# persistent_air_pollution
Persistent air pollution events

Given a daily timeseries of PM10 or O3 concentrations in a group of air quality monitoring stations Sao Paulo, this script identifies persistent exceedance events (PEE), i.e., air pollution events that persist for many days and occur simultaneously in many monitoring stations. According to World Health Organization (WHO, 2021) guidelines, a PM10 exceedance event occurs when its 24h moving average exceeds 45 ug/m3; a O3 exceedance event occurs when its 8h moving average exceeds 100 ug/m3. The output includes a list of events (start, end, duration) and the classification of each day as event or non-event day. The occurrence of PEE can be predicted based on local meteorological conditions (Rizzo and Miranda, 2024), using a classification modelling approach.

Definition of PM10 persistent exceedance events (criteria to classify a particular day as part of a PEE event):
* Condition 1: exceedance must occur in at least 50% of the monitoring stations
* Condition 2: given that the 1st condition was satisfied, there must be at least 5 consecutive days of exceedance

Definition of O3 persistent exceedance events (criteria to classify a particular day as part of a PEE event):
* Condition 1: exceedance must occur in at least 50% of the monitoring stations
* Condition 2: given that the 1st condition was satisfied, there must be at least 3 consecutive days of exceedance

Data provided by CETESB (Sao Paulo State Environmental Agency), IAG meteorological station (WMO station #83004) and ERA5 reanalysis.

-----------------------
File description:

O3_max_day_mavg.csv: daily time series of O3 maximum concentration from 8h moving averages in selected air quality stations, in ug/m3. Input to the script find_PEE.R 

PM10_max_day_mavg.csv: daily time series of PM10 maximum concentration from 24h moving averages in selected air quality stations, in ug/m3. Input to the script find_PEE.R 

pee_o3_classification.csv: classification of days into event and non-event days for O3. Output of the script find_PEE.R.

pee_pm10_classification.csv: classification of days into event and non-event days for PM10. Output of the script find_PEE.R.

pee_o3_list.csv: list of O3 PEE. Output of the script find_PEE.R.

pee_pm10_list.csv: list of O3 PEE. Output of the script find_PEE.R.

meteo_IAG_PBL_2005-2022.csv: daily time series of meteorological variables.

-----------------------
Related publications:

1. Rizzo, L. V. & Miranda, A. G. B. Short term forecasting of persistent air quality deterioration events in the metropolis of Sao Paulo. Urban Clim. 55, (2024), https://doi.org/10.1016/j.uclim.2024.101876.
  
2.  Oliveira, M. C. Q. D., Drumond, A. & Rizzo, L. V. Air pollution persistent exceedance events in the Brazilian metropolis of Sao Paulo and associated surface weather patterns. Int. J. Environ. Sci. Technol. 19, 9495–9506 (2022), https://doi.org/10.1007/s13762-021-03778-1
