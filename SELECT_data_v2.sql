--количество исполнителей в каждом жанре;
select 
	tg.genre as Жанр, 
	count(tsg.id_sinder) as Исполнителей  
from 
	tbl_sinders_genre tsg 
	left join tbl_genre tg 
	on tsg.id_genre = tg.id group by tg.genre ;

--количество треков, вошедших в альбомы 2019-2020 годов;
--select id, album, year from tbl_albums where extract(year from year) >= 2019 and extract(year from year) <=2020;
select 
	count(*) 
from 
	tbl_tracks 
	left join tbl_albums 
	on tbl_albums.id = tbl_tracks.id_album 
where 
	extract(year from tbl_albums.year) >= 2019 
	and extract(year from tbl_albums.year) <=2020
;
			
--средняя продолжительность треков по каждому альбому;
select ta.album , avg(tt.duration) as avg_duration 
from 
	tbl_albums ta 
	left join tbl_tracks tt 
	on ta.id = tt.id_album 
group by ta.album 
having avg(tt.duration) notnull ;

--все исполнители, которые не выпустили альбомы в 2020 году;
select 
	id, sinder 
from 
	tbl_sinders 
	left join tbl_albums_sinders on tbl_albums_sinders.id_sinder = tbl_sinders.id 
	left join tbl_albums on tbl_albums.id = tbl_albums_sinders.id_album 
where 
	extract(year from tbl_albums.year) = 2020
;
--названия сборников, в которых присутствует конкретный исполнитель (выберите сами);

select  
	tc.id, tc.collection, ts.sinder 
from 
	tbl_collections tc
	left join tbl_collections_tracks tct on tct.id_collection  =  tc.id 
	left join tbl_tracks tt on tt.id = tct.id_track 
	left join tbl_albums ta on ta.id  = tt.id_album 
	left join tbl_albums_sinders tas on tas.id_album = ta.id 
	left join tbl_sinders ts on ts.id = tas.id_sinder
where 
	ts.sinder like '%name 17%';
	
--название альбомов, в которых присутствуют исполнители более 1 жанра;
select 
	tbl_albums.album, count(tbl_sinders_genre.id_genre)
from 
	tbl_albums 
	left join tbl_albums_sinders on tbl_albums_sinders.id_album = tbl_albums.id 
	left join tbl_sinders_genre on tbl_sinders_genre.id_sinder = tbl_albums_sinders.id_sinder 
group by tbl_albums.album  
having count(tbl_sinders_genre.id_genre) > 1
;



--наименование треков, которые не входят в сборники;
select track 
from 
	tbl_tracks 
	left join tbl_collections_tracks on tbl_collections_tracks.id_track = tbl_tracks.id 
where 
	tbl_collections_tracks.id_collection is null; 

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
select sinder 
from 
	tbl_sinders 
	left join tbl_albums_sinders on tbl_albums_sinders.id_sinder = tbl_sinders.id 
	left join tbl_tracks on tbl_tracks.id_album = tbl_albums_sinders.id_album 
where
	tbl_tracks.duration = (select min(duration) from tbl_tracks)
;
--название альбомов, содержащих наименьшее количество треков.

select 
	tbl_albums.album, tbl_albums.id, count(tbl_tracks.id) 
from 
	tbl_tracks 
	left join tbl_albums 
	on tbl_albums.id  = tbl_tracks.id_album  
group by 
	tbl_albums.album, tbl_albums.id 
having 
	count(tbl_tracks.id) = 
		(select count(id) from tbl_tracks group by id_album order by count(id) limit 1)
;
