%% ficheiro de desenvolvimento e teste do Minhash




%% ------------------------------------------------------------------------
% Verificação usando o Minhash




















% ------------------------------------------------------------------------
%% Código que o chat deu (só queria guardar para se desse jeito)

% Código Inicial para Implementar Minhash no Tema de Fake News

% 1. Dividir o texto em shingles
function shingles = getShingles(text, k)
    % Dividir o texto em k-gramas (shingles de tamanho k)
    words = split(text); % Divide o texto em palavras
    numWords = length(words);
    shingles = strings(numWords - k + 1, 1);
    
    for i = 1:numWords - k + 1
        shingles(i) = strjoin(words(i:i + k - 1), ' ');
    end
end

% 2. Gerar Minhashes
function minHash = generateMinhash(shingles, numHashFunctions)
    % Gera Minhash para um conjunto de shingles
    numShingles = length(shingles);
    minHash = inf(1, numHashFunctions); % Inicializa com infinito
    
    for i = 1:numShingles
        shingle = char(shingles(i)); % Converte para string
        
        for j = 1:numHashFunctions
            % Exemplo de função hash simples
            hashValue = mod(string2hash(shingle, j), 1e9 + 7);
            
            % Atualiza o valor mínimo de hash para cada função
            if hashValue < minHash(j)
                minHash(j) = hashValue;
            end
        end
    end
end

% 3. Calcular Similaridade de Jaccard
function similarity = computeJaccard(minHash1, minHash2)
    % Compara duas assinaturas Minhash para calcular similaridade
    similarity = sum(minHash1 == minHash2) / length(minHash1);
end

% 4. Função Hash Auxiliar
function hashValue = string2hash(str, seed)
    % Função hash simples baseada em string e seed
    hashValue = 0;
    for i = 1:length(str)
        hashValue = mod(seed * hashValue + double(str(i)), 1e9 + 7);
    end
end

% Teste do Sistema
% Exemplo: dois artigos de notícias
text1 = "A vacina é segura e eficaz.";
text2 = "A vacina é perigosa e eficaz.";

% Configuração
k = 2; % Tamanho dos shingles
numHashFunctions = 100; % Número de funções de hash

% Gerar shingles para os textos
shingles1 = getShingles(lower(text1), k);
shingles2 = getShingles(lower(text2), k);

% Gerar assinaturas Minhash
minHash1 = generateMinhash(shingles1, numHashFunctions);
minHash2 = generateMinhash(shingles2, numHashFunctions);

% Calcular similaridade
similarity = computeJaccard(minHash1, minHash2);

% Exibir resultado
fprintf('A similaridade entre os textos é: %.2f\n', similarity);
