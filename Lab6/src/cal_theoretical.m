function theoretical_bound = cal_theoretical(name, M, ratio)
    if name == "PAM"
        theoretical_bound = 2 .* qfunc(sqrt(6*log2(M)/(M^2-1).*ratio));
    elseif name == "PSK"
        theoretical_bound = 2 .* qfunc(sqrt(2 * log2(M) * (sin(pi/M))^2 .* ratio));
    elseif name == "QAM"
        theoretical_bound = 4 .* qfunc(sqrt(3*log2(M)/(M-1).*ratio));
    end
end