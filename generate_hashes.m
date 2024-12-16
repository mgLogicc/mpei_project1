function hashes = generate_hashes(str, k, n)
    hashes = zeros(1, k);
    for i = 1:k
        seed = i; % Different seed for each hash function
        hash_value = strhash(str, seed);
        hashes(i) = mod(hash_value, n); % Ensuring the hash is within bounds of Bloom filter size
    end
end