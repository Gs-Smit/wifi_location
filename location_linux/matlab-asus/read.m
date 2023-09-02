function csi_buff_all = read(filename)
%% configuration
CHIP = '4366c0';        % wifi chip (possible values 4339, 4358, 43455c0, 4366c0)
BW = 20;        % bandwidth
NFFT = BW*3.2;      % fft size
HOFFSET = 16;       % header offset
NPKTS_MAX = 100000;     % max number of UDPs to process
csi_buff_all=[];


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
        continue;
    end
    
    payload = f.payload;

    H = payload(HOFFSET:HOFFSET+NFFT-1);
    Hout = unpack_float(int32(1), int32(NFFT), H);
    Hout = reshape(Hout,2,[]).';
    cmplx = double(Hout(1:NFFT,1))+1j*double(Hout(1:NFFT,2));
    csi_buff_all=[csi_buff_all;cmplx.'];
end

end
