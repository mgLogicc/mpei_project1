function signature = minhashSignatures(shingles, numHash, p, R)
    %       
    % 
    %
    %
    %
    %

    size = length(shingles);
    signature = zeros(numHash,1);

    if isempty(shingles)
        return
    end

    for hf = 1:numHash
        
        hash_codes = zeros(1,size);

        for shingleIdx = 1:size 

            shingle = shingles{shingleIdx};
        
            hash_codes(shingleIdx) = hash_function_shingles(shingle, hf, R, p);
            
        end

        signature(hf) = min(hash_codes);
    end

end