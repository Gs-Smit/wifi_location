function [PhsSlope, PhsCons, vna_response_corrected] = removePhsSlope(vna_response,M,SubCarrInd,N)
    useCvxgen = 0;
    if ~useCvxgen
        %angle( ) - 求复数相角，提取相位，unwrap( ) - 平移相位角
        PhsRelFirstPac = unwrap(angle(vna_response));
        
        %Below code is for when you are using phase relative to the first packet.
        for antIdForPhs = 1:M
            if  PhsRelFirstPac(1,antIdForPhs) - PhsRelFirstPac(1,1) > pi
                PhsRelFirstPac(:,antIdForPhs) = PhsRelFirstPac(:,antIdForPhs) - 2*pi;
            elseif PhsRelFirstPac(1,antIdForPhs) - PhsRelFirstPac(1,1) < -pi
                PhsRelFirstPac(:,antIdForPhs) = PhsRelFirstPac(:,antIdForPhs) + 2*pi;
            end
        end
        A = [repmat(SubCarrInd(:), M, 1) ones(N*M, 1)];
        x = A\PhsRelFirstPac(:);
        PhsSlope = x(1);
        PhsCons = x(2);
    else
        %% performing the same using cvxgen
        PhsRelFirstPac = unwrap(angle(vna_response));
        for antIdForPhs = 1:M
            if  PhsRelFirstPac(1,antIdForPhs) - PhsRelFirstPac(1,1) > pi
                PhsRelFirstPac(:,antIdForPhs) = PhsRelFirstPac(:,antIdForPhs) - 2*pi;
            elseif PhsRelFirstPac(1,antIdForPhs) - PhsRelFirstPac(1,1) < -pi
                PhsRelFirstPac(:,antIdForPhs) = PhsRelFirstPac(:,antIdForPhs) + 2*pi;
            end
        end
        % figure(201); plot(unwrap(angle(vna_response))); 
        params = struct;
        params.PhsRelFirstPacVec = PhsRelFirstPac(:);
        paramSlopeVecTmp = repmat(SubCarrInd(:),1,M);
        params.paramSlopeVec = paramSlopeVecTmp(:);
        params.paramConsVec = ones(N*M,1);
        settings = struct;
        settings.verbose = 0;
        [vars, status] = csolve(params, settings);
        PhsSlope = vars.PhsSlope;
        PhsCons = vars.PhsCons;
    end
%     ToMult = exp(1i* (-PhsSlope*repmat(SubCarrInd(:),1,M) - PhsCons*ones(N,M) ));
%     vna_response_corrected = vna_response.*ToMult;          
end