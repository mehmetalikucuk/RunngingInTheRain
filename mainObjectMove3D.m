clear; clc; close all;

%% Parametreler
% Hareket uzayı
Space.size = [10, 2, 3];  % Uzay boyutları [m]

% Zaman uzayı
Time.dt = 1e-2;        % Örnekleme periyodu [sn]
Time.tmax = 1;         % Simülasyon süresi [sn]
Time.axis = 0:Time.dt:Time.tmax; % Zaman uzayı [sn]

% Nesnenin bilgileri
Object.size = [0.28, 0.42 1.75]; % Nesnenin boyutları [m]
Object.velocity = 5;             % Nesnenin hareket hızı [m/sn]
Object.movement = Object.velocity*Time.dt;  % Nesnenin hareket vektörü
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
    gifFile = 'Nesne3D.gif';
    exportgraphics(f1, gifFile);
end


%% Nesnenin Hareket Simülasyonu

% Zaman döngüsü
for i = 1:length(Time.axis)

    % Nesnenin hareketi
    Object = f_Movement3D(Object, Space, plottingFlag);
    
    % Görselleştirme
    if plottingFlag
        exportgraphics(f1, gifFile, Append=true);
        drawnow;
        pause(Time.dt);
    end
end

