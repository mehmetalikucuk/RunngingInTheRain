clear; clc; close all;

%% Parametreler
% Hareket uzayı
Space.size = [20, 3];  % Uzay boyutları [m]

% Zaman uzayı
Time.dt = 1e-3;        % Örnekleme periyodu [sn]
Time.tmax = 5;         % Simülasyon süresi [sn]
Time.axis = 0:Time.dt:Time.tmax; % Zaman uzayı [sn]

% Yağmur parametreleri
Rain.velocity = 10;     % Yağmur damlalarının hızı [m/sn]
Rain.angle = 20*pi/180; % Yağış açısı [rad]
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
Drop.ngen  = ((Rain.intensity*Space.size(1))/Drop.weight)*...
             (Time.dt/(12*60*60));
Drop.dp = 0; % Üretilecek damla sayısının virgülden sonraki bölümü
% Damlaların hareket vektörü
Drop.movement = [tan(Rain.angle), 1]*(Rain.velocity*Time.dt);
% Damlaların konumları
Drop.positions = [];

% Görselleştirme bayrağı
plottingFlag = true;
if plottingFlag == true
    f1 = figure;
    xlim([0, Space.size(1)]); ylim([0, Space.size(2)]);
    xlabel("X [m]"); ylabel("Y [m]");
    gifFile = 'Yagmur2D.gif';
    % exportgraphics(f1, gifFile);
end


%% Yağmur Simülasyonu

% Zaman döngüsü
for i = 1:length(Time.axis)
    
    % Yağmur damlalarının üretimi ve hareketi
    Drop = f_Rainfall2D(Drop, Space, plottingFlag);
    
    % Görselleştirme
    if plottingFlag
        % exportgraphics(f1, gifFile, Append=true);
        drawnow;
        pause(Time.dt);
    end
end

