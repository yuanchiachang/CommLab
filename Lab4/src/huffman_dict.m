function dict = huffman_dict(symbols, prob)
    % huffman_dict: Create a huffman tree
    % symbols: the symbols 
    % prob the: corresponding probability of symbols

    % function's body starts here
    

    symbolsString = string(symbols);

    all_array = [symbolsString;prob];
    n = width(all_array);
    M = containers.Map(symbols,(1:n));
    dict = cell(2*n-1,5);
    for i = 1:(n)
        dict(i,1) = symbols(i);
        dict(i,2) = num2cell(prob(i));
    end
    for i = 1:(n-1)
        [min_element, all_array] = extract_min(all_array);
        [min2_element, all_array] = extract_min(all_array);
        newSymbol = min_element(1) + min2_element(1);
        newProb = str2double(min_element(2)) + str2double(min2_element(2));
        newVec = [newSymbol;newProb];
        all_array = [all_array newVec];
        dict(n+i,1) = cellstr(newSymbol);
        dict(n+i,2) = num2cell(newProb);
        dict(n+i,3) = num2cell(M(min_element(1)));
        dict(n+i,4) = num2cell(M(min2_element(1)));
        M(newSymbol) = n+i;
    end
    dict_height = height(dict);
    dict(dict_height,5) = cellstr('');
    dict = encode(dict,dict_height);
    disp(dict);
end