function [outputArg] = cross_border_processing(inputArg,border, axios, CMD)
outputArg = inputArg;
if outputArg > border
    outputArg = border - 1 + rand();
end
if outputArg < 0
    outputArg = rand();
end
if strcmp(axios, 'x')
    if contains(CMD, 'l')
        if outputArg > 0.6 * border
            outputArg = 0.15 * border + 0.45 * border * rand();
        end
    elseif contains(CMD, 'r')
        if outputArg < 0.4 * border
            outputArg = 0.35 * border + 0.45 * border * rand();
        end
    elseif contains(CMD, 'c')
        if outputArg < 0.2 * border || outputArg > 0.8 * border
            outputArg = 0.35 * border + 0.3 * border * rand();
        end
    end
elseif strcmp(axios, 'y')
    if contains(CMD, 'u')
        if outputArg < 0.4 * border
            outputArg = 0.35 * border  + 0.45 * border * rand();
        end
    elseif contains(CMD, 'd')
        if outputArg > 0.6 * border
            outputArg = 0.15 * border + 0.45 * border * rand();
        end
    elseif contains(CMD, 'c')
        if outputArg < 0.2 * border || outputArg > 0.8 * border
            outputArg = 0.35 * border + 0.3 * border * rand();
        end
    end
end
end