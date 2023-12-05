clear; clc; close all;

%% Parametreler
% Hareket uzayı
Space.size = [20, 2, 3];  % Uzay boyutları [m]

% Zaman uzayı
Time.dt = 1e-2;        % Örnekleme periyodu [sn]
Time.tmax = 5;         % Simülasyon süresi [sn]
Time.axis = 0:Time.dt:Time.tmax; % Zaman uzayı [sn]

% Yağmur parametreleri
Rain.velocity = 10;     % Yağmur damlalarının hızı [m/sn]
Rain.angle = [20, 10]*pi/180; % Yağış açısı [rad]
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
% Damlaların hareket vektörü
Drop.movement = [tan(Rain.angle(1)), tan(Rain.angle(2)), 1]*...
                (Rain.velocity*Time.dt);
% Damlaların konumları
Drop.positions = [];

% Görselleştirme bayrağı
plottingFlag = true;
if plottingFlag == true
    f1 = figure;
    scatter3(0, 0, 0, "Marker", "none");
    xlim([0, Space.size(1)]); 
    ylim([0, Space.size(2)]);
    zlim([0, Space.size(3)]);
    view(32, 20);
    xlabel("X [m]"); ylabel("Y [m]"); zlabel("Z [m]");
    gifFile = 'Yagmur3D.gif';
    exportgraphics(f1, gifFile);
end


%% Yağmur Simülasyonu

% Zaman döngüsü
for i = 1:length(Time.axis)
    
    % Yağmur damlalarının üretimi ve hareketi
    Drop = f_Rainfall(Drop, Space, plottingFlag);
    
    % Görselleştirme
    if plottingFlag
        exportgraphics(f1, gifFile, Append=true);
        drawnow;
        pause(Time.dt);
    end
end


%% Fonksiyonlar

function [Drop] = f_Rainfall(Drop, Space, plottingFlag)
% Bu fonksiyon yağmur damlalarını üretir, hareket ettirir ve 
% görselleştirir.
% Girdiler ----
% Drop         : Damlaların bilgilerini içeren structure 
% Space        : Yağmurun yağdığı uzayın bilgileri
% prottingFlag : Görselleştirme bayrağı
% Çıktılar ----
% Drop         : Damlaların güncellenmiş bilgileri
% -------------
    
    % Damlaların üretimi
    Drop.positions = [Drop.positions;
                     Space.size(1)*rand(round(Drop.ngen), 1), ...
                     Space.size(2)*rand(round(Drop.ngen), 1), ...
                     Space.size(3)*ones(round(Drop.ngen), 1)];
    
    % Damlaların hareketi
    Drop.positions(:, 1) = Drop.positions(:, 1) + Drop.movement(1);
    Drop.positions(:, 2) = Drop.positions(:, 2) + Drop.movement(2);
    Drop.positions(:, 3) = Drop.positions(:, 3) - Drop.movement(3);
    
    % Yere çarpan damlaların silinmesi
    Drop.positions(Drop.positions(:,3)<0, :) = [];
    
    % Damlaların görselleştirilmesi
    if plottingFlag == true 
        scatter3(Drop.positions(:, 1), Drop.positions(:, 2), ...
                 Drop.positions(:, 3), "Blue", "Marker", ".");
        xlim([0, Space.size(1)]); 
        ylim([0, Space.size(2)]);
        zlim([0, Space.size(3)]);
        view(32, 20);
        xlabel("X [m]"); ylabel("Y [m]"); zlabel("Z [m]");
    end
end

