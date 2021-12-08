function SER = cal_ser(bin_seq, bin_seq_second, slice)
    reshape_bin_seq = reshape(bin_seq,[length(bin_seq)/slice,slice]);
    reshape_bin_seq_second = reshape(bin_seq_second,[length(bin_seq_second)/slice,slice]);
    count = 0;
    for i = 1:height(reshape_bin_seq)
        sum_xor = sum(xor(reshape_bin_seq(i,:),reshape_bin_seq_second(i,:)));
        if sum_xor ~= 0
            count = count + 1;
        end
    end
    SER = count / height(reshape_bin_seq);
end