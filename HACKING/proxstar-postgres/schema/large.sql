CREATE DATABASE proxstar; CREATE DATABASE starrs; CREATE ROLE proxstar; CREATE ROLE starrs;

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
-- Name: allowed_users; Type: TABLE; Schema: public; Owner: proxstar
--

CREATE TABLE public.shared_pools (
    name VARCHAR(32) PRIMARY KEY,
	members VARCHAR(32)[]
);


ALTER TABLE public.shared_pools OWNER TO proxstar;

--
-- Name: DATABASE proxstar; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE proxstar TO proxstar;


--
-- PostgreSQL database dump complete
--

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

DROP DATABASE starrs;
--
-- Name: starrs; Type: DATABASE; Schema: -; Owner: starrs
--

CREATE DATABASE starrs WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE starrs OWNER TO starrs;

\connect starrs

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
-- Name: DATABASE starrs; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON DATABASE starrs IS 'STARRS network management application';


--
-- Name: api; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA api;


ALTER SCHEMA api OWNER TO starrs;

--
-- Name: SCHEMA api; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA api IS 'Interaction with clients';


--
-- Name: dhcp; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA dhcp;


ALTER SCHEMA dhcp OWNER TO starrs;

--
-- Name: SCHEMA dhcp; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA dhcp IS 'Configuration for stateful addressing';


--
-- Name: dns; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA dns;


ALTER SCHEMA dns OWNER TO starrs;

--
-- Name: SCHEMA dns; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA dns IS 'All DNS records for the controlled zones/domains';


--
-- Name: ip; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA ip;


ALTER SCHEMA ip OWNER TO starrs;

--
-- Name: SCHEMA ip; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA ip IS 'Network resources available for devices';


--
-- Name: libvirt; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA libvirt;


ALTER SCHEMA libvirt OWNER TO starrs;

--
-- Name: SCHEMA libvirt; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA libvirt IS 'Libvirt interaction with VM hosts';


--
-- Name: management; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA management;


ALTER SCHEMA management OWNER TO starrs;

--
-- Name: SCHEMA management; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA management IS 'Application configuration and data';


--
-- Name: network; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA network;


ALTER SCHEMA network OWNER TO starrs;

--
-- Name: SCHEMA network; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA network IS 'Data on special network devices';


--
-- Name: systems; Type: SCHEMA; Schema: -; Owner: starrs
--

CREATE SCHEMA systems;


ALTER SCHEMA systems OWNER TO starrs;

--
-- Name: SCHEMA systems; Type: COMMENT; Schema: -; Owner: starrs
--

COMMENT ON SCHEMA systems IS 'User machine data for devices on the network';


--
-- Name: plperl; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plperl;


ALTER PROCEDURAL LANGUAGE plperl OWNER TO postgres;

--
-- Name: plperlu; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plperlu;


ALTER PROCEDURAL LANGUAGE plperlu OWNER TO postgres;

--
-- Name: plpython3u; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpython3u;


ALTER PROCEDURAL LANGUAGE plpython3u OWNER TO postgres;

--
-- Name: dhcpd_class_options; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_class_options AS (
	option text,
	value text
);


ALTER TYPE dhcp.dhcpd_class_options OWNER TO starrs;

--
-- Name: TYPE dhcpd_class_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_class_options IS 'Get class options for the dhcpd.conf';


--
-- Name: dhcpd_classes; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_classes AS (
	class text,
	comment text
);


ALTER TYPE dhcp.dhcpd_classes OWNER TO starrs;

--
-- Name: TYPE dhcpd_classes; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_classes IS 'Class information for dhcpd.conf';


--
-- Name: dhcpd_dns_keys; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_dns_keys AS (
	keyname text,
	key text,
	enctype text
);


ALTER TYPE dhcp.dhcpd_dns_keys OWNER TO starrs;

--
-- Name: TYPE dhcpd_dns_keys; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_dns_keys IS 'Get all dns key information for dhcpd';


--
-- Name: dhcpd_dynamic_hosts; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_dynamic_hosts AS (
	hostname character varying(63),
	zone text,
	mac macaddr,
	owner text,
	class text
);


ALTER TYPE dhcp.dhcpd_dynamic_hosts OWNER TO starrs;

--
-- Name: dhcpd_global_options; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_global_options AS (
	option text,
	value text
);


ALTER TYPE dhcp.dhcpd_global_options OWNER TO starrs;

--
-- Name: TYPE dhcpd_global_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_global_options IS 'Get all global DHCPD config directives';


--
-- Name: dhcpd_keys; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_keys AS (
	keyname text,
	key text
);


ALTER TYPE dhcp.dhcpd_keys OWNER TO starrs;

--
-- Name: TYPE dhcpd_keys; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_keys IS 'get the keys of the DHCP enabled subnet zones';


--
-- Name: dhcpd_range_options; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_range_options AS (
	option text,
	value text
);


ALTER TYPE dhcp.dhcpd_range_options OWNER TO starrs;

--
-- Name: TYPE dhcpd_range_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_range_options IS 'range options for the dhcpd.conf';


--
-- Name: dhcpd_range_settings; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_range_settings AS (
	setting text,
	value text
);


ALTER TYPE dhcp.dhcpd_range_settings OWNER TO starrs;

--
-- Name: TYPE dhcpd_range_settings; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_range_settings IS 'range settings for the dhcpd.conf';


--
-- Name: dhcpd_static_hosts; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_static_hosts AS (
	hostname character varying(63),
	zone text,
	mac macaddr,
	address inet,
	owner text,
	class text
);


ALTER TYPE dhcp.dhcpd_static_hosts OWNER TO starrs;

--
-- Name: TYPE dhcpd_static_hosts; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_static_hosts IS 'Dynamic host information for the dhcpd.conf';


--
-- Name: dhcpd_subnet_options; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_subnet_options AS (
	option text,
	value text
);


ALTER TYPE dhcp.dhcpd_subnet_options OWNER TO starrs;

--
-- Name: TYPE dhcpd_subnet_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_subnet_options IS 'Subnet options for the dhcpd.conf';


--
-- Name: dhcpd_subnet_ranges; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_subnet_ranges AS (
	name text,
	first_ip inet,
	last_ip inet,
	class text
);


ALTER TYPE dhcp.dhcpd_subnet_ranges OWNER TO starrs;

--
-- Name: TYPE dhcpd_subnet_ranges; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_subnet_ranges IS 'list all dynamic ranges within a subnet';


--
-- Name: dhcpd_subnet_settings; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_subnet_settings AS (
	setting text,
	value text
);


ALTER TYPE dhcp.dhcpd_subnet_settings OWNER TO starrs;

--
-- Name: TYPE dhcpd_subnet_settings; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_subnet_settings IS 'Subnet settings for the dhcpd.conf';


--
-- Name: dhcpd_zones; Type: TYPE; Schema: dhcp; Owner: starrs
--

CREATE TYPE dhcp.dhcpd_zones AS (
	zone text,
	keyname text,
	primary_ns inet
);


ALTER TYPE dhcp.dhcpd_zones OWNER TO starrs;

--
-- Name: TYPE dhcpd_zones; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TYPE dhcp.dhcpd_zones IS 'Zone information for dhcpd';


--
-- Name: zone_audit_data; Type: TYPE; Schema: dns; Owner: starrs
--

CREATE TYPE dns.zone_audit_data AS (
	host text,
	ttl integer,
	type text,
	address inet,
	port integer,
	weight integer,
	priority integer,
	preference integer,
	target text,
	text text,
	contact text,
	serial text,
	refresh integer,
	retry integer,
	expire integer,
	minimum integer
);


ALTER TYPE dns.zone_audit_data OWNER TO starrs;

--
-- Name: TYPE zone_audit_data; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TYPE dns.zone_audit_data IS 'All DNS zone data for auditing purposes';


--
-- Name: domain_data; Type: TYPE; Schema: libvirt; Owner: starrs
--

CREATE TYPE libvirt.domain_data AS (
	domain text,
	state text,
	definition text
);


ALTER TYPE libvirt.domain_data OWNER TO starrs;

--
-- Name: domains; Type: TYPE; Schema: libvirt; Owner: starrs
--

CREATE TYPE libvirt.domains AS (
	host_name text,
	domain_name text,
	state text,
	definition text,
	date_created timestamp without time zone,
	date_modified timestamp without time zone,
	last_modifier text
);


ALTER TYPE libvirt.domains OWNER TO starrs;

--
-- Name: search_data; Type: TYPE; Schema: management; Owner: starrs
--

CREATE TYPE management.search_data AS (
	datacenter text,
	availability_zone text,
	system_name text,
	location text,
	asset text,
	"group" text,
	platform text,
	mac macaddr,
	address inet,
	config text,
	system_owner text,
	system_last_modifier text,
	range text,
	hostname character varying(63),
	cname_alias character varying(63),
	srv_alias character varying(63),
	zone text,
	dns_owner text,
	dns_last_modifier text
);


ALTER TYPE management.search_data OWNER TO starrs;

--
-- Name: cam; Type: TYPE; Schema: network; Owner: starrs
--

CREATE TYPE network.cam AS (
	mac macaddr,
	ifindex integer,
	vlan integer
);


ALTER TYPE network.cam OWNER TO starrs;

--
-- Name: switchports; Type: TYPE; Schema: network; Owner: starrs
--

CREATE TYPE network.switchports AS (
	system_name text,
	name text,
	"desc" text,
	ifindex integer,
	alias text,
	admin_state boolean,
	oper_state boolean,
	date_created timestamp without time zone,
	date_modified timestamp without time zone,
	last_modifier text,
	vlan integer
);


ALTER TYPE network.switchports OWNER TO starrs;

--
-- Name: os_distribution; Type: TYPE; Schema: systems; Owner: starrs
--

CREATE TYPE systems.os_distribution AS (
	name text,
	count integer,
	percentage integer
);


ALTER TYPE systems.os_distribution OWNER TO starrs;

--
-- Name: TYPE os_distribution; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TYPE systems.os_distribution IS 'OS distribution statistics';


--
-- Name: os_family_distribution; Type: TYPE; Schema: systems; Owner: starrs
--

CREATE TYPE systems.os_family_distribution AS (
	family text,
	count integer,
	percentage integer
);


ALTER TYPE systems.os_family_distribution OWNER TO starrs;

--
-- Name: TYPE os_family_distribution; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TYPE systems.os_family_distribution IS 'OS distribution statistics';


--
-- Name: add_libvirt_domain(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.add_libvirt_domain(input_host text, input_domain text) RETURNS SETOF libvirt.domains
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "system"."systems" WHERE "system_name" = input_host) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied: Not owner of host!';
			END IF;

			IF (SELECT "owner" FROM "system"."systems" WHERE "system_name" = input_domain) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied: Not owner of domain!';
			END IF;
		END IF;

		IF (SELECT "type" FROM "systems"."systems" WHERE "system_name" = input_host) != 'VM Host' THEN
			RAISE EXCEPTION 'Host type mismatch. You need a VM Host.';
		END IF;

		IF (SELECT "type" FROM "systems"."systems" WHERE "system_name" = input_domain) != 'Virtual Machine' THEN
			RAISE EXCEPTION 'Domain type mismatch. You need a Virtual Machine.';
		END IF;

		INSERT INTO "libvirt"."domains" ("host_name", "domain_name") VALUES (input_host, input_domain);
		
		RETURN QUERY (SELECT * FROM "libvirt"."domains" WHERE "domain_name" = input_domain);
	END;
$$;


ALTER FUNCTION api.add_libvirt_domain(input_host text, input_domain text) OWNER TO starrs;

--
-- Name: FUNCTION add_libvirt_domain(input_host text, input_domain text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.add_libvirt_domain(input_host text, input_domain text) IS 'Assign a VM to a host';


--
-- Name: change_username(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.change_username(old_username text, new_username text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Only admins can change usernames';
		END IF;
		
		-- Perform update
		UPDATE "dhcp"."class_options" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "ip"."range_uses" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "ip"."subnets" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "ip"."subnets" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "ip"."ranges" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."ns" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."os_family" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."interface_addresses" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dhcp"."classes" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."systems" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "systems"."systems" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dhcp"."subnet_options" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dhcp"."config_types" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."os" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."cname" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."cname" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."srv" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."srv" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."mx" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."mx" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."zones" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."zones" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."soa" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."keys" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."keys" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "ip"."addresses" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "ip"."addresses" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."txt" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."txt" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."zone_txt" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "management"."log_master" SET "user" = new_username WHERE "user" = old_username;
		UPDATE "dns"."a" SET "owner" = new_username WHERE "owner" = old_username;
		UPDATE "dns"."a" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."interfaces" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "management"."configuration" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dhcp"."range_options" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dhcp"."global_options" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."types" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "dns"."zone_a" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "network"."snmp" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."architectures" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."platforms" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."datacenters" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "systems"."availability_zones" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
	     UPDATE "management"."group_members" SET "user" = new_username WHERE "user" = old_username;
		UPDATE "management"."groups" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "management"."group_members" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "network"."cam_cache" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		UPDATE "network"."vlans" SET "last_modifier" = new_username WHERE "last_modifier" = old_username;
		PERFORM api.syslog('changed user "'||old_username||'" to "'||new_username);
		
		-- Done
	END;
$$;


ALTER FUNCTION api.change_username(old_username text, new_username text) OWNER TO starrs;

--
-- Name: FUNCTION change_username(old_username text, new_username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.change_username(old_username text, new_username text) IS 'Change all references to an old username to a new one';


--
-- Name: check_dns_hostname(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.check_dns_hostname(input_hostname text, input_zone text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER := 0;
	BEGIN
		RowCount := RowCount + (SELECT COUNT(*) FROM "dns"."a" WHERE "hostname" = input_hostname AND "zone" = input_zone);
		RowCount := RowCount + (SELECT COUNT(*) FROM "dns"."srv" WHERE "alias" = input_hostname AND "zone" = input_zone);
		RowCount := RowCount + (SELECT COUNT(*) FROM "dns"."cname" WHERE "alias" = input_hostname AND "zone" = input_zone);

		IF RowCount = 0 THEN
			RETURN FALSE;
		ELSE
			RETURN TRUE;
		END IF;
	END;
$$;


ALTER FUNCTION api.check_dns_hostname(input_hostname text, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION check_dns_hostname(input_hostname text, input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.check_dns_hostname(input_hostname text, input_zone text) IS 'Check if a hostname is available in a given zone';


--
-- Name: clear_expired_addresses(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.clear_expired_addresses() RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		SystemData RECORD;
	BEGIN
		--FOR SystemData IN (SELECT "system_name" FROM "systems"."systems" WHERE "systems"."systems"."renew_date" = current_date) LOOP
		--	PERFORM "api"."remove_system"(SystemData.system_name);
		--END LOOP;
		FOR SystemData IN (SELECT "address" FROM "systems"."interface_addresses" WHERE "renew_date" <= current_date) LOOP
			PERFORM "api"."remove_interface_address"(SystemData.address);
		END LOOP;
	END;
$$;


ALTER FUNCTION api.clear_expired_addresses() OWNER TO starrs;

--
-- Name: FUNCTION clear_expired_addresses(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.clear_expired_addresses() IS 'Remove all expired addresses.';


--
-- Name: control_libvirt_domain(text, text, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.control_libvirt_domain(sysuri text, syspassword text, domain text, action text) RETURNS text
    LANGUAGE plpython3u
    AS $$
	#!/usr/bin/python
	
	import libvirt
	import sys

	def request_credentials(credentials, data):
		for credential in credentials:
			if credential[0] == libvirt.VIR_CRED_AUTHNAME:
				return 0
			elif credential[0] == libvirt.VIR_CRED_NOECHOPROMPT:
				credential[4] = syspassword
			else:
				return -1

		return 0

	auth = [[libvirt.VIR_CRED_AUTHNAME, libvirt.VIR_CRED_NOECHOPROMPT], request_credentials, None]
	conn = libvirt.openAuth(sysuri, auth, 0)

	dom = conn.lookupByName(domain)
	
	if action == 'destroy':
		dom.destroy()
	elif action == 'shutdown':
		dom.shutdown()
	elif action == 'reboot':
		dom.reboot(0)
	elif action == 'reset':
		dom.reset(0)
	elif action == 'resume':
		dom.resume()
	elif action == 'restore':
		dom.restore()
	elif action == 'suspend':
		dom.suspend()
	elif action == 'save':
		dom.save()
	elif action == 'create':
		dom.create()
	else:
		sys.exit("Invalid action")

	conn.close()
	state_names = { libvirt.VIR_DOMAIN_RUNNING  : "running",
		libvirt.VIR_DOMAIN_BLOCKED  : "idle",
		libvirt.VIR_DOMAIN_PAUSED   : "paused",
		libvirt.VIR_DOMAIN_SHUTDOWN : "in shutdown",
		libvirt.VIR_DOMAIN_SHUTOFF  : "shut off",
		libvirt.VIR_DOMAIN_CRASHED  : "crashed",
		libvirt.VIR_DOMAIN_NOSTATE  : "no state" }
	return state_names[dom.info()[0]]
$$;


ALTER FUNCTION api.control_libvirt_domain(sysuri text, syspassword text, domain text, action text) OWNER TO postgres;

--
-- Name: create_address_range(inet, inet, cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_address_range(input_first_ip inet, input_last_ip inet, input_subnet cidr) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
		Owner TEXT;
		RangeAddresses RECORD;
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "ip"."subnets" WHERE "subnet" = input_subnet) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on subnet %. You are not owner',input_subnet;
			END IF;
		END IF;

		-- Check if subnet exists
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."subnets"
		WHERE "ip"."subnets"."subnet" = input_subnet;
		IF (RowCount < 1) THEN
			RAISE EXCEPTION 'Subnet (%) does not exist.',input_subnet;
		END IF;

		-- Check if addresses are within subnet
		IF NOT input_first_ip << input_subnet THEN
			RAISE EXCEPTION 'First address (%) not within subnet (%)',input_first_ip,input_subnet;
		END IF;

		IF NOT input_last_ip << input_subnet THEN
			RAISE EXCEPTION 'Last address (%) not within subnet (%)',input_last_ip,input_subnet;
		END IF;

		-- Check if autogen'd
		IF (SELECT "autogen" FROM "ip"."subnets" WHERE "ip"."subnets"."subnet" = input_subnet LIMIT 1) IS TRUE THEN
			RAISE EXCEPTION 'Subnet (%) addresses were autogenerated. Cannot create new addresses.',input_subnet;
		END IF;

		-- Get owner
		SELECT "ip"."subnets"."owner" INTO Owner 
		FROM "ip"."subnets"
		WHERE "ip"."subnets"."subnet" = input_subnet;

		-- Create addresses
		FOR RangeAddresses IN SELECT api.get_range_addresses(input_first_ip,input_last_ip) LOOP
			INSERT INTO "ip"."addresses" ("address","owner") VALUES (RangeAddresses.get_range_addresses,Owner);
		END LOOP;

		-- Done
		PERFORM api.syslog('create_address_range:"'||input_first_ip||'","'||input_last_ip||'","'||input_subnet||'"');
		PERFORM api.syslog('WARNING! Potential deprecated function in use!');
	END;
$$;


ALTER FUNCTION api.create_address_range(input_first_ip inet, input_last_ip inet, input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION create_address_range(input_first_ip inet, input_last_ip inet, input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_address_range(input_first_ip inet, input_last_ip inet, input_subnet cidr) IS 'Create a range of addresses from a non-autogened subnet (intended for DHCPv6)';


--
-- Name: get_current_user(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_current_user() RETURNS text
    LANGUAGE plpgsql
    AS $$
        BEGIN
                RETURN (SELECT "username"
                FROM "user_privileges"
                WHERE "privilege" = 'USERNAME');
        END;
$$;


ALTER FUNCTION api.get_current_user() OWNER TO starrs;

--
-- Name: FUNCTION get_current_user(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_current_user() IS 'Get the username of the current session';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: availability_zones; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.availability_zones (
    datacenter text NOT NULL,
    zone text NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE systems.availability_zones OWNER TO starrs;

--
-- Name: TABLE availability_zones; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.availability_zones IS 'Availability zones within datacenters';


--
-- Name: create_availability_zone(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_availability_zone(input_datacenter text, input_zone text, input_comment text) RETURNS SETOF systems.availability_zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied to create availability zone: not admin';
		END IF;
		
		-- Create availability_zones
		INSERT INTO "systems"."availability_zones" ("datacenter","zone","comment") VALUES (input_datacenter, input_zone, input_comment);

		-- Done
		PERFORM api.syslog('create_availability_zone:"'||input_datacenter||'","'||input_zone||'"');	
		RETURN QUERY (SELECT * FROM "systems"."availability_zones" WHERE "datacenter" = input_datacenter AND "zone" = input_zone);
	END;
$$;


ALTER FUNCTION api.create_availability_zone(input_datacenter text, input_zone text, input_comment text) OWNER TO starrs;

--
-- Name: FUNCTION create_availability_zone(input_datacenter text, input_zone text, input_comment text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_availability_zone(input_datacenter text, input_zone text, input_comment text) IS 'Create a new availability zone';


--
-- Name: datacenters; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.datacenters (
    datacenter text NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE systems.datacenters OWNER TO starrs;

--
-- Name: TABLE datacenters; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.datacenters IS 'Regional locations for systems';


--
-- Name: create_datacenter(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_datacenter(input_name text, input_comment text) RETURNS SETOF systems.datacenters
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied to create datacenter: not admin';
		END IF;
		
		-- Create datacenter
		INSERT INTO "systems"."datacenters" ("datacenter","comment") VALUES (input_name,input_comment);

		-- Done
		PERFORM api.syslog('create_datacenter:"'||input_name||'"');
		RETURN QUERY (SELECT * FROM "systems"."datacenters" WHERE "datacenter" = input_name);
	END;
$$;


ALTER FUNCTION api.create_datacenter(input_name text, input_comment text) OWNER TO starrs;

--
-- Name: FUNCTION create_datacenter(input_name text, input_comment text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_datacenter(input_name text, input_comment text) IS 'Create a new datacenter';


--
-- Name: classes; Type: TABLE; Schema: dhcp; Owner: starrs
--

CREATE TABLE dhcp.classes (
    class text NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE dhcp.classes OWNER TO starrs;

--
-- Name: TABLE classes; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TABLE dhcp.classes IS 'DHCP classes allow configuration of hosts in certain ways';


--
-- Name: create_dhcp_class(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dhcp_class(input_class text, input_comment text) RETURNS SETOF dhcp.classes
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to create dhcp class denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Validate input
		input_class := api.validate_nospecial(input_class);

		-- Create new class		
		INSERT INTO "dhcp"."classes" ("class","comment") VALUES (input_class,input_comment);

		-- Done
		PERFORM api.syslog('create_dhcp_class:"'||input_class||'"');
		RETURN QUERY (SELECT * FROM "dhcp"."classes" WHERE "class" = input_class);
	END;
$$;


ALTER FUNCTION api.create_dhcp_class(input_class text, input_comment text) OWNER TO starrs;

--
-- Name: FUNCTION create_dhcp_class(input_class text, input_comment text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dhcp_class(input_class text, input_comment text) IS 'Create a new DHCP class';


--
-- Name: class_options; Type: TABLE; Schema: dhcp; Owner: starrs
--

CREATE TABLE dhcp.class_options (
    option text NOT NULL,
    value text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    class text NOT NULL
);


ALTER TABLE dhcp.class_options OWNER TO starrs;

--
-- Name: TABLE class_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TABLE dhcp.class_options IS 'Options to apply to a specific DHCP class (like Netbooting)';


--
-- Name: create_dhcp_class_option(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dhcp_class_option(input_class text, input_option text, input_value text) RETURNS SETOF dhcp.class_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to create dhcp class option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Create class option		
		INSERT INTO "dhcp"."class_options" 
		("class","option","value") VALUES
		(input_class,input_option,input_value);

		-- Done
		PERFORM api.syslog('create_dhcp_class_option:"'||input_class||'","'||input_option||'","'||input_value||'"');
		RETURN QUERY (SELECT * FROM "dhcp"."class_options" WHERE "class" = input_class AND "option" = input_option AND "value" = input_value);
	END;
$$;


ALTER FUNCTION api.create_dhcp_class_option(input_class text, input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION create_dhcp_class_option(input_class text, input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dhcp_class_option(input_class text, input_option text, input_value text) IS 'Create a new DHCP class option';


--
-- Name: global_options; Type: TABLE; Schema: dhcp; Owner: starrs
--

CREATE TABLE dhcp.global_options (
    option text NOT NULL,
    value text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE dhcp.global_options OWNER TO starrs;

--
-- Name: TABLE global_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TABLE dhcp.global_options IS 'Global DHCP options that affect all objects';


--
-- Name: create_dhcp_global_option(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dhcp_global_option(input_option text, input_value text) RETURNS SETOF dhcp.global_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to create dhcp class option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Create class option		
		INSERT INTO "dhcp"."global_options" 
		("option","value") VALUES (input_option,input_value);

		-- Done
		PERFORM api.syslog('create_dhcp_global_option:"'||input_option||'","'||input_value||'"');
		RETURN QUERY (SELECT * FROM "dhcp"."global_options" WHERE "option" = input_option AND "value" = input_value);
	END;
$$;


ALTER FUNCTION api.create_dhcp_global_option(input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION create_dhcp_global_option(input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dhcp_global_option(input_option text, input_value text) IS 'Create a new DHCP global option';


--
-- Name: range_options; Type: TABLE; Schema: dhcp; Owner: starrs
--

CREATE TABLE dhcp.range_options (
    option text NOT NULL,
    name text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    value text NOT NULL
);


ALTER TABLE dhcp.range_options OWNER TO starrs;

--
-- Name: TABLE range_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TABLE dhcp.range_options IS 'DHCP options that apply to a specific range';


--
-- Name: create_dhcp_range_option(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dhcp_range_option(input_range text, input_option text, input_value text) RETURNS SETOF dhcp.range_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission to create dhcp range option denied for user %. You are not admin.',api.get_current_user();
		END IF;

		-- Check if range is marked for DHCP
		IF (SELECT "use" FROM "ip"."ranges" WHERE "name" = input_range) !~* 'ROAM' THEN
			RAISE EXCEPTION 'Range % is not marked for DHCP configuration',input_range;
		END IF;

		-- Create option
		INSERT INTO "dhcp"."range_options" ("name","option","value","last_modifier")
		VALUES (input_range, input_option, input_value, api.get_current_user());

		-- Done
		PERFORM api.syslog('create_dhcp_range_option:"'||input_range||'","'||input_option||'","'||input_value||'"');
		RETURN QUERY (SELECT * FROM "dhcp"."range_options" WHERE "name" = input_range AND "option" = input_option AND "value" = input_value);
	END;
$$;


ALTER FUNCTION api.create_dhcp_range_option(input_range text, input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION create_dhcp_range_option(input_range text, input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dhcp_range_option(input_range text, input_option text, input_value text) IS 'Create a DHCP range option';


--
-- Name: subnet_options; Type: TABLE; Schema: dhcp; Owner: starrs
--

CREATE TABLE dhcp.subnet_options (
    option text NOT NULL,
    value text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    subnet cidr NOT NULL
);


ALTER TABLE dhcp.subnet_options OWNER TO starrs;

--
-- Name: TABLE subnet_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TABLE dhcp.subnet_options IS 'Options to apply to an entire subnet';


--
-- Name: create_dhcp_subnet_option(cidr, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text) RETURNS SETOF dhcp.subnet_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to create dhcp subnet option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Create subnet option		
		INSERT INTO "dhcp"."subnet_options" 
		("subnet","option","value") VALUES
		(input_subnet,input_option,input_value);

		-- Done
		PERFORM api.syslog('create_dhcp_subnet_option:"'||input_subnet||'","'||input_option||'","'||input_value||'"');
		RETURN QUERY (SELECT * FROM "dhcp"."subnet_options" WHERE "subnet" = input_subnet AND "option" = input_option AND "value" = input_value);
	END;
$$;


ALTER FUNCTION api.create_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION create_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text) IS 'Create DHCP subnet option';


--
-- Name: get_site_configuration(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_site_configuration(input_directive text) RETURNS text
    LANGUAGE plpgsql
    AS $$
        BEGIN
                RETURN (SELECT "value" FROM "management"."configuration" WHERE "option" = input_directive);
        END;
$$;


ALTER FUNCTION api.get_site_configuration(input_directive text) OWNER TO starrs;

--
-- Name: FUNCTION get_site_configuration(input_directive text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_site_configuration(input_directive text) IS 'Get a site configuration directive';


--
-- Name: a; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.a (
    hostname character varying(63) NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    address inet NOT NULL,
    type text NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    owner text NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    reverse boolean DEFAULT true NOT NULL,
    CONSTRAINT dns_a_hostname CHECK (((hostname)::text !~ '_'::text)),
    CONSTRAINT dns_a_type_check CHECK ((type ~ '^A|AAAA$'::text))
);


ALTER TABLE dns.a OWNER TO starrs;

--
-- Name: TABLE a; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.a IS 'DNS forward address records';


--
-- Name: create_dns_address(inet, text, text, integer, text, boolean, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_address(input_address inet, input_hostname text, input_zone text, input_ttl integer, input_type text, input_reverse boolean, input_owner text) RETURNS SETOF dns.a
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Set owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Autofill Type
		IF input_type IS NULL THEN
			IF family(input_address) = 4 THEN
				input_type := 'A';
			ELSEIF family(input_address) = 6 THEN
				input_type := 'AAAA';
			END IF;
		END IF;

		-- Check type
		IF input_type !~* '^A|AAAA$' THEN
			RAISE EXCEPTION 'Bad type % given',input_type;
		END IF;

		-- Lower
		input_hostname := lower(input_hostname);

		-- Validate type
		IF family(input_address) = 4 AND input_type !~* '^A$' THEN
			RAISE EXCEPTION 'IPv4 Address/Type mismatch';
		ELSEIF family(input_address) = 6 AND input_type !~* '^AAAA$' THEN
			RAISE EXCEPTION 'IPv6 Address/Type mismatch';
		END IF;
		
		-- User can only specify TTL if address is static
		IF (SELECT "config" FROM "systems"."interface_addresses" WHERE "address" = input_address) !~* 'static' AND input_ttl != (SELECT "value"::integer/2 AS "ttl" FROM "dhcp"."subnet_options" WHERE "option"='default-lease-time' AND "subnet" >> input_address) THEN
			RAISE EXCEPTION 'You can only specify a TTL other than the default if your address is configured statically';
		END IF;

		-- Check privileges
	     IF api.get_current_user_level() !~* 'ADMIN' THEN
			-- Shared zone
		     IF (SELECT "shared" FROM "dns"."zones" WHERE "zone" = input_zone) IS FALSE THEN
			 	RAISE EXCEPTION 'Zone is not shared and you are not admin';
			END IF;
	   		-- You own the system
			IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system(input_address))) IS FALSE THEN
				RAISE EXCEPTION 'Permission denied';
			END IF;
	   		-- You specified another owner
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only admins can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Validate hostname
		IF api.validate_domain(input_hostname,input_zone) IS FALSE THEN
			RAISE EXCEPTION 'Invalid hostname (%) and domain (%)',input_hostname,input_zone;
		END IF;

		-- Create record
		INSERT INTO "dns"."a" ("hostname","zone","address","ttl","type","owner","reverse") VALUES 
		(input_hostname,input_zone,input_address,input_ttl,input_type,input_owner,input_reverse);

		-- Done
		PERFORM api.syslog('create_dns_address:"'||input_address||'","'||input_hostname||'","'||input_zone||'"');
		RETURN QUERY (SELECT * FROM "dns"."a" WHERE "address" = input_address AND "hostname" = input_hostname AND "zone" = input_zone);
	END;
$_$;


ALTER FUNCTION api.create_dns_address(input_address inet, input_hostname text, input_zone text, input_ttl integer, input_type text, input_reverse boolean, input_owner text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_address(input_address inet, input_hostname text, input_zone text, input_ttl integer, input_type text, input_reverse boolean, input_owner text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_address(input_address inet, input_hostname text, input_zone text, input_ttl integer, input_type text, input_reverse boolean, input_owner text) IS 'create a new A or AAAA record';


--
-- Name: cname; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.cname (
    alias character varying(63) NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    hostname character varying(63) NOT NULL,
    address inet NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    owner text NOT NULL,
    type text DEFAULT 'CNAME'::text NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL
);


ALTER TABLE dns.cname OWNER TO starrs;

--
-- Name: TABLE cname; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.cname IS 'CNAME records';


--
-- Name: create_dns_cname(text, text, text, integer, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_cname(input_alias text, input_target text, input_zone text, input_ttl integer, input_owner text) RETURNS SETOF dns.cname
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Validate input
		IF api.validate_domain(input_alias,NULL) IS FALSE THEN
			RAISE EXCEPTION 'Invalid alias (%)',input_alias;
		END IF;

		-- Set owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Lower
		input_target := lower(input_target);
		input_alias := lower(input_alias);

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You specified another owner
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
	   		-- You own the system
               IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system((SELECT "address" FROM "dns"."a" WHERE "hostname" = input_target AND "zone" = input_zone)))) IS FALSE THEN
	               RAISE EXCEPTION 'Permission denied';
               END IF;
		END IF;

		-- Check for in use
		IF (SELECT api.check_dns_hostname(input_alias, input_zone)) IS TRUE THEN
			RAISE EXCEPTION 'Record with this hostname and zone already exists';
		END IF;

		-- Create record
		INSERT INTO "dns"."cname" ("alias","hostname","zone","ttl","owner") VALUES
		(input_alias, input_target, input_zone, input_ttl, input_owner);
		
		-- Done
		PERFORM api.syslog('create_dns_cname:"'||input_alias||'","'||input_target||'","'||input_zone||'"');
		RETURN QUERY (SELECT * FROM "dns"."cname" WHERE "alias" = input_alias AND "hostname" = input_target AND "zone" = input_zone);
	END;
$$;


ALTER FUNCTION api.create_dns_cname(input_alias text, input_target text, input_zone text, input_ttl integer, input_owner text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_cname(input_alias text, input_target text, input_zone text, input_ttl integer, input_owner text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_cname(input_alias text, input_target text, input_zone text, input_ttl integer, input_owner text) IS 'create a new dns cname record for a host';


--
-- Name: keys; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.keys (
    keyname text NOT NULL,
    key text NOT NULL,
    enctype text NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    comment text,
    owner text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE dns.keys OWNER TO starrs;

--
-- Name: TABLE keys; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.keys IS 'Zone keys';


--
-- Name: create_dns_key(text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_key(input_keyname text, input_key text, input_enctype text, input_owner text, input_comment text) RETURNS SETOF dns.keys
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Validate input
		input_keyname := api.validate_nospecial(input_keyname);

		-- Fill in owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Create new key
		INSERT INTO "dns"."keys"
		("keyname","key","enctype","comment","owner") VALUES
		(input_keyname,input_key,input_enctype,input_comment,input_owner);

		-- Done
		PERFORM api.syslog('create_dns_key:"'||input_keyname||'"');
		RETURN QUERY (SELECT * FROM "dns"."keys" WHERE "keyname" = input_keyname AND "key" = input_key);
	END;
$$;


ALTER FUNCTION api.create_dns_key(input_keyname text, input_key text, input_enctype text, input_owner text, input_comment text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_key(input_keyname text, input_key text, input_enctype text, input_owner text, input_comment text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_key(input_keyname text, input_key text, input_enctype text, input_owner text, input_comment text) IS 'Create new DNS key';


--
-- Name: mx; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.mx (
    preference integer NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    hostname character varying(63) NOT NULL,
    address inet NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    owner text NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    type text NOT NULL
);


ALTER TABLE dns.mx OWNER TO starrs;

--
-- Name: TABLE mx; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.mx IS 'Mail servers (MX records)';


--
-- Name: create_dns_mailserver(text, text, integer, integer, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_mailserver(input_hostname text, input_zone text, input_preference integer, input_ttl integer, input_owner text) RETURNS SETOF dns.mx
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Set owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Lower
		input_hostname := lower(input_hostname);

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on zone %. You are not owner.',input_zone;
			END IF;
	   		-- You specified a different owner
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Create record
		INSERT INTO "dns"."mx" ("hostname","zone","preference","ttl","owner","type") VALUES
		(input_hostname,input_zone,input_preference,input_ttl,input_owner,'MX');
		
		-- Done
		PERFORM api.syslog('create_dns_mailserver:"'||input_hostname||'","'||input_zone||'","'||input_preference||'"');
		RETURN QUERY (SELECT * FROM "dns"."mx" WHERE "hostname" = input_hostname AND "zone" = input_zone AND "preference" = input_preference);
	END;
$$;


ALTER FUNCTION api.create_dns_mailserver(input_hostname text, input_zone text, input_preference integer, input_ttl integer, input_owner text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_mailserver(input_hostname text, input_zone text, input_preference integer, input_ttl integer, input_owner text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_mailserver(input_hostname text, input_zone text, input_preference integer, input_ttl integer, input_owner text) IS 'Create a new mailserver MX record for a zone';


--
-- Name: ns; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.ns (
    zone text NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    type text DEFAULT 'NS'::text NOT NULL,
    nameserver text NOT NULL,
    address inet NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE dns.ns OWNER TO starrs;

--
-- Name: TABLE ns; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.ns IS 'Nameservers (to be inserted as NS records)';


--
-- Name: create_dns_ns(text, text, inet, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_ns(input_zone text, input_nameserver text, input_address inet, input_ttl integer) RETURNS SETOF dns.ns
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Lower
		input_nameserver := lower(input_nameserver);
		input_zone := lower(input_zone);

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on zone %. You are not owner.',input_zone;
			END IF;
		END IF;

		-- Create record
		INSERT INTO "dns"."ns" ("zone","ttl","nameserver","address") VALUES
		(input_zone,input_ttl,input_nameserver,input_address);
		
		-- Update TTLs of other zone records since they all need to be the same
		UPDATE "dns"."ns" SET "ttl" = input_ttl WHERE "zone" = input_zone;
		
		-- Done
		PERFORM api.syslog('create_dns_ns:"'||input_nameserver||'"');
		RETURN QUERY (SELECT * FROM "dns"."ns" WHERE "zone" = input_zone AND "nameserver" = input_nameserver);
	END;
$$;


ALTER FUNCTION api.create_dns_ns(input_zone text, input_nameserver text, input_address inet, input_ttl integer) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_ns(input_zone text, input_nameserver text, input_address inet, input_ttl integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_ns(input_zone text, input_nameserver text, input_address inet, input_ttl integer) IS 'create a new NS record for a zone';


--
-- Name: soa; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.soa (
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    nameserver text DEFAULT ('ns1.'::text || api.get_site_configuration('DNS_DEFAULT_ZONE'::text)) NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    contact text DEFAULT ('hostmaster.'::text || api.get_site_configuration('DNS_DEFAULT_ZONE'::text)) NOT NULL,
    serial text DEFAULT '0000000000'::text NOT NULL,
    refresh integer DEFAULT 3600 NOT NULL,
    retry integer DEFAULT 600 NOT NULL,
    expire integer DEFAULT 172800 NOT NULL,
    minimum integer DEFAULT 43200 NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE dns.soa OWNER TO starrs;

--
-- Name: TABLE soa; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.soa IS 'SOA records for DNS zones';


--
-- Name: create_dns_soa(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_soa(input_zone text) RETURNS SETOF dns.soa
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to create SOA % denied for user %. Not admin.',input_zone,api.get_current_user();
			END IF;
		END IF;
		
		-- Create soa
		INSERT INTO "dns"."soa" SELECT * FROM api.query_dns_soa(input_zone);

		-- Done
		PERFORM api.syslog('create_dns_soa:"'||input_zone||'"');
		RETURN QUERY (SELECT * FROM "dns"."soa" WHERE "zone" = input_zone);
	END;
$$;


ALTER FUNCTION api.create_dns_soa(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_soa(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_soa(input_zone text) IS 'Create a new DNS soa';


--
-- Name: srv; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.srv (
    alias character varying(63) NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    weight integer DEFAULT 0 NOT NULL,
    port integer NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    hostname character varying(63) NOT NULL,
    address inet NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    owner text NOT NULL,
    type text DEFAULT 'SRV'::text NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL
);


ALTER TABLE dns.srv OWNER TO starrs;

--
-- Name: TABLE srv; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.srv IS 'SRV records';


--
-- Name: create_dns_srv(text, text, text, integer, integer, integer, integer, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_srv(input_alias text, input_target text, input_zone text, input_priority integer, input_weight integer, input_port integer, input_ttl integer, input_owner text) RETURNS SETOF dns.srv
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Validate input
		IF api.validate_srv(input_alias) IS FALSE THEN
			RAISE EXCEPTION 'Invalid alias (%)',input_alias;
		END IF;

		-- Set owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Lower
		input_target := lower(input_target);
		input_alias := lower(input_alias);

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on zone %. You are not owner.',input_zone;
			END IF;
	   		-- You specified another owner
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Create record
		INSERT INTO "dns"."srv" ("alias","hostname","zone","priority","weight","port","ttl","owner") VALUES
		(input_alias, input_target, input_zone, input_priority, input_weight, input_port, input_ttl, input_owner);
		
		-- Done
		PERFORM api.syslog('create_dns_srv:"'||input_alias||'","'||input_target||'","'||input_zone||'","'||input_priority||'","'||input_weight||'","'||input_port||'","'||input_ttl||'"');
		RETURN QUERY (SELECT * FROM "dns"."srv" WHERE "alias" = input_alias AND "hostname" = input_target AND "zone" = input_zone AND "priority" = input_priority AND "weight" = input_weight AND "port" = input_port);
	END;
$$;


ALTER FUNCTION api.create_dns_srv(input_alias text, input_target text, input_zone text, input_priority integer, input_weight integer, input_port integer, input_ttl integer, input_owner text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_srv(input_alias text, input_target text, input_zone text, input_priority integer, input_weight integer, input_port integer, input_ttl integer, input_owner text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_srv(input_alias text, input_target text, input_zone text, input_priority integer, input_weight integer, input_port integer, input_ttl integer, input_owner text) IS 'create a new dns srv record for a zone';


--
-- Name: txt; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.txt (
    text text NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    hostname character varying(63) NOT NULL,
    address inet NOT NULL,
    type text DEFAULT 'TXT'::text NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    owner text NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    CONSTRAINT dns_txt_type_check CHECK ((type ~* '^TXT$'::text))
);


ALTER TABLE dns.txt OWNER TO starrs;

--
-- Name: TABLE txt; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.txt IS 'TXT records for hosts';


--
-- Name: create_dns_txt(text, text, text, integer, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_txt(input_hostname text, input_zone text, input_text text, input_ttl integer, input_owner text) RETURNS SETOF dns.txt
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Set owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Lower
		input_hostname := lower(input_hostname);

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on zone %. You are not owner.',input_zone;
			END IF;
	   		-- You specified a different owner
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Create record
		INSERT INTO "dns"."txt" ("hostname","zone","text","ttl","owner") VALUES
		(input_hostname,input_zone,input_text,input_ttl,input_owner);
		
		-- Done
		PERFORM api.syslog('create_dns_txt:"'||input_hostname||'","'||input_zone||'","'||input_text||'"');
		RETURN QUERY (SELECT * FROM "dns"."txt" WHERE "hostname" = input_hostname AND "zone" = input_zone AND "text" = input_text);
	END;
$$;


ALTER FUNCTION api.create_dns_txt(input_hostname text, input_zone text, input_text text, input_ttl integer, input_owner text) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_txt(input_hostname text, input_zone text, input_text text, input_ttl integer, input_owner text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_txt(input_hostname text, input_zone text, input_text text, input_ttl integer, input_owner text) IS 'create a new dns TXT record for a host';


--
-- Name: zones; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.zones (
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    forward boolean NOT NULL,
    keyname text NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    owner text NOT NULL,
    comment text,
    shared boolean DEFAULT false NOT NULL,
    ddns boolean DEFAULT false NOT NULL
);


ALTER TABLE dns.zones OWNER TO starrs;

--
-- Name: TABLE zones; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.zones IS 'Authoritative DNS zones';


--
-- Name: create_dns_zone(text, text, boolean, boolean, text, text, boolean); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_zone(input_zone text, input_keyname text, input_forward boolean, input_shared boolean, input_owner text, input_comment text, input_ddns boolean) RETURNS SETOF dns.zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Validate input
		IF api.validate_domain(NULL,input_zone) IS FALSE THEN
			RAISE EXCEPTION 'Invalid domain (%)',input_zone;
		END IF;

		-- Fill in owner
		IF input_owner IS NULL THEN
			input_owner = api.get_current_user();
		END IF;

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to create zone % denied for user %. Not admin.',input_zone,api.get_current_user();
		END IF;
		
		-- Create zone
		INSERT INTO "dns"."zones" ("zone","keyname","forward","comment","owner","shared","ddns") VALUES
		(input_zone,input_keyname,input_forward,input_comment,input_owner,input_shared,input_ddns);

		-- Done
		PERFORM api.syslog('create_dns_zone:"'||input_zone||'"');
		RETURN QUERY (SELECT * FROM "dns"."zones" WHERE "zone" = input_zone);
	END;
$$;


ALTER FUNCTION api.create_dns_zone(input_zone text, input_keyname text, input_forward boolean, input_shared boolean, input_owner text, input_comment text, input_ddns boolean) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_zone(input_zone text, input_keyname text, input_forward boolean, input_shared boolean, input_owner text, input_comment text, input_ddns boolean); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_zone(input_zone text, input_keyname text, input_forward boolean, input_shared boolean, input_owner text, input_comment text, input_ddns boolean) IS 'Create a new DNS zone';


--
-- Name: zone_a; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.zone_a (
    hostname text,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    type text NOT NULL,
    address inet NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    CONSTRAINT dns_zone_a_type_check CHECK ((type ~ '^A|AAAA$'::text))
);


ALTER TABLE dns.zone_a OWNER TO starrs;

--
-- Name: TABLE zone_a; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.zone_a IS 'Zone address records';


--
-- Name: create_dns_zone_a(text, inet, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_zone_a(input_zone text, input_address inet, input_ttl integer) RETURNS SETOF dns.zone_a
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Check dynamic
		IF input_address << api.get_site_configuration('DYNAMIC_SUBNET')::cidr THEN
			RAISE EXCEPTION 'Zone A cannot be dynamic';
		END IF;

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'DNS zone % is not shared and you are not owner. Permission denied.',input_zone;
			END IF;
		END IF;

		-- Create record
		INSERT INTO "dns"."zone_a" ("zone","address","ttl") VALUES 
		(input_zone,input_address,input_ttl);

		-- Done
		PERFORM api.syslog('create_dns_zone_a:"'||input_zone||'","'||input_address||'"');
		RETURN QUERY (SELECT * FROM "dns"."zone_a" WHERE "zone" = input_zone AND "address" = input_address);
	END;
$$;


ALTER FUNCTION api.create_dns_zone_a(input_zone text, input_address inet, input_ttl integer) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_zone_a(input_zone text, input_address inet, input_ttl integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_zone_a(input_zone text, input_address inet, input_ttl integer) IS 'create a new zone A or AAAA record';


--
-- Name: zone_txt; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.zone_txt (
    text text NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    hostname character varying(63),
    type text DEFAULT 'TXT'::text NOT NULL,
    ttl integer DEFAULT (api.get_site_configuration('DNS_DEFAULT_TTL'::text))::integer NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text) NOT NULL,
    address inet DEFAULT '0.0.0.0'::inet
);


ALTER TABLE dns.zone_txt OWNER TO starrs;

--
-- Name: TABLE zone_txt; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.zone_txt IS 'TXT records for zones';


--
-- Name: create_dns_zone_txt(text, text, text, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_dns_zone_txt(input_hostname text, input_zone text, input_text text, input_ttl integer) RETURNS SETOF dns.zone_txt
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Set zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Fill TTL
		IF input_ttl IS NULL THEN
			input_ttl := api.get_site_configuration('DNS_DEFAULT_TTL');
		END IF;

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on zone %. You are not owner.',input_zone;
			END IF;
		END IF;

		-- Lower
		input_hostname := lower(input_hostname);

		-- Create record
		INSERT INTO "dns"."zone_txt" ("hostname","zone","text","ttl") VALUES
		(input_hostname,input_zone,input_text,input_ttl);
		
		-- Update TTLs for other null hostname records since they all need to be the same.
		IF input_hostname IS NULL THEN
			UPDATE "dns"."zone_txt" SET "ttl" = input_ttl WHERE "hostname" IS NULL AND "zone" = input_zone;
		END IF;
		
		-- Done
		IF input_hostname IS NULL THEN
			PERFORM api.syslog('create_dns_zone_txt:"'||input_zone||'","'||input_text||'","'||input_ttl);
			RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" IS NULL AND "zone" = input_zone AND "text" = input_text);
		ELSE
			PERFORM api.syslog('create_dns_zone_txt:"'||input_hostname||'","'||input_zone||'","'||input_text||'","'||input_ttl);
			RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" = input_hostname AND "zone" = input_zone AND "text" = input_text);
		END IF;
	END;
$$;


ALTER FUNCTION api.create_dns_zone_txt(input_hostname text, input_zone text, input_text text, input_ttl integer) OWNER TO starrs;

--
-- Name: FUNCTION create_dns_zone_txt(input_hostname text, input_zone text, input_text text, input_ttl integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_dns_zone_txt(input_hostname text, input_zone text, input_text text, input_ttl integer) IS 'create a new dns zone_txt record for a host';


--
-- Name: groups; Type: TABLE; Schema: management; Owner: starrs
--

CREATE TABLE management.groups (
    "group" text NOT NULL,
    comment text,
    privilege text DEFAULT 'USER'::text NOT NULL,
    renew_interval interval DEFAULT (api.get_site_configuration('DEFAULT_RENEW_INTERVAL'::text))::interval NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    CONSTRAINT management_group_privilege_check CHECK ((privilege ~* '^ADMIN|USER|PROGRAM$'::text))
);


ALTER TABLE management.groups OWNER TO starrs;

--
-- Name: TABLE groups; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON TABLE management.groups IS 'Groups of users with different privilege levels';


--
-- Name: create_group(text, text, text, interval); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_group(input_group text, input_privilege text, input_comment text, input_interval interval) RETURNS SETOF management.groups
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can create groups.';
		END IF;

		IF input_interval IS NULL THEN
			input_interval := api.get_site_configuration('DEFAULT_RENEW_INTERVAL');
		END IF;

		INSERT INTO "management"."groups" ("group","privilege","comment","renew_interval") 
		VALUES (input_group, input_privilege, input_comment, input_interval);

		PERFORM api.syslog('create_group:"'||input_group||'","'||input_privilege||'","'||input_interval||'"');
		RETURN QUERY (SELECT * FROM "management"."groups" WHERE "group" = input_group);
	END;
$$;


ALTER FUNCTION api.create_group(input_group text, input_privilege text, input_comment text, input_interval interval) OWNER TO starrs;

--
-- Name: FUNCTION create_group(input_group text, input_privilege text, input_comment text, input_interval interval); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_group(input_group text, input_privilege text, input_comment text, input_interval interval) IS 'Create a user group';


--
-- Name: group_members; Type: TABLE; Schema: management; Owner: starrs
--

CREATE TABLE management.group_members (
    "group" text NOT NULL,
    "user" text NOT NULL,
    privilege text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    CONSTRAINT management_group_member_privilege_check CHECK ((privilege ~* '^ADMIN|USER|PROGRAM$'::text))
);


ALTER TABLE management.group_members OWNER TO starrs;

--
-- Name: TABLE group_members; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON TABLE management.group_members IS 'Map usernames to groups';


--
-- Name: create_group_member(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_group_member(input_group text, input_user text, input_privilege text) RETURNS SETOF management.group_members
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF api.get_current_user() NOT IN (SELECT * FROM api.get_group_admins(input_group)) THEN
				RAISE EXCEPTION 'Permission denied. Only admins can create groups.';
			END IF;
		END IF;

		INSERT INTO "management"."group_members" ("group","user","privilege") 
		VALUES (input_group, input_user, input_privilege);
	
		PERFORM api.syslog('create_group_member:"'||input_group||'","'||input_user||'","'||input_privilege||'"');
		RETURN QUERY (SELECT * FROM "management"."group_members" WHERE "group" = input_group AND "user" = input_user);
	END;
$$;


ALTER FUNCTION api.create_group_member(input_group text, input_user text, input_privilege text) OWNER TO starrs;

--
-- Name: FUNCTION create_group_member(input_group text, input_user text, input_privilege text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_group_member(input_group text, input_user text, input_privilege text) IS 'Assign a user to a group';


--
-- Name: group_settings; Type: TABLE; Schema: management; Owner: starrs
--

CREATE TABLE management.group_settings (
    "group" text NOT NULL,
    privilege text DEFAULT 'USER'::text NOT NULL,
    provider text NOT NULL,
    hostname text,
    id text,
    username text,
    password text,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE management.group_settings OWNER TO starrs;

--
-- Name: TABLE group_settings; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON TABLE management.group_settings IS 'Authentication and provider settings for groups';


--
-- Name: create_group_settings(text, text, text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_group_settings(input_group text, input_provider text, input_id text, input_hostname text, input_username text, input_password text, input_privilege text) RETURNS SETOF management.group_settings
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can create group provider settings';
		END IF;

		-- Check provider
		IF input_provider !~* 'local|vcloud|ldap|ad' THEN
			RAISE EXCEPTION 'Invalid provider given: %',input_provider;
		END IF;

		-- NULLs
		IF input_provider ~* 'vcloud|ldap|ad' THEN
			IF input_hostname IS NULL THEN
				RAISE EXCEPTION 'Need to give a hostname.';
			END IF;
			IF input_id IS NULL THEN
				RAISE EXCEPTION 'Need to give an ID.';
			END IF;
			IF input_username IS NULL THEN
				RAISE EXCEPTION 'Need to give a username.';
			END IF;
			if input_password IS NULL THEN
				RAISE EXCEPTION 'Need to give a password.';
			END IF;
		END IF;

		-- Check privilege level
		IF input_privilege!~* 'USER|ADMIN' THEN
			RAISE EXCEPTION 'Invalid privilege given: %',input_privilege;
		END IF;

		INSERT INTO "management"."group_settings" ("group","provider","id","hostname","username","password","privilege")
		VALUES (input_group, input_provider, input_id,input_hostname, input_username, input_password, input_privilege);

		--PERFORM api.syslog('create_group_settings:"'||input_group||'","'||input_provider||'","'||input_id||'","'||input_hostname||'","'||input_username||'","'||input_privilege||'"');
		RETURN QUERY (SELECT * FROM "management"."group_settings" WHERE "group" = input_group);

	END;
$$;


ALTER FUNCTION api.create_group_settings(input_group text, input_provider text, input_id text, input_hostname text, input_username text, input_password text, input_privilege text) OWNER TO starrs;

--
-- Name: FUNCTION create_group_settings(input_group text, input_provider text, input_id text, input_hostname text, input_username text, input_password text, input_privilege text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_group_settings(input_group text, input_provider text, input_id text, input_hostname text, input_username text, input_password text, input_privilege text) IS 'Create authentication settings';


--
-- Name: interfaces; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.interfaces (
    mac macaddr NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    system_name text,
    name text NOT NULL
);


ALTER TABLE systems.interfaces OWNER TO starrs;

--
-- Name: TABLE interfaces; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.interfaces IS 'Systems have interfaces that connect to the network. This corresponds to your physical hardware.';


--
-- Name: create_interface(text, macaddr, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_interface(input_system_name text, input_mac macaddr, input_name text, input_comment text) RETURNS SETOF systems.interfaces
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system_name) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on system %. You are not owner.',input_system_name;
			END IF;
		END IF;
		
		-- Validate input
		input_name := api.validate_name(input_name);

		-- Create interface
		INSERT INTO "systems"."interfaces"
		("system_name","mac","comment","last_modifier","name") VALUES
		(input_system_name,input_mac,input_comment,api.get_current_user(),input_name);

		-- Done
		PERFORM api.syslog('create_interface:"'||input_mac||'"');
		RETURN QUERY (SELECT * FROM "systems"."interfaces" WHERE "mac" = input_mac);
	END;
$$;


ALTER FUNCTION api.create_interface(input_system_name text, input_mac macaddr, input_name text, input_comment text) OWNER TO starrs;

--
-- Name: FUNCTION create_interface(input_system_name text, input_mac macaddr, input_name text, input_comment text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_interface(input_system_name text, input_mac macaddr, input_name text, input_comment text) IS 'Create a new interface on a system';


--
-- Name: interface_addresses; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.interface_addresses (
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    comment text,
    address inet NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    config text NOT NULL,
    family integer NOT NULL,
    isprimary boolean NOT NULL,
    renew_date date DEFAULT date((('now'::text)::date + (api.get_site_configuration('DEFAULT_RENEW_INTERVAL'::text))::interval)) NOT NULL,
    mac macaddr NOT NULL,
    class text NOT NULL
);


ALTER TABLE systems.interface_addresses OWNER TO starrs;

--
-- Name: TABLE interface_addresses; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.interface_addresses IS 'Interfaces are assigned IP addresses based on certain rules. If DHCP is being used, then a class may be specified.';


--
-- Name: create_interface_address(macaddr, inet, text, text, boolean, text, date); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_interface_address(input_mac macaddr, input_address inet, input_config text, input_class text, input_isprimary boolean, input_comment text, input_renew_date date) RETURNS SETOF systems.interface_addresses
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Renew
		IF input_renew_date IS NULL THEN
			input_renew_date := api.get_default_renew_date((SELECT "system_name" FROM "systems"."interfaces" WHERE "mac" = input_mac));
		END IF;

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."interfaces" 
			JOIN "systems"."systems" ON "systems"."systems"."system_name" = "systems"."interfaces"."system_name"
			WHERE "systems"."interfaces"."mac" = input_mac) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on interface %. You are not owner.',input_mac;
			END IF;

			IF input_renew_date != api.get_default_renew_date((SELECT "system_name" FROM "systems"."interfaces" WHERE "mac" = input_mac)) THEN
				RAISE EXCEPTION 'Only administrators can specify a different renew date';
			END IF;
		END IF;

		-- Fill in class
		IF input_class IS NULL THEN
			input_class = api.get_site_configuration('DHCPD_DEFAULT_CLASS');
		END IF;

		IF input_address << cidr(api.get_site_configuration('DYNAMIC_SUBNET')) AND input_config !~* 'dhcp' THEN
			RAISE EXCEPTION 'Specifified address (%) is only for dynamic DHCP addresses',input_address;
		END IF;

		IF (SELECT "use" FROM "api"."get_ip_ranges"() WHERE "name" = (SELECT "api"."get_address_range"(input_address))) ~* 'ROAM' THEN
			RAISE EXCEPTION 'Specified address (%) is contained within a Dynamic range',input_address;
		END IF;

		-- Create address
		INSERT INTO "systems"."interface_addresses" ("mac","address","config","class","comment","last_modifier","isprimary","renew_date") VALUES
		(input_mac,input_address,input_config,input_class,input_comment,api.get_current_user(),input_isprimary,input_renew_date);

		-- Done
		PERFORM api.syslog('create_interface_address:"'||input_address||'"');
		RETURN QUERY (SELECT * FROM "systems"."interface_addresses" WHERE "address" = input_address);
	END;
$$;


ALTER FUNCTION api.create_interface_address(input_mac macaddr, input_address inet, input_config text, input_class text, input_isprimary boolean, input_comment text, input_renew_date date) OWNER TO starrs;

--
-- Name: FUNCTION create_interface_address(input_mac macaddr, input_address inet, input_config text, input_class text, input_isprimary boolean, input_comment text, input_renew_date date); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_interface_address(input_mac macaddr, input_address inet, input_config text, input_class text, input_isprimary boolean, input_comment text, input_renew_date date) IS 'create a new address on interface from a specified address';


--
-- Name: ranges; Type: TABLE; Schema: ip; Owner: starrs
--

CREATE TABLE ip.ranges (
    first_ip inet NOT NULL,
    last_ip inet NOT NULL,
    comment text,
    use character varying(4) NOT NULL,
    datacenter text DEFAULT api.get_site_configuration('DEFAULT_DATACENTER'::text) NOT NULL,
    zone text NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    name text NOT NULL,
    subnet cidr,
    class text
);


ALTER TABLE ip.ranges OWNER TO starrs;

--
-- Name: TABLE ranges; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON TABLE ip.ranges IS 'Ranges of addresses can be reserved for specific purposes (Autoreg, Dynamics, etc)';


--
-- Name: create_ip_range(text, inet, inet, cidr, character varying, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_ip_range(input_name text, input_first_ip inet, input_last_ip inet, input_subnet cidr, input_use character varying, input_class text, input_comment text, input_datacenter text, input_zone text) RETURNS SETOF ip.ranges
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "ip"."subnets" WHERE "subnet" = input_subnet) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on subnet %. You are not owner',input_subnet;
			END IF;
		END IF;

		-- Validate input
		input_name := api.validate_name(input_name);

		-- Match subnet datacenter
		IF (SELECT "datacenter" FROM "ip"."subnets" WHERE "subnet" = input_subnet) != input_datacenter THEN
			RAISE EXCEPTION 'Subnet/Datacenter mismatch';
		END IF;

		-- Create new IP range		
		INSERT INTO "ip"."ranges" ("name", "first_ip", "last_ip", "subnet", "use", "comment", "class", "datacenter", "zone") VALUES 
		(input_name,input_first_ip,input_last_ip,input_subnet,input_use,input_comment,input_class,input_datacenter,input_zone);

		-- Done
		PERFORM api.syslog('create_ip_range:"'||input_name||'"');
		RETURN QUERY (SELECT * FROM "ip"."ranges" WHERE "name" = input_name);
	END;
$$;


ALTER FUNCTION api.create_ip_range(input_name text, input_first_ip inet, input_last_ip inet, input_subnet cidr, input_use character varying, input_class text, input_comment text, input_datacenter text, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION create_ip_range(input_name text, input_first_ip inet, input_last_ip inet, input_subnet cidr, input_use character varying, input_class text, input_comment text, input_datacenter text, input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_ip_range(input_name text, input_first_ip inet, input_last_ip inet, input_subnet cidr, input_use character varying, input_class text, input_comment text, input_datacenter text, input_zone text) IS 'Create a new range of IP addresses';


--
-- Name: subnets; Type: TABLE; Schema: ip; Owner: starrs
--

CREATE TABLE ip.subnets (
    subnet cidr NOT NULL,
    comment text,
    autogen boolean DEFAULT true NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    name text NOT NULL,
    owner text NOT NULL,
    zone text DEFAULT api.get_site_configuration('DNS_DEFAULT_ZONE'::text),
    dhcp_enable boolean DEFAULT false NOT NULL,
    datacenter text DEFAULT api.get_site_configuration('DEFAULT_DATACENTER'::text) NOT NULL,
    vlan integer NOT NULL
);


ALTER TABLE ip.subnets OWNER TO starrs;

--
-- Name: TABLE subnets; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON TABLE ip.subnets IS 'Subnets for which this application has control';


--
-- Name: create_ip_subnet(cidr, text, text, boolean, boolean, text, text, text, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_ip_subnet(input_subnet cidr, input_name text, input_comment text, input_autogen boolean, input_dhcp boolean, input_zone text, input_owner text, input_datacenter text, input_vlan integer) RETURNS SETOF ip.subnets
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Validate input
		input_name := api.validate_name(input_name);

		-- Fill in owner
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Fill in zone
		IF input_zone IS NULL THEN
			input_zone := api.get_site_configuration('DNS_DEFAULT_ZONE');
		END IF;
		
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF input_dhcp IS TRUE THEN
				RAISE EXCEPTION 'Permission to create DHCP-enabled subnet % denied for user %',input_subnet,api.get_current_user();
			END IF;
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Create new subnet
		INSERT INTO "ip"."subnets" 
			("subnet","name","comment","autogen","owner","dhcp_enable","zone","datacenter","vlan") VALUES
			(input_subnet,input_name,input_comment,input_autogen,input_owner,input_dhcp,input_zone,input_datacenter,input_vlan);

		-- Create RDNS zone
		PERFORM api.create_dns_zone(api.get_reverse_domain(input_subnet),(SELECT "keyname" FROM "dns"."zones" WHERE "zone" = input_zone),FALSE,TRUE,input_owner,'Reverse zone for subnet '||text(input_subnet),(SELECT "ddns" FROM "dns"."zones" WHERE "zone" = input_zone));

		-- Done
		PERFORM api.syslog('create_ip_subnet:"'||input_subnet||'"');
		RETURN QUERY (SELECT * FROM "ip"."subnets" WHERE "subnet" = input_subnet);
	END;
$$;


ALTER FUNCTION api.create_ip_subnet(input_subnet cidr, input_name text, input_comment text, input_autogen boolean, input_dhcp boolean, input_zone text, input_owner text, input_datacenter text, input_vlan integer) OWNER TO starrs;

--
-- Name: FUNCTION create_ip_subnet(input_subnet cidr, input_name text, input_comment text, input_autogen boolean, input_dhcp boolean, input_zone text, input_owner text, input_datacenter text, input_vlan integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_ip_subnet(input_subnet cidr, input_name text, input_comment text, input_autogen boolean, input_dhcp boolean, input_zone text, input_owner text, input_datacenter text, input_vlan integer) IS 'Create/activate a new subnet';


--
-- Name: hosts; Type: TABLE; Schema: libvirt; Owner: starrs
--

CREATE TABLE libvirt.hosts (
    system_name text NOT NULL,
    uri text NOT NULL,
    password text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE libvirt.hosts OWNER TO starrs;

--
-- Name: TABLE hosts; Type: COMMENT; Schema: libvirt; Owner: starrs
--

COMMENT ON TABLE libvirt.hosts IS 'VM hosts';


--
-- Name: create_libvirt_host(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_libvirt_host(input_system text, input_uri text, input_password text) RETURNS SETOF libvirt.hosts
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Only admins can create VM hosts';
		END IF;
		
		IF (SELECT "type" FROM "systems"."systems" WHERE "system_name" = input_system) != 'VM Host' THEN
			RAISE EXCEPTION 'System type mismatch. You need a VM Host.';
		END IF;
		
		INSERT INTO "libvirt"."hosts" ("system_name","uri","password") 
		VALUES (input_system, input_uri, input_password);
		
		RETURN QUERY (SELECT * FROM "libvirt"."hosts" WHERE "system_name" = input_system);
	END;
$$;


ALTER FUNCTION api.create_libvirt_host(input_system text, input_uri text, input_password text) OWNER TO starrs;

--
-- Name: FUNCTION create_libvirt_host(input_system text, input_uri text, input_password text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_libvirt_host(input_system text, input_uri text, input_password text) IS 'Create libvirt connection settings for a system';


--
-- Name: platforms; Type: TABLE; Schema: libvirt; Owner: starrs
--

CREATE TABLE libvirt.platforms (
    platform_name text NOT NULL,
    definition text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE libvirt.platforms OWNER TO starrs;

--
-- Name: TABLE platforms; Type: COMMENT; Schema: libvirt; Owner: starrs
--

COMMENT ON TABLE libvirt.platforms IS 'Libvirt definitions for VM platforms';


--
-- Name: create_libvirt_platform(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_libvirt_platform(input_name text, input_definition text) RETURNS SETOF libvirt.platforms
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied: Not admin!';
		END IF;

		INSERT INTO "libvirt"."platforms" ("platform_name","definition") VALUES (input_name, input_definition);
		
		RETURN QUERY (SELECT * FROM "libvirt"."platforms" WHERE "platform_name" = input_name);
	END;
$$;


ALTER FUNCTION api.create_libvirt_platform(input_name text, input_definition text) OWNER TO starrs;

--
-- Name: FUNCTION create_libvirt_platform(input_name text, input_definition text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_libvirt_platform(input_name text, input_definition text) IS 'Store a definition of a libvirt platform';


--
-- Name: snmp; Type: TABLE; Schema: network; Owner: starrs
--

CREATE TABLE network.snmp (
    system_name text NOT NULL,
    address inet NOT NULL,
    ro_community text,
    rw_community text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE network.snmp OWNER TO starrs;

--
-- Name: TABLE snmp; Type: COMMENT; Schema: network; Owner: starrs
--

COMMENT ON TABLE network.snmp IS 'SNMP community settings for network systems';


--
-- Name: create_network_snmp(text, inet, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_network_snmp(input_system text, input_address inet, input_ro text, input_rw text) RETURNS SETOF network.snmp
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Address
		IF input_address IS NULL THEN
			input_address := api.get_system_primary_address(input_system);
		END IF;
		
		-- Match address against system
		IF(api.get_interface_address_system(input_address) != input_system) THEN
			RAISE EXCEPTION 'Address % is not a part of the system %',input_address,input_system;
		END IF;

	  	-- Don't allow dynamic IPs
		IF input_address << api.get_site_configuration('DYNAMIC_SUBNET')::cidr THEN
			RAISE EXCEPTION 'System address cannot be dynamic';
	 	END IF;

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied: you are not owner';
			END IF;
		END IF;
		
		-- Create it
		INSERT INTO "network"."snmp" ("system_name","address","ro_community","rw_community") 
		VALUES (input_system, input_address, input_ro, input_rw);
		
		-- Done
		PERFORM api.syslog('create_network_snmp:"'||input_system||'"');
		RETURN QUERY (SELECT * FROM "network"."snmp" WHERE "system_name" = input_system);
	END;
$$;


ALTER FUNCTION api.create_network_snmp(input_system text, input_address inet, input_ro text, input_rw text) OWNER TO starrs;

--
-- Name: FUNCTION create_network_snmp(input_system text, input_address inet, input_ro text, input_rw text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_network_snmp(input_system text, input_address inet, input_ro text, input_rw text) IS 'Create a set of credentials for a system';


--
-- Name: platforms; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.platforms (
    platform_name text NOT NULL,
    architecture text NOT NULL,
    disk text NOT NULL,
    cpu text NOT NULL,
    memory integer NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE systems.platforms OWNER TO starrs;

--
-- Name: TABLE platforms; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.platforms IS 'Platform templates of a system';


--
-- Name: create_platform(text, text, text, text, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_platform(input_name text, input_architecture text, input_disk text, input_cpu text, input_memory integer) RETURNS SETOF systems.platforms
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied to create platform: not admin';
		END IF;

		INSERT INTO "systems"."platforms" ("platform_name","architecture","disk","cpu","memory")
		VALUES (input_name, input_architecture, input_disk, input_cpu, input_memory);

		PERFORM api.syslog('create_platform:"'||input_name||'"');
		RETURN QUERY (SELECT * FROM "systems"."platforms" WHERE "platform_name" = input_name);
	END;
$$;


ALTER FUNCTION api.create_platform(input_name text, input_architecture text, input_disk text, input_cpu text, input_memory integer) OWNER TO starrs;

--
-- Name: FUNCTION create_platform(input_name text, input_architecture text, input_disk text, input_cpu text, input_memory integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_platform(input_name text, input_architecture text, input_disk text, input_cpu text, input_memory integer) IS 'Create a new hardware platform';


--
-- Name: range_groups; Type: TABLE; Schema: ip; Owner: starrs
--

CREATE TABLE ip.range_groups (
    range_name text NOT NULL,
    group_name text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE ip.range_groups OWNER TO starrs;

--
-- Name: TABLE range_groups; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON TABLE ip.range_groups IS 'Associate ranges to groups of users';


--
-- Name: create_range_group(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_range_group(input_range text, input_group text) RETURNS SETOF ip.range_groups
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Only admins can assign range resources to groups';
		END IF;

		-- Create
		INSERT INTO "ip"."range_groups" ("range_name","group_name") VALUES (input_range, input_group);

		-- Return
		PERFORM api.syslog('create_range_group:"'||input_range||'","'||input_group||'"');
		RETURN QUERY (SELECT * FROM "ip"."range_groups" WHERE "group_name" = input_group AND "range_name" = input_range); 
	END;
$$;


ALTER FUNCTION api.create_range_group(input_range text, input_group text) OWNER TO starrs;

--
-- Name: FUNCTION create_range_group(input_range text, input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_range_group(input_range text, input_group text) IS 'Assign a range to a group';


--
-- Name: configuration; Type: TABLE; Schema: management; Owner: starrs
--

CREATE TABLE management.configuration (
    option text NOT NULL,
    value text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE management.configuration OWNER TO starrs;

--
-- Name: TABLE configuration; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON TABLE management.configuration IS 'Site specific configuration directives';


--
-- Name: create_site_configuration(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_site_configuration(input_directive text, input_value text) RETURNS SETOF management.configuration
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can create site directives';
		END IF;

		-- Create directive
		INSERT INTO "management"."configuration" VALUES (input_directive, input_value);

		-- Done
		PERFORM api.syslog('create_site_configuration:"'||input_directive||'","'||input_value||'"');
		RETURN QUERY (SELECT * FROM "management"."configuration" WHERE "option" = input_directive AND "value" = input_value);
	END;
$$;


ALTER FUNCTION api.create_site_configuration(input_directive text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION create_site_configuration(input_directive text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_site_configuration(input_directive text, input_value text) IS 'Create a new site configuration directive';


--
-- Name: systems; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.systems (
    system_name text NOT NULL,
    owner text NOT NULL,
    "group" text DEFAULT api.get_site_configuration('DEFAULT_LOCAL_USER_GROUP'::text) NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    type text,
    os_name text,
    last_modifier text NOT NULL,
    platform_name text NOT NULL,
    asset text,
    datacenter text DEFAULT api.get_site_configuration('DEFAULT_DATACENTER'::text) NOT NULL,
    location text
);


ALTER TABLE systems.systems OWNER TO starrs;

--
-- Name: TABLE systems; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.systems IS 'Systems are devices that connect to the network.';


--
-- Name: create_system(text, text, text, text, text, text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_system(input_system_name text, input_owner text, input_type text, input_os_name text, input_comment text, input_group text, input_platform text, input_asset text, input_datacenter text, input_location text) RETURNS SETOF systems.systems
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Validate input
		input_system_name := api.validate_name(input_system_name);

		-- Fill in username
		IF input_owner IS NULL THEN
			input_owner := api.get_current_user();
		END IF;

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF input_owner != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_owner;
			END IF;
		END IF;

		-- Insert new system
		INSERT INTO "systems"."systems"
			("system_name","owner","type","os_name","comment","last_modifier","group","platform_name","asset","datacenter","location") VALUES
			(input_system_name,input_owner,input_type,input_os_name,input_comment,api.get_current_user(),input_group,input_platform,input_asset,input_datacenter,input_location);

		-- Done
		PERFORM api.syslog('create_system:"'||input_system_name||'"');
		RETURN QUERY (SELECT * FROM "systems"."systems" WHERE "system_name" = input_system_name);
	END;
$$;


ALTER FUNCTION api.create_system(input_system_name text, input_owner text, input_type text, input_os_name text, input_comment text, input_group text, input_platform text, input_asset text, input_datacenter text, input_location text) OWNER TO starrs;

--
-- Name: FUNCTION create_system(input_system_name text, input_owner text, input_type text, input_os_name text, input_comment text, input_group text, input_platform text, input_asset text, input_datacenter text, input_location text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_system(input_system_name text, input_owner text, input_type text, input_os_name text, input_comment text, input_group text, input_platform text, input_asset text, input_datacenter text, input_location text) IS 'Create a new system';


--
-- Name: create_system_quick(text, text, text, macaddr, inet, text, text, boolean); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_system_quick(input_system_name text, input_owner text, input_group text, input_mac macaddr, input_address inet, input_zone text, input_config text, input_dns boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		PERFORM api.create_system(
			input_system_name,
			input_owner,
			api.get_site_configuration('DEFAULT_SYSTEM_TYPE'),
			'Other',
			null,
			input_group,
			api.get_site_configuration('DEFAULT_SYSTEM_PLATFORM'),
			null,
			api.get_site_configuration('DEFAULT_DATACENTER'),
            null
		);
		PERFORM api.create_interface(
			input_system_name,
			input_mac,
			api.get_site_configuration('DEFAULT_INTERFACE_NAME'),
			null
		);
		PERFORM api.create_interface_address(
			input_mac,
			input_address,
			input_config,
			api.get_site_configuration('DHCPD_DEFAULT_CLASS'),
			TRUE,
			null,
			null
		);
		IF input_dns IS TRUE THEN
			PERFORM api.create_dns_address(
				input_address,
				lower(regexp_replace(input_system_name,' ','-')),
				input_zone,
				null,
				null,
				TRUE,
				input_owner
			);
		END IF;
	END;
$$;


ALTER FUNCTION api.create_system_quick(input_system_name text, input_owner text, input_group text, input_mac macaddr, input_address inet, input_zone text, input_config text, input_dns boolean) OWNER TO starrs;

--
-- Name: FUNCTION create_system_quick(input_system_name text, input_owner text, input_group text, input_mac macaddr, input_address inet, input_zone text, input_config text, input_dns boolean); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_system_quick(input_system_name text, input_owner text, input_group text, input_mac macaddr, input_address inet, input_zone text, input_config text, input_dns boolean) IS 'Create a full system in one call';


--
-- Name: vlans; Type: TABLE; Schema: network; Owner: starrs
--

CREATE TABLE network.vlans (
    datacenter text NOT NULL,
    vlan integer NOT NULL,
    name text NOT NULL,
    comment text,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE network.vlans OWNER TO starrs;

--
-- Name: TABLE vlans; Type: COMMENT; Schema: network; Owner: starrs
--

COMMENT ON TABLE network.vlans IS 'VLANs in the organization';


--
-- Name: create_vlan(text, integer, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.create_vlan(input_datacenter text, input_vlan integer, input_name text, input_comment text) RETURNS SETOF network.vlans
    LANGUAGE plpgsql
    AS $$
     BEGIN
          IF api.get_current_user_level() !~* 'ADMIN' THEN
               RAISE EXCEPTION 'Only admins can create VLANs';
          END IF;

          INSERT INTO "network"."vlans" ("datacenter","vlan","name","comment")
          VALUES (input_datacenter, input_vlan, input_name, input_comment);

		PERFORM api.syslog('create_vlan:"'||input_datacenter||'","'||input_vlan||'"');
          RETURN QUERY (SELECT * FROM "network"."vlans" WHERE "datacenter" = input_datacenter AND "vlan" = input_vlan);
     END;
$$;


ALTER FUNCTION api.create_vlan(input_datacenter text, input_vlan integer, input_name text, input_comment text) OWNER TO starrs;

--
-- Name: FUNCTION create_vlan(input_datacenter text, input_vlan integer, input_name text, input_comment text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.create_vlan(input_datacenter text, input_vlan integer, input_name text, input_comment text) IS 'Create a VLAN';


--
-- Name: deinitialize(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.deinitialize() RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		DROP TABLE IF EXISTS "user_privileges";
	END;
$$;


ALTER FUNCTION api.deinitialize() OWNER TO starrs;

--
-- Name: FUNCTION deinitialize(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.deinitialize() IS 'Reset user permissions to activate a new user';


--
-- Name: dns_clean_zone_a(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.dns_clean_zone_a(input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		AuditData RECORD;
		DnsKeyName TEXT;
		DnsKey TEXT;
		DnsServer INET;
		DnsRecord TEXT;
		ReturnCode TEXT;
		
	BEGIN
		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Non-admin users are not allowed to clean zones';
		END IF;
		
		SELECT "dns"."keys"."keyname","dns"."keys"."key","address" 
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."ns" 
			JOIN "dns"."zones" ON "dns"."ns"."zone" = "dns"."zones"."zone" 
			JOIN "dns"."keys" ON "dns"."zones"."keyname" = "dns"."keys"."keyname"
			WHERE "dns"."ns"."zone" = input_zone AND "dns"."ns"."nameserver" IN (SELECT "nameserver" FROM "dns"."soa" WHERE "dns"."soa"."zone" = input_zone);
			
		FOR AuditData IN (
			SELECT 
				"audit_data"."address",
				"audit_data"."type",
				"host" AS "bind-forward", 
				"dns"."a"."hostname"||'.'||"dns"."a"."zone" AS "impulse-forward"
			FROM api.dns_zone_audit(input_zone) AS "audit_data" 
			LEFT JOIN "dns"."a" ON "dns"."a"."address" = "audit_data"."address" 
			WHERE "audit_data"."type" ~* '^A|AAAA$'
			ORDER BY "audit_data"."address"
		) LOOP
			-- Delete the forward
			DnsRecord := AuditData."bind-forward";
			ReturnCode := api.nsupdate(input_zone,DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when deleting forward %',ReturnCode,DnsRecord;
			END IF;
			
			-- If it's static, create the correct one
			IF (SELECT "config" FROM "systems"."interface_addresses" WHERE "address" = AuditData."address") ~* 'static' AND AuditData."impulse-forward" IS NOT NULL THEN
				-- Forward
				DnsRecord := AuditData."impulse-forward"||' '||AuditData."ttl"||' '||AuditData."type"||' '||host(AuditData."address");
				ReturnCode := api.nsupdate(input_zone,DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
				IF ReturnCode != '0' THEN
					RAISE EXCEPTION 'DNS Error: % when creating forward %',ReturnCode,DnsRecord;
				END IF;
			END IF;
		END LOOP;
		
	END;
$_$;


ALTER FUNCTION api.dns_clean_zone_a(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION dns_clean_zone_a(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.dns_clean_zone_a(input_zone text) IS 'Erase all non-IMPULSE controlled A records from a zone.';


--
-- Name: dns_clean_zone_ptr(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.dns_clean_zone_ptr(input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		AuditData RECORD;
		DnsKeyName TEXT;
		DnsKey TEXT;
		DnsServer INET;
		DnsRecord TEXT;
		ReturnCode TEXT;
		
	BEGIN
		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Non-admin users are not allowed to clean zones';
		END IF;
		
		SELECT "dns"."keys"."keyname","dns"."keys"."key","dns"."ns"."address"
		INTO DnsKeyName, DnsKey, DnsServer
		FROM "dns"."ns"
		JOIN "dns"."zones" ON "dns"."ns"."zone" = "dns"."zones"."zone"
		JOIN "dns"."keys" ON "dns"."zones"."keyname" = "dns"."keys"."keyname"
		JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."ns"."zone"
		WHERE "dns"."ns"."nameserver" = "dns"."soa"."nameserver"
		AND "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = input_zone);
	
		FOR AuditData IN (
			SELECT 
			"audit_data"."host",
			"audit_data"."target" AS "bind-reverse",
			"dns"."a"."hostname"||'.'||"dns"."a"."zone" AS "impulse-reverse",
			"dns"."a"."ttl" AS "ttl",
			"audit_data"."type" AS "type"
			FROM api.dns_zone_audit(input_zone) AS "audit_data"
			LEFT JOIN "dns"."a" ON api.get_reverse_domain("dns"."a"."address") = "audit_data"."host"
			WHERE "audit_data"."type"='PTR'
		) LOOP
			DnsRecord := AuditData."host";
			ReturnCode := api.nsupdate(input_zone,DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when deleting reverse %',ReturnCode,DnsRecord;
			END IF;
			
			IF (SELECT "config" FROM "systems"."interface_addresses" WHERE api.get_reverse_domain("address") = AuditData."host") ~* 'static' AND AuditData."impulse-reverse" IS NOT NULL THEN
				DnsRecord := AuditData."host"||' '||AuditData."ttl"||' '||AuditData."type"||' '||AuditData."impulse-reverse";
				ReturnCode := api.nsupdate(input_zone,DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
				IF ReturnCode != '0' THEN
					RAISE EXCEPTION 'DNS Error: % when creating reverse %',ReturnCode,DnsRecord;
				END IF;
			END IF;
			
		END LOOP;
	END;
$$;


ALTER FUNCTION api.dns_clean_zone_ptr(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION dns_clean_zone_ptr(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.dns_clean_zone_ptr(input_zone text) IS 'Clean all incorrect pointer records in a reverse zone';


--
-- Name: dns_forward_lookup(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.dns_forward_lookup(text) RETURNS inet
    LANGUAGE plperlu
    AS $_X$
	use Socket;

	my $hostname = $_[0];
	#my $ipaddr = `host $hostname | cut -d ' ' -f 4`;
	$packed_ip = gethostbyname("$hostname");
	if (defined $packed_ip) {
		$ip_address = inet_ntoa($packed_ip);
	}
	return $ip_address;
$_X$;


ALTER FUNCTION api.dns_forward_lookup(text) OWNER TO postgres;

--
-- Name: dns_resolve(text, text, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.dns_resolve(input_hostname text, input_zone text, input_family integer) RETURNS inet
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_family IS NULL THEN
			RETURN (SELECT "address" FROM "dns"."a" WHERE "hostname" = input_hostname AND "zone" = input_zone LIMIT 1);
		ELSE
			RETURN (SELECT "address" FROM "dns"."a" WHERE "hostname" = input_hostname AND "zone" = input_zone AND family("address") = input_family);
		END IF;
	END;
$$;


ALTER FUNCTION api.dns_resolve(input_hostname text, input_zone text, input_family integer) OWNER TO starrs;

--
-- Name: FUNCTION dns_resolve(input_hostname text, input_zone text, input_family integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.dns_resolve(input_hostname text, input_zone text, input_family integer) IS 'Resolve a hostname/zone to its IP address';


--
-- Name: dns_zone_audit(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.dns_zone_audit(input_zone text) RETURNS SETOF dns.zone_audit_data
    LANGUAGE plpgsql
    AS $$
       BEGIN
			-- Create a temporary table to store record data in
            DROP TABLE IF EXISTS "audit";
            CREATE TEMPORARY TABLE "audit" (
			host TEXT, ttl INTEGER, type TEXT, address INET, port INTEGER, weight INTEGER, priority INTEGER, preference INTEGER, target TEXT, text TEXT, contact TEXT, serial TEXT, refresh INTEGER, retry INTEGER, expire INTEGER, minimum INTEGER);
				   
			-- Put AXFR data into the table
			IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = input_zone) IS TRUE THEN
				INSERT INTO "audit"
				(SELECT * FROM "api"."query_axfr"(input_zone, (SELECT "nameserver" FROM "dns"."soa" WHERE "zone" = input_zone)));
			ELSE
				INSERT INTO "audit" (SELECT * FROM "api"."query_axfr"(input_zone, (SELECT "nameserver" FROM "dns"."soa" WHERE "zone" = (SELECT "zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = input_zone))));
			END IF;
			
			-- Update the SOA table with the latest serial
			PERFORM api.modify_dns_soa(input_zone,'serial',(SELECT "api"."query_zone_serial"(input_zone)));
			
			IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = input_zone) IS TRUE THEN
				-- Remove all records that IMPULSE contains
				DELETE FROM "audit" WHERE ("host","ttl","type","address") IN (SELECT "hostname"||'.'||"zone" AS "host","ttl","type","address" FROM "dns"."a");
				DELETE FROM "audit" WHERE ("host","ttl","type","target","port","weight","priority") IN (SELECT "alias"||'.'||"zone" AS "host","ttl","type","hostname"||'.'||"zone" as "target","port","weight","priority" FROM "dns"."srv");
				DELETE FROM "audit" WHERE ("host","ttl","type","target") IN (SELECT "alias"||'.'||"zone" AS "host","ttl","type","hostname"||'.'||"zone" as "target" FROM "dns"."cname");
				DELETE FROM "audit" WHERE ("host","ttl","type","preference") IN (SELECT "hostname"||'.'||"zone" AS "host","ttl","type","preference" FROM "dns"."mx");
				DELETE FROM "audit" WHERE ("host","ttl","type") IN (SELECT "nameserver" AS "host","ttl","type" FROM "dns"."ns");
				DELETE FROM "audit" WHERE ("host","ttl","type","text") IN (SELECT "hostname"||'.'||"zone" AS "host","ttl","type","text" FROM "dns"."txt");
				DELETE FROM "audit" WHERE ("host","ttl","type","target","contact","serial","refresh","retry","expire","minimum") IN 
				(SELECT "zone" as "host","ttl",'SOA'::text as "type","nameserver" as "target","contact","serial","refresh","retry","expire","minimum" FROM "dns"."soa");
				DELETE FROM "audit" WHERE ("host","ttl","type","text") IN (SELECT "hostname"||'.'||"zone" AS "host","ttl","type","text" FROM "dns"."zone_txt");
				DELETE FROM "audit" WHERE ("host","ttl","type","text") IN (SELECT "zone" AS "host","ttl","type","text" FROM "dns"."zone_txt");
				DELETE FROM "audit" WHERE ("host","ttl","type","address") IN (SELECT "zone" AS "host","ttl","type","address" FROM "dns"."zone_a");
				
				-- DynamicDNS records have TXT data placed by the DHCP server. Don't count those.
				DELETE FROM "audit" WHERE ("host") IN (SELECT "hostname"||'.'||"zone" AS "host" FROM "api"."get_dhcpd_dynamic_hosts"() WHERE "hostname" IS NOT NULL) AND "type" = 'TXT';
				-- So do DHCP'd records;
				DELETE FROM "audit" WHERE ("host") IN (SELECT "hostname"||'.'||"zone" AS "host" FROM "dns"."a" JOIN "systems"."interface_addresses" ON "systems"."interface_addresses"."address" = "dns"."a"."address" WHERE "config"='dhcp') AND "type"='TXT';
			ELSE
				-- Remove constant address records
				DELETE FROM "audit" WHERE ("host","target","type") IN (SELECT api.get_reverse_domain("address") as "host","hostname"||'.'||"zone" as "target",'PTR'::text AS "type" FROM "dns"."a");
				-- Remove Dynamics
				DELETE FROM "audit" WHERE ("target","type") IN (SELECT "hostname"||'.'||"zone" as "target",'PTR'::text AS "type" FROM "dns"."a" JOIN "systems"."interface_addresses" ON "systems"."interface_addresses"."address" = "dns"."a"."address" WHERE "config"='dhcp');
				-- Remove NS records;
				DELETE FROM "audit" WHERE ("host","ttl","type") IN (SELECT "nameserver" AS "host","ttl","type" FROM "dns"."ns");
				-- Remove SOA;
				DELETE FROM "audit" WHERE ("host","ttl","type","target","contact","serial","refresh","retry","expire","minimum") IN 
				(SELECT "zone" as "host","ttl",'SOA'::text as "type","nameserver" as "target","contact","serial","refresh","retry","expire","minimum" FROM "dns"."soa" WHERE "zone" = input_zone);
				-- Remove TXT
				DELETE FROM "audit" WHERE ("host","ttl","type","text") IN (SELECT "hostname"||'.'||"zone" AS "host","ttl","type","text" FROM "dns"."zone_txt");
				DELETE FROM "audit" WHERE ("host","ttl","type","text") IN (SELECT "zone" AS "host","ttl","type","text" FROM "dns"."zone_txt");
			END IF;
            
			-- What's left is data that IMPULSE has no idea of
            RETURN QUERY (SELECT * FROM "audit");
       END;
$$;


ALTER FUNCTION api.dns_zone_audit(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION dns_zone_audit(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.dns_zone_audit(input_zone text) IS 'Perform an audit of IMPULSE zone data against server zone data';


--
-- Name: exec(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.exec(text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		EXECUTE $1;
	END;
$_$;


ALTER FUNCTION api.exec(text) OWNER TO starrs;

--
-- Name: FUNCTION exec(text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.exec(text) IS 'Execute a query in a plpgsql context';


--
-- Name: generate_dhcpd6_config(); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.generate_dhcpd6_config() RETURNS void
    LANGUAGE plperlu
    AS $_X$	# Script written by Anthony Gargiulo
	# Altered for IPv6 by Jordan Rodgers
	use warnings;
	no warnings 'redefine';

	# First things first. defining the subroutines that make up this script.

	# Global Options
	sub global_opts
	{
		my ($row, $option, $value, $output);
		my $global_options = spi_query("SELECT * FROM api.get_dhcpd_global_options()");
		while (defined($row = spi_fetchrow($global_options)))
		{
			$option = $row->{option};
			$value = $row->{value};
			$output .= "$option    $value;\n"
		}
		return $output;
	} # end global options

	# DNS keys added here
	sub dns_keys
	{
		my $keys = spi_query("SELECT * FROM api.get_dhcpd_dns_keys()");
		my ($keyname, $key, $enctype, $row, $output);
		while (defined ($row = spi_fetchrow($keys)))
		{
			$keyname = $row->{keyname};
			$key = $row->{key};
			$enctype = $row->{enctype};
			$output .= "key $keyname {\n  algorithm ${enctype};\n  secret \"$key\";\n}\n";
		}
		return $output;
	}# end DNS keys
	
	# Zones are added here.
	sub forward_zones
	{
		my $zones = spi_query("SELECT * FROM api.get_dhcpd_forward_zones()");
		my ($zone, $keyname, $primary_ns, $row, $output);
		$output = "";
		while (defined ($row = spi_fetchrow($zones)))
		{
			$zone = $row->{zone};
			$keyname = $row->{keyname};
			$primary_ns = $row->{primary_ns};
			$output .= "zone $zone {\n  primary ${primary_ns};\n  key ${keyname};\n}\n";
		}
		return $output;
	}# end forward zones

	# Zones are added here.
	sub reverse_zones
	{
		my $zones = spi_query("SELECT * FROM api.get_dhcpd6_reverse_zones()");
		my ($zone, $keyname, $primary_ns, $row, $output);
		$output = "";
		while (defined ($row = spi_fetchrow($zones)))
		{
			$zone = $row->{zone};
			$keyname = $row->{keyname};
			$primary_ns = $row->{primary_ns};
			$output .= "zone $zone {\n  primary ${primary_ns};\n  key ${keyname};\n}\n";
		}
		return $output;
	}# end reverse zones

	# DHCP Classes
	sub dhcp_classes
	{
		my $classes = spi_query("SELECT class,comment FROM api.get_dhcpd_classes()");
		my ($class, $comment, $row, $output);
		while (defined($row = spi_fetchrow($classes)))
		{
			$class = $row->{class};
			$comment = $row->{comment};
			$output .= "class \"$class\" {\n";
			$output .= "  # ${comment}\n" if(defined($comment));
			$output .= &dhcp_class_options($class);
			$output .= "}\n\n";
		}
		return $output;
	}# end &dhcp_classes

	# DHCP Class options
	sub dhcp_class_options
	{
		my $class = $_[0];
		my $options = spi_query("SELECT * FROM api.get_dhcpd_class_options('$class')");
		my ($option, $value, $row, $output);
		while (defined($row = spi_fetchrow($options)))
		{
			$option = $row->{option};
			$value = $row->{value};
			$output .= "    " . $option . ' ' . $value . ";\n";
		}
		return $output;
	}# end &dhcp_class_options

	# Shared networks
	sub shared_networks
	{
		my $networks = spi_query("SELECT get_dhcpd_shared_networks FROM api.get_dhcpd_shared_networks()");
		my ($network, $row, $output, $subnets);
		
		while (defined($row = spi_fetchrow($networks)))
		{
			$network = $row->{get_dhcpd_shared_networks};
			$subnets = &subnets($network);
			if ($subnets)
			{	
				$output .= "shared-network " . $network . " {\n\n";
				$output .= $subnets;
				$output .= "}\n\n";
			}
		}
		return $output;
	}
	
	# Subnets (for shared networks)
	sub subnets
	{
		my $shared_net = $_[0];
		# COHOE: THIS QUERY STRING IS QUITE VERBOSE, I HOPE YOU ARE HAPPY
		my $query = "select get_dhcpd_shared_network_subnets as subnets, netmask(get_dhcpd_shared_network_subnets) ";
		$query .= "from api.get_dhcpd_shared_network_subnets('$shared_net')";
		my $subnets = spi_query($query);
		
		# $subnet = ip + netmask in slash notation; i.e. 10.21.49.0/24
		# $net = only the network address; i.e. 10.21.49.0
		# $mask = netmask in dotted decimal notation; i.e. 255.255.255.0
		my ($subnet, $net, $mask, $row, $output);

		while (defined($row = spi_fetchrow($subnets)))
		{
			$subnet = $row->{subnets};
			# Dirty way to only do IPv6 subnets
			if (index($subnet, ':') != -1)
			{
				$net = substr($subnet, 0, index($subnet, "/"));
				$mask = $row->{netmask};
				$output .= "  subnet6 $subnet {\n  ";
				$output .= "  authoritative;";
				my $subnet_option = &subnet_options($subnet);
				if(defined($subnet_option))
				{
				   $output .= $subnet_option;
				}
				my $subnet_range = &subnet_ranges($subnet);
				if(defined($subnet_range))
				{
				   $output .= $subnet_range;
				}
				$output .= "\n  }\n\n";
			}
		}
		return $output;
	}
	
	# Subnet options
	sub subnet_options
	{
		my $subnet = $_[0];
		my $options = spi_query("SELECT option,value from api.get_dhcpd_subnet_options('$subnet')");
		my ($option, $value, $row, $output);
		while (defined($row = spi_fetchrow($options)))
		{
			$option = $row->{option};
			$value = $row->{value};
			$output .= "\n    $option $value;";
		}
		return $output;
	}
	
	# Subnet ranges
	sub subnet_ranges
	{
		my $subnet = $_[0];
		my $pool = spi_query("SELECT name,first_ip,last_ip,class from api.get_dhcpd_subnet_ranges('$subnet')");
		my ($range_name, $first_ip, $last_ip, $class, $row, $output);
		$output="";
		
		while (defined($row = spi_fetchrow($pool)))
		{
			$range_name = $row->{name};
			$first_ip = $row->{first_ip};
			$last_ip = $row->{last_ip};
			$class = $row->{class};
			$output .= "\n    pool {\n      range $first_ip $last_ip;\n      failover peer \"dhcpfailover\";";
			{
				my $range_options = spi_query("SELECT * from api.get_dhcpd_range_options('$range_name')");
				my ($option, $value, $row);
				while (defined($row = spi_fetchrow($range_options)))
				{
					$option = $row->{option};
					$value = $row->{value};
					$output .= "\n      $option $value;";
				}
			}
			if (defined($class))
			{
				$output .= "\n      allow members of \"$class\";";
			}
			else
			{
				$output .= "\n      allow unknown clients;";
			}
			$output .= "\n    }";
		}
		return $output;
	}

	# hosts
	sub hosts
	{
		my $static_hosts = spi_query("SELECT * FROM api.get_dhcpd6_static_hosts() order by owner,hostname");
		# Disable dynamic hosts
		#my $dynamic_hosts = spi_query("SELECT * FROM api.get_dhcpd_dynamic_hosts() order by owner,hostname");
		my ($hostname, $zone, $mac, $address, $owner, $class, $row, $output);
		$output .= "# Static hosts\n";
		while (defined($row = spi_fetchrow($static_hosts)))
		{
			$hostname = $row->{hostname};
			$zone = $row->{zone};
			$mac = $row->{mac};
			$address = $row->{address};
			$owner = $row->{owner};
			$class = $row->{class};
			
			# Dirty way to only do IPv6 hosts
			if (index($address, ':') != -1)
			{
				$output .= &host_config($hostname, $zone, $mac, $address, $owner, $class);
			}
		}
		# Disable dynamic hosts
		#$output .= "# Dynamic hosts\n";
		#while (defined($row = spi_fetchrow($dynamic_hosts)))
		#{
		#	$hostname = $row->{hostname};
		#	$zone = $row->{zone};
		#	$mac = $row->{mac};
		#	$owner = $row->{owner};
		#	$class = $row->{class};
		#	
		#	# Dirty way to only do IPv6 hosts
		#	if (index($address, ':') != -1)
		#	{
		#		$output .= &host_config($hostname, $zone, $mac, undef, $owner, $class);
		#	}
		#}
		return $output;
	}

	# hosts config generation
	sub host_config
	{
		my ($hostname, $zone, $mac, $address, $owner, $class) = @_;
		
		my $hostmac = $mac;
		$hostmac =~ s/://g;
		
		my $output .= "# $owner\n";
		if (defined($hostname) && defined($zone))
		{
			$output .= "host $hostname.$zone {\n";
		}else 
		{
			$output .= "host $hostmac {\n";
		}
		$output .= "  option dhcp-client-identifier 1:$mac;\n";
		$output .= "  hardware ethernet $mac;\n";
		$output .= "  fixed-address6 $address;\n" if (defined($address));
		$output .= "  option host-name \"$hostname\";\n" if (defined($hostname));
		$output .= "  ddns-hostname \"$hostname\";\n" if (defined($hostname));
		$output .= "  ddns-domainname \"$zone\";\n" if (defined($zone));
		$output .= "  option domain-name \"$zone\";\n" if (defined($zone));
		$output .= "}\n";
		$output .= "subclass \"$class\" 1:$mac;\n";
		$output .= "subclass \"$class\" $mac;\n\n";
		return $output;
	}


	# lets start with the DHCPd.conf header from the DB
	my $header = spi_exec_query("SELECT api.get_site_configuration('DHCPD6_HEADER')");
	my $output = $header->{rows}[0]->{get_site_configuration}. "\n\n"; 

	# add the date to the file
	my $date = spi_exec_query("SELECT localtimestamp(0)")->{rows}[0]->{timestamp};
	$output .= "\# Generated at $date\n\n";

	# now for the rest of the config file
	$output .= &global_opts() . "\n";
	$output .= &dns_keys() . "\n";
	$output .= &forward_zones() . "\n";
	$output .= &reverse_zones() . "\n";
	$output .= &dhcp_classes() . "\n";
	$output .= &shared_networks() . "\n";
	$output .= &hosts() . "\n";

	$output .= "\# End dhcpd6 configuration file";

	# finally, store the config in the db, so we can get it back later.
	spi_exec_query("INSERT INTO management.output (value,file,timestamp) VALUES (\$\$".$output."\$\$,'dhcpd6.conf',now())");

	#log our success with the api logging tool.
	spi_exec_query("SELECT api.syslog('successfully generated dhcpd6.conf')");
$_X$;


ALTER FUNCTION api.generate_dhcpd6_config() OWNER TO postgres;

--
-- Name: FUNCTION generate_dhcpd6_config(); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.generate_dhcpd6_config() IS 'Generate the config file for the dhcpd6 server, and store it in the db';


--
-- Name: generate_dhcpd_config(); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.generate_dhcpd_config() RETURNS void
    LANGUAGE plperlu
    AS $_X$	# Script written by Anthony Gargiulo
	use strict;
	use warnings;
	no warnings 'redefine';

	# First things first. defining the subroutines that make up this script.

	# Global Options
	sub global_opts
	{
		my ($row, $option, $value, $output);
		my $global_options = spi_query("SELECT * FROM api.get_dhcpd_global_options()");
		while (defined($row = spi_fetchrow($global_options)))
		{
			$option = $row->{option};
			$value = $row->{value};
			$output .= "$option    $value;\n"
		}
		return $output;
	} # end global options

	# DNS keys added here
	sub dns_keys
	{
		my $keys = spi_query("SELECT * FROM api.get_dhcpd_dns_keys()");
		my ($keyname, $key, $enctype, $row, $output);
		while (defined ($row = spi_fetchrow($keys)))
		{
			$keyname = $row->{keyname};
			$key = $row->{key};
			$enctype = $row->{enctype};
			$output .= "key $keyname {\n  algorithm ${enctype};\n  secret \"$key\";\n}\n";
		}
		return $output;
	}# end DNS keys
	
	# Zones are added here.
	sub forward_zones
	{
		my $zones = spi_query("SELECT * FROM api.get_dhcpd_forward_zones()");
		my ($zone, $keyname, $primary_ns, $row, $output);
		$output = "";
		while (defined ($row = spi_fetchrow($zones)))
		{
			$zone = $row->{zone};
			$keyname = $row->{keyname};
			$primary_ns = $row->{primary_ns};
			$output .= "zone $zone {\n  primary ${primary_ns};\n  key ${keyname};\n}\n";
		}
		return $output;
	}# end forward zones

	# Zones are added here.
	sub reverse_zones
	{
		my $zones = spi_query("SELECT * FROM api.get_dhcpd_reverse_zones()");
		my ($zone, $keyname, $primary_ns, $row, $output);
		$output = "";
		while (defined ($row = spi_fetchrow($zones)))
		{
			$zone = $row->{zone};
			$keyname = $row->{keyname};
			$primary_ns = $row->{primary_ns};
			$output .= "zone $zone {\n  primary ${primary_ns};\n  key ${keyname};\n}\n";
		}
		return $output;
	}# end reverse zones

	# DHCP Classes
	sub dhcp_classes
	{
		my $classes = spi_query("SELECT class,comment FROM api.get_dhcpd_classes()");
		my ($class, $comment, $row, $output);
		while (defined($row = spi_fetchrow($classes)))
		{
			$class = $row->{class};
			$comment = $row->{comment};
			$output .= "class \"$class\" {\n";
			$output .= "  # ${comment}\n" if(defined($comment));
			$output .= &dhcp_class_options($class);
			$output .= "}\n\n";
		}
		return $output;
	}# end &dhcp_classes

	# DHCP Class options
	sub dhcp_class_options
	{
		my $class = $_[0];
		my $options = spi_query("SELECT * FROM api.get_dhcpd_class_options('$class')");
		my ($option, $value, $row, $output);
		while (defined($row = spi_fetchrow($options)))
		{
			$option = $row->{option};
			$value = $row->{value};
			$output .= "    " . $option . ' ' . $value . ";\n";
		}
		return $output;
	}# end &dhcp_class_options

	# Shared networks
	sub shared_networks
	{
		my $networks = spi_query("SELECT get_dhcpd_shared_networks FROM api.get_dhcpd_shared_networks()");
		my ($network, $row, $output, $subnets);
		
		while (defined($row = spi_fetchrow($networks)))
		{
			$network = $row->{get_dhcpd_shared_networks};
			$subnets = &subnets($network);
			if ($subnets)
			{
				$output .= "shared-network " . $network . " {\n\n";
				$output .= $subnets;
				$output .= "}\n\n";
			}
		}
		return $output;
	}
	
	# Subnets (for shared networks)
	sub subnets
	{
		my $shared_net = $_[0];
		# COHOE: THIS QUERY STRING IS QUITE VERBOSE, I HOPE YOU ARE HAPPY
		my $query = "select get_dhcpd_shared_network_subnets as subnets, netmask(get_dhcpd_shared_network_subnets) ";
		$query .= "from api.get_dhcpd_shared_network_subnets('$shared_net')";
		my $subnets = spi_query($query);
		
		# $subnet = ip + netmask in slash notation; i.e. 10.21.49.0/24
		# $net = only the network address; i.e. 10.21.49.0
		# $mask = netmask in dotted decimal notation; i.e. 255.255.255.0
		my ($subnet, $net, $mask, $row, $output);
		
		while (defined($row = spi_fetchrow($subnets)))
		{
			$subnet = $row->{subnets};
			# Dirty way to only do IPv4 subnets ~Jordan
			if (index($subnet, ':') == -1)
			{
				$net = substr($subnet, 0, index($subnet, "/"));
				$mask = $row->{netmask};
				$output .= "  subnet $net netmask $mask {\n  ";
				$output .= "  authoritative;";
				my $subnet_option = &subnet_options($subnet);
				if(defined($subnet_option))
				{
				   $output .= $subnet_option;
				}
				my $subnet_range = &subnet_ranges($subnet);
				if(defined($subnet_range))
				{
				   $output .= $subnet_range;
				}
				$output .= "\n  }\n\n";
			}
		}
		return $output;
	}
	
	# Subnet options
	sub subnet_options
	{
		my $subnet = $_[0];
		my $options = spi_query("SELECT option,value from api.get_dhcpd_subnet_options('$subnet')");
		my ($option, $value, $row, $output);
		while (defined($row = spi_fetchrow($options)))
		{
			$option = $row->{option};
			$value = $row->{value};
			$output .= "\n    $option $value;";
		}
		return $output;
	}
	
	# Subnet ranges
	sub subnet_ranges
	{
		my $subnet = $_[0];
		my $pool = spi_query("SELECT name,first_ip,last_ip,class from api.get_dhcpd_subnet_ranges('$subnet')");
		my ($range_name, $first_ip, $last_ip, $class, $row, $output);
		$output="";
		
		while (defined($row = spi_fetchrow($pool)))
		{
			$range_name = $row->{name};
			$first_ip = $row->{first_ip};
			$last_ip = $row->{last_ip};
			$class = $row->{class};
			$output .= "\n    pool {\n      range $first_ip $last_ip;\n      failover peer \"dhcpfailover\";";
			{
				my $range_options = spi_query("SELECT * from api.get_dhcpd_range_options('$range_name')");
				my ($option, $value, $row);
				while (defined($row = spi_fetchrow($range_options)))
				{
					$option = $row->{option};
					$value = $row->{value};
					$output .= "\n      $option $value;";
				}
			}
			if (defined($class))
			{
				$output .= "\n      allow members of \"$class\";";
			}
			else
			{
				$output .= "\n      allow unknown clients;";
			}
			$output .= "\n    }";
		}
		return $output;
	}

	# hosts
	sub hosts
	{
		my $static_hosts = spi_query("SELECT * FROM api.get_dhcpd_static_hosts() order by owner,hostname");
		my $dynamic_hosts = spi_query("SELECT * FROM api.get_dhcpd_dynamic_hosts() order by owner,hostname");
		my ($hostname, $zone, $mac, $address, $owner, $class, $row, $output);
		$output .= "# Static hosts\n";
		while (defined($row = spi_fetchrow($static_hosts)))
		{
			$hostname = $row->{hostname};
			$zone = $row->{zone};
			$mac = $row->{mac};
			$address = $row->{address};
			$owner = $row->{owner};
			$class = $row->{class};
			
			$output .= &host_config($hostname, $zone, $mac, $address, $owner, $class);
		}
		$output .= "# Dynamic hosts\n";
		while (defined($row = spi_fetchrow($dynamic_hosts)))
		{
			$hostname = $row->{hostname};
			$zone = $row->{zone};
			$mac = $row->{mac};
			$owner = $row->{owner};
			$class = $row->{class};
			
			$output .= &host_config($hostname, $zone, $mac, undef, $owner, $class);
		}
		return $output;
	}

	# hosts config generation
	sub host_config
	{
		my ($hostname, $zone, $mac, $address, $owner, $class) = @_;
		
		my $hostmac = $mac;
		$hostmac =~ s/://g;
		
		my $output .= "# $owner\n";
		if (defined($hostname) && defined($zone))
		{
			$output .= "host $hostname.$zone {\n";
		}else 
		{
			$output .= "host $hostmac {\n";
		}
		$output .= "  option dhcp-client-identifier 1:$mac;\n";
		$output .= "  hardware ethernet $mac;\n";
		$output .= "  fixed-address $address;\n" if (defined($address));
		$output .= "  option host-name \"$hostname\";\n" if (defined($hostname));
		$output .= "  ddns-hostname \"$hostname\";\n" if (defined($hostname));
		$output .= "  ddns-domainname \"$zone\";\n" if (defined($zone));
		$output .= "  option domain-name \"$zone\";\n" if (defined($zone));
		$output .= "}\n";
		$output .= "subclass \"$class\" 1:$mac;\n";
		$output .= "subclass \"$class\" $mac;\n\n";
		return $output;
	}


	# lets start with the DHCPd.conf header from the DB
	my $header = spi_exec_query("SELECT api.get_site_configuration('DHCPD_HEADER')");
	my $output = $header->{rows}[0]->{get_site_configuration}. "\n\n"; 

	# add the date to the file
	my $date = spi_exec_query("SELECT localtimestamp(0)")->{rows}[0]->{timestamp};
	$output .= "\# Generated at $date\n\n";

	# now for the rest of the config file
	$output .= &global_opts() . "\n";
	$output .= &dns_keys() . "\n";
	$output .= &forward_zones() . "\n";
	$output .= &reverse_zones() . "\n";
	$output .= &dhcp_classes() . "\n";
	$output .= &shared_networks() . "\n";
	$output .= &hosts() . "\n";

	$output .= "\# End dhcpd configuration file";

	# finally, store the config in the db, so we can get it back later.
	spi_exec_query("INSERT INTO management.output (value,file,timestamp) VALUES (\$\$".$output."\$\$,'dhcpd.conf',now())");

	#log our success with the api logging tool.
	spi_exec_query("SELECT api.syslog('successfully generated dhcpd.conf')");
$_X$;


ALTER FUNCTION api.generate_dhcpd_config() OWNER TO postgres;

--
-- Name: FUNCTION generate_dhcpd_config(); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.generate_dhcpd_config() IS 'Generate the config file for the dhcpd server, and store it in the db';


--
-- Name: get_ad_user_email(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_ad_user_email(text) RETURNS text
    LANGUAGE plperlu
    AS $_$
	#!/usr/bin/perl

	use strict;
	use warnings;
	use Net::LDAPS;
	use Data::Dumper;

	my $uri = spi_exec_query("SELECT api.get_site_configuration('AD_URI')")->{rows}[0]->{"get_site_configuration"};
	my $binddn = spi_exec_query("SELECT api.get_site_configuration('AD_BINDDN')")->{rows}[0]->{"get_site_configuration"};
	my $password = spi_exec_query("SELECT api.get_site_configuration('AD_PASSWORD')")->{rows}[0]->{"get_site_configuration"};
	my $identifier= spi_exec_query("SELECT api.get_site_configuration('AD_IDENTIFIER')")->{rows}[0]->{"get_site_configuration"};
	my $username = shift(@_) or die "Unable to get username\n";

	# Set up the server connection
	my $srv = Net::LDAPS->new ($uri) or die "Could not connect to LDAP server ($uri)\n";
	my $mesg = $srv->bind($binddn,password=>$password) or die "Could not bind to LDAP server at $uri\n";

	# Get the users DN
	my $user_dn_query = $srv->search(filter=>"($identifier=$username)");
	my $user_result = $user_dn_query->pop_entry();
	if(!$user_result) {
		die "Unable to find user \"$username\"\n";
	}

	# Unbind from the server
	$srv->unbind;

	return $user_result->get_value('mail');
$_$;


ALTER FUNCTION api.get_ad_user_email(text) OWNER TO postgres;

--
-- Name: FUNCTION get_ad_user_email(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_ad_user_email(text) IS 'Get a users email address from Active Directory';


--
-- Name: get_ad_user_level(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_ad_user_level(text) RETURNS text
    LANGUAGE plperlu
    AS $_X$
	#!/usr/bin/perl
	
	use strict;
	use warnings;
	use Net::LDAPS;
	use Data::Dumper;
	
	my $uri = spi_exec_query("SELECT api.get_site_configuration('AD_URI')")->{rows}[0]->{"get_site_configuration"};
	my $binddn = spi_exec_query("SELECT api.get_site_configuration('AD_BINDDN')")->{rows}[0]->{"get_site_configuration"};
	my $password = spi_exec_query("SELECT api.get_site_configuration('AD_PASSWORD')")->{rows}[0]->{"get_site_configuration"};
	my $identifier= spi_exec_query("SELECT api.get_site_configuration('AD_IDENTIFIER')")->{rows}[0]->{"get_site_configuration"};
	my $admin_filter = spi_exec_query("SELECT api.get_site_configuration('AD_ADMIN_FILTER')")->{rows}[0]->{"get_site_configuration"};
	my $admin_basedn = spi_exec_query("SELECT api.get_site_configuration('AD_ADMIN_BASEDN')")->{rows}[0]->{"get_site_configuration"};
	my $program_filter = spi_exec_query("SELECT api.get_site_configuration('AD_PROGRAM_FILTER')")->{rows}[0]->{"get_site_configuration"};
	my $program_basedn = spi_exec_query("SELECT api.get_site_configuration('AD_PROGRAM_BASEDN')")->{rows}[0]->{"get_site_configuration"};
	my $user_filter = spi_exec_query("SELECT api.get_site_configuration('AD_USER_FILTER')")->{rows}[0]->{"get_site_configuration"};
	my $user_basedn = spi_exec_query("SELECT api.get_site_configuration('AD_USER_BASEDN')")->{rows}[0]->{"get_site_configuration"};
	my $username = shift(@_) or die "Unable to get username\n";
	
	my $status = "NONE";
	my $user_dn;

	if ($username eq "root") {
		return "ADMIN";
	}
	
	
	# Set up the server connection
	my $srv = Net::LDAPS->new ($uri) or die "Could not connect to LDAP server ($uri)\n";
	my $mesg = $srv->bind($binddn,password=>$password) or die "Could not bind to LDAP server at $uri\n";
	
	# Get the users DN
	my $user_dn_query = $srv->search(filter=>"($identifier=$username)");
	my $user_result = $user_dn_query->pop_entry();
	if($user_result) {
		$user_dn = $user_result->dn;
	} else {
		die "Unable to identify user \"$username\"\n";
	}
	
	# Get the User group members
	my $user_query = $srv->search(filter=>"($user_filter)",base=>"$user_basedn");
	foreach my $user_user_entries ($user_query->entries) {
		if(grep $user_dn eq $_, $user_user_entries->get_value("member")) {
			$status = "USER";
		}
	}
	
	# Get the Admin group members
	my $admin_query = $srv->search(filter=>"($admin_filter)",base=>"$admin_basedn");
	foreach my $admin_user_entries ($admin_query->entries) {
		if(grep $user_dn eq $_, $admin_user_entries->get_value("member")) {
			$status = "ADMIN";
		}
	}
	
	# Unbind from the server
	$srv->unbind;
	
	return $status;
$_X$;


ALTER FUNCTION api.get_ad_user_level(text) OWNER TO postgres;

--
-- Name: FUNCTION get_ad_user_level(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_ad_user_level(text) IS 'Get a users level from Active Directory';


--
-- Name: get_address_from_range(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_address_from_range(input_range_name text) RETURNS inet
    LANGUAGE plpgsql
    AS $$
	DECLARE
		LowerBound INET;
		UpperBound INET;
		AddressToUse INET;
	BEGIN
		-- Dynamic Addressing for ipv4
		IF (SELECT "use" FROM "ip"."ranges" WHERE "name" = input_range_name) = 'ROAM' 
		AND (SELECT family("subnet") FROM "ip"."ranges" WHERE "name" = input_range_name) = 4 THEN
			SELECT "address" INTO AddressToUse FROM "ip"."addresses" 
			WHERE "address" << cidr(api.get_site_configuration('DYNAMIC_SUBNET'))
			AND "address" NOT IN (SELECT "address" FROM "systems"."interface_addresses") ORDER BY "address" ASC LIMIT 1;
			RETURN AddressToUse;
		END IF;

		-- Get range bounds
		SELECT "first_ip","last_ip" INTO LowerBound,UpperBound
		FROM "ip"."ranges"
		WHERE "ip"."ranges"."name" = input_range_name;

		-- Get address from range
		SELECT "address" FROM "ip"."addresses" INTO AddressToUse
		WHERE "address" <= UpperBound AND "address" >= LowerBound
		AND "address" NOT IN (SELECT "address" FROM "systems"."interface_addresses") ORDER BY "address" ASC LIMIT 1;

		-- Check if range was full (AddressToUse will be NULL)
		IF AddressToUse IS NULL THEN
			RAISE EXCEPTION 'All addresses in range % are in use',input_range_name;
		END IF;

		-- Done
		RETURN AddressToUse;
	END;
$$;


ALTER FUNCTION api.get_address_from_range(input_range_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_address_from_range(input_range_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_address_from_range(input_range_name text) IS 'get the first available address in a range';


--
-- Name: get_address_range(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_address_range(input_address inet) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "name" FROM "ip"."ranges" WHERE "first_ip" <= input_address AND "last_ip" >= input_address);
	END;
$$;


ALTER FUNCTION api.get_address_range(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_address_range(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_address_range(input_address inet) IS 'Get the name of the range an address is in';


--
-- Name: get_availability_zones(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_availability_zones() RETURNS SETOF systems.availability_zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."availability_zones" ORDER BY "zone");
	END;
$$;


ALTER FUNCTION api.get_availability_zones() OWNER TO starrs;

--
-- Name: FUNCTION get_availability_zones(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_availability_zones() IS 'Get all of the configured availability zones';


--
-- Name: get_current_user_groups(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_current_user_groups() RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY(SELECT "group" FROM "management"."group_members" WHERE "user" = api.get_current_user());
	END;
$$;


ALTER FUNCTION api.get_current_user_groups() OWNER TO starrs;

--
-- Name: FUNCTION get_current_user_groups(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_current_user_groups() IS 'Get the groups of the current user';


--
-- Name: get_current_user_level(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_current_user_level() RETURNS text
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		RETURN (SELECT "privilege"
		FROM "user_privileges"
		WHERE "allow" = TRUE
		AND "privilege" ~* '^admin|program|user$');
	END;
$_$;


ALTER FUNCTION api.get_current_user_level() OWNER TO starrs;

--
-- Name: FUNCTION get_current_user_level(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_current_user_level() IS 'Get the level of the current session user';


--
-- Name: get_datacenters(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_datacenters() RETURNS SETOF systems.datacenters
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."datacenters" ORDER BY CASE WHEN "datacenter" = (SELECT api.get_site_configuration('DEFAULT_DATACENTER')) THEN 1 ELSE 2 END);
	END;
$$;


ALTER FUNCTION api.get_datacenters() OWNER TO starrs;

--
-- Name: FUNCTION get_datacenters(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_datacenters() IS 'Get all of the available datacenters';


--
-- Name: get_default_renew_date(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_default_renew_date(input_system text) RETURNS date
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_system IS NULL THEN
			RETURN date((('now'::text)::date + (api.get_site_configuration('DEFAULT_RENEW_INTERVAL'::text))::interval));
		ELSE
			RETURN date(('now'::text)::date + (SELECT "renew_interval" FROM "management"."groups"
			JOIN "systems"."systems" ON "systems"."systems"."group" = "management"."groups"."group"
			WHERE "system_name" = input_system));
		END IF;
	END;
$$;


ALTER FUNCTION api.get_default_renew_date(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION get_default_renew_date(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_default_renew_date(input_system text) IS 'Get the default renew date based on the configuration';


--
-- Name: get_dhcp_class(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_class(input_class text) RETURNS SETOF dhcp.classes
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_class IS NULL THEN
			RETURN QUERY (SELECT * FROM "dhcp"."classes" ORDER BY "class");
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."classes" WHERE "class" = input_class ORDER BY "class");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dhcp_class(input_class text) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_class(input_class text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_class(input_class text) IS 'Get all DHCP class information for a specific class';


--
-- Name: get_dhcp_class_options(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_class_options(input_class text) RETURNS SETOF dhcp.class_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "dhcp"."class_options" WHERE "class" = input_class ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcp_class_options(input_class text) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_class_options(input_class text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_class_options(input_class text) IS 'Get all DHCP class option data';


--
-- Name: get_dhcp_classes(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_classes() RETURNS SETOF dhcp.classes
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "dhcp"."classes" ORDER BY "class");
	END;
$$;


ALTER FUNCTION api.get_dhcp_classes() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_classes(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_classes() IS 'Get all DHCP class information';


--
-- Name: config_types; Type: TABLE; Schema: dhcp; Owner: starrs
--

CREATE TABLE dhcp.config_types (
    config text NOT NULL,
    comment text,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    family integer NOT NULL
);


ALTER TABLE dhcp.config_types OWNER TO starrs;

--
-- Name: TABLE config_types; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON TABLE dhcp.config_types IS 'List of ways to configure your address';


--
-- Name: get_dhcp_config_types(integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_config_types(input_family integer) RETURNS SETOF dhcp.config_types
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_family IS NULL THEN
			RETURN QUERY (SELECT * FROM "dhcp"."config_types" ORDER BY CASE WHEN "config" = api.get_site_configuration('DEFAULT_CONFIG_TYPE') THEN 1 ELSE 2 END);
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."config_types" WHERE "family" = input_family ORDER BY CASE WHEN "config" = api.get_site_configuration('DEFAULT_CONFIG_TYPE') THEN 1 ELSE 2 END);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dhcp_config_types(input_family integer) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_config_types(input_family integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_config_types(input_family integer) IS 'Get all DHCP config information';


--
-- Name: get_dhcp_global_options(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_global_options() RETURNS SETOF dhcp.global_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "dhcp"."global_options" ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcp_global_options() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_global_options(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_global_options() IS 'Get all DHCP global option data';


--
-- Name: get_dhcp_range_options(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_range_options(input_range text) RETURNS SETOF dhcp.range_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "dhcp"."range_options" WHERE "name" = input_range ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcp_range_options(input_range text) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_range_options(input_range text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_range_options(input_range text) IS 'Get all DHCP range option data';


--
-- Name: get_dhcp_subnet_options(cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcp_subnet_options(input_subnet cidr) RETURNS SETOF dhcp.subnet_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "dhcp"."subnet_options" WHERE "subnet" = input_subnet ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcp_subnet_options(input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcp_subnet_options(input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcp_subnet_options(input_subnet cidr) IS 'Get all DHCP subnet option data';


--
-- Name: get_dhcpd6_config(); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_dhcpd6_config() RETURNS text
    LANGUAGE plpgsql
    AS $$	BEGIN
		RETURN (SELECT "value" FROM "management"."output" WHERE "file"='dhcpd6.conf' ORDER BY "timestamp" DESC LIMIT 1);
	END;
$$;


ALTER FUNCTION api.get_dhcpd6_config() OWNER TO postgres;

--
-- Name: FUNCTION get_dhcpd6_config(); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_dhcpd6_config() IS 'Get the latest DHCPD6 configuration file';


--
-- Name: get_dhcpd6_reverse_zones(); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_dhcpd6_reverse_zones() RETURNS SETOF dhcp.dhcpd_zones
    LANGUAGE plpgsql
    AS $$	BEGIN
		RETURN QUERY (SELECT DISTINCT api.get_reverse_domain("subnet") AS "zone","dns"."zones"."keyname","address" 
		FROM "ip"."subnets"
		JOIN "dns"."zones" ON "dns"."zones"."zone" = "ip"."subnets"."zone" 
		JOIN "dns"."ns" ON "dns"."zones"."zone" = "dns"."ns"."zone" 
		WHERE "dns"."ns"."nameserver" IN (SELECT "nameserver" FROM "dns"."soa" WHERE "dns"."soa"."zone" = "ip"."subnets"."zone") 
		AND "dhcp_enable" = TRUE AND family("subnet") = 6
		ORDER BY api.get_reverse_domain("subnet"),"dns"."zones"."keyname","address");
	END;
$$;


ALTER FUNCTION api.get_dhcpd6_reverse_zones() OWNER TO postgres;

--
-- Name: FUNCTION get_dhcpd6_reverse_zones(); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_dhcpd6_reverse_zones() IS 'Get all reverse zone info for dhcpd6';


--
-- Name: get_dhcpd6_static_hosts(); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_dhcpd6_static_hosts() RETURNS SETOF dhcp.dhcpd_static_hosts
    LANGUAGE plpgsql
    AS $$	BEGIN
		RETURN QUERY (SELECT "dns"."a"."hostname","dns"."a"."zone",
		"systems"."interface_addresses"."mac","systems"."interface_addresses"."address","systems"."systems"."owner",
		"systems"."interface_addresses"."class"
		FROM "systems"."interface_addresses"
		LEFT JOIN "dns"."a" ON "dns"."a"."address" = "systems"."interface_addresses"."address"
		JOIN "systems"."interfaces" ON "systems"."interfaces"."mac" = "systems"."interface_addresses"."mac"
		JOIN "systems"."systems" ON "systems"."systems"."system_name" = "systems"."interfaces"."system_name"
		WHERE "systems"."interface_addresses"."config"='dhcpv6'
		AND NOT "systems"."interface_addresses"."address" << (SELECT cidr(api.get_site_configuration('DYNAMIC_SUBNET')))
		AND ("dns"."a"."zone" IN (SELECT DISTINCT "zone" FROM "ip"."subnets" WHERE "dhcp_enable" IS TRUE ORDER BY "zone")
		OR "dns"."a"."zone" IS NULL) ORDER BY "systems"."systems"."owner");	
	END;
$$;


ALTER FUNCTION api.get_dhcpd6_static_hosts() OWNER TO postgres;

--
-- Name: FUNCTION get_dhcpd6_static_hosts(); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_dhcpd6_static_hosts() IS 'Get all information for a host block of the dhcpd6.conf file';


--
-- Name: get_dhcpd_class_options(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_class_options(input_class text) RETURNS SETOF dhcp.dhcpd_class_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "option","value" FROM "dhcp"."class_options" WHERE "class" = input_class ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_class_options(input_class text) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_class_options(input_class text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_class_options(input_class text) IS 'Get class options for the dhcpd.conf file';


--
-- Name: get_dhcpd_classes(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_classes() RETURNS SETOF dhcp.dhcpd_classes
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "class","comment" FROM "dhcp"."classes" ORDER BY "class");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_classes() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_classes(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_classes() IS 'Get class information for the dhcpd.conf file';


--
-- Name: get_dhcpd_config(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_config() RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "value" FROM "management"."output" WHERE "file"='dhcpd.conf' ORDER BY "timestamp" DESC LIMIT 1);
	END;
$$;


ALTER FUNCTION api.get_dhcpd_config() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_config(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_config() IS 'Get the latest DHCPD configuration file';


--
-- Name: get_dhcpd_dns_keys(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_dns_keys() RETURNS SETOF dhcp.dhcpd_dns_keys
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied on get_dhcpd_dns_keys: You are not admin.';
		END IF;
		
		-- Return data
		RETURN QUERY (SELECT DISTINCT "dns"."zones"."keyname","dns"."keys"."key","dns"."keys"."enctype" 
		FROM "ip"."subnets" 
		JOIN "dns"."zones" ON "dns"."zones"."zone" = "ip"."subnets"."zone" 
		JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname" 
		WHERE "dhcp_enable" = TRUE
		ORDER BY "dns"."zones"."keyname","dns"."keys"."key","dns"."keys"."enctype");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_dns_keys() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_dns_keys(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_dns_keys() IS 'Get all of the dns keys for dhcpd';


--
-- Name: get_dhcpd_dynamic_hosts(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_dynamic_hosts() RETURNS SETOF dhcp.dhcpd_dynamic_hosts
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "dns"."a"."hostname","dns"."a"."zone",
		"systems"."interface_addresses"."mac","systems"."systems"."owner","systems"."interface_addresses"."class"
		FROM "systems"."interface_addresses"
		LEFT JOIN "dns"."a" ON "dns"."a"."address" = "systems"."interface_addresses"."address"
		JOIN "systems"."interfaces" ON "systems"."interfaces"."mac" = "systems"."interface_addresses"."mac"
		JOIN "systems"."systems" ON "systems"."systems"."system_name" = "systems"."interfaces"."system_name"
		WHERE "systems"."interface_addresses"."config"='dhcp'
		AND "systems"."interface_addresses"."address" << (SELECT cidr(api.get_site_configuration('DYNAMIC_SUBNET')))
		AND ("dns"."a"."zone" IN (SELECT DISTINCT "zone" FROM "ip"."subnets" WHERE "dhcp_enable" IS TRUE ORDER BY "zone")
		OR "dns"."a"."zone" IS NULL) ORDER BY "systems"."systems"."owner");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_dynamic_hosts() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_dynamic_hosts(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_dynamic_hosts() IS 'Get all information for a host block of the dhcpd.conf file';


--
-- Name: get_dhcpd_forward_zones(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_forward_zones() RETURNS SETOF dhcp.dhcpd_zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT DISTINCT "ip"."subnets"."zone","dns"."zones"."keyname","address"
		FROM "ip"."subnets"
		JOIN "dns"."zones" ON "dns"."zones"."zone" = "ip"."subnets"."zone" 
		JOIN "dns"."ns" ON "dns"."zones"."zone" = "dns"."ns"."zone" 
		WHERE "dns"."ns"."nameserver" IN (SELECT "nameserver" FROM "dns"."soa" WHERE "dns"."soa"."zone" = "ip"."subnets"."zone")
		ORDER BY "ip"."subnets"."zone");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_forward_zones() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_forward_zones(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_forward_zones() IS 'Get all forward zone info for dhcpd';


--
-- Name: get_dhcpd_global_options(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_global_options() RETURNS SETOF dhcp.dhcpd_global_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "option","value" FROM "dhcp"."global_options" ORDER BY CASE WHEN "option" = 'option space' THEN 1 ELSE 2 END);
	END;
$$;


ALTER FUNCTION api.get_dhcpd_global_options() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_global_options(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_global_options() IS 'Get all of the global DHCPD config directives';


--
-- Name: get_dhcpd_range_options(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_range_options(input_range text) RETURNS SETOF dhcp.dhcpd_range_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "option","value" FROM "dhcp"."range_options" WHERE "name" = input_range ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_range_options(input_range text) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_range_options(input_range text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_range_options(input_range text) IS 'Get all range options for dhcpd.conf';


--
-- Name: get_dhcpd_reverse_zones(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_reverse_zones() RETURNS SETOF dhcp.dhcpd_zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT DISTINCT api.get_reverse_domain("subnet") AS "zone","dns"."zones"."keyname","address" 
		FROM "ip"."subnets"
		JOIN "dns"."zones" ON "dns"."zones"."zone" = "ip"."subnets"."zone" 
		JOIN "dns"."ns" ON "dns"."zones"."zone" = "dns"."ns"."zone" 
		WHERE "dns"."ns"."nameserver" IN (SELECT "nameserver" FROM "dns"."soa" WHERE "dns"."soa"."zone" = "ip"."subnets"."zone") 
		AND "dhcp_enable" = TRUE AND family("subnet") = 4
		ORDER BY api.get_reverse_domain("subnet"),"dns"."zones"."keyname","address");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_reverse_zones() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_reverse_zones(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_reverse_zones() IS 'Get all reverse zone info for dhcpd';


--
-- Name: get_dhcpd_shared_network_subnets(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_shared_network_subnets(input_name text) RETURNS SETOF cidr
    LANGUAGE plpgsql
    AS $$
	BEGIN
	   	RETURN QUERY (SELECT "subnet" FROM "network"."vlans" JOIN "ip"."subnets" ON "network"."vlans"."vlan" = "ip"."subnets"."vlan" WHERE "network"."vlans"."name" = input_name AND "dhcp_enable" IS TRUE);
	END;
$$;


ALTER FUNCTION api.get_dhcpd_shared_network_subnets(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_shared_network_subnets(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_shared_network_subnets(input_name text) IS 'Get the subnets for DHCPD';


--
-- Name: get_dhcpd_shared_networks(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_shared_networks() RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
	BEGIN
	   	RETURN QUERY (SELECT "name" FROM "network"."vlans" WHERE "datacenter" = api.get_site_configuration('DEFAULT_DATACENTER') ORDER BY "name");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_shared_networks() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_shared_networks(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_shared_networks() IS 'Get DHCPD shared networks';


--
-- Name: get_dhcpd_static_hosts(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_static_hosts() RETURNS SETOF dhcp.dhcpd_static_hosts
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "dns"."a"."hostname","dns"."a"."zone",
		"systems"."interface_addresses"."mac","systems"."interface_addresses"."address","systems"."systems"."owner",
		"systems"."interface_addresses"."class"
		FROM "systems"."interface_addresses"
		LEFT JOIN "dns"."a" ON "dns"."a"."address" = "systems"."interface_addresses"."address"
		JOIN "systems"."interfaces" ON "systems"."interfaces"."mac" = "systems"."interface_addresses"."mac"
		JOIN "systems"."systems" ON "systems"."systems"."system_name" = "systems"."interfaces"."system_name"
		WHERE "systems"."interface_addresses"."config"='dhcp'
		AND NOT "systems"."interface_addresses"."address" << (SELECT cidr(api.get_site_configuration('DYNAMIC_SUBNET')))
		AND ("dns"."a"."zone" IN (SELECT DISTINCT "zone" FROM "ip"."subnets" WHERE "dhcp_enable" IS TRUE ORDER BY "zone")
		OR "dns"."a"."zone" IS NULL) ORDER BY "systems"."systems"."owner");	
	END;
$$;


ALTER FUNCTION api.get_dhcpd_static_hosts() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_static_hosts(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_static_hosts() IS 'Get all information for a host block of the dhcpd.conf file';


--
-- Name: get_dhcpd_subnet_options(cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_subnet_options(input_subnet cidr) RETURNS SETOF dhcp.dhcpd_subnet_options
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "option","value" FROM "dhcp"."subnet_options" WHERE "subnet" = input_subnet ORDER BY "option");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_subnet_options(input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_subnet_options(input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_subnet_options(input_subnet cidr) IS 'Get all subnet options for dhcpd.conf';


--
-- Name: get_dhcpd_subnet_ranges(cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_subnet_ranges(input_subnet cidr) RETURNS SETOF dhcp.dhcpd_subnet_ranges
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "name","first_ip","last_ip","class" FROM "ip"."ranges" WHERE "subnet" = input_subnet AND "use" = 'ROAM' AND family("subnet") = 4 ORDER BY "subnet");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_subnet_ranges(input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_subnet_ranges(input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_subnet_ranges(input_subnet cidr) IS 'Get a list of all dynamic ranges in a subnet';


--
-- Name: get_dhcpd_subnets(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dhcpd_subnets() RETURNS SETOF cidr
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "subnet" FROM "ip"."subnets" WHERE "dhcp_enable" = TRUE AND family("subnet") = 4 ORDER BY "subnet");
	END;
$$;


ALTER FUNCTION api.get_dhcpd_subnets() OWNER TO starrs;

--
-- Name: FUNCTION get_dhcpd_subnets(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dhcpd_subnets() IS 'Get a list of all DHCP enabled subnets for DHCPD';


--
-- Name: get_dns_a(inet, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_a(input_address inet, input_zone text) RETURNS SETOF dns.a
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_zone IS NULL THEN
			IF input_address IS NULL THEN
				RETURN QUERY (SELECT * FROM "dns"."a" ORDER BY "address");
			ELSE
				RETURN QUERY (SELECT * FROM "dns"."a" WHERE "address" = input_address ORDER BY "zone" ASC);
			END IF;
		ELSE
			IF input_address IS NULL THEN
				RETURN QUERY (SELECT * FROM "dns"."a" ORDER BY "address");
			ELSE
				RETURN QUERY (SELECT * FROM "dns"."a" WHERE "address" = input_address AND "zone" = input_zone ORDER BY "zone");
			END IF;
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_a(input_address inet, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_a(input_address inet, input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_a(input_address inet, input_zone text) IS 'Get all DNS address records for an address';


--
-- Name: get_dns_cname(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_cname(input_address inet) RETURNS SETOF dns.cname
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_address IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."cname" ORDER BY "alias");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."cname" WHERE "address" = input_address ORDER BY "alias" ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_cname(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_cname(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_cname(input_address inet) IS 'Get all DNS CNAME records for an address';


--
-- Name: get_dns_key(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_key(input_keyname text) RETURNS SETOF dns.keys
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "dns"."keys" WHERE "keyname" = input_keyname) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to get DNS key denied: You are not admin or owner';
			END IF;
		END IF;
		RETURN QUERY (SELECT * FROM "dns"."keys" WHERE "keyname" = input_keyname);
	END;
$$;


ALTER FUNCTION api.get_dns_key(input_keyname text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_key(input_keyname text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_key(input_keyname text) IS 'Get DNS key data';


--
-- Name: get_dns_keys(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_keys(input_username text) RETURNS SETOF dns.keys
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_username IS NULL THEN
			IF api.get_current_user_level() !~* 'ADMIN' THEN
				RAISE EXCEPTION 'Permission to get DNS keys denied: You are not admin';
			END IF;
			RETURN QUERY (SELECT * FROM "dns"."keys" ORDER BY "keyname");
		ELSE
			IF api.get_current_user_level() !~* 'ADMIN' THEN
				IF input_username != api.get_current_user() THEN
					RAISE EXCEPTION 'Permission to get DNS keys denied: You are not admin or owner';
				END IF;
			END IF;
			RETURN QUERY (SELECT * FROM "dns"."keys" WHERE "owner" = input_username ORDER BY "keyname" ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_keys(input_username text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_keys(input_username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_keys(input_username text) IS 'Get DNS key data';


--
-- Name: get_dns_mx(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_mx(input_address inet) RETURNS SETOF dns.mx
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_address IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."mx" ORDER BY "preference");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."mx" WHERE "address" = input_address ORDER BY "preference");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_mx(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_mx(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_mx(input_address inet) IS 'Get all data pertanent to DNS MX records for an address';


--
-- Name: get_dns_ns(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_ns(input_zone text) RETURNS SETOF dns.ns
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_zone IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."ns" ORDER BY "nameserver");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."ns" WHERE "zone" = input_zone ORDER BY "nameserver");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_ns(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_ns(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_ns(input_zone text) IS 'Get all DNS NS records for a zone';


--
-- Name: get_dns_soa(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_soa(input_zone text) RETURNS SETOF dns.soa
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_zone IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."soa" ORDER BY "zone");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."soa" WHERE "dns"."soa"."zone" = input_zone);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_soa(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_soa(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_soa(input_zone text) IS 'Get the SOA record of a DNS zone';


--
-- Name: get_dns_srv(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_srv(input_address inet) RETURNS SETOF dns.srv
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_address IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."srv" ORDER BY "alias");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."srv" WHERE "address" = input_address ORDER BY "alias" ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_srv(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_srv(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_srv(input_address inet) IS 'Get all DNS SRV records for an address';


--
-- Name: get_dns_txt(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_txt(input_address inet) RETURNS SETOF dns.txt
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_address IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."txt" ORDER BY "text");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."txt" WHERE "address" = input_address ORDER BY "text");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_txt(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_txt(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_txt(input_address inet) IS 'Get all DNS TXT records for an address';


--
-- Name: get_dns_zone(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_zone(input_zone text) RETURNS SETOF dns.zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_zone IS NULL THEN
			RETURN QUERY(SELECT * FROM "dns"."zones" ORDER BY "zone");
		ELSE
			RETURN QUERY(SELECT * FROM "dns"."zones" WHERE "zone" = input_zone ORDER BY "zone");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_zone(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_zone(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_zone(input_zone text) IS 'Get detailed dns zone information';


--
-- Name: get_dns_zone_a(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_zone_a(input_zone text) RETURNS SETOF dns.zone_a
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_zone IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."zone_a" ORDER BY "address");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."zone_a" WHERE "zone" = input_zone ORDER BY "address");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_zone_a(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_zone_a(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_zone_a(input_zone text) IS 'Get all DNS address records for a zone';


--
-- Name: get_dns_zone_txt(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_zone_txt(input_zone text) RETURNS SETOF dns.zone_txt
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_zone IS NULL THEN
			RETURN QUERY (SELECT * FROM "dns"."zone_txt" ORDER BY "hostname");
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "zone" = input_zone ORDER BY "hostname" ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_zone_txt(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_zone_txt(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_zone_txt(input_zone text) IS 'Get all DNS TXT records specifically for a zone';


--
-- Name: get_dns_zones(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_dns_zones(input_username text) RETURNS SETOF dns.zones
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_username IS NULL THEN
			 RETURN QUERY(SELECT * FROM "dns"."zones" ORDER BY CASE WHEN "zone" = (SELECT api.get_site_configuration('DNS_DEFAULT_ZONE')) THEN 1 ELSE 2 END, "forward" DESC, "zone" ASC);
		ELSE
			 RETURN QUERY(SELECT * FROM "dns"."zones" WHERE "shared" = TRUE OR "owner" = input_username ORDER BY CASE WHEN "zone" = (SELECT api.get_site_configuration('DNS_DEFAULT_ZONE')) THEN 1 ELSE 2 END, "forward" DESC, "zone" ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_dns_zones(input_username text) OWNER TO starrs;

--
-- Name: FUNCTION get_dns_zones(input_username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_dns_zones(input_username text) IS 'Get the available zones to a user';


--
-- Name: get_domain_state(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_domain_state(input_system text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
		HostData RECORD;
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."system" WHERE "system_name" = input_system) THEN
				RAISE EXCEPTION 'Permission denied: Not VM owner';
			END IF;
		END IF;

		SELECT * INTO HostData FROM "libvirt"."hosts" WHERE "system_name" = (SELECT "host_name" FROM "libvirt"."domains" WHERE "domain_name" = input_system);

		RETURN api.get_libvirt_domain_state(HostData.uri, HostData.password, input_system);
	END;
$$;


ALTER FUNCTION api.get_domain_state(input_system text) OWNER TO starrs;

--
-- Name: get_function_counts(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_function_counts(input_schema text) RETURNS TABLE(function text, calls integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY(
			SELECT "information_schema"."routines"."routine_name"::text,"pg_stat_user_functions"."calls"::integer 
			FROM "information_schema"."routines" 
			LEFT JOIN "pg_stat_user_functions" ON "pg_stat_user_functions"."funcname" = "information_schema"."routines"."routine_name" 
			WHERE "information_schema"."routines"."routine_schema" = input_schema
		);
	END;
$$;


ALTER FUNCTION api.get_function_counts(input_schema text) OWNER TO starrs;

--
-- Name: FUNCTION get_function_counts(input_schema text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_function_counts(input_schema text) IS 'Get statistics on number of calls to each function in a schema';


--
-- Name: get_group_admins(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_group_admins(input_group text) RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY(SELECT "user" FROM "management"."group_members" WHERE "group" = input_group AND "privilege" = 'ADMIN');
	END;
$$;


ALTER FUNCTION api.get_group_admins(input_group text) OWNER TO starrs;

--
-- Name: FUNCTION get_group_admins(input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_group_admins(input_group text) IS 'Get a list of all admins for a group';


--
-- Name: get_group_members(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_group_members(input_group text) RETURNS SETOF management.group_members
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "management"."group_members" WHERE "group" = input_group ORDER BY "user");
	END;
$$;


ALTER FUNCTION api.get_group_members(input_group text) OWNER TO starrs;

--
-- Name: FUNCTION get_group_members(input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_group_members(input_group text) IS 'Get all members of a group';


--
-- Name: get_group_ranges(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_group_ranges(input_group text) RETURNS SETOF ip.ranges
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "ip"."ranges" WHERE "name" IN (SELECT "range_name" FROM "ip"."range_groups" WHERE "group_name" = input_group) ORDER BY "name");
	END;
$$;


ALTER FUNCTION api.get_group_ranges(input_group text) OWNER TO starrs;

--
-- Name: FUNCTION get_group_ranges(input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_group_ranges(input_group text) IS 'Get group range information';


--
-- Name: get_group_settings(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_group_settings(input_group text) RETURNS SETOF management.group_settings
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can view group provider settings';
		END IF;

		-- return
		RETURN QUERY (SELECT * FROM "management"."group_settings" WHERE "group" = input_group);
	END;
$$;


ALTER FUNCTION api.get_group_settings(input_group text) OWNER TO starrs;

--
-- Name: FUNCTION get_group_settings(input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_group_settings(input_group text) IS 'Get group settings';


--
-- Name: get_groups(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_groups() RETURNS SETOF management.groups
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "management"."groups" ORDER BY "group");
	END;
$$;


ALTER FUNCTION api.get_groups() OWNER TO starrs;

--
-- Name: FUNCTION get_groups(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_groups() IS 'Get all of the configured groups';


--
-- Name: get_host_domain(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_host_domain(input_system text, input_domain text) RETURNS SETOF libvirt.domains
    LANGUAGE plpgsql
    AS $$
	DECLARE
		HostData RECORD;
	BEGIN
		SELECT * INTO HostData FROM "libvirt"."hosts" WHERE "system_name" = input_system;
		RETURN QUERY (SELECT input_system AS "host_name","domain","state","definition",localtimestamp(0) AS "date_created", localtimestamp(0) AS "date_modified", api.get_current_user() AS "last_modifier" FROM api.get_libvirt_domain(HostData.uri, HostData.password, input_domain));
	END;
$$;


ALTER FUNCTION api.get_host_domain(input_system text, input_domain text) OWNER TO starrs;

--
-- Name: get_host_domains(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_host_domains(input_system text) RETURNS SETOF libvirt.domains
    LANGUAGE plpgsql
    AS $$
	DECLARE
		HostData RECORD;
	BEGIN
		SELECT * INTO HostData FROM "libvirt"."hosts" WHERE "system_name" = input_system;
		RETURN QUERY (SELECT input_system AS "host_name","domain","state","definition",localtimestamp(0) AS "date_created", localtimestamp(0) AS "date_modified", api.get_current_user() AS "last_modifier" FROM api.get_libvirt_domains(HostData.uri, HostData.password));
	END;
$$;


ALTER FUNCTION api.get_host_domains(input_system text) OWNER TO starrs;

--
-- Name: get_hosts(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_hosts(input_user text) RETURNS SETOF libvirt.hosts
    LANGUAGE plpgsql
    AS $$
	BEGIN	
		IF input_user IS NULL THEN
			IF api.get_current_user_level() !~* 'ADMIN' THEN
				RAISE EXCEPTION 'Only admins can view all VM hosts';
			END IF;
			RETURN QUERY (SELECT * FROM "libvirt"."hosts" ORDER BY "system_name");
		ELSE
			IF api.get_current_user_level() !~* 'ADMIN' THEN
				RETURN QUERY (SELECT * FROM "libvirt"."hosts" WHERE api.get_system_owner("system_name") = input_user ORDER BY "system_name");
			ELSE
				RETURN QUERY (SELECT * FROM "libvirt"."hosts" ORDER BY "system_name");
			END IF;
		END IF;
	END;
$$;


ALTER FUNCTION api.get_hosts(input_user text) OWNER TO starrs;

--
-- Name: FUNCTION get_hosts(input_user text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_hosts(input_user text) IS 'Get all VM hosts';


--
-- Name: get_interface_address_owner(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_interface_address_owner(input_address inet) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "owner" FROM systems.interface_addresses
			JOIN systems.interfaces on systems.interface_addresses.mac = systems.interfaces.mac
			JOIN systems.systems on systems.interfaces.system_name = systems.systems.system_name
			WHERE "address" = input_address);
	END;
$$;


ALTER FUNCTION api.get_interface_address_owner(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_interface_address_owner(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_interface_address_owner(input_address inet) IS 'Get the owner of an interface address';


--
-- Name: get_interface_address_system(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_interface_address_system(input_address inet) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "system_name" FROM "systems"."interface_addresses"
		JOIN "systems"."interfaces" ON "systems"."interface_addresses"."mac" = "systems"."interfaces"."mac"
		WHERE "address" = input_address);
	END;
$$;


ALTER FUNCTION api.get_interface_address_system(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_interface_address_system(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_interface_address_system(input_address inet) IS 'Get the name of the system to which the given address is assigned';


--
-- Name: get_interface_owner(macaddr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_interface_owner(input_mac macaddr) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "owner" FROM "systems"."interfaces" 
			JOIN "systems"."systems" ON "systems"."interfaces"."system_name" = "systems"."systems"."system_name"
			WHERE "mac" = input_mac);
	END;
$$;


ALTER FUNCTION api.get_interface_owner(input_mac macaddr) OWNER TO starrs;

--
-- Name: FUNCTION get_interface_owner(input_mac macaddr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_interface_owner(input_mac macaddr) IS 'Get the owner of the system that contains the mac address';


--
-- Name: cam_cache; Type: TABLE; Schema: network; Owner: starrs
--

CREATE TABLE network.cam_cache (
    system_name text NOT NULL,
    mac macaddr NOT NULL,
    ifindex integer NOT NULL,
    vlan integer NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE network.cam_cache OWNER TO starrs;

--
-- Name: TABLE cam_cache; Type: COMMENT; Schema: network; Owner: starrs
--

COMMENT ON TABLE network.cam_cache IS 'Cache switch data for port mappings';


--
-- Name: get_interface_switchports(macaddr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_interface_switchports(input_mac macaddr) RETURNS SETOF network.cam_cache
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "network"."cam_cache" WHERE "mac" = input_mac);
	END;
$$;


ALTER FUNCTION api.get_interface_switchports(input_mac macaddr) OWNER TO starrs;

--
-- Name: FUNCTION get_interface_switchports(input_mac macaddr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_interface_switchports(input_mac macaddr) IS 'Get all the cam cache entries for MAC';


--
-- Name: get_interface_system(macaddr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_interface_system(input_mac macaddr) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "system_name" FROM "systems"."interfaces" WHERE "mac" = input_mac);
	END;
$$;


ALTER FUNCTION api.get_interface_system(input_mac macaddr) OWNER TO starrs;

--
-- Name: FUNCTION get_interface_system(input_mac macaddr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_interface_system(input_mac macaddr) IS 'Get the system name that a mac address is on';


--
-- Name: get_ip_mask_bits(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_ip_mask_bits(input_subnet inet) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        t1 TEXT;
        t2 TEXT;
        t3 TEXT;
        t4 TEXT;
        i BIGINT;
        n INTEGER;
    BEGIN
        IF family(input_subnet) != 4 THEN
            RAISE EXCEPTION 'Can only get mask bits of an IPv4 address';
        END IF;

        t1 := SPLIT_PART(HOST(input_subnet), '.',1);
        t2 := SPLIT_PART(HOST(input_subnet), '.',2);
        t3 := SPLIT_PART(HOST(input_subnet), '.',3);
        t4 := SPLIT_PART(HOST(input_subnet), '.',4);
        i := (t1::BIGINT << 24) + (t2::BIGINT << 16) +
                (t3::BIGINT << 8) + t4::BIGINT;
        n := (32-log(2, 4294967296 - i ))::integer;

        RETURN n;
    END;
$$;


ALTER FUNCTION api.get_ip_mask_bits(input_subnet inet) OWNER TO starrs;

--
-- Name: FUNCTION get_ip_mask_bits(input_subnet inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_ip_mask_bits(input_subnet inet) IS 'Get the number of bits in a subnet mask';


--
-- Name: get_ip_range_total(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_ip_range_total(input_range text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT COUNT(api.get_address_range("address"))
		FROM "ip"."addresses"
		WHERE api.get_address_range("address") ~* input_range);
	END;
$$;


ALTER FUNCTION api.get_ip_range_total(input_range text) OWNER TO starrs;

--
-- Name: FUNCTION get_ip_range_total(input_range text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_ip_range_total(input_range text) IS 'Get the number of possible addresses in a particiular range';


--
-- Name: get_ip_range_uses(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_ip_range_uses() RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT text("use") FROM "ip"."range_uses");
	END;
$$;


ALTER FUNCTION api.get_ip_range_uses() OWNER TO starrs;

--
-- Name: FUNCTION get_ip_range_uses(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_ip_range_uses() IS 'Get a list of all use codes';


--
-- Name: get_ip_ranges(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_ip_ranges() RETURNS SETOF ip.ranges
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "ip"."ranges" ORDER BY "first_ip");
	END;
$$;


ALTER FUNCTION api.get_ip_ranges() OWNER TO starrs;

--
-- Name: FUNCTION get_ip_ranges(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_ip_ranges() IS 'Get all configured IP ranges';


--
-- Name: get_ip_subnets(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_ip_subnets(input_username text) RETURNS SETOF ip.subnets
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_username IS NULL THEN
			RETURN QUERY (SELECT * FROM "ip"."subnets" ORDER BY "subnet");
		ELSE
			RETURN QUERY (SELECT * FROM "ip"."subnets" WHERE "owner" = input_username ORDER BY "subnet");
		END IF;
	END;
$$;


ALTER FUNCTION api.get_ip_subnets(input_username text) OWNER TO starrs;

--
-- Name: FUNCTION get_ip_subnets(input_username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_ip_subnets(input_username text) IS 'Get all IP subnet data';


--
-- Name: get_ldap_group_members(text, text, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_ldap_group_members(text, text, text, text) RETURNS SETOF text
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Net::LDAP;

	# Get the credentials
	my $hostname = $_[0] or die "Need to give a hostname";
	my $id= $_[1] or die "Need to give an ID";
	my $binddn = $_[2] or die "Need to give a username";
	my $password = $_[3] or die "Need to give a password";

	my $srv = Net::LDAP->new ($hostname) or die "Could not connect to LDAP server ($hostname)\n";
	my $mesg = $srv->bind($binddn,password=>$password) or die "Could not bind to LDAP server";

	my @members;

	my @dnparts = split(/,/, $id);
	my $filter = shift(@dnparts);
	my $base = join(",",@dnparts);


	$mesg = $srv->search(filter=>"($filter)",base=>$base);
	foreach my $entry ($mesg->entries) {
		my @vals = $entry->get_value('member');
		foreach my $val (@vals) {
			$val =~ s/^uid=(.*?),(.*?)$/$1/;
			push(@members, $val);
		}
	}

	return \@members;

$_X$;


ALTER FUNCTION api.get_ldap_group_members(text, text, text, text) OWNER TO postgres;

--
-- Name: get_ldap_user_level(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_ldap_user_level(text) RETURNS text
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Net::LDAP;
	
	# Get the current authenticated username
	my $username = $_[0] or die "Need to give a username";
	
	# If this is the installer, we dont need to query the server
	if ($username eq "root")
	{
		return "ADMIN";
	}
	
	# Get LDAP connection information
	my $host = spi_exec_query("SELECT api.get_site_configuration('LDAP_HOST')")->{rows}[0]->{"get_site_configuration"};
	my $binddn = spi_exec_query("SELECT api.get_site_configuration('LDAP_BINDDN')")->{rows}[0]->{"get_site_configuration"};
	my $password = spi_exec_query("SELECT api.get_site_configuration('LDAP_PASSWORD')")->{rows}[0]->{"get_site_configuration"};
	my $admin_filter = spi_exec_query("SELECT api.get_site_configuration('LDAP_ADMIN_FILTER')")->{rows}[0]->{"get_site_configuration"};
	my $admin_basedn = spi_exec_query("SELECT api.get_site_configuration('LDAP_ADMIN_BASEDN')")->{rows}[0]->{"get_site_configuration"};
	my $program_filter = spi_exec_query("SELECT api.get_site_configuration('LDAP_PROGRAM_FILTER')")->{rows}[0]->{"get_site_configuration"};
	my $program_basedn = spi_exec_query("SELECT api.get_site_configuration('LDAP_PROGRAM_BASEDN')")->{rows}[0]->{"get_site_configuration"};
	my $user_filter = spi_exec_query("SELECT api.get_site_configuration('LDAP_USER_FILTER')")->{rows}[0]->{"get_site_configuration"};
	my $user_basedn = spi_exec_query("SELECT api.get_site_configuration('LDAP_USER_BASEDN')")->{rows}[0]->{"get_site_configuration"};

	# The lowest status. Build from here.
	my $status = "NONE";

	# Bind to the LDAP server
	my $srv = Net::LDAP->new ($host) or die "Could not connect to LDAP server ($host)\n";
	my $mesg = $srv->bind($binddn,password=>$password) or die "Could not bind to LDAP server at $host\n";
	
	# Go through the directory and see if this user is a user account
	$mesg = $srv->search(filter=>"($user_filter=$username)",base=>$user_basedn,attrs=>[$user_filter]);
	foreach my $entry ($mesg->entries)
	{
		my @users = $entry->get_value($user_filter);
		foreach my $user (@users)
		{
			$user =~ s/^uid=(.*?)\,(.*?)$/$1/;
			if ($user eq $username)
			{
				$status = "USER";
			}
		}
	}

	# Go through the directory and see if this user is a program account
	$mesg = $srv->search(filter=>"($program_filter=$username)",base=>$program_basedn,attrs=>[$program_filter]);
	foreach my $entry ($mesg->entries)
	{
		my @programs = $entry->get_value($program_filter);
		foreach my $program (@programs)
		{
			if ($program eq $username)
			{
				$status = "PROGRAM";
			}
		}
	}
	
	# Go through the directory and see if this user is an admin
	# Fancy hacks to allow for less hardcoding of attributes
	my $admin_filter_atr = $admin_filter;
	$admin_filter_atr =~ s/^(.*?)[^a-zA-Z0-9]+$/$1/;
	$mesg = $srv->search(filter=>"($admin_filter)",base=>$admin_basedn,attrs=>[$admin_filter_atr]);
	foreach my $entry ($mesg->entries)
	{
		my @admins = $entry->get_value($admin_filter_atr);
		foreach my $admin (@admins)
		{
			$admin =~ s/^uid=(.*?)\,(.*?)$/$1/;
			if ($admin eq $username)
			{
				$status = "ADMIN";
			}
		}
	}

	# Unbind from the LDAP server
	$srv->unbind;

	# Done
	return $status;

#	if($_[0] eq 'root')
#	{
#		return "ADMIN"
#	}
#	else
#	{
#		return "USER";
#	}
$_X$;


ALTER FUNCTION api.get_ldap_user_level(text) OWNER TO postgres;

--
-- Name: FUNCTION get_ldap_user_level(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_ldap_user_level(text) IS 'Get the level of access for the authenticated user';


--
-- Name: get_libvirt_domain(text, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_libvirt_domain(sysuri text, syspassword text, domainname text) RETURNS libvirt.domain_data
    LANGUAGE plpython3u
    AS $$
	#!/usr/bin/python

	import libvirt
	import sys

	def request_credentials(credentials, data):
		for credential in credentials:
			if credential[0] == libvirt.VIR_CRED_AUTHNAME:
				#credential[4] = sysuser
				return 0
			elif credential[0] == libvirt.VIR_CRED_NOECHOPROMPT:
				credential[4] = syspassword
			else:
				return -1

		return 0

	auth = [[libvirt.VIR_CRED_AUTHNAME, libvirt.VIR_CRED_NOECHOPROMPT], request_credentials, None]
	if syspassword == None:
		conn = libvirt.open(sysuri)
	else:
		conn = libvirt.openAuth(sysuri, auth, 0)

	if conn == None:
		sys.exit("Unable to connect")
	
	state_names = { libvirt.VIR_DOMAIN_RUNNING  : "running",
		libvirt.VIR_DOMAIN_BLOCKED  : "idle",
		libvirt.VIR_DOMAIN_PAUSED   : "paused",
		libvirt.VIR_DOMAIN_SHUTDOWN : "in shutdown",
		libvirt.VIR_DOMAIN_SHUTOFF  : "shut off",
		libvirt.VIR_DOMAIN_CRASHED  : "crashed",
		libvirt.VIR_DOMAIN_NOSTATE  : "no state" }

	domain = conn.lookupByName(domainname)
	return ([domain.name(), state_names[domain.info()[0]], domain.XMLDesc(0)])
$$;


ALTER FUNCTION api.get_libvirt_domain(sysuri text, syspassword text, domainname text) OWNER TO postgres;

--
-- Name: get_libvirt_domain_state(text, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_libvirt_domain_state(sysuri text, syspassword text, domain text) RETURNS text
    LANGUAGE plpython3u
    AS $$
	#!/usr/bin/python
	
	import libvirt
	import sys

	def request_credentials(credentials, data):
		for credential in credentials:
			if credential[0] == libvirt.VIR_CRED_AUTHNAME:
				return 0
			elif credential[0] == libvirt.VIR_CRED_NOECHOPROMPT:
				credential[4] = syspassword
			else:
				return -1

		return 0

	auth = [[libvirt.VIR_CRED_AUTHNAME, libvirt.VIR_CRED_NOECHOPROMPT], request_credentials, None]
	conn = libvirt.openAuth(sysuri, auth, 0)

	dom = conn.lookupByName(domain)

	conn.close()
	state_names = { libvirt.VIR_DOMAIN_RUNNING  : "running",
		libvirt.VIR_DOMAIN_BLOCKED  : "idle",
		libvirt.VIR_DOMAIN_PAUSED   : "paused",
		libvirt.VIR_DOMAIN_SHUTDOWN : "in shutdown",
		libvirt.VIR_DOMAIN_SHUTOFF  : "shut off",
		libvirt.VIR_DOMAIN_CRASHED  : "crashed",
		libvirt.VIR_DOMAIN_NOSTATE  : "no state" }
	return state_names[dom.info()[0]]
$$;


ALTER FUNCTION api.get_libvirt_domain_state(sysuri text, syspassword text, domain text) OWNER TO postgres;

--
-- Name: get_libvirt_domains(text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_libvirt_domains(sysuri text, syspassword text) RETURNS SETOF libvirt.domain_data
    LANGUAGE plpython3u
    AS $$
	#!/usr/bin/python

	import libvirt
	import sys

	def request_credentials(credentials, data):
		for credential in credentials:
			if credential[0] == libvirt.VIR_CRED_AUTHNAME:
				#credential[4] = sysuser
				return 0
			elif credential[0] == libvirt.VIR_CRED_NOECHOPROMPT:
				credential[4] = syspassword
			else:
				return -1

		return 0

	auth = [[libvirt.VIR_CRED_AUTHNAME, libvirt.VIR_CRED_NOECHOPROMPT], request_credentials, None]
	if syspassword == None:
		conn = libvirt.open(sysuri)
	else:
		conn = libvirt.openAuth(sysuri, auth, 0)

	if conn == None:
		sys.exit("Unable to connect")
	
	state_names = { libvirt.VIR_DOMAIN_RUNNING  : "running",
		libvirt.VIR_DOMAIN_BLOCKED  : "idle",
		libvirt.VIR_DOMAIN_PAUSED   : "paused",
		libvirt.VIR_DOMAIN_SHUTDOWN : "in shutdown",
		libvirt.VIR_DOMAIN_SHUTOFF  : "shut off",
		libvirt.VIR_DOMAIN_CRASHED  : "crashed",
		libvirt.VIR_DOMAIN_NOSTATE  : "no state" }

	domNames = ()
	for domID in conn.listDomainsID():
		domain = conn.lookupByID(domID)
		domNames += ([domain.name(), state_names[domain.info()[0]], domain.XMLDesc(0)],)

	for dom in conn.listDefinedDomains():
		domain = conn.lookupByName(dom)
		domNames += ([domain.name(), state_names[domain.info()[0]], domain.XMLDesc(0)],)
	
	conn.close()
	return domNames
$$;


ALTER FUNCTION api.get_libvirt_domains(sysuri text, syspassword text) OWNER TO postgres;

--
-- Name: get_libvirt_platform(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_libvirt_platform(input_name text) RETURNS SETOF libvirt.platforms
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "libvirt"."platforms" WHERE "platform_name" = input_name);
	END;
$$;


ALTER FUNCTION api.get_libvirt_platform(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_libvirt_platform(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_libvirt_platform(input_name text) IS 'Get a libvirt platform';


--
-- Name: get_local_user_level(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_local_user_level(input_user text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_user = 'root' THEN
			RETURN 'admin';
		END IF;

		IF input_user IN (SELECT "user" FROM api.get_group_members(api.get_site_configuration('DEFAULT_LOCAL_ADMIN_GROUP'))) THEN
			RETURN 'ADMIN';
		END IF;

		IF input_user IN (SELECT "user" FROM "management"."group_members" JOIN "management"."groups" ON "management"."groups"."group" = "management"."group_members"."group" WHERE "management"."groups"."privilege" = 'USER') THEN
			RETURN 'USER';
		END IF;

		IF input_user IN (SELECT "user" FROM "management"."group_members" JOIN "management"."groups" ON "management"."groups"."group" = "management"."group_members"."group" WHERE "management"."groups"."privilege" = 'PROGRAM') THEN
			RETURN 'PROGRAM';
		END IF;
		
		IF input_user IN (SELECT "user" FROM api.get_group_members(api.get_site_configuration('DEFAULT_LOCAL_USER_GROUP'))) THEN
			RETURN 'USER';
		END IF;
		
		RETURN 'NONE';
	END;
$$;


ALTER FUNCTION api.get_local_user_level(input_user text) OWNER TO starrs;

--
-- Name: FUNCTION get_local_user_level(input_user text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_local_user_level(input_user text) IS 'Get the users privilege level based on local tables';


--
-- Name: get_network_snmp(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_network_snmp(input_system_name text) RETURNS SETOF network.snmp
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system_name) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to get SNMP credentials denied: You are not owner or admin';
			END IF;
		END IF;
		
		-- Return
		RETURN QUERY (SELECT * FROM "network"."snmp" WHERE "system_name" = input_system_name);
	END;
$$;


ALTER FUNCTION api.get_network_snmp(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_network_snmp(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_network_snmp(input_system_name text) IS 'Get SNMP connection information for a system';


--
-- Name: get_network_switchport(text, integer); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_network_switchport(text, integer) RETURNS SETOF network.switchports
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	
	# Input parameters
	my $systemName = shift(@_);
	my $ifIndex = shift(@_);
	
	# Connection Details
	my $snmpInfo = spi_exec_query("SELECT ro_community,address FROM network.snmp WHERE system_name = '$systemName'");
	my $host = $snmpInfo->{rows}[0]->{address};
	my $community = $snmpInfo->{rows}[0]->{ro_community};
	
	# Date
	my $date = spi_exec_query("SELECT localtimestamp(0)");
	$date = $date->{rows}[0]->{timestamp};
	my $user = spi_exec_query("SELECT api.get_current_user()");
	$user = $user->{rows}[0]->{get_current_user};
	
	# OIDs
	my $OID_ifName = ".1.3.6.1.2.1.31.1.1.1.1.$ifIndex";
	my $OID_ifDesc = ".1.3.6.1.2.1.2.2.1.2.$ifIndex";
	my $OID_ifAlias = ".1.3.6.1.2.1.31.1.1.1.18.$ifIndex";
	my $OID_ifOperStatus = ".1.3.6.1.2.1.2.2.1.8.$ifIndex";
	my $OID_ifAdminStatus = ".1.3.6.1.2.1.2.2.1.7.$ifIndex";
	my $OID_vmVlan = ".1.3.6.1.4.1.9.9.68.1.2.2.1.2.$ifIndex";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$host",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}
	
	# Data
	my $result = $session->get_request(
		-varbindlist => [ $OID_ifName, $OID_ifDesc, $OID_ifAlias, $OID_ifOperStatus, $OID_ifAdminStatus ]
	);
	
	# Check for errors
	if(!defined($result)) {
		die $session->error();
	}

	my $vlanResult = $session->get_request(
		-varbindlist => [ $OID_vmVlan ]
	);
	
	# Gracefully disconnect
	$session->close();
	
	# Deal with results
	if(!$vlanResult->{$OID_vmVlan}) { $result->{$OID_vmVlan} = undef; } else { $result->{$OID_vmVlan} = $vlanResult->{$OID_vmVlan}; }
	if($result->{$OID_ifAlias} eq 'noSuchInstance') { $result->{$OID_ifAlias} = undef; }
	if($result->{$OID_ifOperStatus}-1 == 0) { $result->{$OID_ifOperStatus} = 1; } else { $result->{$OID_ifOperStatus} = 0; }
	if($result->{$OID_ifAdminStatus}-1 == 0) { $result->{$OID_ifAdminStatus} = 1; } else { $result->{$OID_ifAdminStatus} = 0; }
	
	# Return
	return_next({system_name=>$systemName, name=>$result->{$OID_ifName}, desc=>$result->{$OID_ifDesc}, ifindex=>$ifIndex, alias=>$result->{$OID_ifAlias}, admin_state=>$result->{$OID_ifAdminStatus}, oper_state=>$result->{$OID_ifOperStatus}, vlan=>$result->{$OID_vmVlan},date_created=>$date, date_modified=>$date, last_modifier=>$user});
	return undef;
$_$;


ALTER FUNCTION api.get_network_switchport(text, integer) OWNER TO postgres;

--
-- Name: FUNCTION get_network_switchport(text, integer); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_network_switchport(text, integer) IS 'Get information on a specific switchport';


--
-- Name: get_network_switchports(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_network_switchports(text) RETURNS SETOF integer
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	
	# Input parameters
	my $systemName = shift(@_);
	
	# Connection Details
	my $snmpInfo = spi_exec_query("SELECT ro_community,address FROM network.snmp WHERE system_name = '$systemName'");
	my $host = $snmpInfo->{rows}[0]->{address};
	my $community = $snmpInfo->{rows}[0]->{ro_community};
	
	# OIDs
	my $OID_ifName = ".1.3.6.1.2.1.31.1.1.1.1";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$host",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}
	
	# Data
	my $ifList = $session->get_table(-baseoid => $OID_ifName);
	
	# Check for errors
	if(!defined($ifList)) {
		die $session->error();
	}
	
	# Deal with results
	while ( my ($ifIndex, $ifName) = each(%$ifList)) {
		$ifIndex =~ s/$OID_ifName\.//;
		return_next($ifIndex);
	}
	
	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;
$_$;


ALTER FUNCTION api.get_network_switchports(text) OWNER TO postgres;

--
-- Name: FUNCTION get_network_switchports(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_network_switchports(text) IS 'Get a list of all switchport indexes on a system';


--
-- Name: get_operating_systems(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_operating_systems() RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "name" FROM "systems"."os" ORDER BY "name" ASC);
	END;
$$;


ALTER FUNCTION api.get_operating_systems() OWNER TO starrs;

--
-- Name: FUNCTION get_operating_systems(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_operating_systems() IS 'Get a list of all available system types';


--
-- Name: get_os_distribution(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_os_distribution() RETURNS SETOF systems.os_distribution
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY(SELECT "os_name",count("os_name")::integer,round(count("os_name")::numeric/(SELECT count(*)::numeric FROM "systems"."systems")*100,0)::integer AS "percentage"
		FROM "systems"."systems" 
		JOIN "systems"."os" ON "systems"."systems"."os_name" = "systems"."os"."name" 
		GROUP BY "os_name"
		ORDER BY count("os_name") DESC);
	END;
$$;


ALTER FUNCTION api.get_os_distribution() OWNER TO starrs;

--
-- Name: FUNCTION get_os_distribution(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_os_distribution() IS 'Get fun statistics on registered operating systems';


--
-- Name: get_os_family_distribution(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_os_family_distribution() RETURNS SETOF systems.os_family_distribution
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY(SELECT "family",count("family")::integer,round(count("family")::numeric/(SELECT count(*)::numeric FROM "systems"."systems")*100,0)::integer AS "percentage"
		FROM "systems"."systems" 
		JOIN "systems"."os" ON "systems"."systems"."os_name" = "systems"."os"."name" 
		GROUP BY "family"
		ORDER BY count("family") DESC);
	END;
$$;


ALTER FUNCTION api.get_os_family_distribution() OWNER TO starrs;

--
-- Name: FUNCTION get_os_family_distribution(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_os_family_distribution() IS 'Get fun statistics on registered operating system families';


--
-- Name: get_owned_interface_addresses(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_owned_interface_addresses(input_owner text) RETURNS SETOF systems.interface_addresses
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_owner IS NULL THEN
			RETURN QUERY (SELECT * FROM "systems"."interface_addresses");
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."interface_addresses" WHERE api.get_interface_address_owner("address") = input_owner);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_owned_interface_addresses(input_owner text) OWNER TO starrs;

--
-- Name: FUNCTION get_owned_interface_addresses(input_owner text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_owned_interface_addresses(input_owner text) IS 'Get all interface address data for all addresses owned by a given user';


--
-- Name: get_platforms(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_platforms() RETURNS SETOF systems.platforms
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."platforms" ORDER BY CASE WHEN "platform_name" = 'Custom' THEN 1 ELSE 2 END);
	END;
$$;


ALTER FUNCTION api.get_platforms() OWNER TO starrs;

--
-- Name: FUNCTION get_platforms(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_platforms() IS 'Get information on all system platforms';


--
-- Name: get_range_addresses(inet, inet); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_range_addresses(inet, inet) RETURNS SETOF inet
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Net::IP;
	use Net::IP qw(:PROC);
	use feature 'switch';

	# Define range
	my $range = new Net::IP ("$_[0] - $_[1]");
	my @addresses;

	# Loop through range
	while ($range) 
	{
		push(@addresses, ip_compress_address($range->ip(), 6));
		$range++;
	}

	# Done
	return \@addresses;
$_X$;


ALTER FUNCTION api.get_range_addresses(inet, inet) OWNER TO postgres;

--
-- Name: FUNCTION get_range_addresses(inet, inet); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_range_addresses(inet, inet) IS 'return a list of all addresses within a given range';


--
-- Name: get_range_groups(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_range_groups(input_name text) RETURNS SETOF management.groups
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY (SELECT * FROM "management"."groups" WHERE "group" IN (SELECT "group_name" FROM "ip"."range_groups" WHERE "range_name" = input_name) ORDER BY "group");
    END;
$$;


ALTER FUNCTION api.get_range_groups(input_name text) OWNER TO starrs;

--
-- Name: get_range_top_users(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_range_top_users(input_name text) RETURNS TABLE("user" text, count integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY(
			 SELECT 
			 	api.get_interface_address_owner(address),
			 	count(api.get_interface_address_owner(address))::integer
			 FROM
			 	systems.interface_addresses
			 WHERE api.get_address_range(address) = input_name
			 GROUP BY api.get_interface_address_owner(address)
			 ORDER BY count(api.get_interface_address_owner(address))
			 DESC limit 10
		);
	END;
$$;


ALTER FUNCTION api.get_range_top_users(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_range_top_users(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_range_top_users(input_name text) IS 'Get the top 10 users of range addresses';


--
-- Name: get_range_utilization(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_range_utilization(input_range text) RETURNS TABLE(inuse integer, free integer, total integer)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (
			SELECT COUNT("systems"."interface_addresses"."address")::integer AS "inuse",
			(api.get_ip_range_total(input_range) - COUNT("systems"."interface_addresses"."address"))::integer AS "free",
			api.get_ip_range_total(input_range)::integer AS "total"
			FROM "systems"."interface_addresses" 
			WHERE api.get_address_range("address") = input_range);
	END;
$$;


ALTER FUNCTION api.get_range_utilization(input_range text) OWNER TO starrs;

--
-- Name: FUNCTION get_range_utilization(input_range text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_range_utilization(input_range text) IS 'Get statistics on range utilization';


--
-- Name: get_record_types(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_record_types() RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "type" FROM "dns"."types" ORDER BY "type" ASC);
	END;
$$;


ALTER FUNCTION api.get_record_types() OWNER TO starrs;

--
-- Name: FUNCTION get_record_types(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_record_types() IS 'Get all of the valid DNS types for this application';


--
-- Name: get_reverse_domain(inet); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_reverse_domain(inet) RETURNS text
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Net::IP;
	use Net::IP qw(:PROC);

	# Return the rdns string for nsupdate from the given address. Automagically figures out IPv4 and IPv6.
	my $reverse_domain = new Net::IP ($_[0])->reverse_ip() or die (Net::IP::Error());
	$reverse_domain =~ s/\.$//;
	return $reverse_domain;

$_X$;


ALTER FUNCTION api.get_reverse_domain(inet) OWNER TO postgres;

--
-- Name: FUNCTION get_reverse_domain(inet); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_reverse_domain(inet) IS 'Use a convenient Perl module to generate and return the RDNS record for a given address';


--
-- Name: get_search_data(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_search_data() RETURNS SETOF management.search_data
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT
	"systems"."systems"."datacenter",
	(SELECT "zone" FROM "ip"."ranges" WHERE "name" =  "api"."get_address_range"("systems"."interface_addresses"."address")) AS "availability_zone",
	"systems"."systems"."system_name",
	"systems"."systems"."location",
	"systems"."systems"."asset",
	"systems"."systems"."group",
	"systems"."systems"."platform_name",
	"systems"."interfaces"."mac",
	"systems"."interface_addresses"."address",
	"systems"."interface_addresses"."config",
	"systems"."systems"."owner" AS "system_owner",
	"systems"."systems"."last_modifier" AS "system_last_modifier",
	"api"."get_address_range"("systems"."interface_addresses"."address") AS "range",
	"dns"."a"."hostname",
	"dns"."cname"."alias",
	"dns"."srv"."alias",
	"dns"."a"."zone",
	"dns"."a"."owner" AS "dns_owner",
	"dns"."a"."last_modifier" AS "dns_last_modifier"
FROM 	"systems"."systems"
LEFT JOIN	"systems"."interfaces" ON "systems"."interfaces"."system_name" = "systems"."systems"."system_name"
LEFT JOIN	"systems"."interface_addresses" ON "systems"."interface_addresses"."mac" = "systems"."interfaces"."mac"
LEFT JOIN	"dns"."a" ON "dns"."a"."address" = "systems"."interface_addresses"."address"
LEFT JOIN	"dns"."cname" ON "dns"."cname"."address" = "systems"."interface_addresses"."address"
LEFT JOIN	"dns"."srv" ON "dns"."srv"."address" = "systems"."interface_addresses"."address"
ORDER BY "systems"."interface_addresses"."address","systems"."interfaces"."mac");
	END;
$$;


ALTER FUNCTION api.get_search_data() OWNER TO starrs;

--
-- Name: FUNCTION get_search_data(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_search_data() IS 'Get search data to parse';


--
-- Name: get_site_configuration_all(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_site_configuration_all() RETURNS SETOF management.configuration
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "management"."configuration" ORDER BY "option" ASC);
	END;
$$;


ALTER FUNCTION api.get_site_configuration_all() OWNER TO starrs;

--
-- Name: FUNCTION get_site_configuration_all(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_site_configuration_all() IS 'Get all site configuration directives';


--
-- Name: get_subnet_addresses(cidr); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_subnet_addresses(cidr) RETURNS SETOF inet
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Net::IP;
	use Net::IP qw(:PROC);
	use feature 'switch';

	# Define some basic information about the network.
	my $subnet = new Net::IP ($_[0]) or die (Net::IP::Error());
	my $broadcast_address = $subnet->last_ip();
	my $network_address = $subnet->ip();
	my $version = ip_get_version($network_address);

	# Create an object of the range between the network address and the broadcast address.
	my $range = new Net::IP ("$network_address - $broadcast_address");
	my @addresses;

	# Given/When is the new Switch. Perform different operations for IPv4 and IPv6. 
	given ($version) {
		when (/4/) { 
			while (++$range) {
				# While they technically work, .255 and .0 addresses in multi-range wide networks
				# can cause confusion and possibly device problems. Well just avoid them alltogether.
				if($range->ip() !~ m/\.0$|\.255$/) {
					push(@addresses, $range->ip());
				}
			}
		}
		when (/6/) { 
			while (++$range) {
				push(@addresses, ip_compress_address($range->ip(), 6));
			}
		}
		default { die "Unable to generate\n"; }
	}

	# Done
	return \@addresses;
$_X$;


ALTER FUNCTION api.get_subnet_addresses(cidr) OWNER TO postgres;

--
-- Name: FUNCTION get_subnet_addresses(cidr); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_subnet_addresses(cidr) IS 'Given a subnet, return an array of all acceptable addresses within that subnet.';


--
-- Name: get_subnet_utilization(cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_subnet_utilization(input_subnet cidr) RETURNS TABLE(inuse integer, free integer, total integer)
    LANGUAGE plpgsql
    AS $$
	DECLARE
		addrcount INTEGER;
	BEGIN
		-- Total
		SELECT COUNT("address")::integer INTO addrcount
		FROM "ip"."addresses" WHERE "address" << input_subnet;
		
		RETURN QUERY (
			SELECT COUNT("systems"."interface_addresses"."address"):: integer AS "inuse",
			addrcount - COUNT("systems"."interface_addresses"."address"):: integer as "free",
			addrcount AS "total"
			FROM "systems"."interface_addresses"
			WHERE "address" << input_subnet
		);
	END;
$$;


ALTER FUNCTION api.get_subnet_utilization(input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION get_subnet_utilization(input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_subnet_utilization(input_subnet cidr) IS 'Get statistics on subnet utilization';


--
-- Name: get_switchview_bridgeportid(inet, text, integer); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_bridgeportid(inet, text, integer) RETURNS TABLE(camportinstanceid text, bridgeportid integer)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $dot1dTpFdbPort = ".1.3.6.1.2.1.17.4.3.1.2";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";
	my $vlan = shift(@_) or die "Unable to get VLANID";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community\@$vlan",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $bridgePortList = $session->get_table(-baseoid => $dot1dTpFdbPort);

	# Do something for each item of the list
	while ( my ($camPortInstanceID, $bridgePortID) = each(%$bridgePortList)) {
		$camPortInstanceID =~ s/$dot1dTpFdbPort//;
		return_next({camportinstanceid=>$camPortInstanceID, bridgeportid=>$bridgePortID});
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;
$_$;


ALTER FUNCTION api.get_switchview_bridgeportid(inet, text, integer) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_bridgeportid(inet, text, integer); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_bridgeportid(inet, text, integer) IS 'Get a mapping of CAM instanceIDs and bridgeIDs';


--
-- Name: get_switchview_cam(inet, text, integer); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_cam(inet, text, integer) RETURNS TABLE(camportinstanceid text, mac macaddr)
    LANGUAGE plperlu
    AS $_X$
	#!/usr/bin/perl -w 

	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $dot1dTpFdbAddress = ".1.3.6.1.2.1.17.4.3.1.1";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";
	my $vlan = shift(@_) or die "Unable to get VLANID";

	# Subroutine to format a MAC address to something nice
	sub format_raw_mac {
		my $mac = $_[0];
		# Get rid of the hex identifier
		$mac =~ s/^0x//;

		# Make groups of two characters
		$mac =~ s/(.{2})/$1:/gg;

		# Remove the trailing : left by the previous function
		$mac =~ s/\:$//;

		# Spit it back out
		return $mac;
	}

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community\@$vlan",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $camList = $session->get_table(-baseoid => $dot1dTpFdbAddress);

	# Do something for each item of the list
	while ( my ($camPortInstanceID, $macaddr) = each(%$camList)) {
		$camPortInstanceID =~ s/$dot1dTpFdbAddress//;
		
		# Sometimes there are non-valid MAC addresses in the CAM.
		if($macaddr =~ m/[0-9a-fA-F]{12}/) {
			$macaddr = format_raw_mac($macaddr);
			#print "InstanceID: $camPortInstanceID - MAC: $macaddr\n";
			return_next({camportinstanceid=>$camPortInstanceID,mac=>$macaddr});
		}
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;

$_X$;


ALTER FUNCTION api.get_switchview_cam(inet, text, integer) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_cam(inet, text, integer); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_cam(inet, text, integer) IS 'Get the CAM/MAC table from a device on a certain VLAN';


--
-- Name: get_switchview_device_cam(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_switchview_device_cam(input_system text) RETURNS SETOF network.cam
    LANGUAGE plpgsql
    AS $$
	DECLARE
		Vlans RECORD;
		CamData RECORD;
		input_host INET;
		input_community TEXT;
	BEGIN
		SELECT get_system_primary_address::inet INTO input_host FROM api.get_system_primary_address(input_system);
		IF input_host IS NULL THEN
			RAISE EXCEPTION 'Unable to find address for system %',input_system;
		END IF;
		SELECT ro_community INTO input_community FROM api.get_network_snmp(input_system);
		IF input_community IS NULL THEN
			RAISE EXCEPTION 'Unable to find SNMP settings for system %',input_system;
		END IF;

		FOR Vlans IN (SELECT "vlan" FROM "network"."vlans" WHERE "datacenter" = (SELECT "datacenter" FROM "systems"."systems" WHERE "system_name" = input_system) AND "vlan" IS NOT NULL GROUP BY "vlan" ORDER BY "vlan") LOOP
			FOR CamData IN (
				SELECT mac,portindex.ifindex,Vlans.vlan FROM api.get_switchview_cam(input_host,input_community,vlans.vlan) AS "cam"
				JOIN api.get_switchview_bridgeportid(input_host,input_community,vlans.vlan) AS "bridgeportid"
				ON bridgeportid.camportinstanceid = cam.camportinstanceid
				JOIN api.get_switchview_portindex(input_host,input_community,vlans.vlan) AS "portindex"
				ON bridgeportid.bridgeportid = portindex.bridgeportid
			) LOOP
				RETURN NEXT CamData;
			END LOOP;
		END LOOP;
		RETURN;
	END;
$$;


ALTER FUNCTION api.get_switchview_device_cam(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION get_switchview_device_cam(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_switchview_device_cam(input_system text) IS 'Get all CAM data from a particular device';


--
-- Name: get_switchview_device_switchports(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_switchview_device_switchports(input_system text) RETURNS SETOF network.switchports
    LANGUAGE plpgsql
    AS $$
	DECLARE
		system_address INET;
          system_community TEXT;
	BEGIN
		SELECT get_system_primary_address::inet INTO system_address FROM api.get_system_primary_address(input_system);
          IF system_address IS NULL THEN
               RAISE EXCEPTION 'Unable to find address for system %',input_system;
          END IF;
          SELECT ro_community INTO system_community FROM api.get_network_snmp(input_system);
          IF system_community IS NULL THEN
               RAISE EXCEPTION 'Unable to find SNMP settings for system %',input_system;
          END IF;

		RETURN QUERY (
			SELECT "ifadminstatus","ifoperstatus","ifname","ifdesc","ifalias"
			FROM api.get_switchview_port_names(system_address, system_community) AS "namedata"
			JOIN api.get_switchview_port_adminstatus(system_address, system_community) AS "admindata"
			ON "admindata"."ifindex" = "namedata"."ifindex"
			JOIN api.get_switchview_port_operstatus(system_address, system_community) AS "operdata"
			ON "operdata"."ifindex" = "namedata"."ifindex"
			JOIN api.get_switchview_port_descriptions(system_address, system_community) AS "descdata"
			ON "descdata"."ifindex" = "namedata"."ifindex"
		);
	END;
$$;


ALTER FUNCTION api.get_switchview_device_switchports(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION get_switchview_device_switchports(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_switchview_device_switchports(input_system text) IS 'Get data on all switchports on a system';


--
-- Name: get_switchview_neighbors(inet, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_neighbors(inet, text) RETURNS TABLE("localifIndex" integer, remoteifdesc text, remotehostname text)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;
	use 5.10.0;

	# Define OIDs
	my $cdpCacheEntry = "1.3.6.1.4.1.9.9.23.1.2.1.1";
	my $cdpCacheIfIndex = "1";
	my $cdpCacheDeviceId = "6";
	my $cdpCacheDevicePort = "7";
	my $cdpCachePlatform = "8";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";

	# Data containers
	my %remoteHosts;
	my %remotePorts;
	my %remotePlatforms;
	my %localPorts;

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		print $error;
		exit 1;
	}

	# Get a list of all data
	my $neighborList = $session->get_table(-baseoid => $cdpCacheEntry);

	# Do something for each item of the list
	while ( my ($id, $value) = each(%$neighborList)) {
		$id=~ s/$cdpCacheEntry\.//;
		
		if($id =~ m/^($cdpCacheDeviceId|$cdpCacheDevicePort|$cdpCachePlatform|$cdpCacheIfIndex)\./) {
			my @cdpEntry = split(/\./,$id);

			given ($cdpEntry[0]) {
				when(/$cdpCacheDeviceId/) {
					$remoteHosts{$cdpEntry[1]} = $value;
				}
				when(/$cdpCacheDevicePort/) {
					$remotePorts{$cdpEntry[1]} = $value;
				}
				when(/$cdpCachePlatform/) {
					$remotePlatforms{$cdpEntry[1]} = $value;
				}
			}
		}
	}

	foreach my $ifIndex (keys(%remoteHosts)) {
		return_next({localifIndex=>$ifIndex,remoteifdesc=>$remotePorts{$ifIndex}, remotehostname=>$remoteHosts{$ifIndex}});
	}

	# Gracefully disconnect
	$session->close();

	# Return
	return undef;

$_$;


ALTER FUNCTION api.get_switchview_neighbors(inet, text) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_neighbors(inet, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_neighbors(inet, text) IS 'Get the CDP table from a device to see who it is attached to';


--
-- Name: get_switchview_port_adminstatus(inet, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_port_adminstatus(inet, text) RETURNS TABLE(ifindex integer, ifadminstatus boolean)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $ifAdminStatus = ".1.3.6.1.2.1.2.2.1.7";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $portStates = $session->get_table(-baseoid => $ifAdminStatus);

	# Do something for each item of the list
	while ( my ($portIndex, $portState) = each(%$portStates)) {
		$portIndex =~ s/$ifAdminStatus\.//;
		if($portState-1 == 0) {
			# Then its up
			$portState = 1;
		}
		else {
			# Then its down
			$portState = 0;
		}
		return_next({ifindex=>$portIndex, ifadminstatus=>$portState});
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;
	
$_$;


ALTER FUNCTION api.get_switchview_port_adminstatus(inet, text) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_port_adminstatus(inet, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_port_adminstatus(inet, text) IS 'Map ifindexes to port administrative status';


--
-- Name: get_switchview_port_descriptions(inet, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_port_descriptions(inet, text) RETURNS TABLE(ifindex integer, ifalias text)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $ifAlias = "1.3.6.1.2.1.31.1.1.1.18";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $portAliases = $session->get_table(-baseoid => $ifAlias);

	# Do something for each item of the list
	while ( my ($portIndex, $portAlias) = each(%$portAliases)) {
		$portIndex =~ s/$ifAlias\.//;
		return_next({ifindex=>$portIndex, ifalias=>$portAlias});
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;
	
$_$;


ALTER FUNCTION api.get_switchview_port_descriptions(inet, text) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_port_descriptions(inet, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_port_descriptions(inet, text) IS 'Map ifindexes to port descriptions (or aliases in Cisco-land)';


--
-- Name: get_switchview_port_names(inet, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_port_names(inet, text) RETURNS TABLE(ifindex integer, ifname text, ifdesc text)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $ifName = ".1.3.6.1.2.1.31.1.1.1.1";
	my $ifDesc = ".1.3.6.1.2.1.2.2.1.2";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";
	my %ports;

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $portNameList = $session->get_table(-baseoid => $ifName);
	my $portDescList = $session->get_table(-baseoid => $ifDesc);

	# Do something for each item of the list
	while ( my ($portIndex, $portName) = each(%$portNameList)) {
		$portIndex =~ s/$ifName\.//;
		$ports{$portIndex}{'ifName'} = $portName;
	}
	while ( my ($portIndex, $portDesc) = each(%$portDescList)) {
		$portIndex =~ s/$ifDesc\.//;
		$ports{$portIndex}{'ifDesc'} = $portDesc;
	}
	foreach my $key (keys(%ports)) {
		return_next({ifindex=>$key, ifname=>$ports{$key}{'ifName'}, ifdesc=>$ports{$key}{'ifDesc'}});
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;
	
$_$;


ALTER FUNCTION api.get_switchview_port_names(inet, text) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_port_names(inet, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_port_names(inet, text) IS 'Map ifindexes to port names';


--
-- Name: get_switchview_port_operstatus(inet, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_port_operstatus(inet, text) RETURNS TABLE(ifindex integer, ifoperstatus boolean)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $ifOperStatus = ".1.3.6.1.2.1.2.2.1.8";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community",
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $portStates = $session->get_table(-baseoid => $ifOperStatus);

	# Do something for each item of the list
	while ( my ($portIndex, $portState) = each(%$portStates)) {
		$portIndex =~ s/$ifOperStatus\.//;
		if($portState-1 == 0) {
			# Then its up
			$portState = 1;
		}
		else {
			# Then its down
			$portState = 0;
		}
		return_next({ifindex=>$portIndex, ifoperstatus=>$portState});
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;
	
$_$;


ALTER FUNCTION api.get_switchview_port_operstatus(inet, text) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_port_operstatus(inet, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_port_operstatus(inet, text) IS 'Map ifindexes to port operational status';


--
-- Name: get_switchview_portindex(inet, text, integer); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.get_switchview_portindex(inet, text, integer) RETURNS TABLE(bridgeportid integer, ifindex integer)
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	use Socket;

	# Define OIDs
	my $dot1dBasePortIfIndex = ".1.3.6.1.2.1.17.1.4.1.2";

	# Needed Variables
	my $hostname = shift(@_) or die "Unable to get host";
	my $community = shift(@_) or die "Unable to get READ community";
	my $vlan = shift(@_) or die "Unable to get VLAN";

	# Establish session
	my ($session,$error) = Net::SNMP->session (
		-hostname => "$hostname",
		-community => "$community\@$vlan"
	);

	# Check that it did not error
	if (!defined($session)) {
		die $error;
	}

	# Get a list of all data
	my $portIndexList = $session->get_table(-baseoid => $dot1dBasePortIfIndex);

	# Do something for each item of the list
	while ( my ($bridgePortID, $portIndex) = each(%$portIndexList)) {
		$bridgePortID =~ s/$dot1dBasePortIfIndex\.//;
		return_next({bridgeportid=>$bridgePortID, ifindex=>$portIndex});
	}

	# Gracefully disconnect
	$session->close();
	
	# Return
	return undef;

$_$;


ALTER FUNCTION api.get_switchview_portindex(inet, text, integer) OWNER TO postgres;

--
-- Name: FUNCTION get_switchview_portindex(inet, text, integer); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.get_switchview_portindex(inet, text, integer) IS 'Get a mapping of port indexes to bridge indexes';


--
-- Name: get_system(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system(input_system_name text) RETURNS SETOF systems.systems
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."systems" WHERE "system_name" = input_system_name);
	END;
$$;


ALTER FUNCTION api.get_system(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_system(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system(input_system_name text) IS 'Get a single system';


--
-- Name: architectures; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.architectures (
    architecture text NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE systems.architectures OWNER TO starrs;

--
-- Name: TABLE architectures; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.architectures IS 'The CPU architecture of a platform';


--
-- Name: get_system_architectures(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_architectures() RETURNS SETOF systems.architectures
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."architectures" ORDER BY CASE WHEN "architecture" = 'i386' THEN 1 ELSE 2 END);
	END;
$$;


ALTER FUNCTION api.get_system_architectures() OWNER TO starrs;

--
-- Name: FUNCTION get_system_architectures(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_architectures() IS 'Get all the available system architectures';


--
-- Name: get_system_cam(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_cam(input_system_name text) RETURNS SETOF network.cam_cache
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system_name) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to get CAM denied: You are not owner or admin';
			END IF;
		END IF;

		RETURN QUERY (SELECT * FROM "network"."cam_cache" WHERE "system_name" = input_system_name ORDER BY "vlan","ifindex","mac");
	END;
$$;


ALTER FUNCTION api.get_system_cam(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_system_cam(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_cam(input_system_name text) IS 'Get the latest CAM data from the cache';


--
-- Name: get_system_interface_address(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_interface_address(input_address inet) RETURNS SETOF systems.interface_addresses
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."interface_addresses" WHERE "address" = input_address);
	END;
$$;


ALTER FUNCTION api.get_system_interface_address(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION get_system_interface_address(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_interface_address(input_address inet) IS 'Get all interface address data for an address';


--
-- Name: get_system_interface_addresses(macaddr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_interface_addresses(input_mac macaddr) RETURNS SETOF systems.interface_addresses
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_mac IS NULL THEN
			RETURN QUERY (SELECT * FROM "systems"."interface_addresses" ORDER BY family(address),address);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."interface_addresses" WHERE "mac" = input_mac ORDER BY family(address),address ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_system_interface_addresses(input_mac macaddr) OWNER TO starrs;

--
-- Name: FUNCTION get_system_interface_addresses(input_mac macaddr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_interface_addresses(input_mac macaddr) IS 'Get all interface addresses on a specified MAC';


--
-- Name: get_system_interface_data(macaddr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_interface_data(input_mac macaddr) RETURNS SETOF systems.interfaces
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."interfaces" WHERE "mac" = input_mac);
	END;
$$;


ALTER FUNCTION api.get_system_interface_data(input_mac macaddr) OWNER TO starrs;

--
-- Name: FUNCTION get_system_interface_data(input_mac macaddr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_interface_data(input_mac macaddr) IS 'Get all interface information on a system for a specific interface';


--
-- Name: get_system_interfaces(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_interfaces(input_system_name text) RETURNS SETOF systems.interfaces
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_system_name IS NULL THEN
			RETURN QUERY (SELECT * FROM "systems"."interfaces" ORDER BY mac);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."interfaces" WHERE "system_name" = input_system_name  ORDER BY mac);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_system_interfaces(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_system_interfaces(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_interfaces(input_system_name text) IS 'Get all interface information on a system';


--
-- Name: get_system_owner(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_owner(input_system text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system);
	END;
$$;


ALTER FUNCTION api.get_system_owner(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION get_system_owner(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_owner(input_system text) IS 'Easily get the owner of a system';


--
-- Name: get_system_permissions(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_permissions(input_system_name text) RETURNS TABLE(read boolean, write boolean)
    LANGUAGE plpgsql
    AS $$
	DECLARE
		read BOOLEAN;
		write BOOLEAN;
		sysowner TEXT;
		sysgroup TEXT;
	BEGIN
		SELECT "owner","group" INTO sysowner, sysgroup
		FROM "systems"."systems"
		WHERE "system_name" = input_system_name;

		IF sysowner IS NULL THEN
			RAISE EXCEPTION 'System % not found!',input_system_name;
		END IF;
		
		IF sysgroup IN (SELECT * FROM api.get_current_user_groups()) THEN
			IF api.get_current_user() IN (SELECT * FROM api.get_group_admins(sysgroup)) THEN
				read := TRUE;
				write := TRUE;
			ELSE
				read := TRUE;
				write := FALSE;
			END IF;
		ELSE
			read := TRUE;
			write := FALSE;
		END IF;

		IF sysowner = api.get_current_user() THEN
			read := TRUE;
			write := TRUE;
			
		END IF;

		IF api.get_current_user_level() ~* 'ADMIN' THEN
			read := TRUE;
			write := TRUE;
		END IF;
		RETURN QUERY (SELECT read, write);
	END;
$$;


ALTER FUNCTION api.get_system_permissions(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_system_permissions(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_permissions(input_system_name text) IS 'Get the current user permissions on a system';


--
-- Name: get_system_primary_address(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_primary_address(input_system_name text) RETURNS inet
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "address" FROM "systems"."systems" 
		JOIN "systems"."interfaces" ON "systems"."interfaces"."system_name" = "systems"."systems"."system_name"
		JOIN "systems"."interface_addresses" ON "systems"."interfaces"."mac" = "systems"."interface_addresses"."mac"
		WHERE "isprimary" = TRUE AND "systems"."systems"."system_name" = input_system_name
		ORDER BY "systems"."interfaces"."mac" DESC LIMIT 1);
	END;
$$;


ALTER FUNCTION api.get_system_primary_address(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION get_system_primary_address(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_primary_address(input_system_name text) IS 'Get the primary address of a system';


--
-- Name: get_system_switchports(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_switchports(input_system text) RETURNS SETOF network.switchports
    LANGUAGE plpgsql
    AS $$
	DECLARE
		IfIndexes RECORD;
		Ints network.switchports%rowtype;
	BEGIN
		FOR IfIndexes IN (SELECT * FROM api.get_network_switchports(input_system) ORDER BY get_network_switchports) LOOP
			--RETURN NEXT api.get_network_switchport(input_system, IfIndexes.get_network_switchports);
			SELECT * FROM api.get_network_switchport(input_system, IfIndexes.get_network_switchports) INTO Ints;
			RETURN NEXT Ints;
		END LOOP;
		RETURN;
	END;
$$;


ALTER FUNCTION api.get_system_switchports(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION get_system_switchports(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_switchports(input_system text) IS 'Get the most recent cached switchport data';


--
-- Name: device_types; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.device_types (
    type text NOT NULL,
    family text NOT NULL,
    CONSTRAINT device_types_family_check CHECK ((family ~ '^PC|Network$'::text))
);


ALTER TABLE systems.device_types OWNER TO starrs;

--
-- Name: TABLE device_types; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.device_types IS 'Computers are different than switches and routers, as they appear in the network overview.';


--
-- Name: get_system_types(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_system_types() RETURNS SETOF systems.device_types
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "systems"."device_types" ORDER BY "type");
	END;
$$;


ALTER FUNCTION api.get_system_types() OWNER TO starrs;

--
-- Name: FUNCTION get_system_types(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_system_types() IS 'Get a list of all available system types';


--
-- Name: get_systems(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_systems(input_username text) RETURNS SETOF systems.systems
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_username IS NULL THEN
			RETURN QUERY (SELECT * FROM "systems"."systems" ORDER BY lower("system_name") ASC);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."systems" WHERE "owner" = input_username  ORDER BY lower("system_name") ASC);
		END IF;
	END;
$$;


ALTER FUNCTION api.get_systems(input_username text) OWNER TO starrs;

--
-- Name: FUNCTION get_systems(input_username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_systems(input_username text) IS 'Get all system names owned by a given user';


--
-- Name: get_user_email(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_user_email(input_user text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		IF api.get_site_configuration('USER_PRIVILEGE_SOURCE') ~* '^ad$' THEN
			RETURN api.get_ad_user_email(input_user);
		ELSE
			RETURN input_user||'@'||api.get_site_configuration('EMAIL_DOMAIN');
		END IF;
	END;
$_$;


ALTER FUNCTION api.get_user_email(input_user text) OWNER TO starrs;

--
-- Name: FUNCTION get_user_email(input_user text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_user_email(input_user text) IS 'Get the email address of a user';


--
-- Name: get_user_groups(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_user_groups(input_user text) RETURNS SETOF management.groups
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT * FROM "management"."groups" WHERE "group" IN (
		SELECT "group" FROM "management"."group_members" WHERE "user" = input_user)
		ORDER BY "group"
		);
	END;
$$;


ALTER FUNCTION api.get_user_groups(input_user text) OWNER TO starrs;

--
-- Name: FUNCTION get_user_groups(input_user text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_user_groups(input_user text) IS 'Get all of the groups that a user belongs to';


--
-- Name: get_user_ranges(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_user_ranges(input_user text) RETURNS SETOF ip.ranges
    LANGUAGE plpgsql
    AS $$
	DECLARE
		UserGroups RECORD;
		GroupRanges RECORD;
		RangeData RECORD;
	BEGIN
		--IF api.get_current_user_level() ~* 'ADMIN' THEN
		--	RETURN QUERY (SELECT * FROM "ip"."ranges" ORDER BY "name");
		--END IF;

		FOR UserGroups IN (SELECT "group" FROM "management"."group_members" WHERE "user" = input_user) LOOP
			FOR RangeData IN (SELECT * FROM api.get_group_ranges(UserGroups."group")) LOOP
				RETURN NEXT RangeData;
			END LOOP;
		END LOOP;

		RETURN;
	END;
$$;


ALTER FUNCTION api.get_user_ranges(input_user text) OWNER TO starrs;

--
-- Name: get_vlans(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.get_vlans(input_datacenter text) RETURNS SETOF network.vlans
    LANGUAGE plpgsql
    AS $$
     BEGIN
          IF input_datacenter IS NULL THEN
               RETURN QUERY (SELECT * FROM "network"."vlans" ORDER BY "datacenter","vlan");
          ELSE
               RETURN QUERY (SELECT * FROM "network"."vlans" WHERE "datacenter" = input_datacenter ORDER BY "vlan");
          END IF;
     END;
$$;


ALTER FUNCTION api.get_vlans(input_datacenter text) OWNER TO starrs;

--
-- Name: FUNCTION get_vlans(input_datacenter text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.get_vlans(input_datacenter text) IS 'Get all or a systems vlans';


--
-- Name: initialize(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.initialize(input_username text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
		Level TEXT;
	BEGIN
		-- Get level
		IF api.get_site_configuration('USER_PRIVILEGE_SOURCE') ~* 'ldap' THEN
			SELECT api.get_ldap_user_level(input_username) INTO Level;
		ELSEIF api.get_site_configuration('USER_PRIVILEGE_SOURCE') ~* 'ad' THEN
			SELECT api.get_ad_user_level(input_username) INTO Level;
		ELSE
			SELECT api.get_local_user_level(input_username) INTO Level;
		END IF;

		IF Level='NONE' THEN
			RAISE EXCEPTION 'Could not identify "%".',input_username;
		END IF;

		-- Create privilege table
		DROP TABLE IF EXISTS "user_privileges";

		CREATE TEMPORARY TABLE "user_privileges"
		(username text NOT NULL,privilege text NOT NULL,
		allow boolean NOT NULL DEFAULT false);

		-- Populate privileges
		INSERT INTO "user_privileges" VALUES (input_username,'USERNAME',TRUE);
		INSERT INTO "user_privileges" VALUES (input_username,'ADMIN',FALSE);
		INSERT INTO "user_privileges" VALUES (input_username,'PROGRAM',FALSE);
		INSERT INTO "user_privileges" VALUES (input_username,'USER',FALSE);
		ALTER TABLE "user_privileges" ALTER COLUMN "username" SET DEFAULT api.get_current_user();

		-- Set level
		UPDATE "user_privileges" SET "allow" = TRUE WHERE "privilege" ~* Level;

		RETURN 'Greetings '||lower(Level)||'!';
	END;
$$;


ALTER FUNCTION api.initialize(input_username text) OWNER TO starrs;

--
-- Name: FUNCTION initialize(input_username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.initialize(input_username text) IS 'Setup user access to the database';


--
-- Name: ip_arp(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.ip_arp(input_address inet) RETURNS macaddr
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN (SELECT "mac" FROM "systems"."interface_addresses" WHERE "address" = input_address);
	END;
$$;


ALTER FUNCTION api.ip_arp(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION ip_arp(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.ip_arp(input_address inet) IS 'Get the MAC address assiciated with an IP address';


--
-- Name: ip_in_subnet(inet, cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.ip_in_subnet(input_address inet, input_subnet cidr) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_address << input_subnet THEN
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	END;
$$;


ALTER FUNCTION api.ip_in_subnet(input_address inet, input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION ip_in_subnet(input_address inet, input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.ip_in_subnet(input_address inet, input_subnet cidr) IS 'True or False if an address is contained within a given subnet';


--
-- Name: ip_is_dynamic(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.ip_is_dynamic(input_address inet) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF input_address << cidr((SELECT api.get_site_configuration('DYNAMIC_SUBNET'))) THEN
			RETURN TRUE;
		ELSE
			RETURN FALSE;
		END IF;
	END;
$$;


ALTER FUNCTION api.ip_is_dynamic(input_address inet) OWNER TO starrs;

--
-- Name: modify_availability_zone(text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_availability_zone(input_old_datacenter text, input_old_zone text, input_field text, input_new_value text) RETURNS SETOF systems.availability_zones
    LANGUAGE plpgsql
    AS $_$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to edit availability zone denied. You are not admin';
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'datacenter|zone|comment' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;
		
		-- Update record

		EXECUTE 'UPDATE "systems"."availability_zones" SET ' || quote_ident($3) || ' = $4, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "datacenter" = $1 AND "zone" = $2' 
		USING input_old_datacenter, input_old_zone, input_field, input_new_value;

		-- Done

		PERFORM api.syslog('modify_availability_zone:"'||input_old_datacenter||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "systems"."availability_zones" WHERE "datacenter" = input_old_datacenter AND "zone" = input_new_value);
		ELSEIF input_field ~* 'datacenter' THEN
			RETURN QUERY (SELECT * FROM "systems"."availability_zones" WHERE "datacenter" = input_new_value AND "zone" = input_old_zone);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."availability_zones" WHERE "datacenter" = input_old_datacenter AND "zone" = input_old_zone);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_availability_zone(input_old_datacenter text, input_old_zone text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_availability_zone(input_old_datacenter text, input_old_zone text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_availability_zone(input_old_datacenter text, input_old_zone text, input_field text, input_new_value text) IS 'modify a availability_zone';


--
-- Name: modify_datacenter(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_datacenter(input_old_name text, input_field text, input_new_value text) RETURNS SETOF systems.datacenters
    LANGUAGE plpgsql
    AS $_$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to edit address % denied. You are not admin';
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'datacenter|comment' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;
		
		-- Update record

		EXECUTE 'UPDATE "systems"."datacenters" SET ' || quote_ident($2) || ' = $3, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "datacenter" = $1' 
		USING input_old_name, input_field, input_new_value;

		-- Done

		PERFORM api.syslog('modify_datacenter:"'||input_old_name||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'datacenter' THEN
			RETURN QUERY (SELECT * FROM "systems"."datacenters" WHERE "datacenter" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."datacenters" WHERE "datacenter" = input_old_name);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_datacenter(input_old_name text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_datacenter(input_old_name text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_datacenter(input_old_name text, input_field text, input_new_value text) IS 'modify a datacenter';


--
-- Name: modify_dhcp_class(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dhcp_class(input_old_class text, input_field text, input_new_value text) RETURNS SETOF dhcp.classes
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to modify dhcp class denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Check allowed fields
		IF input_field !~* 'class|comment' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		-- Validate class name
		IF input_field !~* 'class' THEN
			input_new_value := api.validate_nospecial(input_new_value);
		END IF;

		-- Update record
		EXECUTE 'UPDATE "dhcp"."classes" SET ' || quote_ident($2) || ' = $3, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "class" = $1' 
		USING input_old_class, input_field, input_new_value;	

		-- Done
		PERFORM api.syslog('modify_dhcp_class:"'||input_old_class||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'class' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."classes" WHERE "class" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."classes" WHERE "class" = input_old_class);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dhcp_class(input_old_class text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dhcp_class(input_old_class text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dhcp_class(input_old_class text, input_field text, input_new_value text) IS 'Modify a field of a DHCP setting';


--
-- Name: modify_dhcp_class_option(text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dhcp_class_option(input_old_class text, input_old_option text, input_old_value text, input_field text, input_new_value text) RETURNS SETOF dhcp.class_options
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to modify dhcp class option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Check allowed fields
		IF input_field !~* 'class|option|value' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		-- Update record
		EXECUTE 'UPDATE "dhcp"."class_options" SET ' || quote_ident($4) || ' = $5, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "class" = $1 AND "option" = $2 AND "value" = $3' 
		USING input_old_class, input_old_option, input_old_value, input_field, input_new_value;

		-- Done
		PERFORM api.syslog('modify_dhcp_class_option:"'||input_old_class||'","'||input_old_option||'","'||input_old_value||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'class' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."class_options" 
			WHERE "class" = input_new_value AND "option" = input_old_option AND "value" = input_old_value);
		ELSIF input_field ~* 'option' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."class_options" 
			WHERE "class" = input_old_class AND "option" = input_new_value AND "value" = input_old_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."class_options" 
			WHERE "class" = input_old_class AND "option" = input_old_option AND "value" = input_new_value);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dhcp_class_option(input_old_class text, input_old_option text, input_old_value text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dhcp_class_option(input_old_class text, input_old_option text, input_old_value text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dhcp_class_option(input_old_class text, input_old_option text, input_old_value text, input_field text, input_new_value text) IS 'Modify a field of a DHCP class option';


--
-- Name: modify_dhcp_global_option(text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dhcp_global_option(input_old_option text, input_old_value text, input_field text, input_new_value text) RETURNS SETOF dhcp.global_options
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to modify dhcp global option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Check allowed fields
		IF input_field !~* 'option|value' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		-- Update record
		EXECUTE 'UPDATE "dhcp"."global_options" SET ' || quote_ident($3) || ' = $4, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "option" = $1 AND "value" = $2' 
		USING input_old_option, input_old_value, input_field, input_new_value;

		-- Done
		PERFORM api.syslog('modify_dhcp_global_option:"'||input_old_option||'","'||input_old_value||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'option' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."global_options" 
			WHERE "option" = input_new_value AND "value" = input_old_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."global_options" 
			WHERE "option" = input_old_option AND "value" = input_new_value);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dhcp_global_option(input_old_option text, input_old_value text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dhcp_global_option(input_old_option text, input_old_value text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dhcp_global_option(input_old_option text, input_old_value text, input_field text, input_new_value text) IS 'Modify a field of a DHCP global option';


--
-- Name: modify_dhcp_range_option(text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dhcp_range_option(input_old_range text, input_old_option text, input_old_value text, input_field text, input_new_value text) RETURNS SETOF dhcp.range_options
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to modify dhcp range option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Check allowed fields
		IF input_field !~* 'name|option|value' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;
		
		-- Check if range is marked for DHCP
		IF input_field ~* 'name' THEN
			IF (SELECT "use" FROM "ip"."ranges" WHERE "name" = input_new_value) !~* 'ROAM' THEN
				RAISE EXCEPTION 'Range % is not marked for DHCP configuration',input_new_value;
			END IF;
		END IF;

		-- Update record
		EXECUTE 'UPDATE "dhcp"."range_options" SET ' || quote_ident($4) || ' = $5, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "name" = $1 AND "option" = $2 AND "value" = $3' 
		USING input_old_range, input_old_option, input_old_value, input_field, input_new_value;

		-- Done
		PERFORM api.syslog('modify_dhcp_range_option:"'||input_old_range||'","'||input_old_option||'","'||input_old_value||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'name' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."range_options" 
			WHERE "name" = input_new_value AND "option" = input_old_option AND "value" = input_old_value);
		ELSIF input_field ~* 'option' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."range_options" 
			WHERE "name" = input_old_range AND "option" = input_new_value AND "value" = input_old_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."range_options" 
			WHERE "name" = input_old_range AND "option" = input_old_option AND "value" = input_new_value);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dhcp_range_option(input_old_range text, input_old_option text, input_old_value text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dhcp_range_option(input_old_range text, input_old_option text, input_old_value text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dhcp_range_option(input_old_range text, input_old_option text, input_old_value text, input_field text, input_new_value text) IS 'Modify a field of a DHCP range option';


--
-- Name: modify_dhcp_subnet_option(cidr, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dhcp_subnet_option(input_old_subnet cidr, input_old_option text, input_old_value text, input_field text, input_new_value text) RETURNS SETOF dhcp.subnet_options
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to modify dhcp subnet option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Check allowed fields
		IF input_field !~* 'subnet|option|value' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		-- Update record
		EXECUTE 'UPDATE "dhcp"."subnet_options" SET ' || quote_ident($4) || ' = $5, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "subnet" = $1 AND "option" = $2 AND "value" = $3' 
		USING input_old_subnet, input_old_option, input_old_value, input_field, input_new_value;

		-- Done
		PERFORM api.syslog('modify_dhcp_subnet_option:"'||input_old_subnet||'","'||input_old_option||'","'||input_old_value||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'subnet' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."subnet_options" 
			WHERE "subnet" = input_new_value AND "option" = input_old_option AND "value" = input_old_value);
		ELSIF input_field ~* 'option' THEN
			RETURN QUERY (SELECT * FROM "dhcp"."subnet_options" 
			WHERE "subnet" = input_old_subnet AND "option" = input_new_value AND "value" = input_old_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dhcp"."subnet_options" 
			WHERE "subnet" = input_old_subnet AND "option" = input_old_option AND "value" = input_new_value);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dhcp_subnet_option(input_old_subnet cidr, input_old_option text, input_old_value text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dhcp_subnet_option(input_old_subnet cidr, input_old_option text, input_old_value text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dhcp_subnet_option(input_old_subnet cidr, input_old_option text, input_old_value text, input_field text, input_new_value text) IS 'Modify a field of a DHCP subnet option';


--
-- Name: modify_dns_address(inet, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_address(input_old_address inet, input_old_zone text, input_field text, input_new_value text) RETURNS SETOF dns.a
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system(input_old_address))) IS FALSE THEN
				RAISE EXCEPTION 'Permission denied';
			END IF;
	   		-- Shared zone
	          IF (SELECT "shared" FROM "dns"."zones" WHERE "zone" = input_old_zone) IS FALSE THEN
	               RAISE EXCEPTION 'Zone is not shared and you are not admin';
               END IF;
	  	END IF;

		-- Check allowed fields
		IF input_field !~* 'hostname|zone|address|owner|ttl' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;
		
		IF input_field ~* 'ttl' THEN
			-- User can only specify TTL if address is static
			IF (SELECT "config" FROM "systems"."interface_addresses" WHERE "address" = input_old_address) !~* 'static' AND input_new_value::integer != (SELECT "value"::integer/2 AS "ttl" FROM "dhcp"."subnet_options" WHERE "option"='default-lease-time' AND "subnet" >> input_old_address) THEN
				RAISE EXCEPTION 'You can only specify a TTL other than the default if your address is configured statically';
			END IF;
		END IF;

		IF api.get_current_user_level() !~* 'ADMIN' THEN
			-- Owner
	   		IF input_field ~* 'owner' THEN
			 	-- Different owner
				IF (SELECT "owner" FROM "dns"."a" WHERE "address" = input_old_address AND "zone" = input_zone) != input_new_value THEN
		               RAISE EXCEPTION 'Only admins can define a different owner (%).',input_new_value;
          	     END IF;
			END IF;
		END IF;

		-- Lower
		IF input_field ~* 'hostname' THEN
			input_new_value := lower(input_new_value);
		END IF;

		-- Update record

		IF input_field ~* 'address' THEN
			EXECUTE 'UPDATE "dns"."a" SET ' || quote_ident($3) || ' = $4, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1 AND "zone" = $2' 
			USING input_old_address, input_old_zone, input_field, inet(input_new_value);		
		ELSIF input_field ~* 'ttl' THEN
			EXECUTE 'UPDATE "dns"."a" SET ' || quote_ident($3) || ' = $4, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1 AND "zone" = $2' 
			USING input_old_address, input_old_zone, input_field, cast(input_new_value as int);
		ELSE
			EXECUTE 'UPDATE "dns"."a" SET ' || quote_ident($3) || ' = $4, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1 AND "zone" = $2' 
			USING input_old_address, input_old_zone, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_address:"'||input_old_address||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'address' THEN
			RETURN QUERY (SELECT * FROM "dns"."a" WHERE "address" = inet(input_new_value) AND "zone" = input_old_zone);
		ELSEIF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."a" WHERE "address" = input_old_address AND "zone" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."a" WHERE "address" = input_old_address AND "zone" = input_old_zone);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_address(input_old_address inet, input_old_zone text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_address(input_old_address inet, input_old_zone text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_address(input_old_address inet, input_old_zone text, input_field text, input_new_value text) IS 'Modify an existing DNS address';


--
-- Name: modify_dns_cname(text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_cname(input_old_alias text, input_old_zone text, input_field text, input_new_value text) RETURNS SETOF dns.cname
    LANGUAGE plpgsql
    AS $_$
	BEGIN

		 -- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			-- Shared zone
			IF (SELECT "shared" FROM "dns"."zones" WHERE "zone" = input_old_zone) IS FALSE THEN
				RAISE EXCEPTION 'Zone is not shared and you are not admin';
			END IF;
	   		-- System owner
			IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system((SELECT "address" FROM "dns"."cname" WHERE "alias" = input_old_alias AND "zone" = input_old_zone)))) IS FALSE THEN
				RAISE EXCEPTION 'Permission denied';
			END IF;
	   		-- Another owner
			IF input_field !~* 'owner' THEN
			 	IF input_new_value != api.get_current_user() THEN
					RAISE EXCEPTION 'You specified another owner when you are not an admin';
				END IF;
			END IF;
		END IF;

		 -- Check allowed fields
		IF input_field !~* 'hostname|zone|alias|owner|ttl' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Lower
		IF input_field ~* 'hostname|alias' THEN
			input_new_value := lower(input_new_value);
		END IF;

		-- Check for in use
		IF input_field ~* 'alias' THEN
			IF (SELECT api.check_dns_hostname(input_new_value, input_zone)) IS TRUE THEN
				RAISE EXCEPTION 'Record with this hostname and zone already exists';
			END IF;
		END IF;

		-- Update record
		IF input_field ~* 'ttl' THEN
			EXECUTE 'UPDATE "dns"."cname" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "alias" = $1 AND "zone" = $2'
			USING input_old_alias, input_old_zone, input_field, cast(input_new_value as int);
		ELSEIF input_field ~* 'hostname' THEN
			EXECUTE 'UPDATE "dns"."cname" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user(), address = (SELECT "address" FROM "dns"."a" WHERE "hostname" = $4 AND "zone" = $2) 
			WHERE "alias" = $1 AND "zone" = $2'
			USING input_old_alias, input_old_zone, input_field, input_new_value;
		ELSE
			EXECUTE 'UPDATE "dns"."cname" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "alias" = $1 AND "zone" = $2'
			USING input_old_alias, input_old_zone, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_cname:"'||input_old_alias||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'alias' THEN
			RETURN QUERY (SELECT * FROM "dns"."cname" WHERE "alias" = input_new_value AND "zone" = input_old_zone);
		ELSEIF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."cname" WHERE "alias" = input_old_alias AND "zone" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."cname" WHERE "alias" = input_old_alias AND "zone" = input_old_zone);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_cname(input_old_alias text, input_old_zone text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_cname(input_old_alias text, input_old_zone text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_cname(input_old_alias text, input_old_zone text, input_field text, input_new_value text) IS 'Modify an existing DNS CNAME record';


--
-- Name: modify_dns_key(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_key(input_old_keyname text, input_field text, input_new_value text) RETURNS SETOF dns.keys
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."keys" WHERE "keyname" = input_old_keyname) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit key % denied. You are not owner',input_old_keyname;
			END IF;

			IF input_field ~* 'owner' AND input_new_value != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_new_value;
			END IF;
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'keyname|key|comment|owner|enctype' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Validate input
		IF input_field ~* 'keyname' THEN 
			input_new_value := api.validate_nospecial(input_new_value);
		END IF;

		-- Update record
		EXECUTE 'UPDATE "dns"."keys" SET ' || quote_ident($2) || ' = $3, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "keyname" = $1' 
		USING input_old_keyname, input_field, input_new_value;

		-- Done
		PERFORM api.syslog('modify_dns_key:"'||input_old_keyname||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'keyname' THEN
			RETURN QUERY (SELECT * FROM "dns"."keys" WHERE "keyname" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."keys" WHERE "keyname" = input_old_keyname);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_key(input_old_keyname text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_key(input_old_keyname text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_key(input_old_keyname text, input_field text, input_new_value text) IS 'Modify an existing DNS key';


--
-- Name: modify_dns_mailserver(text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_mailserver(input_old_hostname text, input_old_zone text, input_field text, input_new_value text) RETURNS SETOF dns.mx
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		 -- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- Zone owner
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied';
			END IF;
	   		-- You own the system
			IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system(input_old_address))) IS FALSE THEN
				RAISE EXCEPTION 'Permission denied';
			END IF;
		END IF;

		 -- Check allowed fields
		IF input_field !~* 'hostname|zone|preference|owner|ttl' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Lower
		IF input_field ~* 'hostname' THEN
			input_new_value := lower(input_new_value);
		END IF;

		-- Update record

		IF input_field ~* 'preference|ttl' THEN
			EXECUTE 'UPDATE "dns"."mx" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "hostname" = $1 AND "zone" = $2'
			USING input_old_hostname, input_old_zone, input_field, cast(input_new_value as int);
		ELSEIF input_field ~* 'hostname' THEN
			EXECUTE 'UPDATE "dns"."mx" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user(), address = (SELECT "address" FROM "dns"."a" WHERE "hostname" = $4 AND "zone" = $2) 
			WHERE "hostname" = $1 AND "zone" = $2'
			USING input_old_hostname, input_old_zone, input_field, input_new_value;
		ELSE
			EXECUTE 'UPDATE "dns"."mx" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "hostname" = $1 AND "zone" = $2'
			USING input_old_hostname, input_old_zone, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_mailserver:"'||input_old_hostname||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'hostname' THEN
			RETURN QUERY (SELECT * FROM "dns"."mx" WHERE "hostname" = input_new_value AND "zone" = input_old_zone);
		ELSEIF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."mx" WHERE "hostname" = input_old_hostname AND "zone" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."mx" WHERE "hostname" = input_old_hostname AND "zone" = input_old_zone);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_mailserver(input_old_hostname text, input_old_zone text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_mailserver(input_old_hostname text, input_old_zone text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_mailserver(input_old_hostname text, input_old_zone text, input_field text, input_new_value text) IS 'Modify an existing DNS MX record';


--
-- Name: modify_dns_ns(text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_ns(input_old_zone text, input_old_nameserver text, input_field text, input_new_value text) RETURNS SETOF dns.ns
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		 -- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit nameserver (%.%) denied. You are not owner',input_old_nameserver,input_old_zone;
			END IF;
		END IF;

		 -- Check allowed fields
		IF input_field !~* 'nameserver|zone|ttl|address' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Lower
		IF input_field ~* 'nameserver' THEN
			input_new_value := lower(input_new_value);
		END IF;

		-- Update record
		IF input_field ~* 'ttl' THEN
			EXECUTE 'UPDATE "dns"."ns" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "zone" = $1 AND "nameserver" = $2'
			USING input_old_zone, input_old_nameserver, input_field, cast(input_new_value as int);
			
			-- Update TTLs of other zone records since they all need to be the same
			UPDATE "dns"."ns" SET "ttl" = cast(input_new_value as int) WHERE "zone" = input_old_zone;
			
		ELSEIF input_field ~* 'address' THEN
			EXECUTE 'UPDATE "dns"."ns" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "zone" = $1 AND "nameserver" = $2'
			USING input_old_zone, input_old_nameserver, input_field, cast(input_new_value as inet);
		ELSE
			EXECUTE 'UPDATE "dns"."ns" SET ' || quote_ident($3) || ' = $4,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "zone" = $1 AND "nameserver" = $2'
			USING input_old_zone, input_old_nameserver, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_ns:"'||input_old_zone||'","'||input_old_nameserver||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'input_old_zone' THEN		
			RETURN QUERY (SELECT * FROM "dns"."ns" WHERE "zone" = input_new_value AND "nameserver" = input_old_nameserver);
		ELSEIF input_field ~* 'nameserver' THEN
			RETURN QUERY (SELECT * FROM "dns"."ns" WHERE "zone" = input_old_zone AND "nameserver" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."ns" WHERE "zone" = input_old_zone AND "nameserver" = input_old_nameserver);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_ns(input_old_zone text, input_old_nameserver text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_ns(input_old_zone text, input_old_nameserver text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_ns(input_old_zone text, input_old_nameserver text, input_field text, input_new_value text) IS 'Modify an existing DNS NS record';


--
-- Name: modify_dns_soa(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_soa(input_old_zone text, input_field text, input_new_value text) RETURNS SETOF dns.soa
    LANGUAGE plpgsql
    AS $_$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit SOA % denied. You are not owner',input_old_zone;
			END IF;
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'zone|ttl|nameserver|contact|serial|refresh|retry|expire|minimum' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Validate
		IF input_field ~* 'contact' THEN
			IF api.validate_soa_contact(input_new_value) IS FALSE THEN
				RAISE EXCEPTION 'Invalid SOA contact given (%)',input_contact;
			END IF;
		END IF;

		-- Update record
		IF input_field ~* 'ttl|refresh|retry|expire|minimum' THEN
			EXECUTE 'UPDATE "dns"."soa" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1' 
			USING input_old_zone, input_field, cast(input_new_value as integer);
		ELSE
			EXECUTE 'UPDATE "dns"."soa" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1' 
			USING input_old_zone, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_soa:"'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."soa" WHERE "zone" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."soa" WHERE "zone" = input_old_zone);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_soa(input_old_zone text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_soa(input_old_zone text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_soa(input_old_zone text, input_field text, input_new_value text) IS 'Modify an existing DNS SOA record';


--
-- Name: modify_dns_srv(text, text, integer, integer, integer, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_srv(input_old_alias text, input_old_zone text, input_old_priority integer, input_old_weight integer, input_old_port integer, input_field text, input_new_value text) RETURNS SETOF dns.srv
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		 -- Check privileges
	   	IF api.get_current_user_level() !~* 'ADMIN' THEN
			-- You own the system
			IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system((SELECT "address" FROM "dns"."srv" WHERE "alias" = input_old_alias AND "zone" = input_old_zone AND "priority" = input_old_priority AND "weight" = input_old_weight AND "port" = input_old_port)))) IS FALSE THEN
				RAISE EXCEPTION 'Permission denied';
			END IF;
	   		-- You own the zone
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit denied: You are not zone owner';
	   		END IF;
	   	END IF;

		 -- Check allowed fields
		IF input_field !~* 'hostname|zone|alias|owner|ttl|priority|weight|port' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Lower
		IF input_field ~* 'hostname|alias' THEN
			input_new_value := lower(input_new_value);
		END IF;
			
		-- Update record
		IF input_field ~* 'ttl|priority|weight|port' THEN
			EXECUTE 'UPDATE "dns"."srv" SET ' || quote_ident($6) || ' = $7,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "alias" = $1 AND "zone" = $2 AND "priority" = $3 AND "weight" = $4 AND "port" = $5'
			USING input_old_alias, input_old_zone, input_old_priority, input_old_weight, input_old_port, input_field, cast(input_new_value as int);
		ELSEIF input_field ~* 'hostname' THEN
			RAISE EXCEPTION 'test';
			EXECUTE 'UPDATE "dns"."srv" SET ' || quote_ident($6) || ' = $7,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user(), address = (SELECT "address" FROM "dns"."a" WHERE "hostname" = $7 AND "zone" = $2) 
			WHERE "alias" = $1 AND "zone" = $2 AND "priority" = $3 AND "weight" = $4 AND "port" = $5'
			USING input_old_alias, input_old_zone, input_old_priority, input_old_weight, input_old_port, input_field, input_new_value;
		ELSE
			EXECUTE 'UPDATE "dns"."srv" SET ' || quote_ident($6) || ' = $7,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "alias" = $1 AND "zone" = $2 AND "priority" = $3 AND "weight" = $4 AND "port" = $5'
			USING input_old_alias, input_old_zone, input_old_priority, input_old_weight, input_old_port, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_srv:"'||input_old_alias||'","'||input_old_zone||'","'||input_old_priority||'","'||input_old_weight||'","'||input_old_port||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'alias' THEN
			RETURN QUERY (SELECT * FROM "dns"."srv" 
			WHERE "alias" = input_new_value AND "zone" = input_old_zone AND "priority" = input_old_priority AND "weight" = input_old_weight AND "port" = input_old_port);
		ELSEIF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."srv" 
			WHERE "alias" = input_old_alias AND "zone" = input_new_value AND "priority" = input_old_priority AND "weight" = input_old_weight AND "port" = input_old_port);
		ELSEIF input_field ~* 'priority' THEN
			RETURN QUERY (SELECT * FROM "dns"."srv" 
			WHERE "alias" = input_old_alias AND "zone" = input_old_zone AND "priority" = input_new_value::integer AND "weight" = input_old_weight AND "port" = input_old_port);
		ELSEIF input_field ~* 'weight' THEN
			RETURN QUERY (SELECT * FROM "dns"."srv" 
			WHERE "alias" = input_old_alias AND "zone" = input_old_zone AND "priority" = input_old_priority AND "weight" = input_new_value::integer AND "port" = input_old_port);
		ELSEIF input_field ~* 'port' THEN
			RETURN QUERY (SELECT * FROM "dns"."srv" 
			WHERE "alias" = input_old_alias AND "zone" = input_old_zone AND "priority" = input_old_priority AND "weight" = input_old_weight AND "port" = input_new_value::integer);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."srv" 
			WHERE "alias" = input_old_alias AND "zone" = input_old_zone AND "priority" = input_old_priority AND "weight" = input_old_weight AND "port" = input_old_port);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_srv(input_old_alias text, input_old_zone text, input_old_priority integer, input_old_weight integer, input_old_port integer, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_srv(input_old_alias text, input_old_zone text, input_old_priority integer, input_old_weight integer, input_old_port integer, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_srv(input_old_alias text, input_old_zone text, input_old_priority integer, input_old_weight integer, input_old_port integer, input_field text, input_new_value text) IS 'Modify an existing DNS SRV record';


--
-- Name: modify_dns_txt(text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text) RETURNS SETOF dns.txt
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			-- Record owner
			IF (SELECT "owner" FROM "dns"."txt" WHERE "hostname" = input_old_hostname AND "zone" = input_old_zone AND "text" = input_old_text) != api.get_current_user() THEN
			 	RAISE EXCEPTION 'You are not the record owner';
			END IF;
			-- Zone owner
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'You are not the owner of the zone or an admin';
	   		END IF;
	   	END IF;

		 -- Check allowed fields
		IF input_field !~* 'hostname|zone|text|owner|ttl' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Lower
		IF input_new_value ~* 'hostname' THEN
			input_new_value := lower(input_new_value);
		END IF;

		-- Update record
		IF input_field ~* 'ttl' THEN
			EXECUTE 'UPDATE "dns"."txt" SET ' || quote_ident($4) || ' = $5,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "hostname" = $1 AND "zone" = $2 AND "text" = $3'
			USING input_old_hostname, input_old_zone, input_old_text, input_field, cast(input_new_value as int);
		ELSE
			EXECUTE 'UPDATE "dns"."txt" SET ' || quote_ident($4) || ' = $5,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "hostname" = $1 AND "zone" = $2 AND "text" = $3'
			USING input_old_hostname, input_old_zone, input_old_text, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_txt:"'||input_old_hostname||'","'||input_old_zone||'","'||input_old_text||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'hostname' THEN
			RETURN QUERY (SELECT * FROM "dns"."txt" WHERE "hostname" = input_new_value AND "zone" = input_old_zone AND "text" = input_old_text);
		ELSEIF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."txt" WHERE "hostname" = input_old_hostname AND "zone" = input_new_value AND "text" = input_old_text);
		ELSEIF input_field ~* 'text' THEN
			RETURN QUERY (SELECT * FROM "dns"."txt" WHERE "hostname" = input_old_hostname AND "zone" = input_old_zone AND "text" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."txt" WHERE "hostname" = input_old_hostname AND "zone" = input_old_zone AND "text" = input_old_text);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text) IS 'Modify an existing DNS TXT record';


--
-- Name: modify_dns_zone(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_zone(input_old_zone text, input_field text, input_new_value text) RETURNS SETOF dns.zones
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit zone % denied. You are not owner',input_old_zone;
			END IF;

			IF input_field ~* 'owner' AND input_new_value != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_new_value;
			END IF;
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'zone|forward|keyname|owner|comment|shared|ddns' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Update record
		IF input_field ~* 'forward|shared|ddns' THEN
			EXECUTE 'UPDATE "dns"."zones" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1' 
			USING input_old_zone, input_field, bool(input_new_value);
		ELSE
			EXECUTE 'UPDATE "dns"."zones" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1' 
			USING input_old_zone, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_zone:"'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."zones" WHERE "zone" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."zones" WHERE "zone" = input_old_zone);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_zone(input_old_zone text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_zone(input_old_zone text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_zone(input_old_zone text, input_field text, input_new_value text) IS 'Modify an existing DNS zone';


--
-- Name: modify_dns_zone_a(text, inet, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_zone_a(input_old_zone text, input_old_address inet, input_field text, input_new_value text) RETURNS SETOF dns.zone_a
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit zone % denied. You are not owner',input_old_zone;
			END IF;
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'zone|address|ttl' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		IF input_field ~* 'address' THEN
			IF input_new_value::inet << api.get_site_configuration('DYNAMIC_SUBNET')::cidr THEN
				RAISE EXCEPTION 'Zone A cannot be dynamic';
			END IF;
		END IF;


		-- Update record
		IF input_field ~* 'address' THEN
			EXECUTE 'UPDATE "dns"."zone_a" SET ' || quote_ident($3) || ' = $4, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1 AND "address" = $2' 
			USING input_old_zone, input_old_address, input_field, inet(input_new_value);		
		ELSIF input_field ~* 'ttl' THEN
			EXECUTE 'UPDATE "dns"."zone_a" SET ' || quote_ident($3) || ' = $4, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1 AND "address" = $2' 
			USING input_old_zone, input_old_address, input_field, cast(input_new_value as int);
		ELSE
			EXECUTE 'UPDATE "dns"."zone_a" SET ' || quote_ident($3) || ' = $4, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "zone" = $1 AND "address" = $2' 
			USING input_old_zone, input_old_address, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_dns_zone_a:"'||input_old_zone||'","'||input_old_address||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'zone' THEN
			RETURN QUERY (SELECT * FROM "dns"."zone_a" WHERE "zone" = input_new_value AND "address" = input_old_address);
		ELSEIF input_field ~* 'address' THEN
			RETURN QUERY (SELECT * FROM "dns"."zone_a" WHERE "zone" = input_old_zone AND "address" = inet(input_new_value));
		ELSE
			RETURN QUERY (SELECT * FROM "dns"."zone_a" WHERE "zone" = input_old_zone AND "address" = input_old_address);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_zone_a(input_old_zone text, input_old_address inet, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_zone_a(input_old_zone text, input_old_address inet, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_zone_a(input_old_zone text, input_old_address inet, input_field text, input_new_value text) IS 'Modify an existing DNS address';


--
-- Name: modify_dns_zone_txt(text, text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_dns_zone_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text) RETURNS SETOF dns.zone_txt
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		 -- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_old_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit alias (%.%) denied. You are not owner',input_old_hostname,input_old_zone;
			END IF;
		END IF;

		 -- Check allowed fields
		IF input_field !~* 'hostname|zone|text|ttl' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Lower
		IF input_zone ~* 'hostname' THEN
			input_new_value := lower(input_new_value);
		END IF;

		-- Update record
		IF input_field ~* 'ttl' THEN
			EXECUTE 'UPDATE "dns"."zone_txt" SET ' || quote_ident($4) || ' = $5,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "hostname" = $1 AND "zone" = $2 AND "text" = $3'
			USING input_old_hostname, input_old_zone, input_old_text, input_field, cast(input_new_value as int);
			
			-- Update other zone-only records if needed
			IF input_old_hostname IS NULL THEN
				UPDATE "dns"."zone_txt" SET "ttl" = cast(input_new_value as int) WHERE "hostname" IS NULL AND "zone" = input_old_zone;
			END IF;
		ELSE
			EXECUTE 'UPDATE "dns"."zone_txt" SET ' || quote_ident($4) || ' = $5,
			date_modified = localtimestamp(0), last_modifier = api.get_current_user()
			WHERE "hostname" = $1 AND "zone" = $2 AND "text" = $3'
			USING input_old_hostname, input_old_zone, input_old_text, input_field, input_new_value;
		END IF;

		-- Done
		IF input_field ~* 'hostname' THEN
			IF input_new_value IS NULL THEN
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_hostname||'","'||input_old_zone||'","'||input_field||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" IS NULL AND "zone" = input_old_zone AND "text" = input_old_text);
			ELSE
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_hostname||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" = input_new_value AND "zone" = input_old_zone AND "text" = input_old_text);
			END IF;
		ELSEIF input_field ~* 'zone' THEN
			IF input_old_hostname IS NULL THEN
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" IS NULL AND "zone" = input_new_value AND "text" = input_old_text);
			ELSE
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_hostname||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" = input_old_hostname AND "zone" = input_new_value AND "text" = input_old_text);
			END IF;
		ELSEIF input_field ~* 'text' THEN
			IF input_old_hostname IS NULL THEN
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" IS NULL AND "zone" = input_old_zone AND "text" = input_new_value);
			ELSE
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_hostname||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" = input_old_hostname AND "zone" = input_old_zone AND "text" = input_new_value);
			END IF;
		ELSE
			IF input_old_hostname IS NULL THEN
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" IS NULL AND "zone" = input_old_zone AND "text" = input_old_text);
			ELSE
				PERFORM api.syslog('modify_dns_zone_txt:"'||input_old_hostname||'","'||input_old_zone||'","'||input_field||'","'||input_new_value||'"');
				RETURN QUERY (SELECT * FROM "dns"."zone_txt" WHERE "hostname" = input_old_hostname AND "zone" = input_old_zone AND "text" = input_old_text);
			END IF;
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_dns_zone_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_dns_zone_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_dns_zone_txt(input_old_hostname text, input_old_zone text, input_old_text text, input_field text, input_new_value text) IS 'Modify an existing DNS zone_txt record';


--
-- Name: modify_domain_state(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_domain_state(input_host text, input_domain text, input_action text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
		HostData RECORD;
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."system" WHERE "system_name" = input_domain) THEN
				RAISE EXCEPTION 'Permission denied: Not VM owner';
			END IF;
		END IF;

		SELECT * INTO HostData FROM "libvirt"."hosts" WHERE "system_name" = input_host;

		RETURN api.control_libvirt_domain(HostData.uri,HostData.password,input_domain,input_action);
	END;
$$;


ALTER FUNCTION api.modify_domain_state(input_host text, input_domain text, input_action text) OWNER TO starrs;

--
-- Name: modify_group(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_group(input_old_group text, input_field text, input_new_value text) RETURNS SETOF management.groups
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can modify groups';
		END IF;

		IF input_field !~* 'group|privilege|renew_interval|comment' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		IF input_field ~* 'renew_interval' THEN
			EXECUTE 'UPDATE "management"."groups" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "group" = $1' 
			USING input_old_group, input_field, input_new_value::interval;
		ELSE
			EXECUTE 'UPDATE "management"."groups" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "group" = $1' 
			USING input_old_group, input_field, input_new_value;
		END IF;

		PERFORM api.syslog('modify_group:"'||input_old_group||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'group' THEN
			RETURN QUERY (SELECT * FROM "management"."groups" WHERE "group" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "management"."groups" WHERE "group" = input_old_group);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_group(input_old_group text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_group(input_old_group text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_group(input_old_group text, input_field text, input_new_value text) IS 'Alter a group';


--
-- Name: modify_group_member(text, text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_group_member(input_old_group text, input_old_user text, input_field text, input_new_value text) RETURNS SETOF management.group_members
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF api.get_current_user() NOT IN (SELECT * FROM api.get_group_admins(input_old_group)) THEN
				RAISE EXCEPTION 'Permission denied. Only admins can modify group members';
			END IF;
		END IF;

		IF input_field !~* 'group|user|privilege' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		EXECUTE 'UPDATE "management"."group_members" SET ' || quote_ident($3) || ' = $4, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "group" = $1 AND "user" = $2' 
		USING input_old_group, input_old_user, input_field, input_new_value;

		PERFORM api.syslog('modify_group_member:"'||input_old_group||'","'||input_old_user||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'group' THEN
			RETURN QUERY (SELECT * FROM "management"."group_members" WHERE "group" = input_new_value AND "user" = input_old_user);
		ELSEIF input_field ~* 'user' THEN
			RETURN QUERY (SELECT * FROM "management"."group_members" WHERE "group" = input_old_group AND "user" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "management"."group_members" WHERE "group" = input_old_group AND "user" = input_old_user);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_group_member(input_old_group text, input_old_user text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_group_member(input_old_group text, input_old_user text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_group_member(input_old_group text, input_old_user text, input_field text, input_new_value text) IS 'Modify a group member';


--
-- Name: modify_group_settings(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_group_settings(input_old_group text, input_field text, input_new_value text) RETURNS SETOF management.group_settings
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can create group provider settings';
		END IF;

		IF input_field !~* 'group|provider|id|hostname|username|password|privilege' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

          EXECUTE 'UPDATE "management"."group_settings" SET ' || quote_ident($2) || ' = $3,
          date_modified = localtimestamp(0), last_modifier = api.get_current_user()
          WHERE "group" = $1'
          USING input_old_group, input_field, input_new_value;

          PERFORM api.syslog('modify_group_settings:"'||input_old_group||'","'||input_field||'","'||input_new_value||'"');
          IF input_field ~* 'group' THEN
               RETURN QUERY (SELECT * FROM "management"."group_settings" WHERE "group" = input_new_value);
          ELSE
               RETURN QUERY (SELECT * FROM "management"."group_settings" WHERE "group" = input_old_group);
          END IF;
	END;
$_$;


ALTER FUNCTION api.modify_group_settings(input_old_group text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_group_settings(input_old_group text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_group_settings(input_old_group text, input_field text, input_new_value text) IS 'Modify group authentication and provider settings';


--
-- Name: modify_interface(macaddr, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_interface(input_old_mac macaddr, input_field text, input_new_value text) RETURNS SETOF systems.interfaces
    LANGUAGE plpgsql
    AS $_$
	BEGIN

		-- Check privileges
		IF (SELECT "write" FROM api.get_system_permissions((SELECT "system_name" FROM "systems"."interfaces" WHERE "mac" = input_old_mac))) IS FALSE THEN
			RAISE EXCEPTION 'Permission denied';
		END IF;

		-- Check allowed fields
		IF input_field !~* 'mac|comment|system_name|name' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Update record

		IF input_field ~* 'mac' THEN
			EXECUTE 'UPDATE "systems"."interfaces" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "mac" = $1' 
			H
			USING input_old_mac, input_field, macaddr(input_new_value);
		ELSE
			EXECUTE 'UPDATE "systems"."interfaces" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "mac" = $1' 
			USING input_old_mac, input_field, input_new_value;
		END IF;

		-- Done
		PERFORM api.syslog('modify_interface:"'||input_old_mac||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'mac' THEN
			RETURN QUERY (SELECT * FROM "systems"."interfaces" WHERE "mac" = macaddr(input_new_value));
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."interfaces" WHERE "mac" = input_old_mac);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_interface(input_old_mac macaddr, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_interface(input_old_mac macaddr, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_interface(input_old_mac macaddr, input_field text, input_new_value text) IS 'Modify an existing system interface';


--
-- Name: modify_interface_address(inet, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_interface_address(input_old_address inet, input_field text, input_new_value text) RETURNS SETOF systems.interface_addresses
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		isprim BOOLEAN;
		primcount INTEGER;
	BEGIN

		-- Check privilegesinput_old_name
		IF (SELECT "write" FROM api.get_system_permissions(api.get_interface_address_system(input_old_address))) IS FALSE THEN
			RAISE EXCEPTION 'Permission denied';
		END IF;

		-- Check allowed fields
		IF input_field !~* 'comment|address|config|isprimary|mac|class|renew_date' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;
		
		-- Check dynamic
		IF api.ip_is_dynamic(input_old_address) IS TRUE THEN
			IF input_field ~* 'config|class' THEN
				RAISE EXCEPTION 'Cannot modify the configuration or class of a dynamic address';
			END IF;
		END IF;

		-- Check for primary
		SELECT "isprimary" INTO isprim FROM "systems"."interface_addresses" WHERE "address" = input_old_address;

		IF input_field ~* 'mac' THEN
			SELECT COUNT(*) INTO primcount FROM "systems"."interface_addresses" WHERE "mac" = input_new_value::macaddr AND "isprimary" IS TRUE;
			IF primcount = 0 THEN
				isprim := TRUE;
			ELSE
				isprim := FALSE;
			END IF;
		END IF;

		IF input_field ~* 'address' THEN
			IF (SELECT "use" FROM "api"."get_ip_ranges"() WHERE "name" = (SELECT "api"."get_address_range"(input_new_value::inet))) ~* 'ROAM' THEN
				RAISE EXCEPTION 'Specified new address (%) is contained within a Dynamic range',input_new_value;
			END IF;
		END IF;

		IF input_field ~* 'renew_date' AND input_new_value IS NULL THEN
			input_new_value := api.get_default_renew_date(api.get_interface_address_system(input_old_address));
		END IF;

		-- Update record

		IF input_field ~* 'mac' THEN
			EXECUTE 'UPDATE "systems"."interface_addresses" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user(), isprimary = $4 
			WHERE "address" = $1' 
			USING input_old_address, input_field, macaddr(input_new_value),isprim;
		ELSIF input_field ~* 'address' THEN
			EXECUTE 'UPDATE "systems"."interface_addresses" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1' 
			USING input_old_address, input_field, inet(input_new_value);
		ELSIF input_field ~* 'isprimary' THEN
			EXECUTE 'UPDATE "systems"."interface_addresses" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1' 
			USING input_old_address, input_field, bool(input_new_value);
		ELSIF input_field ~* 'renew_date' THEN
			EXECUTE 'UPDATE "systems"."interface_addresses" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1' 
			USING input_old_address, input_field, input_new_value::date;
		ELSEIF input_field ~* 'config' THEN
			EXECUTE 'UPDATE "systems"."interface_addresses" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1' 
			USING input_old_address, input_field, input_new_value;
			-- Need to force DNS records to be created
			IF input_new_value ~* 'static' THEN
				UPDATE "dns"."a" SET "address" = input_old_address WHERE "address" = input_old_address;
			END IF;
		ELSE
			EXECUTE 'UPDATE "systems"."interface_addresses" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "address" = $1' 
			USING input_old_address, input_field, input_new_value;
		END IF;
		
		-- Done
		PERFORM api.syslog('modify_interface_address:"'||input_old_address||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'address' THEN
			RETURN QUERY (SELECT * FROM "systems"."interface_addresses" WHERE "address" = inet(input_new_value));
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."interface_addresses" WHERE "address" = input_old_address);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_interface_address(input_old_address inet, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_interface_address(input_old_address inet, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_interface_address(input_old_address inet, input_field text, input_new_value text) IS 'Modify an existing interface address';


--
-- Name: modify_ip_range(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_ip_range(input_old_name text, input_field text, input_new_value text) RETURNS SETOF ip.ranges
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to modify range (%). Not admin.',input_old_name;
		END IF;

		-- Check allowed fields
		IF input_field !~* 'first_ip|last_ip|comment|use|name|subnet|class|zone' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		-- Update record
		IF input_field ~* 'first_ip|last_ip' THEN
			EXECUTE 'UPDATE "ip"."ranges" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "name" = $1' 
			USING input_old_name, input_field, inet(input_new_value);	
		ELSIF input_field ~* 'subnet' THEN
			EXECUTE 'UPDATE "ip"."ranges" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "name" = $1' 
			USING input_old_name, input_field, cidr(input_new_value);	
		ELSE
			EXECUTE 'UPDATE "ip"."ranges" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "name" = $1' 
			USING input_old_name, input_field, input_new_value;	
		END IF;

		-- Done
		PERFORM api.syslog('modify_ip_range:"'||input_old_name||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'name' THEN
			RETURN QUERY (SELECT * FROM "ip"."ranges" WHERE "name" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "ip"."ranges" WHERE "name" = input_old_name);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_ip_range(input_old_name text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_ip_range(input_old_name text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_ip_range(input_old_name text, input_field text, input_new_value text) IS 'Modify an IP range';


--
-- Name: modify_ip_subnet(cidr, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_ip_subnet(input_old_subnet cidr, input_field text, input_new_value text) RETURNS SETOF ip.subnets
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges		
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "ip"."subnets" WHERE "subnet" = input_old_subnet) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to edit subnet % denied. You are not owner',input_old_subnet;
			END IF;

			IF input_field ~* 'owner' AND input_new_value != api.get_current_user() THEN
				RAISE EXCEPTION 'Only administrators can define a different owner (%).',input_new_value;
			END IF;
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'subnet|comment|autogen|name|owner|zone|dhcp_enable|datacenter|vlan' THEN
			RAISE EXCEPTION 'Invalid field specified (%)',input_field;
		END IF;

		-- Update record
		IF input_field ~* 'dhcp_enable|autogen' THEN
			EXECUTE 'UPDATE "ip"."subnets" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "subnet" = $1' 
			USING input_old_subnet, input_field, bool(input_new_value);	
		ELSIF input_field ~* 'subnet' THEN
			EXECUTE 'UPDATE "ip"."subnets" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "subnet" = $1' 
			USING input_old_subnet, input_field, cidr(input_new_value);	
		ELSIF input_field ~* 'vlan' THEN
			EXECUTE 'UPDATE "ip"."subnets" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "subnet" = $1' 
			USING input_old_subnet, input_field, input_new_value::integer;	
		ELSE
			EXECUTE 'UPDATE "ip"."subnets" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "subnet" = $1' 
			USING input_old_subnet, input_field, input_new_value;	
		END IF;

		-- Done
		PERFORM api.syslog('modify_ip_subnet:"'||input_old_subnet||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'subnet' THEN
			RETURN QUERY (SELECT * FROM "ip"."subnets" WHERE "subnet" = cidr(input_new_value));
		ELSE
			RETURN QUERY (SELECT * FROM "ip"."subnets" WHERE "subnet" = input_old_subnet);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_ip_subnet(input_old_subnet cidr, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_ip_subnet(input_old_subnet cidr, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_ip_subnet(input_old_subnet cidr, input_field text, input_new_value text) IS 'Modify an IP subnet';


--
-- Name: modify_network_snmp(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_network_snmp(input_old_system text, input_field text, input_new_value text) RETURNS void
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_old_system) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied: you are not owner';
			END IF;
		END IF;
		
		-- Check fields
		IF input_field !~* 'ro_community|rw_community|system_name|address' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;
		
		IF input_field ~* 'address' THEN
			IF(api.get_interface_address_system(input_new_value::inet) != input_old_system) THEN
				RAISE EXCEPTION 'Address % is not a part of the system %',input_new_value,input_old_system;
			END IF;

	   		IF input_new_value::inet << api.get_site_configuration('DYNAMIC_SUBNET')::cidr THEN
				RAISE EXCEPTION 'System address cannot be dynamic';
	          END IF;
		END IF;
		
		-- Mod it
		IF input_field  ~* 'address' THEN
			EXECUTE 'UPDATE "network"."snmp" SET ' || quote_ident($2) || ' = $3
			WHERE "system_name" = $1'
			USING input_old_system, input_field, input_new_value::inet;
		ELSE
			EXECUTE 'UPDATE "network"."snmp" SET ' || quote_ident($2) || ' = $3
			WHERE "system_name" = $1'
			USING input_old_system, input_field, input_new_value;
		END IF;
		
		-- Done
		PERFORM api.syslog('modify_network_snmp:"'||input_old_system||'","'||input_field||'","'||input_new_value||'"');
	END;
$_$;


ALTER FUNCTION api.modify_network_snmp(input_old_system text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_network_snmp(input_old_system text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_network_snmp(input_old_system text, input_field text, input_new_value text) IS 'Modify credentials for a system';


--
-- Name: modify_network_switchport_admin_state(inet, text, text, boolean); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.modify_network_switchport_admin_state(input_address inet, input_port text, input_rw_community text, input_state boolean) RETURNS void
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	no warnings('redefine');

	# Local variables and things
	our $host = shift;
	our $portName = shift;
	our $community = shift;
	our $state = shift;

	# OID List
	our $ifNameList_OID = '.1.3.6.1.2.1.31.1.1.1.1';
	#our $ifAliasList_OID = '1.3.6.1.2.1.31.1.1.1.18';

	# Stored data
	our %ifIndexData;
	our $ifAdminStatusOid = '.1.3.6.1.2.1.2.2.1.7';

	# Establish session
	our ($session,$error) = Net::SNMP->session (
	     -hostname => $host,
	     -community => $community,
	);

	# Get the index of all interfaces
	my $ifNameList = $session->get_table(-baseoid => $ifNameList_OID);
	while (my($ifIndex,$ifName) = each(%$ifNameList)) {
		$ifIndex =~ s/$ifNameList_OID\.//;
		if($ifIndex =~ m/\d{5}/) {
			# $ifIndexData{$ifIndex} = $ifName;
			if($ifName eq $portName) {
				$ifAdminStatusOid .= ".$ifIndex";
			}
		}
		# warn("$ifIndex - $ifName\n");
	}

	# Finalize the data
	my $snmpState = 1;
	if($state eq 'f') {
		$snmpState = 2;
	}

	# Set the new description
	my $result = $session->set_request(
		-varbindlist => [ $ifAdminStatusOid, INTEGER, $snmpState ],
	);
	#die($state);
	#die($ifAdminStatusOid);

	if(!$result) {
		die("Error: ",$session->error());
	}

	# Close initial session
	$session->close();
$_$;


ALTER FUNCTION api.modify_network_switchport_admin_state(input_address inet, input_port text, input_rw_community text, input_state boolean) OWNER TO postgres;

--
-- Name: FUNCTION modify_network_switchport_admin_state(input_address inet, input_port text, input_rw_community text, input_state boolean); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.modify_network_switchport_admin_state(input_address inet, input_port text, input_rw_community text, input_state boolean) IS 'Modify the admin state of a network switchport';


--
-- Name: modify_network_switchport_description(inet, text, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.modify_network_switchport_description(input_address inet, input_port text, input_rw_community text, input_description text) RETURNS void
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SNMP;
	no warnings('redefine');

	# Local variables and things
	our $host = shift;
	our $portName = shift;
	our $community = shift;
	our $description = shift;

	# OID List
	our $ifNameList_OID = '.1.3.6.1.2.1.31.1.1.1.1';
	our $ifAliasList_OID = '1.3.6.1.2.1.31.1.1.1.18';

	# Stored data
	our %ifIndexData;
	our $ifAliasOid = '1.3.6.1.2.1.31.1.1.1.18';

	# Establish session
	our ($session,$error) = Net::SNMP->session (
	     -hostname => $host,
	     -community => $community,
	);

	# Get the index of all interfaces
	my $ifNameList = $session->get_table(-baseoid => $ifNameList_OID);
	while (my($ifIndex,$ifName) = each(%$ifNameList)) {
		$ifIndex =~ s/$ifNameList_OID\.//;
		if($ifIndex =~ m/\d{5}/) {
			# $ifIndexData{$ifIndex} = $ifName;
			if($ifName eq $portName) {
				$ifAliasOid .= ".$ifIndex";
			}
		}
		# warn("$ifIndex - $ifName\n");
	}

	# Set the new description
	my $result = $session->set_request(
		-varbindlist => [ $ifAliasOid, OCTET_STRING, $description ],
	);

	if(!$result) {
		die("Error: ",$session->error());
	}

	# Close initial session
	$session->close();
$_$;


ALTER FUNCTION api.modify_network_switchport_description(input_address inet, input_port text, input_rw_community text, input_description text) OWNER TO postgres;

--
-- Name: FUNCTION modify_network_switchport_description(input_address inet, input_port text, input_rw_community text, input_description text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.modify_network_switchport_description(input_address inet, input_port text, input_rw_community text, input_description text) IS 'Modify the description of a network switchport';


--
-- Name: modify_platform(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_platform(input_old_name text, input_field text, input_new_value text) RETURNS SETOF systems.platforms
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to edit platform denied. You are not admin';
 		END IF;

		-- Check allowed fields
		IF input_field !~* 'platform_name|architecture|disk|cpu|memory' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		IF input_field ~* 'memory' THEN
			EXECUTE 'UPDATE "systems"."platforms" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "platform_name" = $1' 
			USING input_old_name, input_field, input_new_value::integer;
		ELSE
			EXECUTE 'UPDATE "systems"."platforms" SET ' || quote_ident($2) || ' = $3, 
			date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
			WHERE "platform_name" = $1' 
			USING input_old_name, input_field, input_new_value;
		END IF;

		PERFORM api.syslog('modify_platform:"'||input_old_name||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'platform_name' THEN
			RETURN QUERY (SELECT * FROM "systems"."platforms" WHERE "platform_name" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."platforms" WHERE "platform_name" = input_old_name);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_platform(input_old_name text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_platform(input_old_name text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_platform(input_old_name text, input_field text, input_new_value text) IS 'Modify a hardware platform';


--
-- Name: modify_site_configuration(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_site_configuration(input_directive text, input_value text) RETURNS SETOF management.configuration
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can modify site directives';
		END IF;

		-- Create directive
		UPDATE "management"."configuration" SET "value" = input_value WHERE "option" = input_directive;

		-- Done
		PERFORM api.syslog('modify_site_configuration:"'||input_directive||'","'||input_value||'"');
		RETURN QUERY (SELECT * FROM "management"."configuration" WHERE "option" = input_directive AND "value" = input_value);
	END;
$$;


ALTER FUNCTION api.modify_site_configuration(input_directive text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_site_configuration(input_directive text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_site_configuration(input_directive text, input_value text) IS 'Modify a site configuration directive';


--
-- Name: modify_system(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_system(input_old_name text, input_field text, input_new_value text) RETURNS SETOF systems.systems
    LANGUAGE plpgsql
    AS $_$
	BEGIN
		-- Check privileges
		IF (SELECT "write" FROM api.get_system_permissions(input_old_name)) IS FALSE THEN
			RAISE EXCEPTION 'Permission denied';
		END IF;

		-- Check allowed fields
		IF input_field !~* 'system_name|owner|comment|type|os_name|platform_name|asset|group|datacenter|location' THEN
			RAISE EXCEPTION 'Invalid field % specified',input_field;
		END IF;

		-- Update record

		EXECUTE 'UPDATE "systems"."systems" SET ' || quote_ident($2) || ' = $3, 
		date_modified = localtimestamp(0), last_modifier = api.get_current_user() 
		WHERE "system_name" = $1' 
		USING input_old_name, input_field, input_new_value;

		-- Done
		PERFORM api.syslog('modify_system:"'||input_old_name||'","'||input_field||'","'||input_new_value||'"');
		IF input_field ~* 'system_name' THEN
			RETURN QUERY (SELECT * FROM "systems"."systems" WHERE "system_name" = input_new_value);
		ELSE
			RETURN QUERY (SELECT * FROM "systems"."systems" WHERE "system_name" = input_old_name);
		END IF;
	END;
$_$;


ALTER FUNCTION api.modify_system(input_old_name text, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_system(input_old_name text, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_system(input_old_name text, input_field text, input_new_value text) IS 'Modify an existing system';


--
-- Name: modify_vlan(text, integer, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.modify_vlan(input_old_datacenter text, input_old_vlan integer, input_field text, input_new_value text) RETURNS SETOF network.vlans
    LANGUAGE plpgsql
    AS $_$
     BEGIN
          IF api.get_current_user_level() !~* 'ADMIN' THEN
               RAISE EXCEPTION 'Only admins can create VLANs';
          END IF;

          IF input_field !~* 'datacenter|vlan|name|comment' THEN
               RAISE EXCEPTION 'Invalid field %',input_field;
          END IF;

          IF input_field ~* 'vlan' THEN
               EXECUTE 'UPDATE "network"."vlans" SET ' || quote_ident($3) || ' = $4,
               date_modified = localtimestamp(0), last_modifier = api.get_current_user()
               WHERE "datacenter" = $1 AND "vlan" = $2'
               USING input_old_datacenter, input_old_vlan, input_field, input_new_value::integer;
          ELSE
               EXECUTE 'UPDATE "network"."vlans" SET ' || quote_ident($3) || ' = $4,
               date_modified = localtimestamp(0), last_modifier = api.get_current_user()
               WHERE "datacenter" = $1 AND "vlan" = $2'
               USING input_old_datacenter, input_old_vlan, input_field, input_new_value;
          END IF;

		PERFORM api.syslog('modify_vlan:"'||input_old_datacenter||'","'||input_old_vlan||'","'||input_field||'","'||input_new_value||'"');
          IF input_field ~* 'datacenter' THEN
               RETURN QUERY (SELECT * FROM "network"."vlans" WHERE "datacenter" = input_new_value AND "vlan" = input_old_vlan);
          ELSEIF input_field ~* 'vlan' THEN
               RETURN QUERY (SELECT * FROM "network"."vlans" WHERE "datacenter" = input_old_datacenter AND "vlan" = input_new_value::integer);
          ELSE
               RETURN QUERY (SELECT * FROM "network"."vlans" WHERE "datacenter" = input_old_datacenter AND "vlan" = input_old_vlan);
          END IF;
     END;
$_$;


ALTER FUNCTION api.modify_vlan(input_old_datacenter text, input_old_vlan integer, input_field text, input_new_value text) OWNER TO starrs;

--
-- Name: FUNCTION modify_vlan(input_old_datacenter text, input_old_vlan integer, input_field text, input_new_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.modify_vlan(input_old_datacenter text, input_old_vlan integer, input_field text, input_new_value text) IS 'Modify a VLAN';


--
-- Name: notify_expiring_addresses(); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.notify_expiring_addresses() RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		SystemData RECORD;
	BEGIN
		FOR SystemData IN (SELECT api.get_interface_address_owner("address") AS "owner","address","renew_date" FROM "systems"."interface_addresses" WHERE "renew_date" <= current_date + api.get_site_configuration('EMAIL_NOTIFICATION_INTERVAL')::interval) LOOP
			PERFORM "api"."send_renewal_email"(api.get_user_email(SystemData.owner), SystemData.address, api.get_interface_address_system(SystemData.address), (SELECT "api"."get_site_configuration"('EMAIL_DOMAIN')), (SELECT api.get_site_configuration('WEB_URL')),(SELECT api.get_site_configuration('MAIL_HOST')));
			PERFORM api.syslog('notified '||api.get_user_email(SystemData.owner)||' of expiring address: '||SystemData.address);
		END LOOP;
	END;
$$;


ALTER FUNCTION api.notify_expiring_addresses() OWNER TO starrs;

--
-- Name: FUNCTION notify_expiring_addresses(); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.notify_expiring_addresses() IS 'Notify users of soon-to-expire addresses';


--
-- Name: nslookup(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.nslookup(input_address inet) RETURNS TABLE(fqdn text)
    LANGUAGE plpgsql
    AS $$
	BEGIN
		RETURN QUERY (SELECT "hostname"||'.'||"zone" FROM "dns"."a" WHERE "address" = input_address);
	END;
$$;


ALTER FUNCTION api.nslookup(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION nslookup(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.nslookup(input_address inet) IS 'Get the DNS name of an IP address in the database';


--
-- Name: nsupdate(text, text, text, inet, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.nsupdate(zone text, keyname text, key text, server inet, action text, record text) RETURNS text
    LANGUAGE plperlu
    AS $_$	use strict;
	use warnings;
	use v5.10;
	use Net::DNS;
	no warnings('redefine');

	# Local variable information
	our $zone = shift(@_) or die("Invalid zone argument");
	our $keyname = shift(@_) or die("Invalid keyname argument");
	our $key = shift(@_) or die("Invalid key argument");
	our $server = shift(@_) or die("Invalid server argument");
	our $action = shift(@_) or die("Invalid action argument");
	our $record = shift(@_) or die("Invalid record argument");

	# DNS Server
	our $res = Net::DNS::Resolver->new;
	$res->nameservers($server);


	# Update packet
	our $update = Net::DNS::Update->new($zone);

	# Do something
	my $returnCode;
	if($action eq "DELETE") {
		$returnCode = &delete();
	}
	elsif($action eq "ADD") {
		$returnCode = &add();
	}
	else {
		$returnCode = "INVALID ACTION";
	}

	# Delete a record
	sub delete() {
		# The record must be there to delete it
		# $update->push(pre => yxrrset($record));

		# Delete the record
		$update->push(update => rr_del($record));

		# Sign it
		$update->sign_tsig($keyname, $key);

		# Send it
		&send();
	}

	# Add a record
	sub add() {
		# MX and TXT records will already exist. Otherwise the record you are 
		# creating should not already be in the zone. That would be silly.
		#
		# Frak it, you better be sure IMPULSE owns your DNS zone. Otherwise old records
		# WILL be overwriten.
		# 
		# if($record !~ m/\s(MX|TXT|NS)\s/) {
		# 	$update->push(pre => nxrrset($record));
		# }

		# Add the record
		$update->push(update => rr_add($record));

		# Sign it
		$update->sign_tsig($keyname, $key);

		# Send it
		&send();
	}

	# Send an update
	sub send() {
		my $reply = $res->send($update);
		if($reply) {
			if($reply->header->rcode eq 'NOERROR') {
				return 0;
			}
			else {
				return &interpret_error($reply->header->rcode);
			}
		}
		else {
			return &interpret_error($res->errorstring);
		}
	}

	# Interpret the error codes if any
	sub interpret_error() {
		my $error = shift(@_);

		given ($error) {
			when (/NXRRSET/) { return "Error $error: Name does not exist"; }
			when (/YXRRSET/) { return "Error $error: Name exists"; }
			when (/NOTAUTH/) { return "Error $error: Not authorized. Check system clocks and or key"; }
			default { return "$error unrecognized"; }
		}
	}

	return $returnCode;$_$;


ALTER FUNCTION api.nsupdate(zone text, keyname text, key text, server inet, action text, record text) OWNER TO postgres;

--
-- Name: ping(inet); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.ping(inet) RETURNS boolean
    LANGUAGE plperlu
    AS $_X$
	#! /usr/bin/perl
	use strict;
	use warnings;
	use Net::IP qw(ip_get_version);

	my $res = 1;

	if (ip_get_version($_[0]) == 6) {
		   $res = system("ping6 -W 1 -c 1 $_[0] > /dev/null");
	} else {
		    $res = system("ping -W 1 -c 1 $_[0] > /dev/null");
	}

	if($res == 0) {
		return 1;
	} else {
		return 0;
	}
$_X$;


ALTER FUNCTION api.ping(inet) OWNER TO postgres;

--
-- Name: FUNCTION ping(inet); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.ping(inet) IS 'See if a host is up on the network';


--
-- Name: query_address_reverse(inet); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.query_address_reverse(inet) RETURNS text
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::DNS;
	use Net::IP;
	use Net::IP qw(:PROC);
	use v5.10;

	# Define some variables
	my $address = shift(@_) or die "Unable to get address";
	
	# Generate the reverse string (d.c.b.a.in-addr.arpa.)
	my $reverse = new Net::IP ($address)->reverse_ip() or die (Net::IP::Error());

	# Create the resolver
	my $res = Net::DNS::Resolver->new;

	# Run the query
	my $rr = $res->query($reverse,'PTR');

	# Check for a response
	if(!defined($rr)) {
		return;
	}

	# Parse the response
	my @answer = $rr->answer;
	foreach my $response(@answer) {
		return $response->ptrdname;
	}
$_$;


ALTER FUNCTION api.query_address_reverse(inet) OWNER TO postgres;

--
-- Name: FUNCTION query_address_reverse(inet); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.query_address_reverse(inet) IS 'Print the forward host of a reverse lookup';


--
-- Name: query_axfr(text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.query_axfr(text, text) RETURNS SETOF dns.zone_audit_data
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Net::DNS;
	use v5.10;
	use Data::Dumper;
	
	my $zone = shift(@_) or die "Unable to get zone";
	my $nameserver = shift(@_) or die "Unable to get nameserver for zone";

	my $res = Net::DNS::Resolver->new;
	$res->nameservers($nameserver);

	my @answer = $res->axfr($zone);

	foreach my $result (@answer) {
		&print_data($result);
	}

	sub print_data() {
		my $rr = $_[0];
		given($rr->type) {
			when (/^A|AAAA$/) {
				return_next({host=>$rr->name, ttl=>$rr->ttl, type=>$rr->type, address=>$rr->address});
			}
			when (/^CNAME$/) {
				return_next({host=>$rr->name,ttl=>$rr->ttl,type=>$rr->type,target=>$rr->cname});
			}
			when (/^SRV$/) {
				return_next({host=>$rr->name,ttl=>$rr->ttl,type=>$rr->type,priority=>$rr->priority,weight=>$rr->weight,port=>$rr->port,target=>$rr->target});
			}
			when (/^NS$/) {
				return_next({host=>$rr->nsdname, ttl=>$rr->ttl, type=>$rr->type});
			}
			when (/^MX$/) {
				return_next({host=>$rr->exchange, ttl=>$rr->ttl, type=>$rr->type, preference=>$rr->preference});
			}
			when (/^TXT$/) {
				return_next({host=>$rr->name, ttl=>$rr->ttl, type=>$rr->type, text=>$rr->char_str_list});
			}
			when (/^SOA$/) {
				return_next({host=>$rr->name, target=>$rr->mname, ttl=>$rr->ttl, contact=>$rr->rname, serial=>$rr->serial, refresh=>$rr->refresh, retry=>$rr->retry, expire=>$rr->expire, minimum=>$rr->minimum, type=>$rr->type});
			}
			when (/^PTR$/) {
				return_next({host=>$rr->name, target=>$rr->ptrdname, ttl=>$rr->ttl, type=>$rr->type});
			}
		}
	}
	return undef;
$_X$;


ALTER FUNCTION api.query_axfr(text, text) OWNER TO postgres;

--
-- Name: FUNCTION query_axfr(text, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.query_axfr(text, text) IS 'Query a nameserver for the DNS zone transfer to use for auditing';


--
-- Name: query_dns_soa(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.query_dns_soa(text) RETURNS SETOF dns.soa
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::DNS;
	
	# Get the zone
	my $zone = shift(@_) or die "Unable to get DNS zone to query";

	# Date
	my $date = spi_exec_query("SELECT localtimestamp(0)");
	$date = $date->{rows}[0]->{timestamp};
	my $user = spi_exec_query("SELECT api.get_current_user()");
	$user = $user->{rows}[0]->{get_current_user};
	
	# Establish the resolver and make the query
	my $res = Net::DNS::Resolver->new;
	my $rr = $res->query($zone,'soa');

	# Check if it actually returned
	if(!defined($rr)) {
		die "Unable to find record for zone $zone";
	}
	
	# Spit out the serial
	my @answer = $rr->answer;
	return_next({zone=>$zone, nameserver=>$answer[0]->mname, ttl=>$answer[0]->ttl, contact=>$answer[0]->rname, serial=>$answer[0]->serial, refresh=>$answer[0]->refresh, retry=>$answer[0]->retry, expire=>$answer[0]->expire, minimum=>$answer[0]->minimum, date_created=>$date, date_modified=>$date, last_modifier=>$user});
	return undef;
$_$;


ALTER FUNCTION api.query_dns_soa(text) OWNER TO postgres;

--
-- Name: FUNCTION query_dns_soa(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.query_dns_soa(text) IS 'Use the hosts resolver to query and create an SOA';


--
-- Name: query_zone_serial(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.query_zone_serial(text) RETURNS text
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::DNS;
	
	# Get the zone
	my $zone = shift(@_) or die "Unable to get DNS zone to query";
	
	# Establish the resolver and make the query
	my $res = Net::DNS::Resolver->new;
	my $rr = $res->query($zone,'soa');

	# Check if it actually returned
	if(!defined($rr)) {
		die "Unable to find record for zone $zone";
	}
	
	# Spit out the serial
	my @answer = $rr->answer;
	return $answer[0]->serial;
$_$;


ALTER FUNCTION api.query_zone_serial(text) OWNER TO postgres;

--
-- Name: FUNCTION query_zone_serial(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.query_zone_serial(text) IS 'Query this hosts resolver for the serial number of the zone.';


--
-- Name: reload_cam(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.reload_cam(input_system_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF api.get_current_user() != (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system_name) THEN
				RAISE EXCEPTION 'Permission denied: Not owner';
			END IF;
		END IF;

		INSERT INTO "network"."cam_cache" ("system_name","mac","vlan","date_created","date_modified","last_modifier","ifindex") (
			SELECT input_system_name,mac,vlan,localtimestamp(0),localtimestamp(0),api.get_current_user(),ifindex
			FROM api.get_switchview_device_cam(input_system_name)
		);
		DELETE FROM "network"."cam_cache" WHERE "system_name" = input_system_name AND "date_created" != localtimestamp(0);
	END;
$$;


ALTER FUNCTION api.reload_cam(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION reload_cam(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.reload_cam(input_system_name text) IS 'Reload the cam cache for a system';


--
-- Name: reload_group_members(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.reload_group_members(input_group text) RETURNS SETOF management.group_members
    LANGUAGE plpgsql
    AS $$
	DECLARE
		MemberData RECORD;
		ReloadData RECORD;
		Settings RECORD;
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can reload group members';
		END IF;

		SELECT * INTO Settings FROM api.get_group_settings(input_group);

		IF Settings."provider" !~* 'ldap|vcloud|ad' THEN
			RAISE EXCEPTION 'Cannot reload local group';
		END IF;

		IF Settings."provider" IS NULL THEN
			RAISE EXCEPTION 'Cannot reload group with no provider: %',input_group;
		END IF;

		FOR MemberData IN (SELECT * FROM api.get_group_members(input_group)) LOOP
			PERFORM api.remove_group_member(input_group, MemberData."user");
		END LOOP;

		IF Settings."provider" ~* 'LDAP' THEN
			FOR ReloadData IN (SELECT * FROM api.get_ldap_group_members(Settings."hostname", Settings."id", Settings."username", Settings."password")) LOOP
				PERFORM api.create_group_member(input_group, ReloadData.get_ldap_group_members, Settings."privilege");
			END LOOP;
		END IF;
		
		IF Settings."provider" ~* 'vcloud' THEN
			FOR ReloadData IN (SELECT * FROM api.get_vcloud_group_members(Settings."hostname", Settings."id", Settings."username", Settings."password")) LOOP
				PERFORM api.create_group_member(input_group, ReloadData.get_vcloud_group_members, Settings."privilege");
			END LOOP;
        END IF;

		PERFORM api.syslog('reload_group_members:"'||input_group||'"');
		RETURN QUERY (SELECT * FROM api.get_group_members(input_group));
		
	END;
$$;


ALTER FUNCTION api.reload_group_members(input_group text) OWNER TO starrs;

--
-- Name: remove_availability_zone(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_availability_zone(input_datacenter text, input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied: Only admins can remove availability_zones';
		END IF;
		
		-- Perform delete
		DELETE FROM "systems"."availability_zones" WHERE "datacenter" = input_datacenter AND "zone" = input_zone;
		
		-- Done
		PERFORM api.syslog('remove_availability_zone:"'||input_datacenter||'","'||input_zone||'"');
	END;
$$;


ALTER FUNCTION api.remove_availability_zone(input_datacenter text, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION remove_availability_zone(input_datacenter text, input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_availability_zone(input_datacenter text, input_zone text) IS 'Remove an availability zone';


--
-- Name: remove_datacenter(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_datacenter(input_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied: Only admins can remove datacenters';
		END IF;
		
		-- Perform delete
		DELETE FROM "systems"."datacenters" WHERE "datacenter" = input_name;
		
		-- Done
		PERFORM api.syslog('remove_datacenter:"'||input_name||'"');
	END;
$$;


ALTER FUNCTION api.remove_datacenter(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION remove_datacenter(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_datacenter(input_name text) IS 'remove a datacenter';


--
-- Name: remove_dhcp_class(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dhcp_class(input_class text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to remove dhcp class denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Remove class
		DELETE FROM "dhcp"."classes" WHERE "class" = input_class;

		-- Done
		PERFORM api.syslog('remove_dhcp_class:"'||input_class||'"');
	END;
$$;


ALTER FUNCTION api.remove_dhcp_class(input_class text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dhcp_class(input_class text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dhcp_class(input_class text) IS 'Delete an existing DHCP class';


--
-- Name: remove_dhcp_class_option(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dhcp_class_option(input_class text, input_option text, input_value text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to remove dhcp class option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Remove class option		
		DELETE FROM "dhcp"."class_options"
		WHERE "class" = input_class AND "option" = input_option AND "value" = input_value;

		-- Done
		PERFORM api.syslog('remove_dhcp_class_option:"'||input_class||'","'||input_option||'","'||input_value||'"');
	END;
$$;


ALTER FUNCTION api.remove_dhcp_class_option(input_class text, input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dhcp_class_option(input_class text, input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dhcp_class_option(input_class text, input_option text, input_value text) IS 'Delete an existing DHCP class option';


--
-- Name: remove_dhcp_global_option(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dhcp_global_option(input_option text, input_value text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to remove dhcp global option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Delete global option		
		DELETE FROM "dhcp"."global_options"
		WHERE "option" = input_option AND "value" = input_value;

		-- Done
		PERFORM api.syslog('remove_dhcp_global_option:"'||input_option||'","'||input_value||'"');
	END;
$$;


ALTER FUNCTION api.remove_dhcp_global_option(input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dhcp_global_option(input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dhcp_global_option(input_option text, input_value text) IS 'Delete an existing DHCP global option';


--
-- Name: remove_dhcp_range_option(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dhcp_range_option(input_range text, input_option text, input_value text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to remove dhcp range option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Remove range option		
		DELETE FROM "dhcp"."range_options"
		WHERE "name" = input_range AND "option" = input_option;

		-- Done
		PERFORM api.syslog('remove_dhcp_range_option:"'||input_range||'","'||input_option||'","'||input_value||'"');
	END;
$$;


ALTER FUNCTION api.remove_dhcp_range_option(input_range text, input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dhcp_range_option(input_range text, input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dhcp_range_option(input_range text, input_option text, input_value text) IS 'Delete an existing DHCP range option';


--
-- Name: remove_dhcp_subnet_option(cidr, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			RAISE EXCEPTION 'Permission to remove dhcp subnet option denied for %. Not admin.',api.get_current_user();
		END IF;

		-- Delete subnet option		
		DELETE FROM "dhcp"."subnet_options"
		WHERE "subnet" = input_subnet AND "option" = input_option AND "value" = input_value;

		-- Done
		PERFORM api.syslog('remove_dhcp_subnet_option:"'||input_subnet||'","'||input_option||'","'||input_value||'"');
	END;
$$;


ALTER FUNCTION api.remove_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dhcp_subnet_option(input_subnet cidr, input_option text, input_value text) IS 'Delete an existing DHCP subnet option';


--
-- Name: remove_dns_address(inet, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_address(input_address inet, input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."a" WHERE "address" = input_address AND "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS address %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_address;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."a" WHERE "address" = input_address AND "zone" = input_zone;

		PERFORM api.syslog('remove_dns_address:"'||input_address||'","'||input_zone||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_address(input_address inet, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_address(input_address inet, input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_address(input_address inet, input_zone text) IS 'delete an A or AAAA record';


--
-- Name: remove_dns_cname(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_cname(input_alias text, input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."cname" WHERE "alias" = input_alias AND "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS CNAME %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_alias||'.'||input_zone;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."cname" WHERE "alias" = input_alias AND "zone" = input_zone;

		PERFORM api.syslog('remove_dns_cname:"'||input_alias||'","'||input_zone||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_cname(input_alias text, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_cname(input_alias text, input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_cname(input_alias text, input_zone text) IS 'remove a dns cname record for a host';


--
-- Name: remove_dns_key(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_key(input_keyname text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."keys" WHERE "keyname" = input_keyname) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on key %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_keyname;
			END IF;
		END IF;

		-- Remove key		
		DELETE FROM "dns"."keys" WHERE "keyname" = input_keyname;

		PERFORM api.syslog('remove_dns_key:"'||input_keyname||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_key(input_keyname text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_key(input_keyname text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_key(input_keyname text) IS 'Delete existing DNS key';


--
-- Name: remove_dns_mailserver(text, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_mailserver(input_zone text, input_preference integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."mx" WHERE "zone" = input_zone AND "preference" = input_preference) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS MX %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_hostname||'.'||input_zone;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."mx" WHERE "zone" = input_zone AND "preference" = input_preference;

		PERFORM api.syslog('remove_dns_mailserver:"'||input_zone||'","'||input_preference||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_mailserver(input_zone text, input_preference integer) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_mailserver(input_zone text, input_preference integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_mailserver(input_zone text, input_preference integer) IS 'Delete an existing MX record for a zone';


--
-- Name: remove_dns_ns(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_ns(input_zone text, input_nameserver text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS NS %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_nameserver;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."ns" WHERE "zone" = input_zone AND "nameserver" = input_nameserver;

		PERFORM api.syslog('remove_dns_ns:"'||input_zone||'","'||input_nameserver||'"');

	END;
$$;


ALTER FUNCTION api.remove_dns_ns(input_zone text, input_nameserver text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_ns(input_zone text, input_nameserver text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_ns(input_zone text, input_nameserver text) IS 'Remove a DNS NS record from the zone';


--
-- Name: remove_dns_soa(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_soa(input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on zone %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_soa;
			END IF;
		END IF;

		-- Delete soa
		DELETE FROM "dns"."soa"
		WHERE "zone" = input_zone;

		PERFORM api.syslog('remove_dns_soa:"'||input_zone||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_soa(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_soa(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_soa(input_zone text) IS 'Delete existing DNS soa';


--
-- Name: remove_dns_srv(text, text, integer, integer, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_srv(input_alias text, input_zone text, input_priority integer, input_weight integer, input_port integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."srv" WHERE "alias" = input_alias AND "zone" = input_zone AND "priority" = input_priority AND "weight" = input_weight AND "port" = input_port) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS SRV %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_alias||'.'||input_zone;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."srv" WHERE "alias" = input_alias AND "zone" = input_zone AND "priority" = input_priority AND "weight" = input_weight AND "port" = input_port;

		PERFORM api.syslog('remove_dns_srv:"'||input_alias||'","'||input_zone||'","'||input_priority||'","'||input_weight||'","'||input_port||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_srv(input_alias text, input_zone text, input_priority integer, input_weight integer, input_port integer) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_srv(input_alias text, input_zone text, input_priority integer, input_weight integer, input_port integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_srv(input_alias text, input_zone text, input_priority integer, input_weight integer, input_port integer) IS 'remove a dns srv record';


--
-- Name: remove_dns_txt(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_txt(input_hostname text, input_zone text, input_text text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."txt" WHERE "hostname" = input_hostname AND "zone" = input_zone AND "text" = input_text) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS TXT %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_hostname||'.'||input_zone;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."txt" WHERE "hostname" = input_hostname AND "zone" = input_zone AND "text" = input_text;

		PERFORM api.syslog('remove_dns_txt:"'||input_hostname||'","'||input_zone||'","'||input_text||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_txt(input_hostname text, input_zone text, input_text text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_txt(input_hostname text, input_zone text, input_text text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_txt(input_hostname text, input_zone text, input_text text) IS 'remove a dns text record for a host';


--
-- Name: remove_dns_zone(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_zone(input_zone text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on zone %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_zone;
			END IF;
		END IF;

		-- Delete zone
		DELETE FROM "dns"."zones"
		WHERE "zone" = input_zone;

		PERFORM api.syslog('remove_dns_zone:"'||input_zone||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_zone(input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_zone(input_zone text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_zone(input_zone text) IS 'Delete existing DNS zone';


--
-- Name: remove_dns_zone_a(text, inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_zone_a(input_zone text, input_address inet) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS zone %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_zone;
			END IF;
		END IF;

		-- Remove record
		DELETE FROM "dns"."zone_a" WHERE "address" = input_address AND "zone" = input_zone;

		PERFORM api.syslog('remove_dns_zone_a:"'||input_zone||'","'||input_address||'"');
	END;
$$;


ALTER FUNCTION api.remove_dns_zone_a(input_zone text, input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_zone_a(input_zone text, input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_zone_a(input_zone text, input_address inet) IS 'delete a zone A or AAAA record';


--
-- Name: remove_dns_zone_txt(text, text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_dns_zone_txt(input_hostname text, input_zone text, input_text text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "dns"."zones" WHERE "zone" = input_zone) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied for % (%) on DNS zone_txt %. You are not owner.',api.get_current_user(),api.get_current_user_level(),input_hostname||'.'||input_zone;
			END IF;
		END IF;

		-- Remove record
		IF input_hostname IS NULL THEN
			PERFORM api.syslog('remove_dns_zone_txt:"'||input_zone||'","'||input_text||'"');
			DELETE FROM "dns"."zone_txt" WHERE "hostname" IS NULL AND "zone" = input_zone AND "text" = input_text;
		ELSE
			PERFORM api.syslog('remove_dns_zone_txt:"'||input_hostname||'","'||input_zone||'","'||input_text||'"');
			DELETE FROM "dns"."zone_txt" WHERE "hostname" = input_hostname AND "zone" = input_zone AND "text" = input_text;
		END IF;

	END;
$$;


ALTER FUNCTION api.remove_dns_zone_txt(input_hostname text, input_zone text, input_text text) OWNER TO starrs;

--
-- Name: FUNCTION remove_dns_zone_txt(input_hostname text, input_zone text, input_text text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_dns_zone_txt(input_hostname text, input_zone text, input_text text) IS 'remove a dns text record for a host';


--
-- Name: remove_group(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_group(input_group text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can remove groups.';
		END IF;

		DELETE FROM "management"."groups" WHERE "group" = input_group;

		PERFORM api.syslog('remove_group:"'||input_group||'"');
	END;
$$;


ALTER FUNCTION api.remove_group(input_group text) OWNER TO starrs;

--
-- Name: FUNCTION remove_group(input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_group(input_group text) IS 'Remove a group';


--
-- Name: remove_group_member(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_group_member(input_group text, input_user text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF api.get_current_user() NOT IN (SELECT * FROM api.get_group_admins(input_group)) THEN
				RAISE EXCEPTION 'Permission denied. Only admins can remove groups members';
			END IF;
		END IF;

		DELETE FROM "management"."group_members" WHERE "group" = input_group AND "user" = input_user;

		PERFORM api.syslog('remove_group_member:"'||input_group||'","'||input_user||'"');	
	END;
$$;


ALTER FUNCTION api.remove_group_member(input_group text, input_user text) OWNER TO starrs;

--
-- Name: FUNCTION remove_group_member(input_group text, input_user text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_group_member(input_group text, input_user text) IS 'Remove a group member';


--
-- Name: remove_group_settings(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_group_settings(input_group text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can remove group provider settings';
		END IF;

		DELETE FROM "management"."group_settings" WHERE "group" = input_group;

		PERFORM api.syslog('remove_group_settings:"'||input_group||'"');
	END;
$$;


ALTER FUNCTION api.remove_group_settings(input_group text) OWNER TO starrs;

--
-- Name: FUNCTION remove_group_settings(input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_group_settings(input_group text) IS 'remove group authentication providers';


--
-- Name: remove_interface(macaddr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_interface(input_mac macaddr) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."interfaces" 
			JOIN "systems"."systems" ON "systems"."systems"."system_name" = "systems"."interfaces"."system_name"
			WHERE "systems"."interfaces"."mac" = input_mac) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on interface %. You are not owner.',input_mac;
			END IF;
		END IF;

		-- Remove interface
		DELETE FROM "systems"."interfaces" WHERE "mac" = input_mac;

		-- Done
		PERFORM api.syslog('remove_interface:"'||input_mac||'"');
	END;
$$;


ALTER FUNCTION api.remove_interface(input_mac macaddr) OWNER TO starrs;

--
-- Name: FUNCTION remove_interface(input_mac macaddr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_interface(input_mac macaddr) IS 'delete an interface based on MAC address';


--
-- Name: remove_interface_address(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_interface_address(input_address inet) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN

		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."interface_addresses" 
			JOIN "systems"."interfaces" ON "systems"."interfaces"."mac" = "systems"."interface_addresses"."mac"
			JOIN "systems"."systems" ON "systems"."systems"."system_name" = "systems"."interfaces"."system_name"
			WHERE "systems"."interface_addresses"."address" = input_address) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on interface address %. You are not owner.',input_address;
			END IF;
		END IF;

		-- Remove address
		DELETE FROM "systems"."interface_addresses" WHERE "address" = input_address;

		-- Done
		PERFORM api.syslog('remove_interface_address:"'||input_address||'"');
	END;
$$;


ALTER FUNCTION api.remove_interface_address(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION remove_interface_address(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_interface_address(input_address inet) IS 'delete an interface address';


--
-- Name: remove_ip_range(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_ip_range(input_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "ip"."subnets" WHERE "subnet" = 
			(SELECT "subnet" FROM "ip"."ranges" WHERE "name" = input_range)) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to delete range % denied. Not owner',input_name;
			END IF;
		END IF;

		-- Delete range		
		DELETE FROM "ip"."ranges" WHERE "name" = input_name;

		-- Done
		PERFORM api.syslog('remove_ip_range:"'||input_name||'"');
	END;
$$;


ALTER FUNCTION api.remove_ip_range(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION remove_ip_range(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_ip_range(input_name text) IS 'Delete an existing IP range';


--
-- Name: remove_ip_subnet(cidr); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_ip_subnet(input_subnet cidr) RETURNS void
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
		WasAuto BOOLEAN;
	BEGIN
		-- Check privileges
		IF (api.get_current_user_level() !~* 'ADMIN') THEN
			IF (SELECT "owner" FROM "ip"."subnets" WHERE "subnet" = input_subnet) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission to delete subnet % denied. Not owner',input_subnet;
			END IF;
		END IF;

		-- Delete RDNS zone
		PERFORM api.remove_dns_zone(api.get_reverse_domain(input_subnet));

		-- Delete subnet
		DELETE FROM "ip"."subnets" WHERE "subnet" = input_subnet;

		-- Done
		PERFORM api.syslog('remove_ip_subnet:"'||input_subnet||'"');
	END;
$$;


ALTER FUNCTION api.remove_ip_subnet(input_subnet cidr) OWNER TO starrs;

--
-- Name: FUNCTION remove_ip_subnet(input_subnet cidr); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_ip_subnet(input_subnet cidr) IS 'Delete/deactivate an existing subnet';


--
-- Name: remove_libvirt_domain(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_libvirt_domain(input_host text, input_domain text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "system"."systems" WHERE "system_name" = input_host) != api.get_current_user() THEN
				RAISE EXCEPTION 'Only admins can remove VM hosts';
			END IF;
			IF (SELECT "owner" FROM "system"."systems" WHERE "system_name" = input_domain) != api.get_current_user() THEN
				RAISE EXCEPTION 'Only admins can remove VM hosts';
			END IF;
		END IF;

		DELETE FROM "libvirt"."domains" WHERE "domain_name" = input_domain AND "host_name" = input_host;
	END;
$$;


ALTER FUNCTION api.remove_libvirt_domain(input_host text, input_domain text) OWNER TO starrs;

--
-- Name: FUNCTION remove_libvirt_domain(input_host text, input_domain text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_libvirt_domain(input_host text, input_domain text) IS 'Remove a libvirt domain';


--
-- Name: remove_libvirt_host(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_libvirt_host(input_system text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Only admins can remove VM hosts';
		END IF;
		
		DELETE FROM "libvirt"."hosts" WHERE "system_name" = input_system;
	END;
$$;


ALTER FUNCTION api.remove_libvirt_host(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION remove_libvirt_host(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_libvirt_host(input_system text) IS 'Remove libvirt connection credentials for a system';


--
-- Name: remove_libvirt_platform(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_libvirt_platform(input_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Only admins can remove VM hosts';
		END IF;

		DELETE FROM "libvirt"."platforms" WHERE "platform_name" = input_name;
	END;
$$;


ALTER FUNCTION api.remove_libvirt_platform(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION remove_libvirt_platform(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_libvirt_platform(input_name text) IS 'Remove libvirt platform';


--
-- Name: remove_network_snmp(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_network_snmp(input_system text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied: you are not owner';
			END IF;
		END IF;
		
		-- Create it
		DELETE FROM "network"."snmp" WHERE "system_name" = input_system;
		
		-- Done
		PERFORM api.syslog('remove_network_snmp:"'||input_system||'"');
	END;
$$;


ALTER FUNCTION api.remove_network_snmp(input_system text) OWNER TO starrs;

--
-- Name: FUNCTION remove_network_snmp(input_system text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_network_snmp(input_system text) IS 'Remove credentials for a system';


--
-- Name: remove_platform(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_platform(input_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied: Only admins can remove platforms'; 
		END IF;

		DELETE FROM "systems"."platforms" WHERE "platform_name" = input_name;
	END;
$$;


ALTER FUNCTION api.remove_platform(input_name text) OWNER TO starrs;

--
-- Name: FUNCTION remove_platform(input_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_platform(input_name text) IS 'Remove a platform';


--
-- Name: remove_range_group(text, text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_range_group(input_range text, input_group text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Only admins can assign range resources to groups';
		END IF;

		-- Remove
		DELETE FROM "ip"."range_groups" WHERE "range_name" = input_range AND "group_name" = input_group;

		-- Done
		PERFORM api.syslog('remove_range_group:"'||input_range||'","'||input_group||'"');
	END;
$$;


ALTER FUNCTION api.remove_range_group(input_range text, input_group text) OWNER TO starrs;

--
-- Name: FUNCTION remove_range_group(input_range text, input_group text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_range_group(input_range text, input_group text) IS 'Remove a range group';


--
-- Name: remove_site_configuration(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_site_configuration(input_directive text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied. Only admins can remove site directives';
		END IF;

		-- Create directive
		DELETE FROM "management"."configuration" WHERE "option" = input_directive;

		-- Done
		PERFORM api.syslog('remove_site_configuration:"'||input_directive||'"');
	END;
$$;


ALTER FUNCTION api.remove_site_configuration(input_directive text) OWNER TO starrs;

--
-- Name: FUNCTION remove_site_configuration(input_directive text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_site_configuration(input_directive text) IS 'Remove a site configuration directive';


--
-- Name: remove_system(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_system(input_system_name text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			IF (SELECT "owner" FROM "systems"."systems" WHERE "system_name" = input_system_name) != api.get_current_user() THEN
				RAISE EXCEPTION 'Permission denied on system %. You are not owner.',input_system_name;
			END IF;
		END IF;

		-- Remove system
		DELETE FROM "systems"."systems" WHERE "system_name" = input_system_name;

		-- Done
		PERFORM api.syslog('remove_system:"'||input_system_name||'"');
	END;
$$;


ALTER FUNCTION api.remove_system(input_system_name text) OWNER TO starrs;

--
-- Name: FUNCTION remove_system(input_system_name text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_system(input_system_name text) IS 'Delete an existing system';


--
-- Name: remove_users_systems(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_users_systems(username text) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		
		-- Check privileges
		IF api.get_current_user_level() !~* 'ADMIN' THEN
			RAISE EXCEPTION 'Permission denied: Only admins can remove all systems from a user';
		END IF;
		
		-- Perform delete
		DELETE FROM "systems"."systems" WHERE "owner" = username;
		
		-- Done
		PERFORM api.syslog('remove_users_systems:"'||username||'"');
	END;
$$;


ALTER FUNCTION api.remove_users_systems(username text) OWNER TO starrs;

--
-- Name: FUNCTION remove_users_systems(username text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_users_systems(username text) IS 'Remove all systems owned by a user';


--
-- Name: remove_vlan(text, integer); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.remove_vlan(input_datacenter text, input_vlan integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
     BEGIN
          IF api.get_current_user_level() !~* 'ADMIN' THEN
               RAISE EXCEPTION 'Only admins can remove VLANs';
          END IF;

          DELETE FROM "network"."vlans" WHERE "datacenter" = input_datacenter AND "vlan" = input_vlan;
		PERFORM api.syslog('remove_vlan:"'||input_datacenter||'","'||input_vlan||'"');
     END;
$$;


ALTER FUNCTION api.remove_vlan(input_datacenter text, input_vlan integer) OWNER TO starrs;

--
-- Name: FUNCTION remove_vlan(input_datacenter text, input_vlan integer); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.remove_vlan(input_datacenter text, input_vlan integer) IS 'Remove a VLAN';


--
-- Name: renew_interface_address(inet); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.renew_interface_address(input_address inet) RETURNS void
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE "systems"."interface_addresses"
		SET "renew_date" = date(('now'::text)::date + (SELECT "renew_interval" FROM "management"."groups" JOIN "systems"."systems" ON "systems"."systems"."group" = "management"."groups"."group" WHERE "system_name" = api.get_interface_address_system(input_address)))
		WHERE "address" = input_address;

	END;
$$;


ALTER FUNCTION api.renew_interface_address(input_address inet) OWNER TO starrs;

--
-- Name: FUNCTION renew_interface_address(input_address inet); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.renew_interface_address(input_address inet) IS 'renew an interface address registration for another interval';


--
-- Name: resolve(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.resolve(text) RETURNS inet
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Socket qw(inet_ntoa);
	
	my $hostname = shift() or die "Unable to get name argument";
	my ($name,$aliases,$addrtype,$length,@addrs) = gethostbyname($hostname);
	return inet_ntoa($addrs[0]);
$_$;


ALTER FUNCTION api.resolve(text) OWNER TO postgres;

--
-- Name: send_renewal_email(text, inet, text, text, text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.send_renewal_email(text, inet, text, text, text, text) RETURNS void
    LANGUAGE plperlu
    AS $_$
	use strict;
	use warnings;
	use Net::SMTP;
    use POSIX;

	my $email = shift(@_) or die "Unable to get email";
	my $address = shift(@_) or die "Unable to get address";
	my $system = shift(@_) or die "Unable to get system";
	my $domain = shift(@_) or die "Unable to get mail domain";
	my $url = shift(@_) or die "Unable to get URL";
	my $mailserver = shift(@_) or die "Unable to get mailserver";

	my $smtp = Net::SMTP->new($mailserver);

	if(!$smtp) { die "Unable to connect to \"$mailserver\"\n"; }

	$smtp->mail("starrs-noreply\@$domain");
	$smtp->recipient("$email");
	$smtp->data;
	$smtp->datasend("Date: " . strftime("%a, %d %b %Y %H:%M:%S %z", localtime) . "\n"); 
	$smtp->datasend("From: starrs-noreply\@$domain\n");
	$smtp->datasend("To: $email\n");
	$smtp->datasend("Subject: STARRS Renewal Notification - $address\n");
	$smtp->datasend("\n");
	$smtp->datasend("Your registered address $address on system $system will expire in less than 7 days and may be removed from STARRS automatically. You can click $url/addresses/viewrenew to renew your address(s). Alternatively you can navigate to the Interface Address view and click the Renew button. If you have any questions, please see your local system administrator.");

	$smtp->datasend;
	$smtp->quit;
$_$;


ALTER FUNCTION api.send_renewal_email(text, inet, text, text, text, text) OWNER TO postgres;

--
-- Name: FUNCTION send_renewal_email(text, inet, text, text, text, text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.send_renewal_email(text, inet, text, text, text, text) IS 'Send an email to a user saying their address is about to expire';


--
-- Name: syslog(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.syslog(input_message text) RETURNS void
    LANGUAGE plperlu
    AS $_$
	#!/usr/bin/perl
	use strict;
	use warnings;
	use Sys::Syslog qw( :DEFAULT setlogsock);

	#my $sev = shift(@_) or die "Unable to get severity";
	my $sev = "info";
	my $msg = shift(@_) or die "Unable to get message.";
	my $facility = spi_exec_query("SELECT api.get_site_configuration('SYSLOG_FACILITY')")->{rows}[0]->{"get_site_configuration"};
	my $user= spi_exec_query("SELECT api.get_current_user()")->{rows}[0]->{"get_current_user"};
	setlogsock('unix');
	openlog("STARRS",'',$facility);
	syslog($sev, "$user $msg");
	closelog;
$_$;


ALTER FUNCTION api.syslog(input_message text) OWNER TO postgres;

--
-- Name: FUNCTION syslog(input_message text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.syslog(input_message text) IS 'Log to syslog';


--
-- Name: validate_domain(text, text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.validate_domain(hostname text, domain text) RETURNS boolean
    LANGUAGE plperlu
    AS $_X$
	use strict;
	use warnings;
	use Data::Validate::Domain qw(is_domain);
	# die("LOLZ");

	# Usage: PERFORM api.validate_domain([hostname OR NULL],[domain OR NULL]);

	# Declare the string to check later on
	my $domain;

	# This script can deal with just domain validation rather than host-domain. Note that the
	# module this depends on requires a valid TLD, so one is picked for this purpose.
	if (!$_[0])
	{
		# We are checking a domain name only
		$domain = $_[1];
	}
	elsif (!$_[1])
	{
		# We are checking a hostname only
		$domain = "$_[0].me";
	}
	else
	{
		# We have enough for a FQDN
		$domain = "$_[0].$_[1]";
	}

    if($_[0] eq "0") {
        return 'TRUE';
    }

	# Return a boolean value of whether the input forms a valid domain
	if (is_domain($domain))
	{
		return 'TRUE';
	}
	else
	{
		# This module sucks and should be disabled
		#return 'TRUE';
		# Seems to be working normally... Keep an eye on your domain validation
		return 'FALSE';
	}
$_X$;


ALTER FUNCTION api.validate_domain(hostname text, domain text) OWNER TO postgres;

--
-- Name: FUNCTION validate_domain(hostname text, domain text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.validate_domain(hostname text, domain text) IS 'Validate hostname, domain, FQDN based on known rules. Requires Perl module';


--
-- Name: validate_name(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.validate_name(input text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
		BadCrap TEXT;
	BEGIN
		BadCrap = regexp_replace(input, E'[a-z0-9\:\_\/ ]*\-*', '', 'gi');
		IF BadCrap != '' THEN
			RAISE EXCEPTION 'Invalid characters detected in string "%"',input;
		END IF;
		IF input = '' THEN
			RAISE EXCEPTION 'Name cannot be blank';
		END IF;
		RETURN input;
	END;
$$;


ALTER FUNCTION api.validate_name(input text) OWNER TO starrs;

--
-- Name: FUNCTION validate_name(input text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.validate_name(input text) IS 'Allow certain characters for names';


--
-- Name: validate_nospecial(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.validate_nospecial(input text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	DECLARE
		BadCrap TEXT;
	BEGIN
		BadCrap = regexp_replace(input, E'[a-z0-9]*', '', 'gi');
		IF BadCrap != '' THEN
			RAISE EXCEPTION 'Invalid characters detected in string "%"',input;
		END IF;
		RETURN input;
	END;
$$;


ALTER FUNCTION api.validate_nospecial(input text) OWNER TO starrs;

--
-- Name: FUNCTION validate_nospecial(input text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.validate_nospecial(input text) IS 'Block all special characters';


--
-- Name: validate_soa_contact(text); Type: FUNCTION; Schema: api; Owner: starrs
--

CREATE FUNCTION api.validate_soa_contact(input text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
	DECLARE
		BadCrap TEXT;
	BEGIN
		BadCrap = regexp_replace(input, E'[a-z0-9\.]*\-*', '', 'gi');
		IF BadCrap != '' THEN
			RAISE EXCEPTION 'Invalid characters detected in string "%"',input;
		END IF;
		IF input = '' THEN
			RAISE EXCEPTION 'Contact cannot be blank';
		END IF;
		RETURN TRUE;
	END;
$$;


ALTER FUNCTION api.validate_soa_contact(input text) OWNER TO starrs;

--
-- Name: FUNCTION validate_soa_contact(input text); Type: COMMENT; Schema: api; Owner: starrs
--

COMMENT ON FUNCTION api.validate_soa_contact(input text) IS 'Ensure that the SOA contact is properly formatted';


--
-- Name: validate_srv(text); Type: FUNCTION; Schema: api; Owner: postgres
--

CREATE FUNCTION api.validate_srv(text) RETURNS boolean
    LANGUAGE plperl
    AS $_X$	my $srv = $_[0];
	my @parts = split('\.',$srv);
	# Check for two parts: the service and the transport
	if (scalar(@parts) ne 2)
	{
		die "Improper number of parts in record\n";
	}

	# Define parts of the record
	my $service = $parts[0];
	my $transport = $parts[1];

	# Check if transport is valid
	if ($transport !~ m/_tcp|_udp/i)
	{
		return "false";
	}

	# Check that service is valid
	if ($service !~ m/^_[\w-]+$/i)
	{
		return "false";
	}
	
	# Good!
	return "true";
$_X$;


ALTER FUNCTION api.validate_srv(text) OWNER TO postgres;

--
-- Name: FUNCTION validate_srv(text); Type: COMMENT; Schema: api; Owner: postgres
--

COMMENT ON FUNCTION api.validate_srv(text) IS 'Validate SRV records';


--
-- Name: a_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.a_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	DECLARE
		RowCount INTEGER;
	BEGIN
		/*
		-- Check for zone mismatch
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."subnets"
		WHERE "ip"."subnets"."zone" = NEW."zone"
		AND NEW."address" << "ip"."subnets"."subnet";
		IF (RowCount < 1) THEN 
			RAISE EXCEPTION 'IP address and DNS Zone do not match (%, %)',NEW."address",NEW."zone";
		END IF;
		*/
		-- Autofill type

		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.a_insert() OWNER TO starrs;

--
-- Name: FUNCTION a_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.a_insert() IS 'Creating a new A or AAAA record';


--
-- Name: a_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.a_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Address/Zone mismatch
		IF NEW."address" != OLD."address" THEN
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."subnets"
			WHERE "ip"."subnets"."zone" = NEW."zone"
			AND NEW."address" << "ip"."subnets"."subnet";
			IF (RowCount < 1) THEN 
				RAISE EXCEPTION 'IP address and DNS Zone do not match (%, %)',NEW."address",NEW."zone";
			END IF;
			
			-- Autofill Type
		END IF;
		
		-- New zone mismatch
		IF NEW."zone" != OLD."zone" THEN
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."subnets"
			WHERE "ip"."subnets"."zone" = NEW."zone"
			AND NEW."address" << "ip"."subnets"."subnet";
			IF (RowCount < 1) THEN 
				RAISE EXCEPTION 'IP address and DNS Zone do not match (%, %)',NEW."address",NEW."zone";
			END IF;
		END IF;

		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.a_update() OWNER TO starrs;

--
-- Name: FUNCTION a_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.a_update() IS 'Update an existing A or AAAA record';


--
-- Name: cname_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.cname_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Check if alias name already exists
		SELECT COUNT(*) INTO RowCount
		FROM "dns"."a"
		WHERE "dns"."a"."hostname" = NEW."alias";
		IF (RowCount > 0) THEN
			RAISE EXCEPTION 'Alias name (%) already exists',NEW."alias";
		END IF;
		
		SELECT COUNT(*) INTO RowCount
		FROM "dns"."srv"
		WHERE "dns"."srv"."alias" = NEW."alias";
		IF (RowCount > 0) THEN
			RAISE EXCEPTION 'Alias name (%) already exists as a SRV',NEW."alias";
		END IF;
		
		-- Autopopulate address
		NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.cname_insert() OWNER TO starrs;

--
-- Name: FUNCTION cname_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.cname_insert() IS 'Check if the alias already exists as an address record';


--
-- Name: cname_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.cname_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Check if alias name already exists
		IF NEW."alias" != OLD."alias" THEN	
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."a"
			WHERE "dns"."a"."hostname" = NEW."alias";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'Alias name (%) already exists',NEW."alias";
			END IF;
			
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."srv"
			WHERE "dns"."srv"."alias" = NEW."alias";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'Alias name (%) already exists as a SRV',NEW."alias";
			END IF;
		END IF;
		
		-- Autopopulate address
		IF NEW."address" != OLD."address" THEN
			NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		END IF;
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.cname_update() OWNER TO starrs;

--
-- Name: FUNCTION cname_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.cname_update() IS 'Check if the new alias already exists as an address record';


--
-- Name: dns_autopopulate_address(text, text); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.dns_autopopulate_address(input_hostname text, input_zone text) RETURNS inet
    LANGUAGE plpgsql
    AS $$
	DECLARE
		address INET;
	BEGIN
		SELECT "dns"."a"."address" INTO address
		FROM "dns"."a"
		WHERE "dns"."a"."hostname" = input_hostname
		AND "dns"."a"."zone" = input_zone LIMIT 1;
		
		IF address IS NULL THEN
			RAISE EXCEPTION 'Unable to find address for given host % and zone %',input_hostname,input_zone;
		ELSE
			RETURN address;
		END IF;
	END;
$$;


ALTER FUNCTION dns.dns_autopopulate_address(input_hostname text, input_zone text) OWNER TO starrs;

--
-- Name: FUNCTION dns_autopopulate_address(input_hostname text, input_zone text); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.dns_autopopulate_address(input_hostname text, input_zone text) IS 'Fill in the address portion of the foreign key relationship';


--
-- Name: mx_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.mx_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.mx_insert() OWNER TO starrs;

--
-- Name: FUNCTION mx_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.mx_insert() IS 'Create new MX record';


--
-- Name: mx_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.mx_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF NEW."address" != OLD."address" THEN
			NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.mx_update() OWNER TO starrs;

--
-- Name: FUNCTION mx_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.mx_update() IS 'Modify a MX record';


--
-- Name: ns_query_delete(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.ns_query_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT; -- Return code from the nsupdate function
		DnsKeyName TEXT; -- The DNS keyname to sign with
		DnsKey TEXT; -- The DNS key to sign with
		DnsServer INET; -- The nameserver to send the update to
		DnsRecord TEXT; -- The formatted string that is the record
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = OLD."zone") IS FALSE THEN
			RETURN OLD;
		END IF;
		
		-- If this is a forward zone:
		IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = OLD."zone") IS TRUE THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = OLD."zone";
		-- If this is a reverse zone:
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = OLD."zone");
		END IF;
		
		-- Just make sure no-one is forcing a bogus type
		IF OLD."type" !~* '^NS$' THEN
			RAISE EXCEPTION 'Trying to create a non-NS record in an NS table!';
		END IF;
		
		-- Create and fire off the update
		DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."nameserver";
		ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing NS-DELETE %',ReturnCode,DnsRecord;
		END IF;
		
		-- Done!
		RETURN OLD;
	END;
$_$;


ALTER FUNCTION dns.ns_query_delete() OWNER TO starrs;

--
-- Name: FUNCTION ns_query_delete(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.ns_query_delete() IS 'Delete an old NS record from the server';


--
-- Name: ns_query_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.ns_query_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT; -- Return code from the nsupdate function
		DnsKeyName TEXT; -- The DNS keyname to sign with
		DnsKey TEXT; -- The DNS key to sign with
		DnsServer INET; -- The nameserver to send the update to
		DnsRecord TEXT; -- The formatted string that is the record
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = NEW."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		-- If this is a forward zone:
		IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = NEW."zone") IS TRUE THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key","address" 
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."ns" 
			JOIN "dns"."zones" ON "dns"."ns"."zone" = "dns"."zones"."zone" 
			JOIN "dns"."keys" ON "dns"."zones"."keyname" = "dns"."keys"."keyname"
			WHERE "dns"."ns"."zone" = NEW."zone" AND "dns"."ns"."nameserver" IN (SELECT "nameserver" FROM "dns"."soa" WHERE "dns"."soa"."zone" = NEW."zone");
		-- If this is a reverse zone:
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key","dns"."ns"."address"
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."ns"
			JOIN "dns"."zones" ON "dns"."ns"."zone" = "dns"."zones"."zone"
			JOIN "dns"."keys" ON "dns"."zones"."keyname" = "dns"."keys"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."ns"."zone"
			WHERE "dns"."ns"."nameserver" = "dns"."soa"."nameserver"
			AND "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = NEW."zone");
		END IF;
		
		-- Just make sure no-one is forcing a bogus type
		IF NEW."type" !~* '^NS$' THEN
			RAISE EXCEPTION 'Trying to create a non-NS record in an NS table!';
		END IF;
		
		-- Create and fire off the update
		DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."nameserver";
		ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
		END IF;
		
		-- Done!
		RETURN NEW;
	END;
$_$;


ALTER FUNCTION dns.ns_query_insert() OWNER TO starrs;

--
-- Name: FUNCTION ns_query_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.ns_query_insert() IS 'Update the nameserver with a new NS record';


--
-- Name: ns_query_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.ns_query_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT; -- Return code from the nsupdate function
		DnsKeyName TEXT; -- The DNS keyname to sign with
		DnsKey TEXT; -- The DNS key to sign with
		DnsServer INET; -- The nameserver to send the update to
		DnsRecord TEXT; -- The formatted string that is the record
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = OLD."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		-- If this is a forward zone:
		IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = NEW."zone") IS TRUE THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";
		-- If this is a reverse zone:
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = NEW."zone");
		END IF;
		
		-- Just make sure no-one is forcing a bogus type
		IF NEW."type" !~* '^NS$' THEN
			RAISE EXCEPTION 'Trying to create a non-NS record in an NS table!';
		END IF;
		
		-- Delete the record first
		DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."nameserver";
		ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing NS-UPDATE-DELETE %',ReturnCode,DnsRecord;
		END IF;
		
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = NEW."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		-- Create and fire off the update
		DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."nameserver";
		ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing NS-UPDATE-INSERT %',ReturnCode,DnsRecord;
		END IF;
		
		-- Done!
		RETURN NEW;
	END;
$_$;


ALTER FUNCTION dns.ns_query_update() OWNER TO starrs;

--
-- Name: FUNCTION ns_query_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.ns_query_update() IS 'Update the nameserver with a new NS record';


--
-- Name: queue_delete(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.queue_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT;
		DnsKeyName TEXT;
		DnsKey TEXT;
		DnsServer INET;
		DnsRecord TEXT;
		RevZone TEXT;
		RevSubnet CIDR;
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = OLD."zone") IS FALSE THEN
			RETURN OLD;
		END IF;


	     -- This needs cleaned up a lot. See github bug #211 for more details. This fix works but is
		-- not exactly great.
		IF true THEN
	
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = OLD."zone";

			IF OLD."type" ~* '^A|AAAA$' THEN
				--NULL hostname means zone address
				IF OLD."hostname" IS NULL THEN
					DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||host(OLD."address");
					ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
				ELSE
					-- Do the forward record first
					DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||host(OLD."address");
					ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);

					-- Check for errors
					IF ReturnCode != '0' THEN
						RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
					END IF;	

					-- Get the proper zone for the reverse A record
					SELECT "zone" INTO RevZone
					FROM "ip"."subnets" 
					WHERE OLD."address" << "subnet";
					
					-- Get the subnet
					SELECT "subnet" INTO RevSubnet
					FROM "ip"."subnets"
					WHERE OLD."address" << "subnet";

					-- If it is in this domain, add the reverse entry
					IF RevZone = OLD."zone" AND OLD."reverse" IS TRUE AND NOT OLD."address" << api.get_site_configuration('DYNAMIC_SUBNET')::cidr THEN
						DnsRecord := api.get_reverse_domain(OLD."address")||' '||OLD."ttl"||' PTR '||OLD."hostname"||'.'||OLD."zone"||'.';
						ReturnCode := api.nsupdate(api.get_reverse_domain(RevSubnet),DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
					END IF;
				END IF;

			ELSEIF OLD."type" ~* '^NS$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."nameserver";
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^MX$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."preference"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^SRV$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."priority"||' '||OLD."weight"||' '||OLD."port"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^CNAME$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^TXT$' THEN
				-- For zone TXT records
				IF OLD."hostname" IS NULL THEN
					DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				ELSE
					DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			END IF;

			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
			END IF;
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = OLD."zone";

			IF OLD."type" ~* '^NS$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."nameserver";
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^MX$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."preference"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^SRV$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."priority"||' '||OLD."weight"||' '||OLD."port"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^CNAME$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			ELSEIF OLD."type" ~* '^TXT$' THEN
				-- For zone TXT records
				IF OLD."hostname" IS NULL THEN
					DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				ELSE
					DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			END IF;

			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
			END IF;
		END IF;
		
		RETURN OLD;
	END;
$_$;


ALTER FUNCTION dns.queue_delete() OWNER TO starrs;

--
-- Name: FUNCTION queue_delete(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.queue_delete() IS 'Add a delete directive to the queue';


--
-- Name: queue_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.queue_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$	DECLARE
		ReturnCode TEXT;
		DnsKeyName TEXT;
		DnsKey TEXT;
		DnsServer INET;
		DnsRecord TEXT;
		RevZone TEXT;
		RevSubnet CIDR;
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = NEW."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		IF (SELECT "config" FROM api.get_system_interface_address(NEW."address")) ~* 'static|dhcpv6' THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";

			IF NEW."type" ~* '^A|AAAA$' THEN
				--NULL hostname means zone address
				IF NEW."hostname" IS NULL THEN
					DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||host(NEW."address");
					ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
				ELSE
					-- Do the forward record first
					DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||host(NEW."address");
					ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);

					-- Check for errors
					IF ReturnCode != '0' THEN
						RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
					END IF;	

					-- Get the proper zone for the reverse A record
					SELECT "zone" INTO RevZone
					FROM "ip"."subnets" 
					WHERE NEW."address" << "subnet";

					-- Get the subnet
					SELECT "subnet" INTO RevSubnet
					FROM "ip"."subnets"
					WHERE NEW."address" << "subnet";

					-- If it is in this domain, add the reverse entry
					IF RevZone = NEW."zone" AND NEW."reverse" IS TRUE THEN
						DnsRecord := api.get_reverse_domain(NEW."address")||' '||NEW."ttl"||' PTR '||NEW."hostname"||'.'||NEW."zone"||'.';
						ReturnCode := api.nsupdate(api.get_reverse_domain(RevSubnet),DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
					END IF;
				END IF;

			ELSEIF NEW."type" ~* '^NS$' THEN
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."nameserver";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^MX$' THEN
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."preference"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^SRV$' THEN	
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."priority"||' '||NEW."weight"||' '||NEW."port"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^CNAME$' THEN
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^TXT$' THEN
				-- For zone TXT records
				IF NEW."hostname" IS NULL THEN
					DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				ELSE
					DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			END IF;

			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
			END IF;
		ELSE 
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";

			IF NEW."type" ~* '^NS$' THEN
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."nameserver";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^MX$' THEN
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."preference"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^SRV$' THEN	
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."priority"||' '||NEW."weight"||' '||NEW."port"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^CNAME$' THEN
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^TXT$' THEN
				-- For zone TXT records
				IF NEW."hostname" IS NULL THEN
					DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				ELSE
					DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			END IF;

			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
			END IF;
		END IF;
		
		RETURN NEW;
	END;$_$;


ALTER FUNCTION dns.queue_insert() OWNER TO starrs;

--
-- Name: FUNCTION queue_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.queue_insert() IS 'Add an add directive to the queue';


--
-- Name: queue_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.queue_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$	DECLARE
		ReturnCode TEXT;
		DnsKeyName TEXT;
		DnsKey TEXT;
		DnsServer INET;
		DnsRecord TEXT;
		RevZone TEXT;
		RevSubnet CIDR;
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = NEW."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		IF (SELECT "config" FROM api.get_system_interface_address(NEW."address")) ~* 'static|dhcpv6' THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";
			
			IF NEW."type" ~* '^A|AAAA$' THEN
				--NULL hostname means zone address
				IF NEW."hostname" IS NULL THEN
					DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||host(OLD."address");
					ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
				
					DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||host(NEW."address");
					ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
				ELSE
					-- Do the forward record first
					DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||host(OLD."address");
					ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);

					-- Check for errors
					IF ReturnCode != '0' THEN
						RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
					END IF;	

					-- Get the proper zone for the reverse A record
					SELECT "zone" INTO RevZone
					FROM "ip"."subnets" 
					WHERE OLD."address" << "subnet";
					
					-- Get the subnet
					SELECT "subnet" INTO RevSubnet
					FROM "ip"."subnets"
					WHERE OLD."address" << "subnet";

					-- If it is in this domain, add the reverse entry
					IF RevZone = OLD."zone" AND OLD."reverse" IS TRUE THEN
						DnsRecord := api.get_reverse_domain(OLD."address")||' '||OLD."ttl"||' PTR '||OLD."hostname"||'.'||OLD."zone"||'.';
						ReturnCode := Returncode||api.nsupdate(api.get_reverse_domain(RevSubnet),DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
					END IF;

					-- Do the forward record first
					DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||host(NEW."address");
					ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);

					-- Check for errors
					IF ReturnCode != '0' THEN
						RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
					END IF;	

					-- Get the proper zone for the reverse A record
					SELECT "zone" INTO RevZone
					FROM "ip"."subnets" 
					WHERE NEW."address" << "subnet";

					-- Get the subnet
					SELECT "subnet" INTO RevSubnet
					FROM "ip"."subnets"
					WHERE NEW."address" << "subnet";

					-- If it is in this domain, add the reverse entry
					IF RevZone = NEW."zone" AND NEW."reverse" IS TRUE THEN
						DnsRecord := api.get_reverse_domain(NEW."address")||' '||NEW."ttl"||' PTR '||NEW."hostname"||'.'||NEW."zone"||'.';
						ReturnCode := Returncode||api.nsupdate(api.get_reverse_domain(RevSubnet),DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
					END IF;
				END IF;

			ELSEIF NEW."type" ~* '^NS$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."nameserver";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
				
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."nameserver";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^MX$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."preference"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
				
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."preference"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^SRV$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."priority"||' '||OLD."weight"||' '||OLD."port"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."priority"||' '||NEW."weight"||' '||NEW."port"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^CNAME$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^TXT$' THEN
				-- For zone TXT records
				IF OLD."hostname" IS NULL THEN
					DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				ELSE
					DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			
				IF NEW."hostname" IS NULL THEN
					DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				ELSE
					DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			END IF;
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";

			IF NEW."type" ~* '^NS$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."nameserver";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
				
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."nameserver";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^MX$' THEN
				DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."preference"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
				
				DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."preference"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^SRV$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."priority"||' '||OLD."weight"||' '||OLD."port"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."priority"||' '||NEW."weight"||' '||NEW."port"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^CNAME$' THEN
				DnsRecord := OLD."alias"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' '||OLD."hostname"||'.'||OLD."zone";
				ReturnCode := Returncode||api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			
				DnsRecord := NEW."alias"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' '||NEW."hostname"||'.'||NEW."zone";
				ReturnCode := Returncode||api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			ELSEIF NEW."type" ~* '^TXT$' THEN
				-- For zone TXT records
				IF OLD."hostname" IS NULL THEN
					DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				ELSE
					DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
			
				IF NEW."hostname" IS NULL THEN
					DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				ELSE
					DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
				END IF;
				ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
			END IF;

			IF ReturnCode != '0' THEN
				RAISE EXCEPTION 'DNS Error: % when performing %',ReturnCode,DnsRecord;
			END IF;
		END IF;
		RETURN NEW;
	END;
$_$;


ALTER FUNCTION dns.queue_update() OWNER TO starrs;

--
-- Name: FUNCTION queue_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.queue_update() IS 'Add a delete then add directive to the queue';


--
-- Name: srv_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.srv_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Check if alias name already exists
		SELECT COUNT(*) INTO RowCount
		FROM "dns"."a"
		WHERE "dns"."a"."hostname" = NEW."alias";
		IF (RowCount > 0) THEN
			RAISE EXCEPTION 'Alias name (%) already exists',NEW."alias";
		END IF;
		
		SELECT COUNT(*) INTO RowCount
		FROM "dns"."cname"
		WHERE "dns"."cname"."alias" = NEW."alias";
		IF (RowCount > 0) THEN
			RAISE EXCEPTION 'Alias name (%) already exists as a CNAME',NEW."alias";
		END IF;
		
		-- Autopopulate address
		NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.srv_insert() OWNER TO starrs;

--
-- Name: FUNCTION srv_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.srv_insert() IS 'Check if the alias already exists as an address record';


--
-- Name: srv_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.srv_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Check if alias name already exists
		IF NEW."alias" != OLD."alias" THEN	
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."a"
			WHERE "dns"."a"."hostname" = NEW."alias";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'Alias name (%) already exists',NEW."alias";
			END IF;
			
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."cname"
			WHERE "dns"."cname"."alias" = NEW."alias";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'Alias name (%) already exists as a CNAME',NEW."alias";
			END IF;
		END IF;
		
		-- Autopopulate address
		IF NEW."address" != OLD."address" THEN
			NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		END IF;
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.srv_update() OWNER TO starrs;

--
-- Name: FUNCTION srv_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.srv_update() IS 'Check if the new alias already exists as an address record';


--
-- Name: txt_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.txt_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.txt_insert() OWNER TO starrs;

--
-- Name: FUNCTION txt_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.txt_insert() IS 'Create new TXT record';


--
-- Name: txt_query_delete(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.txt_query_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT; -- Return code from the nsupdate function
		DnsKeyName TEXT; -- The DNS keyname to sign with
		DnsKey TEXT; -- The DNS key to sign with
		DnsServer INET; -- The nameserver to send the update to
		DnsRecord TEXT; -- The formatted string that is the record
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = OLD."zone") IS FALSE THEN
			RETURN OLD;
		END IF;
		
		-- If this is a forward zone:
		IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = OLD."zone") IS TRUE THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = OLD."zone";
		-- If this is a reverse zone:
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = OLD."zone");
		END IF;
		
		-- Just make sure no-one is forcing a bogus type
		IF OLD."type" !~* '^TXT$' THEN
			RAISE EXCEPTION 'Trying to delete a non-TXT record in a TXT table!';
		END IF;
		
		-- Create and fire off the update
		-- For zone TXT records
		IF OLD."hostname" IS NULL THEN
			DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
		ELSE
			DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
		END IF;
		ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing TXT-DELETE %',ReturnCode,DnsRecord;
		END IF;
		
		-- Done!
		RETURN OLD;
	END;
$_$;


ALTER FUNCTION dns.txt_query_delete() OWNER TO starrs;

--
-- Name: FUNCTION txt_query_delete(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.txt_query_delete() IS 'Delete an old TXT record from the server';


--
-- Name: txt_query_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.txt_query_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT; -- Return code from the nsupdate function
		DnsKeyName TEXT; -- The DNS keyname to sign with
		DnsKey TEXT; -- The DNS key to sign with
		DnsServer INET; -- The nameserver to send the update to
		DnsRecord TEXT; -- The formatted string that is the record
	BEGIN
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = NEW."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		-- If this is a forward zone:
		IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = NEW."zone") IS TRUE THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";
		-- If this is a reverse zone:
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = NEW."zone");
		END IF;
		
		-- Just make sure no-one is forcing a bogus type
		IF NEW."type" !~* '^TXT$' THEN
			RAISE EXCEPTION 'Trying to create a non-TXT record in a TXT table!';
		END IF;
		
		-- Create and fire off the update
		-- For zone TXT records
		IF NEW."hostname" IS NULL THEN
			DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
		ELSE
			DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
		END IF;
		ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing TXT-INSERT %',ReturnCode,DnsRecord;
		END IF;
		
		-- Done!
		RETURN NEW;
	END;
$_$;


ALTER FUNCTION dns.txt_query_insert() OWNER TO starrs;

--
-- Name: FUNCTION txt_query_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.txt_query_insert() IS 'Update the nameserver with a new TXT record';


--
-- Name: txt_query_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.txt_query_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		ReturnCode TEXT; -- Return code from the nsupdate function
		DnsKeyName TEXT; -- The DNS keyname to sign with
		DnsKey TEXT; -- The DNS key to sign with
		DnsServer INET; -- The nameserver to send the update to
		DnsRecord TEXT; -- The formatted string that is the record
	BEGIN
		-- If this is a forward zone:
		IF (SELECT "forward" FROM "dns"."zones" WHERE "zone" = NEW."zone") IS TRUE THEN
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."zones"."zone" = NEW."zone";
		-- If this is a reverse zone:
		ELSE
			SELECT "dns"."keys"."keyname","dns"."keys"."key",api.resolve("dns"."soa"."nameserver")
			INTO DnsKeyName, DnsKey, DnsServer
			FROM "dns"."zones"
			JOIN "dns"."keys" ON "dns"."keys"."keyname" = "dns"."zones"."keyname"
			JOIN "dns"."soa" ON "dns"."soa"."zone" = "dns"."zones"."zone"
			WHERE "dns"."ns"."zone" = (SELECT "ip"."subnets"."zone" FROM "ip"."subnets" WHERE api.get_reverse_domain("subnet") = NEW."zone");
		END IF;
		
		-- Just make sure no-one is forcing a bogus type
		IF NEW."type" !~* '^TXT$' THEN
			RAISE EXCEPTION 'Trying to update a non-TXT record in a TXT table!';
		END IF;
		
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = OLD."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
		
		-- Delete the record first
		IF OLD."hostname" IS NULL THEN
			DnsRecord := OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
		ELSE
			DnsRecord := OLD."hostname"||'.'||OLD."zone"||' '||OLD."ttl"||' '||OLD."type"||' "'||OLD."text"||'"';
		END IF;
		ReturnCode := api.nsupdate(OLD."zone",DnsKeyName,DnsKey,DnsServer,'DELETE',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing TXT-UPDATE-DELETE %',ReturnCode,DnsRecord;
		END IF;
		
		IF (SELECT "ddns" FROM "dns"."zones" WHERE "dns"."zones"."zone" = NEW."zone") IS FALSE THEN
			RETURN NEW;
		END IF;
	
		-- Create and fire off the update
		IF NEW."hostname" IS NULL THEN
			DnsRecord := NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
		ELSE
			DnsRecord := NEW."hostname"||'.'||NEW."zone"||' '||NEW."ttl"||' '||NEW."type"||' "'||NEW."text"||'"';
		END IF;
		ReturnCode := api.nsupdate(NEW."zone",DnsKeyName,DnsKey,DnsServer,'ADD',DnsRecord);
		
		-- Check for result
		IF ReturnCode != '0' THEN
			RAISE EXCEPTION 'DNS Error: % when performing TXT-UPDATE-INSERT %',ReturnCode,DnsRecord;
		END IF;
		
		-- Done!
		RETURN NEW;
	END;
$_$;


ALTER FUNCTION dns.txt_query_update() OWNER TO starrs;

--
-- Name: FUNCTION txt_query_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.txt_query_update() IS 'Update the nameserver with a new TXT record';


--
-- Name: txt_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.txt_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF NEW."address" != OLD."address" THEN
			NEW."address" := dns.dns_autopopulate_address(NEW."hostname",NEW."zone");
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.txt_update() OWNER TO starrs;

--
-- Name: FUNCTION txt_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.txt_update() IS 'Modify a TXT record';


--
-- Name: zone_a_delete(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.zone_a_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF family(OLD."address") = 4 THEN
			OLD."type" = 'A';
		ELSE
			OLD."type" = 'AAAA';
		END IF;
		RETURN OLD;
	END;
$$;


ALTER FUNCTION dns.zone_a_delete() OWNER TO starrs;

--
-- Name: FUNCTION zone_a_delete(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.zone_a_delete() IS 'Auto-fill the type based on the address family.';


--
-- Name: zone_a_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.zone_a_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF family(NEW."address") = 4 THEN
			NEW."type" = 'A';
		ELSE
			NEW."type" = 'AAAA';
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.zone_a_insert() OWNER TO starrs;

--
-- Name: FUNCTION zone_a_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.zone_a_insert() IS 'Auto-fill the type based on the address family.';


--
-- Name: zone_a_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.zone_a_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF family(NEW."address") = 4 THEN
			NEW."type" = 'A';
		ELSE
			NEW."type" = 'AAAA';
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.zone_a_update() OWNER TO starrs;

--
-- Name: FUNCTION zone_a_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.zone_a_update() IS 'Auto-fill the type based on the address family.';


--
-- Name: zone_txt_insert(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.zone_txt_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;

	BEGIN
		IF NEW."hostname" IS NOT NULL THEN
			-- Check if hostname name already exists as an A
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."a"
			WHERE "dns"."a"."hostname" = NEW."hostname";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'Hostname (%) already exists',NEW."hostname";
			END IF;
			
			-- Check if hostname name already exists as an SRV
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."srv"
			WHERE "dns"."srv"."alias" = NEW."hostname";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'hostname (%) already exists as a SRV',NEW."hostname";
			END IF;
			
			-- Check if hostname name already exists as an CNAME
			SELECT COUNT(*) INTO RowCount
			FROM "dns"."cname"
			WHERE "dns"."cname"."alias" = NEW."hostname";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'hostname (%) already exists as a CNAME',NEW."hostname";
			END IF;
		END IF;
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.zone_txt_insert() OWNER TO starrs;

--
-- Name: FUNCTION zone_txt_insert(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.zone_txt_insert() IS 'Check if the hostname already exists in other tables and insert the zone TXT record';


--
-- Name: zone_txt_update(); Type: FUNCTION; Schema: dns; Owner: starrs
--

CREATE FUNCTION dns.zone_txt_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
		
	BEGIN
		-- Check if hostname name already exists
		IF NEW."hostname" != OLD."hostname" THEN	
			IF NEW."hostname" IS NOT NULL THEN
				-- Check if hostname name already exists as an A
				SELECT COUNT(*) INTO RowCount
				FROM "dns"."a"
				WHERE "dns"."a"."hostname" = NEW."hostname";
				IF (RowCount > 0) THEN
					RAISE EXCEPTION 'Hostname (%) already exists',NEW."hostname";
				END IF;
				
				-- Check if hostname name already exists as an SRV
				SELECT COUNT(*) INTO RowCount
				FROM "dns"."srv"
				WHERE "dns"."srv"."alias" = NEW."hostname";
				IF (RowCount > 0) THEN
					RAISE EXCEPTION 'hostname (%) already exists as a SRV',NEW."hostname";
				END IF;
				
				-- Check if hostname name already exists as an CNAME
				SELECT COUNT(*) INTO RowCount
				FROM "dns"."cname"
				WHERE "dns"."cname"."alias" = NEW."hostname";
				IF (RowCount > 0) THEN
					RAISE EXCEPTION 'hostname (%) already exists as a CNAME',NEW."hostname";
				END IF;
			END IF;
		END IF;
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION dns.zone_txt_update() OWNER TO starrs;

--
-- Name: FUNCTION zone_txt_update(); Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON FUNCTION dns.zone_txt_update() IS 'Check if the new hostname already exists in other tables and update the zone TXT record';


--
-- Name: addresses_insert(); Type: FUNCTION; Schema: ip; Owner: starrs
--

CREATE FUNCTION ip.addresses_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Done
		RETURN NEW;
	END;
$$;


ALTER FUNCTION ip.addresses_insert() OWNER TO starrs;

--
-- Name: FUNCTION addresses_insert(); Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON FUNCTION ip.addresses_insert() IS 'Activate a new IP address in the application';


--
-- Name: ranges_insert(); Type: FUNCTION; Schema: ip; Owner: starrs
--

CREATE FUNCTION ip.ranges_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		LowerBound INET;
		UpperBound INET;
		query_result RECORD;
		RowCount INTEGER;
	BEGIN
		-- Check for illegal addresses
		IF host(NEW."subnet") = host(NEW."first_ip") THEN
			RAISE EXCEPTION 'You cannot have a boundry that is the network identifier';
		END IF;
		
		-- Check address vs subnet
		IF NOT NEW."first_ip" << NEW."subnet" OR NOT NEW."last_ip" << NEW."subnet" THEN
			RAISE EXCEPTION 'Range addresses must be inside the specified subnet';
		END IF;

		-- Check valid range
		IF NEW."first_ip" >= NEW."last_ip" THEN
			RAISE EXCEPTION 'First address is larger or equal to last address.';
		END IF;

		-- IPv6
		IF family(NEW."subnet") = 6 THEN
			INSERT INTO "ip"."addresses" ("address") (SELECT * FROM "api"."get_range_addresses"(NEW."first_ip", NEW."last_ip") AS "potential" WHERE "potential" NOT IN (SELECT "address" FROM "ip"."addresses" WHERE "ip"."addresses"."address" << NEW."subnet"));
		END IF;
		
		-- Check address existance
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."addresses"
		WHERE "ip"."addresses"."address" = NEW."first_ip";
		IF (RowCount != 1) THEN
			RAISE EXCEPTION 'First address (%) not found in address pool.',NEW."first_ip";
		END IF;
		
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."addresses"
		WHERE "ip"."addresses"."address" = NEW."last_ip";
		IF (RowCount != 1) THEN
			RAISE EXCEPTION 'Last address (%) not found in address pool.',NEW."last_ip";
		END IF;

		-- Define lower boundary for range
		-- Loop through all ranges and find what is near the new range
		FOR query_result IN SELECT "first_ip","last_ip" FROM "ip"."ranges" WHERE "subnet" = NEW."subnet" ORDER BY "last_ip" LOOP
			IF NEW."first_ip" >= query_result.first_ip AND NEW."first_ip" <= query_result.last_ip THEN
				RAISE EXCEPTION 'First address out of bounds.';
			ELSIF NEW."first_ip" > query_result.last_ip THEN
				LowerBound := query_result.last_ip;
			END IF;
			IF NEW."last_ip" >= query_result.first_ip AND NEW."last_ip" <= query_result.last_ip THEN
				RAISE EXCEPTION 'Last address is out of bounds';
			END IF;
		END LOOP;

		-- Define upper boundry for range
		SELECT "first_ip" INTO UpperBound
		FROM "ip"."ranges"
		WHERE "first_ip" >= LowerBound
		ORDER BY "first_ip" LIMIT 1;

		-- Check for range spanning
		IF NEW."last_ip" >= UpperBound THEN
			RAISE EXCEPTION 'Last address is out of bounds';
		END IF;

		-- Done
		RETURN NEW;
	END;
$$;


ALTER FUNCTION ip.ranges_insert() OWNER TO starrs;

--
-- Name: FUNCTION ranges_insert(); Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON FUNCTION ip.ranges_insert() IS 'Insert a new range of addresses for use';


--
-- Name: ranges_update(); Type: FUNCTION; Schema: ip; Owner: starrs
--

CREATE FUNCTION ip.ranges_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		LowerBound INET;
		UpperBound INET;
		query_result RECORD;
		RowCount INTEGER;
	BEGIN
		IF NEW."first_ip" != OLD."first_ip" OR NEW."last_ip" != OLD."last_ip" THEN
			-- Check for illegal addresses
			IF host(NEW."subnet") = host(NEW."first_ip") THEN
				RAISE EXCEPTION 'You cannot have a boundry that is the network identifier';
			END IF;
			
			-- Check address vs subnet
			IF NOT NEW."first_ip" << NEW."subnet" OR NOT NEW."last_ip" << NEW."subnet" THEN
				RAISE EXCEPTION 'Range addresses must be inside the specified subnet';
			END IF;

			-- Check valid range
			IF NEW."first_ip" >= NEW."last_ip" THEN
				RAISE EXCEPTION 'First address is larger or equal to last address.';
			END IF;
			
			-- Check address existance
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."addresses"
			WHERE "ip"."addresses"."address" = NEW."first_ip";
			IF (RowCount != 1) THEN
				RAISE EXCEPTION 'First address (%) not found in address pool.',NEW."first_ip";
			END IF;
			
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."addresses"
			WHERE "ip"."addresses"."address" = NEW."last_ip";
			IF (RowCount != 1) THEN
				RAISE EXCEPTION 'Last address (%) not found in address pool.',NEW."last_ip";
			END IF;

			-- Define lower boundary for range
			-- Loop through all ranges and find what is near the new range
			FOR query_result IN SELECT "first_ip","last_ip" FROM "ip"."ranges" WHERE "subnet" = NEW."subnet" AND "first_ip" != OLD."first_ip" ORDER BY "last_ip" LOOP
				-- Check if the new first_ip is contained within the next lower range
				IF NEW."first_ip" >= query_result.first_ip AND NEW."first_ip" <= query_result.last_ip THEN
					RAISE EXCEPTION 'First address out of bounds.';

				--Check if the new last_ip is contained with the next lower range
				ELSIF NEW."last_ip" >= query_result.first_ip AND NEW."last_ip" <= query_result.last_ip THEN
					RAISE EXCEPTION 'Last address LOLOLOL is out of bounds';
				ELSIF NEW."first_ip" > query_result.last_ip THEN
					LowerBound := query_result.last_ip;
				END IF;
				
			END LOOP;

			-- Define upper boundry for range
			SELECT "first_ip" INTO UpperBound
			FROM "ip"."ranges"
			WHERE "first_ip" > LowerBound
			AND "name" != NEW."name"
			ORDER BY "first_ip" DESC LIMIT 1;

			-- Check for range spanning
			IF NEW."last_ip" >= UpperBound THEN
				RAISE EXCEPTION 'Last address HAHAH is out of bounds';
			END IF;
		END IF;
		-- Done
		RETURN NEW;
	END;
$$;


ALTER FUNCTION ip.ranges_update() OWNER TO starrs;

--
-- Name: FUNCTION ranges_update(); Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON FUNCTION ip.ranges_update() IS 'Alter a range of addresses for use';


--
-- Name: subnets_delete(); Type: FUNCTION; Schema: ip; Owner: starrs
--

CREATE FUNCTION ip.subnets_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
	BEGIN
		-- Check for inuse addresses
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."addresses"
		WHERE EXISTS (
			SELECT "address" 
			FROM "systems"."interface_addresses" 
			WHERE "systems"."interface_addresses"."address" = "ip"."addresses"."address" )
		AND "ip"."addresses"."address" << OLD."subnet";
		IF (RowCount >= 1) THEN
			RAISE EXCEPTION 'Inuse addresses found. Aborting delete.';
		END IF;

		-- Delete autogenerated addresses
		IF OLD."autogen" = TRUE THEN
			DELETE FROM "ip"."addresses" WHERE "address" << OLD."subnet";
		END IF;

		-- Done
		RETURN OLD;
	END;
$$;


ALTER FUNCTION ip.subnets_delete() OWNER TO starrs;

--
-- Name: FUNCTION subnets_delete(); Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON FUNCTION ip.subnets_delete() IS 'You can only delete a subnet if no addresses from it are inuse.';


--
-- Name: subnets_insert(); Type: FUNCTION; Schema: ip; Owner: starrs
--

CREATE FUNCTION ip.subnets_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
		SubnetAddresses RECORD;
	BEGIN
		-- Check for larger subnets
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."subnets"
		WHERE NEW."subnet" << "ip"."subnets"."subnet";
		IF (RowCount > 1) THEN
			RAISE EXCEPTION 'A larger existing subnet was detected. Nested subnets are not supported.';
		END IF;

		-- Check for smaller subnets
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."subnets"
		WHERE NEW."subnet" >> "ip"."subnets"."subnet";
		IF (RowCount > 0) THEN
			RAISE EXCEPTION 'A smaller existing subnet was detected. Nested subnets are not supported.';
		END IF;
		
		-- Check for existing addresses
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."addresses"
		WHERE "ip"."addresses"."address" << NEW."subnet";
		IF RowCount >= 1 THEN
			RAISE EXCEPTION 'Existing addresses detected for your subnet. Modify the existing subnet.';
		END IF;

		-- Autogenerate addresses & firewall default
		IF NEW."autogen" IS TRUE THEN
			FOR SubnetAddresses IN SELECT api.get_subnet_addresses(NEW."subnet") LOOP
				INSERT INTO "ip"."addresses" ("address") VALUES (SubnetAddresses.get_subnet_addresses);
			END LOOP;
		END IF;
		
		-- Done
		RETURN NEW;
	END;
$$;


ALTER FUNCTION ip.subnets_insert() OWNER TO starrs;

--
-- Name: FUNCTION subnets_insert(); Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON FUNCTION ip.subnets_insert() IS 'Create a subnet';


--
-- Name: subnets_update(); Type: FUNCTION; Schema: ip; Owner: starrs
--

CREATE FUNCTION ip.subnets_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		RowCount INTEGER;
		SubnetAddresses RECORD;
	BEGIN
		IF NEW."subnet" != OLD."subnet" THEN
			-- Check for larger subnets
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."subnets"
			WHERE NEW."subnet" << "ip"."subnets"."subnet";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'A larger existing subnet was detected. Nested subnets are not supported.';
			END IF;

			-- Check for smaller subnets
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."subnets"
			WHERE NEW."subnet" >> "ip"."subnets"."subnet"
			AND OLD."subnet" <> "ip"."subnets"."subnet";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'A smaller existing subnet was detected. Nested subnets are not supported.';
			END IF;
			
			-- Check for existing addresses
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."addresses"
			WHERE "ip"."addresses"."address" << NEW."subnet";
			IF RowCount >= 1 THEN
				RAISE EXCEPTION 'Existing addresses detected for your subnet. Modify the existing subnet.';
			END IF;
		END IF;

		-- Autogenerate addresses
		IF NEW."autogen" != OLD."autogen" THEN
			IF NEW."autogen" IS TRUE THEN
				DELETE FROM "ip"."addresses" WHERE "ip"."addresses"."address" << OLD."subnet";
				FOR SubnetAddresses IN SELECT api.get_subnet_addresses(NEW."subnet") LOOP
					INSERT INTO "ip"."addresses" ("address") VALUES (SubnetAddresses.get_subnet_addresses);
				END LOOP;
			END IF;
		END IF;
		
		-- Done
		RETURN NEW;
	END;
$$;


ALTER FUNCTION ip.subnets_update() OWNER TO starrs;

--
-- Name: FUNCTION subnets_update(); Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON FUNCTION ip.subnets_update() IS 'Modify an existing new subnet';


--
-- Name: switchport_states_update(); Type: FUNCTION; Schema: network; Owner: starrs
--

CREATE FUNCTION network.switchport_states_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		IF NEW."admin_state" != OLD."admin_state" THEN
			PERFORM api.modify_network_switchport_admin_state(api.get_system_primary_address(NEW."system_name"),NEW."port_name",(SELECT "snmp_rw_community" FROM "network"."switchview" WHERE "system_name" = NEW."system_name"),NEW."admin_state");
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION network.switchport_states_update() OWNER TO starrs;

--
-- Name: switchports_insert(); Type: FUNCTION; Schema: network; Owner: starrs
--

CREATE FUNCTION network.switchports_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		DeviceType TEXT;
	BEGIN
		-- Check for system types
		SELECT "type" INTO DeviceType
		FROM "systems"."systems"
		WHERE "systems"."systems"."system_name" = NEW."system_name";
		IF DeviceType !~* 'Router|Switch|Hub|Wireless Access Point' THEN
			RAISE EXCEPTION 'Cannot create a switchport on non-network device type (%)',DeviceType;
		END IF;
		RETURN NEW;
	END;
$$;


ALTER FUNCTION network.switchports_insert() OWNER TO starrs;

--
-- Name: FUNCTION switchports_insert(); Type: COMMENT; Schema: network; Owner: starrs
--

COMMENT ON FUNCTION network.switchports_insert() IS 'verifications for network switchports';


--
-- Name: switchports_update(); Type: FUNCTION; Schema: network; Owner: starrs
--

CREATE FUNCTION network.switchports_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE
		DeviceType TEXT;
	BEGIN
		-- Check for system types
		IF NEW."system_name" != OLD."system_name" THEN
			SELECT "type" INTO DeviceType
			FROM "systems"."systems"
			WHERE "systems"."systems"."system_name" = NEW."system_name";
			IF DeviceType !~* 'Router|Switch|Hub|Wireless Access Point' THEN
				RAISE EXCEPTION 'Cannot create a switchport on non-network device type %',DeviceType;
			END IF;
		END IF;
		
		IF NEW."description" != OLD."description" THEN
			PERFORM api.modify_network_switchport_description(api.get_system_primary_address(NEW."system_name"),NEW."port_name",(SELECT "snmp_rw_community" FROM "network"."switchview" WHERE "system_name" = NEW."system_name"),NEW."description");
		END IF;
		
		RETURN NEW;
	END;
$$;


ALTER FUNCTION network.switchports_update() OWNER TO starrs;

--
-- Name: FUNCTION switchports_update(); Type: COMMENT; Schema: network; Owner: starrs
--

COMMENT ON FUNCTION network.switchports_update() IS 'verifications for network switchports';


--
-- Name: interface_addresses_insert(); Type: FUNCTION; Schema: systems; Owner: starrs
--

CREATE FUNCTION systems.interface_addresses_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	DECLARE
		RowCount INTEGER;
		ConfigFamily INTEGER;
		PrimaryName TEXT;
		Owner TEXT;
	BEGIN
		-- Set address family
		NEW."family" := family(NEW."address");

		-- Check if address is within a subnet
		SELECT COUNT(*) INTO RowCount
		FROM "ip"."subnets" 
		WHERE NEW."address" << "ip"."subnets"."subnet";
		IF (RowCount < 1) THEN
			RAISE EXCEPTION 'IP address (%) must be within a managed subnet.',NEW."address";
		END IF;
		
		-- Check if primary address exists (it shouldnt)
		SELECT COUNT(*) INTO RowCount
		FROM "systems"."interface_addresses"
		WHERE "systems"."interface_addresses"."isprimary" = TRUE
		AND "systems"."interface_addresses"."family" = NEW."family"
		AND "systems"."interface_addresses"."mac" = NEW."mac";
		IF NEW."isprimary" IS TRUE AND RowCount > 0 THEN
			-- There is a primary address already registered and this was supposed to be one.
			RAISE EXCEPTION 'Primary address for this interface and family already exists';
		ELSIF NEW."isprimary" IS FALSE AND RowCount = 0 THEN
			-- There is no primary and this is set to not be one.
			RAISE EXCEPTION 'No primary address exists for this interface (%) and family (%).',NEW."mac",NEW."family";
		END IF;

		-- Check for one DHCPable address per MAC
		IF NEW."config" !~* 'static' THEN
			SELECT COUNT(*) INTO RowCount
			FROM "systems"."interface_addresses"
			WHERE "systems"."interface_addresses"."family" = NEW."family"
			AND "systems"."interface_addresses"."config" ~* 'dhcp'
			AND "systems"."interface_addresses"."mac" = NEW."mac";
			IF (RowCount > 0) THEN
				RAISE EXCEPTION 'Only one DHCP/Autoconfig-able address per MAC (%) is allowed',NEW."mac";
			END IF;
		END IF;

		-- Check address family against config type
		IF NEW."config" !~* 'static' THEN
			SELECT "family" INTO ConfigFamily
			FROM "dhcp"."config_types"
			WHERE "dhcp"."config_types"."config" = NEW."config";
			IF NEW."family" != ConfigFamily THEN
				RAISE EXCEPTION 'Invalid configuration type selected (%) for your address family (%)',NEW."config",NEW."family";
			END IF;
		END IF;
		
		-- IPv6 Autoconfiguration
		IF NEW."family" = 6 AND NEW."config" ~* 'dhcpv6|static' THEN
			SELECT "systems"."systems"."owner" INTO Owner
			FROM "systems"."interfaces"
			JOIN "systems"."systems" ON
			"systems"."systems"."system_name" = "systems"."interfaces"."system_name"
			WHERE "systems"."interfaces"."mac" = NEW."mac";

			SELECT COUNT(*) INTO RowCount
			FROM "ip"."addresses"
			WHERE "ip"."addresses"."address" = NEW."address";
			IF (RowCount = 0) THEN
				INSERT INTO "ip"."addresses" ("address","owner") VALUES (NEW."address",Owner);
			END IF;
			
		END IF;

		RETURN NEW;
	END;
$$;


ALTER FUNCTION systems.interface_addresses_insert() OWNER TO starrs;

--
-- Name: FUNCTION interface_addresses_insert(); Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON FUNCTION systems.interface_addresses_insert() IS 'Create a new address based on a very complex ruleset';


--
-- Name: interface_addresses_update(); Type: FUNCTION; Schema: systems; Owner: starrs
--

CREATE FUNCTION systems.interface_addresses_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
	DECLARE
		RowCount INTEGER;
		ConfigFamily INTEGER;
		PrimaryName TEXT;
		Owner TEXT;
	BEGIN
		IF NEW."address" != OLD."address" THEN
			-- Set family
			NEW."family" := family(NEW."address");

			-- Check if IP is within our controlled subnets
			SELECT COUNT(*) INTO RowCount
			FROM "ip"."subnets" 
			WHERE NEW."address" << "ip"."subnets"."subnet";
			IF (RowCount < 1) THEN
				RAISE EXCEPTION 'IP address (%) must be within a managed subnet.',NEW."address";
			END IF;
		END IF;
		
		-- Check if primary for the family already exists. It shouldnt.
		IF NEW."isprimary" != OLD."isprimary" THEN
			SELECT COUNT(*) INTO RowCount
			FROM "systems"."interface_addresses"
			WHERE "systems"."interface_addresses"."isprimary" = TRUE
			AND "systems"."interface_addresses"."family" = NEW."family"
			AND "systems"."interface_addresses"."mac" = NEW."mac";
			IF NEW."isprimary" IS TRUE AND RowCount > 0 THEN
				-- There is a primary address already registered and this was supposed to be one.
				RAISE EXCEPTION 'Primary address for this interface and family already exists';
			ELSIF NEW."isprimary" IS FALSE AND RowCount = 0 THEN
				-- There is no primary and this is set to not be one.
				RAISE EXCEPTION 'No primary address exists for this interface and family and this will not be one.';
			END IF;
		END IF;

		-- Check for only one DHCPable address per MAC address
		IF NEW."config" != OLD."config" THEN
			IF NEW."config" ~* '^dhcp$' THEN
				SELECT COUNT(*) INTO RowCount
				FROM "systems"."interface_addresses"
				WHERE "systems"."interface_addresses"."family" = NEW."family"
				AND "systems"."interface_addresses"."config" ~* 'dhcp'
				AND "systems"."interface_addresses"."mac" = NEW."mac";
				IF (RowCount > 0) THEN
					RAISE EXCEPTION 'Only one DHCP/Autoconfig-able address per MAC (%) is allowed',NEW."mac";
				END IF;
			END IF;

			-- Check address family against config type
			IF NEW."config" !~* 'static' THEN
				SELECT "family" INTO ConfigFamily
				FROM "dhcp"."config_types"
				WHERE "dhcp"."config_types"."config" = NEW."config";
				IF NEW."family" != ConfigFamily THEN
					RAISE EXCEPTION 'Invalid configuration type selected (%) for your address family (%)',NEW."config",NEW."family";
				END IF;
			END IF;
			
			-- IPv6 Autoconfiguration
			IF NEW."family" = 6 AND NEW."config" ~* 'autoconf' THEN
				SELECT COUNT(*) INTO RowCount
				FROM "ip"."addresses"
				WHERE "ip"."addresses"."address" = NEW."address";
				IF (RowCount > 0) THEN
					RAISE EXCEPTION 'Existing address (%) detected. Cannot continue.',NEW."address";
				END IF;
				
				SELECT "systems"."systems"."owner" INTO Owner
				FROM "systems"."interfaces"
				JOIN "systems"."systems" ON
				"systems"."systems"."system_name" = "systems"."interfaces"."system_name"
				WHERE "systems"."interfaces"."mac" = NEW."mac";

				INSERT INTO "ip"."addresses" ("address","owner") VALUES (NEW."address",Owner);
			END IF;
			
			-- Remove old autoconf addresses
			IF OLD."config" ~* 'autoconf' THEN
				DELETE FROM "ip"."addresses" WHERE "address" = OLD."address";
			END IF;
		END IF;
		
		-- Check for IPv6 secondary name
		/*
		IF NEW."family" = 6 AND NEW."isprimary" = FALSE THEN
			SELECT "name" INTO PrimaryName
			FROM "systems"."interface_addresses"
			WHERE "systems"."interface_addresses"."mac" = NEW."mac"
			AND "systems"."interface_addresses"."isprimary" = TRUE;
			IF NEW."name" != PrimaryName THEN
				RAISE EXCEPTION 'IPv6 secondaries must have the same interface name (%) as the primary (%)',NEW."name",PrimaryName;
			END IF;
		END IF;			
		*/
		RETURN NEW;
	END;
$_$;


ALTER FUNCTION systems.interface_addresses_update() OWNER TO starrs;

--
-- Name: FUNCTION interface_addresses_update(); Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON FUNCTION systems.interface_addresses_update() IS 'Modify an existing address based on a very complex ruleset';


--
-- Name: types; Type: TABLE; Schema: dns; Owner: starrs
--

CREATE TABLE dns.types (
    type text NOT NULL,
    comment text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE dns.types OWNER TO starrs;

--
-- Name: TABLE types; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON TABLE dns.types IS 'All DNS record types';


--
-- Name: addresses; Type: TABLE; Schema: ip; Owner: starrs
--

CREATE TABLE ip.addresses (
    address inet NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL,
    owner text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE ip.addresses OWNER TO starrs;

--
-- Name: TABLE addresses; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON TABLE ip.addresses IS 'Master list of all controlled addresses in the application';


--
-- Name: range_uses; Type: TABLE; Schema: ip; Owner: starrs
--

CREATE TABLE ip.range_uses (
    use character varying(4) NOT NULL,
    comment text,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE ip.range_uses OWNER TO starrs;

--
-- Name: TABLE range_uses; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON TABLE ip.range_uses IS 'Ranges are intended for a specific purpose.';


--
-- Name: log_master; Type: TABLE; Schema: management; Owner: starrs
--

CREATE TABLE management.log_master (
    "timestamp" timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    "user" text NOT NULL,
    message text NOT NULL,
    source text NOT NULL,
    severity text NOT NULL
);


ALTER TABLE management.log_master OWNER TO starrs;

--
-- Name: TABLE log_master; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON TABLE management.log_master IS 'Record every single transaction that occurs in this application.';


--
-- Name: output_id_seq; Type: SEQUENCE; Schema: management; Owner: starrs
--

CREATE SEQUENCE management.output_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE management.output_id_seq OWNER TO starrs;

--
-- Name: SEQUENCE output_id_seq; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON SEQUENCE management.output_id_seq IS 'Identifier for all output results';


--
-- Name: output; Type: TABLE; Schema: management; Owner: starrs
--

CREATE TABLE management.output (
    output_id integer DEFAULT nextval('management.output_id_seq'::regclass) NOT NULL,
    value text,
    file text,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE management.output OWNER TO starrs;

--
-- Name: TABLE output; Type: COMMENT; Schema: management; Owner: starrs
--

COMMENT ON TABLE management.output IS 'Destination of the output functions rather than write a file to disk.';


--
-- Name: snmp3; Type: TABLE; Schema: network; Owner: starrs
--

CREATE TABLE network.snmp3 (
    system_name text NOT NULL,
    "user" text NOT NULL,
    auth_encryption text DEFAULT 'md5'::text NOT NULL,
    password text NOT NULL,
    priv_encryption text DEFAULT 'aes'::text NOT NULL,
    priv_password text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE network.snmp3 OWNER TO starrs;

--
-- Name: TABLE snmp3; Type: COMMENT; Schema: network; Owner: starrs
--

COMMENT ON TABLE network.snmp3 IS 'SNMPv3 credentials for network hosts';


--
-- Name: os; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.os (
    name text NOT NULL,
    family text,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE systems.os OWNER TO starrs;

--
-- Name: TABLE os; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.os IS 'Track what primary operating systems are in use on the network.';


--
-- Name: os_family; Type: TABLE; Schema: systems; Owner: starrs
--

CREATE TABLE systems.os_family (
    family text NOT NULL,
    date_created timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    last_modifier text DEFAULT api.get_current_user() NOT NULL
);


ALTER TABLE systems.os_family OWNER TO starrs;

--
-- Name: TABLE os_family; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON TABLE systems.os_family IS 'General classification for operating systems.';


--
-- Name: class_options class_options_class_option_value_key; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.class_options
    ADD CONSTRAINT class_options_class_option_value_key UNIQUE (option, value, class);


--
-- Name: CONSTRAINT class_options_class_option_value_key ON class_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON CONSTRAINT class_options_class_option_value_key ON dhcp.class_options IS 'No two directives can be the same';


--
-- Name: class_options class_options_pkey; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.class_options
    ADD CONSTRAINT class_options_pkey PRIMARY KEY (option, value, class);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (class);


--
-- Name: config_types config_types_pkey; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.config_types
    ADD CONSTRAINT config_types_pkey PRIMARY KEY (config);


--
-- Name: global_options global_options_pkey; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.global_options
    ADD CONSTRAINT global_options_pkey PRIMARY KEY (option);


--
-- Name: range_options range_options_pkey; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.range_options
    ADD CONSTRAINT range_options_pkey PRIMARY KEY (name, option);


--
-- Name: subnet_options subnet_option_subnet_option_value_key; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.subnet_options
    ADD CONSTRAINT subnet_option_subnet_option_value_key UNIQUE (option, value, subnet);


--
-- Name: CONSTRAINT subnet_option_subnet_option_value_key ON subnet_options; Type: COMMENT; Schema: dhcp; Owner: starrs
--

COMMENT ON CONSTRAINT subnet_option_subnet_option_value_key ON dhcp.subnet_options IS 'No two directives can be the same';


--
-- Name: subnet_options subnet_options_pkey; Type: CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.subnet_options
    ADD CONSTRAINT subnet_options_pkey PRIMARY KEY (option, value, subnet);


--
-- Name: a a_address_zone_key; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.a
    ADD CONSTRAINT a_address_zone_key UNIQUE (address, zone);


--
-- Name: CONSTRAINT a_address_zone_key ON a; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON CONSTRAINT a_address_zone_key ON dns.a IS 'Addresses in this table must be unique';


--
-- Name: a a_hostname_zone_type_key; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.a
    ADD CONSTRAINT a_hostname_zone_type_key UNIQUE (hostname, type, zone);


--
-- Name: CONSTRAINT a_hostname_zone_type_key ON a; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON CONSTRAINT a_hostname_zone_type_key ON dns.a IS 'Can only have 1 of each A or AAAA';


--
-- Name: a a_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.a
    ADD CONSTRAINT a_pkey PRIMARY KEY (hostname, address, zone);


--
-- Name: cname cname_alias_zone_key; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.cname
    ADD CONSTRAINT cname_alias_zone_key UNIQUE (alias, zone);


--
-- Name: CONSTRAINT cname_alias_zone_key ON cname; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON CONSTRAINT cname_alias_zone_key ON dns.cname IS 'Cannot have two of the same alises in the same zone';


--
-- Name: cname cname_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.cname
    ADD CONSTRAINT cname_pkey PRIMARY KEY (alias, hostname, address, zone);


--
-- Name: mx dns_mx_preference_zone_key; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.mx
    ADD CONSTRAINT dns_mx_preference_zone_key UNIQUE (preference, zone);


--
-- Name: CONSTRAINT dns_mx_preference_zone_key ON mx; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON CONSTRAINT dns_mx_preference_zone_key ON dns.mx IS 'No two MX servers can have the same preference in a domain';


--
-- Name: txt dns_txt_hostname_zone_text_key; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.txt
    ADD CONSTRAINT dns_txt_hostname_zone_text_key UNIQUE (hostname, zone, text);


--
-- Name: CONSTRAINT dns_txt_hostname_zone_text_key ON txt; Type: COMMENT; Schema: dns; Owner: starrs
--

COMMENT ON CONSTRAINT dns_txt_hostname_zone_text_key ON dns.txt IS 'No duplicate TXT records';


--
-- Name: zone_a dns_zone_a_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zone_a
    ADD CONSTRAINT dns_zone_a_pkey PRIMARY KEY (zone, type);


--
-- Name: keys keys_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.keys
    ADD CONSTRAINT keys_pkey PRIMARY KEY (keyname);


--
-- Name: mx mx_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.mx
    ADD CONSTRAINT mx_pkey PRIMARY KEY (hostname, address, zone);


--
-- Name: ns ns_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.ns
    ADD CONSTRAINT ns_pkey PRIMARY KEY (zone, nameserver);


--
-- Name: soa soa_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.soa
    ADD CONSTRAINT soa_pkey PRIMARY KEY (zone);


--
-- Name: srv srv_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.srv
    ADD CONSTRAINT srv_pkey PRIMARY KEY (alias, hostname, address, zone, priority, weight, port);


--
-- Name: txt txt_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.txt
    ADD CONSTRAINT txt_pkey PRIMARY KEY (text, hostname, address, zone);


--
-- Name: types types_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.types
    ADD CONSTRAINT types_pkey PRIMARY KEY (type);


--
-- Name: zone_txt zone_txt_hostname_zone_text_key; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zone_txt
    ADD CONSTRAINT zone_txt_hostname_zone_text_key UNIQUE (hostname, zone, text);


--
-- Name: zones zones_pkey; Type: CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zones
    ADD CONSTRAINT zones_pkey PRIMARY KEY (zone);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (address);


--
-- Name: range_groups ip_range_group_pkey; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.range_groups
    ADD CONSTRAINT ip_range_group_pkey PRIMARY KEY (range_name, group_name);


--
-- Name: range_uses range_uses_pkey; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.range_uses
    ADD CONSTRAINT range_uses_pkey PRIMARY KEY (use);


--
-- Name: ranges ranges_first_ip_key; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT ranges_first_ip_key UNIQUE (first_ip);


--
-- Name: CONSTRAINT ranges_first_ip_key ON ranges; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON CONSTRAINT ranges_first_ip_key ON ip.ranges IS 'Unique starting IP''s';


--
-- Name: ranges ranges_last_ip_key; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT ranges_last_ip_key UNIQUE (last_ip);


--
-- Name: CONSTRAINT ranges_last_ip_key ON ranges; Type: COMMENT; Schema: ip; Owner: starrs
--

COMMENT ON CONSTRAINT ranges_last_ip_key ON ip.ranges IS 'Unique ending IP''s';


--
-- Name: ranges ranges_pkey; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT ranges_pkey PRIMARY KEY (name);


--
-- Name: subnets subnets_pkey; Type: CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.subnets
    ADD CONSTRAINT subnets_pkey PRIMARY KEY (subnet);


--
-- Name: hosts libvirt_hosts_pkey; Type: CONSTRAINT; Schema: libvirt; Owner: starrs
--

ALTER TABLE ONLY libvirt.hosts
    ADD CONSTRAINT libvirt_hosts_pkey PRIMARY KEY (system_name);


--
-- Name: platforms libvirt_platforms_name_pkey; Type: CONSTRAINT; Schema: libvirt; Owner: starrs
--

ALTER TABLE ONLY libvirt.platforms
    ADD CONSTRAINT libvirt_platforms_name_pkey PRIMARY KEY (platform_name);


--
-- Name: configuration configuration_pkey; Type: CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (option);


--
-- Name: group_settings group_settings_pkey; Type: CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.group_settings
    ADD CONSTRAINT group_settings_pkey PRIMARY KEY ("group");


--
-- Name: group_members management_group_members_pkey; Type: CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.group_members
    ADD CONSTRAINT management_group_members_pkey PRIMARY KEY ("group", "user");


--
-- Name: groups management_groups_pkey; Type: CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.groups
    ADD CONSTRAINT management_groups_pkey PRIMARY KEY ("group");


--
-- Name: output output_pkey; Type: CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.output
    ADD CONSTRAINT output_pkey PRIMARY KEY (output_id);


--
-- Name: snmp3 network_snmp3_pkey; Type: CONSTRAINT; Schema: network; Owner: starrs
--

ALTER TABLE ONLY network.snmp3
    ADD CONSTRAINT network_snmp3_pkey PRIMARY KEY (system_name);


--
-- Name: snmp network_snmp_pkey; Type: CONSTRAINT; Schema: network; Owner: starrs
--

ALTER TABLE ONLY network.snmp
    ADD CONSTRAINT network_snmp_pkey PRIMARY KEY (system_name);


--
-- Name: vlans network_vlans_pkey; Type: CONSTRAINT; Schema: network; Owner: starrs
--

ALTER TABLE ONLY network.vlans
    ADD CONSTRAINT network_vlans_pkey PRIMARY KEY (datacenter, vlan);


--
-- Name: device_types device_types_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.device_types
    ADD CONSTRAINT device_types_pkey PRIMARY KEY (type);


--
-- Name: interface_addresses interface_addresses_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interface_addresses
    ADD CONSTRAINT interface_addresses_pkey PRIMARY KEY (address);


--
-- Name: interfaces interfaces_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interfaces
    ADD CONSTRAINT interfaces_pkey PRIMARY KEY (mac);


--
-- Name: interfaces interfaces_system_name_name_key; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interfaces
    ADD CONSTRAINT interfaces_system_name_name_key UNIQUE (system_name, name);


--
-- Name: CONSTRAINT interfaces_system_name_name_key ON interfaces; Type: COMMENT; Schema: systems; Owner: starrs
--

COMMENT ON CONSTRAINT interfaces_system_name_name_key ON systems.interfaces IS 'Inteface names must be unique on a system';


--
-- Name: os_family os_family_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.os_family
    ADD CONSTRAINT os_family_pkey PRIMARY KEY (family);


--
-- Name: os os_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.os
    ADD CONSTRAINT os_pkey PRIMARY KEY (name);


--
-- Name: architectures systems_architecture_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.architectures
    ADD CONSTRAINT systems_architecture_pkey PRIMARY KEY (architecture);


--
-- Name: availability_zones systems_az_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.availability_zones
    ADD CONSTRAINT systems_az_pkey PRIMARY KEY (datacenter, zone);


--
-- Name: datacenters systems_datacenter_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.datacenters
    ADD CONSTRAINT systems_datacenter_pkey PRIMARY KEY (datacenter);


--
-- Name: systems systems_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.systems
    ADD CONSTRAINT systems_pkey PRIMARY KEY (system_name);


--
-- Name: platforms systems_platforms_pkey; Type: CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.platforms
    ADD CONSTRAINT systems_platforms_pkey PRIMARY KEY (platform_name);


--
-- Name: a dns_a_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_a_delete_queue AFTER DELETE ON dns.a FOR EACH ROW EXECUTE FUNCTION dns.queue_delete();


--
-- Name: a dns_a_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_a_insert BEFORE INSERT ON dns.a FOR EACH ROW EXECUTE FUNCTION dns.a_insert();


--
-- Name: a dns_a_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_a_insert_queue AFTER INSERT ON dns.a FOR EACH ROW EXECUTE FUNCTION dns.queue_insert();


--
-- Name: a dns_a_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_a_update BEFORE UPDATE ON dns.a FOR EACH ROW EXECUTE FUNCTION dns.a_update();


--
-- Name: a dns_a_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_a_update_queue AFTER UPDATE ON dns.a FOR EACH ROW EXECUTE FUNCTION dns.queue_update();


--
-- Name: cname dns_cname_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_cname_delete_queue AFTER DELETE ON dns.cname FOR EACH ROW EXECUTE FUNCTION dns.queue_delete();


--
-- Name: cname dns_cname_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_cname_insert BEFORE INSERT ON dns.cname FOR EACH ROW EXECUTE FUNCTION dns.cname_insert();


--
-- Name: cname dns_cname_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_cname_insert_queue AFTER INSERT ON dns.cname FOR EACH ROW EXECUTE FUNCTION dns.queue_insert();


--
-- Name: cname dns_cname_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_cname_update BEFORE UPDATE ON dns.cname FOR EACH ROW EXECUTE FUNCTION dns.cname_update();


--
-- Name: cname dns_cname_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_cname_update_queue AFTER UPDATE ON dns.cname FOR EACH ROW EXECUTE FUNCTION dns.queue_update();


--
-- Name: mx dns_mx_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_mx_delete_queue AFTER DELETE ON dns.mx FOR EACH ROW EXECUTE FUNCTION dns.queue_delete();


--
-- Name: mx dns_mx_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_mx_insert BEFORE INSERT ON dns.mx FOR EACH ROW EXECUTE FUNCTION dns.mx_insert();


--
-- Name: mx dns_mx_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_mx_insert_queue AFTER INSERT ON dns.mx FOR EACH ROW EXECUTE FUNCTION dns.queue_insert();


--
-- Name: mx dns_mx_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_mx_update BEFORE UPDATE ON dns.mx FOR EACH ROW EXECUTE FUNCTION dns.mx_update();


--
-- Name: mx dns_mx_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_mx_update_queue AFTER UPDATE ON dns.mx FOR EACH ROW EXECUTE FUNCTION dns.queue_update();


--
-- Name: ns dns_ns_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_ns_delete_queue AFTER DELETE ON dns.ns FOR EACH ROW EXECUTE FUNCTION dns.ns_query_delete();


--
-- Name: ns dns_ns_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_ns_insert_queue AFTER INSERT ON dns.ns FOR EACH ROW EXECUTE FUNCTION dns.ns_query_insert();


--
-- Name: ns dns_ns_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_ns_update_queue AFTER UPDATE ON dns.ns FOR EACH ROW EXECUTE FUNCTION dns.ns_query_update();


--
-- Name: srv dns_srv_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_srv_delete_queue AFTER DELETE ON dns.srv FOR EACH ROW EXECUTE FUNCTION dns.queue_delete();


--
-- Name: srv dns_srv_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_srv_insert BEFORE INSERT ON dns.srv FOR EACH ROW EXECUTE FUNCTION dns.srv_insert();


--
-- Name: srv dns_srv_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_srv_insert_queue AFTER INSERT ON dns.srv FOR EACH ROW EXECUTE FUNCTION dns.queue_insert();


--
-- Name: srv dns_srv_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_srv_update BEFORE UPDATE ON dns.srv FOR EACH ROW EXECUTE FUNCTION dns.srv_update();


--
-- Name: srv dns_srv_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_srv_update_queue AFTER UPDATE ON dns.srv FOR EACH ROW EXECUTE FUNCTION dns.queue_update();


--
-- Name: txt dns_txt_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_txt_delete_queue AFTER DELETE ON dns.txt FOR EACH ROW EXECUTE FUNCTION dns.txt_query_delete();


--
-- Name: txt dns_txt_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_txt_insert BEFORE INSERT ON dns.txt FOR EACH ROW EXECUTE FUNCTION dns.txt_insert();


--
-- Name: txt dns_txt_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_txt_insert_queue AFTER INSERT ON dns.txt FOR EACH ROW EXECUTE FUNCTION dns.txt_query_insert();


--
-- Name: txt dns_txt_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_txt_update BEFORE UPDATE ON dns.txt FOR EACH ROW EXECUTE FUNCTION dns.txt_update();


--
-- Name: txt dns_txt_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_txt_update_queue AFTER UPDATE ON dns.txt FOR EACH ROW EXECUTE FUNCTION dns.txt_query_update();


--
-- Name: zone_a dns_zone_a_delete; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_a_delete BEFORE DELETE ON dns.zone_a FOR EACH ROW EXECUTE FUNCTION dns.zone_a_delete();


--
-- Name: zone_a dns_zone_a_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_a_delete_queue AFTER DELETE ON dns.zone_a FOR EACH ROW EXECUTE FUNCTION dns.queue_delete();


--
-- Name: zone_a dns_zone_a_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_a_insert BEFORE INSERT ON dns.zone_a FOR EACH ROW EXECUTE FUNCTION dns.zone_a_insert();


--
-- Name: zone_a dns_zone_a_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_a_insert_queue AFTER INSERT ON dns.zone_a FOR EACH ROW EXECUTE FUNCTION dns.queue_insert();


--
-- Name: zone_a dns_zone_a_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_a_update BEFORE UPDATE ON dns.zone_a FOR EACH ROW EXECUTE FUNCTION dns.zone_a_update();


--
-- Name: zone_a dns_zone_a_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_a_update_queue AFTER UPDATE ON dns.zone_a FOR EACH ROW EXECUTE FUNCTION dns.queue_update();


--
-- Name: zone_txt dns_zone_txt_delete_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_txt_delete_queue AFTER DELETE ON dns.zone_txt FOR EACH ROW EXECUTE FUNCTION dns.txt_query_delete();


--
-- Name: zone_txt dns_zone_txt_insert; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_txt_insert BEFORE INSERT ON dns.zone_txt FOR EACH ROW EXECUTE FUNCTION dns.zone_txt_insert();


--
-- Name: zone_txt dns_zone_txt_insert_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_txt_insert_queue AFTER INSERT ON dns.zone_txt FOR EACH ROW EXECUTE FUNCTION dns.txt_query_insert();


--
-- Name: zone_txt dns_zone_txt_update; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_txt_update BEFORE UPDATE ON dns.zone_txt FOR EACH ROW EXECUTE FUNCTION dns.zone_txt_update();


--
-- Name: zone_txt dns_zone_txt_update_queue; Type: TRIGGER; Schema: dns; Owner: starrs
--

CREATE TRIGGER dns_zone_txt_update_queue AFTER UPDATE ON dns.zone_txt FOR EACH ROW EXECUTE FUNCTION dns.txt_query_update();


--
-- Name: addresses ip_addresses_insert; Type: TRIGGER; Schema: ip; Owner: starrs
--

CREATE TRIGGER ip_addresses_insert BEFORE INSERT ON ip.addresses FOR EACH ROW EXECUTE FUNCTION ip.addresses_insert();


--
-- Name: ranges ip_ranges_insert; Type: TRIGGER; Schema: ip; Owner: starrs
--

CREATE TRIGGER ip_ranges_insert BEFORE INSERT ON ip.ranges FOR EACH ROW EXECUTE FUNCTION ip.ranges_insert();


--
-- Name: ranges ip_ranges_update; Type: TRIGGER; Schema: ip; Owner: starrs
--

CREATE TRIGGER ip_ranges_update BEFORE UPDATE ON ip.ranges FOR EACH ROW EXECUTE FUNCTION ip.ranges_update();


--
-- Name: subnets ip_subnets_delete; Type: TRIGGER; Schema: ip; Owner: starrs
--

CREATE TRIGGER ip_subnets_delete BEFORE DELETE ON ip.subnets FOR EACH ROW EXECUTE FUNCTION ip.subnets_delete();


--
-- Name: subnets ip_subnets_insert; Type: TRIGGER; Schema: ip; Owner: starrs
--

CREATE TRIGGER ip_subnets_insert BEFORE INSERT ON ip.subnets FOR EACH ROW EXECUTE FUNCTION ip.subnets_insert();


--
-- Name: subnets ip_subnets_update; Type: TRIGGER; Schema: ip; Owner: starrs
--

CREATE TRIGGER ip_subnets_update BEFORE UPDATE ON ip.subnets FOR EACH ROW EXECUTE FUNCTION ip.subnets_update();


--
-- Name: interface_addresses systems_interface_addresses_insert; Type: TRIGGER; Schema: systems; Owner: starrs
--

CREATE TRIGGER systems_interface_addresses_insert BEFORE INSERT ON systems.interface_addresses FOR EACH ROW EXECUTE FUNCTION systems.interface_addresses_insert();


--
-- Name: interface_addresses systems_interface_addresses_update; Type: TRIGGER; Schema: systems; Owner: starrs
--

CREATE TRIGGER systems_interface_addresses_update BEFORE UPDATE ON systems.interface_addresses FOR EACH ROW EXECUTE FUNCTION systems.interface_addresses_update();


--
-- Name: class_options fk_dhcp_class_options_class; Type: FK CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.class_options
    ADD CONSTRAINT fk_dhcp_class_options_class FOREIGN KEY (class) REFERENCES dhcp.classes(class) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subnet_options fk_dhcp_subnet_options_subnet; Type: FK CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.subnet_options
    ADD CONSTRAINT fk_dhcp_subnet_options_subnet FOREIGN KEY (subnet) REFERENCES ip.subnets(subnet) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: range_options fk_range_options_name; Type: FK CONSTRAINT; Schema: dhcp; Owner: starrs
--

ALTER TABLE ONLY dhcp.range_options
    ADD CONSTRAINT fk_range_options_name FOREIGN KEY (name) REFERENCES ip.ranges(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: a fk_a_type; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.a
    ADD CONSTRAINT fk_a_type FOREIGN KEY (type) REFERENCES dns.types(type) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: a fk_a_zone; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.a
    ADD CONSTRAINT fk_a_zone FOREIGN KEY (zone) REFERENCES dns.zones(zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: cname fk_cname_fqdn; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.cname
    ADD CONSTRAINT fk_cname_fqdn FOREIGN KEY (hostname, address, zone) REFERENCES dns.a(hostname, address, zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: a fk_dns_a_address; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.a
    ADD CONSTRAINT fk_dns_a_address FOREIGN KEY (address) REFERENCES systems.interface_addresses(address) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ns fk_dns_ns_zone; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.ns
    ADD CONSTRAINT fk_dns_ns_zone FOREIGN KEY (zone) REFERENCES dns.zones(zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: zone_a fk_dns_zone_a_address; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zone_a
    ADD CONSTRAINT fk_dns_zone_a_address FOREIGN KEY (address) REFERENCES systems.interface_addresses(address) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: zones fk_dns_zones_keyname; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zones
    ADD CONSTRAINT fk_dns_zones_keyname FOREIGN KEY (keyname) REFERENCES dns.keys(keyname) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mx fk_mx_fqdn; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.mx
    ADD CONSTRAINT fk_mx_fqdn FOREIGN KEY (hostname, address, zone) REFERENCES dns.a(hostname, address, zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: mx fk_mx_type; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.mx
    ADD CONSTRAINT fk_mx_type FOREIGN KEY (type) REFERENCES dns.types(type) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: soa fk_soa_zone; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.soa
    ADD CONSTRAINT fk_soa_zone FOREIGN KEY (zone) REFERENCES dns.zones(zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: srv fk_srv_fqdn; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.srv
    ADD CONSTRAINT fk_srv_fqdn FOREIGN KEY (hostname, address, zone) REFERENCES dns.a(hostname, address, zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: txt fk_txt_fqdn; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.txt
    ADD CONSTRAINT fk_txt_fqdn FOREIGN KEY (hostname, address, zone) REFERENCES dns.a(hostname, address, zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: txt fk_txt_type; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.txt
    ADD CONSTRAINT fk_txt_type FOREIGN KEY (type) REFERENCES dns.types(type) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: zone_a fk_zone_a_type; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zone_a
    ADD CONSTRAINT fk_zone_a_type FOREIGN KEY (type) REFERENCES dns.types(type) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: zone_a fk_zone_a_zone; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zone_a
    ADD CONSTRAINT fk_zone_a_zone FOREIGN KEY (zone) REFERENCES dns.zones(zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: zone_txt fk_zone_txt_zone; Type: FK CONSTRAINT; Schema: dns; Owner: starrs
--

ALTER TABLE ONLY dns.zone_txt
    ADD CONSTRAINT fk_zone_txt_zone FOREIGN KEY (zone) REFERENCES dns.zones(zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ranges fk_ip_ranges_subnet; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT fk_ip_ranges_subnet FOREIGN KEY (subnet) REFERENCES ip.subnets(subnet) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ranges fk_ip_ranges_use; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT fk_ip_ranges_use FOREIGN KEY (use) REFERENCES ip.range_uses(use) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: range_groups fk_range_group_name; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.range_groups
    ADD CONSTRAINT fk_range_group_name FOREIGN KEY (group_name) REFERENCES management.groups("group") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: range_groups fk_range_name; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.range_groups
    ADD CONSTRAINT fk_range_name FOREIGN KEY (range_name) REFERENCES ip.ranges(name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ranges fk_range_zone; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT fk_range_zone FOREIGN KEY (datacenter, zone) REFERENCES systems.availability_zones(datacenter, zone) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ranges fk_ranges_class; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.ranges
    ADD CONSTRAINT fk_ranges_class FOREIGN KEY (class) REFERENCES dhcp.classes(class) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: subnets fk_subnet_vlans; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.subnets
    ADD CONSTRAINT fk_subnet_vlans FOREIGN KEY (datacenter, vlan) REFERENCES network.vlans(datacenter, vlan) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subnets fk_subnets_datacenter; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.subnets
    ADD CONSTRAINT fk_subnets_datacenter FOREIGN KEY (datacenter) REFERENCES systems.datacenters(datacenter) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subnets fk_subnets_zone; Type: FK CONSTRAINT; Schema: ip; Owner: starrs
--

ALTER TABLE ONLY ip.subnets
    ADD CONSTRAINT fk_subnets_zone FOREIGN KEY (zone) REFERENCES dns.zones(zone) ON UPDATE CASCADE ON DELETE SET DEFAULT;


--
-- Name: hosts fk_libvirt_host_name; Type: FK CONSTRAINT; Schema: libvirt; Owner: starrs
--

ALTER TABLE ONLY libvirt.hosts
    ADD CONSTRAINT fk_libvirt_host_name FOREIGN KEY (system_name) REFERENCES systems.systems(system_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: platforms fk_libvirt_platform_name; Type: FK CONSTRAINT; Schema: libvirt; Owner: starrs
--

ALTER TABLE ONLY libvirt.platforms
    ADD CONSTRAINT fk_libvirt_platform_name FOREIGN KEY (platform_name) REFERENCES systems.platforms(platform_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_settings fk_group_settings_group; Type: FK CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.group_settings
    ADD CONSTRAINT fk_group_settings_group FOREIGN KEY ("group") REFERENCES management.groups("group") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: group_members fk_management_group_members; Type: FK CONSTRAINT; Schema: management; Owner: starrs
--

ALTER TABLE ONLY management.group_members
    ADD CONSTRAINT fk_management_group_members FOREIGN KEY ("group") REFERENCES management.groups("group") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vlans fk_network_vlan_datacenter; Type: FK CONSTRAINT; Schema: network; Owner: starrs
--

ALTER TABLE ONLY network.vlans
    ADD CONSTRAINT fk_network_vlan_datacenter FOREIGN KEY (datacenter) REFERENCES systems.datacenters(datacenter) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: snmp fk_snmp_address; Type: FK CONSTRAINT; Schema: network; Owner: starrs
--

ALTER TABLE ONLY network.snmp
    ADD CONSTRAINT fk_snmp_address FOREIGN KEY (address) REFERENCES systems.interface_addresses(address) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: snmp fk_snmp_system_name; Type: FK CONSTRAINT; Schema: network; Owner: starrs
--

ALTER TABLE ONLY network.snmp
    ADD CONSTRAINT fk_snmp_system_name FOREIGN KEY (system_name) REFERENCES systems.systems(system_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: platforms fk_platforms_architectures_arch; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.platforms
    ADD CONSTRAINT fk_platforms_architectures_arch FOREIGN KEY (architecture) REFERENCES systems.architectures(architecture) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: systems fk_system_group; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.systems
    ADD CONSTRAINT fk_system_group FOREIGN KEY ("group") REFERENCES management.groups("group") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: availability_zones fk_systems_az_datacenter; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.availability_zones
    ADD CONSTRAINT fk_systems_az_datacenter FOREIGN KEY (datacenter) REFERENCES systems.datacenters(datacenter) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: systems fk_systems_datacenter; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.systems
    ADD CONSTRAINT fk_systems_datacenter FOREIGN KEY (datacenter) REFERENCES systems.datacenters(datacenter) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: interface_addresses fk_systems_interface_address_class; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interface_addresses
    ADD CONSTRAINT fk_systems_interface_address_class FOREIGN KEY (class) REFERENCES dhcp.classes(class) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: interface_addresses fk_systems_interface_address_config; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interface_addresses
    ADD CONSTRAINT fk_systems_interface_address_config FOREIGN KEY (config) REFERENCES dhcp.config_types(config) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: interface_addresses fk_systems_interface_addresses_mac; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interface_addresses
    ADD CONSTRAINT fk_systems_interface_addresses_mac FOREIGN KEY (mac) REFERENCES systems.interfaces(mac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: interface_addresses fk_systems_interfaces_address; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interface_addresses
    ADD CONSTRAINT fk_systems_interfaces_address FOREIGN KEY (address) REFERENCES ip.addresses(address) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE;


--
-- Name: interfaces fk_systems_interfaces_system_name; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.interfaces
    ADD CONSTRAINT fk_systems_interfaces_system_name FOREIGN KEY (system_name) REFERENCES systems.systems(system_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: os fk_systems_os_family; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.os
    ADD CONSTRAINT fk_systems_os_family FOREIGN KEY (family) REFERENCES systems.os_family(family) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: systems fk_systems_platform; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.systems
    ADD CONSTRAINT fk_systems_platform FOREIGN KEY (platform_name) REFERENCES systems.platforms(platform_name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: systems fk_systems_systems_os; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.systems
    ADD CONSTRAINT fk_systems_systems_os FOREIGN KEY (os_name) REFERENCES systems.os(name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: systems fk_systems_systems_type; Type: FK CONSTRAINT; Schema: systems; Owner: starrs
--

ALTER TABLE ONLY systems.systems
    ADD CONSTRAINT fk_systems_systems_type FOREIGN KEY (type) REFERENCES systems.device_types(type) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: DATABASE starrs; Type: ACL; Schema: -; Owner: starrs
--

GRANT ALL ON DATABASE starrs TO proxstar;


--
-- Name: SCHEMA api; Type: ACL; Schema: -; Owner: starrs
--

GRANT USAGE ON SCHEMA api TO proxstar;


--
-- Name: SCHEMA management; Type: ACL; Schema: -; Owner: starrs
--

GRANT ALL ON SCHEMA management TO proxstar;


--
-- PostgreSQL database dump complete
--

