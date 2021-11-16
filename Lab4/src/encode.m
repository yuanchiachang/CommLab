function dict = encode(dict,idx)
    if cell2mat(dict(idx,3))>0
        left_index = cell2mat(dict(idx,3));
        right_index = cell2mat(dict(idx,4));
        if cell2mat(dict(idx,5)) > 0
            %disp(num2str(cell2mat(dict(idx,5))));
            dict(left_index,5) = cellstr(strcat( num2str(cell2mat((dict(idx,5)))),'0'));
        else
            dict(left_index,5) = cellstr('0');
        end
        
        if cell2mat(dict(idx,5)) > 0
            dict(right_index,5) = cellstr(strcat(num2str(cell2mat((dict(idx,5)))),'1'));
        else
            dict(right_index,5) = cellstr('1');
        end
        dict = encode(dict,left_index);
        dict = encode(dict,right_index);
    end
end