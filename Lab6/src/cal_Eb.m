function E_b = cal_Eb(name,d,M)
    E_b = 0;
    if name == "PAM"
        E_b = d^2*(M^2-1)/12/log2(M);
    elseif name == "PSK"
        E_b = (d/2)^2/log2(M)/((sin(pi/M))^2);
    elseif name == "QAM"
        E_b = d^2*(M-1)/6/log2(M);
    end
end