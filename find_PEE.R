# find_PEE.r

# Given a daily timeseries of PM10 or O3 concentrations in a group of
# air quality monitoring stations Sao Paulo, this script identifies 
# persistent exceedance events (PEE), i.e., air pollution events that
# persist for many days and occur simultaneously in many monitoring
# stations. The World Health Organization (WHO, 2021) guidelines for air quality 
# was considered. According to WHO guidelines, a PM10 exceedance event occurs 
# when its 24h moving average exceeds 45 ug/m3; a O3 exceedance event occurs
# when its 8h moving average exceeds 100 ug/m3.

# Definition of PM10 persistent exceedance events:
# (criteria to classify a particular day as part of a PEE event)
# Condition 1: exceedance must occur in at least 50% of the monitoring stations
# Condition 2: given that the 1st condition was satisfied, there must be
#       at least 5 consecutive days of exceedance

# Definition of O3 persistent exceedance events:
# (criteria to classify a particular day as part of a PEE event)
# Condition 1: exceedance must occur in at least 50% of the monitoring stations
# Condition 2: given that the 1st condition was satisfied, there must be
#       at least 3 consecutive days of exceedance

# Data provided by CETESB (Sao Paulo State Environmental Agency)

# Written by Luciana Rizzo (lrizzo@usp.br)

# Inputs: 
# PM10: Timeseries of the daily maximum of 24h moving averages of PM10 concentrations
# O3: Timeseries of the daily maximum of 8h moving averages of O3 concentrations

# Outputs:
# exceed: binary matrix of exceedance/non-exceedance for each day and station
# pee_clf: classification of days as PEE/non-PEE
# pee_list: start, end, duration of each PEE event

# Load packages
library(lubridate)

# User options:
pollutant <- 'pm10'  # Choose air pollutant: pm10 or o3
filename <- 'PM10_max_day_mavg.csv'

# Parameters:
if (pollutant=='pm10'){
  who <- 45 # ug/m3 (WHO standard for PM10)
  minst <- 0.5 # mininum fraction of monitoring stations to satisfy the Condition 1
  mindays <-5 # minimum number of consecutive days to satisfy the Condition 2
} else if (pollutant=='o3'){
  who <- 100 # ug/m3 (WHO standard for O3)
  minst <- 0.5 # mininum fraction of monitoring stations to satisfy the Condition 1
  mindays <-3 # minimum number of consecutive days to satisfy the Condition 2
}

# Read input file:
dados <- read.csv(file=filename,header=T, sep=",", na.strings = "NA")
dados <- cbind(ymd(paste0(dados$y,"-",dados$m,"-",dados$d)), dados)
colnames(dados)[1] <- "date"

##########################################################
# Binary matrix of exceedance days
exceed <- dados
exceed[,5:ncol(dados)] <- 0
exceed[,5:ncol(dados)] <- as.numeric(dados[,5:ncol(dados)]>who)
write.csv(exceed, file = paste0(pollutant,"_exceedance.csv"), row.names = FALSE)

##########################################################
# Apply conditions to identify Persistent Exceedance Events
idpee <- data.frame(exceed$date,0,0,0,0,0)
colnames(idpee) <- c("date","num.exc","num.st","cond1","mov.sum","pee")

# Number of stations with exceeding concentrations:
idpee$num.exc <- rowSums(exceed[5:ncol(dados)], na.rm=TRUE)

# Number of stations with valid data:
idpee$num.st <- rowSums(!is.na(exceed[5:ncol(dados)]))

# Label the days that satisfy the Condition 1
idpee$cond1[idpee$num.exc/idpee$num.st>minst] <- 1

# Moving sum of mindays
for (i in 1:(nrow(idpee)-mindays+1)){
  idpee$mov.sum[i] <- sum(idpee$cond1[i:(i+mindays-1)])
}
# Loop in the moving sum to identify start and end of PEE events (Condition 2)
lin <- 1
while (lin<nrow(idpee)){
  if (idpee$mov.sum[lin]==mindays){   # PEE start day
    while (idpee$cond1[lin]==1){    # search for PEE final day
      idpee$pee[lin] <-1
      lin<-lin+1
    }
  } else {lin<-lin+1}
}

pee_clf <- data.frame(exceed[,1:4],idpee$pee)
colnames(pee_clf)[5] <- paste0("pee_",pollutant)
write.csv(pee_clf, file = paste0(pollutant,"_pee_classific.csv"), row.names = FALSE)

##########################################################
# List the PEE events (start, end and duration)

# start: diff(pee)=1; end: diff(pee)=-1
diffpee <- data.frame(diff(idpee$pee))
# How many PEE?
npee <- length(which(diffpee==1))

pee_list <- data.frame(matrix(NA,npee,3))
colnames(pee_list)=c("start","end","duration")
lin=which(diffpee==1)+1 # line index of PEE start days
pee_list$start <- pee_clf$date[lin]
lin=which(diffpee==-1) # line index of PEE end days
pee_list$end <- pee_clf$date[lin]
pee_list$duration <- as.numeric(pee_list$end - pee_list$start) + 1 
write.csv(pee_list, file = paste0(pollutant,"_pee_list.csv"), row.names = FALSE)
