use steam
go

--Lista todas las columnas de la tabla.

select Nombre,ReleaseDate,RequiredAge,DemoCount,DeveloperCount,DLCCount,Metacritic,
PublisherCount,AchievementCount,ControllerSupport,IsFree,FreeVerAvail,PlatformWindows,
PlatformLinux,PlatformMac,Genre,PriceCurrency,PriceInitial,PriceFinal,ShortDescrip,
HeaderImage,SupportedLanguages,Category,Website
from juegos
go

--Lista todos los diferentes géneros, eliminando duplicados.

select distinct Genre
from juegos
where Genre != ''
group by Genre
order by Genre;
go

--Lista únicamente aquellos juegos que puedan ser jugados únicamente en Linux.

select Nombre,PlatformLinux,PlatformMac,PlatformWindows
from juegos
where PlatformLinux = 'True' and PlatformWindows = 'False' and PlatformMac = 'False';
go

--Lista todos los juegos de rol, ordenador por nota.

select Nombre,Genre,Metacritic
from juegos
where Genre like '%RPG%'
order by Metacritic desc;
go

--Lista todos aquellos juegos que puedan ser jugados en Español pero no en Frances.

select * from juegos
where SupportedLanguages like '%Spanish%'
and SupportedLanguages not like '%French%'

--Lista el nombre del juego, su precio inicial, su precio final y la diferencia entre ambos en una nueva columna.

select concat(Nombre, ' | Precio Inicial: ',
PriceInitial, ' | Precio Final: ', PriceFinal,
' | Diferencia de precio: ', (PriceInitial - PriceFinal) ) 
from juegos

--¿Cuántos juegos hay del siglo pasado?

select * from juegos

select * from juegos
where ReleaseDate  not like '[2___]'

--Devuelve todos los juegos que terminen o en N o en O.

select * from juegos where Nombre like '%n' or Nombre like '%o'

--Devuelve todos los juegos que empiecen por A y que se puedan jugar con mando.

select *
from juegos
where Nombre like 'A%' and ControllerSupport='True';
go

--Devuelve todos aquellos juegos que estén entre el 2000 y el 2010.

select *
from juegos
where ReleaseDate between '2000' and '2010';
go

--Devuelve todos los juegos que sean de la saga Final Fantasy.

select *
from juegos
where Nombre like '%final%fantasy%';
go

--Devuelve todos los juegos que sean de deportes y haya trabajado más de 3 desarrolladores.

select *
from juegos
where Genre like '%sports%' and DeveloperCount > 3;
go
