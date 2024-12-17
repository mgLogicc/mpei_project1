%% insert
function bloom_filter = insert(element, bloom_filter, k)
    % inserir elementos no bloom_filter utilizando k functions
    %
    % element: elemento a inserir
    % bloom_filter: bloom filter inicializado
    % k: funções de dispersão
    
    % Início do processo
    for i = 1:k
        % criar uma key para cada hash function
        key = [element num2str(i)];
        
        % transformar a key em hash
        hash_code = strhash(key, 5381);
        
        % cálculo do índice
        index = mod(hash_code, length(bloom_filter)) + 1;
    
        % limitar a 1 o tamanho do array
        bloom_filter(index) = 1;
    end
end