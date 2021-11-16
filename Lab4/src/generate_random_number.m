function random_seq = generate_random_number(symbols, prob, n)
    % symbols: the symbols 
    % prob: the corresponding probability of symbols
    % n: the number of symbols in the sequence

    % function's body starts here
    random_seq = [];
    for i = 2:length(prob)
        prob(i) = prob(i) + prob(i-1);
    end
    for i = 1:n
        x = rand;
        j = 1;
        while(x > prob(j))
            j = j + 1;
        end
        random_seq = strcat(random_seq,cell2mat(symbols(j)));
    end
        
            
        

end