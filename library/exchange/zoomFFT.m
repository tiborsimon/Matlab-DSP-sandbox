disp('  zoomFFT - version 1.1, April 20, 2005 ');
disp('  by Tom Irvine ');
disp('  Email:  tomirvine@aol.com ');
%
disp(' ');
disp(' This program calculates the non-destructive zoom ');
disp(' Fast Fourier transform of a time history. ');
%
disp(' ');
disp(' The input file must be time(sec) and amplitude(units) ');
disp(' The format is free, but no header lines allowed.');
disp(' Please enter the input filename. ');
%
%  Add phase compensation in future version
%
%  Reference:  Randall, Frequency Analysis, Bruel & Kjaer, page 170.
%
%   262144
%   131072
%    65536
%    32768
%    16384
%
clear THM;
clear amp;
clear ampf;
clear tim;
clear FF;
clear n;
clear N;
clear MM;
clear nz;
clear Y;
%
MAX  =  262144*2;
MAXP1 = 131072*2;
%
inv=0;
mf=0.;
%
tp=2.*pi;
%
iflag=0;
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    disp(' Enter the input filename ');
    filename = input(' ','s');
    fid = fopen(filename,'r');
    THM = fscanf(fid,'%g %g',[2 inf]);
    THM=THM';
else
    THM = input(' Enter the matrix name:  ');
end
%
%N=4096;
%
amp=THM(:,2);
tim=THM(:,1);
n = length(amp);
%
for(i=1:18)
    if( 2^i > n )
        break;
    end
    N=2^i;
end
%
out4 = sprintf(' time history length = %d ',n);
disp(out4)
disp(' ');
out5 = sprintf(' samples used for FFT = %d',N);
disp(out5)
nsegment=N;
%
%disp(' mean values ')
%
mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);
tmx=max(tim);
tmi=min(tim);
dt=(tmx-tmi)/(n-1);
%
sr=1/dt;
df=1./(N*dt);
%
disp(' ')
out5 = sprintf(' dt=%12.4g sec   sr=%12.4g Hz',dt,sr);
disp(out5)
disp(' ')
out5 = sprintf(' df=%12.4g Hz',df);
disp(out5)
%
%*** choose frequency 	
%	
disp(' ');
disp(' Enter frequency (Hz) of interest ');
fin = input(' ');
%
octave = (2.^(1./3.));
flow  = fin/octave;
fhigh = fin*octave;
%
%***  Choose Zoom Factor
%
disp(' ');
disp(' Choose Zoom Factor ');
disp(' 1 =  1:1 ');
disp(' 2 =  2:1 ');
disp(' 3 =  4:1 ');
disp(' 4 =  8:1 ');
disp(' 5 = 16:1 ');
%
iz=input(' ');
%
if(iz>5)
    iz=5;
end    
%
if(iz==1)
	nz=1;
end
if(iz==2)
    nz=2;
end
if(iz==3)
    nz=4;
end
if(iz==4)
    nz=8;
end
if(iz==5)
    nz=16;
end
%
%***** Choose filter option  (next version)
%
%disp(' ');
%disp(' Bandpass filter the data prior to zoom FFT (recommended) ?');
%disp(' 1=yes  2=no ');
%
%i_filter_choice=input(' ');
%
%if(i_filter_choice ==1)
%
%   put in filter
%           
%end
%
%    FFT
%
disp(' ')
disp(' begin FFT ')
disp(' ')
%
clear Y;
clear complex_FFT;
Y=zeros(N,1);
complex_FFT=zeros(N,3);
%
ia=1;
MM=N;
N=fix(N/nz);
ja=1;
for( ikj = 1:nz)
    nk = ikj;
    jb=ja+MM-1;
    ampf=zeros(1,MM);
%
    ampf=amp(nk:nz:MM);
 % 
   Y(ja:jb)=fft(ampf,MM);
   ja=jb+1;
end
%
NT=length(Y);
FF=linspace(0,df*NT,NT);
complex_FFT = zeros(NT,3);
complex_FFT(:,1)=FF';
complex_FFT(:,2)=real(Y);
complex_FFT(:,3)=imag(Y);    
%
nntt = fix(nsegment/nz);
%
%  accumulator
%
disp(' accumulator ');
%
maxf = max(FF);
%
if( NT > MAX )
    disp(' Error: too many data points. ');
    disp(' Press any key to exit.       ');
end
%
nmax=NT;
%
if( maxf < flow )
    disp('\n Frequency error. Greater bandwidth needed. \n');
    disp('\n Press any key to continue. \n');
	input(' ');
end
%
dfz=df/nz;
nm= fix(NT/nz);
%
if(nz==1)
%
    cr = complex_FFT(:,2);
    ci = complex_FFT(:,3); 
    z=sqrt(cr.*cr+ci.*ci);
    freq=FF;
%
else
%   
    for(i=1:nm)
%    
        cr=0.;
        ci=0.;
        for(j=0:(nz-1))
            cr=cr + complex_FFT(i+j*nm,2) ; 
            ci=ci + complex_FFT(i+j*nm,3) ;
        end
%
        z(i)=sqrt(cr^2+ci^2);
        freq(i)=i*dfz;
    end
end
%
%   Output
%
ny=fix(length(z)/2);
zoom=2.*z(1:ny);
freqz=freq(1:ny);
zoom(1)=zoom(1)/2.;
plot(freqz,zoom);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
out5 = sprintf(' ZOOM FFT  %d:1 ',nz);
title(out5);
grid;
fmin=fin/2.^(1./6.);
fmax=fin*2.^(1./6.);
ymin=0.;
ymax=max(zoom)*1.2;
axis([fmin,fmax,ymin,ymax]);