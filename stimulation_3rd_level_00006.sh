#!/bin/bash
#copy 1st level images to have a perspective what's active what's not

# for folder in /home/in/aeed/Work/stimulation/Data_CA3/*;do
# 	cd $folder;
# 	cp *.png /home/in/aeed/Work/stimulation/CA3_1st_level_images/${folder}.png;
# 	cd ..;
# done

# for folder in /home/in/aeed/Work/stimulation/Data_CA3/*;do
# 	mkdir /home/in/aeed/Work/stimulation/CA3_1st_level_images/${folder};
# 	mv  /home/in/aeed/Work/stimulation/CA3_1st_level_images/*_${folder}.png /home/in/aeed/Work/stimulation/CA3_1st_level_images/${folder}/;
# done



#combine the copes from the 2nd level for 10,20 and 40 Hz



mkdir -p /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/{05Hz,10Hz,20Hz,40Hz}

cd /home/in/aeed/Work/stimulation/Data_CA3/


for folder in *;do

	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_40Hz_CA3/stimulation_2nd_level_40Hz_CA3/_subject_id_${folder}/cope1_2ndlevel_2_template/cope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/cope1_${folder}

	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_40Hz_CA3/stimulation_2nd_level_40Hz_CA3/_subject_id_${folder}/varcope1_2ndlevel_2_template/varcope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/varcope1_${folder}



	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_20Hz_CA3/stimulation_2nd_level_20Hz_CA3/_subject_id_${folder}/cope1_2ndlevel_2_template/cope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/cope1_${folder}

	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_20Hz_CA3/stimulation_2nd_level_20Hz_CA3/_subject_id_${folder}/varcope1_2ndlevel_2_template/varcope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/varcope1_${folder}



	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_10Hz_CA3/stimulation_2nd_level_10Hz_CA3/_subject_id_${folder}/cope1_2ndlevel_2_template/cope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/cope1_${folder}

	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_10Hz_CA3/stimulation_2nd_level_10Hz_CA3/_subject_id_${folder}/varcope1_2ndlevel_2_template/varcope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/varcope1_${folder}


	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_05Hz_CA3/stimulation_2nd_level_05Hz_CA3/_subject_id_${folder}/cope1_2ndlevel_2_template/cope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/cope1_${folder}

	imcp /home/in/aeed/Work/stimulation/Stimulation_2nd_level_WorkingDir_05Hz_CA3/stimulation_2nd_level_05Hz_CA3/_subject_id_${folder}/varcope1_2ndlevel_2_template/varcope1_2ndlevel_2_template_brain.nii.gz \
	/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/varcope1_${folder}



done

#======================================================================================================================

# change file names to contain gp name

python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz -10 -7

python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz -10 -7


python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz -10 -7


python3 /home/in/aeed/SCRIPTS/change_files_to_contain_gp_name_CA3.py \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz -10 -7

#=====================================================================================================================
#Delete subjects with no activation: 005, 028, 052
#females no. 81 79

imrm /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/*/*_005.nii.gz

imrm /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/*/*_028.nii.gz

imrm /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/*/*_052.nii.gz

# females
imrm /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/*/*_079.nii.gz

imrm /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/*/*_081.nii.gz


#======================================================================================================================
#merge copes and varcopes for each frequency seperately

fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/cope1_05Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/*_cope1_*.nii.gz


gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/cope1_05Hz.nii.gz

fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/varcope1_05Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/*_varcope1_*.nii.gz


gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/varcope1_05Hz.nii.gz



#======================================================================================================================


fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/cope1_10Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/*_cope1_*.nii.gz


gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/cope1_10Hz.nii.gz

fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/varcope1_10Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/*_varcope1_*.nii.gz


gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/varcope1_10Hz.nii.gz



#======================================================================================================================

fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/cope1_20Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/*_cope1_*.nii.gz



gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/cope1_20Hz.nii.gz

fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/varcope1_20Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/*_varcope1_*.nii.gz


gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/varcope1_20Hz.nii.gz


#======================================================================================================================


fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/cope1_40Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/*_cope1_*.nii.gz


gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/cope1_40Hz.nii.gz

fslmerge -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/varcope1_40Hz.nii.gz \
/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/*_varcope1_*.nii.gz



gunzip /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/varcope1_40Hz.nii.gz


#=====================================================================================================================
#Now, the third-level designs should be as hollow:
# 05Hz -> 9  A & 8 B (7  A without females))
# 10Hz -> 12 A & 9 B (10 A without females)
# 20Hz -> 12 A & 9 B (10 A without females)
# 40Hz -> 12 A & 9 B (10 A without females)


design_ttest2 /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/05Hz_3rd_level 7 8 -m

design_ttest2 /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/10Hz_3rd_level 10 9 -m

design_ttest2 /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/20Hz_3rd_level 10 9  -m

design_ttest2 /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/40Hz_3rd_level 10 9  -m


#=====================================================================================================================

# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/palm

# palm \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/cope1_05Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/palm/05Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/05Hz_3rd_level.mat \
# -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/05Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p
# # -vg /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz.grp \



# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/palm

# palm \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/cope1_10Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/palm/10Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/10Hz_3rd_level.mat \
# -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/10Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p
# # -vg /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz.grp \




# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/palm

# palm \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/cope1_20Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/palm/20Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/20Hz_3rd_level.mat \
# -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/20Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p
# # -vg /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz.grp \



# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/palm

# palm \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/cope1_40Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/palm/40Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/40Hz_3rd_level.mat \
# -t /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/40Hz_3rd_level.mat \
# -n 5000 -T -C 3.1 -ise -corrcon -save1-p
# # -vg /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_40Hz.grp \



#======================================================================================================================


flameo \
--cope=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/cope1_05Hz.nii \
--vc=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/varcope1_05Hz.nii \
--mask=/home/in/aeed/Work/October_Acquistion/anat_template_enhanced_mask_2.nii.gz \
--ld=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/flameo/ \
--dm=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz_CA3.mat \
--tc=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz_CA3.con \
--cs=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz_CA3.grp \
--runmode=flame12








flameo \
--cope=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/cope1_10Hz.nii \
--vc=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/varcope1_10Hz.nii \
--mask=/home/in/aeed/Work/October_Acquistion/anat_template_enhanced_mask_2.nii.gz \
--ld=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/flameo/ \
--dm=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz_CA3.mat \
--tc=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz_CA3.con \
--cs=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz_CA3.grp \
--runmode=flame12







flameo \
--cope=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/cope1_20Hz.nii \
--vc=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/varcope1_20Hz.nii \
--mask=/home/in/aeed/Work/October_Acquistion/anat_template_enhanced_mask_2.nii.gz \
--ld=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/flameo/ \
--dm=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.mat \
--tc=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.con \
--cs=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.grp \
--runmode=flame12






flameo \
--cope=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/cope1_40Hz.nii \
--vc=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/varcope1_40Hz.nii \
--mask=/home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
--ld=/home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/flameo/ \
--dm=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_40Hz_CA3.mat \
--tc=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_40Hz_CA3.con \
--cs=/home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_40Hz_CA3.grp \
--runmode=flame12




# #================================================================================================================================
# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/randomise
#
# randomise \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/cope1_05Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/05Hz/randomise/05Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz_CA3.mat \
# -t /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_05Hz_CA3.con \
# -n 5000 -x -T --uncorrp
#
#
#
# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/randomise
#
#
# randomise \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/cope1_10Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/10Hz/randomise/10Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz_CA3.mat \
# -t /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_10Hz_CA3.con \
# -n 5000 -x -T --uncorrp
#
#
#
#
# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/randomise
#
#
#
#
# randomise \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/cope1_20Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/20Hz/randomise/20Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.mat \
# -t /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_20Hz_CA3.con \
# -n 5000 -x -T --uncorrp
#
#
#
#
#
#
#
# mkdir /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/randomise
#
#
#
#
# randomise \
# -i /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/cope1_40Hz.nii \
# -o /home/in/aeed/Work/stimulation/stimulation_3rd_level_CA3/40Hz/randomise/40Hz_ \
# -m /home/in/aeed/Work/stimulation/Anat_Template_Enhanced_Mask.nii \
# -d /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_40Hz_CA3.mat \
# -t /home/in/aeed/Work/stimulation/1st_Level_Designs/3rd_level_design_40Hz_CA3.con \
# -n 5000 -x -T --uncorrp
#
#
