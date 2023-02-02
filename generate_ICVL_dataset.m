img_dir = '..\inputs\ICVL_test_data\';
files = dir(fullfile(img_dir, '*.mat'));
file_names = {files.name};

save_dir = 'dataset\ICVL\';

n_test_img = numel(files);
img_sz = [512,512];

% load cassi mask
load('dataset\mask_512x512.mat');

for idx = 1 : 10
    % load test data
    filename = files(idx).name;
    load(['..\inputs\ICVL_test_data\',filename]);
    
    % hyperspectral img
    orig = single(rad);
    orig = imresize(orig,img_sz);
    % normalize the Iin vals
    orig = orig./max(orig(:));
    
    % rgb img
    orig_rgb = imresize(rgb,img_sz);
    
    % lambda
    wavelength = bands;
    
    % Measured image
    meas = sum(mask.*orig,3);
    meas = single(meas);
      
    % save dataset
    save([save_dir,filename], 'mask','meas','orig','orig_rgb','wavelength');
end