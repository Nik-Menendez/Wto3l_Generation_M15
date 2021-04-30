from WMCore.Configuration import Configuration
from CRABClient.UserUtilities import config

config = config()

config.General.requestName = 'WmTo3l_M15'
config.General.workArea = 'crab'
config.General.transferOutputs = True

config.JobType.pluginName = 'PrivateMC'
config.JobType.psetName = 'placeholder_PSet.py'
config.JobType.scriptExe = 'produce_Wto3l_Zp_M15.sh'
config.JobType.disableAutomaticOutputCollection = True
config.JobType.outputFiles = ['Wto3l-RunIISummer20UL17NanoAODv2.root']
config.JobType.inputFiles = ['produce_Wto3l_Zp_M15.sh','retrieve_fragment.sh','fragment-Wto3l-RunIISummer20UL17wmLHEGEN.py','Zp_to_3mu_M15_slc7_amd64_gcc700_CMSSW_10_6_19_tarball.tar.xz','FrameworkJobReport.xml']
config.JobType.maxMemoryMB = 5000

config.Data.splitting = 'EventBased'
config.Data.unitsPerJob = 1
config.Data.totalUnits = 100
config.Data.outLFNDirBase = '/store/user/nimenend/SignalGeneration/'
config.Data.publication = False
config.Data.ignoreLocality = True
config.Data.outputDatasetTag = 'WmTo3l_M15'

config.section_('User')
config.section_("Site")
config.Site.storageSite = "T2_US_Florida"
config.Site.whitelist = ['T2_US_*']
