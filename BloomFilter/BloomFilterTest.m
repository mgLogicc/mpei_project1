%% ficheiro de desenvolvimento e teste do Bloom Filter

%teste (links que pertencem)
test_links = {'proudemocrat.com';
    'fort-russ.com';
    'prisonplanet.com';
    'truthfeed.com';
    'themindunleashed.com';
    'usuncut.com';
    'newstarget.com';
    'counterpunch.org';
    'jewsnews.co.il';
    'educateinspirechange.org';
    'clickhole.com';
    'newcenturytimes.com';
    'opednews.com';
    'defenddemocracy.press';
    'voltairenet.org';
    'whatreallyhappened.com';
    'winningdemocrats.com';
    'other98.com';
    'southfront.org';
    'barenakedislam.com';
    'dailywire.com';
    'americasfreedomfighters.com';
    'presidentialvoting2016.com';
    'thesleuthjournal.com';
    'nakedcapitalism.com';
    'rumormillnews.com';
    'greanvillepost.com';
    'ncscooper.com';
    'indiaarising.com';
    'thelastlineofdefense.org';
    'moonofalabama.org';
    'prepperwebsite.com';
    'allnewspipeline.com';
    'corbettreport.com';
    'blackagendareport.com';
    'ihavethetruth.com';
    'therundownlive.com';
    'abeldanger.net';
    'trueactivist.com';
    'usatwentyfour.com';
    'nowtheendbegins.com';
    'intrepidreport.com';
    'fellowshipoftheminds.com';
    'veteransnewsnow.com';
    'breitbart.com';
    'conservativetribune.com';
    'thefederalistpapers.org';
    'unz.com';
    'eutimes.net';
    'libertyblitzkrieg.com';
    'madworldnews.com';
    'mediamass.net';
    'investmentresearchdynamics.com';
    'veteranstoday.com';
    'regated.com';
    'sgtreport.com';
    'usapoliticsnow.com';
    'nutritionfacts.org';
    'worldtruth.tv';
    'dcclothesline.com';
    'in5d.com';
    'fromthetrenchesworldreport.com';
    'pravdareport.com';
    'rt.com';
    'therussophile.org';
    'truthbroadcastnetwork.com';
    'strategic-culture.org';
    'ahtribune.com';
    '100percentfedup.com';
    'thecontroversialfiles.net';
    'der-postillon.com';
    'truthfrequencyradio.com';
    'thedailywtf.com';
    'elmundotoday.com';
    'orientalreview.org';
    'survivopedia.com';
    'journal-neo.org';
    'redflagnews.com';
    'drudgereport.com';
    'consortiumnews.com';
    'presstv.com';
    'libertyunyielding.com';
    'thefreethoughtproject.com';
    'coasttocoastam.com';
    'dennismichaellynch.com';
    'hangthebankers.com';
    'yournewswire.com';
    'anonews.co';
    'newsbiscuit.com';
    'projectveritas.com';
    'realfarmacy.com';
    'shtfplan.com';
    'libertynews.com';
    'newsthump.com';
    'truthdig.com';
    'anonhq.com';
    'sputniknews.com';
    'frontpagemag.com';
    'returnofkings.com';
};

% teste (links que não pertencem)
%  test_links = {'alpha-news.com';
%     'beta-world.net';
%     'gamma-reports.org';
%     'delta-times.info';
%     'epsilon-update.biz';
%     'zeta-journal.co';
%     'eta-insider.tv';
%     'theta-daily.us';
%     'iota-now.news';
%     'kappa-chronicle.site';
%     'lambda-press.online';
%     'mu-hub.com';
%     'nu-portal.net';
%     'xi-realm.org';
%     'omicron-global.info';
%     'pi-focus.biz';
%     'rho-digest.co';
%     'sigma-outlet.tv';
%     'tau-brief.us';
%     'upsilon-newsroom.news';
%     'phi-space.site';
%     'chi-archive.online';
%     'psi-network.com';
%     'omega-truth.net';
%     'alpha-update.org';
%     'beta-insights.info';
%     'gamma-coverage.biz';
%     'delta-stories.co';
%     'epsilon-spotlight.tv';
%     'zeta-review.us';
%     'eta-journal.news';
%     'theta-press.site';
%     'iota-hub.online';
%     'kappa-portal.com';
%     'lambda-realm.net';
%     'mu-global.org';
%     'nu-focus.info';
%     'xi-digest.biz';
%     'omicron-outlet.co';
%     'pi-brief.tv';
%     'rho-newsroom.us';
%     'sigma-space.news';
%     'tau-archive.site';
%     'upsilon-network.online';
%     'phi-truth.com';
%     'chi-update.net';
%     'psi-insights.org';
%     'omega-coverage.info';
%     'alpha-stories.biz';
%     'beta-spotlight.co';
%     'gamma-review.tv';
%     'delta-journal.us';
%     'epsilon-press.news';
%     'zeta-hub.site';
%     'eta-portal.online';
%     'theta-realm.com';
%     'iota-global.net';
%     'kappa-focus.org';
%     'lambda-digest.info';
%     'mu-outlet.biz';
%     'nu-brief.co';
%     'xi-newsroom.tv';
%     'omicron-space.us';
%     'pi-archive.news';
%     'rho-network.site';
%     'sigma-truth.online';
%     'tau-update.com';
%     'upsilon-insights.net';
%     'phi-coverage.org';
%     'chi-stories.info';
%     'psi-spotlight.biz';
%     'omega-review.co';
%     'alpha-journal.tv';
%     'beta-press.us';
%     'gamma-hub.news';
%     'delta-portal.site';
%     'epsilon-realm.online';
%     'zeta-global.com';
%     'eta-focus.net';
%     'theta-digest.org';
%     'iota-outlet.info';
%     'kappa-brief.biz';
%     'lambda-newsroom.co';
%     'mu-space.tv';
%     'nu-archive.us';
%     'xi-network.news';
%     'omicron-truth.site';
%     'pi-update.online';
%     'rho-insights.com';
%     'sigma-coverage.net';
%     'tau-stories.org';
%     'upsilon-spotlight.info';
%     'phi-review.biz';
%     'chi-journal.co';
%     'psi-press.tv';
%     'omega-hub.us';
% };


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
n = 3e3; % tamanho do vetor 
m = length(urls);
k = round(log(1/2)/(m*log(1 - 1/n))); % nº de funções de dispersão

% inicialização do bloom filter
bloom_filter = initialize(n);


% inserção de elementos no bloom filter
for i = 1:height(urls)
    bloom_filter = insert(urls{i}, bloom_filter, k);
    % disp(data.site_url{i}); % mostrar o que foi inserido
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