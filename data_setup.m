% Preprocessed and analysed data will be in "results/" folder
data_dir = fullfile(getenv('HOME'),'ds000157-download');
spm_dir = fullfile(getenv('HOME'),'spm12');
results_dir = fullfile(getenv('HOME'),'results');
stats_dir = [results_dir filesep 'stats'];
processing_dir = [results_dir filesep 'preproc_data'];
if ~exist(stats_dir,'dir')
    mkdir(stats_dir);
end
if ~exist(processing_dir,'dir')
    mkdir(processing_dir);
end
% Initialize subject data; extract; copy to preprocessing folder
sub = '01';
s_raw_fn = fullfile(data_dir, ['sub-' sub], 'anat', ['sub-' sub '_T1w.nii.gz']);
if exist(s_raw_fn, 'file')
    out_fns = gunzip(s_raw_fn);
    s_fn = out_fns{1};
else
    s_fn = strrep(s_raw_fn, '.gz', '');
end
f_raw_fn = fullfile(data_dir, ['sub-' sub], 'func', ['sub-' sub '_task-passiveimageviewing_bold.nii.gz']);
if exist(f_raw_fn, 'file')
    out_fns = gunzip(f_raw_fn);
    f_fn = out_fns{1};
else
    f_fn = strrep(f_raw_fn, '.gz', '');
end
% Create preprocessing subfolders
anat_dir = fullfile(processing_dir, ['sub-' sub], 'anat'); 
func_dir = fullfile(processing_dir, ['sub-' sub], 'func'); 
if ~exist(anat_dir, 'dir')
    mkdir(anat_dir);
end
if ~exist(func_dir, 'dir')
    mkdir(func_dir);
end
% Copy extracted files to preprocessing subfolders
anat_fn = fullfile(processing_dir, ['sub-' sub], 'anat', ['sub-' sub '_T1w.nii']);
func_fn = fullfile(processing_dir, ['sub-' sub], 'func', ['sub-' sub '_task-passiveimageviewing_bold.nii']);
if ~exist(anat_fn, 'file')
    copyfile(s_fn, anat_dir);
end
if ~exist(func_fn, 'file')
    copyfile(f_fn, func_dir);
end
% Initialize processing variables
fwhm = 6;  % mm

disp('Data setup finished')