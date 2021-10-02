--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 12.6

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

DROP DATABASE proxstar;
--
-- Name: proxstar; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE proxstar WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE proxstar OWNER TO postgres;

\connect proxstar

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
-- Name: plperl; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plperl;


ALTER PROCEDURAL LANGUAGE plperl OWNER TO postgres;

--
-- Name: plperl_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.plperl_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plperl', 'plperl_call_handler';


ALTER FUNCTION public.plperl_call_handler() OWNER TO postgres;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: allowed_users; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.allowed_users (
    id character varying(32) NOT NULL
);


ALTER TABLE public.allowed_users OWNER TO proxstar;

--
-- Name: ignored_pools; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.ignored_pools (
    id character varying(32) NOT NULL
);


ALTER TABLE public.ignored_pools OWNER TO proxstar;

--
-- Name: pool_cache; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.pool_cache (
    pool character varying(32) NOT NULL,
    vms text[] NOT NULL,
    num_vms integer NOT NULL,
    usage json NOT NULL,
    limits json NOT NULL,
    percents json NOT NULL
);


ALTER TABLE public.pool_cache OWNER TO proxstar;

--
-- Name: template; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.template (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    disk integer NOT NULL
);


ALTER TABLE public.template OWNER TO proxstar;

--
-- Name: template_id_seq; Type: SEQUENCE; Schema: public; Owner: proxstar
--

CREATE SEQUENCE public.template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_id_seq OWNER TO proxstar;

--
-- Name: template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxstar
--

ALTER SEQUENCE public.template_id_seq OWNED BY public.template.id;


--
-- Name: usage_limit; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.usage_limit (
    id character varying(32) NOT NULL,
    cpu integer NOT NULL,
    mem integer NOT NULL,
    disk integer NOT NULL
);


ALTER TABLE public.usage_limit OWNER TO proxstar;

--
-- Name: vm_expiration; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.vm_expiration (
    id integer NOT NULL,
    expire_date date NOT NULL
);


ALTER TABLE public.vm_expiration OWNER TO proxstar;

--
-- Name: vm_expiration_id_seq; Type: SEQUENCE; Schema: public; Owner: proxstar
--

CREATE SEQUENCE public.vm_expiration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vm_expiration_id_seq OWNER TO proxstar;

--
-- Name: vm_expiration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: proxstar
--

ALTER SEQUENCE public.vm_expiration_id_seq OWNED BY public.vm_expiration.id;


--
-- Name: template id; Type: DEFAULT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.template ALTER COLUMN id SET DEFAULT nextval('public.template_id_seq'::regclass);


--
-- Name: vm_expiration id; Type: DEFAULT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.vm_expiration ALTER COLUMN id SET DEFAULT nextval('public.vm_expiration_id_seq'::regclass);


--
-- Name: allowed_users allowed_users_pkey; Type: CONSTRAINT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.allowed_users
    ADD CONSTRAINT allowed_users_pkey PRIMARY KEY (id);


--
-- Name: ignored_pools ignored_pools_pkey; Type: CONSTRAINT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.ignored_pools
    ADD CONSTRAINT ignored_pools_pkey PRIMARY KEY (id);


--
-- Name: pool_cache pool_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.pool_cache
    ADD CONSTRAINT pool_cache_pkey PRIMARY KEY (pool);


--
-- Name: template template_pkey; Type: CONSTRAINT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT template_pkey PRIMARY KEY (id);


--
-- Name: usage_limit usage_limit_pkey; Type: CONSTRAINT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.usage_limit
    ADD CONSTRAINT usage_limit_pkey PRIMARY KEY (id);


--
-- Name: vm_expiration vm_expiration_pkey; Type: CONSTRAINT; Schema: public; Owner: proxstar
--

ALTER TABLE ONLY public.vm_expiration
    ADD CONSTRAINT vm_expiration_pkey PRIMARY KEY (id);


--
-- Name: DATABASE proxstar; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE proxstar TO proxstar;


--
-- PostgreSQL database dump complete
--

