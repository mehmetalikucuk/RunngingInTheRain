function [Drop] = f_Rainfall2D(Drop, Space, plottingFlag)
% Bu fonksiyon yağmur damlalarını üretir, hareket ettirir ve 
% görselleştirir.
% Girdiler ------
% Drop           : Damlaların bilgilerini içeren structure 
% Drop.ngen      :
% Drop.dp        : 
% Drop.movement  :
% Drop.positions : 
% Space          : Yağmurun yağdığı uzayın bilgileri
% Space.size     : 
% prottingFlag   : Görselleştirme bayrağı
% Çıktılar ------
% Drop           : Damlaların güncellenmiş bilgileri
% Drop.dp        :
% Drop.positions :
% ---------------
    
    % Üretilecek damla sayısının belirlenmesi
    ngen = Drop.ngen + Drop.dp;
    
    genDrop = floor(ngen);
    Drop.dp = ngen - genDrop;
    
    % Damlaların üretimi
    Drop.positions = [Drop.positions;
                      Space.size(1)*rand(genDrop, 1), ...
                      Space.size(2)*ones(genDrop, 1)];
    
    % Damlaların hareketi
    Drop.positions(:, 1) = Drop.positions(:, 1) + Drop.movement(1);
    Drop.positions(:, 2) = Drop.positions(:, 2) - Drop.movement(2);
    
    % Yere çarpan damlaların silinmesi
    Drop.positions(Drop.positions(:,2)<0, :) = [];
    
    % Damlaların görselleştirilmesi
    if plottingFlag == true 
        scatter(Drop.positions(:, 1), Drop.positions(:, 2), ...
                "Blue", "Marker", ".");
        xlim([0, Space.size(1)]); 
        ylim([0, Space.size(2)]);
        xlabel("X [m]"); ylabel("Y [m]");
    end

end

