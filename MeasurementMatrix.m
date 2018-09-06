function Phi = MeasurementMatrix(M,N,Method)
%该函数用于生成随机测量矩阵
%输入参数：  M,N ---- 矩阵的尺寸
%           Method ---- 字符串，Method = 'Gaussian',服从高斯分布N(0，1/M)
%                              Method = 'Bernoulli',服从贝努利分布
%输出参数:  Phi ---- 随机测量矩阵
%--------------------------------------------------------------------------
%  编程人--南京邮电大学 李然  Email: sololee2010@163.com
%  编程时间：2011年11月
%--------------------------------------------------------------------------

switch Method
    case 'Gaussian'
        Phi = 1/sqrt(M) * randn(M,N);
    case 'Bernoulli'
        Phi = randsrc(M,N,[1,-1]); 
end
