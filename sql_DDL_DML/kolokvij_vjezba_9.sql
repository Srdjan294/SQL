drop database if exists kolokvij_vjezba_9;
create database kolokvij_vjezba_9;
use kolokvij_vjezba_9;

create table ostavljena(
sifra int not null primary key auto_increment,
modelnaocala varchar(34) not null,
suknja varchar(32),
eura decimal(18,7) not null,
lipa decimal(15,7) not null,
treciputa datetime not null,
drugiputa datetime not null
);

create table snasa(
sifra int not null primary key auto_increment,
prstena int,
drugiputa datetime not null,
haljina varchar(38) not null,
ostavljena int
);

create table zarucnik(
sifra int not null primary key auto_increment,
gustoca decimal(17,6),
haljina varchar(40),
kratkamajica varchar(48) not null,
nausnica int not null,
brat int not null
);

create table brat(
sifra int not null primary key auto_increment,
novcica decimal(18,9) not null,
ekstroventno bit,
vesta varchar(32) not null,
cura int
);

create table cura(
sifra int not null primary key auto_increment,
vesta varchar(49) not null,
ekstroventno bit,
carape varchar(37),
suknja varchar(37) not null,
punac int not null
);

create table punac(
sifra int not null primary key auto_increment,
narukvica int not null,
modelnaocala varchar(30),
kuna decimal(12,8),
bojaociju varchar(33),
suknja varchar(45)
);

create table punac_prijateljica(
sifra int not null primary key auto_increment,
punac int not null,
prijateljica int not null
);

create table prijateljica(
sifra int not null primary key auto_increment,
treciputa datetime,
novcica decimal(16,7),
kuna decimal(14,10) not null,
drugiputa datetime,
haljina varchar(45),
kratkamajica varchar(49)
);

alter table snasa add foreign key (ostavljena) references ostavljena(sifra);

alter table zarucnik add foreign key (brat) references brat(sifra);

alter table brat add foreign key (cura) references cura(sifra);

alter table cura add foreign key (punac) references punac(sifra);

alter table punac_prijateljica add foreign key (punac) references punac(sifra);
alter table punac_prijateljica add foreign key (prijateljica) references prijateljica(sifra);

#1. U tablice brat, cura i punac_prijateljica unesite po 3 retka.

#describe brat;
#describe cura;
#describe punac;
#describe punac_prijateljica;
#describe prijateljica;

insert into prijateljica(treciputa,novcica,kuna,drugiputa,haljina,kratkamajica) values
('2020-01-01',1.1,4.4,'2020-04-04','ab','žuta'),
('2020-02-02',2.2,5.5,'2020-05-05','cd','crvena'),
('2020-03-03',3.3,6.6,'2020-06-06','ef','crna');

insert into punac(narukvica,modelnaocala,kuna,bojaociju,suknja) values
(1,'ab',1.1,'plava','kratka'),
(2,'cd',2.2,'smeđa','duga'),
(3,'ef',3.3,'crna','srednja');

insert into punac_prijateljica(punac,prijateljica) values
(1,1),(2,2),(3,3);

insert into cura(vesta,ekstroventno,carape,suknja,punac) values
('ab',1,'crne','kratka',1),
('cd',1,'plave','duga',2),
('ef',1,'bijele','srednja',3);

insert into brat(novcica,ekstroventno,vesta,cura) values
(1.1,1,'ab',1),
(2.2,1,'cd',2),
(3.3,1,'ef',3);

#2. U tablici snasa postavite svim zapisima kolonu drugiputa na vrijednost 24. travnja 2020.

#describe snasa;
#describe ostavljena;

insert into ostavljena(modelnaocala,suknja,eura,lipa,treciputa,drugiputa) values
('ab','kratka',1.1,5.5,'2020-01-01','2020-05-05'),
('cd','duga',2.2,6.6,'2020-02-02','2020-06-06'),
('ef','srednja',3.3,7.7,'2020-03-03','2020-07-07');

insert into snasa(prstena,drugiputa,haljina,ostavljena) values
(1,'2020-01-01','ab',1),
(2,'2020-02-02','cd',2),
(3,'2020-03-03','ef',3);

update snasa set drugiputa='2020-04-24';

select * from snasa;

#3. U tablici zarucnik obrišite sve zapise čija je vrijednost kolone haljina jednako AB.

#describe zarucnik;

insert into zarucnik(gustoca,haljina,kratkamajica,nausnica,brat) values
(1.1,'kratka','AB',1,1),
(2.2,'duga','cd',2,2),
(3.3,'srednja','ef',3,3);

delete from zarucnik where haljina='AB';

select * from zarucnik;

#4. Izlistajte carape iz tablice cura uz uvjet da vrijednost kolone ekstroventno nepoznate.

select carape from cura where ekstroventno is null;

#5. Prikažite kuna iz tablice prijateljica, nausnica iz tablice zarucnik te
#   ekstroventno iz tablice brat uz uvjet da su vrijednosti kolone
#   ekstroventno iz tablice cura poznate te da su vrijednosti kolone
#   modelnaocala iz tablice punac sadrže niz znakova ba. Podatke
#   posložite po ekstroventno iz tablice brat silazno.

select a.kuna, f.nausnica, e.ekstroventno 
from prijateljica a inner join punac_prijateljica b on a.sifra=b.prijateljica 
inner join punac c on c.sifra=b.punac 
inner join cura d on c.sifra=d.punac 
inner join brat e on d.sifra=e.cura
inner join zarucnik f on e.sifra=f.brat 
where d.ekstroventno is not null and c.modelnaocala like '%ba%'
order by e.ekstroventno asc;

#6. Prikažite kolone modelnaocala i kuna iz tablice punac čiji se
#   primarni ključ ne nalaze u tablici punac_prijateljica.

select c.modelnaocala, c.kuna 
from punac c left join punac_prijateljica b on c.sifra=b.punac
where b.punac is null;