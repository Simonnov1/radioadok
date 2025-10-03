-- 3bp
select distinct cim
from kiosztas
where adohely = 'Budapest';

-- 4miskolc
select csatorna, teljesitmeny
from kiosztas
where adohely = 'Miskolc'
order by teljesitmeny desc;

-- 5kossuth
select regio.nev, count(regio.nev)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev inner join regio on regio.megye = telepules.megye
where csatorna = 'MR1-Kossuth Rádió'
group by regio.nev;

-- 6resz
select csatorna
from kiosztas
where csatorna like concat('%', adohely, '%');

-- 8resz1
select count(*)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev
where megye = 'Veszprém' and teljesitmeny <= 0.1;

-- 8resz2
select count(*)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev
where megye = 'Veszprém' and teljesitmeny > 0.1 and teljesitmeny < 1;

-- 8resz1
select count(*)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev
where megye = 'Veszprém' and teljesitmeny > 1;

-- 8katossz
select (select count(*)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev
where megye = 'Veszprém' and teljesitmeny <= 0.1) as helyi, (select count(*)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev
where megye = 'Veszprém' and teljesitmeny > 0.1 and teljesitmeny < 1) as tersegi, (select count(*)
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev
where megye = 'Veszprém' and teljesitmeny > 1) as orszagos;

-- 9helyi
select adohely
from kiosztas
where adohely not in (select adohely from kiosztas where teljesitmeny > 0.1);

-- 10orszagos
select csatorna, adohely, cim, teljesitmeny
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev inner join regio on regio.megye = telepules.megye
order by teljesitmeny
limit 1;

-- 11sugarzok
select nev, count(*)
from (select distinct regio.nev, adohely
from telepules inner join kiosztas on kiosztas.adohely = telepules.nev inner join regio on regio.megye = telepules.megye) as asd
group by nev;
