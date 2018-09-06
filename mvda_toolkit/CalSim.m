function sim = CalSim(gallery,test)
    dim = size(test,1);
    total_num_test = size(test,2);
    total_num_gallery = size(gallery,2);
    
    norm_t = zeros(1,total_num_test);
    for i = 1:total_num_test
        norm_t(1,i) = norm(test(:,i));
    end
    norm_test = repmat(norm_t,dim,1);
    
    norm_g = zeros(1,total_num_gallery);
    for i = 1:total_num_gallery
        norm_g(1,i) = norm(gallery(:,i));
    end
    norm_gallery = repmat(norm_g, dim,1);
    
    test = test ./ norm_test;
    gallery = gallery ./ norm_gallery;
    
    %cal sim
    sim = test' * gallery;