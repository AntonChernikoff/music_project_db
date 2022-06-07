CREATE TABLE public.tbl_genre (
	id int4 NOT NULL,
	genre varchar NULL,
	description varchar NULL,
	start_year date NULL,
	CONSTRAINT tbl_genre_pk PRIMARY KEY (id)
);

CREATE TABLE public.tbl_sinders (
	id int4 NOT NULL,
	sinder varchar NULL,
	alias varchar NULL,
	email_address varchar NULL,
	country varchar NULL,
	date_of_birth date NULL,
	id_genre int4 NULL,
	CONSTRAINT tbl_sinders_pk PRIMARY KEY (id)
    --CONSTRAINT tbl_sinders_fk_genre FOREIGN KEY (id_genre) REFERENCES public.tbl_genre(id)
);

create table if not exists tbl_sinders_genre (
	id_sinder int4 references tbl_sinders(id),
	id_genre int4 references tbl_genre(id),
	constraint tbl_sinders_genre_pk primary key (id_sinder, id_genre)
);

CREATE TABLE public.tbl_albums (
	id int4 NOT NULL,
	album varchar NULL,
	city varchar NULL,
	country varchar NULL,
	"year" date NULL,
	id_sinder int4 NULL,
	CONSTRAINT tbl_albums_pk PRIMARY KEY (id)
	--CONSTRAINT tbl_albums_fk_tbl_sinders FOREIGN KEY (id_sinder) REFERENCES public.tbl_sinders(id)
);

create table if not exists tbl_albums_sinders (
	id_album int4 references tbl_albums(id),
	id_sinder int4 references tbl_sinders(id),
	constraint tbl_albums_sinders_pk primary key (id_album, id_sinder)
);

CREATE TABLE public.tbl_tracks (
	id int4 NOT NULL,
	track varchar not NULL,
	description text NULL,
	duration int4 not NULL,
	id_album int4 null,
	CONSTRAINT tbl_tracks_pk PRIMARY KEY (id)
	CONSTRAINT tbl_tracks_fk_tbl_albums FOREIGN KEY (id_album) REFERENCES public.tbl_albums(id)
);

create table public.tbl_collections (
	id int4 not NULL,
	collection varchar NULL,
	description text NULL,
	"year" date NULL,
	constraint tbl_collections_pk primary key (id)
);

create table if not exists tbl_collections_tracks (
	id_collection int4 references tbl_collections(id),
	id_track int4 references tbl_tracks(id),
	constraint tbl_collections_tracks_pk primary key (id_collection, id_track)
);

/*
drop table tbl_sinders_genre;
drop table tbl_albums_sinders;
drop table public.tbl_sinders ;
drop table public.tbl_genre ;
drop table tbl_collections_tracks;
drop table tbl_collections;
drop table public.tbl_tracks ;
drop table public.tbl_albums ;
*/