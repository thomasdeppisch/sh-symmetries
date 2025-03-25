function Yr = convertComplexToRealShs(Yc)

    N = sqrt(size(Yc,2)) - 1;
    nm2acn = @(n_,m_) n_^2 + m_ + n_ + 1;
    Yr = zeros(size(Yc));
    for nn = 0:N
        for mm = -nn:nn
            if (mm < 0)
                % Yr(:,nm2acn(nn,mm)) = (-1)^mm * sqrt(2) * imag(Yc(:,nm2acn(nn,-mm)));
                Yr(:,nm2acn(nn,mm)) = 1i / sqrt(2) * (Yc(:,nm2acn(nn,mm)) - (-1)^mm * Yc(:,nm2acn(nn,-mm)));
            elseif (mm == 0)
                Yr(:,nm2acn(nn,mm)) = real(Yc(:,nm2acn(nn,mm)));
            else
                % Yr(:,nm2acn(nn,mm)) = (-1)^mm * sqrt(2) * real(Yc(:,nm2acn(nn,mm)));
                Yr(:,nm2acn(nn,mm)) = 1 / sqrt(2) * ((-1)^mm * Yc(:,nm2acn(nn,mm)) + Yc(:,nm2acn(nn,-mm)));
            end
        end
    end
    
end