search_dir=crab/
for entry in "$search_dir"/*
do
	crab status -d $entry
	#crab resubmit -d $entry
done

