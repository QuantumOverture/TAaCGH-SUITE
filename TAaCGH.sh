#!/bin/bash

if [ $# -eq 0 ]
then
	echo "No Command Entered! [VALID COMMANDS ARE : Setup , Clean, and Run]"
elif [ $1 == 'Run' ]
then
	echo "SCRIPT RUNNING PROCESS STARTED"
	# Add running prompts and advisory note in parameter file
	# Don't forget that some scripts run more than once (i.e add more parameters)
	#R --slave --args Research/Data/set < Research/TAaCGH/1_impute_aCGH.R
	echo "Will you be using the provided parameter file for automatically inputting parameters for the scripts?[Y/N]"
	read ParameterFileUse

	if [ $ParameterFileUse == 'Y' ]
	then
		echo "Parameter File Use Selected" 
	else
		echo "Manual Parameter Input Selected"
	fi	

	#1_Impute
	if [ $ParameterFileUse == 'Y' ]
	then      
		line=$(sed -n '1 p' parameter.txt)
		for element in $line
		do
	        ./outputter.sh $element
		done	

	else
		echo "Manual Parameter Input Selected"
	fi



	echo "SCRIPTS RUNING PROCESS ENDED"

elif [ $1 == 'Setup' ]
then
	echo "SET UP STARTED"
	# Create Core Directories
	mkdir Research
	mkdir Research/Data
	mkdir Research/Data/set
	mkdir Research/TAaCGH
	mkdir Research/Results

	# Add Read and Execute Permissions to Core Scripts (needed for cp command and running of scripts)
	chmod +rx TAaCGH-master_June_24_2019/1_impute_aCGH.R
	chmod +rx TAaCGH-master_June_24_2019/2_cgh_dictionary_cytoband.R
	chmod +rx TAaCGH-master_June_24_2019/3_Transposed_aCGH.R
	chmod +rx TAaCGH-master_June_24_2019/3b_dist_Q05.R
	chmod +rx TAaCGH-master_June_24_2019/4_hom_stats_parts.py
	chmod +rx TAaCGH-master_June_24_2019/5_sig_pcalc_parts.R
	chmod +rx TAaCGH-master_June_24_2019/6_FDR.R
	chmod +rx TAaCGH-master_June_24_2019/7_vis_curves.R
	chmod +rx TAaCGH-master_June_24_2019/8_probesFDR.R
	chmod +rx TAaCGH-master_June_24_2019/9_mean_diff_perm_NoOut.R
	chmod +rx TAaCGH-master_June_24_2019/10_class_pat_CM.R
        chmod +rx TAaCGH-master_June_24_2019/11_class_pat_seg.R
	chmod +rx TAaCGH-master_June_24_2019/functions_cgh.py
	chmod +rx TAaCGH-master_June_24_2019/functions_data_processing.R
	chmod +rx TAaCGH-master_June_24_2019/functions_io.py
	chmod +rx TAaCGH-master_June_24_2019/functions_sig.R
	chmod +rx TAaCGH-master_June_24_2019/plex.jar
	#chmod +rx TAaCGH-master_June_24_2019/Readme.pdf
	chmod +rx TAaCGH-master_June_24_2019/ind_prof_origpat_local_sect.R
	chmod +rx TAaCGH-master_June_24_2019/ind_prof_origpat_local.R
	chmod +rx TAaCGH-master_June_24_2019/vis_avg_betti_curves.R

	# Copy files from downloaded directory to required directory
	cp TAaCGH-master_June_24_2019/1_impute_aCGH.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/2_cgh_dictionary_cytoband.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/3_Transposed_aCGH.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/3b_dist_Q05.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/4_hom_stats_parts.py Research/TAaCGH
	cp TAaCGH-master_June_24_2019/5_sig_pcalc_parts.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/6_FDR.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/7_vis_curves.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/8_probesFDR.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/9_mean_diff_perm_NoOut.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/10_class_pat_CM.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/11_class_pat_seg.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/functions_cgh.py Research/TAaCGH
	cp TAaCGH-master_June_24_2019/functions_data_processing.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/functions_io.py Research/TAaCGH
	cp TAaCGH-master_June_24_2019/functions_sig.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/plex.jar Research/TAaCGH
	#cp TAaCGH-master_June_24_2019/Readme.pdf Research/TAaCGH
	cp TAaCGH-master_June_24_2019/ind_prof_origpat_local_sect.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/ind_prof_origpat_local.R Research/TAaCGH
	cp TAaCGH-master_June_24_2019/vis_avg_betti_curves.R Research/TAaCGH
	#cp TAaCGH-master_June_24_2019/ Research/TAaCGH
	echo "SET UP SUCCESSFUL"
elif [ $1 == 'Clear' ]
then
	echo "DELETION STARTED"
	# ADD Deletion property of exposed files
	rm -R -f Research
	echo "DELETION SUCCESSFUL"
else
	echo "$1 is an INVALID COMMAND! [VALID COMMANDS ARE : Setup , Clean, and Run]"
fi
