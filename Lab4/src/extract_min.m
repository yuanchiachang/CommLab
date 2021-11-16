function [min_element ,rest_array] = extract_min(all_array)
    all_array_transpose = transpose(all_array);
    sort_array_transpose = sortrows(all_array_transpose,2);
    all_array = transpose(sort_array_transpose);
    n = width(all_array);
    min_element = all_array(:,1);
    if n > 2
        rest_array = all_array(:,2:n);
    elseif n == 2
        rest_array = all_array(:,2);
    else
        rest_array = [];
    end
    
end