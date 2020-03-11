--Partitionierte Sicht
--statt einer sehr großen Tabelle lieber viele kleinere

--Umsatztabelle wächst von Jahr zu Jahr


use Northwind
GO

create table u2018 (id int identity, jahr int, spx char(4100))
create table u2017 (id int identity, jahr int, spx char(4100)) --theoretisch auf andere DGR
create table u2016 (id int identity, jahr int, spx char(4100))
create table u2019 (id int identity, jahr int, spx char(4100))

--aber die APP sagt: wo ist mein Umsatz????

select * from umsatz where jahr = 2015;
GO

--??


create view Umsatz 
as
select * from u2017
UNION ALL--nicht nach doppelten Zeilen suchen..UNION alleine macht distinct
Select * from u2016
UNION ALL
select * from u2019
UNION ALL
select * from u2018
GO




--Plan anschauen!
select * from umsatz where jahr = 2016
--die Sicht enthält keine Daten!!..

ALTER TABLE dbo.u2016 ADD CONSTRAINT
	CK_u2016 CHECK ((jahr=2016))

ALTER TABLE dbo.u2018 ADD CONSTRAINT
	CK_u2018 CHECK ((jahr=2018))

ALTER TABLE dbo.u2017 ADD CONSTRAINT
	CK_u2017 CHECK ((jahr=2017))


ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK ((jahr=2019))

select * from umsatz where jahr = 2016--trara: nur noch 2016 Tabelle

insert into umsatz (id, jahr, spx) values (1,2016,'xy')

--??

--> Diagramm





