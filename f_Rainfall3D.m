function [Drop] = f_Rainfall3D(Drop, Space, plottingFlag)
% Bu fonksiyon yağmur damlalarını üretir, hareket ettirir ve 
% görselleştirir.
% Girdiler ------
% Drop           : Damlaların bilgilerini içeren structure
% Drop.ngen      : Birim zamanda üretilecek damla sayısı
% Drop.dp        : Önceki zaman diliminden kalan damla sayısı
% Drop.movement  : Damlaların hareket vektörü
% Drop.positions : Damlaların konumları
% Space          : Yağmurun yağdığı uzayın bilgileri
% Space.size     : Uzayın boyutları
% prottingFlag   : Görselleştirme bayrağı
% Çıktılar ------
% Drop           : Damlaların güncellenmiş bilgileri
% Drop.dp        : Güncellenmiş kalan damla sayısı
% Drop.positions : Güncellenmiş damla konumları
% ---------------
    
    % Üretilecek damla sayısının belirlenmesi
    ngen = Drop.ngen + Drop.dp;
    
    genDrop = floor(ngen);
    Drop.dp = ngen - genDrop;

    % Damlaların üretimi
    Drop.positions = [Drop.positions;
                      Space.size(1)*rand(genDrop, 1), ...
                      Space.size(2)*rand(genDrop, 1), ...
                      Space.size(3)*ones(genDrop, 1)];
    
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

