%% insert
function bloom_filter = insert(element, bloom_filter, k)

    key = element;
    for fh = 1:k

        key = [element num2str(fh)];

        hash_code = string2hash(key);

        index = mod(hash_code, length(bloom_filter));

        bits(fh) = bloom_filter(index);

    end
    % apicar função
    hash_code = string2hash(element);
    
    % limitar a 1 o tamanho do array
    bloom_filter(index) = 1;
end 