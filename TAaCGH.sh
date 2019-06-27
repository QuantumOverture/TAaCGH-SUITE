#!/bin/bash

if [ $# -eq 0 ]
then
	echo "No Command Entered! [VALID COMMANDS ARE : Setup , Clean, and Run]"
elif [ $1 == 'Run' ]
then
	echo "SCRIPT RUNNING PROCESS STARTED"
	echo "NOTE: the 10th and 11th scripts require manual input. To exit now(so you can edit them) --> Ctrl + z."
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
	echo "Running 1_impute_aCGH.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '4 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				set=$element
			fi
			((counter++))
		done	
		echo $set
	else
		echo Enter The Value for \" Set \"
		read set
		echo $set
	fi
	echo "Finished Running 1_impute_aCGH.R"
	echo "====================================="
	echo " "

	#2_cgh_dictionary_cytoband.R
	echo "Running 2_cgh_dictionary_cytoband.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '5 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				dataSet=$element
			elif [ $counter -eq 2 ]
			then
				numParts=$element
			elif [ $counter -eq 3 ]
			then
				action=$element
			elif [ $counter -eq 4 ]
			then
				segLength=$element
			elif [ $counter -eq 5 ]
			then
				subdir=$element
			fi
			((counter++))
		done	
		echo $dataSet $numParts $action $segLength $subdir 
	else
		echo Enter The Value for \" DataSet \"
		read dataSet
		echo Enter The Value for \" numParts \"
		read numParts
		echo Enter The Value for \" action \"
		read action
		echo Enter The Value for \" seglength \"
		read segLength
		echo Enter The Value for \" subdir \"
		read subdir
		echo $dataSet $numParts $action $segLength $subdir
	fi
	echo "Finished 2_cgh_dictionary_cytoband.R"
	echo "====================================="
	echo " "

	#3_Transposed_aCGH.R
	echo "Running 3_Transposed_aCGH.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '6 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				set=$element
			fi
			((counter++))
		done	
		echo $set
	else
		echo Enter The Value for \" Set \"
		read set
		echo $set
	fi
	echo "Finished Running 3_Transposed_aCGH.R"
	echo "====================================="
	echo " "

	#3b_dist_Q05.R
	echo "Running 3b_dist_Q05.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '7 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				dataSet=$element
			elif [ $counter -eq 2 ]
			then
				arms=$element
			fi
			((counter++))
		done	
		echo $dataSet $arms
	else
		echo Enter The Value for \" DataSet \"
		read dataSet
		echo $dataSet
		echo Enter The Value for \" Arms \"
		read arms
		echo $arms
		
	fi
	echo "Finished Running 3b_dist_Q05.R"
	echo "====================================="
	echo " "

	#4_hom_stats_parts.py
	echo "Running 4_hom_stats_parts.py"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '8 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				set=$element
			elif [ $counter -eq 2 ]
			then
				num1=$element
			elif [ $counter -eq 3 ]
			then
				num2=$element
			elif [ $counter -eq 4 ]
			then
				num3=$element
			elif [ $counter -eq 5 ]
			then
				action=$element
			fi
			((counter++))
		done	
		echo $set $num1 $num2 $num3 $action 
	else
		echo Enter The Value for \" set \"
		read set
		echo Enter The Value for \" num1 \"
		read num1
		echo Enter The Value for \" num2 \"
		read num2
		echo Enter The Value for \" num3 \"
		read num3
		echo Enter The Value for \" action \"
		read action
		echo $set $num1 $num2 $num3 $action
	fi
	echo "Finished 4_hom_stats_parts.py"
	echo "====================================="
	echo " "

	#5_sig_pcalc_parts.R
	echo "Running 5_sig_pcalc_parts.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '9 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				param=$element
			elif [ $counter -eq 2 ]
			then
				phenotype=$element
			elif [ $counter -eq 3 ]
			then
				dataSet=$element
			elif [ $counter -eq 4 ]
			then
				partNum=$element
			elif [ $counter -eq 5 ]
			then
				action=$element
			elif [ $counter -eq 6 ]
			then
				outliers=$element
			elif [ $counter -eq 7 ]
			then
				subdir=$element
			fi
			((counter++))
		done	
		echo $param $phenotype $dataSet $partNum $action $outliers $subdir
	else
		echo Enter The Value for \" param \"
		read param
		echo Enter The Value for \" phenotype \"
		read phenotype
		echo Enter The Value for \" dataSet \"
		read dataSet
		echo Enter The Value for \" partNum \"
		read partNum
		echo Enter The Value for \" action \"
		read action
		echo Enter The Value for \" outliers \"
		read outliers
		echo Enter The Value for \" subdir \"
		read subdir
		echo $param $phenotype $dataSet $partNum $action $outliers $subdir
	fi
	echo "Finished 5_sig_pcalc_parts.R"
	echo "====================================="
	echo " "

	#6_FDR.R
	echo "Running 6_FDR.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '10 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				file=$element
			elif [ $counter -eq 2 ]
			then
				Parameter=$element
			elif [ $counter -eq 3 ]
			then
				phenotype=$element
			elif [ $counter -eq 4 ]
			then
				Parts=$element
			elif [ $counter -eq 5 ]
			then
				perm=$element
			elif [ $counter -eq 6 ]
			then
				sig=$element
			elif [ $counter -eq 7 ]
			then
				subdir=$element
			fi
			((counter++))
		done	
		echo $file $parameters $phenotype $Parts $perm $sig $subdir
	else
		echo Enter The Value for \" file \"
		read file
		echo Enter The Value for \" Parameter \"
		read Parameter
		echo Enter The Value for \" phenotype \"
		read phenotype
		echo Enter The Value for \" Parts \"
		read Parts
		echo Enter The Value for \" perm \"
		read perm
		echo Enter The Value for \" sig \"
		read sig
		echo Enter The Value for \" subdir \"
		read subdir
		echo $file $parameters $phenotype $Parts $perm $sig $subdir
	fi
	echo "Finished 6_FDR.R"
	echo "====================================="
	echo " "

	#7_vis_curves.R
	echo "Running 7_vis_curves.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '11 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				param=$element
			elif [ $counter -eq 2 ]
			then
				phenotype=$element
			elif [ $counter -eq 3 ]
			then
				dataSet=$element
			elif [ $counter -eq 4 ]
			then
				action=$element
			elif [ $counter -eq 5 ]
			then
				subdir=$element
			fi
			((counter++))
		done	
		echo $param $phenotype $dataSet $action $subdir
	else
		echo Enter The Value for \" param \"
		read param
		echo Enter The Value for \" phenotype \"
		read phenotype
		echo Enter The Value for \" dataSet \"
		read dataSet
		echo Enter The Value for \" action \"
		read action
		echo Enter The Value for \" subdir \"
		read subdir
		echo $param $phenotype $dataSet $action $subdir
	fi
	echo "Finished 7_vis_curves.R"
	echo "====================================="
	echo " "

	#8_probesFDR.R
	echo "Running 8_probesFDR.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '12 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				Parameter=$element
			elif [ $counter -eq 2 ]
			then
				phenotype=$element
			elif [ $counter -eq 3 ]
			then
				dataSet=$element
			elif [ $counter -eq 4 ]
			then
				subdir=$element
			elif [ $counter -eq 5 ]
			then
				perm=$element
			elif [ $counter -eq 6 ]
			then
				sig=$element
			elif [ $counter -eq 7 ]
			then
				seed=$element
			fi
			((counter++))
		done	
		echo $Parameter $phenotype $dataSet $subdir $perm $sig $seed
	else
		echo Enter The Value for \" file \"
		read file
		echo Enter The Value for \" Parameter \"
		read Parameter
		echo Enter The Value for \" phenotype \"
		read phenotype
		echo Enter The Value for \" Parts \"
		read Parts
		echo Enter The Value for \" perm \"
		read perm
		echo Enter The Value for \" sig \"
		read sig
		echo Enter The Value for \" subdir \"
		read subdir
		echo $Parameter $phenotype $dataSet $subdir $perm $sig $seed
	fi
	echo "Finished 8_probesFDR.R"
	echo "====================================="
	echo " "

	#9_mean_diff_perm_NoOut.R
	echo "Running 9_mean_diff_perm_NoOut.R"
	if [ $ParameterFileUse == 'Y' ]
	then    
		counter=0
		line=$(sed -n '13 p' parameter.txt)
		for element in $line
		do
	        	if [ $counter -eq 1 ]
			then
				dataSet=$element
			elif [ $counter -eq 2 ]
			then
				segLength=$element
			elif [ $counter -eq 3 ]
			then
				phenotype=$element
			elif [ $counter -eq 4 ]
			then
				permutations=$element
			elif [ $counter -eq 5 ]
			then
				sig=$element
			elif [ $counter -eq 6 ]
			then
				seed=$element
			fi
			((counter++))
		done	
		echo $dataSet $segLength $phenotype $permutations $sig $seed
	else
		echo Enter The Value for \" dataSet \"
		read dataSet
		echo Enter The Value for \" segLength \"
		read segLength
		echo Enter The Value for \" phenotype \"
		read phenotype
		echo Enter The Value for \" permutations \"
		read permutations
		echo Enter The Value for \" sig \"
		read sig
		echo Enter The Value for \" seed \"
		read seed
		echo $dataSet $segLength $phenotype $permutations $sig $seed
	fi
	echo "Finished 9_mean_diff_perm_NoOut.R"
	echo "====================================="
	echo " "

	#10_class_pat_CM.R
	echo "Running 10_class_pat_CM.R"
	echo MANUAL
	echo "Finished 10_class_pat_CM.R"
	echo "====================================="
	echo " "

	#11_class_pat_seg.R
	echo "Running 11_class_pat_seg.R"
	echo MANUAL
	echo "Finished 11_class_pat_seg.R"
	echo "====================================="
	echo " "

	
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
