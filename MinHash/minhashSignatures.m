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

    size = length(shingles);        % Number of shingles in the array
    signature = zeros(numHash,1);   % Initialize column vector to store signatures

    if isempty(shingles)            % If shingles is empty 
        return                      % exit
    end

    for hf = 1:numHash              % For each hash function
        
        hash_codes = zeros(1,size); % Initialize vector to store hash values

        for shingleIdx = 1:size     % For each shingle

            % Get current shingle
            shingle = shingles{shingleIdx};
        
            % Compute  the current shingle's hash code
            hash_codes(shingleIdx) = hash_function_shingles(shingle, hf, R, p);
            
        end
    
        % Take the minimum hash value 
        signature(hf) = min(hash_codes);
    end
end