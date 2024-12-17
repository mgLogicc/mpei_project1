function signature = minhashSignatures(shingles, numHash, p, R)
    %   This function returns the signatures of the shingles passed in
    % 
    %   Inputs:
    %   - shingles :
    %   - numHash : 
    %   - p : 
    %   - R : 
    %
    %   Output:
    %   signature:

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