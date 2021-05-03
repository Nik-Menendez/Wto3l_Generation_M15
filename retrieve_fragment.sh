export SCRAM_ARCH=slc7_amd64_gcc700

source /cvmfs/cms.cern.ch/cmsset_default.sh
if [ -r CMSSW_10_6_19_patch2/src ] ; then
  echo release CMSSW_10_6_19_patch2 already exists
else
  scram p CMSSW CMSSW_10_6_19_patch2
fi
cd CMSSW_10_6_19_patch2/src
eval `scram runtime -sh`

# Download fragment from McM
curl -s -k https://cms-pdmv.cern.ch/mcm/public/restapi/requests/get_fragment/SMP-RunIISummer20UL17wmLHEGEN-00053 --retry 3 --create-dirs -o Configuration/GenProduction/python/fragment-Wto3l-RunIISummer20UL17wmLHEGEN.py

cd -
Mass=$1
if $2 == "1":
	file="Fragments/WpTo3l_M${Mass}_fragment.py"
else:
	file="Fragments/WmTo3l_M${Mass}_fragment.py"
cp $file CMSSW_10_6_19_patch2/src/Configuration/GenProduction/python/fragment-Wto3l-RunIISummer20UL17wmLHEGEN.py
