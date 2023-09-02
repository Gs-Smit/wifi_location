function csi_buff_all = read_file(filename)
%% csireader.m
% read and plot CSI from UDPs created using the nexmon CSI extractor (nexmon.org/csi)
% modify the configuration section to your needs


%% configuration
CHIP = '4366c0';        % wifi chip (possible values 4339, 4358, 43455c0, 4366c0)
BW = 20;        % bandwidth
NFFT = BW*3.2;      % fft size
HOFFSET = 16;       % header offset
NPKTS_MAX = 100000;     % max number of UDPs to process
csi_buff_4 = complex(zeros(4,NFFT),0);
csi_buff_all=[];
ant_code_idx=0;


%% read file
p = readpcap();
p.open(filename);
n = min(length(p.all()),NPKTS_MAX);
p.from_start();
% ant_code_buff=nan(n,4);

for i=1:n
    f = p.next();
    if isempty(f)
        disp('no more frames');
        break;
    end
    if f.header.orig_len-(HOFFSET-1)*4 ~= NFFT*4
        disp('skipped frame with incorrect size');
        csi_buff_4 = complex(zeros(4,NFFT),0);
        ant_code_idx=0;
        continue;
    end
    
    payload = f.payload;

    ant_code=bitshift(payload(14),-16);
    ant_code = bitshift(ant_code,-8);
    if ant_code~=ant_code_idx
        disp('skipped frame with incorrect ant_code');
        csi_buff_4 = complex(zeros(4,NFFT),0);
        ant_code_idx=0;
        if ant_code~=0
            continue
        end
    end

    H = payload(HOFFSET:HOFFSET+NFFT-1);
    Hout = unpack_float(int32(1), int32(NFFT), H);
    Hout = reshape(Hout,2,[]).';
    cmplx = double(Hout(1:NFFT,1))+1j*double(Hout(1:NFFT,2));
    csi_buff_4(ant_code+1,:)=cmplx.'; 
    if ant_code==3
        csi_buff_all=[csi_buff_all;csi_buff_4(1,:);csi_buff_4(4,:);csi_buff_4(2,:)];
        csi_buff_4 = complex(zeros(4,NFFT),0);
    end
    ant_code_idx=mod(ant_code_idx+1,4);
end



