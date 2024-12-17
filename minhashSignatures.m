function signature = minhashSignatures(shingles, numHash, p, R)
    %   This function returns the signatures of the shingles passed in
    % 
    %   Inputs:
    %   - shingles : cell array of shingles of a new
    %   - numHash : number of hash functions
    %   - R : matrix where each line represents a different hash function
    %   - p : a prime number used has divisor in the mod operation
    %
    %   Output:
    %   signature: signature vector of the shingles

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