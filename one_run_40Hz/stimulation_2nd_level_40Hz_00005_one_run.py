# In[1]:

from nipype import config
cfg = dict(execution={'remove_unnecessary_outputs': False})
config.update_config(cfg)

import nipype.interfaces.fsl as fsl
import nipype.interfaces.afni as afni
import nipype.interfaces.ants as ants
import nipype.interfaces.spm as spm

from nipype.interfaces.utility import IdentityInterface, Function, Select, Merge
from os.path import join as opj
from nipype.interfaces.io import SelectFiles, DataSink
from nipype.pipeline.engine import Workflow, Node, MapNode

import numpy as np
import os, re
import matplotlib.pyplot as plt
from nipype.interfaces.matlab import MatlabCommand
MatlabCommand.set_default_paths('/Users/amr/Downloads/spm12')
MatlabCommand.set_default_matlab_cmd("matlab -nodesktop -nosplash")

# import nipype.interfaces.matlab as mlab
# mlab.MatlabCommand.set_default_matlab_cmd("matlab -nodesktop -nosplash")
# mlab.MatlabCommand.set_default_paths('/home/amr/Documents/MATLAB/toolbox/spm8')

#============================================================================================================================
# In[2]:
experiment_dir = '/media/amr/Amr_4TB/Work/stimulation' 



subject_list = ['005', '007', '008', '010', '013', '024',
                '025', '026', '027', '028', '038', '040', 
                '041', '042', '051', '052', '053', '054',
                '055', '059', '060', '061', '079', '081']



output_dir  = 'Stimulation_2nd_level_OutputDir_40Hz_CA3_one_run'
working_dir = 'Stimulation_2nd_level_WorkingDir_40Hz_CA3_one_run'

stimulation_2nd_level = Workflow(name = 'stimulation_2nd_level_40Hz_CA3_one_run')
stimulation_2nd_level.base_dir = opj(experiment_dir, working_dir)


#==========================================================================================================================================================
# In[3]:
infosource = Node(IdentityInterface(fields=['subject_id']),
                  name="infosource")

infosource.iterables = [('subject_id', subject_list)]


#==========================================================================================================================================================
# In[4]:
# sub-001_task-MGT_run--02_bold.nii.gz, sub-001_task-MGT_run--02_sbref.nii.gz
#/preproc_img/run--04sub-119/smoothed_all_maths_filt_maths.nii.gz
#functional run-s


template_brain = '/media/amr/Amr_4TB/Work/October_Acquistion/Anat_Template_Enhanced.nii.gz' 
template_mask = '/media/amr/Amr_4TB/Work/October_Acquistion/Anat_Template_Enhanced_Mask.nii.gz'

TR = 2.0
no_runs = 3
#==========================================================================================================================================================

templates = {


'anat_brain'                :  '/media/amr/Amr_4TB/Work/stimulation/Data_CA3/{subject_id}/Anat_{subject_id}_bet.nii.gz',
'mask_brain'                :  '/media/amr/Amr_4TB/Work/stimulation/Data_CA3/{subject_id}/Anat_{subject_id}_Mask.nii.gz',
'anat_2_temp_trans'         :  '/media/amr/Amr_4TB/Work/stimulation/Stimulation_Preproc_OutputDir_CA3/anat_2_temp_transformations/subj_{subject_id}/transformComposite.h5',

#==========================================================================================================================================================

'func_2_anat_trans_40Hz_r1' :  """/media/amr/Amr_4TB/Work/stimulation/Stimulation_Preproc_WorkingDir_CA3/stimulation_preproc_CA3/_frequency_id_40Hz_session_id_run001_subject_id_{subject_id}/coreg/bold_2_anat_sub-{subject_id}0GenericAffine.mat""",
# 'func_2_anat_trans_40Hz_r2' :  """/media/amr/Amr_4TB/Work/stimulation/Stimulation_Preproc_WorkingDir_CA3/stimulation_preproc_CA3/_frequency_id_40Hz_session_id_run002_subject_id_{subject_id}/coreg/bold_2_anat_sub-{subject_id}0GenericAffine.mat""",
# 'func_2_anat_trans_40Hz_r3' :  """/media/amr/Amr_4TB/Work/stimulation/Stimulation_Preproc_WorkingDir_CA3/stimulation_preproc_CA3/_frequency_id_40Hz_session_id_run003_subject_id_{subject_id}/coreg/bold_2_anat_sub-{subject_id}0GenericAffine.mat""",

#==========================================================================================================================================================

'cope1_40Hz_r1'             : '/media/amr/Amr_4TB/Work/stimulation/Stimulation_1st_level_OutputDir_CA3/copes_1st_level/40Hz_run001_subj_{subject_id}/cope1.nii.gz',
# 'cope1_40Hz_r2'             : '/media/amr/Amr_4TB/Work/stimulation/Stimulation_1st_level_OutputDir_CA3/copes_1st_level/40Hz_run002_subj_{subject_id}/cope1.nii.gz',
# 'cope1_40Hz_r3'             : '/media/amr/Amr_4TB/Work/stimulation/Stimulation_1st_level_OutputDir_CA3/copes_1st_level/40Hz_run003_subj_{subject_id}/cope1.nii.gz',

#==========================================================================================================================================================

'varcope1_40Hz_r1'          : '/media/amr/Amr_4TB/Work/stimulation/Stimulation_1st_level_OutputDir_CA3/varcopes_1st_level/40Hz_run001_subj_{subject_id}/varcope1.nii.gz',
# 'varcope1_40Hz_r2'          : '/media/amr/Amr_4TB/Work/stimulation/Stimulation_1st_level_OutputDir_CA3/varcopes_1st_level/40Hz_run002_subj_{subject_id}/varcope1.nii.gz',
# 'varcope1_40Hz_r3'          : '/media/amr/Amr_4TB/Work/stimulation/Stimulation_1st_level_OutputDir_CA3/varcopes_1st_level/40Hz_run003_subj_{subject_id}/varcope1.nii.gz',

#==========================================================================================================================================================
}



selectfiles = Node(SelectFiles(templates,
                              base_directory=experiment_dir),
                              name="selectfiles")
#==========================================================================================================================================================
# In[5]:

datasink = Node(DataSink(), name = 'datasink')
datasink.inputs.container = output_dir
datasink.inputs.base_directory = experiment_dir

substitutions = [('_subject_id_', '')]

datasink.inputs.substitutions = substitutions



#==========================================================================================================================================================
#Since, I am only operating with one session, there will be no second level
#All I am going to do here is just register from native space to anat to template


merge_trans = Node(Merge(2), name='merge_transformations')
merge_trans.inputs.no_flatten = True



cope1_2_template = Node(ants.ApplyTransforms(), name='cope1_2_template')
cope1_2_template.inputs.dimension = 3
cope1_2_template.inputs.reference_image = template_brain
cope1_2_template.inputs.output_image = 'cope1_2_template_brain.nii.gz'



varcope1_2_template = Node(ants.ApplyTransforms(), name='varcope1_2_template')
varcope1_2_template.inputs.dimension = 3
varcope1_2_template.inputs.reference_image = template_brain
varcope1_2_template.inputs.output_image = 'varcope1_2_template_brain.nii.gz'




#==========================================================================================================================================================


stimulation_2nd_level.connect([


              (infosource, selectfiles, [('subject_id','subject_id')]),

              (selectfiles, merge_trans, [('anat_2_temp_trans','in1'),
                                          ('func_2_anat_trans_40Hz_r1','in2')]),

              (selectfiles, cope1_2_template, [('cope1_40Hz_r1','input_image')]),
              (merge_trans, cope1_2_template, [('out','transforms')]),



              (selectfiles, varcope1_2_template, [('varcope1_40Hz_r1', 'input_image')]),
              (merge_trans, varcope1_2_template, [('out','transforms')])



              ])

stimulation_2nd_level.write_graph(graph2use='colored', format='png', simple_form=True)

stimulation_2nd_level.run('MultiProc', plugin_args={'n_procs': 32})

#need number for l2model

