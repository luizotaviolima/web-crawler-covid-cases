# Script em Bash para Download de Dados Externos do Portal da Secretaria de Saúde do Paraná.
---

## Objetivo

Escrever um script em `BASH` que baixe informações do portal da [Secretaria de Saúde do Paraná](https://www.saude.pr.gov.br/Pagina/Coronavirus-COVID-19) de um período pré-determinado. 

![image_secret](https://scontent.fbfh8-1.fna.fbcdn.net/v/t39.30808-6/271388638_2915954045361617_8240370610404962769_n.png?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=u4o_H5JeVuIAX8Sjoa2&tn=wE4Ct8n7F41vKSTU&_nc_ht=scontent.fbfh8-1.fna&oh=00_AfA__go206WLP1cmJNA_K9NktliHBUE_EgnPAIzTXXfQaw&oe=63A6C54D)

## Instruções

O Script deve receber **4** parâmetros de entrada da seguinte forma: *./baixaDadosSaude.sh diaIni diaFim mes ano cidade TipoInfo* na qual:
- *baixaDadosSaude.sh* é o nome do script;
- *diaIni* é o dia inicial a ser baixado;
- *diaFim* é o dia final a ser baixado;
- *mes* é o mes das informações requeridas;
- *ano* é o ano das informações requeridas;
- *cidade* é o nome da cidade;
- *tipoInfo* é um número que indica qual informação será mostrada. 
  - 1 para número de casos;
  - 2 para número de óbitos
  - 3 para as duas informações anteriores (duas colunas).

O nome do arquivo deve possuir o seguinte formato: `informe_epidemiologico_DD_MM_AAA_obitos_casos_municipios.csv` onde:
- AAAA é o ano;
- MM é o mês;
- DD é o dia.



