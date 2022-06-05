CREATE TABLE public.tbl_music_style (
	id int4 NOT NULL,
	music_style varchar NULL,
	description varchar NULL,
	start_year date NULL,
	CONSTRAINT tbl_music_style_pk PRIMARY KEY (id)
);

CREATE TABLE public.tbl_sinders (
	id int4 NOT NULL,
	singer varchar NULL,
	alias varchar NULL,
	email_address varchar NULL,
	country varchar NULL,
	date_of_birth date NULL,
	id_music_style int4 NULL,
	CONSTRAINT tbl_sinders_pk PRIMARY KEY (id)
    CONSTRAINT tbl_sinders_fk_tbl_music_style FOREIGN KEY (id_music_style) REFERENCES public.tbl_music_style(id)
);

CREATE TABLE public.tbl_albums (
	id int4 NOT NULL,
	album varchar NULL,
	city varchar NULL,
	country varchar NULL,
	"year" date NULL,
	id_music_style int4 NULL,
	id_singer int4 NULL,
	CONSTRAINT tbl_albums_pk PRIMARY KEY (id),
	CONSTRAINT tbl_albums_fk_tbl_sinders FOREIGN KEY (id_singer) REFERENCES public.tbl_sinders(id)
);

CREATE TABLE public.tbl_tracks (
	id int4 NOT NULL,
	track varchar NULL,
	description text NULL,
	duration time NULL,
	id_singer int4 NULL,
	id_album int4 NULL,
	id_music_style int4 NULL,
	CONSTRAINT tbl_tracks_pk PRIMARY KEY (id),
	CONSTRAINT tbl_tracks_fk_tbl_albums FOREIGN KEY (id_album) REFERENCES public.tbl_albums(id),
);