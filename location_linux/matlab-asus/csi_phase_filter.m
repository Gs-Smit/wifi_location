function index=csi_phase_filter(csi_all)
    [m,~]=size(csi_all);
    csi_phase = angle(squeeze(csi_all));
    
    for i=1:m
        csi_phase(i,:)=unwrap(csi_phase(i,:));
    end
    
    csi_phase_gradient=gradient(csi_phase);
    
    for i=1:m
        gradient_var(i,1)=var(csi_phase_gradient(i,:));
    end
    
    csi=[];
    index=[];
    for i=1:m/3
        R=3*(i-1)+1:3*i;
        if all(gradient_var(R,1)<0.5)
            csi=[csi;csi_all(R,:)];
            index=[index;R];
        end
    end
end