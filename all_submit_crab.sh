rm -rf crab/

Masses=("4" "5" "10" "15" "30" "60")

for Mass in "${Masses[@]}"
do
	request="WpTo3l_M$Mass"
	output="WpTo3l_M$Mass"
	gridpack="Gridpacks/WpTo3l_M${Mass}_tarball.tar.xz"
	inputs="['produce_Wto3l_Zp_M15.sh','retrieve_fragment.sh','Fragments/','${gridpack}','FrameworkJobReport.xml']"
	args="['Mass=$Mass','isP=1']"
	echo "crab submit submit_crab_Wp.py General.requestName=$request Data.outputDatasetTag=$output JobType.inputFiles=$inputs JobType.scriptArgs=$args"
	crab submit submit_crab_Wp.py General.requestName=$request Data.outputDatasetTag=$output JobType.inputFiles=$inputs JobType.scriptArgs=$args
	request="WmTo3l_M$Mass"
        output="WmTo3l_M$Mass"
        gridpack="Gridpacks/WmTo3l_M${Mass}_tarball.tar.xz"
	inputs="['produce_Wto3l_Zp_M15.sh','retrieve_fragment.sh','Fragments/','${gridpack}','FrameworkJobReport.xml']"
	args="['Mass=$Mass','isP=0']"
	echo "crab submit submit_crab_Wm.py General.requestName=$request Data.outputDatasetTag=$output JobType.inputFiles=$inputs JobType.scriptArgs=$args"
        crab submit submit_crab_Wm.py General.requestName=$request Data.outputDatasetTag=$output JobType.inputFiles=$inputs JobType.scriptArgs=$args
done
