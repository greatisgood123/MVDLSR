function Phi = MeasurementMatrix(M,N,Method)
%�ú����������������������
%���������  M,N ---- ����ĳߴ�
%           Method ---- �ַ�����Method = 'Gaussian',���Ӹ�˹�ֲ�N(0��1/M)
%                              Method = 'Bernoulli',���ӱ�Ŭ���ֲ�
%�������:  Phi ---- �����������
%--------------------------------------------------------------------------
%  �����--�Ͼ��ʵ��ѧ ��Ȼ  Email: sololee2010@163.com
%  ���ʱ�䣺2011��11��
%--------------------------------------------------------------------------

switch Method
    case 'Gaussian'
        Phi = 1/sqrt(M) * randn(M,N);
    case 'Bernoulli'
        Phi = randsrc(M,N,[1,-1]); 
end
