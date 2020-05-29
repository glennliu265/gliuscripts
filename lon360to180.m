function [lon_new,var_new] = lon360to180(lon,var)

% [lon_new,var_new]= lon360to180(lon,var)
% Remaps Longitude and input variable from 0-360 to -180-180.
% Based on excerpt from Young-Oh's EOF_ENSO.m script.   
% Nov 2019 G. Liu
     %% Find western/eastern longitudes
     lon = squeeze(lon);
     
     kxw=find(lon<180);
     kxe=find(lon>=180);

     % Concatenate western and eastern longitudes
     if size(lon,1) == 1
         lon_new=cat(2,lon(kxe)-360,lon(kxw));
     else
        lon_new=cat(1,lon(kxe)-360,lon(kxw));
     end
     
     %% Permute the input variable to find the longitude dim
     sv = size(var);                  % Get dim sizes of variable
     poslon = find(sv==length(lon));  % Get Longitude Position
     if poslon == 1
         beforelon = 1;
     else
        beforelon = 1:poslon-1;
     end
     afterlon  = poslon+1:length(sv);
     
     % Permute if lon is not first dim
     if poslon ~= 1
         % Get new order and size of dimensions
         ndimord = [poslon beforelon afterlon];
         ndimsz  = [sv(poslon) sv(beforelon) sv(afterlon)];
         
         % Set order to re-permute back to original order
         odimord = [1+beforelon 1 afterlon];
         
         % Move lon to first dim.
         var_per = permute(var,ndimord);
     
     else
         % Get array of sizes
         ndimsz  = [sv(poslon) sv(poslon+1:end)];         
         var_per = var;
     end
     
     % Concatenate eastern and western values
     var_new = cat(1,var_per(kxe,:),var_per(kxw,:));    
     var_new = reshape(var_new,ndimsz);
     
     % Reorder variables if lon was not first dim.
     if poslon ~= 1      
         var_new = permute(var_new,odimord);
     end
end