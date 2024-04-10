# persistent_air_pollution
Persistent air pollution events

Given a daily timeseries of PM10 or O3 concentrations in a group of air quality monitoring stations Sao Paulo, this script identifies persistent exceedance events (PEE), i.e., air pollution events that persist for many days and occur simultaneously in many monitoring stations. The World Health Organization (WHO, 2021) guidelines for air quality was considered. According to WHO guidelines, a PM10 exceedance event occurs when its 24h moving average exceeds 45 ug/m3; a O3 exceedance event occurs when its 8h moving average exceeds 100 ug/m3.

Definition of PM10 persistent exceedance events (criteria to classify a particular day as part of a PEE event):
* Condition 1: exceedance must occur in at least 50% of the monitoring stations
* Condition 2: given that the 1st condition was satisfied, there must be at least 5 consecutive days of exceedance

Definition of O3 persistent exceedance events (criteria to classify a particular day as part of a PEE event):
* Condition 1: exceedance must occur in at least 50% of the monitoring stations
* Condition 2: given that the 1st condition was satisfied, there must be at least 3 consecutive days of exceedance

Data provided by CETESB (Sao Paulo State Environmental Agency)

Related publications:
1. Rizzo, L. V. & Miranda, A. G. B. Short term forecasting of persistent air quality deterioration events in the metropolis of Sao Paulo. Urban Clim. 55, (2024), https://doi.org/10.1016/j.uclim.2024.101876.
2. Oliveira, M. C. Q. D., Drumond, A. & Rizzo, L. V. Air pollution persistent exceedance events in the Brazilian metropolis of Sao Paulo and associated surface weather patterns. Int. J. Environ. Sci. Technol. 19, 9495–9506 (2022), https://doi.org/10.1007/s13762-021-03778-1
