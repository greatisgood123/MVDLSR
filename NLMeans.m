function w = NLMeans(Iin,h)
%Non-Local Means denoising method based on Buades-Coll-Morel model
%Iin: the original image, needs to be denoised
%h:   the degree of filtering, should be 10 times of the orignial image
%noise deviation
%A typical call of this function is Iout = NLMeans(Iin,1,10,7,21)

[nx,ny]=size(Iin);
w=zeros(ny,ny);
for i = 1:ny
 w1 = zeros(1,ny);
     for Kxm=1:ny
          w1(1,Kxm)= exp(-(norm((Iin(:,i)-Iin(:,Kxm)),2)/(h)));
     end   
     w1 = w1/sum(w1);  %πÈ“ªªØ
     w(i,:)=w1;
     
end
