CREATE DATABASE rd;
USE rd;

/*CRIANDO A TABELA QUE VAI RECEBER O CSV DAS METAS POR MES*/
CREATE TABLE metas_mes(account_last_touch VARCHAR(30),
channel_last_touch VARCHAR(30),
etapa VARCHAR(30),
icp_score VARCHAR(10),
mes INT(10),
meta INT(10),
meta_dia FLOAT,
data date);

/* COPIANDO OS DADOS DO CSV PARA A TABELA*/
/* COLAR A TABELA NO DIRETÓRIO DO BANCO C:\ProgramData\MySQL\MySQL Server 8.0\Data\rd*/
LOAD DATA INFILE 'metas_email.csv' INTO TABLE metas_mes FIELDS TERMINATED BY ',' IGNORE 1 ROWS
(account_last_touch, channel_last_touch, etapa, icp_score, mes, meta, @data, @meta_dia) 
SET data = STR_TO_DATE(@data, '%d/%m/%Y'), meta_dia = (meta/30);
SELECT SUM(META) FROM METAS_MES; /*52953*/

/*CRIANDO O RANGE DE DIAS*/
CREATE TABLE DIAS (dia INT(10));
INSERT INTO RD.DIAS (dia) VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),
(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(29),(30);
SELECT * FROM DIAS;

/*CRIANDO A TABELA QUE VAI RECEBER O CSV DAS METAS POR DIA*/
CREATE TABLE metas(account_last_touch VARCHAR(30),
channel_last_touch VARCHAR(30),
etapa VARCHAR(30),
icp_score VARCHAR(10),
mes INT(10),
meta INT(10),
meta_dia FLOAT,
data date,
dia INT(10));

/*POPULANDO A TABELA COM AS METAS POR DIA*/
INSERT INTO METAS (account_last_touch, channel_last_touch, etapa, icp_score, mes, meta, meta_dia, data, dia)
SELECT * FROM metas_mes join dias;
SELECT SUM(meta_dia) FROM METAS; /*52953*/

/*CRIANDO A TABELA QUE VAI RECEBER O CSV DOS FUNIL*/
CREATE TABLE FUNIL(id VARCHAR(40),
email VARCHAR(40),
mes INT(10),
dia INT(10),
created_month DATE,
created_date DATE,
lead_created_month DATE,
lead_created_date DATE,
mql_created_month DATE,
mql_created_date DATE,
sal_created_month DATE,
sal_created_date DATE,
first_touch_date DATE,
last_touch_date DATE,
account_first_touch VARCHAR(30),
account_last_touch VARCHAR(30),
channel_first_touch VARCHAR(30),
channel_last_touch VARCHAR(30),
campaign_first_touch VARCHAR(40),
campaign_last_touch VARCHAR(40),
identifier_first_touch VARCHAR(40),
identifier_last_touch VARCHAR(40),
icp_score VARCHAR(10),
lead_channel VARCHAR(10),
lead_type VARCHAR(30),
country VARCHAR(10),
is_new_lead VARCHAR(10),
converted_to_mql VARCHAR(10),
is_blank_mql VARCHAR(10),
converted_to_sal VARCHAR(10),
is_a VARCHAR(10),
is_b VARCHAR(10),
is_c VARCHAR(10),
is_d VARCHAR(10),
is_abc VARCHAR(10),
contador INT(1),
etapa VARCHAR(10));

/* COPIANDO OS DADOS DO CSV PARA A TABELA*/
/* COLAR A TABELA NO DIRETÓRIO DO BANCO C:\ProgramData\MySQL\MySQL Server 8.0\Data\rd*/
LOAD DATA INFILE 'bi_challenge_rd_bi_funnel_email.csv' INTO TABLE FUNIL 
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, email, @created_month, @created_date, @lead_created_month, @lead_created_date, @mql_created_month,
@mql_created_date, @sal_created_month, @sal_created_date, @first_touch_date, @last_touch_date,
account_first_touch, account_last_touch, channel_first_touch, channel_last_touch,
campaign_first_touch, campaign_last_touch, identifier_first_touch, identifier_last_touch,
icp_score, lead_channel, lead_type, country, is_new_lead, converted_to_mql, is_blank_mql,
converted_to_sal, is_a, is_b, is_c, is_d, is_abc, @contador, @etapa)
SET mes = cast(SUBSTRING(@created_month,6,2) as unsigned integer),
dia = cast(SUBSTRING(@created_date,9,2) as unsigned integer),
created_month = STR_TO_DATE(@created_month, '%Y-%m-%d'),
created_date = STR_TO_DATE(@created_date, '%Y-%m-%d %H:%i:%s'),
lead_created_month = STR_TO_DATE(@lead_created_month, '%Y-%m-%d'),
lead_created_date  = STR_TO_DATE(@lead_created_date, '%Y-%m-%d %H:%i:%s'),
mql_created_month  = STR_TO_DATE(@mql_created_month, '%Y-%m-%d'),
mql_created_date   = STR_TO_DATE(@mql_created_date, '%Y-%m-%d %H:%i:%s'),
sal_created_month  = STR_TO_DATE(@sal_created_month, '%Y-%m-%d'),
sal_created_date   = STR_TO_DATE(@sal_created_date, '%Y-%m-%d %H:%i:%s'),
first_touch_date   = STR_TO_DATE(@first_touch_date, '%Y-%m-%d %H:%i:%s'),
last_touch_date    = STR_TO_DATE(@last_touch_date, '%Y-%m-%d %H:%i:%s'),
contador = 1,
etapa = (if(converted_to_sal = 1, 'SAL', (if(converted_to_mql = 1, 'MQL', 'LEAD'))));
select * from FUNIL;

/*CRIANDO A TABELA QUE VAI RECEBER OS TIPOS DE CONTAS*/
CREATE TABLE ACCOUNT(account_last_touch VARCHAR(30));
INSERT INTO RD.ACCOUNT (account_last_touch) select distinct account_last_touch from RD.funil;
select * from RD.ACCOUNT;

/*CRIANDO A TABELA QUE VAI RECEBER OS MESES e dias*/
CREATE TABLE MESES(mes INT(10));
INSERT INTO RD.MESES (mes) select distinct mes from RD.funil;
select * from RD.MESES;

/*CRIANDO A TABELA QUE VAI RECEBER OS PERFIS*/
CREATE TABLE ICP_SCORE(icp_score VARCHAR(10));
INSERT INTO RD.ICP_SCORE (icp_score) select distinct icp_score from RD.funil;
select * from RD.ICP_SCORE;

/*CRIANDO A TABELA QUE VAI RECEBER AS ETAPAS*/
CREATE TABLE ETAPAS(etapa VARCHAR(10));
INSERT INTO RD.ETAPAS (etapa) select distinct etapa from RD.funil;
select * from RD.ETAPAS;