#!/bin/bash

# copy the txt files that contain the number of voxels

mkdir -p /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/

mkdir -p /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/total_no_voxels/{05Hz,10Hz,20Hz,40Hz}

mkdir -p /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/left_no_voxels/{05Hz,10Hz,20Hz,40Hz}


for txt in  /media/amr/Amr_4TB/Work/stimulation/workingdir_stimulation_no_voxels_CA3/no_voxels_CA3/_frequencies_??Hz_subjects_???/total_no_voxels/total_no_voxels.txt;do
# extract freq and subject_id

    info=`echo $txt | sed s]'/media/amr/Amr_4TB/Work/stimulation/workingdir_stimulation_no_voxels_CA3/no_voxels_CA3/_frequencies_']'']g | sed s]'/total_no_voxels/total_no_voxels.txt']'']g | sed s]'subjects_']'']g`
    frequency=`echo ${info:0:4}`
    subject_id=`echo ${info:5:10}`

    cp $txt \
    /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/total_no_voxels/${frequency}/total_no_voxels_${subject_id}.txt
done



for txt in  /media/amr/Amr_4TB/Work/stimulation/workingdir_stimulation_no_voxels_CA3/no_voxels_CA3/_frequencies_??Hz_subjects_???/left_no_voxels/left_no_voxels.txt;do
# extract freq and subject_id

    info=`echo $txt | sed s]'/media/amr/Amr_4TB/Work/stimulation/workingdir_stimulation_no_voxels_CA3/no_voxels_CA3/_frequencies_']'']g | sed s]'/left_no_voxels/left_no_voxels.txt']'']g | sed s]'subjects_']'']g`
    frequency=`echo ${info:0:4}`
    subject_id=`echo ${info:5:10}`

    cp $txt \
    /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/left_no_voxels/${frequency}/left_no_voxels_${subject_id}.txt
done




# change files names to contain gp name
for folder in /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/total_no_voxels/*;do
    python3 /Users/amr/Dropbox/SCRIPTS/change_files_to_contain_gp_name_CA3.py ${folder}   -7 -4
    cd $folder
    frequency=`basename $folder`
    cat A*.txt >> A_CA3_total_${frequency}.txt
    cat B*.txt >> B_CA3_total_${frequency}.txt
done

#
for folder in /media/amr/Amr_4TB/Work/stimulation/no_voxels_CA3/left_no_voxels/*;do
    python3 /Users/amr/Dropbox/SCRIPTS/change_files_to_contain_gp_name_CA3.py ${folder}   -7 -4
    cd $folder
    frequency=`basename $folder`
    cat A*.txt >> A_CA3_left_${frequency}.txt
    cat B*.txt >> B_CA3_left_${frequency}.txt
done
