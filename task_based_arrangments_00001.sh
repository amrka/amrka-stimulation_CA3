#!/bin/bash
#The data was acquired using Bruker 7T MRI machine
#The default output of the machine is 2dseq
#This script is for stimulation of CA3, Feb_2019, April_2019
  
cd '/media/amr/Amr_4TB/Work/stimulation/stimulation_raw_data_CA3'

#now the folder is in this format:
# A010419_24/  
# A020419_38/                B020419_26/
# A030419_25/                B030419_28/
# A040419_27/                B040419_42/
# A050419_41/                B050419_53/
# A080419_51/                B080419_52/
# A090419_54/                B090419_55/
# A100419_40/                B100419_61/
# A110419_60/                B110419_59/
# A120419_79/                B120419_81/
# A200219_8/                 B200219_10/
# A220219_7/                 C210219_5/
# C220219_13/				 meta/

#Now, remove the machine name and zeropadding
# for folder in *;do
# 	new_name=`echo $folder | cut -d '_' -f 2`
# 	zero_pad=`zeropad ${new_name} 3`
# 	mv $folder ${zero_pad}
# done



mkdir '/media/amr/Amr_4TB/Work/stimulation/Data_CA3' 
for folder in *;do
	#convert 2dseq to analyze format using an old script written in perl
	pvconv.pl $folder -outdir $folder
	
	cd $folder

	mkdir /media/amr/Amr_4TB/Work/stimulation/Data_CA3/${folder}
	pwd
	

	for image in *.img;do
		fslchfiletype NIFTI_GZ $image
	done

	for image in *.nii.gz;do
		#You cannot swapdim without sform or qform


		dim1=`fslval ${image} dim1`
		dim4=`fslval ${image} dim4`
		echo $pixdim $dim4
		without_ext=`remove_ext $image`
		number=`echo ${without_ext} | cut  -d"_" -f2` 

		
		if    [[ "$dim1" -eq "200"  &&  "$dim4" -eq "1" ]]; then
			
			fslswapdim $image RL AP IS $image
			Augment.sh $image 10 2
			fslorient -deleteorient    $image
			fslorient -setsformcode 1  $image
			fslorient -setqformcode 1  $image



			imcp $image /media/amr/Amr_4TB/Work/stimulation/Data_CA3/${folder}/Anat_${folder}
		elif  [[ "$dim1" -eq "100"   &&  "$dim4" -eq "150" ]]; then
			
			fslswapdim $image RL AP IS $image
			Augment.sh $image 10 2
			fslorient -deleteorient    $image
			fslorient -setsformcode 1  $image
			fslorient -setqformcode 1  $image

			#Extract a ROI from each file and take the average to use for manual skull-stripping
			#The electrode makes everything difficult with the coregistration
			fslroi $image Example_${number} 75 1
			imcp $image /media/amr/Amr_4TB/Work/stimulation/Data_CA3/${folder}/Stim_${folder}_${number}
		fi
	done
	fslmerge -t EPI_Average_${folder} Example_*
	fslmaths EPI_Average_${folder} -Tmean EPI_Average_${folder} 
	imrm Example_* 
	imcp EPI_Average_${folder} /media/amr/Amr_4TB/Work/stimulation/Data_CA3/${folder}/ 

	cd ..
done


#Now, you have to draw a mask for anat and epi_average manually

















