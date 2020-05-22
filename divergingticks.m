function [ticknum,ticklab] = divergingticks(clims,clevels,interval)

    %{
    [ticknum,ticklab] = divergingtick(clims,clevels,interval)
    
    % Function to generate centered labels and tick locations for diverging 
    colorbar
    
    Inputs:

    1) clims   : Array of color axis limits [min, max]
    2) clevels : Number of contour levels
    3) interval: Desired spacing for labeling

    Outputs

    1) ticknum: Tick locations
    2) ticklab: Tick labels
    %}


    % Calculate the actual color interval
    cmin = clims(1);
    cmax = clims(2);
    c_int = (cmax-cmin)/clevels;
    
    % Make Tick Labels
    ticklab = string([cmin:interval:cmax]);
    
    
    % Make array of tick locations
    ticknum = [cmin+c_int/2:c_int:cmax-c_int/2];
end

