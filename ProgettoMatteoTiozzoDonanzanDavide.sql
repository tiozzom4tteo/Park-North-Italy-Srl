--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-06-20 12:04:29 CEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3732 (class 1262 OID 19976)
-- Name: Progetto; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Progetto" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE "Progetto" OWNER TO postgres;

\connect "Progetto"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 897 (class 1247 OID 20182)
-- Name: enumalimentazione; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enumalimentazione AS ENUM (
    'Carnivoro',
    'Erbivoro',
    'Onnivoro'
);


ALTER TYPE public.enumalimentazione OWNER TO postgres;

--
-- TOC entry 894 (class 1247 OID 20158)
-- Name: enumclasseanimale; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enumclasseanimale AS ENUM (
    'Mammifero',
    'Pesce',
    'Uccello',
    'Rettile',
    'Anfibio',
    'Porifero',
    'Celenterato',
    'Artropode',
    'Mollusco',
    'Verme',
    'Echinoderma'
);


ALTER TYPE public.enumclasseanimale OWNER TO postgres;

--
-- TOC entry 858 (class 1247 OID 19992)
-- Name: enumdipendente; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enumdipendente AS ENUM (
    'Guida',
    'Ricercatore',
    'Responsabile',
    'Organizzatore',
    'Manutenzione',
    'Sicurezza'
);


ALTER TYPE public.enumdipendente OWNER TO postgres;

--
-- TOC entry 876 (class 1247 OID 20073)
-- Name: enumevento; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enumevento AS ENUM (
    'Musicale',
    'Artistico',
    'Naturalistico'
);


ALTER TYPE public.enumevento OWNER TO postgres;

--
-- TOC entry 888 (class 1247 OID 20134)
-- Name: enumfoglie; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enumfoglie AS ENUM (
    'Filiformi',
    'Aghiformi',
    'Oblunghe',
    'Ovali',
    'Seghettate'
);


ALTER TYPE public.enumfoglie OWNER TO postgres;

--
-- TOC entry 864 (class 1247 OID 20021)
-- Name: enumtour; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enumtour AS ENUM (
    'Flora',
    'Fauna'
);


ALTER TYPE public.enumtour OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 20189)
-- Name: animale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animale (
    id character varying(255) NOT NULL,
    descrizione character varying(255),
    nomelatino character varying(255) NOT NULL,
    alimentazione public.enumalimentazione NOT NULL,
    datanascita timestamp without time zone NOT NULL,
    "età" smallint,
    classe public.enumclasseanimale NOT NULL,
    famiglia character varying(255),
    area integer
);


ALTER TABLE public.animale OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 20115)
-- Name: area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    posizione character varying(255) NOT NULL,
    parco character varying(255) NOT NULL,
    responsabile integer NOT NULL
);


ALTER TABLE public.area OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 20114)
-- Name: area_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_id_seq OWNER TO postgres;

--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 226
-- Name: area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.area_id_seq OWNED BY public.area.id;


--
-- TOC entry 225 (class 1259 OID 20090)
-- Name: bigliettoevento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bigliettoevento (
    id integer NOT NULL,
    ridotto boolean NOT NULL,
    data timestamp without time zone NOT NULL,
    prezzo double precision NOT NULL,
    codicefiscalecliente character varying(255),
    evento character varying(255),
    parco character varying(255),
    CONSTRAINT bigliettoevento_prezzo_check CHECK ((prezzo > (0)::double precision))
);


ALTER TABLE public.bigliettoevento OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 20089)
-- Name: bigliettoevento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bigliettoevento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bigliettoevento_id_seq OWNER TO postgres;

--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 224
-- Name: bigliettoevento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bigliettoevento_id_seq OWNED BY public.bigliettoevento.id;


--
-- TOC entry 222 (class 1259 OID 20048)
-- Name: bigliettotour; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bigliettotour (
    id integer NOT NULL,
    ridotto boolean NOT NULL,
    data timestamp without time zone NOT NULL,
    prezzo double precision NOT NULL,
    codicefiscalecliente character varying(255),
    tour character varying(255),
    parco character varying(255),
    CONSTRAINT bigliettotour_prezzo_check CHECK ((prezzo > (0)::double precision))
);


ALTER TABLE public.bigliettotour OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20047)
-- Name: bigliettotour_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bigliettotour_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bigliettotour_id_seq OWNER TO postgres;

--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 221
-- Name: bigliettotour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bigliettotour_id_seq OWNED BY public.bigliettotour.id;


--
-- TOC entry 214 (class 1259 OID 19977)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    codicefiscale character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    datanascita timestamp without time zone
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 20006)
-- Name: dipendente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dipendente (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    cognome character varying(255) NOT NULL,
    datanascita timestamp without time zone,
    guadagno double precision NOT NULL,
    tipodipendente public.enumdipendente NOT NULL,
    lingueparlate character varying(255),
    specializzazione character varying(255),
    compitospecifico character varying(255),
    corsifrequentati character varying(255),
    parco character varying(255),
    CONSTRAINT dipendente_check CHECK ((((tipodipendente = 'Guida'::public.enumdipendente) AND (lingueparlate IS NOT NULL)) OR ((tipodipendente = 'Ricercatore'::public.enumdipendente) AND (specializzazione IS NOT NULL)) OR ((tipodipendente = 'Manutenzione'::public.enumdipendente) AND (compitospecifico IS NOT NULL)) OR ((tipodipendente = 'Sicurezza'::public.enumdipendente) AND (corsifrequentati IS NOT NULL)) OR (tipodipendente = 'Responsabile'::public.enumdipendente) OR (tipodipendente = 'Organizzatore'::public.enumdipendente)))
);


ALTER TABLE public.dipendente OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 20005)
-- Name: dipendente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dipendente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dipendente_id_seq OWNER TO postgres;

--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 216
-- Name: dipendente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dipendente_id_seq OWNED BY public.dipendente.id;


--
-- TOC entry 223 (class 1259 OID 20079)
-- Name: evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evento (
    id character varying(255) NOT NULL,
    numeropersone integer NOT NULL,
    data timestamp without time zone NOT NULL,
    tipoevento public.enumevento NOT NULL,
    organizzatore integer
);


ALTER TABLE public.evento OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 19984)
-- Name: parco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parco (
    nome character varying(255) NOT NULL,
    luogo character varying(255) NOT NULL,
    dimensione double precision
);


ALTER TABLE public.parco OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 20145)
-- Name: pianta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pianta (
    id character varying(255) NOT NULL,
    descrizione character varying(255),
    nomelatino character varying(255) NOT NULL,
    acquanecessaria double precision NOT NULL,
    locazione character varying(255) NOT NULL,
    tipofoglie public.enumfoglie,
    datatrapianto timestamp without time zone NOT NULL,
    "età" smallint,
    area integer
);


ALTER TABLE public.pianta OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 20031)
-- Name: spiega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spiega (
    dipendente integer NOT NULL,
    tour character varying(255) NOT NULL
);


ALTER TABLE public.spiega OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 20030)
-- Name: spiega_dipendente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spiega_dipendente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spiega_dipendente_seq OWNER TO postgres;

--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 219
-- Name: spiega_dipendente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spiega_dipendente_seq OWNED BY public.spiega.dipendente;


--
-- TOC entry 218 (class 1259 OID 20025)
-- Name: tourguidato; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tourguidato (
    id character varying(255) NOT NULL,
    numeropersone integer NOT NULL,
    data timestamp without time zone NOT NULL,
    tipotour public.enumtour NOT NULL
);


ALTER TABLE public.tourguidato OWNER TO postgres;

--
-- TOC entry 3527 (class 2604 OID 20118)
-- Name: area id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area ALTER COLUMN id SET DEFAULT nextval('public.area_id_seq'::regclass);


--
-- TOC entry 3526 (class 2604 OID 20093)
-- Name: bigliettoevento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettoevento ALTER COLUMN id SET DEFAULT nextval('public.bigliettoevento_id_seq'::regclass);


--
-- TOC entry 3525 (class 2604 OID 20051)
-- Name: bigliettotour id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettotour ALTER COLUMN id SET DEFAULT nextval('public.bigliettotour_id_seq'::regclass);


--
-- TOC entry 3523 (class 2604 OID 20009)
-- Name: dipendente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dipendente ALTER COLUMN id SET DEFAULT nextval('public.dipendente_id_seq'::regclass);


--
-- TOC entry 3524 (class 2604 OID 20034)
-- Name: spiega dipendente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spiega ALTER COLUMN dipendente SET DEFAULT nextval('public.spiega_dipendente_seq'::regclass);


--
-- TOC entry 3726 (class 0 OID 20189)
-- Dependencies: 229
-- Data for Name: animale; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.animale VALUES ('A1A1', 'Aspetto robusto, muniti di lunga coda rettangolare e becco conico e appuntito', 'Uraeginthus bengalus', 'Onnivoro', '2005-11-02 00:00:00', 18, 'Uccello', 'Estrildidae', 1);
INSERT INTO public.animale VALUES ('A1A2', 'Uccello della famiglia degli Scolopacidae dell ordine dei Charadriiformes', 'Tringa glareola', 'Erbivoro', '2016-03-01 00:00:00', 7, 'Uccello', 'Scolopacidae', 1);
INSERT INTO public.animale VALUES ('A1A3', 'Color nero-azzurro nella parte superiore e grigio e grigio-bianco nelle parti inferiori e nel petto', 'Coluber constrictor foxii', 'Carnivoro', '2016-03-04 00:00:00', 7, 'Rettile', 'Colubridae', 1);
INSERT INTO public.animale VALUES ('A1A4', 'È una specie di lucertola diffusa nella Africa meridionale', 'Varanus albigularis', 'Carnivoro', '2019-06-04 00:00:00', 4, 'Rettile', 'Varanidae', 1);
INSERT INTO public.animale VALUES ('A2A1', 'È un pipistrello della famiglia dei Vespertilionidi diffuso nella America settentrionale', 'Myotis lucifugus', 'Carnivoro', '2015-09-26 00:00:00', 8, 'Mammifero', 'Vespertilionidae', 2);
INSERT INTO public.animale VALUES ('A2A2', 'Raggiunge una lunghezza di oltre 40 centimetri per un peso di 700 grammi. Possiede un corpo robusto e zampe corte, utili al suo stile di vita fossorio. La lingua è di un colore che va dal blu-viola al blu cobalto', 'Tiliqua scincoides', 'Carnivoro', '2019-04-16 00:00:00', 4, 'Rettile', 'Scincidae', 2);
INSERT INTO public.animale VALUES ('A2A3', 'È una specie di bovino di grandi dimensioni originario del subcontinente indiano e del sud-est asiatico', 'Bubalus arnee', 'Erbivoro', '2018-02-06 00:00:00', 5, 'Mammifero', 'Bovidae', 2);
INSERT INTO public.animale VALUES ('A2A4', 'Non velenoso appartenente al genere Coluber', 'Coluber constrictor', 'Carnivoro', '2000-10-21 00:00:00', 23, 'Rettile', 'Colubridae', 2);
INSERT INTO public.animale VALUES ('A3A1', 'È un grande uccello rapace prevalentemente terrestre', 'Sagittarius serpentarius', 'Onnivoro', '2006-08-15 00:00:00', 17, 'Uccello', 'Sagittariidae', 3);
INSERT INTO public.animale VALUES ('A3A2', 'È la specie di fenicottero più piccola e più diffusa numericamente in assoluto', 'Phoeniconaias minor', 'Onnivoro', '2018-06-08 00:00:00', 6, 'Uccello', 'Phoenicopteridae', 3);
INSERT INTO public.animale VALUES ('A3A3', 'Uccello nero e bianco', 'Chlidonias leucopterus', 'Onnivoro', '2015-03-03 00:00:00', 8, 'Uccello', 'Laridae', 3);
INSERT INTO public.animale VALUES ('A3A4', 'Presente nelle zone remote del Nord America e della Eurasia', 'Canis lupus', 'Carnivoro', '2008-12-18 00:00:00', 15, 'Mammifero', 'Canidae', 3);
INSERT INTO public.animale VALUES ('A4A1', 'Sono una famiglia di uccelli appartenente allo ordine dei Caprimulgiformi.', 'Chordeiles minor', 'Erbivoro', '2014-07-18 00:00:00', 9, 'Uccello', '	Caprimulgidae', 4);
INSERT INTO public.animale VALUES ('A4A2', 'È diffuso in Benin, Burkina Faso, Camerun, Repubblica Centrafricana', 'Merops nubicus', 'Erbivoro', '2009-05-15 00:00:00', 14, 'Uccello', 'Meropidae', 4);
INSERT INTO public.animale VALUES ('A4A3', 'La lunghezza totale può superare i 140 cm, compresa la coda che misura circa venti centimetri. La apertura alare raggiunge i 230 cm', 'Ardea golieth', 'Onnivoro', '2011-11-18 00:00:00', 12, 'Uccello', 'Ardeidae', 4);
INSERT INTO public.animale VALUES ('A4A4', 'È una specie sudamericana, diffusa nella area al confine fra Brasile, Colombia, Bolivia e Argentina', 'Dasypus septemcincus', 'Onnivoro', '2022-05-02 00:00:00', 1, 'Mammifero', 'Dasypodidae', 4);
INSERT INTO public.animale VALUES ('A5A1', 'Piccoli sauri diffusi in Asia e Oceania', 'Cyrtodactylus louisiadensis', 'Carnivoro', '2015-05-07 00:00:00', 8, 'Rettile', 'Gekkonidae', 5);
INSERT INTO public.animale VALUES ('A5A2', 'Può essere distinto dagli altri per il suo corpo fortemente appiattito, di circa 290 mm', 'Ctenophorus ornatus', 'Carnivoro', '2008-01-23 00:00:00', 15, 'Rettile', 'Agamidae', 5);
INSERT INTO public.animale VALUES ('A5A3', 'Il corpo è lungo sino a 53 cm, con una coda di circa 9 cm. Il dorso e i fianchi sono interamente ricoperti da aculei', 'Tachyglossus aculeatus', 'Erbivoro', '2002-09-14 00:00:00', 21, 'Mammifero', 'Tachiglossidi', 5);
INSERT INTO public.animale VALUES ('A5A4', 'La specie è elencata come in Pericolo nella Lista Rossa IUCN, dal 1986, poiché la popolazione rimanente ammonta a meno di 4.000 esemplari', 'Bubalus', 'Onnivoro', '2017-07-28 00:00:00', 7, 'Mammifero', 'Bovidae', 5);
INSERT INTO public.animale VALUES ('A6A1', 'Presenta un mantello uniformemente di color bruno-vinaccia, con margine alare grigio-bluastro', 'Streptopelia senegalensis', 'Onnivoro', '2020-01-30 00:00:00', 3, 'Uccello', ' Columbidae', 6);
INSERT INTO public.animale VALUES ('A6A2', 'Il suo aspetto è quello tipico dello avvoltoio: testa e collo non hanno un piumaggio sviluppato ma solo un corto piumino', 'Gyps fulvus', 'Carnivoro', '2006-07-20 00:00:00', 17, 'Uccello', ' Accipitridi', 6);
INSERT INTO public.animale VALUES ('A6A3', 'È lo orso più comune in America del Nord. Si incontra in una area geografica che si estende dal nord del Canada e della Alaska al nord del Messico, e dalle coste atlantiche alle coste pacifiche della America del Nord', 'Ursus americanus', 'Carnivoro', '2012-12-15 00:00:00', 11, 'Mammifero', 'Ursidae', 6);
INSERT INTO public.animale VALUES ('A6A4', 'È di colore variabile dal marrone sabbia al grigio-giallo, con strisce nere sulla coda', 'Felis silvestris lybica', 'Carnivoro', '2016-01-29 00:00:00', 7, 'Mammifero', 'Felini', 6);
INSERT INTO public.animale VALUES ('A7A1', 'Ha un muso allungato e appuntito, simile ad una piccola proboscide, e una coda rudimentale', 'Tenrec ecaudatus', 'Erbivoro', '2004-08-04 00:00:00', 19, 'Mammifero', 'Tenrecidae', 7);
INSERT INTO public.animale VALUES ('A7A2', 'È un uccello diffuso nel continente australiano', 'Cereopsis novaehollandiae', 'Onnivoro', '2011-01-27 00:00:00', 12, 'Uccello', 'Anatidi', 7);
INSERT INTO public.animale VALUES ('A7A3', 'Deve il nome scientifico alle penne di colore bianco e nero, simili agli abiti indossati un tempo dai chierici.', 'Ciconia episcopus', 'Onnivoro', '2005-10-24 00:00:00', 18, 'Uccello', 'Ciconiidae', 7);
INSERT INTO public.animale VALUES ('A7A4', 'È una specie esistente di canide di taglia media endemica della parte centrale della America del Sud', 'Dusicyon thous', 'Carnivoro', '2006-02-09 00:00:00', 17, 'Mammifero', 'Canidae', 7);
INSERT INTO public.animale VALUES ('A8A1', 'È il rapace americano più diffuso, e vive dal Canada meridionale al Centro America', 'Buteo jamaicensis', 'Carnivoro', '2020-11-16 00:00:00', 3, 'Uccello', 'Accipitridi', 8);
INSERT INTO public.animale VALUES ('A8A2', 'Il maschio misura 100 cm di lunghezza, per un peso di 9000-10.000 g; la femmina misura 80 cm di lunghezza, per un peso di 3000 g', 'Neotis denhami', 'Onnivoro', '2019-09-23 00:00:00', 30, 'Uccello', ' Otididi', 8);
INSERT INTO public.animale VALUES ('A8A3', 'Questo volatile, lungo 54 cm, è di colore grigio ardesia scuro', 'Hymenolaimus malacorhynchus', 'Erbivoro', '2008-10-20 00:00:00', 15, 'Uccello', 'Anatidi', 8);
INSERT INTO public.animale VALUES ('A8A4', 'Bellissimo uccello acquatico lungo poco più di 30 centimetri', 'Actophilornis africanus', 'Erbivoro', '2021-09-25 00:00:00', 2, 'Uccello', 'Jacanidae', 8);
INSERT INTO public.animale VALUES ('A9A1', 'Pappagallo di taglia attorno ai 35 cm, presenta una colorazione base verde, fronte e corona bianche', 'Deroptyus accipitrinus', 'Onnivoro', '2013-06-27 00:00:00', 10, 'Uccello', ' Psittacidi', 9);
INSERT INTO public.animale VALUES ('A9A2', 'Questo uccello vive nella Africa centrale e meridionale', 'Vanellus armatus', 'Erbivoro', '2014-06-13 00:00:00', 9, 'Uccello', ' Charadriidae', 9);
INSERT INTO public.animale VALUES ('A9A3', 'Si tratta di uccelli dall aspetto slanciato, muniti di lunga coda rettangolare e becco conico e appuntito', 'Uraeginthus granatina', 'Onnivoro', '2012-07-04 00:00:00', 11, 'Uccello', ' Estrildidi', 9);
INSERT INTO public.animale VALUES ('A9A4', 'Vive in ambienti aridi ed è lunga circa 60 cm di cui la metà spetta alla sola coda', 'Heloderma horridum', 'Carnivoro', '2012-05-02 00:00:00', 11, 'Rettile', '	Helodermatidae', 9);
INSERT INTO public.animale VALUES ('A10A1', 'È di un colore tra il rosso e il marrone, il muso verso il grigio; il mantello è fulvo in estate', 'Capreolus capreolus', 'Erbivoro', '2008-10-15 00:00:00', 15, 'Mammifero', 'Cervidae', 10);
INSERT INTO public.animale VALUES ('A10A2', 'La lunghezza ed il peso medi di questa specie adulta rientrano tra 250/300cm x 10/15kg i maschi e tra 250/350cm x 10/20kg le femmine', 'Boa constrictor', 'Carnivoro', '2018-05-01 00:00:00', 5, 'Rettile', 'Boidi', 10);
INSERT INTO public.animale VALUES ('A10A3', 'Il collo è muscoloso e sorregge una testa adornata da due grandi corna ad anelli che possono raggiungere i 150 cm di lunghezza', 'Oryx gazella', 'Onnivoro', '2005-07-10 00:00:00', 18, 'Mammifero', 'Bovidae', 10);
INSERT INTO public.animale VALUES ('A10A4', 'È un piccolo uccello passeriforme che nidifica nella Africa meridionale', 'Nectarinia chalybea', 'Onnivoro', '2015-10-22 00:00:00', 8, 'Uccello', '	Nectariniidae', 10);
INSERT INTO public.animale VALUES ('A11A1', 'È lungo da 19 a 21 cm e pesa dai 30 ai 48 gr', 'Pycnonotus nigricans', 'Onnivoro', '2002-07-26 00:00:00', 21, 'Uccello', ' Pycnonotidae', 11);
INSERT INTO public.animale VALUES ('A11A2', 'Il pelo è molto folto e di maggiore lunghezza nella parte inferiore del corpo e nella coda', 'Bos mutus', 'Erbivoro', '2011-10-31 00:00:00', 12, 'Mammifero', 'Bovidae', 11);
INSERT INTO public.animale VALUES ('A11A3', 'Vive in Australia, Nuova Zelanda e Nuova Caledonia, nonché sulle isole limitrofe', 'Larus novaehollandiae', 'Carnivoro', '2004-08-04 00:00:00', 19, 'Uccello', 'Laridi', 11);
INSERT INTO public.animale VALUES ('A11A4', 'Vive su gran parte delle catene montuose della Asia centrale.', 'Ovis ammon', 'Erbivoro', '2001-10-06 00:00:00', 22, 'Mammifero', 'Bovidae', 11);
INSERT INTO public.animale VALUES ('A12A1', 'Con i suoi 20 cm di lunghezza per oltre 100 g di peso, questo ragno è uno dei rappresentanti più grandi al mondo dell intero ordine Araneae', 'Lasiodora parahybana', 'Carnivoro', '2006-04-12 00:00:00', 17, 'Rettile', 'Theraphosidae', 12);
INSERT INTO public.animale VALUES ('A12A2', 'Vive nella parte occidentale dell areale del panda rosso, in particolare in Nepal, Assam, Sikkim e Bhutan', ' Ailurus fulgens', 'Onnivoro', '2003-06-02 00:00:00', 20, 'Mammifero', 'Ailuridae', 12);
INSERT INTO public.animale VALUES ('A12A3', 'Vive nelle regioni montuose del Sichuan', 'Ailuropoda melanoleuca', 'Onnivoro', '2000-04-26 00:00:00', 23, 'Mammifero', 'Ursidae', 12);
INSERT INTO public.animale VALUES ('A12A4', 'Diffusa in Australia settentrionale e Nuova Guinea', 'Macropus agilis', 'Carnivoro', '2019-08-10 00:00:00', 4, 'Mammifero', 'Macropodidae', 12);
INSERT INTO public.animale VALUES ('A13A1', 'È la specie di dimensioni maggiori: il peso varia tra 15 e 31 kg, la lunghezza del corpo può raggiungere 115 cm, quella della coda i 70 cm', 'Papio ursinus', 'Onnivoro', '2009-04-15 00:00:00', 14, 'Mammifero', 'Cercopithecidae', 13);
INSERT INTO public.animale VALUES ('A13A2', 'Medie dimensioni originaria delle pampas', 'Pseudalopex gymnocercus', 'Carnivoro', '2017-06-12 00:00:00', 6, 'Mammifero', 'Canidae', 13);
INSERT INTO public.animale VALUES ('A13A3', 'Diffusa in America del Nord e nell estremità nord-orientale dell Asia', 'Grus canadensis', 'Erbivoro', '2011-11-04 00:00:00', 12, 'Uccello', 'Gruidae', 13);
INSERT INTO public.animale VALUES ('A13A4', 'È un grande uccello trampoliere', 'Ephipplorhynchus senegalensis', 'Erbivoro', '2004-08-02 00:00:00', 19, 'Uccello', 'Ciconiidae', 13);
INSERT INTO public.animale VALUES ('A14A1', 'È la tartaruga terrestre più grande al mondo', 'Geochelone elephantopus', 'Carnivoro', '2002-09-22 00:00:00', 21, 'Rettile', 'Testudinidae', 14);
INSERT INTO public.animale VALUES ('A14A2', 'Caratteristici sono gli unghioni che armano le cinque dita degli arti anteriori', 'Priodontes maximus', 'Erbivoro', '2011-06-17 00:00:00', 12, 'Mammifero', 'Chlamyphoridae', 14);
INSERT INTO public.animale VALUES ('A14A3', 'Abita le aree aride di Namibia, Botswana, Zimbabwe occidentale e meridionale, Mozambico meridionale e Sudafrica', 'Hyaena brunnea', 'Onnivoro', '2006-06-28 00:00:00', 17, 'Mammifero', 'Hyaenidae', 14);
INSERT INTO public.animale VALUES ('A14A4', 'Dopo la tigre, è il più grande dei cinque grandi felidi del genere Panthera', 'Panthera Leo', 'Carnivoro', '2022-07-02 00:00:00', 1, 'Mammifero', 'Felidae', 14);
INSERT INTO public.animale VALUES ('A15A1', 'Coda cuneiforme, iride marrone scura con un anello oculare grigio, becco grigio-bluastro chiaro', 'Pterocles gutturalis', 'Erbivoro', '2006-07-26 00:00:00', 17, 'Uccello', 'Pteroclidae', 15);
INSERT INTO public.animale VALUES ('A15A2', 'È robusto, abbastanza basso sulle zampe, con una coda relativamente lunga per un animale imparentato con le linci delle regioni fredde-temperate. La testa, piccola, porta orecchie molto lunghe, appuntite', 'Felis caracal', 'Carnivoro', '2008-04-12 00:00:00', 15, 'Mammifero', 'Felidae', 15);
INSERT INTO public.animale VALUES ('A15A3', 'Diffuso negli Stati Uniti e nel Canada meridionale lungo la catena delle Montagne Rocciose', 'Spermophilus lateralis', 'Erbivoro', '2002-05-02 00:00:00', 21, 'Mammifero', 'Sciuridae', 15);
INSERT INTO public.animale VALUES ('A15A4', 'Abita la volta delle foreste pluviali dall America centrale al Brasile e all Argentina settentrionale', 'Bradypus tridactylus', 'Erbivoro', '2022-01-03 00:00:00', 1, 'Mammifero', 'Bradypodidae', 15);
INSERT INTO public.animale VALUES ('A16A1', 'Presente in gran parte del Nordamerica, compreso il Canada meridionale, gli Stati Uniti e il Messico settentrionale', 'Mephitis mephitis', 'Onnivoro', '2001-10-12 00:00:00', 22, 'Mammifero', 'Mephitidae', 16);
INSERT INTO public.animale VALUES ('A16A2', 'Alta 60-90 centimetri e pesa tra i 13 e i 16 kilogrammi', 'Gazella thompsonii', 'Onnivoro', '2012-08-10 00:00:00', 11, 'Mammifero', 'Bovidae', 16);
INSERT INTO public.animale VALUES ('A16A3', 'È un cosiddetto predatore alfa, ovvero si colloca all apice della catena alimentare, non avendo predatori in natura, a parte l uomo', 'Panthera Tigris', 'Carnivoro', '2005-02-10 00:00:00', 18, 'Mammifero', 'Felidae', 16);
INSERT INTO public.animale VALUES ('A16A4', 'Ha un lungo becco appuntito e le palpebre bluastre', 'Cacatua tenuirostris', 'Onnivoro', '2017-05-02 00:00:00', 6, 'Uccello', 'Cacatuidae', 16);
INSERT INTO public.animale VALUES ('A17A1', 'Diffuso in Canada e nella parte nord-orientale degli Stati Uniti', 'Marmota monax', 'Erbivoro', '2000-02-24 00:00:00', 23, 'Mammifero', 'Sciuridae', 17);
INSERT INTO public.animale VALUES ('A17A2', 'Felino solitario e opportunista, il leopardo è ampiamente diffuso in Africa e in Asia sud-orientale', 'Panthera Pardus', 'Carnivoro', '2015-10-14 00:00:00', 8, 'Mammifero', 'Felidae', 17);
INSERT INTO public.animale VALUES ('A17A3', 'È una specie domestica che deriva dal Guanaco e a questo assomiglia per la morfologia e per il comportamento', 'Lama glama', 'Erbivoro', '2022-01-22 00:00:00', 1, 'Mammifero', 'Camelidae', 17);
INSERT INTO public.animale VALUES ('A17A4', 'Aspetto robusto e slanciato, muniti di grossa testa arrotondata, becco conico e robusto di media lunghezza', 'Dicrurus adsimilis', 'Erbivoro', '2007-02-10 00:00:00', 16, 'Uccello', 'Dicruridae', 17);
INSERT INTO public.animale VALUES ('A18A1', 'Ha il piumaggio completamente bianco che non cambia nell arco dell anno. Il becco è generalmente giallo e le zampe sono di colore nerastro o giallo sbiadito alla base durante l anno', 'Casmerodius albus', 'Onnivoro', '2022-02-21 00:00:00', 1, 'Uccello', 'Ardeidae', 18);
INSERT INTO public.animale VALUES ('A18A2', 'Diffuso nel continente americano', 'Egretta thula', 'Erbivoro', '2017-01-25 00:00:00', 6, 'Uccello', 'Ardeidae', 18);
INSERT INTO public.animale VALUES ('A18A3', 'Vive prevalentemente in stagni di acqua dolce e paludi', 'Alligator mississippiensis', 'Carnivoro', '2013-04-02 00:00:00', 10, 'Rettile', 'Alligatoridae', 18);
INSERT INTO public.animale VALUES ('A18A4', 'Il capo è rosso vivo, petto e penne remiganti sono bianche ed il resto del corpo è grigio scuro', 'Melanerpes erythrocephalus', 'Erbivoro', '2022-05-02 00:00:00', 1, 'Uccello', 'Picidae', 18);
INSERT INTO public.animale VALUES ('A19A1', 'Collo lungo diffusa in alcune regioni dell Africa orientale', 'Litrocranius walleri', 'Onnivoro', '2013-02-19 00:00:00', 10, 'Mammifero', 'Bovidae', 19);
INSERT INTO public.animale VALUES ('A19A2', 'Nativa della regione artica', 'Alopex lagopus', 'Erbivoro', '2004-12-14 00:00:00', 19, 'Mammifero', 'Canidae', 19);
INSERT INTO public.animale VALUES ('A19A3', 'La testa ha forma triangolare, le orecchie sono piccole e prive di pelo, gli occhi sono invece molto grandi', 'Petaurus breviceps', 'Erbivoro', '2008-01-27 00:00:00', 15, 'Mammifero', 'Petauridae', 19);
INSERT INTO public.animale VALUES ('A19A4', 'Aspetto robusto e slanciato, muniti di piccola testa arrotondata con un becco massiccio', 'Corvus albicollis', 'Onnivoro', '2003-01-01 00:00:00', 20, 'Uccello', 'Corvidae', 19);
INSERT INTO public.animale VALUES ('A20A1', 'La testa e il collo del maschio sono ricoperte di piume blu elettrico dai riflessi metallici. La zona intorno all occhio è nuda,', 'Pavo cristatus', 'Erbivoro', '2005-07-30 00:00:00', 18, 'Uccello', 'Phasianidae', 20);
INSERT INTO public.animale VALUES ('A20A2', 'È stato trovato in molte zone del Canada', 'Papilio canadensis', 'Onnivoro', '2013-10-31 00:00:00', 10, 'Artropode', 'Papilionidae', 20);
INSERT INTO public.animale VALUES ('A20A3', 'Ha bianche la testa, il petto, la parte anteriore sotto le ali e la coda', 'Haliaetus leucogaster', 'Erbivoro', '2020-11-03 00:00:00', 3, 'Uccello', 'Accipitridae', 20);
INSERT INTO public.animale VALUES ('A20A4', 'La testa è grande, il muso è ampio e arrotondato, gli occhi sono di medie dimensioni. Le squame sono lunghe, lisce e oblique', 'Naja haje', 'Carnivoro', '2005-08-13 00:00:00', 18, 'Rettile', 'Elapidae', 20);


--
-- TOC entry 3724 (class 0 OID 20115)
-- Dependencies: 227
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.area VALUES (1, 'Sentiero delle Cascate', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3);
INSERT INTO public.area VALUES (2, 'Bosco degli Ulivi', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3);
INSERT INTO public.area VALUES (3, 'Radura dei Cervi', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3);
INSERT INTO public.area VALUES (4, 'Laghetto delle Ninfee', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3);
INSERT INTO public.area VALUES (5, 'Gola del Torrente', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3);
INSERT INTO public.area VALUES (6, 'Prato dei Fiori', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18);
INSERT INTO public.area VALUES (7, 'Collina Panoramica', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18);
INSERT INTO public.area VALUES (8, 'Valle degli Uccelli', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18);
INSERT INTO public.area VALUES (9, 'Passeggiata dei Pini', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18);
INSERT INTO public.area VALUES (10, 'Rifugio Alpino', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18);
INSERT INTO public.area VALUES (11, 'Laghi Glaciali', 'Vicenza', 'Riserva Naturale Misquilese', 21);
INSERT INTO public.area VALUES (12, 'Faggeta Millenaria', 'Vicenza', 'Riserva Naturale Misquilese', 21);
INSERT INTO public.area VALUES (13, 'Valle Incantata', 'Vicenza', 'Riserva Naturale Misquilese', 21);
INSERT INTO public.area VALUES (14, 'Oasi Avifaunistica', 'Vicenza', 'Riserva Naturale Misquilese', 21);
INSERT INTO public.area VALUES (15, 'Giardino delle Farfalle', 'Vicenza', 'Riserva Naturale Misquilese', 21);
INSERT INTO public.area VALUES (16, 'Fontana delle Sorgenti', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37);
INSERT INTO public.area VALUES (17, 'Belvedere sul Fiume', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37);
INSERT INTO public.area VALUES (18, 'Bosco delle Fate', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37);
INSERT INTO public.area VALUES (19, 'Sorgente Cristallina', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37);
INSERT INTO public.area VALUES (20, 'Prato dei Gigli', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37);


--
-- TOC entry 3722 (class 0 OID 20090)
-- Dependencies: 225
-- Data for Name: bigliettoevento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bigliettoevento VALUES (1, false, '2023-06-27 00:00:00', 13.54, '699-29-0318', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (2, true, '2023-09-16 00:00:00', 10, '784-49-7651', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (3, true, '2023-08-13 00:00:00', 10, '154-56-9692', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (4, false, '2023-07-01 00:00:00', 26.1, '836-85-0679', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (5, false, '2023-10-18 00:00:00', 18.37, '120-26-1291', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (6, false, '2023-08-23 00:00:00', 28.52, '707-89-6237', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (7, true, '2023-10-08 00:00:00', 10, '139-97-1893', '5', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (8, false, '2023-01-23 00:00:00', 11.22, '423-07-2436', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (9, true, '2023-05-06 00:00:00', 10, '439-91-1723', '1', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (10, true, '2023-03-22 00:00:00', 10, '680-13-5568', '2', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (11, false, '2023-07-21 00:00:00', 23.75, '343-11-1370', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (12, false, '2023-07-17 00:00:00', 25.52, '166-31-8683', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (13, false, '2023-08-24 00:00:00', 15.3, '480-69-2766', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (14, false, '2023-07-30 00:00:00', 27.91, '492-59-8797', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (15, false, '2023-03-24 00:00:00', 15.52, '650-03-0408', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (16, false, '2023-08-29 00:00:00', 23.39, '464-17-9230', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (17, true, '2023-07-19 00:00:00', 10, '590-26-4546', '2', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (18, false, '2023-01-23 00:00:00', 18.76, '253-62-4244', '3', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (19, false, '2023-07-08 00:00:00', 13.33, '612-54-6736', '3', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (20, true, '2023-10-13 00:00:00', 10, '449-55-3114', '5', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (21, true, '2023-01-04 00:00:00', 10, '397-99-8395', '3', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (22, false, '2023-05-24 00:00:00', 15.89, '196-78-3197', '3', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (23, true, '2023-03-11 00:00:00', 10, '544-13-0833', '3', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (24, false, '2023-12-22 00:00:00', 24.17, '713-37-7873', '3', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (25, true, '2023-07-27 00:00:00', 10, '730-93-0076', '3', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (26, true, '2023-08-15 00:00:00', 10, '363-26-4065', '3', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (27, true, '2023-11-02 00:00:00', 10, '661-41-3101', '4', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (28, true, '2023-02-07 00:00:00', 10, '293-15-6901', '4', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (29, false, '2023-07-16 00:00:00', 26.13, '206-99-3195', '4', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (30, true, '2023-11-18 00:00:00', 10, '166-09-3544', '5', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (31, false, '2023-03-23 00:00:00', 17.44, '126-36-9862', '4', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (32, true, '2023-01-27 00:00:00', 10, '830-81-4564', '5', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (33, true, '2023-02-20 00:00:00', 10, '218-97-3505', '4', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (34, false, '2023-05-28 00:00:00', 13.3, '724-82-7580', '4', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (35, true, '2023-04-30 00:00:00', 10, '143-30-5420', '4', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (36, false, '2023-11-10 00:00:00', 16.41, '231-46-4162', '4', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (37, true, '2023-07-09 00:00:00', 10, '483-29-5126', '6', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (38, false, '2023-04-27 00:00:00', 28.42, '609-22-3888', '6', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (39, false, '2023-08-20 00:00:00', 17.52, '237-53-9877', '6', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (40, true, '2023-10-18 00:00:00', 10, '121-64-6056', '6', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (41, true, '2023-01-05 00:00:00', 10, '285-26-0230', '6', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (42, false, '2023-05-25 00:00:00', 15.89, '826-33-6034', '6', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (43, true, '2023-03-11 00:00:00', 10, '783-22-5493', '6', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (44, false, '2023-11-22 00:00:00', 24.17, '544-97-5975', '6', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (45, true, '2023-03-27 00:00:00', 10, '835-10-3948', '7', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettoevento VALUES (46, true, '2023-05-15 00:00:00', 10, '175-75-7878', '7', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (47, true, '2023-01-02 00:00:00', 10, '531-01-5962', '7', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (48, true, '2023-10-07 00:00:00', 10, '738-26-1525', '7', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (49, false, '2023-11-16 00:00:00', 26.13, '702-08-9656', '7', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (50, true, '2023-06-18 00:00:00', 10, '238-19-1124', '5', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettoevento VALUES (51, false, '2023-07-23 00:00:00', 17.44, '131-89-1859', '7', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (52, true, '2023-09-27 00:00:00', 10, '377-04-2790', '5', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (53, true, '2023-08-20 00:00:00', 10, '173-46-0895', '7', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (54, false, '2023-05-28 00:00:00', 13.3, '818-30-2512', '7', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (55, true, '2023-04-30 00:00:00', 10, '631-71-6521', '8', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettoevento VALUES (56, false, '2023-03-10 00:00:00', 16.41, '168-07-9718', '8', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (57, true, '2023-10-09 00:00:00', 10, '634-93-5729', '8', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (58, false, '2023-09-27 00:00:00', 28.42, '289-73-0768', '8', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (59, false, '2023-12-20 00:00:00', 17.52, '325-80-9772', '8', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettoevento VALUES (60, true, '2023-11-18 00:00:00', 10, '826-43-7893', '8', 'Parco Nazionale dello Stelvio');


--
-- TOC entry 3719 (class 0 OID 20048)
-- Dependencies: 222
-- Data for Name: bigliettotour; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bigliettotour VALUES (1, false, '2023-05-08 00:00:00', 18.59, '610-86-1925', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (2, true, '2023-10-14 00:00:00', 10, '850-20-1383', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (3, true, '2023-05-09 00:00:00', 10, '542-70-7587', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (4, true, '2023-02-11 00:00:00', 10, '624-83-2281', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (5, true, '2023-07-01 00:00:00', 10, '321-59-4010', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (6, false, '2023-03-04 00:00:00', 26.75, '462-45-2627', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (7, true, '2023-03-05 00:00:00', 10, '447-75-9453', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (8, false, '2023-11-22 00:00:00', 14.21, '603-97-2041', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (9, true, '2023-10-14 00:00:00', 10, '383-58-9178', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (10, false, '2023-11-23 00:00:00', 17.49, '429-90-5672', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (11, true, '2023-01-04 00:00:00', 10, '168-57-6934', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (12, true, '2023-08-13 00:00:00', 10, '716-10-6207', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (13, true, '2023-02-11 00:00:00', 10, '864-39-9520', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (14, true, '2023-05-02 00:00:00', 10, '817-56-2969', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (15, false, '2023-01-06 00:00:00', 29.97, '274-11-5075', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (16, false, '2023-10-20 00:00:00', 19.15, '568-72-0542', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (17, true, '2023-12-27 00:00:00', 10, '339-79-6748', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (18, true, '2023-01-08 00:00:00', 10, '437-46-6883', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (19, true, '2023-11-20 00:00:00', 10, '390-62-9877', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (20, false, '2023-09-12 00:00:00', 13.43, '218-29-5617', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (21, false, '2023-11-13 00:00:00', 13.52, '791-87-5229', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (22, false, '2023-04-11 00:00:00', 16.98, '434-97-0717', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (23, false, '2023-12-25 00:00:00', 27.35, '892-19-0009', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (24, true, '2023-05-11 00:00:00', 10, '169-65-7563', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (25, false, '2023-08-30 00:00:00', 28.82, '687-05-3528', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (26, false, '2023-03-05 00:00:00', 25.95, '123-12-7561', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (27, false, '2023-01-27 00:00:00', 21.76, '512-68-2495', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (28, true, '2023-02-11 00:00:00', 10, '651-18-3600', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (29, false, '2023-02-26 00:00:00', 21.9, '821-84-4678', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (30, false, '2023-11-23 00:00:00', 29.26, '404-87-7274', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (31, false, '2023-02-06 00:00:00', 18.64, '876-27-8044', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (32, false, '2023-02-09 00:00:00', 18.76, '168-77-9561', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (33, true, '2023-02-24 00:00:00', 10, '765-34-6733', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (34, false, '2023-04-25 00:00:00', 19.15, '299-51-9664', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (35, true, '2023-06-30 00:00:00', 10, '119-97-3751', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (36, true, '2023-04-15 00:00:00', 10, '655-24-1339', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (37, false, '2023-08-06 00:00:00', 20.62, '277-06-0346', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (38, false, '2023-12-12 00:00:00', 25.7, '758-34-6771', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (39, true, '2023-10-11 00:00:00', 10, '329-68-0127', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (40, false, '2023-08-19 00:00:00', 29.18, '870-05-6425', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (41, false, '2023-10-13 00:00:00', 13.52, '391-74-6833', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (42, false, '2023-05-11 00:00:00', 16.98, '100-30-1935', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (43, false, '2023-11-25 00:00:00', 27.35, '865-67-4633', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (44, true, '2023-02-11 00:00:00', 10, '506-28-2861', 'A13BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (45, false, '2023-07-24 00:00:00', 28.82, '538-89-9886', 'A12BC', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.bigliettotour VALUES (46, false, '2023-03-05 00:00:00', 25.95, '727-60-7349', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (47, false, '2023-02-27 00:00:00', 21.76, '298-24-3122', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (48, true, '2023-03-11 00:00:00', 10, '374-17-6525', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (49, false, '2023-10-26 00:00:00', 21.9, '808-22-3703', 'A14BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (50, false, '2023-08-23 00:00:00', 29.26, '784-21-8836', 'A15BC', 'Parco Nazionale di Camponogara');
INSERT INTO public.bigliettotour VALUES (51, false, '2023-06-06 00:00:00', 18.64, '265-79-3790', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (52, false, '2023-01-09 00:00:00', 18.76, '152-19-0103', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (53, true, '2023-12-24 00:00:00', 10, '844-85-7794', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (54, false, '2023-07-25 00:00:00', 19.15, '474-86-3989', 'A17BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (55, true, '2023-09-30 00:00:00', 10, '813-19-2972', 'A16BC', 'Riserva Naturale Misquilese');
INSERT INTO public.bigliettotour VALUES (56, true, '2023-02-15 00:00:00', 10, '522-31-4106', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (57, false, '2023-01-06 00:00:00', 20.62, '316-40-0889', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (58, false, '2023-07-12 00:00:00', 25.7, '142-46-4522', 'A19BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (59, true, '2023-11-11 00:00:00', 10, '581-26-6071', 'A18BC', 'Parco Nazionale dello Stelvio');
INSERT INTO public.bigliettotour VALUES (60, false, '2023-08-19 00:00:00', 29.18, '520-88-6112', 'A19BC', 'Parco Nazionale dello Stelvio');


--
-- TOC entry 3711 (class 0 OID 19977)
-- Dependencies: 214
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES ('610-86-1925', 'Tucker', 'Gerish', '1993-06-07 00:00:00');
INSERT INTO public.cliente VALUES ('850-20-1383', 'Cordi', 'Nettle', '1998-07-11 00:00:00');
INSERT INTO public.cliente VALUES ('542-70-7587', 'Darius', 'Assad', '1997-06-05 00:00:00');
INSERT INTO public.cliente VALUES ('624-83-2281', 'Elinor', 'Scholig', '1987-08-30 00:00:00');
INSERT INTO public.cliente VALUES ('321-59-4010', 'Johna', 'Dibbe', '1989-07-07 00:00:00');
INSERT INTO public.cliente VALUES ('462-45-2627', 'Immanuel', 'Leworthy', '2001-02-10 00:00:00');
INSERT INTO public.cliente VALUES ('447-75-9453', 'Darren', 'Mee', '1999-09-26 00:00:00');
INSERT INTO public.cliente VALUES ('603-97-2041', 'Meggy', 'Curson', '1985-04-21 00:00:00');
INSERT INTO public.cliente VALUES ('383-58-9178', 'Alford', 'Wittey', '1996-02-09 00:00:00');
INSERT INTO public.cliente VALUES ('429-90-5672', 'Hercule', 'Ray', '1997-04-23 00:00:00');
INSERT INTO public.cliente VALUES ('168-57-6934', 'Jeralee', 'Yakov', '1991-03-29 00:00:00');
INSERT INTO public.cliente VALUES ('716-10-6207', 'Grace', 'Ewles', '2001-01-24 00:00:00');
INSERT INTO public.cliente VALUES ('864-39-9520', 'Wilmar', 'Coil', '2005-08-23 00:00:00');
INSERT INTO public.cliente VALUES ('817-56-2969', 'Alair', 'Jain', '2001-02-12 00:00:00');
INSERT INTO public.cliente VALUES ('274-11-5075', 'Ludvig', 'Zavattero', '1988-02-05 00:00:00');
INSERT INTO public.cliente VALUES ('568-72-0542', 'Martainn', 'Kupisz', '1996-09-05 00:00:00');
INSERT INTO public.cliente VALUES ('339-79-6748', 'Tucky', 'Ivan', '1996-10-27 00:00:00');
INSERT INTO public.cliente VALUES ('437-46-6883', 'Andriana', 'Hook', '1990-08-07 00:00:00');
INSERT INTO public.cliente VALUES ('390-62-9877', 'Letizia', 'Sloegrave', '1995-12-09 00:00:00');
INSERT INTO public.cliente VALUES ('218-29-5617', 'Boyce', 'Calvert', '1994-04-14 00:00:00');
INSERT INTO public.cliente VALUES ('791-87-5229', 'Rodolph', 'Sedge', '2001-06-19 00:00:00');
INSERT INTO public.cliente VALUES ('434-97-0717', 'Rosene', 'Trunby', '1985-02-08 00:00:00');
INSERT INTO public.cliente VALUES ('892-19-0009', 'Mahmud', 'Beverstock', '1992-04-10 00:00:00');
INSERT INTO public.cliente VALUES ('169-65-7563', 'Jake', 'Blade', '1998-08-25 00:00:00');
INSERT INTO public.cliente VALUES ('687-05-3528', 'Gleda', 'Langworthy', '1991-07-22 00:00:00');
INSERT INTO public.cliente VALUES ('123-12-7561', 'Corinna', 'Salling', '2002-02-04 00:00:00');
INSERT INTO public.cliente VALUES ('512-68-2495', 'Aurlie', 'Dell Casa', '1986-07-30 00:00:00');
INSERT INTO public.cliente VALUES ('651-18-3600', 'Timmie', 'Terram', '1998-12-09 00:00:00');
INSERT INTO public.cliente VALUES ('821-84-4678', 'Gael', 'Durrans', '1992-06-24 00:00:00');
INSERT INTO public.cliente VALUES ('404-87-7274', 'Robert', 'Guyot', '1991-07-31 00:00:00');
INSERT INTO public.cliente VALUES ('876-27-8044', 'Sibley', 'Venney', '2001-04-20 00:00:00');
INSERT INTO public.cliente VALUES ('168-77-9561', 'Donny', 'Bethell', '1994-08-04 00:00:00');
INSERT INTO public.cliente VALUES ('765-34-6733', 'Aldwin', 'McAline', '1992-08-08 00:00:00');
INSERT INTO public.cliente VALUES ('299-51-9664', 'Jobey', 'Bluck', '1989-12-01 00:00:00');
INSERT INTO public.cliente VALUES ('119-97-3751', 'Henrietta', 'Laux', '2001-01-18 00:00:00');
INSERT INTO public.cliente VALUES ('655-24-1339', 'Pauletta', 'Baccas', '2000-08-19 00:00:00');
INSERT INTO public.cliente VALUES ('277-06-0346', 'Janina', 'Altimas', '1991-10-15 00:00:00');
INSERT INTO public.cliente VALUES ('758-34-6771', 'Keenan', 'Desvignes', '1995-07-28 00:00:00');
INSERT INTO public.cliente VALUES ('329-68-0127', 'Warner', 'Thewles', '1985-08-16 00:00:00');
INSERT INTO public.cliente VALUES ('870-05-6425', 'Natka', 'Heavens', '1988-11-26 00:00:00');
INSERT INTO public.cliente VALUES ('699-29-0318', 'Luella', 'Chaperlin', '2005-06-21 00:00:00');
INSERT INTO public.cliente VALUES ('784-49-7651', 'Vitia', 'Ralestone', '2001-02-17 00:00:00');
INSERT INTO public.cliente VALUES ('154-56-9692', 'Gael', 'Corcut', '1997-06-17 00:00:00');
INSERT INTO public.cliente VALUES ('836-85-0679', 'Chrissie', 'Sparrow', '2004-04-07 00:00:00');
INSERT INTO public.cliente VALUES ('120-26-1291', 'Elsinore', 'Kehri', '1985-06-19 00:00:00');
INSERT INTO public.cliente VALUES ('707-89-6237', 'Meryl', 'Thurlby', '1997-08-13 00:00:00');
INSERT INTO public.cliente VALUES ('139-97-1893', 'Randa', 'Brompton', '1990-05-13 00:00:00');
INSERT INTO public.cliente VALUES ('423-07-2436', 'Myrlene', 'Knotte', '2000-07-21 00:00:00');
INSERT INTO public.cliente VALUES ('439-91-1723', 'Wood', 'Rymill', '1992-08-03 00:00:00');
INSERT INTO public.cliente VALUES ('680-13-5568', 'Flynn', 'Hrihorovich', '1995-02-28 00:00:00');
INSERT INTO public.cliente VALUES ('343-11-1370', 'Dalton', 'Harewood', '1987-04-15 00:00:00');
INSERT INTO public.cliente VALUES ('166-31-8683', 'Isaac', 'Dogerty', '2000-03-29 00:00:00');
INSERT INTO public.cliente VALUES ('480-69-2766', 'Gage', 'Jeaffreson', '1992-09-13 00:00:00');
INSERT INTO public.cliente VALUES ('492-59-8797', 'Marguerite', 'McGirl', '1996-08-23 00:00:00');
INSERT INTO public.cliente VALUES ('650-03-0408', 'Joshuah', 'Dolman', '2002-12-05 00:00:00');
INSERT INTO public.cliente VALUES ('464-17-9230', 'Alexander', 'Cawley', '1994-09-18 00:00:00');
INSERT INTO public.cliente VALUES ('590-26-4546', 'Rolland', 'Matthew', '1999-09-15 00:00:00');
INSERT INTO public.cliente VALUES ('253-62-4244', 'Jocelin', 'Toler', '1987-05-15 00:00:00');
INSERT INTO public.cliente VALUES ('612-54-6736', 'Gris', 'Poller', '1999-06-03 00:00:00');
INSERT INTO public.cliente VALUES ('449-55-3114', 'Winny', 'Agnew', '1990-02-21 00:00:00');
INSERT INTO public.cliente VALUES ('397-99-8395', 'Danny', 'Labone', '2003-05-21 00:00:00');
INSERT INTO public.cliente VALUES ('196-78-3197', 'Mayer', 'Spirit', '1994-08-12 00:00:00');
INSERT INTO public.cliente VALUES ('544-13-0833', 'Vidovic', 'Dreye', '1993-12-18 00:00:00');
INSERT INTO public.cliente VALUES ('713-37-7873', 'Sheffy', 'Stansby', '2005-09-12 00:00:00');
INSERT INTO public.cliente VALUES ('730-93-0076', 'Rebekah', 'Farra', '1993-07-26 00:00:00');
INSERT INTO public.cliente VALUES ('363-26-4065', 'Christa', 'Arnolds', '2005-02-18 00:00:00');
INSERT INTO public.cliente VALUES ('661-41-3101', 'Lavena', 'Bellino', '1992-03-11 00:00:00');
INSERT INTO public.cliente VALUES ('293-15-6901', 'Barbra', 'Enrdigo', '1989-10-21 00:00:00');
INSERT INTO public.cliente VALUES ('206-99-3195', 'Angelita', 'Breffit', '1995-11-11 00:00:00');
INSERT INTO public.cliente VALUES ('166-09-3544', 'Jan', 'Bearsmore', '1994-02-24 00:00:00');
INSERT INTO public.cliente VALUES ('126-36-9862', 'Tersina', 'Juschka', '2003-11-06 00:00:00');
INSERT INTO public.cliente VALUES ('830-81-4564', 'Marchall', 'Smiz', '1997-07-30 00:00:00');
INSERT INTO public.cliente VALUES ('218-97-3505', 'Orella', 'Burgyn', '1996-02-13 00:00:00');
INSERT INTO public.cliente VALUES ('724-82-7580', 'Phaidra', 'Buckthought', '1999-07-05 00:00:00');
INSERT INTO public.cliente VALUES ('143-30-5420', 'Vinny', 'Fortey', '1986-01-17 00:00:00');
INSERT INTO public.cliente VALUES ('231-46-4162', 'Naomi', 'Scocroft', '1990-11-29 00:00:00');
INSERT INTO public.cliente VALUES ('483-29-5126', 'Gary', 'Swett', '1991-09-19 00:00:00');
INSERT INTO public.cliente VALUES ('609-22-3888', 'Sawyer', 'Cumine', '1989-01-24 00:00:00');
INSERT INTO public.cliente VALUES ('237-53-9877', 'Dina', 'Likly', '1997-10-18 00:00:00');
INSERT INTO public.cliente VALUES ('121-64-6056', 'Tracie', 'Culpan', '2005-07-13 00:00:00');
INSERT INTO public.cliente VALUES ('391-74-6833', 'Faunie', 'Battershall', '1989-06-13 00:00:00');
INSERT INTO public.cliente VALUES ('100-30-1935', 'Raynard', 'Dils', '1994-09-17 00:00:00');
INSERT INTO public.cliente VALUES ('865-67-4633', 'Richmond', 'Krishtopaittis', '1996-04-08 00:00:00');
INSERT INTO public.cliente VALUES ('506-28-2861', 'Arel', 'Horick', '2004-03-22 00:00:00');
INSERT INTO public.cliente VALUES ('538-89-9886', 'Helga', 'Brown', '2002-05-07 00:00:00');
INSERT INTO public.cliente VALUES ('727-60-7349', 'Gillie', 'Bernot', '1992-07-13 00:00:00');
INSERT INTO public.cliente VALUES ('298-24-3122', 'Beniamino', 'Henri', '1986-03-05 00:00:00');
INSERT INTO public.cliente VALUES ('374-17-6525', 'Marcellina', 'Cullon', '1995-09-03 00:00:00');
INSERT INTO public.cliente VALUES ('808-22-3703', 'Doroteya', 'Lyndon', '2003-06-26 00:00:00');
INSERT INTO public.cliente VALUES ('784-21-8836', 'Lettie', 'Noller', '2003-03-25 00:00:00');
INSERT INTO public.cliente VALUES ('265-79-3790', 'Brook', 'Beazley', '2004-08-17 00:00:00');
INSERT INTO public.cliente VALUES ('152-19-0103', 'Ulises', 'Kobiela', '1992-06-19 00:00:00');
INSERT INTO public.cliente VALUES ('844-85-7794', 'Bette', 'Falk', '1992-09-17 00:00:00');
INSERT INTO public.cliente VALUES ('474-86-3989', 'Ferdy', 'Lagde', '2000-10-30 00:00:00');
INSERT INTO public.cliente VALUES ('813-19-2972', 'Dur', 'Bumphries', '1989-11-20 00:00:00');
INSERT INTO public.cliente VALUES ('522-31-4106', 'Ricky', 'Hartland', '1989-01-30 00:00:00');
INSERT INTO public.cliente VALUES ('316-40-0889', 'Stanislas', 'Wake', '1994-12-18 00:00:00');
INSERT INTO public.cliente VALUES ('142-46-4522', 'Sondra', 'Mancktelow', '1994-12-10 00:00:00');
INSERT INTO public.cliente VALUES ('581-26-6071', 'Sindee', 'Vaune', '1997-05-27 00:00:00');
INSERT INTO public.cliente VALUES ('520-88-6112', 'Derby', 'Simenon', '1995-03-13 00:00:00');
INSERT INTO public.cliente VALUES ('285-26-0230', 'Tomas', 'Webber', '1987-05-27 00:00:00');
INSERT INTO public.cliente VALUES ('826-33-6034', 'Suzanne', 'Bale', '2001-12-28 00:00:00');
INSERT INTO public.cliente VALUES ('783-22-5493', 'Abdul', 'Buckett', '1989-12-12 00:00:00');
INSERT INTO public.cliente VALUES ('544-97-5975', 'Fancie', 'Pfleger', '1991-03-10 00:00:00');
INSERT INTO public.cliente VALUES ('835-10-3948', 'Carina', 'Sauvain', '2003-11-10 00:00:00');
INSERT INTO public.cliente VALUES ('175-75-7878', 'Shirlee', 'Izakovitz', '2005-09-30 00:00:00');
INSERT INTO public.cliente VALUES ('531-01-5962', 'Dita', 'McGillreich', '1985-12-18 00:00:00');
INSERT INTO public.cliente VALUES ('738-26-1525', 'Craig', 'Overlow', '2004-06-26 00:00:00');
INSERT INTO public.cliente VALUES ('702-08-9656', 'Hazel', 'Guiver', '2002-11-17 00:00:00');
INSERT INTO public.cliente VALUES ('238-19-1124', 'Josee', 'Hampson', '2001-01-19 00:00:00');
INSERT INTO public.cliente VALUES ('131-89-1859', 'Robby', 'Byne', '2000-07-09 00:00:00');
INSERT INTO public.cliente VALUES ('377-04-2790', 'Rosana', 'Attkins', '1997-04-10 00:00:00');
INSERT INTO public.cliente VALUES ('173-46-0895', 'Marena', 'Breakwell', '1993-06-05 00:00:00');
INSERT INTO public.cliente VALUES ('818-30-2512', 'Powell', 'Moult', '1996-09-05 00:00:00');
INSERT INTO public.cliente VALUES ('631-71-6521', 'Morgen', 'Rossander', '1997-03-10 00:00:00');
INSERT INTO public.cliente VALUES ('168-07-9718', 'Hailee', 'Starling', '2004-01-08 00:00:00');
INSERT INTO public.cliente VALUES ('634-93-5729', 'Andria', 'Cardoso', '2001-04-20 00:00:00');
INSERT INTO public.cliente VALUES ('289-73-0768', 'Ally', 'Ealam', '2001-08-07 00:00:00');
INSERT INTO public.cliente VALUES ('325-80-9772', 'Miguel', 'Lindroos', '1990-12-09 00:00:00');
INSERT INTO public.cliente VALUES ('826-43-7893', 'Robbin', 'Sinnie', '1990-04-08 00:00:00');


--
-- TOC entry 3714 (class 0 OID 20006)
-- Dependencies: 217
-- Data for Name: dipendente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dipendente VALUES (1, 'Prescott', 'MacLaverty', '1987-12-11 00:00:00', 3419, 'Guida', 'Tedesco, Inglese, Italiano', NULL, NULL, 'Corso Inglese, Corso Tedesco', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (2, 'Avram', 'McGarahan', '2001-07-15 00:00:00', 3572, 'Guida', 'Tedesco, Inglese, Italiano', NULL, NULL, 'Corso Inglese, Corso Tedesco', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (3, 'Rooney', 'Housden', '2004-03-10 00:00:00', 1233, 'Responsabile', NULL, NULL, NULL, NULL, 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (4, 'Brigit', 'Gopsell', '1997-11-09 00:00:00', 1662, 'Guida', 'Tedesco, Inglese, Italiano, Spagnolo', NULL, NULL, 'Corso Inglese, Corso Tedesco, Corso Spagnolo', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (5, 'Dyan', 'Itzkowicz', '1998-01-05 00:00:00', 2860, 'Guida', 'Tedesco, Inglese', NULL, NULL, 'Corso Tedesco', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (6, 'Carla', 'Kentish', '1991-05-31 00:00:00', 2459, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (7, 'Georgeanne', 'Daintith', '1991-12-31 00:00:00', 2637, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (8, 'Yelena', 'Moule', '1996-11-29 00:00:00', 2229, 'Manutenzione', NULL, NULL, 'Idraulico Elettricista Giardiniere', NULL, 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (9, 'Davide', 'Tiozzo', '2001-04-04 00:00:00', 1740, 'Ricercatore', NULL, 'Zoologo', NULL, NULL, 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (10, 'Trudi', 'Lofty', '1998-12-03 00:00:00', 3429, 'Sicurezza', NULL, NULL, NULL, 'Primo soccorso', 'Parco Naturale del Gran Paradiso');
INSERT INTO public.dipendente VALUES (11, 'Jenica', 'Halladay', '1997-03-31 00:00:00', 3467, 'Guida', 'Spagnolo, Inglese', NULL, NULL, 'Corso Spagnolo', 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (12, 'Trina', 'Dodle', '1987-07-28 00:00:00', 1659, 'Guida', 'Spagnolo, Francese, Tedesco, Inglese', NULL, NULL, 'Corso Tedesco, Corso Spagnolo, Corso Francese', 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (13, 'Sherline', 'Osipenko', '1994-03-27 00:00:00', 3904, 'Manutenzione', NULL, NULL, 'Idraulico Giardiniere', NULL, 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (14, 'Roda', 'Graine', '1993-03-19 00:00:00', 1653, 'Ricercatore', NULL, 'Botanico', NULL, NULL, 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (15, 'Salomo', 'Shanks', '2000-05-02 00:00:00', 3825, 'Sicurezza', NULL, NULL, NULL, 'Primo soccorso', 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (16, 'Harvey', 'Carlton', '1997-11-20 00:00:00', 4527, 'Guida', 'Tedesco, Francese, Italiano, Russo', NULL, NULL, 'Corso Tedesco, Corso Francese, Corso Russo', 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (17, 'Link', 'Oran', '2004-06-05 00:00:00', 2291, 'Guida', 'Tedesco, Inglese', NULL, NULL, 'Corso Inglese', 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (18, 'Kerby', 'Edmonstone', '2003-01-06 00:00:00', 4886, 'Responsabile', NULL, NULL, NULL, NULL, 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (19, 'Ronnie', 'St. Aubyn', '2005-10-16 00:00:00', 2298, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (20, 'Nettle', 'Simmans', '1997-02-07 00:00:00', 3789, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale di Camponogara');
INSERT INTO public.dipendente VALUES (21, 'Delmore', 'Battista', '1991-07-15 00:00:00', 4240, 'Responsabile', NULL, NULL, NULL, NULL, 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (22, 'Clo', 'Keri', '1986-04-13 00:00:00', 3996, 'Organizzatore', NULL, NULL, NULL, NULL, 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (23, 'Jessamine', 'Meek', '1985-10-23 00:00:00', 1411, 'Guida', 'Spagnolo, Tedesco', NULL, NULL, 'Corso Spagnolo', 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (24, 'Dickie', 'Malkie', '1996-01-14 00:00:00', 2544, 'Ricercatore', NULL, 'Ornitologo', NULL, NULL, 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (25, 'Viviana', 'Ecob', '1992-04-24 00:00:00', 1700, 'Guida', 'Francese, Inglese', NULL, NULL, 'Corso Francese', 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (26, 'Hugibert', 'Batkin', '2003-05-16 00:00:00', 3505, 'Guida', 'Tedesco, Italiano, Inglese', NULL, NULL, 'Corso Tedesco, Corso Italiano', 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (27, 'Hi', 'Knights', '2001-06-30 00:00:00', 1959, 'Manutenzione', NULL, NULL, 'Elettricista Giardiniere', NULL, 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (28, 'Matteo', 'Donanzan', '2002-10-01 00:00:00', 3499, 'Organizzatore', NULL, NULL, NULL, NULL, 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (29, 'Patrizius', 'Gravenor', '2001-09-04 00:00:00', 2193, 'Guida', 'Tedesco', NULL, NULL, 'Corso Tedesco', 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (30, 'Calv', 'Synnot', '1987-02-14 00:00:00', 1320, 'Sicurezza', NULL, NULL, NULL, 'Primo soccorso', 'Riserva Naturale Misquilese');
INSERT INTO public.dipendente VALUES (31, 'Iggie', 'Stitt', '1990-06-25 00:00:00', 1799, 'Guida', 'Tedesco, Inglese, Italiano', NULL, NULL, 'Corso Tedesco', 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (32, 'Remington', 'Torrent', '2003-12-30 00:00:00', 1750, 'Guida', 'Francese, Inglese, Spagnolo', NULL, NULL, 'Corso Francese, Corso Spagnolo', 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (33, 'Silas', 'Cleghorn', '1988-01-03 00:00:00', 2140, 'Guida', 'Russo, Inglese', NULL, NULL, 'Corso Russo', 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (34, 'Gaspar', 'Dunlop', '2002-08-31 00:00:00', 2723, 'Guida', 'Arabo, Inglese', NULL, NULL, 'Corso Arabo', 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (35, 'Kathie', 'Tschersich', '2001-03-18 00:00:00', 4290, 'Ricercatore', NULL, 'Chimico', NULL, NULL, 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (36, 'Wilhelmine', 'Haney`', '2001-02-26 00:00:00', 3281, 'Manutenzione', NULL, NULL, 'Idraulico Elettricista Giardiniere', NULL, 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (37, 'Linoel', 'Llewelly', '1987-10-04 00:00:00', 4882, 'Responsabile', NULL, NULL, NULL, NULL, 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (38, 'Dulsea', 'Pescud', '1992-06-13 00:00:00', 3112, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (39, 'Finlay', 'Notman', '1993-01-06 00:00:00', 3584, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale dello Stelvio');
INSERT INTO public.dipendente VALUES (40, 'Howie', 'Stollenberg', '1989-02-16 00:00:00', 2288, 'Sicurezza', NULL, NULL, NULL, 'Primo soccorso', 'Parco Nazionale dello Stelvio');


--
-- TOC entry 3720 (class 0 OID 20079)
-- Dependencies: 223
-- Data for Name: evento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.evento VALUES ('1', 8, '2023-03-18 00:00:00', 'Musicale', 6);
INSERT INTO public.evento VALUES ('2', 8, '2023-12-13 00:00:00', 'Artistico', 7);
INSERT INTO public.evento VALUES ('3', 8, '2023-05-02 00:00:00', 'Musicale', 19);
INSERT INTO public.evento VALUES ('4', 8, '2024-05-26 00:00:00', 'Artistico', 20);
INSERT INTO public.evento VALUES ('5', 6, '2023-06-24 00:00:00', 'Artistico', 22);
INSERT INTO public.evento VALUES ('6', 8, '2024-11-23 00:00:00', 'Musicale', 28);
INSERT INTO public.evento VALUES ('7', 8, '2024-12-04 00:00:00', 'Naturalistico', 38);
INSERT INTO public.evento VALUES ('8', 6, '2023-02-24 00:00:00', 'Naturalistico', 39);


--
-- TOC entry 3712 (class 0 OID 19984)
-- Dependencies: 215
-- Data for Name: parco; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.parco VALUES ('Parco Naturale del Gran Paradiso', 'Piemonte', 75690);
INSERT INTO public.parco VALUES ('Parco Nazionale di Camponogara', 'Venezia', 95486);
INSERT INTO public.parco VALUES ('Riserva Naturale Misquilese', 'Mussolente', 6087);
INSERT INTO public.parco VALUES ('Parco Nazionale dello Stelvio', 'Lombardia', 12420);


--
-- TOC entry 3725 (class 0 OID 20145)
-- Dependencies: 228
-- Data for Name: pianta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pianta VALUES ('A1P1', 'Foglie verdi, fiori rosa, alta e elegante', 'Eritrichium nanum ', 16.6, 'Valnontey', 'Filiformi', '2017-01-01 00:00:00', 22, 1);
INSERT INTO public.pianta VALUES ('A1P2', 'Pianta rampicante con foglie a forma di cuore', 'Dacryodes Vahl', 14.1, 'Cogne', 'Aghiformi', '2003-01-01 00:00:00', 24, 1);
INSERT INTO public.pianta VALUES ('A1P3', 'Arbusto sempreverde con fiori gialli profumati', 'Centaurea eriophora', 15.3, 'Valsavarenche', 'Filiformi', '2022-01-01 00:00:00', 45, 1);
INSERT INTO public.pianta VALUES ('A1P4', 'Arbusto con foglie variegate e fiori viola', 'Lecanora gyalectodes', 14.1, 'Rhêmes-Notre-Dame', 'Aghiformi', '2001-01-01 00:00:00', 25, 1);
INSERT INTO public.pianta VALUES ('A2P1', 'Pianta tropicale con foglie grandi e vistose', 'Leptospermum laevigatum', 1.4, 'Rhêmes-Saint-Georges', 'Oblunghe', '2013-01-01 00:00:00', 21, 2);
INSERT INTO public.pianta VALUES ('A2P2', 'Pianta acquatica con fiori galleggianti rosa', 'Lobelia flaccidifolia Small', 11.7, 'Valgrisenche', 'Filiformi', '2012-01-01 00:00:00', 32, 2);
INSERT INTO public.pianta VALUES ('A2P3', 'Arbusto con foglie piccole e fiori rosa intenso', 'Launaea Cass', 13.9, 'Ceresole Reale', 'Oblunghe', '2007-01-01 00:00:00', 10, 2);
INSERT INTO public.pianta VALUES ('A2P4', 'Arbusto con foglie lanceolate e frutti rossi', 'Chenopodium Aellen', 11.1, 'Pont', 'Filiformi', '2021-01-01 00:00:00', 11, 2);
INSERT INTO public.pianta VALUES ('A3P1', 'Pianta rampicante con foglie verdi lucide e fiori bianchi', 'Chrysogonum virginianum', 12.7, 'Ronco Canavese', 'Aghiformi', '2004-01-01 00:00:00', 50, 3);
INSERT INTO public.pianta VALUES ('A3P2', 'Albero con foglie palmate e fiori rosa penduli', 'Lathyrus nevadensis', 19.3, 'Villeneuve', 'Oblunghe', '2008-01-01 00:00:00', 12, 3);
INSERT INTO public.pianta VALUES ('A3P3', 'Erba profumata con foglie sottili e fiori viola', 'Orobanche corymbosa', 16.6, 'Valprato Soana', 'Ovali', '2011-01-01 00:00:00', 15, 3);
INSERT INTO public.pianta VALUES ('A3P4', 'Pianta acquatica con foglie galleggianti a forma di cuore', 'Baptisia megacarpa', 18, 'Eaux Rousses', 'Seghettate', '2011-01-01 00:00:00', 16, 3);
INSERT INTO public.pianta VALUES ('A4P1', 'Arbusto con foglie argentate e fiori gialli a grappolo', 'Lotus procumbens Greene', 9.7, 'Gimillan', 'Aghiformi', '2006-01-01 00:00:00', 14, 4);
INSERT INTO public.pianta VALUES ('A4P2', 'Pianta rampicante con foglie a forma di stella e fiori profumati', 'Oligoneuron rigidum Small', 11.1, 'Val di Rhêmes', 'Ovali', '2009-01-01 00:00:00', 9, 4);
INSERT INTO public.pianta VALUES ('A4P3', 'Albero con fiori bianchi a forma di piuma', 'Tricardia Torr', 8.8, 'Valsavarenche', 'Seghettate', '2001-01-01 00:00:00', 8, 4);
INSERT INTO public.pianta VALUES ('A4P4', 'Albero con foglie lanceolate e frutti dolci ', 'Triodanis texana', 4.8, 'Piantonetto', 'Ovali', '2008-01-01 00:00:00', 5, 4);
INSERT INTO public.pianta VALUES ('A5P1', 'Albero con fiori bianchi a forma di spiga elegante', 'Peniocereus greggii', 10.2, 'Lauson', 'Filiformi', '2014-01-01 00:00:00', 18, 5);
INSERT INTO public.pianta VALUES ('A5P2', 'Erba ornamentale con foglie a strisce e fiori rosa intenso profumati', 'Tragia glanduligera', 4.8, 'Val di Cogne', 'Seghettate', '2015-01-01 00:00:00', 17, 5);
INSERT INTO public.pianta VALUES ('A5P3', 'Pianta con foglie strette e fiori gialli a forma di stella', 'Penstemon goodrichii', 18.5, 'Teleccio', 'Aghiformi', '2017-01-01 00:00:00', 15, 5);
INSERT INTO public.pianta VALUES ('A5P4', 'Albero con foglie strette e fiori gialli profumati a grappolo splendidi', 'Symphyotrichum laurentianum', 15.2, 'Locana', 'Filiformi', '2020-01-01 00:00:00', 35, 5);
INSERT INTO public.pianta VALUES ('A6P1', 'Colorato, a forma di coppa', 'Portulaca quadrifida', 11.2, 'Monterosso al Mare', 'Aghiformi', '2014-01-01 00:00:00', 8, 6);
INSERT INTO public.pianta VALUES ('A6P2', 'Viola, aromatico, lavanda', 'Phlox andicola', 16.4, 'Vernazza', 'Oblunghe', '2006-01-01 00:00:00', 9, 6);
INSERT INTO public.pianta VALUES ('A6P3', 'Alta, foglie verdi, fiori bianchi, profumata', 'Cetrelia chicitae', 9, 'Corniglia', 'Aghiformi', '2021-01-01 00:00:00', 13, 6);
INSERT INTO public.pianta VALUES ('A6P4', 'Fiori rossi, foglie lanceolate, rampicante, vivace', 'Dryopteris xneowherryi', 15.3, 'Manarola', 'Ovali', '2022-01-01 00:00:00', 11, 6);
INSERT INTO public.pianta VALUES ('A7P1', 'Piccoli fiori rosa, foglie ovali, profumo dolce', 'Calypso bulbosa', 4, 'Riomaggiore', 'Filiformi', '2019-01-01 00:00:00', 24, 7);
INSERT INTO public.pianta VALUES ('A7P2', 'Grappoli di fiori gialli, foglie lucide, profumo intenso', 'Thelopsis isiaca', 6.5, 'Portovenere', 'Oblunghe', '2015-01-01 00:00:00', 31, 7);
INSERT INTO public.pianta VALUES ('A7P3', 'Fiore giallo, foglie sottili, profumo dolce', 'Samolus', 17, 'Levanto', 'Aghiformi', '2016-01-01 00:00:00', 15, 7);
INSERT INTO public.pianta VALUES ('A7P4', 'Fiori bianchi, foglie verdi, rampicante, profumo delicato', 'Sidastrum ', 2.9, 'La Spezia', 'Ovali', '2005-01-01 00:00:00', 32, 7);
INSERT INTO public.pianta VALUES ('A8P1', 'Fiori rossi, foglie dentate', 'Salix xprincepsrayi', 15.5, 'Portofino', 'Seghettate', '2017-01-01 00:00:00', 23, 8);
INSERT INTO public.pianta VALUES ('A8P2', 'Fiori bianchi, foglie verde scuro, profumo rilassante', 'Capparis incana', 10, 'Camogli', 'Ovali', '2015-01-01 00:00:00', 22, 8);
INSERT INTO public.pianta VALUES ('A8P3', 'Fiori arancioni, foglie verde scuro, rampicante, vivace', 'Eleutheranthera ruderalis', 7.3, 'Santa Margherita Ligure', 'Filiformi', '2004-01-01 00:00:00', 21, 8);
INSERT INTO public.pianta VALUES ('A8P4', 'Fiori gialli, foglie strette, profumo citrico', 'Urera obovata Benth.', 19.8, 'Bonassola', 'Seghettate', '2008-01-01 00:00:00', 16, 8);
INSERT INTO public.pianta VALUES ('A9P1', 'Fiori rosa, foglie verde brillante, profumo intenso', 'Cardaria draba', 2.3, 'Framura', 'Oblunghe', '2022-01-01 00:00:00', 15, 9);
INSERT INTO public.pianta VALUES ('A9P2', 'Fiori viola, foglie verde chiaro, profumo erbaceo', 'Crossosoma bigelovii', 8, 'Lerici', 'Filiformi', '2021-01-01 00:00:00', 11, 9);
INSERT INTO public.pianta VALUES ('A9P3', 'Fiori bianchi, foglie verde scuro, profumo dolce', 'Nesaea', 2.9, 'Tellaro', 'Ovali', '2013-01-01 00:00:00', 43, 9);
INSERT INTO public.pianta VALUES ('A9P4', 'Fiori blu, foglie lanceolate, profumo rinfrescante', 'Calamagrostis tacomensis', 9.8, 'Volastra', 'Aghiformi', '2008-01-01 00:00:00', 26, 9);
INSERT INTO public.pianta VALUES ('A10P1', 'Fiori rosa, foglie lanceolate, profumo delicato', 'Hymenopappus carrizoanus', 19, 'Biassa', 'Ovali', '2000-01-01 00:00:00', 21, 10);
INSERT INTO public.pianta VALUES ('A10P2', 'Fiori arancioni, foglie verde scuro, rampicante, vivace', 'Baccharis texana', 9.8, 'Riomaggiore Scalo', 'Seghettate', '2016-01-01 00:00:00', 15, 10);
INSERT INTO public.pianta VALUES ('A10P3', 'Fiori bianchi, foglie verde scuro, rampicante, profumo intenso', 'Jacquemontia havanensis', 5, 'Pignone', 'Aghiformi', '2021-01-01 00:00:00', 13, 10);
INSERT INTO public.pianta VALUES ('A10P4', 'Fiori gialli, foglie verdi, rampicante, profumo leggero', 'Paspalum bifidum', 3.1, 'Montaretto', 'Filiformi', '2011-01-01 00:00:00', 11, 10);
INSERT INTO public.pianta VALUES ('A11P1', 'Fiori viola, foglie verde scuro, profumo erbaceo', 'Grindelia hirsutula', 3, 'Castelluccio di Norcia', 'Aghiformi', '2015-01-01 00:00:00', 56, 11);
INSERT INTO public.pianta VALUES ('A11P2', 'Fiori rossi, foglie verdi, rampicante, vivace', 'Saxifraga flagellaris ', 17.6, 'Visso', 'Oblunghe', '2021-01-01 00:00:00', 34, 11);
INSERT INTO public.pianta VALUES ('A11P3', 'Fiori bianchi, foglie verdi, profumo dolce', 'Styrax', 7.6, 'Castelsantangelo sul Nera', 'Ovali', '2001-01-01 00:00:00', 23, 11);
INSERT INTO public.pianta VALUES ('A11P4', 'Fiori rosa, foglie verde scuro, profumo intenso', 'Heracleum', 7.5, 'Ussita', 'Filiformi', '2017-01-01 00:00:00', 34, 11);
INSERT INTO public.pianta VALUES ('A12P1', 'Fiori arancioni, foglie verde scuro, rampicante, vivace', 'Sterculia', 9.6, 'Montemonaco', 'Seghettate', '2022-01-01 00:00:00', 11, 12);
INSERT INTO public.pianta VALUES ('A12P2', 'Fiori gialli, foglie verdi, rampicante, profumo leggero', 'Acarospora smaragdula', 6.1, 'Fiastra', 'Aghiformi', '2000-01-01 00:00:00', 22, 12);
INSERT INTO public.pianta VALUES ('A12P3', 'Bianco, foglie verde scuro, profumo dolce', 'Spiraea chamaedryfolia', 1.9, 'Bolognola', 'Filiformi', '2014-01-01 00:00:00', 33, 12);
INSERT INTO public.pianta VALUES ('A12P4', 'Arancione, foglie verde scuro, rampicante, vivace', 'Brickellia frutescens', 20, 'Amandola', 'Ovali', '2005-01-01 00:00:00', 15, 12);
INSERT INTO public.pianta VALUES ('A13P1', 'Giallo, foglie strette, profumo citrico', 'Gossypium barbadense', 8.7, 'Sarnano', 'Oblunghe', '2020-01-01 00:00:00', 17, 13);
INSERT INTO public.pianta VALUES ('A13P2', 'Giallo, foglie verde scuro, profumo agrumato', 'Dodecatheon amethystinum', 8.5, 'Acquacanina', 'Ovali', '2015-01-01 00:00:00', 16, 13);
INSERT INTO public.pianta VALUES ('A13P3', 'Rosa, foglie lanceolate, profumo floreale', 'Malvastrum americanum', 14.8, 'Montefortino', 'Aghiformi', '2014-01-01 00:00:00', 67, 13);
INSERT INTO public.pianta VALUES ('A13P4', 'Bianco, foglie verdi, profumo delicato', 'Actinidia polygama', 17, 'Preci', 'Seghettate', '2000-01-01 00:00:00', 85, 13);
INSERT INTO public.pianta VALUES ('A14P1', 'Rosso, foglie lanceolate, profumo speziato', 'Solidago velutina', 16.9, 'Valfornace', 'Filiformi', '2015-01-01 00:00:00', 38, 14);
INSERT INTO public.pianta VALUES ('A14P2', 'Giallo, foglie verdi, rampicante, profumo erbaceo', 'Stenotus', 11.3, 'Montegallo', 'Ovali', '2005-01-01 00:00:00', 12, 14);
INSERT INTO public.pianta VALUES ('A14P3', 'Viola, foglie verde scuro, profumo intenso', 'Androsace', 11.5, 'Montefalcone Appennino', 'Seghettate', '2007-01-01 00:00:00', 34, 14);
INSERT INTO public.pianta VALUES ('A14P4', 'Rosso, foglie verde brillante, profumo fruttato', 'Eugenia uniflora', 11.8, 'Pievebovigliana', 'Aghiformi', '2015-01-01 00:00:00', 45, 14);
INSERT INTO public.pianta VALUES ('A15P1', 'Bianco, foglie verde scuro, profumo fresco', 'Phlox glaberrima', 16.5, 'Colfiorito', 'Ovali', '2020-01-01 00:00:00', 26, 15);
INSERT INTO public.pianta VALUES ('A15P2', 'Blu, foglie lanceolate, profumo erbaceo', 'Saxifraga bryophora', 18.6, 'Pieve Torina', 'Filiformi', '2022-01-01 00:00:00', 13, 15);
INSERT INTO public.pianta VALUES ('A15P3', 'Giallo, foglie verdi, rampicante, profumo floreale', 'Astragalus soxmaniorum', 11.8, 'Cessapalombo', 'Ovali', '2019-01-01 00:00:00', 64, 15);
INSERT INTO public.pianta VALUES ('A15P4', 'Viola, foglie verde chiaro, profumo dolce', 'Jacquemontia tamnifolia', 13.2, 'Pintura di Bolognola', 'Aghiformi', '2008-01-01 00:00:00', 65, 15);
INSERT INTO public.pianta VALUES ('A16P1', 'Bianco, foglie verdi, profumo delicato', 'Ericameria obovata', 2.7, 'Bormio', 'Aghiformi', '2012-01-01 00:00:00', 56, 16);
INSERT INTO public.pianta VALUES ('A16P2', 'Arancione, foglie verde scuro, rampicante, profumo tropicale', 'Escobaria organensis', 4.2, 'Livigno', 'Oblunghe', '2018-01-01 00:00:00', 43, 16);
INSERT INTO public.pianta VALUES ('A16P3', 'Giallo, foglie strette, profumo speziato', 'Nama aretioides', 1.8, 'Santa Caterina Valfurva', 'Aghiformi', '2002-01-01 00:00:00', 41, 16);
INSERT INTO public.pianta VALUES ('A16P4', 'Rosa, foglie verde brillante, profumo leggero', 'Arctostaphylos hookeri', 9.7, 'Peio', 'Ovali', '2020-01-01 00:00:00', 23, 16);
INSERT INTO public.pianta VALUES ('A17P1', 'Bianco, foglie verde scuro, profumo rinfrescante', 'Lecidea sublimosa', 1.6, 'Prato allo Stelvio', 'Aghiformi', '2000-01-01 00:00:00', 16, 17);
INSERT INTO public.pianta VALUES ('A17P2', 'Viola, foglie verde scuro, profumo dolce', 'Juncus drummondii', 1.3, 'Solda', 'Seghettate', '2017-01-01 00:00:00', 11, 17);
INSERT INTO public.pianta VALUES ('A17P3', 'Rosso, foglie verdi, rampicante, profumo intenso', 'Vicia cracca', 13.3, 'Trafoi', 'Filiformi', '2008-01-01 00:00:00', 43, 17);
INSERT INTO public.pianta VALUES ('A17P4', 'Giallo, foglie verdi, profumo agrumato', 'Croton ciliatoglandulifer', 8.4, 'Valdidentro', 'Ovali', '2007-01-01 00:00:00', 75, 17);
INSERT INTO public.pianta VALUES ('A18P1', 'Blu, foglie lanceolate, profumo erbaceo', 'Stipa klemenzii', 18.4, 'Sulden', 'Aghiformi', '2022-01-01 00:00:00', 23, 18);
INSERT INTO public.pianta VALUES ('A18P2', 'Rosa, foglie lanceolate, profumo floreale', 'Psychopsis', 10.5, 'Rabbi', 'Seghettate', '2015-01-01 00:00:00', 22, 18);
INSERT INTO public.pianta VALUES ('A18P3', 'Bianco, foglie verde scuro, profumo delicato', 'Allium oleraceum', 7.6, 'Martello', 'Ovali', '2001-01-01 00:00:00', 30, 18);
INSERT INTO public.pianta VALUES ('A18P4', 'Arancione, foglie verde scuro, rampicante, profumo esotico', 'Centaurium arizonicum', 9.8, 'Madonna di Senales', 'Filiformi', '2007-01-01 00:00:00', 21, 18);
INSERT INTO public.pianta VALUES ('A19P1', 'Giallo, foglie strette, profumo speziato', 'Saxifraga hirculus', 10, 'Vermiglio', 'Aghiformi', '2000-01-01 00:00:00', 23, 19);
INSERT INTO public.pianta VALUES ('A19P2', 'Viola, foglie verde scuro, profumo intenso', 'Mycocalicium sequoiae', 7.5, 'Santa Maria Val Müstair', 'Seghettate', '2018-01-01 00:00:00', 25, 19);
INSERT INTO public.pianta VALUES ('A19P3', 'Rosso, foglie verde brillante, profumo fruttato', 'Phacelia capitata', 2.3, 'Stelvio Pass', 'Ovali', '2014-01-01 00:00:00', 21, 19);
INSERT INTO public.pianta VALUES ('A19P4', 'Bianco, foglie verde scuro, profumo fresco', 'Phoenix sylvestris', 2.5, 'Cogolo di Pejo', 'Aghiformi', '2003-01-01 00:00:00', 54, 19);
INSERT INTO public.pianta VALUES ('A20P1', 'Blu, foglie lanceolate, profumo erbaceo', 'Penstemon procerus Douglas', 10.9, 'Malè', 'Ovali', '2019-01-01 00:00:00', 43, 20);
INSERT INTO public.pianta VALUES ('A20P2', 'Giallo, foglie verdi, rampicante, profumo floreale', 'Linum carteri', 13.6, 'Santa Valburga', 'Seghettate', '2001-01-01 00:00:00', 54, 20);
INSERT INTO public.pianta VALUES ('A20P3', 'Viola, foglie verde chiaro, profumo dolce', 'Vitex parviflora', 11.3, 'Valdisotto', 'Ovali', '2001-01-01 00:00:00', 32, 20);
INSERT INTO public.pianta VALUES ('A20P4', 'Rosso, foglie verde scuro, profumo piccante', 'Bacopa repens', 7.7, 'Laces', 'Oblunghe', '2018-01-01 00:00:00', 56, 20);


--
-- TOC entry 3717 (class 0 OID 20031)
-- Dependencies: 220
-- Data for Name: spiega; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.spiega VALUES (1, 'A12BC');
INSERT INTO public.spiega VALUES (2, 'A13BC');
INSERT INTO public.spiega VALUES (4, 'A12BC');
INSERT INTO public.spiega VALUES (5, 'A13BC');
INSERT INTO public.spiega VALUES (11, 'A14BC');
INSERT INTO public.spiega VALUES (12, 'A15BC');
INSERT INTO public.spiega VALUES (16, 'A14BC');
INSERT INTO public.spiega VALUES (17, 'A15BC');
INSERT INTO public.spiega VALUES (23, 'A16BC');
INSERT INTO public.spiega VALUES (25, 'A17BC');
INSERT INTO public.spiega VALUES (26, 'A16BC');
INSERT INTO public.spiega VALUES (29, 'A17BC');
INSERT INTO public.spiega VALUES (31, 'A18BC');
INSERT INTO public.spiega VALUES (32, 'A19BC');
INSERT INTO public.spiega VALUES (33, 'A18BC');
INSERT INTO public.spiega VALUES (34, 'A19BC');


--
-- TOC entry 3715 (class 0 OID 20025)
-- Dependencies: 218
-- Data for Name: tourguidato; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tourguidato VALUES ('A12BC', 8, '2023-08-28 00:00:00', 'Flora');
INSERT INTO public.tourguidato VALUES ('A13BC', 8, '2024-09-02 00:00:00', 'Fauna');
INSERT INTO public.tourguidato VALUES ('A14BC', 8, '2023-07-04 00:00:00', 'Fauna');
INSERT INTO public.tourguidato VALUES ('A15BC', 8, '2024-01-07 00:00:00', 'Flora');
INSERT INTO public.tourguidato VALUES ('A16BC', 8, '2024-04-29 00:00:00', 'Fauna');
INSERT INTO public.tourguidato VALUES ('A17BC', 4, '2023-09-12 00:00:00', 'Flora');
INSERT INTO public.tourguidato VALUES ('A18BC', 8, '2023-02-09 00:00:00', 'Fauna');
INSERT INTO public.tourguidato VALUES ('A19BC', 8, '2023-04-04 00:00:00', 'Flora');


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 226
-- Name: area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.area_id_seq', 1, false);


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 224
-- Name: bigliettoevento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bigliettoevento_id_seq', 1, false);


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 221
-- Name: bigliettotour_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bigliettotour_id_seq', 1, false);


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 216
-- Name: dipendente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dipendente_id_seq', 1, false);


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 219
-- Name: spiega_dipendente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spiega_dipendente_seq', 1, false);


--
-- TOC entry 3553 (class 2606 OID 20195)
-- Name: animale animale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animale
    ADD CONSTRAINT animale_pkey PRIMARY KEY (id);


--
-- TOC entry 3548 (class 2606 OID 20122)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id);


--
-- TOC entry 3546 (class 2606 OID 20097)
-- Name: bigliettoevento bigliettoevento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettoevento
    ADD CONSTRAINT bigliettoevento_pkey PRIMARY KEY (id);


--
-- TOC entry 3542 (class 2606 OID 20055)
-- Name: bigliettotour bigliettotour_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettotour
    ADD CONSTRAINT bigliettotour_pkey PRIMARY KEY (id);


--
-- TOC entry 3532 (class 2606 OID 19983)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (codicefiscale);


--
-- TOC entry 3536 (class 2606 OID 20013)
-- Name: dipendente dipendente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dipendente
    ADD CONSTRAINT dipendente_pkey PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 20083)
-- Name: evento evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_pkey PRIMARY KEY (id);


--
-- TOC entry 3534 (class 2606 OID 19990)
-- Name: parco parco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parco
    ADD CONSTRAINT parco_pkey PRIMARY KEY (nome);


--
-- TOC entry 3551 (class 2606 OID 20151)
-- Name: pianta pianta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pianta
    ADD CONSTRAINT pianta_pkey PRIMARY KEY (id);


--
-- TOC entry 3540 (class 2606 OID 20036)
-- Name: spiega spiega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spiega
    ADD CONSTRAINT spiega_pkey PRIMARY KEY (dipendente, tour);


--
-- TOC entry 3538 (class 2606 OID 20029)
-- Name: tourguidato tourguidato_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tourguidato
    ADD CONSTRAINT tourguidato_pkey PRIMARY KEY (id);


--
-- TOC entry 3554 (class 1259 OID 20206)
-- Name: indiceanimale; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX indiceanimale ON public.animale USING btree (id, descrizione, nomelatino, alimentazione, datanascita);


--
-- TOC entry 3549 (class 1259 OID 20205)
-- Name: indicepianta; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX indicepianta ON public.pianta USING btree (id, descrizione, nomelatino, acquanecessaria, locazione);


--
-- TOC entry 3568 (class 2606 OID 20196)
-- Name: animale animale_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animale
    ADD CONSTRAINT animale_area_fkey FOREIGN KEY (area) REFERENCES public.area(id) ON UPDATE CASCADE;


--
-- TOC entry 3565 (class 2606 OID 20123)
-- Name: area area_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_parco_fkey FOREIGN KEY (parco) REFERENCES public.parco(nome) ON UPDATE CASCADE;


--
-- TOC entry 3566 (class 2606 OID 20128)
-- Name: area area_responsabile_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_responsabile_fkey FOREIGN KEY (responsabile) REFERENCES public.dipendente(id) ON UPDATE CASCADE;


--
-- TOC entry 3562 (class 2606 OID 20098)
-- Name: bigliettoevento bigliettoevento_codicefiscalecliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettoevento
    ADD CONSTRAINT bigliettoevento_codicefiscalecliente_fkey FOREIGN KEY (codicefiscalecliente) REFERENCES public.cliente(codicefiscale) ON UPDATE CASCADE;


--
-- TOC entry 3563 (class 2606 OID 20103)
-- Name: bigliettoevento bigliettoevento_evento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettoevento
    ADD CONSTRAINT bigliettoevento_evento_fkey FOREIGN KEY (evento) REFERENCES public.evento(id) ON UPDATE CASCADE;


--
-- TOC entry 3564 (class 2606 OID 20108)
-- Name: bigliettoevento bigliettoevento_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettoevento
    ADD CONSTRAINT bigliettoevento_parco_fkey FOREIGN KEY (parco) REFERENCES public.parco(nome) ON UPDATE CASCADE;


--
-- TOC entry 3558 (class 2606 OID 20056)
-- Name: bigliettotour bigliettotour_codicefiscalecliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettotour
    ADD CONSTRAINT bigliettotour_codicefiscalecliente_fkey FOREIGN KEY (codicefiscalecliente) REFERENCES public.cliente(codicefiscale) ON UPDATE CASCADE;


--
-- TOC entry 3559 (class 2606 OID 20066)
-- Name: bigliettotour bigliettotour_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettotour
    ADD CONSTRAINT bigliettotour_parco_fkey FOREIGN KEY (parco) REFERENCES public.parco(nome) ON UPDATE CASCADE;


--
-- TOC entry 3560 (class 2606 OID 20061)
-- Name: bigliettotour bigliettotour_tour_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bigliettotour
    ADD CONSTRAINT bigliettotour_tour_fkey FOREIGN KEY (tour) REFERENCES public.tourguidato(id) ON UPDATE CASCADE;


--
-- TOC entry 3555 (class 2606 OID 20014)
-- Name: dipendente dipendente_parco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dipendente
    ADD CONSTRAINT dipendente_parco_fkey FOREIGN KEY (parco) REFERENCES public.parco(nome) ON UPDATE CASCADE;


--
-- TOC entry 3561 (class 2606 OID 20084)
-- Name: evento evento_organizzatore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evento
    ADD CONSTRAINT evento_organizzatore_fkey FOREIGN KEY (organizzatore) REFERENCES public.dipendente(id) ON UPDATE CASCADE;


--
-- TOC entry 3567 (class 2606 OID 20152)
-- Name: pianta pianta_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pianta
    ADD CONSTRAINT pianta_area_fkey FOREIGN KEY (area) REFERENCES public.area(id) ON UPDATE CASCADE;


--
-- TOC entry 3556 (class 2606 OID 20037)
-- Name: spiega spiega_dipendente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spiega
    ADD CONSTRAINT spiega_dipendente_fkey FOREIGN KEY (dipendente) REFERENCES public.dipendente(id) ON UPDATE CASCADE;


--
-- TOC entry 3557 (class 2606 OID 20042)
-- Name: spiega spiega_tour_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spiega
    ADD CONSTRAINT spiega_tour_fkey FOREIGN KEY (tour) REFERENCES public.tourguidato(id) ON UPDATE CASCADE;


-- Completed on 2023-06-20 12:04:29 CEST

--
-- PostgreSQL database dump complete
--

--Query 1:
SELECT nome, luogo FROM Parco

--Query 2:
SELECT età, COUNT(età) FROM Animale GROUP BY età ORDER BY count ASC

--Query 3:
SELECT id, nomeLatino, alimentazione FROM Animale WHERE (id= $1::varchar) --IN QUESTO CASO 'A16A4'

--Query 4:
SELECT id, nomeLatino, acquaNecessaria FROM Pianta WHERE (id= $1::varchar) --IN QUESTO CASO 'A20P4'

--Query 5:
SELECT p.id, p.nomeLatino, p.locazione, p.area, a.parco FROM Pianta AS p, Area AS a WHERE (p.area = a.id AND p.id = $1::varchar) --IN QUESTO CASO 'A20P4'

--Query 6:
SELECT tipoFoglie, COUNT(id) AS Numero_Piante FROM Pianta WHERE (tipoFoglie = $1::enumFoglie) GROUP BY tipoFoglie --IN QUESTO CASO ‘Oblunghe’ 

--Query 7:
SELECT c.nome, c.cognome FROM Cliente AS c, BigliettoEvento AS b, Evento AS e WHERE (c.codiceFiscale = b.codiceFiscaleCliente AND b.evento = e.id AND e.organizzatore = $1::int) --IN QUESTO CASO '7'

--Query 8:
SELECT DISTINCT d.id, d.nome, d.cognome FROM Dipendente AS d, Spiega AS s, TourGuidato AS t WHERE (d.id = s.dipendente AND s.tour = t.id AND t.tipoTour = $1::enumTour) --IN QUESTO CASO 'Fauna'

--Query 9:
SELECT id, nome, tipoDipendente, guadagno FROM Dipendente WHERE (guadagno > $1::int) ORDER BY guadagno DESC --IN QUESTO CASO '4500'

--Query 10:
SELECT COUNT(*)AS Ridotti FROM (SELECT id FROM BigliettoEvento WHERE ridotto = true UNION SELECT id FROM BigliettoTour WHERE ridotto = true) AS r

--Query 11:
SELECT id, nomeLatino, locazione FROM Pianta WHERE (dataTrapianto < $1::timestamp) --IN QUESTO CASO '2001-01-01'

--Query 12:
SELECT nomeLatino FROM Animale WHERE (Animale.id = $1::varchar) /*IN QUESTO CASO 'A16A4' - VUOTO*/ UNION SELECT nomeLatino FROM Pianta WHERE (Pianta.id = $1::varchar) --IN QUESTO CASO 'A16A4' – NON VUOTO

--Query 13:
SELECT parco, AVG(guadagno) FROM Dipendente GROUP BY parco HAVING (parco = $1::varchar) --IN QUESTO CASO 'Parco Nazionale dello Stelvio'

--Query 14:
SELECT tour, SUM(prezzo) AS somma
FROM bigliettoTour
WHERE (parco = $1::varchar) /*IN QUESTO CASO ‘Parco Nazionale dello Stelvio’*/ GROUP BY prezzo, tour
ORDER BY somma DESC

SELECT evento, SUM(prezzo) AS somma
FROM bigliettoEvento
WHERE (parco = $1::varchar) /*IN QUESTO CASO ‘Parco Nazionale dello Stelvio’*/ GROUP BY prezzo, evento ORDER BY somma DESC

SELECT SUM(prezzo) AS totale
FROM (SELECT prezzo FROM BigliettoTour WHERE parco = $1::varchar /*IN QUESTO CASO ‘Parco Nazionale dello Stelvio’*/
UNION ALL
SELECT prezzo FROM BigliettoEvento WHERE parco = $1::varchar) AS u