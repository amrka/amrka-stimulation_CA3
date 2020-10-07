#!/bin/bash

#combine the copes from the 2nd level for 10,20 and 40 Hz



cd /home/in/aeed/Work/stimulation/Data_CA3/

mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/timeseries
mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/timeseries
mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/timeseries
mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/timeseries


for folder in *;do

	if [[ -d $folder ]];then
		cp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_40Hz_CA3/stimulation_2nd_level_40Hz_CA3/_subject_id_${folder}/mean_timeseries_2nd_level/mean_ts_40Hz_2nd_level.txt \
		/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/timeseries/percent_change_40Hz_${folder}.txt



		cp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_20Hz_CA3/stimulation_2nd_level_20Hz_CA3/_subject_id_${folder}/mean_timeseries_2nd_level/mean_ts_20Hz_2nd_level.txt \
		/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/timeseries/percent_change_20Hz_${folder}.txt


		cp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_10Hz_CA3/stimulation_2nd_level_10Hz_CA3/_subject_id_${folder}/mean_timeseries_2nd_level/mean_ts_10Hz_2nd_level.txt \
		/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/timeseries/percent_change_10Hz_${folder}.txt

        cp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_05Hz_CA3/stimulation_2nd_level_05Hz_CA3/_subject_id_${folder}/mean_timeseries_2nd_level/mean_ts_05Hz_2nd_level.txt \
        /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/timeseries/percent_change_05Hz_${folder}.txt
	fi



done

#======================================================================================================================

# change file names to contain gp name

python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/timeseries -7 -4


python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/timeseries -7 -4


python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/timeseries -7 -4


python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/timeseries -7 -4
