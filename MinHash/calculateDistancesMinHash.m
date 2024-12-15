function J = calculateDistancesMinHash(Set, k)
    Nu = length(Set);
    J = zeros(Nu, Nu);

    % Barra de progresso
    h = waitbar(0, 'Calculating distances...');
    
    Assinaturas = zeros(k, Nu);

    % iterar pelas k funções de hash
    for hf=1:k
        % iterar pelos conjuntos
        for c=1:Nu
            % interar pelos elementos do conjunto
            conjunto = Set{c};
            hc = zeros(1, length(conjunto));

            for nelem=1:length(conjunto)
                % aplicar função de hash aos elementos
                elemento = conjunto{nelem};
                hc(nelem) = hash_function(elemento);
            end
            % fazer minimo
            minhash = min(hc);
            % guardar
            Assinaturas(hf, c) = minhash;
        end
    end
    delete(h)

    % 2 calc dists (com base nas assinaturas)

    h = waitbar(0, 'Calculating');

    for n1 = 1:Nu
        waitbar(n1/Nu, h);
        for n2 = n1+1:Nu
            % Assinaturas
            assinatura1 = Assinaturas(:,n1);
            assinatura2 = Assinaturas(:,n2);
            SimilarUsers = sum(assinatura1 == assinatura2) / k;
        end
    end
    delete(h);
end