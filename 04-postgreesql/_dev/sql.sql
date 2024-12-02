-- DROP TABLE public.client;

CREATE TABLE public.client (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	first_name varchar NOT NULL,
	last_name varchar NULL,
	email varchar NULL,
	CONSTRAINT client_pk PRIMARY KEY (id)
);

-- DROP TABLE public.phone;

CREATE TABLE public.phone (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	client_id int4 NOT NULL,
	phone varchar NOT NULL,
	CONSTRAINT phone_pk PRIMARY KEY (id),
	CONSTRAINT phone_fk FOREIGN KEY (client_id) REFERENCES public.client(id) ON DELETE CASCADE ON UPDATE CASCADE
);