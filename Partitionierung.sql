

--------------------
--Partitionierung---
--------------------

--Funktion
create partition function fnZahl(int) 
as
range left for values (100, 200)

--Schema
create partition  scheme schZahl
as
partition fnZahl to (bis100,bis200, rest)

--Tabelle
create table ptab  (id int identity, nummer int, spx char(4100)) on schZahl(nummer)
GO

--Demodaten
declare @i as int = 0

while @i < 20000
	begin
		insert into ptab (nummer, spx) values (@i, 'XY')
		set @i+=1
	end
GO

select $partition.fnZhal(nummer) as PartID, min(nummer) as kleinste_Nummer, max(nummer) as Groesste_Nummer, count(*) as Anzahl
from
	ptab
group by $partition.fnZahl(nummer)
GO




