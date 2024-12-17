%% verify
function boolean = verify(bloom_filter, element, k)
    % Se alguma das posições contém 0 não é um membro do conjunto
    % A pior situação em termos de tempo de processamento ocorre para membros e para falsos positivos 
    % Ambos obrigam a calcular todas as k funções de dispersão
    %
    % bloom_filter: bloom filter inicializado
    % element: elemento a inserir
    % k: funções de dispersão

    % assumir que o boolean é verdadeiro, caso não se verifique a condição abaixo
    boolean = true;

    % loop para verificar os índices
    for i = 1:k
        % chave única para cada função hash
        key = [element num2str(i)];

        % cálculo do índice
        index = mod(strhash(key, 5381),length(bloom_filter)) + 1;
        
        % verifica se o bit correspondente é um 1
        if bloom_filter(index) == 0
            boolean = false;
            break;
        end
    end 
end