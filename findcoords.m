function [lonidx,latidx] = findcoords(lon_in,lat_in,filetype,file)
% 
% [lonidx,latidx] = findcoords(lon_in,lat_in,filetype,file)
%
% This function finds the longitude and latitude indices given input
% longitude (0 to 360) and latitude (-90 to 90) data.  
%
% Currently, this script supports two filetypes:
%   1) filetype = 1: "netCDF" .nc file with 'lat' and 'lon' fields. The file
%                 variable is the full path to the .nc file.
%   2) filetype = 2: "cellarray" the file variable is a cell array where the 
%                 first array is Lon and the second array is Lat
%
% The indices are rounded UP to the nearest integer.

% Last modified: 6/7/2019

% ###################################################################### %
% Read in longitude and latitude indices from the netCDF file
switch filetype
    case 1
        lon_ori = ncread(file,'lon');
        lat_ori = ncread(file,'lat');
    case 2
        lon_ori = file{1};
        lat_ori = file{2};
end
    
    
% If longitude is negative (degrees West), convert to degrees East (0-360).
if lon_in < 0
    lon_in = 360 + lon_in;
end

for i = 1:length(lon_ori)
    if lon_ori(i) < 0
       lon_ori(i) = lon_ori(i)+360;
    end
end
       
% Find nearest indices by using the minimum function.  The index containing
% the point where the absolute value of the difference between the desired
% and available points is minimum will be selected.
[a,lonidx] = min(abs(lon_ori-lon_in));
[a,latidx] = min(abs(lat_ori-lat_in));

% Print result
fprintf(['The closest Longitude to ',num2str(lon_in),' was ',...
    num2str(lon_ori(lonidx)),'\n The closest Latitude to ',num2str(lat_in),...
    ' was ',num2str(lat_ori(latidx)),' \n'])
end