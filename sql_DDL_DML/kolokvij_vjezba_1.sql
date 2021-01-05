drop database if exists kolokvij_vjezba_1;
create database kolokvij_vjezba_1;
use kolokvij_vjezba_1;

create table sestra(
sifra int not null primary key auto_increment,
introvertno bit,
haljina varchar(31) not null,
maraka decimal(16,6),
hlace varchar(46) not null,
narukvica int not null
);

create table zena(
sifra int not null primary key auto_increment,
treciputa datetime,
hlace varchar(46),
kratkamajica varchar(31) not null,
jmbag char(11) not null,
bojaociju varchar(39) not null,
haljina varchar(44),
sestra int not null
);

create table muskarac(
sifra int not null primary key auto_increment,
bojaociju varchar(50) not null,
hlace varchar(30),
modelnaocala varchar(43),
maraka decimal(14,5) not null,
zena int not null
);

create table mladic(
sifra int not null primary key auto_increment,
suknja varchar(50) not null,
kuna decimal(16,8) not null,
drugiputa datetime,
asocijalno bit,
ekstroventno bit not null,
dukserica varchar(48) not null,
muskarac int
);

create table svekar(
sifra int not null primary key auto_increment,
bojaociju varchar(40) not null,
prstena int,
dukserica varchar(41),
lipa decimal(13,8),
eura decimal(12,7),
majica varchar(35)
);

create table sestra_svekar(
sifra int not null primary key auto_increment,
sestra int not null,
svekar int not null
);

create table punac(
sifra int not null primary key auto_increment,
ogrlica int,
gustoca decimal(14,9),
hlace varchar(41) not null
);

create table cura(
sifra int not null primary key auto_increment,
novcica decimal(16,5) not null,
gustoca decimal(18,6) not null,
lipa decimal(13,10),
ogrlica int not null,
bojakose varchar(38),
suknja varchar(36),
punac int
);

alter table cura add foreign key (punac) references punac(sifra);

alter table mladic add foreign key (muskarac) references muskarac(sifra);

alter table muskarac add foreign key (zena) references zena(sifra);

alter table zena add foreign key (sestra) references sestra(sifra);

alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);

#1. U tablice muskarac, zena i sestra_svekar unesite po 3 retka.
#describe muskarac;
#describe zena;
#describe sestra_svekar;
#describe sestra;
#describe svekar;

insert into svekar (bojaociju,prstena,dukserica,lipa,eura,majica) values
('zelena',1,'vunena',11.11,1.12,'kratka'),
('plava',2,'platnena',22.22,2.13,'duga'),
('crvena',3,'lanena',33.33,3.14,'srednja');

#select * from svekar; 

insert into sestra(introvertno,haljina,maraka,hlace,narukvica) values
(1,'plava',1.2,'crne',1),
(0,'crvena',2.3,'bijele',2),
(1,'zelena',3.4,'ljubičaste',3);

#select * from sestra;

insert into sestra_svekar(sestra,svekar) values
(1,1),
(2,2),
(3,3);

#select * from sestra_svekar;

insert into zena(treciputa,hlace,kratkamajica,jmbag,bojaociju,haljina,sestra) values
('2020-01-02','crne','bijela',11111111111,'zelena','kratka',1),
('2020-02-03','bijele','crvena',22222222222,'plava','duga',2),
('2020-03-04','plave','ljubičasta',33333333333,'crvena','srednja',3);

#select * from zena;

insert into muskarac(bojaociju,hlace,modelnaocala,maraka,zena) values
('zelena','crne','ogrugle',1.2,1),
('plava','bijele','kockaste',2.3,2),
('smeđa','plave','trokutaste',3.4,3);

#select * from muskarac;

#2. U tablici cura postavite svim zapisima kolonu gustoca na vrijednost 15.77
#describe cura;
#describe punac;

insert into punac(ogrlica,gustoca,hlace) values
(1,1.2,'crne'),
(2,2.3,'plave'),
(3,3.4,'bijele');

insert into cura(novcica,gustoca,lipa,ogrlica,bojakose,suknja,punac) values
(1.2,3.1,4.2,1,'plava','kratka',1),
(1.3,3.2,4.3,2,'smeđa','duga',2),
(1.4,3.3,4.4,3,'crna','srednja',3);

select * from cura;

update cura set gustoca=15.77;

#3. U tablici mladic obrišite sve zapise čija je vrijednost kolone kuna veća od 15.78.
#describe mladic;
select * from mladic;

insert into mladic(suknja,kuna,drugiputa,asocijalno,ekstroventno,dukserica,muskarac) values
('plava',11.12,'2020-01-01',1,1,'bijela',1),
('crna',22.11,'2020-02-02',1,1,'crna',2),
('bijela',11.1,'2020-03-03',1,1,'plava',3);

delete from mladic where kuna>15.78;

#4. Izlistajte kratkamajica iz tablice zena uz uvjet da vrijednost kolone hlace sadrži slova ana.

select * from zena;

select kratkamajica from zena where hlace like '%ana%';

#5. Prikažite dukserica iz tablice svekar, asocijalno iz tablice mladic te hlace iz tablice muskarac 
#   uz uvjet da su vrijednosti kolone hlace iz tablice zena počinju slovom a te da su vrijednosti kolone 
#   haljina iz tablice sestra sadrže niz znakova ba. Podatke posložite po hlace iz tablice muskarac silazno.

#select * from svekar;
#select * from mladic;
#select * from muskarac;
#select * from zena;
#select * from sestra;

select a.dukserica, e.asocijalno, f.hlace 
from svekar a inner join sestra_svekar b on a.sifra=b.svekar
inner join sestra c on c.sifra=b.sestra 
inner join zena d on d.sestra=c.sifra 
inner join muskarac f on f.zena=d.sifra 
inner join mladic e on e.muskarac=f.sifra;
where d.hlace like 'a%' and c.haljina like '%ba%'
order by f.hlace desc;

#6.  Prikažite kolone haljina i maraka iz tablice sestra čiji se primarni ključ ne nalaze u tablici sestra_svekar.

#select * from sestra;
#select * from sestra_svekar;

select a.haljina, a.maraka 
from sestra a left join sestra_svekar b on a.sifra=b.sestra 
where b.sestra is null;