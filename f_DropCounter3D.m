function [Drop, Counter] = f_DropCounter3D(Drop, Object)
% Bu fonksiyon cisme temas eden damlaları sayar ve bu damlaları siler
% Girdiler ------
% Drop           : Damlaların bilgilerini içeren structure
% Drop.positions : Damlaların konumları
% Object         : Nesnenin bilgilerini içeren structure
% Object.edges   : Nesnenin sınırları
% Çıktılar ------
% Drop           : Damlaların güncellenmiş bilgileri
% Drop.positions : Güncellenmiş damla konumları
% Counter        : Nesneye temas eden damla sayısı
% ---------------
    
    % Nesneye temas eden damlaların indislerinin belirlenmesi
    Indexes = Drop.positions(:,1)>=Object.edges(1,1) & ...
              Drop.positions(:,1)<Object.edges(1,2)  & ...
              Drop.positions(:,2)>=Object.edges(2,1) & ...
              Drop.positions(:,2)<Object.edges(2,2)  & ...
              Drop.positions(:,3)>=Object.edges(3,1) & ...
              Drop.positions(:,3)<Object.edges(3,2);
    
    % Temas eden damlaların sayısı
    Counter = sum(Indexes);
    
    % Temas eden damlaların silinmesi
    Drop.positions(Indexes, :) = [];
end

