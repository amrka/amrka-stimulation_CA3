#!/bin/bash

# convert stimulation stat results to rambmc_in_anat_enh_3_space and create figures
# you should pass the frequency from the cmd line and the script does the rest

frequency=$1

flirt_trans='/Users/amr/Dropbox/thesis/registration/anat_to_rambmc_flirt.mat'
ants_trans='/Users/amr/Dropbox/thesis/registration/anat_to_rambmc_flirt_Composite.h5'
rambmc='/Users/amr/Dropbox/thesis/registration/rambmc_in_anat_enh_3_space.nii.gz'
out_dir='/Users/amr/Dropbox/thesis/stimulation'
fsleyes='pythonw /Users/amr/anaconda3/bin/fsleyes' #aliases do not work inside scripts
#==============================================================================
# make a fig for gp A
input_img_A=/media/amr/Amr_4TB/Work/stimulation/output_stimulation_proc_3rd_level_post_fitting_CA3/threshold_file/${frequency}_zstat3/threshold_file.nii.gz

input_img_A=`remove_ext ${input_img_A}`


flirt \
-in 	${input_img_A} \
-ref 	${rambmc} \
-init	${flirt_trans} \
-applyxfm \
-out ${out_dir}/A_${frequency}_flirted_CA3.nii.gz \

# if the output not float, fsleyes render will crash
antsApplyTransforms \
-d       3 \
-i 		${out_dir}/A_${frequency}_flirted_CA3.nii.gz \
-r      ${rambmc} \
-t 		${ants_trans} \
-o 		${out_dir}/A_${frequency}_rambmc_CA3.nii.gz \
-v --float

slice_no=357

# if the image a little bit cropped, then you need to put the cursor in the middle of the brain, when you first load an image -> copy those coordinates


# 455, 303
for slice_no in {474,436,417,398,360,341,322,284};do

    ${fsleyes} render  \
    --scene ortho -no   --displaySpace world --hidex --hidey    -vl 169  124 ${slice_no} \
    --hideCursor   --outfile    ${out_dir}/A_${frequency}_stat_CA3_${slice_no}.png   \
    ${rambmc} --displayRange 50 210  \
    ${out_dir}/A_${frequency}_rambmc_CA3.nii.gz --cmap red     --displayRange 3.1  7


     convert ${out_dir}/A_${frequency}_stat_CA3_${slice_no}.png -crop 740x500+30+50  ${out_dir}/A_${frequency}_stat_cropped_CA3_${slice_no}.png

done


 pngappend \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_284.png + \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_322.png + \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_341.png + \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_360.png - \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_398.png + \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_417.png + \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_436.png + \
 ${out_dir}/A_${frequency}_stat_cropped_CA3_474.png  \
 ${out_dir}/A_${frequency}_CA3.png

 #==============================================================================
 # make a fig for gp B
input_img_B=/media/amr/Amr_4TB/Work/stimulation/output_stimulation_proc_3rd_level_post_fitting_CA3/threshold_file/${frequency}_zstat4/threshold_file.nii.gz

input_img_B=`remove_ext ${input_img_B}`



flirt \
-in 	${input_img_B} \
-ref 	${rambmc} \
-init	${flirt_trans} \
-applyxfm \
-out ${out_dir}/B_${frequency}_flirted_CA3.nii.gz \

# if the output not float, fsleyes render will crash
antsApplyTransforms \
-d       3 \
-i 		${out_dir}/B_${frequency}_flirted_CA3.nii.gz \
-r      ${rambmc} \
-t 		${ants_trans} \
-o 		${out_dir}/B_${frequency}_rambmc_CA3.nii.gz \
-v --float

slice_no=357

# if the image a little bit cropped, then you need to put the cursor in the middle of the brain, when you first load an image -> copy those coordinates


# 455, 303
for slice_no in {474,436,417,398,360,341,322,284};do

    ${fsleyes} render  \
    --scene ortho -no   --displaySpace world --hidex --hidey    -vl 169  124 ${slice_no} \
    --hideCursor   --outfile    ${out_dir}/B_${frequency}_stat_CA3_${slice_no}.png   \
    ${rambmc} --displayRange 50 210  \
    ${out_dir}/B_${frequency}_rambmc_CA3.nii.gz --cmap blue     --displayRange 3.1  7


    convert ${out_dir}/B_${frequency}_stat_CA3_${slice_no}.png -crop 740x500+30+50  ${out_dir}/B_${frequency}_stat_cropped_CA3_${slice_no}.png
done


pngappend \
${out_dir}/B_${frequency}_stat_cropped_CA3_284.png + \
${out_dir}/B_${frequency}_stat_cropped_CA3_322.png + \
${out_dir}/B_${frequency}_stat_cropped_CA3_341.png + \
${out_dir}/B_${frequency}_stat_cropped_CA3_360.png - \
${out_dir}/B_${frequency}_stat_cropped_CA3_398.png + \
${out_dir}/B_${frequency}_stat_cropped_CA3_417.png + \
${out_dir}/B_${frequency}_stat_cropped_CA3_436.png + \
${out_dir}/B_${frequency}_stat_cropped_CA3_474.png  \
${out_dir}/B_${frequency}_CA3.png

  #==============================================================================================
  # now both two imges overlaid
  # group A and B above

for slice_no in {474,436,417,398,360,341,322,284};do

  ${fsleyes} render  \
  --scene ortho -no   --displaySpace world --hidex --hidey    -vl 169  124 ${slice_no} \
  --hideCursor   --outfile    ${out_dir}/${frequency}_stat_CA3_${slice_no}.png   \
  ${rambmc} --displayRange 50 210  \
  ${out_dir}/A_${frequency}_rambmc_CA3.nii.gz --cmap red       --displayRange 3.1  7 \
  ${out_dir}/B_${frequency}_rambmc_CA3.nii.gz --cmap blue    --displayRange 3.1  7


   convert ${out_dir}/${frequency}_stat_CA3_${slice_no}.png -crop 740x500+30+50  ${out_dir}/${frequency}_stat_cropped_CA3_${slice_no}.png
done


pngappend \
${out_dir}/${frequency}_stat_cropped_CA3_284.png + \
${out_dir}/${frequency}_stat_cropped_CA3_322.png + \
${out_dir}/${frequency}_stat_cropped_CA3_341.png + \
${out_dir}/${frequency}_stat_cropped_CA3_360.png - \
${out_dir}/${frequency}_stat_cropped_CA3_398.png + \
${out_dir}/${frequency}_stat_cropped_CA3_417.png + \
${out_dir}/${frequency}_stat_cropped_CA3_436.png + \
${out_dir}/${frequency}_stat_cropped_CA3_474.png  \
${out_dir}/combined_${frequency}_CA3.png


# rm ${out_dir}/*_???.png
