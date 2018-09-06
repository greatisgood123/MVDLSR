function PCA_MvDA(trainset_path,pca_model_path,lda_model_path,pca_options, b_viewconsistency, lambda)
%% Get DB
num_view = length(trainset_path);
X_multiview = cell(1,num_view);
Label_multiview = cell(1,num_view);
for i=1:num_view
    m = load(trainset_path{i});
    Xi = m.X;
    Li = m.Label;
    X_multiview{i} = Xi;
    Label_multiview{i} = Li;
end

%% PCA
if ~exist(pca_model_path,'file')
    [x_mean x_var eig_value W_pca] = MvPCA(X_multiview, pca_options);
    save(pca_model_path, 'x_mean', 'x_var', 'eig_value', 'W_pca');
end

[Y_multiview x_mean x_var W_pca]= MvPCA_Projection(X_multiview,pca_model_path,pca_options);
if b_viewconsistency == 0
    W_lda = MvDA(Y_multiview,Label_multiview);
else
    W_lda = MvDAvc(Y_multiview,Label_multiview, lambda);
end
save(lda_model_path, 'x_mean', 'x_var', 'W_pca', 'W_lda');
