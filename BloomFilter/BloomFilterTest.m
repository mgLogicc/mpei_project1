%% ficheiro de desenvolvimento e teste do Bloom Filter

%teste (links que pertencem)
% test_links = {'proudemocrat.com';
%     'fort-russ.com';
%     'prisonplanet.com';
%     'truthfeed.com';
%     'themindunleashed.com';
%     'usuncut.com';
%     'newstarget.com';
%     'counterpunch.org';
%     'jewsnews.co.il';
%     'educateinspirechange.org';
%     'clickhole.com';
%     'newcenturytimes.com';
%     'opednews.com';
%     'defenddemocracy.press';
%     'voltairenet.org';
%     'whatreallyhappened.com';
%     'winningdemocrats.com';
%     'other98.com';
%     'southfront.org';
%     'barenakedislam.com';
%     'dailywire.com';
%     'americasfreedomfighters.com';
%     'presidentialvoting2016.com';
%     'thesleuthjournal.com';
%     'nakedcapitalism.com';
%     'rumormillnews.com';
%     'greanvillepost.com';
%     'ncscooper.com';
%     'indiaarising.com';
%     'thelastlineofdefense.org';
%     'moonofalabama.org';
%     'prepperwebsite.com';
%     'allnewspipeline.com';
%     'corbettreport.com';
%     'blackagendareport.com';
%     'ihavethetruth.com';
%     'therundownlive.com';
%     'abeldanger.net';
%     'trueactivist.com';
%     'usatwentyfour.com';
%     'nowtheendbegins.com';
%     'intrepidreport.com';
%     'fellowshipoftheminds.com';
%     'veteransnewsnow.com';
%     'breitbart.com';
%     'conservativetribune.com';
%     'thefederalistpapers.org';
%     'unz.com';
%     'eutimes.net';
%     'libertyblitzkrieg.com';
%     'madworldnews.com';
%     'mediamass.net';
%     'investmentresearchdynamics.com';
%     'veteranstoday.com';
%     'regated.com';
%     'sgtreport.com';
%     'usapoliticsnow.com';
%     'nutritionfacts.org';
%     'worldtruth.tv';
%     'dcclothesline.com';
%     'in5d.com';
%     'fromthetrenchesworldreport.com';
%     'pravdareport.com';
%     'rt.com';
%     'therussophile.org';
%     'truthbroadcastnetwork.com';
%     'strategic-culture.org';
%     'ahtribune.com';
%     '100percentfedup.com';
%     'thecontroversialfiles.net';
%     'der-postillon.com';
%     'truthfrequencyradio.com';
%     'thedailywtf.com';
%     'elmundotoday.com';
%     'orientalreview.org';
%     'survivopedia.com';
%     'journal-neo.org';
%     'redflagnews.com';
%     'drudgereport.com';
%     'consortiumnews.com';
%     'presstv.com';
%     'libertyunyielding.com';
%     'thefreethoughtproject.com';
%     'coasttocoastam.com';
%     'dennismichaellynch.com';
%     'hangthebankers.com';
%     'yournewswire.com';
%     'anonews.co';
%     'newsbiscuit.com';
%     'projectveritas.com';
%     'realfarmacy.com';
%     'shtfplan.com';
%     'libertynews.com';
%     'newsthump.com';
%     'truthdig.com';
%     'anonhq.com';
%     'sputniknews.com';
%     'frontpagemag.com';
%     'returnofkings.com';
% };

% teste (links que não pertencem)
test_links = {
    'lab342.net';
    'growth411.co';
    'connect971.com';
    'portal612.tv';
    'advance361.info';
    'edge704.tv';
    'virtual104.tv';
    'fast717.biz';
    'tech393.me';
    'fast598.io';
    'global968.tech';
    'example292.net';
    'base272.io';
    'world306.biz';
    'edge887.tv';
    'universe184.tv';
    'global585.net';
    'wave186.com';
    'tech933.io';
    'demo419.io';
    'core364.biz';
    'link521.xyz';
    'connect826.net';
    'fast510.io';
    'stack215.xyz';
    'engine42.biz';
    'connect121.io';
    'drive149.biz';
    'support586.me';
    'global661.org';
    'data396.org';
    'solution563.org';
    'orbit422.me';
    'fake183.co';
    'link920.tv';
    'online586.biz';
    'sector199.me';
    'online644.co';
    'awesome87.io';
    'random222.tech';
    'core331.io';
    'advance121.org';
    'united163.xyz';
    'example720.me';
    'support110.me';
    'community11.com';
    'group112.me';
    'point779.com';
    'drive943.io';
    'fake736.xyz';
    'base23.com';
    'awesome830.info';
    'flow668.com';
    'virtual356.org';
    'global622.info';
    'fake1.io';
    'link968.info';
    'source553.me';
    'global179.info';
    'world928.xyz';
    'united799.com';
    'random520.me';
    'network393.biz';
    'field777.xyz';
    'store564.tech';
    'demo149.net';
    'task225.co';
    'advance903.tv';
    'portal28.io';
    'advance288.org';
    'media610.co';
    'edge55.org';
    'connect289.tech';
    'virtual129.tv';
    'edge149.me';
    'data764.com';
    'community701.xyz';
    'design402.me';
    'space349.biz';
    'wave432.xyz';
    'design458.net';
    'drive94.xyz';
    'growth987.me';
    'universe850.com';
    'point416.me';
    'demo803.com';
    'space305.biz';
    'universe765.io';
    'drive839.com';
    'core170.co';
    'advance588.info';
    'smart59.org';
    'matrix324.net';
    'future414.io';
    'pulse177.biz';
    'start446.biz';
    'stack451.tv';
    'group477.org';
    'orbit482.co';
    'support89.tv';
    'drive416.io';
    'pulse513.tech';
    'virtual63.co';
    'hub857.net';
    'smart732.io';
    'space827.net';
    'link632.net';
    'task210.org';
    'demo630.xyz';
    'connect736.info';
    'design508.org';
    'link625.me';
    'store271.org';
    'sector96.me';
    'connect985.io';
    'hub912.info';
    'hub427.xyz';
    'flow961.net';
    'start621.me';
    'portal780.tv';
    'media687.tv';
    'united683.co';
    'world389.io';
    'future94.tech';
    'sector627.me';
    'media600.io';
    'center613.info';
    'store901.tech';
    'community453.co';
    'space120.net';
    'space288.tv';
    'space170.info';
    'world900.co';
    'world250.com';
    'sample894.net';
    'center512.com';
    'expand607.tv';
    'space132.me';
    'link927.biz';
    'fast249.net';
    'global649.io';
    'test308.io';
    'connect989.com';
    'connect683.tv';
    'task646.com';
    'demo773.org';
    'edge16.biz';
    'media154.me';
    'link303.info';
    'web404.biz';
    'start663.me';
    'base672.co';
    'engine28.biz';
    'connect39.tech';
    'source826.io';
    'system458.org';
    'awesome809.info';
    'online597.me';
    'base568.biz';
    'cool766.me';
    'new284.co';
    'support458.info';
    'online776.info';
    'field944.io';
    'drive945.biz';
    'cloud259.me';
    'firm463.xyz';
    'fast471.tv';
    'project17.org';
    'orbit552.org';
    'fast360.org';
    'space517.info';
    'start490.com';
    'flow265.info';
    'new743.com';
    'flow815.me';
    'growth928.biz';
    'wave223.biz';
    'system401.io';
    'virtual181.tv';
    'field495.com';
    'portal975.org';
    'zone356.tv';
    'sample618.tv';
    'point487.org';
    'expand789.me';
    'fast67.io';
    'matrix415.tech';
    'sector772.net';
    'community319.xyz';
    'expand307.biz';
    'start131.tech';
    'drive91.me';
    'solution804.org';
    'orbit996.co';
    'orbit57.net';
    'connect373.tv';
    'cloud997.biz';
    'inc74.biz';
    'my412.tech'
};


positives = 0; % nº de positivos
negatives = 0; % nº de negativos

for l = 1:length(test_links) % for de teste
test_link = test_links{l}; % link em teste


%% ------------------------------------------------------------------------
% verificação inicial usando Bloom Filter

linkscsv = 'bf_data_fake.csv'; % ficheiro CSV com os links

data = readtable(linkscsv); % links processados
urls=unique(data.site_url);
clear data

% parâmetros iniciais
m = length(urls);
p = 0.001; % probabilidade de falsos positivos desejada (1%)
n = ceil(-1 * (m * log(p))/(log(2))^2); % tamanho do vetor 
k = ceil((n/m)*log(2)); % nº de funções de dispersão

% inicialização do bloom filter
bloom_filter = initialize(n);

% inserção de elementos no bloom filter
for i = 1:length(urls)
    bloom_filter = insert(urls{i}, bloom_filter, k);
    % disp(data.site_url{i}); % mostrar o que foi inseridoc
end

% verificar se um link fornecido pertence à base de dados
ismember = verify(bloom_filter, test_link, k);

% -------------------------------------------------------------------------
%% testar os nº de falsos positivos
if ismember == 1
    positives = positives + 1;
    fprintf('A notícia do site "%s" pode ser fake news!\n', test_link)
else
    negatives = negatives + 1;
    fprintf('A notícia do site "%s" não está registada como possível fake news!\n', test_link)
end


end % end do for de teste
fprintf('Positives: %d\n', positives)
fprintf('Negatives: %d\n', negatives)
fprintf("end of test")