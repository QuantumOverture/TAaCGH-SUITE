#!/bin/bash

MakeNewFile(){

# Clear away previous file
rm Parameter.txt

echo NOTE: PLEASE DO NOT MOVE ANY LINES AROUND OR CHANGE THE ORDER OF THE LINES. ALSO, PLEASE PUT A SPACE BETWEEN EACH PARAMETER AND THE COLONS OF EACH LINE INDICATOR! >> Parameter.txt
echo EXAMPLE: 15_TAaCGH.py: parameter1 parameter2 parameter3 >> Parameter.txt
echo " " >> Parameter.txt

Line_Headers=("1_impute_aCGH.R:" "2_cgh_dictionary_cytoband.R:" "3_Transposed_aCGH.R:"
"3b_dist_Q05.R:" "4_hom_stats_parts.py:" "5_sig_pcalc_parts.R:" "6_FDR.R:" "7_vis_curves.R:"
"8_probesFDR.R:" "9_mean_diff.perm.R:" "10_class_pat_CM.R:" "11_class_pat_seg.R:" "Script_4_run:"
"Script_5_run:");

Info_For_Headers=("Set" "dataSet numParts action segLength subdir" "Set" "dataSet arms" "dataSet homDim partNum epsIncr action" "param phenotype dataSet partNum action outliers subdir" "file Parameter phenotype Parts perm sig subdir"
"param phenotype dataSet action subdir" "Parameter phenotype Name_of_dataSet subdir perm sig seed" "dataSet segLength phenotype permutations sig seed"
"Manual" "Manual" "num" "num");



counter=0
for i in ${Line_Headers[@]}
do
	if [ $i != "10_class_pat_CM.R:" ] && [ $i != "11_class_pat_seg.R:" ]
	then
		echo "Enter parameters for $i"
		echo "In the following format: ${Info_For_Headers[$counter]}"
		read InputForLine[$counter]
		echo $i ${InputForLine[$counter]} >> Parameter.txt
	else
		echo $i MANUAL >> Parameter.txt
	fi
	((counter++))
done


}

ChangeSpecificLine(){

Line_Headers=("1_impute_aCGH.R:" "2_cgh_dictionary_cytoband.R:" "3_Transposed_aCGH.R:"
"3b_dist_Q05.R:" "4_hom_stats_parts.py:" "5_sig_pcalc_parts.R:" "6_FDR.R:" "7_vis_curves.R:"
"8_probesFDR.R:" "9_mean_diff.perm.R:" "10_class_pat_CM.R:" "11_class_pat_seg.R:" "Script_4_run:"
"Script_5_run:");

Info_For_Headers=("Set" "dataSet numParts action segLength subdir" "Set" "dataSet arms" "dataSet homDim partNum epsIncr action" "param phenotype dataSet partNum action
outliers subdir" "file Parameter phenotype Parts perm sig subdir"
"param phenotype dataSet action subdir" "Parameter phenotype Name_of_dataSet subdir perm sig seed" "dataSet segLength phenotype permutations sig seed"
"Manual" "Manual" "num" "num");

if [ ! -f Parameter.txt ]; then
	echo "Parameter.txt not found! Please choose the \"Entire File Rewrite Option\"."
	return 1
fi

echo "Please specify which of the following lines you would like to edit"
counter=4
for i in ${Line_Headers[@]}
do
	if [ $i != "10_class_pat_CM.R:" ] || [ $i != "11_class_pat_seg.R:" ]
	then
		echo $counter - $i
	else
		echo 10_class_pat_CM.R and 11_class_pat_seg.R require manual operation
	fi
	((counter++))
done

read line_num
if [ $line_num -gt 17 ] || [ $line_num -lt 4 ]
then
	echo "Must be between 4 and 17 [Inclusive]"
	return 1
fi

echo Enter the parameter for the selected line in the following format:
echo ${Info_For_Headers[$(($line_num-4))]}
read NewParameters

NewParameters="${Line_Headers[$(($line_num-4))]} $NewParameters"

sed -i "${line_num}s/.*/$NewParameters/" Parameter.txt


}

GetFileInput(){

if [ -f Parameter.txt ]; then
	cat Parameter.txt
fi
echo " "
dne="f"

while [ $dne != 't' ]
do
	echo "Would you like to edit a specfic line or rewrite the entire parameter file?"
	echo "Type \"S\" for Specific Line"
	echo "Type \"W\" for entire file rewrite"

	read choice
	
	if [ $choice == "S" ]
	then
		ChangeSpecificLine
	elif [ $choice == "W" ]
	then
		MakeNewFile
	fi

	echo "Continue file modification?[ \"t\" for no \"f\" for yes]"
	read dne

done

}


GetParameter(){


	line=$(sed -n "$1 p" parameter.txt)

	counter=0
	for element in $line
	do
		if [ $counter -ne 0 ]
		then
			arr[$counter]=$element
		fi
		((counter++))
	done
	
	if [ $2 == "4_hom_stars_parts.py" ]
	then
		script4=($(sed -n "16 p" parameter.txt))
		while [ $((${script4[1]})) -gt 0 ]
		do
			echo "(cd Research/TAaCGH && python 4_hom_stats_parts.py ${arr[@]})"
			(cd Research/TAaCGH && python 4_hom_stats_parts.py ${arr[@]})
			((script4[1]--))
		done
	elif [ $2 == "5_sig_pcalc_parts.R" ] 
	then
		script5=($(sed -n "17 p" parameter.txt))
		while [ $((${script5[1]})) -gt 0 ]
		do
			echo "(cd Research/TAaCGH && R --slave --args ${arr[@]} < $2)"
			(cd Research/TAaCGH && R --slave --args ${arr[@]} < $2)	
			((script5[1]--))
		done

	else
		echo "(cd Research/TAaCGH && R --slave --args ${arr[@]} < $2)"
		(cd Research/TAaCGH && R --slave --args ${arr[@]} < $2)
	fi

}

GetInput(){

 exect=$1
 counter=0
 shift
 
 while [ $# -gt 0 ]
 do	
	echo Enter the value for the Parameter \" $1 \"
	read arr[$counter]
	((counter++))
	shift
 done

if [ $exect == "4_hom_stars_parts.py" ]
then
	echo "(cd Research/TAaCGH && python 4_hom_stats_parts.py ${arr[@]})"
	(cd Research/TAaCGH && python 4_hom_stats_parts.py ${arr[@]})
else
	echo "(cd Research/TAaCGH && R --slave --args ${arr[@]} < $exect)"
	(cd Research/TAaCGH && R --slave --args ${arr[@]} < $exect)
fi


}

if [ $# -eq 0 ]
then
	echo "NO COMMANDS ENTERED! VALID COMMANDS ARE: File,Setup,Run,AND Clear"
elif [ $1 == 'Run' ]
then
	echo "SCRIPT RUNNING PROCESS STARTED"
	echo "NOTE: the 10th and 11th scripts require manual input. To exit now(so you can edit them) --> Ctrl + z."
	# Add Inner Program File Setup  --> Creates and setups Parameter.txt
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
		GetParameter "4" "1_impute_aCGH.R"
	else
		GetInput "1_impute_aCGH.R" "set"
	fi
	echo "Finished Running 1_impute_aCGH.R"
	echo "====================================="
	echo " "

	#2_cgh_dictionary_cytoband.R
	echo "Running 2_cgh_dictionary_cytoband.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "5" "2_cgh_dictionary.R"	
	else
		GetInput "2_cgh_dictionary.R" "dataSet" "numParts" "action" "segLength" "subdir"
	fi
	echo "Finished 2_cgh_dictionary_cytoband.R"
	echo "====================================="
	echo " "

	#3_Transposed_aCGH.R
	echo "Running 3_Transposed_aCGH.R"
	if [ $ParameterFileUse == 'Y' ]
	then
	     GetParameter "6" "3_Transposed_aCGH.R"	
	else
		GetInput "3_Transposed_aCGH.R" "set"
	fi
	echo "Finished Running 3_Transposed_aCGH.R"
	echo "====================================="
	echo " "

	#3b_dist_Q05.R
	echo "Running 3b_dist_Q05.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "7" "3b_dist_Q05.R"	
	else
		GetInput "3b_dist_Q05.R" "dataSet" "arms"
		
	fi
	echo "Finished Running 3b_dist_Q05.R"
	echo "====================================="
	echo " "

	#4_hom_stats_parts.py
	echo "Running 4_hom_stats_parts.py"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "8" "4_hom_stars_parts.py"
	else
		GetInput "4_hom_stars_parts.py" "set" "num1" "num2" "num3" "action"
	fi
	echo "Finished 4_hom_stats_parts.py"
	echo "====================================="
	echo " "

	#5_sig_pcalc_parts.R
	echo "Running 5_sig_pcalc_parts.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "9" "5_sig_pcalc_parts.R"	
	else
		GetInput "5_sig_pcalc_parts.R" "param" "phenotype" "dataSet" "partNum" "action" "outliers" "subdir"
	fi
	echo "Finished 5_sig_pcalc_parts.R"
	echo "====================================="
	echo " "

	#6_FDR.R
	echo "Running 6_FDR.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "10" "6_FDR.R"
	else
		GetInput "6_FDR.R" "file" "parameters" "phenotype" "Parts" "perm" "sig" "subdir"
	fi
	echo "Finished 6_FDR.R"
	echo "====================================="
	echo " "

	#7_vis_curves.R
	echo "Running 7_vis_curves.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "11" "7_vis_curves.R"	
	else
		GetInput "7_vis_curves.R" "param" "phenotype" "dataSet" "action" "subdir"
	fi
	echo "Finished 7_vis_curves.R"
	echo "====================================="
	echo " "

	#8_probesFDR.R
	echo "Running 8_probesFDR.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		 GetParameter "12" "8_probesFDR.R"	
	else
		GetInput "8_probesFDR.R" "Parameter" "phenotype" "dataSet" "subdir" "perm" "sig" "seed"
	fi
	echo "Finished 8_probesFDR.R"
	echo "====================================="
	echo " "

	#9_mean_diff_perm_NoOut.R
	echo "Running 9_mean_diff_perm_NoOut.R"
	if [ $ParameterFileUse == 'Y' ]
	then
		GetParameter "13" "9_mean_diff_perm_NoOut.R"	
	else
		GetInput "9_mean_diff_perm_NoOut.R" "dataSet" "segLength" "phenotype" "permutations" "sig" "seed"
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
	
	touch Parameter.txt
	echo "Would you like to setup your parameter file?[y( is yes)/n( is no)]"
	read choice
	if [ $choice == "y" ]
	then
		MakeNewFile
	fi
	echo "SET UP SUCCESSFUL"
elif [ $1 == 'Clear' ]
then
	echo "DELETION STARTED"
	# ADD Deletion property of exposed files
	rm -R -f Research
	rm Parameter.txt
	echo "DELETION SUCCESSFUL"
elif [ $1 == 'File' ]
then
	GetFileInput
else
	echo "$1 is an INVALID COMMAND! [VALID COMMANDS ARE : Setup , Clean, and Run]"
fi
