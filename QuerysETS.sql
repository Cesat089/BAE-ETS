use steam
go

--Lista todas las columnas de la tabla.

select Nombre,ReleaseDate,RequiredAge,DemoCount,DeveloperCount,DLCCount,Metacritic,
PublisherCount,AchievementCount,ControllerSupport,IsFree,FreeVerAvail,PlatformWindows,
PlatformLinux,PlatformMac,Genre,PriceCurrency,PriceInitial,PriceFinal,ShortDescrip,
HeaderImage,SupportedLanguages,Category,Website
from juegos
go

--Lista todos los diferentes g�neros, eliminando duplicados.

select distinct Genre
from juegos
where Genre != ''
group by Genre
order by Genre;
go

--Lista �nicamente aquellos juegos que puedan ser jugados �nicamente en Linux.

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

--Lista todos aquellos juegos que puedan ser jugados en Espa�ol pero no en Frances.

select * from juegos
where SupportedLanguages like '%Spanish%'
and SupportedLanguages not like '%French%'

--Lista el nombre del juego, su precio inicial, su precio final y la diferencia entre ambos en una nueva columna.

select concat(Nombre, ' | Precio Inicial: ',
PriceInitial, ' | Precio Final: ', PriceFinal,
' | Diferencia de precio: ', (PriceInitial - PriceFinal) ) 
from juegos

--�Cu�ntos juegos hay del siglo pasado?

select * from juegos

select * from juegos
where ReleaseDate  not like '[2___]'

--Devuelve todos los juegos que terminen o en N o en O.

select * from juegos where Nombre like '%n' or Nombre like '%o'

--Sprint 2

--Devuelve todos los juegos que empiecen por A y que se puedan jugar con mando.

select *
from juegos
where Nombre like 'A%' and ControllerSupport='True';
go

--Devuelve todos aquellos juegos que est�n entre el 2000 y el 2010.

select *
from juegos
where ReleaseDate between '2000' and '2010';
go

--Devuelve todos los juegos que sean de la saga Final Fantasy.

select *
from juegos
where Nombre like '%final%fantasy%';
go

--Devuelve todos los juegos que sean de deportes y haya trabajado m�s de 3 desarrolladores.

select *
from juegos
where Genre like '%sports%' and DeveloperCount > 3;
go

--�Cuantos juegos hay asociados a cada categoria?

select COUNT(*) as Categorias from juegos
group by Category 

--�Cu�ntos juegos se han sacado en cada a�o?

select ReleaseDate as FechaLanzamiento, COUNT(*) as 'Cantidad Juegos' from juegos
group by ReleaseDate

--En base a la consulta anterior, devuelve aquellos a�os en los que la media de puntuaci�n est� entre un 6 y un 8

select ReleaseDate as FechaLanzamiento, COUNT(*) as 'Cantidad Juegos' from juegos
group by ReleaseDate
having AVG(Metacritic) between 6 and 8

select * from juegos

--�Cu�l es la m�xima, m�nima y puntuaci�n media (AVG) por g�nero?

select Category as Categor�a,MAX(Metacritic) as PuntuacionMAX, 
MIN(Metacritic) as PuntuacionMIN,
AVG(Metacritic) as PuntuacionMedia 
from juegos
group by Category

--Sprint 3

--Usando LIMIT, devuelve el top 10 de juegos con mayor puntuaci�n del 2012.

select TOP 10 Nombre, ReleaseDate, Metacritic
from juegos
where ReleaseDate = '2012'
order by Metacritic desc;
go

--Usando LIMIT, devuelve el top 10 de juegos m�s nuevos de g�nero single player.

select TOP 10 Nombre, ReleaseDate, Category
from juegos
where Category = ' Single Player'
order by ReleaseDate desc;
go

--Devuelve la media de nota de todos aquellos juegos que sean para mayores de 18 a�os.

select RequiredAge, AVG(Metacritic) as 'Nota Media'
from juegos
where RequiredAge = 18
group by RequiredAge;
go

--�Cu�ntos juegos hay asociados a cada tipo (mayor de 18, de 17�)?

select COUNT(*), RequiredAge from juegos 
group by RequiredAge order by RequiredAge desc

-- Devuelve todos aquellos a�os en los que haya menos de 300 juegos.

select COUNT(*)as Cantidad, ReleaseDate as Anio 
from juegos group by ReleaseDate
having COUNT(*) > 300

-- Devuelve todos los juegos que est�n para Mac pero no para Windows.

select * from juegos where PlatformMac = 'true' and PlatformWindows = 'false'

--Sprint 4

--Devuelve todos los juegos donde su precio final sea mayor a su precio inicial.

select Nombre, PriceInitial, PriceFinal
from juegos
where PriceInitial < PriceFinal;
go

--Devuelve todos los juegos que no est�n valorados en d�lares.

select Nombre, PriceCurrency
from juegos
where PriceCurrency not like 'USD';
go

--Devuelve todos los juegos que tengan una mayor nota que 0, pero que hayan suspendido.

select Nombre, Metacritic
from juegos
where Metacritic > 0 and Metacritic < 50;
go

--Devuelve el top 15 de juegos con mayor n�mero de DLC.

select TOP 15 Nombre, DLCCount
from juegos
order by DLCCount desc;
go

--Devuelve la informaci�n de los juegos que s�lo se puedan jugar en Ingl�s.

select *
from juegos
where SupportedLanguages = 'English';
go

--Devuelve el nombre(en min�scula) y la web (en may�scula) de los juegos de acci�n o casuales.

select Lower(Nombre) as 'Nombre (min�sculas)', Upper(Website) as 'Web (may�sculas)', Genre
from juegos
where Genre like '%Actio%' or Genre like '%Casual%';
go

--�Cu�l es el juego indie con mayor nota?

select TOP 1 Nombre, Genre, Metacritic
from juegos
where Genre = ' Indie'
order by Metacritic desc;
go

--�Y con menor nota?

select TOP 1 Nombre, Genre, Metacritic
from juegos
where Genre = ' Indie'
order by Metacritic asc;
go

--Devuelve toda la informaci�n del juego con menor nota, siempre que sea mayor a cero.

select TOP 1 WITH TIES *
from juegos
where Metacritic > 0
order by Metacritic asc;
go

--Devuelve aquellos juegos que tengan mayor nota que la media.

select Nombre, Metacritic
from juegos 
where metacritic > (select Avg(Metacritic)
					from juegos
					where Metacritic != 0);
go

--Devuelve el juego con mayor nota del a�o 2008.

select TOP 1 WITH TIES Nombre, Metacritic, ReleaseDate
from juegos
where ReleaseDate = '2008'
order by Metacritic desc;
go

--Devuelve toda la informaci�n de los juegos que valgan m�s que la media.

select *
from juegos 
where PriceFinal > (select Avg(PriceFinal)
					from juegos
					where PriceFinal != 0);
go

--Devuelve toda la informaci�n de los juegos de Linux que tengan el mayor n�mero de logros (achivements).

select *
from juegos 
where PlatformLinux = 'True' and AchievementCount = (select Max(AchievementCount)
													from juegos);
go