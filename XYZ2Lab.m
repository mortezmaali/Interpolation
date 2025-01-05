%Code by Lin Chen 
%Summary
%   The function is to convert images to CIELAB.
%[IN]
%   a 3-by-n matrix of tristimulus values and a 3-by-1 vector of an
%   illuminant white point (XYZn)
%[OUT]
%   a 3-by-n matrix of CIELAB values
function CIELab=XYZ2Lab(XYZ,XYZn)
ratio=diag(1./XYZn)*XYZ;
idx=(ratio<=0.00856);
f=zeros(size(ratio));
f(idx)=7.787.*ratio(idx)+16/116;
f(~idx)=ratio(~idx).^(1/3);
L=116*f(2,:)-16;
a=500*(f(1,:)-f(2,:));
b=200*(f(2,:)-f(3,:));
CIELab=[L;a;b];