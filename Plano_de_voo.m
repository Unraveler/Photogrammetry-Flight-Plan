clc;
format long g;
clear all;
echo off;
close all;
%PROGRAMA PARA PLANO DE VOO
%MESTRADO EM ENGENHARIA GEOGRÁFICA
%FOTOGRAMETRIA ANALÍTICA 2011/2012
%REALIZADO POR : RUI JORGE ABRUNHOSA NUNES nº32092
%%------------------------------------------------------------------------
%% ABERTURA DE FICHEIRO DE ESCRITA
fwr = fopen('relatorio_voo.txt','w');
fwc = fopen('coord_fotos.txt','w');

%% INSERÇÃO DE DADOS: 
%Apresentação
apresentacao = menu('PROGRAMA DE PLANO DE VOO | POR: Rui Jorge Abrunhosa Nunes','Começar','Sair');
switch(apresentacao)
    case 1
%Nome de quem realizou o trabalho
%nome = input('Trabalho realizado por: ','s');
%nome = inputdlg('Trabalho realizado por: ','s');

%Data de realização do projecto
%Data = input('Data de realização do projecto:','s');
%Data = inputdlg('Data de realização do projecto:','s');

%INSERÇÃO DE COORDENADAS DOS CANTOS DA ÁREA A LEVANTAR
for i = 1:4;
    if(i==1)
        disp('Quais as coordenadas do vertice do canto superior esquerdo(em metros): ');
    elseif(i==2)
        disp('Quais as coordenadas do vertice do canto superior direito(em metros): ');
    elseif(i==3)
        disp('Quais as coordenadas do vertice do canto inferior direito(em metros): ');
    elseif(i==4)
        disp('Quais as coordenadas do vertice do canto inferior esquerdo(em metros): ');
    end
    X(i) = input('M: ');
    Y(i) = input('P: ');   
end
%Guardar as coordenadas em vector (Para apresentação em esquema)
Terreno_X = [X(1), X(2), X(3), X(4),X(1)];
Terreno_Y = [Y(1), Y(2), Y(3), Y(4),Y(1)];

%COTA MÉDIA NO TERRENO
%z0 = input('Qual a cota média do terreno?: ');
z0 = str2double(inputdlg('Qual a cota média do terreno?: '));

%INSERÇÃO DA ESCALA DA FOTO
%mf = input('Qual e o modulo da escala pretendido para a fotografia?: ');
mf = str2double(inputdlg('Qual e o modulo da escala pretendido para a fotografia?: '));

%INSERÇÃO DAS SOBREPOSIÇÕES PRETENDIDAS
%disp('Qual a sobreposicao longitudinal (l) pretendida? (em percentagem): ');
%l = input('l:');
%disp('Qual a sobreposicao lateral (q) pretendida? (em percentagem): ');
%q = input('q:');

prompt = {'Longitudinal (l%):','Lateral (q%):'};
dlg_title = 'Sobreposições';
num_lines = 1;
def = {'',''};
sobreposicao = inputdlg(prompt,dlg_title,num_lines,def);
l = str2double(sobreposicao(1));
q = str2double(sobreposicao(2));

%CUSTOS POR HORA E FOTO
%custo_foto = input('Preço por foto(€): ');
%custo_voo = input('Preço por hora de voo(€): ');
prompt = {'Preço por foto(€):','Preço por hora de voo(€):'};
dlg_title = 'Valores';
num_lines = 1;
def = {'',''};
precos = inputdlg(prompt,dlg_title,num_lines,def);
custo_foto = str2double(precos(1));
custo_voo = str2double(precos(2));

%TEMPO DE VOO ENTRE FIADAS
%tvfx = input('Qual o tempo de voo entre cada fiada (em minutos): ');
tvfx = str2double(inputdlg('Qual o tempo de voo entre cada fiada (em minutos): '));

%AVIÃO FOTOGRAMÉTRICO A UTILIZAR
opcao0 = menu('Qual o avião fotogramétricoa utilizar?', 'Beach/King Air','De Havilland/ Twin Otter','Cessna 402','Cessna 404');
%disp('Qual o aviao fotogrametrico a utilizar? :');
%disp('1 - Beach/King Air');
%disp('2 - De Havilland/ Twin Otter');
%disp('3 - Cessna 402');
%disp('4 - Cessna 404');
%opcao0 = input('Opcao: ');
switch(opcao0)
    case 1
       vel_voo = 320e3/3600;
       aviao = 'Beach/King Air'; 
    case 2
       vel_voo = 258e3/3600;
       aviao = 'De Havilland/Twin Otter'; 
    case 3
        vel_voo = ((180+320)/2)*1e3/3600;
        aviao = 'Cessna 402';
    case 4
        vel_voo = ((200+340)/2)*1e3/3600;
        aviao = 'Cessna 404';
end
    
%CÂMARA DIGITAL A UTILIZAR
opcao1 = menu('Qual o tipo de câmara que pretende usar?', 'Analógica','Digital');
%disp('Que tipo de camara pretende usar?: ');
%disp('1 - Analogica');
%disp('2 - Digital');
%opcao1 = input('Opcao: ');
switch(opcao1)
    case 1
        opcao2 = menu('Qual a objectiva que pretende?', 'Ângulo Estreito','Ângulo Normal','Ângulo Intermédio','Grande Angular','Super Grande Angular');
        %disp('Qual a objectiva que pretende?: ');
        %disp('1 - Angulo Estreito');
        %disp('2 - Angulo Normal');
        %disp('3 - Angulo Intermedio');
        %disp('4 - Grande Angular');
        %disp('5 - Super Grande Angular');
        %opcao2 = input('Opcao: ');
        switch(opcao2)
            case 1;
                c = 60e-2;
                ang = 33*pi/400;
                s1 = 0.23;
                s2 = s1;
                camara = 'Analógica Angulo Estreito';
            case 2
                c = 30e-2;
                ang = 62*pi/400;
                s1 = 0.23;
                s2 = s1;
                camara = 'Analógica Angulo Normal';
            case 3
                c = 21e-2;
                ang = 85*pi/400;
                s1 = 0.23;
                s2 = s1;
                camara = 'Analógica Angulo Intermédio';
            case 4
                c = 15e-2;
                ang = 100*pi/400;
                s1 = 0.23;
                s2 = s1;
                camara = 'Analógica Grande Angular';
            case 5
                c = 9e-2;
                ang = 140*pi/400;
                s1 = 0.23;
                s2 = s1;
                camara = 'Analógica Super Grande Angular';
        end
    case 2
        opcao2 = menu('Qual o fabricante da câmara que pretende usar?', 'Intergraph','Microsoft','Leica');
        %disp('Qual a marca da camara que pretende usar?: ');
        %disp('1 - Intergraph');
        %disp('2 - Microsoft');
        %disp('3 - Leica');
        %opcao2 = input('Opçao: ');
        switch(opcao2);
            case 1
                opcao3 = menu('Qual o modelo que pretende usar?', 'DMC','DMC II 140','DMC II 230','DMC II 250');
                %disp('Qual a modelo da camara que pretende usar?: ');
                %disp('1 - DMC');
                %disp('2 - DMC II 140');
                %disp('3 - DMC II 230');
                %disp('4 - DMC II 250');
                %opcao3 = input('Opçao: ');
                switch(opcao3)
                    case 1
                        c = 120e-3;
                        s2 = 13824 * 12e-6;
                        s1 = 7680 * 12e-6;
                        camara = 'Intergraph DMC';
                    case 2
                        c = 72e-3;
                        s2 = 12096 * 7.2e-6;
                        s1 = 11200 * 7.2e-6;
                        camara = 'Intergraph DMC II 140';
                    case 3
                        c = 92e-3;
                        s2 = 15542 * 5.6e-6;
                        s1 = 14144 * 5.6e-6;
                        camara = 'Intergraph DMC II 230';
                    case 4
                        c = 112e-3;
                        s2 = 17216 * 5.6e-6;
                        s1 = 14656 * 5.6e-6;
                        camara = 'Intergraph DMC II 250';
                end
        
            case 2
                opcao3 = menu('Qual o modelo que pretende usar?', 'UltraCAM D','UltraCAM X','UltraCAM Xp','UltraCAM XpWA');
                %disp('Qual a modelo da camara que pretende usar?: ');
                %disp('1 - UltraCAM D');
                %disp('2 - UltraCAM X');
                %disp('3 - UltraCAM Xp');
                %disp('4 - UltraCAM XpWA');
                %opcao3 = input('Opçao: ');
                switch(opcao3)
                    case 1
                        c = 100e-3;
                        s1 = 7500 * 9e-6;
                        s2 = 11500 * 9e-6;
                        camara = 'Microsoft UltraCAM D';
                    case 2
                        c = 100e-3;
                        s1 = 9420 * 7.2e-6;
                        s2 = 14430 * 7.2e-6;
                        camara = 'Microsoft UltraCAM X';
                    case 3
                        c = 100e-3;
                        s1 = 11310 * 6e-6;
                        s2 = 17310 * 6e-6;
                        camara = 'Microsoft UltraCAM Xp';
                    case 4
                        c = 70e-3;
                        s1 = 11310 * 5.6e-6;
                        s2 = 17310 * 5.6e-6;
                        camara = 'Microsoft UltraCAM XpWA';
                end
        
            case 3
                opcao3 = menu('Qual o modelo que pretende usar?', 'ADS');
                %disp('Qual a modelo da camara que pretende usar?: ');
                %disp('1 - ADS');
                switch(opcao3)
                    case 1
                        c = 62.5e-3;
                        s1 = 12000 * 6.5e-6;
                        s2 = 12000 * 6.5e-6;
                        camara = 'LEICA ADS';
                end           
        end
end

    case 2
        return;
end
%% CALCULO DAS QUANTIDADES NECESSÁRIAS AO MAPA DE VOO
%Altura do voo
h = mf*c;

%Lados da foto no terreno
S1 = s1*mf;
S2 = s2*mf;

%Lados do terreno
if(sqrt((X(1)-X(2))^2 + (Y(1)-Y(2))^2) >= sqrt((X(2)-X(3))^2 + (Y(2)-Y(3))^2) || sqrt((X(4)-X(3))^2 + (Y(4)-Y(3))^2) >= sqrt((X(1)-X(4))^2 + (Y(1)-Y(4))^2))
    L = (sqrt((X(1)-X(2))^2 + (Y(1)-Y(2))^2) + sqrt((X(4)-X(3))^2 + (Y(4)-Y(3))^2))/2; 
    Q = (sqrt((X(2)-X(3))^2 + (Y(2)-Y(3))^2) + sqrt((X(1)-X(4))^2 + (Y(1)-Y(4))^2))/2;
    dM = X(2)-X(1);
    dP = Y(2)-Y(1);
    aux1 = X(1);
    aux2 = Y(1);
    dist=S2*0.30;
elseif(sqrt((X(1)-X(2))^2 + (Y(1)-Y(2))^2) < sqrt((X(2)-X(3))^2 + (Y(2)-Y(3))^2) || sqrt((X(4)-X(3))^2 + (Y(4)-Y(3))^2) < sqrt((X(1)-X(4))^2 + (Y(1)-Y(4))^2))
    L = (sqrt((X(2)-X(3))^2+(Y(2)-Y(3))^2) + sqrt((X(1)-X(4))^2+(Y(1)-Y(4))^2))/2;
    Q = (sqrt((X(1)-X(2))^2+(Y(1)-Y(2))^2) + sqrt((X(4)-X(3))^2+(Y(4)-Y(3))^2))/2;
    dM = X(3)-X(2);
    dP = Y(3)-Y(2);
    aux1 = X(2);
    aux2 = Y(2);
    dist=S2*0.30;
end

%Comprimento da Base Aerea para l% de sobreposicao
B = S1*(1-l/100);

%Distancia entre fiadas para q% de sobreposicao
A = S2*(1-q/100);

%Calculo do Rumo
if(dM>0 && dP >0)
    corr = 0;
    Rumo = atan(dM/dP) + corr;
elseif(dM>0 && dP<0)
    corr = pi;
    Rumo = atan(dM/dP) + corr;
elseif(dM<0 && dP>0)
    corr = 2*pi;
    Rumo = atan(dM/dP) + corr;
elseif(dM<0 && dP<0)
    corr = pi;
    Rumo = atan(dM/dP) + corr;
end

if(dM == 0 && dP ~= 0)
    if(dP>0)
        Rumo = 0;
    else
        Rumo = pi;
    end
elseif(dM ~= 0 && dP == 0)
    if(dM>0)
        Rumo = (pi/2);
    else
        Rumo = 3*pi/2;
    end
end

%Numero de modelos por fiada
nm = fix((L/B)+1);

%Numero de fotos por fiada
nf = nm+1;

%Numero de fiadas
nfx = fix((Q/A)+1);

%Lado do quadrado central
lq = B/mf;

%Distância radial máxima do quadrado central
r = lq/sqrt(2);

%Verificar se é necessário uma eventual partição de fiadas
lmin = l-5;
hmin = (1-B)*(100*c)/(lmin*s1);
cota_maxima_admissivel = h-hmin;
if(z0 > cota_maxima_admissivel)
    veredicto ='Necessária eventual partição de fiadas';
else
    veredicto ='Não é necessária partição de fiadas';
end
    

%% CALCULO DAS QUANTIDADES NECESSÁRIAS AO ORÇAMENTO
%tempo de voo entre bases fotográficas 
t = B/vel_voo;

%custo total das fotos
custo_total_fotos = nf*nfx*custo_foto;

%Custo total do voo
custo_total_voo = (t*nf*nfx) + (tvfx*60*(nfx-1));

%Custo total
Custo_Total = custo_total_fotos + custo_total_voo;

%% APRESENTAÇÃO DE RESULTADOS EM RELATÓRIO
fprintf(fwr, '               RELATÓRIO PARA O PROJECTO DO PLANO DE VOO\n');
fprintf(fwr, '                   MESTRADO EM ENGENHARIA GEOGRÁFICA\n');
fprintf(fwr, '                   FOTOGRAMTERIA ANALÍTICA 2011/2012\n');
fprintf(fwr, '                   ---------------------------------\n');
%fprintf(fwr, 'DATA: %s \n',Data);
%fprintf(fwr, 'REALIZADO POR: %s \n',nome);
fprintf(fwr, '---------------------------------------------------------\n');
fprintf(fwr, 'DADOS\n');
fprintf(fwr, 'Dimensões da area a levantar (em km): %2.3f x %2.3f\n',L*1e-3,Q*1e-3);
fprintf(fwr, 'Cota média do terreno: %2.2f\n',z0);
fprintf(fwr, 'Modulo da escala das fotografia: %6.2f\n', mf);
fprintf(fwr, 'Sobreposição longitudinal, em percentagem (l): %d\n',l);
fprintf(fwr, 'Sobreposição lateral, em percentagem (q): %d\n',q);
fprintf(fwr, 'Rumo de entrada da primeira fiada (em graus): %3.3f\n',Rumo*180/pi);
fprintf(fwr, 'Avião fotogramétrico utilizado: %s\n',aviao);
fprintf(fwr, 'Velocidade do voo (em km/h): %3.2f\n',vel_voo*3600/1000);
fprintf(fwr, 'Custo de cada hora de voo: %6.2f €\n',custo_voo);
fprintf(fwr, 'Custo de cada fotografia: %3.2f €\n',custo_foto);
fprintf(fwr, 'Camara utilizada: %s\n',camara);
fprintf(fwr, '---------------------------------------------------------\n');
fprintf(fwr, 'RESULTADOS\n');
fprintf(fwr, 'Altura do voo (em metros): %f\n',h);
fprintf(fwr, 'Lado do quadrado central (em metros): %f\n',lq);
fprintf(fwr, 'Distância radial máxima do quadrado central (em metros): %f\n',r);
fprintf(fwr, 'Lado da foto no terreno, ao longo da fiada (em metros): %4.3f\n',S1);
fprintf(fwr, 'Lado da foto no terreno, perpendicular à fiada (em metros): %4.3f\n',S2);
fprintf(fwr, 'Distância entre fiadas (em metros): %4.3f\n',A);
fprintf(fwr, 'Distância entre bases fotográficas (em metros): %4.3f\n',B);
fprintf(fwr, 'Numero de modelos por fiada: %d\n',nm);
fprintf(fwr, 'Numero de fotografias por fiada: %d\n',nf);
fprintf(fwr, 'Numero de fiadas: %d\n',nfx);
fprintf(fwr, 'Tempo de voo em cada fiada (em segundos): %2.3f\n',t*nf);
fprintf(fwr, 'Tempo de voo entre fiadas (em minutos): %2.3f\n',tvfx);
fprintf(fwr, 'Necessária partição de fiadas?: %s\n',veredicto);
fprintf(fwr, '---------------------------------------------------------\n');
fprintf(fwr, 'CUSTOS\n');
fprintf(fwr, 'Custo total das fotos: %7.2f €\n',custo_total_fotos);
fprintf(fwr, 'Custo total do voo: %7.2f €\n',custo_total_voo);
fprintf(fwr, 'Custo total: %7.2f €\n',Custo_Total);
fprintf(fwr, '---------------------------------------------------------\n');
fprintf(fwr, 'CORDENADAS DOS VÉRTICES QUE DEFINEM A ÁREA A LEVANTAR\n');
fprintf(fwr, 'id                X                   Y\n');

r=1;
for h = 1:4
    v = r;
    fprintf(fwr, '%d          %7.3f          %7.3f\n', v, X(h), Y(h));
    r = r+1;
end
fprintf(fwr, '---------------------------------------------------------\n');
fprintf(fwc, 'COORDENADAS DOS PONTOS DE TOMADA DE FOTO\n');
fprintf(fwc, 'id                X                   Y                  Z\n');

coordenadas=zeros(nf*nfx,2);

compRumo = Rumo + pi;
compRumo2 = Rumo + (pi/2);
atras1 = sin(compRumo)*B;
atras2 = cos(compRumo)*B;
a=1;
for n = 1:nfx
    for o = 1:nf+1
        id = n*1000+o;
        x(o) = (aux1+sin(compRumo2)*dist) + atras1;
        y(o) = (aux2+cos(compRumo2)*dist) + atras2;
        fprintf(fwc, '%d          %7.3f          %7.3f          %2.2f\n', id, x(o), y(o), z0+h);
        %Guardar valores em matriz
        coordenadas(a,1) = x(o);
        coordenadas(a,2) = y(o);
        %Actualizar variáveis para próximas iterações
        dist = B;
        aux1 = x(o);
        aux2 = y(o);
        atras1 = 0;
        atras2 = 0;
        compRumo2 = Rumo;
        a=a+1;
    end
    %Actualizar variáveis para próxima fiada
    aux1 = x(1);
    aux2 = y(1);
    dist = A;
    compRumo2 = Rumo+(pi/2);
end

%% ENCERRAMENTO DO FICHEIRO DE ESCRITA
fclose(fwr);
fclose(fwc);

%% ESQUEMA GRÁFICO
coordenada_X = coordenadas(:,1);
coordenada_Y = coordenadas(:,2);
plot(coordenada_X, coordenada_Y, '+r');
hold on;
plot(Terreno_X, Terreno_Y, 'b');
hold off;












