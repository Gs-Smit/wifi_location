function [cmd] = setCMD(name)
cmd = '';
if contains(name, 'cc')
    cmd = 'cc';
elseif contains(name, 'lu')
    cmd = 'lu';
elseif contains(name, 'ld')
    cmd = 'ld';
elseif contains(name, 'ru')
    cmd = 'ru';
elseif contains(name, 'rd')
    cmd = 'rd';
end
end

