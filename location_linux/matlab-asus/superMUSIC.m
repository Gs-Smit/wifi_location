function AOATOF=superMUSIC(csi_all)
    %% 参数设置 
    SubCarrInd=-128:1:127; % 80MHz�?256个子载波
%     SubCarrInd_real=[-112:3:-11,11:3:112]; % 80MHz的有效子载波
    SubCarrInd_real=[-26:1:-4,4:1:26]; % 80MHz的有效子载波
%     SubCarrInd_real=[-58,-54,-50,-46,-42,-38,-34,-30,-26,-22,-18,-14,-10,-6,-2,2,6,10,14,18,22,26,30,34,38,42,46,50,54,58];
    T = 1; % 发射天线�?
%     fc = 5.765e9; % channel 153 中心频率
    fc = 2.412e9; % channel 153 中心频率
    M = 3; % 接收(Rx)天线�?
    N = length(SubCarrInd); % 子载波数�?256
    N_real=length(SubCarrInd_real); % 有效子载�?242
    c = 299792458;  % 光�?�c
    fgap = 312.5e3; % WiFi中连续子载波之间频率间隔，单位Hz
%     d = 2.60019e-2;  % 线�?�天线阵列中相邻天线之间的距离�?��?�中心频率的半波长，单位cm
    d = 7.8e-2;
    paramRange.GridPts = [101 101 1]; % 格式中的网格点数[ToF的网格点数，AoA的网格点数，1] 
    paramRange.delayRange = [-1000 1000]*1e-9; % ToF网格要�?�虑的最低和�?高�??
    paramRange.angleRange = 45*[-1 1]; % AoA网格的最低�?�和要�?�虑的�??
    paramRange.K = floor(M/2)+1; % 平滑参数
    % 平滑参数用于构建平滑矩阵，故使用有效子载波数�?
    paramRange.L = floor(N_real/2); % 平滑参数
    paramRange.T = 1;
    paramRange.deltaRange = [0 0];
    paramRange.generateAtot = 2;
    maxRapIters = Inf;
    useNoise = 0;
    do_second_iter = 0;
    
    %% MUSIC算法
    [csi_len,~]=size(csi_all);
    LEN = csi_len/M;
    k=0;
    count=0;
    for i =1:LEN
        RANGE=(i-1)*M+1:i*M;
        csi_i = csi_all(RANGE,:);
%         csi_i = fftshift(csi_i,2);    % fftshift
    %     STO消除算法
        csi_plot=csi_i;
        SubCarrInd=SubCarrInd_real+33;
        csi_plot = csi_plot(:,SubCarrInd);
        
        
%         figure(41)
%         for kk = 1:3
%             csi_phase1 = unwrap(angle(squeeze(csi_plot(kk,:))));
%             hold on
%             plot(1:1:46,csi_phase1);
%         end
%         
        
        [M,N]=size(csi_plot);
        csi_plot=csi_plot.';
        [PhsSlope, PhsCons] = removePhsSlope(csi_plot,M,SubCarrInd_real,N);
        ToMult = exp(1i* (-PhsSlope*repmat(SubCarrInd_real(:),1,M) - PhsCons*ones(N,M)));
        
        csi_plot = csi_plot.*ToMult;
        relChannel_noSlope = reshape(csi_plot, N, M, T);
        sample_csi_trace_sanitized = relChannel_noSlope(:);
        
        
        
       
        csi_plot = csi_plot.';
%         figure(42)
%          for kk = 1:3
%              
%             csi_phase2 = unwrap(angle(squeeze(csi_plot(kk,:))));
%             hold on
%             plot(1:1:46,csi_phase2);
%         end
    
        % MUSIC算法估计AOA与TOF\
        aoaEstimateMatrix = backscatterEstimationMusic(sample_csi_trace_sanitized, M, N, c, fc, ...
            T, fgap, SubCarrInd, d, paramRange, maxRapIters, useNoise, do_second_iter, ones(2));
        tofEstimate = aoaEstimateMatrix(:,1); % 第一列是ToF，单位：ns
        aoaEstomate = aoaEstimateMatrix(:,2); % 第二列是AoA，单位：°
        if length(unique(aoaEstomate))==1
            count=count+1;
        end
        %% get AOATOF
        lenaoa=length(aoaEstomate);
        for j=1:lenaoa
            AOATOF(k+j,1)=i;
            AOATOF(k+j,2)=tofEstimate(j);
            AOATOF(k+j,3)=aoaEstomate(j);
        end
        [k,~]=size(AOATOF);
        %% get AOA of min TOF
%         AOATOF_mintof=getAOAofMinTOF(AOATOF);
    end
end