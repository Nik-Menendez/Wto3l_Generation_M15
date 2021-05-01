# Wto3l_Generation_M15

## Setup
```bash
git clone git@github.com:Nik-Menendez/Wto3l_Generation_M15.git
cd Wto3l_Generation_M15/
cmsrel CMSSW_10_6_19_patch2
cd CMSSW_10_6_19_patch2/src
cmsenv
cd -
```

## Number of Events
Change the number of events to be generated in both produce_Wto3l_Zp_M15.sh and fragment-Wto3l-RunIISummer20UL17wmLHEGEN.py.

## Run Locally
```bash
source produce_Wto3l_Zp_M15.sh
```

## Run Over Crab
```bash
crab submit submit_crab.sh
```
