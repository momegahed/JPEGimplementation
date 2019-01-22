function originalStream = runLengthDecoder(incodedStream, originalLength)
% this function does zero run length encoding on any stream
    
    originalStream = zeros(1, originalLength);
    k = 1;
    flag = 0;
    for i = 1 : length(incodedStream)
        if flag == 1
            flag = 0;
            continue
        end
        if incodedStream(i) == 0
            flag = 1;
            for f = 1 : incodedStream(i+1)
                originalStream(k) = 0;
                k = k + 1;
            end
        else
            originalStream(k) = incodedStream(i);
            k = k + 1;
        end
    end