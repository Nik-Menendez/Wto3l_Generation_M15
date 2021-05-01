EVENTS=500
SEED=$RANDOM

source retrieve_fragment.sh

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_19_patch2/src ] ; then
  echo release CMSSW_10_6_19_patch2 already exists
else
  scram p CMSSW CMSSW_10_6_19_patch2
fi
cd CMSSW_10_6_19_patch2/src
eval `scram runtime -sh`

scram b
cd ../..

# ------------------- GENERATE LHE-GEN

echo "--------------------- LHE-GEN ----------------------"

# cmsDriver command
cmsDriver.py Configuration/GenProduction/python/fragment-Wto3l-RunIISummer20UL17wmLHEGEN.py --python_filename Wto3l-RunIISummer20UL17wmLHEGEN_cfg.py --eventcontent RAWSIM,LHE --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN,LHE --fileout file:Wto3l-RunIISummer20UL17wmLHEGEN.root --conditions 106X_mc2017_realistic_v6 --beamspot Realistic25ns13TeVEarly2017Collision --customise_commands process.source.numberEventsInLuminosityBlock="cms.untracked.uint32(100)" --customise_commands process.RandomNumberGeneratorService.generator.initialSeed="cms.untracked.uint32($SEED)" --step LHE,GEN --geometry DB:Extended --era Run2_2017 --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17wmLHEGEN_report.xml Wto3l-RunIISummer20UL17wmLHEGEN_cfg.py

rm Wto3l-RunIISummer20UL17wmLHEGEN_report.xml Wto3l-RunIISummer20UL17wmLHEGEN_cfg.py
rm -rf CMSSW*
# ------------------- GENERATE SIM

echo "--------------------- SIM ----------------------"

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_17_patch1/src ] ; then
  echo release CMSSW_10_6_17_patch1 already exists
else
  scram p CMSSW CMSSW_10_6_17_patch1
fi
cd CMSSW_10_6_17_patch1/src
eval `scram runtime -sh`

scram b
cd ../..

# cmsDriver command
cmsDriver.py  --python_filename Wto3l-RunIISummer20UL17SIM_cfg.py --eventcontent RAWSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM --fileout file:Wto3l-RunIISummer20UL17SIM.root --conditions 106X_mc2017_realistic_v6 --beamspot Realistic25ns13TeVEarly2017Collision --step SIM --geometry DB:Extended --filein file:Wto3l-RunIISummer20UL17wmLHEGEN.root --era Run2_2017 --runUnscheduled --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17SIM_report.xml Wto3l-RunIISummer20UL17SIM_cfg.py

rm Wto3l-RunIISummer20UL17SIM_report.xml Wto3l-RunIISummer20UL17SIM_cfg.py Wto3l-RunIISummer20UL17wmLHEGEN.root Wto3l-RunIISummer20UL17wmLHEGEN_inLHE.root
rm -rf CMSSW*
# ------------------- RUN DIGI-Premix

echo "--------------------- DIGI-Premix ----------------------"

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_17_patch1/src ] ; then
  echo release CMSSW_10_6_17_patch1 already exists
else
  scram p CMSSW CMSSW_10_6_17_patch1
fi
cd CMSSW_10_6_17_patch1/src
eval `scram runtime -sh`

scram b
cd ../..

# cmsDriver command
cmsDriver.py  --python_filename Wto3l-RunIISummer20UL17DIGIPremix_cfg.py --eventcontent PREMIXRAW --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-DIGI --fileout file:Wto3l-RunIISummer20UL17DIGIPremix.root --pileup_input "dbs:/Neutrino_E-10_gun/RunIISummer20ULPrePremix-UL17_106X_mc2017_realistic_v6-v3/PREMIX" --conditions 106X_mc2017_realistic_v6 --step DIGI,DATAMIX,L1,DIGI2RAW --procModifiers premix_stage2 --geometry DB:Extended --filein file:Wto3l-RunIISummer20UL17SIM.root --datamix PreMix --era Run2_2017 --runUnscheduled --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17DIGIPremix_report.xml Wto3l-RunIISummer20UL17DIGIPremix_cfg.py

rm Wto3l-RunIISummer20UL17DIGIPremix_report.xml Wto3l-RunIISummer20UL17DIGIPremix_cfg.py Wto3l-RunIISummer20UL17SIM.root
rm -rf CMSSW*
# ------------------- Run HLT

echo "--------------------- HLT ----------------------"

export SCRAM_ARCH=slc7_amd64_gcc630

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_9_4_14_UL_patch1/src ] ; then
  echo release CMSSW_9_4_14_UL_patch1 already exists
else
  scram p CMSSW CMSSW_9_4_14_UL_patch1
fi
cd CMSSW_9_4_14_UL_patch1/src
eval `scram runtime -sh`

scram b
cd ../..

# cmsDriver command
cmsDriver.py  --python_filename Wto3l-RunIISummer20UL17HLT_cfg.py --eventcontent RAWSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier GEN-SIM-RAW --fileout file:Wto3l-RunIISummer20UL17HLT.root --conditions 94X_mc2017_realistic_v15 --customise_commands 'process.source.bypassVersionCheck = cms.untracked.bool(True)' --step HLT:2e34v40 --geometry DB:Extended --filein file:Wto3l-RunIISummer20UL17DIGIPremix.root --era Run2_2017 --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17HLT_report.xml Wto3l-RunIISummer20UL17HLT_cfg.py

rm Wto3l-RunIISummer20UL17HLT_report.xml Wto3l-RunIISummer20UL17HLT_cfg.py Wto3l-RunIISummer20UL17DIGIPremix.root
rm -rf CMSSW*
# ------------------- Run RECO

echo "--------------------- RECO ----------------------"

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_17_patch1/src ] ; then
  echo release CMSSW_10_6_17_patch1 already exists
else
  scram p CMSSW CMSSW_10_6_17_patch1
fi
cd CMSSW_10_6_17_patch1/src
eval `scram runtime -sh`

scram b
cd ../..

# cmsDriver command
cmsDriver.py  --python_filename Wto3l-RunIISummer20UL17RECO_cfg.py --eventcontent AODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier AODSIM --fileout file:Wto3l-RunIISummer20UL17RECO.root --conditions 106X_mc2017_realistic_v6 --step RAW2DIGI,L1Reco,RECO,RECOSIM --geometry DB:Extended --filein file:Wto3l-RunIISummer20UL17HLT.root --era Run2_2017 --runUnscheduled --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17RECO_report.xml Wto3l-RunIISummer20UL17RECO_cfg.py

rm Wto3l-RunIISummer20UL17RECO_report.xml Wto3l-RunIISummer20UL17RECO_cfg.py Wto3l-RunIISummer20UL17HLT.root
rm -rf CMSSW*
# ------------------- Run MiniAOD

echo "--------------------- MiniAOD ----------------------"

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_20/src ] ; then
  echo release CMSSW_10_6_20 already exists
else
  scram p CMSSW CMSSW_10_6_20
fi
cd CMSSW_10_6_20/src
eval `scram runtime -sh`

scram b
cd ../..

# cmsDriver command
cmsDriver.py  --python_filename Wto3l-RunIISummer20UL17MiniAODv2_cfg.py --eventcontent MINIAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier MINIAODSIM --fileout file:Wto3l-RunIISummer20UL17MiniAODv2.root --conditions 106X_mc2017_realistic_v9 --step PAT --procModifiers run2_miniAOD_UL --geometry DB:Extended --filein file:Wto3l-RunIISummer20UL17RECO.root --era Run2_2017 --runUnscheduled --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17MiniAODv2_report.xml Wto3l-RunIISummer20UL17MiniAODv2_cfg.py

rm Wto3l-RunIISummer20UL17MiniAODv2_report.xml Wto3l-RunIISummer20UL17MiniAODv2_cfg.py Wto3l-RunIISummer20UL17RECO.root
rm -rf CMSSW*
# ------------------- Run NanoAOD

echo "--------------------- NanoAOD ----------------------"

export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_19_patch2/src ] ; then
  echo release CMSSW_10_6_19_patch2 already exists
else
  scram p CMSSW CMSSW_10_6_19_patch2
fi
cd CMSSW_10_6_19_patch2/src
eval `scram runtime -sh`

scram b
cd ../..

# cmsDriver command
cmsDriver.py  --python_filename Wto3l-RunIISummer20UL17NanoAODv2_cfg.py --eventcontent NANOAODSIM --customise Configuration/DataProcessing/Utils.addMonitoring --datatier NANOAODSIM --fileout file:Wto3l-RunIISummer20UL17NanoAODv2.root --conditions 106X_mc2017_realistic_v8 --step NANO --filein file:Wto3l-RunIISummer20UL17MiniAODv2.root --era Run2_2017,run2_nanoAOD_106Xv1 --no_exec --mc -n $EVENTS

# Run generated config
cmsRun -e -j Wto3l-RunIISummer20UL17NanoAODv2_report.xml Wto3l-RunIISummer20UL17NanoAODv2_cfg.py

rm Wto3l-RunIISummer20UL17NanoAODv2_report.xml Wto3l-RunIISummer20UL17NanoAODv2_cfg.py Wto3l-RunIISummer20UL17MiniAODv2.root
rm -rf CMSSW*
