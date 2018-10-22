
clear all;
close all;
[FileName1,PathName] = uigetfile('*.dat','Select the VISSIM network Results file');
T = importdata(FileName1);
[F C]=size(T);
for i=1:F
    clear data1 
    for ii=1:8
        if ii<=4
        data1(ii,:)=T(i,1:4);
        else
            data1(ii,:)=T(i,5:8);
        end
        
    end
    
    data_class={
        'g'   'r'   'r'  'r'
        'r'   'g'   'r'  'r'
        'r'   'r'   'g'  'r'
        'r'   'r'   'r'  'g'
        'g'   'r'   'r'  'r'
        'r'   'g'   'r'  'r'
        'r'   'r'   'g'  'r'
        'r'   'r'   'r'  'g'};
    data1(end+1,:)=NaN;
    figure(1);

    hold on
    for k=1:(size(data1,1)-1)
%        
        b1{k}=barh([k-1 k],data1([end k],:),'stacked');
%        
    end
    for k=1:(size(data1,1)-1)
        for k2=1:size(data1,2)
            switch data_class{k,k2}
                case 'g'
                    set(b1{k}(k2),'FaceColor','g')
                    
                case 'r'
                    set(b1{k}(k2),'FaceColor','r')
                    
            end
        end
    end
        xlabel('Tiempo[s]');
        ylabel('Intersecciones');
        title('Grafico Signal Time') ;
    
pause(2)
end