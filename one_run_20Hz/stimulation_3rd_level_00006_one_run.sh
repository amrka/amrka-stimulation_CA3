#!/bin/bash
#copy 1st level images to have a perspective what's active what's not

# for folder in /media/amr/Amr_4TB/Work/stimulation/Data_CA3/*;do 
# 	cd $folder; 
# 	cp *.png /media/amr/Amr_4TB/Work/stimulation/CA3_1st_level_images/${folder}.png; 
# 	cd ..; 
# done

# for folder in /media/amr/Amr_4TB/Work/stimulation/Data_CA3/*;do 
# 	mkdir /media/amr/Amr_4TB/Work/stimulation/CA3_1st_level_images/${folder}; 
# 	mv  /media/amr/Amr_4TB/Work/stimulation/CA3_1st_level_images/*_${folder}.png /media/amr/Amr_4TB/Work/stimulation/CA3_1st_level_images/${folder}/; 
# done



#combine the copes from the 2nd level for 10,20 and 40 Hz



mkdir -p /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/{05Hz,10Hz,20Hz,40Hz}

cd /media/amr/Amr_4TB/Work/stimulation/Data_CA3/


for folder in *;do

	imcp /media/amr/Amr_4TB/Work/stimulation/Stimulation_2nd_level_WorkingDir_20Hz_CA3_one_run/stimulation_2nd_level_20Hz_CA3_one_run/_subject_id_${folder}/cope1_2_template/cope1_2_template_brain.nii.gz \
	/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_${folder}

	imcp /media/amr/Amr_4TB/Work/stimulation/Stimulation_2nd_level_WorkingDir_20Hz_CA3_one_run/stimulation_2nd_level_20Hz_CA3_one_run/_subject_id_${folder}/varcope1_2_template/varcope1_2_template_brain.nii.gz \
	/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/varcope1_${folder}


done

#======================================================================================================================

# change file names to contain gp name


python3 /Users/amr/Dropbox/SCRIPTS/change_files_to_contain_gp_name.py \
/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz -10 -7

#=====================================================================================================================
#Delete subjects with no activation: 005, 028, 052
#females no. 81 79

imrm /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/*/*_005.nii.gz 

imrm /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/*/*_028.nii.gz

imrm /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/*/*_052.nii.gz

# females
imrm /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/*/*_079.nii.gz

imrm /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/*/*_081.nii.gz



#======================================================================================================================


fslmerge -t /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_20Hz.nii.gz \
/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/*_cope1_*.nii.gz


fslchfiletype NIFTI /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_20Hz.nii.gz

fslmerge -t /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/varcope1_20Hz.nii.gz \
/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/*_varcope1_*.nii.gz 



fslchfiletype NIFTI /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/varcope1_20Hz.nii.gz


#=====================================================================================================================
#Now, the third-level designs should be as hollow:
# 05Hz -> 9  A & 8 B (7  A without females))
# 10Hz -> 12 A & 9 B (10 A without females)
# 20Hz -> 12 A & 9 B (10 A without females)
# 20Hz -> 12 A & 9 B (10 A without females)


# design_ttest2 /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/05Hz/05Hz_3rd_level 7 8 -m

# design_ttest2 /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/10Hz/10Hz_3rd_level 10 9 -m

# design_ttest2 /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/20Hz_3rd_level 10 9  -m

# design_ttest2 /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/20Hz_3rd_level 10 9  -m


#=====================================================================================================================

# mkdir /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/05Hz/palm 

# palm \
# -i /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/05Hz/cope1_05Hz.nii \
# -o /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/05Hz/palm/05Hz_ \
# -m /media/amr/Amr_4TB/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/05Hz/05Hz_3rd_level.mat \
# -t /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/05Hz/05Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p 
# # -vg /media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz.grp \



# mkdir /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/10Hz/palm 

# palm \
# -i /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/10Hz/cope1_10Hz.nii \
# -o /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/10Hz/palm/10Hz_ \
# -m /media/amr/Amr_4TB/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/10Hz/10Hz_3rd_level.mat \
# -t /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/10Hz/10Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p 
# # -vg /media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz.grp \




# mkdir /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/palm 

# palm \
# -i /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_20Hz.nii \
# -o /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/palm/20Hz_ \
# -m /media/amr/Amr_4TB/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/20Hz_3rd_level.mat \
# -t /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/20Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p 
# # -vg /media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz.grp \



# mkdir /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/palm 

# palm \
# -i /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_20Hz.nii \
# -o /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/palm/20Hz_ \
# -m /media/amr/Amr_4TB/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/20Hz_3rd_level.mat \
# -t /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/20Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p 
# # -vg /media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz.grp \



#======================================================================================================================




flameo \
--cope=/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_20Hz.nii \
--vc=/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/varcope1_20Hz.nii \
--mask=/media/amr/Amr_4TB/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
--ld=/media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/flameo/ \
--dm=/media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.mat \
--tc=/media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.con \
--cs=/media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.grp \
--runmode=flame12 




# #================================================================================================================================


mkdir /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/randomise




randomise \
-i /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/cope1_20Hz.nii \
-o /media/amr/Amr_4TB/Work/stimulation/stimulation_3rd_level_CA3_one_run/20Hz/randomise/20Hz_ \
-m /media/amr/Amr_4TB/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
-d /media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.mat \
-t /media/amr/Amr_4TB/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.con \
-n 5000 -x -T --uncorrp


