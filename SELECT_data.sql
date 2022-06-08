--название и год выхода альбомов, вышедших в 2018 году;
select album, year from tbl_albums where extract(year from year) = 2018;

--название и продолжительность самого длительного трека;
select track, duration from tbl_tracks order by duration desc limit 1;

--название треков, продолжительность которых не менее 3,5 минуты;
select track, duration from tbl_tracks where duration >= 3.5 * 60; 

--названия сборников, вышедших в период с 2018 по 2020 год включительно;
select collection, year from tbl_collections where extract(year from year) >= 2018 and extract(year from year) <=2020;

--исполнители, чье имя состоит из 1 слова;
select sinder from tbl_sinders where not trim(sinder) like '% %';

--название треков, которые содержат слово "мой"/"my".
select track from tbl_tracks where track like '%мой%' or track like '%my%';



