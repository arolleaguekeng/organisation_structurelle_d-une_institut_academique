SET ECHO OFF
SET VERIFY OFF
ALTER SESSION SET container = xepdb1;
PROMPT 
PROMPT specify password for ASM as parameter 1:
DEFINE pass     = &1
PROMPT 
PROMPT specify default tablespeace for ASM as parameter 2:
DEFINE tbs      = &2
PROMPT 
PROMPT specify temporary tablespace for ASM as parameter 3:
DEFINE ttbs     = &3
PROMPT 
PROMPT specify password for SYS as parameter 4:
DEFINE pass_sys = &4
PROMPT 
PROMPT specify log path as parameter 5:
DEFINE log_path = C:/asm/
PROMPT
PROMPT specify connect string as parameter 6:
DEFINE connect_string     = //localhost:1521/xepdb1
PROMPT

DEFINE spool_file = &log_path.hr_main.log
SPOOL &spool_file



REM =======================================================
REM cleanup section
REM =======================================================

DROP USER asm CASCADE;



REM =======================================================
REM create user
REM three separate commands, so the create user command 
REM will succeed regardless of the existence of the 
REM DEMO and TEMP tablespaces 
REM =======================================================

CREATE USER asm IDENTIFIED BY &pass;

ALTER USER asm DEFAULT TABLESPACE &tbs
              QUOTA UNLIMITED ON &tbs;

ALTER USER asm TEMPORARY TABLESPACE &ttbs;

GRANT CREATE SESSION, CREATE VIEW, ALTER SESSION, CREATE SEQUENCE TO asm;
GRANT CREATE SYNONYM, CREATE DATABASE LINK, RESOURCE , UNLIMITED TABLESPACE TO asm;
REM =======================================================
REM grants from sys schema
REM =======================================================

CONNECT sys/&pass_sys@&connect_string AS SYSDBA;
GRANT execute ON sys.dbms_stats TO asm;

REM =======================================================
REM create asm schema objects
REM =======================================================

CONNECT asm/&pass@&connect_string
ALTER SESSION SET NLS_LANGUAGE=English;
ALTER SESSION SET NLS_TERRITORY=Cameroon;

--
-- create tables, sequences and constraint
--

@C:/asm/asm_cre
// crea  de la table bloc
CREATE TABLE blocs
(
    id_bloc INT PRIMARY KEY NOT NULL,
    nom_bloc VARCHAR (255),
    salle_de_classe_blocid_bloc INT,
    salle_de_classe_classeid_classe INT
);

//creation de la table campus
CREATE TABLE blocs
(
    id_bloc INT PRIMARY KEY NOT NULL,
    nom_bloc VARCHAR (255),
    salle_de_classe_blocid_bloc INT,
    salle_de_classe_classeid_classe INT

);

//creation de la table diplome

CREATE TABLE diplomes
(
    id_diplome INT PRIMARY KEY NOT NULL,
    tutelle VARCHAR (255),
    nom_diplome VARCHAR (255),
    type_diplome VARCHAR(255),
    qualite VARCHAR(255),
    equivalence VARCHAR (255),
    #id_niveau INT,
    #id_specialite INT,
    specialitied_specialite INT,
    niveau_academiqueid_niveau INT,
    id_type_de_diplome INT
);

//creation de la table niveau_accademique

CREATE TABLE niveau_academique
(
    id_niveau INT PRIMARY KEY NOT NULL,
    nom_niveau VARCHAR (100),
    Ddepartementid_departement INT,
    coursfiliereid_filiere INT,
    coursniveau_academique_niveau INT,
    coursid_cours INT
);

//creation de la table position

CREATE TABLE position
(
    id INT PRIMARY KEY NOT NULL,
    nom_position VARCHAR (255)
);

//creation de la table ville

CREATE TABLE villes
(
    id_ville INT PRIMARY KEY NOT NULL,
    nom_ville VARCHAR (255)
);
