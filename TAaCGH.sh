#!/bin/bash

if [ $# -eq 0 ]
then
	echo "No Command Entered! [VALID COMMANDS ARE : Setup , Clean, and Run]"

elif [ $1 == 'Setup' ]
then
	# Create Core Directories
	mkdir Research
	mkdir Research/Data
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
elif [ $1 == 'Clear' ]
then
	# ADD Deletion property of exposed files
	rm -R -f Research
else
	echo "$1 is an INVALID COMMAND! [VALID COMMANDS ARE : Setup , Clean, and Run]"
fi
