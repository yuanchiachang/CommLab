function gray_code_mat = generate_gray_code(length)
    gray_code_mat = zeros(2^length,length);
    for i = 1:length
        gray_code_mat(1,i) = 0;
    end
    for i = 2:2^length 
        if ~mod(i,2)
            seq = zeros(1,length);
            seq(1,length) = 1;
            gray_code_mat(i,:) = xor(gray_code_mat(i-1,:),seq);
        else
            for j = length:-1:1
                if gray_code_mat(i-1,j) == 1
                    seq = zeros(1,length);
                    seq(1,j-1) = 1;
                    gray_code_mat(i,:) = xor(gray_code_mat(i-1,:),seq);
                    break;
                end
            end
        end
    end
end