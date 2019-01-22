function encodedStream = runLengthEncoder(stream)
% this function does zero run length encoding on any stream
temp = zeros(length(stream), 1);
j = 1;
for i = 1 : length(stream)
    if stream(i) ~= 0
        if temp(j) == 0
            temp(j) = stream(i);
            j = j + 1;
        else
            j = j + 1;
            temp(j) = stream(i);
            j = j + 1;
        end
    else
        if temp(j) == 0
            j = j + 1;
            temp(j) = temp(j) + 1;
        else
            if temp(j) < 255
                temp(j) = temp(j) + 1;
            else
                j = j + 2;
                temp(j) = temp(j) + 1;
            end
        end
    end
    encodedStream = zeros(j, 1);
    for g = 1 : j
        encodedStream(g) = temp(g);
    end
end
