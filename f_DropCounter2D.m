function [Drop, Counter] = f_DropCounter2D(Drop, Object)
% Bu fonksiyon cisme temas eden damlaları sayar ve bu damlaları siler
% Girdiler ------
% Drop           :
% Drop.positions :
% Object         :
% Object.edges   :
% Çıktılar ------
% Drop           :
% Drop.positions :
% Counter        :
% ---------------
    
    % Nesneye temas eden damlaların indislerinin belirlenmesi
    Indexes = Drop.positions(:,1)>=Object.edges(1,1) & ...
              Drop.positions(:,1)<Object.edges(1,2)  & ...
              Drop.positions(:,2)>=Object.edges(2,1) & ...
              Drop.positions(:,2)<Object.edges(2,2);
    
    % Temas eden damlaların sayısı
    Counter = sum(Indexes);
    
    % Temas eden damlaların silinmesi
    Drop.positions(Indexes, :) = [];
    
end

