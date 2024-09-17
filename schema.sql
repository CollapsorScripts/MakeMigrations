--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 13.3 (Debian 13.3-1.pgdg100+1)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: pomosh
--

-- Удалить базу данных "pomosh", если она существует
DROP DATABASE IF EXISTS pomosh;

-- Создать базу данных "pomosh", если она не существует
CREATE DATABASE pomosh;

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pomosh;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pomosh
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: categorygodsend; Type: TYPE; Schema: public; Owner: pomosh
--

CREATE TYPE public.categorygodsend AS ENUM (
    'ElderlyCategory',
    'KidsCategory',
    'PetsCategory',
    'OtherCategory'
);


ALTER TYPE public.categorygodsend OWNER TO pomosh;

--
-- Name: collect; Type: TYPE; Schema: public; Owner: pomosh
--

CREATE TYPE public.collect AS ENUM (
    'Monthly',
    'One_time',
    'Emergency',
    'General'
);


ALTER TYPE public.collect OWNER TO pomosh;

--
-- Name: dimension; Type: TYPE; Schema: public; Owner: pomosh
--

CREATE TYPE public.dimension AS ENUM (
    'Rub',
    'Pcs',
    'Man'
);


ALTER TYPE public.dimension OWNER TO pomosh;

--
-- Name: task; Type: TYPE; Schema: public; Owner: pomosh
--

CREATE TYPE public.task AS ENUM (
    'Money',
    'Service',
    'Product',
    'Job'
);


ALTER TYPE public.task OWNER TO pomosh;

--
-- Name: userrole; Type: TYPE; Schema: public; Owner: pomosh
--

CREATE TYPE public.userrole AS ENUM (
    'StaffRole',
    'AdminRole',
    'PartnerRole',
    'VendorRole',
    'SuperUserRole',
    'PersonRole'
);


ALTER TYPE public.userrole OWNER TO pomosh;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO pomosh;

--
-- Name: company_user; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.company_user (
    user_id uuid NOT NULL,
    title character varying,
    phone character varying,
    address character varying,
    site character varying,
    inn character varying,
    kpp character varying,
    okpo character varying,
    card_number character varying(256) NOT NULL
);


ALTER TABLE public.company_user OWNER TO pomosh;

--
-- Name: donat; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.donat (
    id integer NOT NULL,
    user_id uuid NOT NULL,
    order_id uuid NOT NULL,
    summa double precision NOT NULL,
    date_done timestamp without time zone NOT NULL,
    creation_date date DEFAULT CURRENT_DATE NOT NULL,
    is_active boolean NOT NULL
);


ALTER TABLE public.donat OWNER TO pomosh;

--
-- Name: donat_id_seq; Type: SEQUENCE; Schema: public; Owner: pomosh
--

CREATE SEQUENCE public.donat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.donat_id_seq OWNER TO pomosh;

--
-- Name: donat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pomosh
--

ALTER SEQUENCE public.donat_id_seq OWNED BY public.donat.id;


--
-- Name: god_send; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.god_send (
    id uuid NOT NULL,
    creator_id integer NOT NULL,
    name character varying NOT NULL,
    passport character varying(256) NOT NULL,
    card_number_gods integer,
    card_number character varying(256) NOT NULL,
    country character varying NOT NULL,
    city_id character varying NOT NULL,
    address character varying NOT NULL,
    phone character varying NOT NULL,
    email character varying NOT NULL,
    category public.categorygodsend NOT NULL,
    moderator_id uuid NOT NULL,
    "check" boolean,
    data_check timestamp without time zone,
    creation_date date DEFAULT CURRENT_DATE NOT NULL,
    is_active boolean NOT NULL
);


ALTER TABLE public.god_send OWNER TO pomosh;

--
-- Name: godsend_photos; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.godsend_photos (
    godsend_id uuid NOT NULL,
    photo_id integer NOT NULL
);


ALTER TABLE public.godsend_photos OWNER TO pomosh;

--
-- Name: natural_user; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.natural_user (
    user_id uuid NOT NULL,
    name character varying,
    phone character varying,
    address character varying,
    card_number character varying(256) NOT NULL
);


ALTER TABLE public.natural_user OWNER TO pomosh;

--
-- Name: order; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public."order" (
    id uuid NOT NULL,
    godsend_id uuid NOT NULL,
    title character varying NOT NULL,
    description character varying,
    task public.task NOT NULL,
    order_sum integer NOT NULL,
    dimension public.dimension NOT NULL,
    collect_id public.collect NOT NULL,
    moderator_id uuid NOT NULL,
    "check" boolean,
    data_check timestamp without time zone,
    text_check character varying,
    creation_date date DEFAULT CURRENT_DATE NOT NULL,
    is_active boolean NOT NULL
);


ALTER TABLE public."order" OWNER TO pomosh;

--
-- Name: order_photos; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.order_photos (
    order_id uuid NOT NULL,
    photo_id integer NOT NULL
);


ALTER TABLE public.order_photos OWNER TO pomosh;

--
-- Name: photo; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    name character varying NOT NULL,
    url character varying NOT NULL,
    creation_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.photo OWNER TO pomosh;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: pomosh
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO pomosh;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pomosh
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: product_basket; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.product_basket (
    id integer NOT NULL,
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.product_basket OWNER TO pomosh;

--
-- Name: product_basket_id_seq; Type: SEQUENCE; Schema: public; Owner: pomosh
--

CREATE SEQUENCE public.product_basket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_basket_id_seq OWNER TO pomosh;

--
-- Name: product_basket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pomosh
--

ALTER SEQUENCE public.product_basket_id_seq OWNED BY public.product_basket.id;


--
-- Name: product_photos; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.product_photos (
    product_id integer NOT NULL,
    photo_id integer NOT NULL
);


ALTER TABLE public.product_photos OWNER TO pomosh;

--
-- Name: product_shop; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.product_shop (
    id integer NOT NULL,
    product_name character varying NOT NULL,
    price double precision,
    title character varying NOT NULL,
    description character varying,
    quantity integer,
    creator_id integer NOT NULL,
    is_active boolean NOT NULL,
    creation_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public.product_shop OWNER TO pomosh;

--
-- Name: product_shop_id_seq; Type: SEQUENCE; Schema: public; Owner: pomosh
--

CREATE SEQUENCE public.product_shop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_shop_id_seq OWNER TO pomosh;

--
-- Name: product_shop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pomosh
--

ALTER SEQUENCE public.product_shop_id_seq OWNED BY public.product_shop.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public."user" (
    id uuid NOT NULL,
    email character varying NOT NULL,
    username character varying NOT NULL,
    status character varying,
    role public.userrole NOT NULL,
    company boolean,
    creation_date date DEFAULT CURRENT_DATE NOT NULL
);


ALTER TABLE public."user" OWNER TO pomosh;

--
-- Name: user_photos; Type: TABLE; Schema: public; Owner: pomosh
--

CREATE TABLE public.user_photos (
    user_id uuid NOT NULL,
    photo_id integer NOT NULL
);


ALTER TABLE public.user_photos OWNER TO pomosh;

--
-- Name: donat id; Type: DEFAULT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.donat ALTER COLUMN id SET DEFAULT nextval('public.donat_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: product_basket id; Type: DEFAULT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_basket ALTER COLUMN id SET DEFAULT nextval('public.product_basket_id_seq'::regclass);


--
-- Name: product_shop id; Type: DEFAULT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_shop ALTER COLUMN id SET DEFAULT nextval('public.product_shop_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.alembic_version (version_num) FROM stdin;
f77f39bc22b5
\.


--
-- Data for Name: company_user; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.company_user (user_id, title, phone, address, site, inn, kpp, okpo, card_number) FROM stdin;
\.


--
-- Data for Name: donat; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.donat (id, user_id, order_id, summa, date_done, creation_date, is_active) FROM stdin;
\.


--
-- Data for Name: god_send; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.god_send (id, creator_id, name, passport, card_number_gods, card_number, country, city_id, address, phone, email, category, moderator_id, "check", data_check, creation_date, is_active) FROM stdin;
\.


--
-- Data for Name: godsend_photos; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.godsend_photos (godsend_id, photo_id) FROM stdin;
\.


--
-- Data for Name: natural_user; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.natural_user (user_id, name, phone, address, card_number) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public."order" (id, godsend_id, title, description, task, order_sum, dimension, collect_id, moderator_id, "check", data_check, text_check, creation_date, is_active) FROM stdin;
\.


--
-- Data for Name: order_photos; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.order_photos (order_id, photo_id) FROM stdin;
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.photo (id, name, url, creation_date) FROM stdin;
\.


--
-- Data for Name: product_basket; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.product_basket (id, user_id, product_id, quantity) FROM stdin;
\.


--
-- Data for Name: product_photos; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.product_photos (product_id, photo_id) FROM stdin;
\.


--
-- Data for Name: product_shop; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.product_shop (id, product_name, price, title, description, quantity, creator_id, is_active, creation_date) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public."user" (id, email, username, status, role, company, creation_date) FROM stdin;
\.


--
-- Data for Name: user_photos; Type: TABLE DATA; Schema: public; Owner: pomosh
--

COPY public.user_photos (user_id, photo_id) FROM stdin;
\.


--
-- Name: donat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pomosh
--

SELECT pg_catalog.setval('public.donat_id_seq', 1, false);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pomosh
--

SELECT pg_catalog.setval('public.photo_id_seq', 1, false);


--
-- Name: product_basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pomosh
--

SELECT pg_catalog.setval('public.product_basket_id_seq', 1, false);


--
-- Name: product_shop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pomosh
--

SELECT pg_catalog.setval('public.product_shop_id_seq', 1, false);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: company_user company_user_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.company_user
    ADD CONSTRAINT company_user_pkey PRIMARY KEY (user_id);


--
-- Name: donat donat_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.donat
    ADD CONSTRAINT donat_pkey PRIMARY KEY (id);


--
-- Name: god_send god_send_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.god_send
    ADD CONSTRAINT god_send_pkey PRIMARY KEY (id);


--
-- Name: godsend_photos godsend_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.godsend_photos
    ADD CONSTRAINT godsend_photos_pkey PRIMARY KEY (godsend_id, photo_id);


--
-- Name: natural_user natural_user_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.natural_user
    ADD CONSTRAINT natural_user_pkey PRIMARY KEY (user_id);


--
-- Name: order_photos order_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.order_photos
    ADD CONSTRAINT order_photos_pkey PRIMARY KEY (order_id, photo_id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: product_basket product_basket_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_basket
    ADD CONSTRAINT product_basket_pkey PRIMARY KEY (id);


--
-- Name: product_photos product_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_photos
    ADD CONSTRAINT product_photos_pkey PRIMARY KEY (product_id, photo_id);


--
-- Name: product_shop product_shop_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_shop
    ADD CONSTRAINT product_shop_pkey PRIMARY KEY (id);


--
-- Name: user_photos user_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.user_photos
    ADD CONSTRAINT user_photos_pkey PRIMARY KEY (user_id, photo_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: ix_god_send_id; Type: INDEX; Schema: public; Owner: pomosh
--

CREATE INDEX ix_god_send_id ON public.god_send USING btree (id);


--
-- Name: ix_order_id; Type: INDEX; Schema: public; Owner: pomosh
--

CREATE INDEX ix_order_id ON public."order" USING btree (id);


--
-- Name: ix_user_id; Type: INDEX; Schema: public; Owner: pomosh
--

CREATE INDEX ix_user_id ON public."user" USING btree (id);


--
-- Name: company_user company_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.company_user
    ADD CONSTRAINT company_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: donat donat_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.donat
    ADD CONSTRAINT donat_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: donat donat_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.donat
    ADD CONSTRAINT donat_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: god_send god_send_moderator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.god_send
    ADD CONSTRAINT god_send_moderator_id_fkey FOREIGN KEY (moderator_id) REFERENCES public."user"(id);


--
-- Name: godsend_photos godsend_photos_godsend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.godsend_photos
    ADD CONSTRAINT godsend_photos_godsend_id_fkey FOREIGN KEY (godsend_id) REFERENCES public.god_send(id);


--
-- Name: godsend_photos godsend_photos_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.godsend_photos
    ADD CONSTRAINT godsend_photos_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id);


--
-- Name: natural_user natural_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.natural_user
    ADD CONSTRAINT natural_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: order order_godsend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_godsend_id_fkey FOREIGN KEY (godsend_id) REFERENCES public.god_send(id);


--
-- Name: order order_moderator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_moderator_id_fkey FOREIGN KEY (moderator_id) REFERENCES public."user"(id);


--
-- Name: order_photos order_photos_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.order_photos
    ADD CONSTRAINT order_photos_order_id_fkey FOREIGN KEY (order_id) REFERENCES public."order"(id);


--
-- Name: order_photos order_photos_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.order_photos
    ADD CONSTRAINT order_photos_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id);


--
-- Name: product_basket product_basket_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_basket
    ADD CONSTRAINT product_basket_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product_shop(id);


--
-- Name: product_photos product_photos_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_photos
    ADD CONSTRAINT product_photos_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id);


--
-- Name: product_photos product_photos_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.product_photos
    ADD CONSTRAINT product_photos_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product_shop(id);


--
-- Name: user_photos user_photos_photo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.user_photos
    ADD CONSTRAINT user_photos_photo_id_fkey FOREIGN KEY (photo_id) REFERENCES public.photo(id);


--
-- Name: user_photos user_photos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pomosh
--

ALTER TABLE ONLY public.user_photos
    ADD CONSTRAINT user_photos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--
