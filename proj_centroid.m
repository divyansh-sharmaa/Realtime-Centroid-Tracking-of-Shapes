clc
clear all
close all
warning off
mycam=ipcam('http://172.16.128.213:8080/video'); %write your IPWebcam address as shown to you in the app
while true
e=mycam.snapshot;
ks=rgb2gray(e);
mg=~imbinarize(ks);
mg=imfill(mg,'holes');
mg=bwareaopen(mg,10);
[a bc]=bwlabel(mg);
b=[];
temp=0;
gk=1;
[f g]=size(a);
for i=1:bc
for wk=1:f
for tk=1:g
if(a(wk,tk)==gk)
temp=temp+1;
end
end
end
b=[b temp];
temp=0;
gk=gk+1;
end
level=1:bc;
for i=1:length(b)
for j=1:(length(b)-i)
if(b(j)>b(j+1))
temp=b(j);
b(j)=b(j+1);
b(j+1)=temp;
gemp=level(j);
level(j)=level(j+1);
level(j+1)=gemp;
end
end
end
if(bc>=4)
b_heighest_5=[];
level_heighest_5=[];
for i=length(b):-1:length(b)-3
b_heighest_5=[b(i) b_heighest_5];
level_heighest_5=[level(i) level_heighest_5];
end
center_x=[];
center_y=[];
for n=1:4
bmap=a==level_heighest_5(n);
[rows,cols]=find(bmap==1);
rc=mean(rows);
cc=mean(cols);
center_x=[center_x (rc)];
center_y=[center_y (cc)];
end
imshow(e);
hold on;
plot(center_y,center_x,'w*','linewidth',10);
drawnow;
clf;
else
imshow(e);
end
end