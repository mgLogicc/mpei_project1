function shingles = generateShingles(new,k)
    %
    %
    %   Inputs : 
    %   - new : string with new content
    %   - k : length of shingles
    %

    words = strsplit(new);

    numShingles = length(words) - k + 1;
    
    if numShingles < 1
        shingles = {};
        return;
    end

    shingles = cell(numShingles,1);

    for i = 1:numShingles
        shingle = string(new(i:i+k-1));
        shingles{i} = char(shingle);
    end
    
    shingles = unique(shingles);
end