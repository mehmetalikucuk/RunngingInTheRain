clear; clc; close all;

%% Parametreler
% Hareket uzayı
Space.size = [10, 2, 3];  % Uzay boyutları [m]

% Zaman uzayı
Time.dt = 1e-2;        % Örnekleme periyodu [sn]
Time.tmax = 1;         % Simülasyon süresi [sn]
Time.axis = 0:Time.dt:Time.tmax; % Zaman uzayı [sn]

% Yağmur parametreleri
Rain.velocity = 10;     % Yağmur damlalarının hızı [m/sn]
Rain.angle = [0, 0]*pi/180; % Yağış açısı [rad]
Rain.intensity = 44;    % Yağış miktarı [mm = kg/m^2]
% Yağış miktarı
% Hafif Yağış         1- 5 mm
% Orta Kuvvette Yağış 6- 20 mm
% Kuvvetli Yağış      21- 50 mm
% Çok Kuvvetli Yağış  51- 75 mm
% Şiddetli Yağış      76-100 mm
% Aşırı Yağış         100 mm üzeri
% Not: 12 Saatlik periyotta miktara bağlı değerlendirme yapılmıştır.
% Kaynak Meteoroloji Genel Müdürlüğü
% https://www.mgm.gov.tr/site/yardim1.aspx?=HadSid

% Yağmur damlalarının bilgileri
Drop.weight = 0.05e-3; % Bir damlanın ağırlığı [kg]
% Birim zamanda üretilecek damla sayısı
Drop.ngen = ((Rain.intensity*Space.size(1)*Space.size(2))/Drop.weight)*...
            (Time.dt/(12*60*60));
Drop.dp = 0; % Üretilecek damla sayısının virgülden sonraki bölümü
% Damlaların hareket vektörü
Drop.movement = [tan(Rain.angle(1)), tan(Rain.angle(2)), 1]*...
                (Rain.velocity*Time.dt);
% Damlaların konumları
Drop.positions = [Space.size(1)*rand(120, 1),...
                  Space.size(2)*rand(120, 1),...
                  Space.size(3)*rand(120, 1)];

% Nesnenin bilgileri
Object.size = [0.28, 0.42 1.75]; % Nesnenin boyutları [m]
Object.velocity = 5;             % Nesnenin hareket hızı [m/sn]
Object.movement = Object.velocity*Time.dt;  % İnsanın hareket vektörü
Object.position = [1, 1, Object.size(3)/2]; % Nesnenin başlangıç konumu [m]
% Nesnenin sınırları
Object.edges = [Object.position(1)-Object.size(1)/2,...
                Object.position(1)+Object.size(1)/2;
                Object.position(2)-Object.size(2)/2,...
                Object.position(2)+Object.size(2)/2;
                Object.position(3)-Object.size(3)/2,...
                Object.position(3)+Object.size(3)/2];

% Görselleştirme bayrağı
plottingFlag = true;
if plottingFlag == true
    f1 = figure;
    scatter3(0, 0, 0, "Marker", "none");
    xlim([0, Space.size(1)]); 
    ylim([0, Space.size(2)]);
    zlim([0, Space.size(3)]);
    view(32, 20); grid on;
    xlabel("X [m]"); ylabel("Y [m]"); zlabel("Z [m]");
    gifFile = 'RunningInTheRain3D.gif';
    exportgraphics(f1, gifFile);
end

%% Yağmur Altında Koşma Simülasyonu

DropCounter = 0;

% Zaman döngüsü
for i = 1:length(Time.axis)

    % Yağmur damlalarının üretimi ve hareketi
    Drop = f_Rainfall3D(Drop, Space, plottingFlag); hold on;
    
    % Nesnenin hareketi
    Object = f_Movement3D(Object, Space, plottingFlag); hold off;

    % Cisme temas eden damlaların sayılması
    [Drop, Counter] = f_DropCounter3D(Drop, Object);

    DropCounter = DropCounter + Counter;
    
    % Görselleştirme
    if plottingFlag
        exportgraphics(f1, gifFile, Append=true);
        drawnow;
        pause(Time.dt);
    end
end

