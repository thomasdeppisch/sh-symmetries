function Yc = convertRealToComplexShs(Yr)
    % Compared to conversions in literature, these ones have an additional
    % factor (-1)^m as the SHs are assumed to be implemented including the
    % Condon-shortley phase.

    N = sqrt(size(Yr,2)) - 1;
    nm2acn = @(n_,m_) n_^2 + m_ + n_ + 1;
    Yc = zeros(size(Yr));
    for nn = 0:N
        for mm = -nn:nn
            if (mm < 0)
                Yc(:,nm2acn(nn,mm)) = 1/sqrt(2) * (Yr(:,nm2acn(nn,-mm)) ...
                                      - 1i * Yr(:,nm2acn(nn,mm)));
            elseif (mm == 0)
                Yc(:,nm2acn(nn,mm)) = Yr(:,nm2acn(nn,mm));
            else
                Yc(:,nm2acn(nn,mm)) = (-1)^mm/sqrt(2) * (Yr(:,nm2acn(nn,mm)) ...
                                      + 1i * Yr(:,nm2acn(nn,-mm)));
            end
        end
    end
    
end