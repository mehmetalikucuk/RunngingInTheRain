function [Object] = f_Movement2D(Object, Space, plottingFlag)
% Bu fonksiyon girdi olarak verilen nesnenin konumunu değiştiri ve 
% görselleştirir.
% Girdiler -------
% Object          : Nesnenin bilgilerini içeren structure
% Object.movement : Nesnenin x eksenindeki hareket vektörü
% Object.position : Nesnenin konumu
% Object.edges    : Nesnenin sınırları
% Space           : Nesnenin hareket ettiği uzayın bilgileri
% Space.size      : Uzayın boyutları
% prottingFlag    : Görselleştirme bayrağı
% Çıktılar -------
% Object          : Nesnenin güncellenmiş bilgileri
% Object.position : Nesnenin güncellenmiş konumu
% Object.edges    : Nesnenin güncellenmiş sınırları
% ----------------
    
    % Nesnenin hareketi
    Object.position(1) = Object.position(1) + Object.movement;
    
    % Nesnenin sınırları
    Object.edges = [Object.position(1)-Object.size(1)/2,...
                    Object.position(1)+Object.size(1)/2;
                    Object.position(2)-Object.size(2)/2,...
                    Object.position(2)+Object.size(2)/2];
    
    % Görselleştirme için oluşturulan değişkenler
    Draw.x = [Object.edges(1,1), Object.edges(1,2), Object.edges(1,2), ...
              Object.edges(1,1), Object.edges(1,1)];
    Draw.y = [Object.edges(2,1), Object.edges(2,1), Object.edges(2,2), ...
              Object.edges(2,2), Object.edges(2,1)];
    
    % Nesnenin görselleştirilmesi
    if plottingFlag == true
        plot(Draw.x, Draw.y, 'Black', "LineWidth", 1);
        xlim([0, Space.size(1)]); ylim([0, Space.size(2)]);
        xlabel("X [m]"); ylabel("Y [m]");
    end
end

