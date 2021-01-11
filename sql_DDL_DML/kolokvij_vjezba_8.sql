drop database if exists kolokvij_vjezba_8;
create database kolokvij_vjezba_8;
use kolokvij_vjezba_8;

create table prijateljica(
sifra int not null primary key auto_increment,
vesta varchar(50),
nausnica int not null,
introvertno bit not null
);

create table cura(
sifra int not null primary key auto_increment,
nausnica int not null,
indiferentno bit,
ogrlica int not null,
gustoca decimal(12,6),
drugiputa datetime,
vesta varchar(33),
prijateljica int
);

create table decko(
sifra int not null primary key auto_increment,
kuna decimal(12,10),
lipa decimal(17,10),
bojakose varchar(44),
treciputa datetime not null,
ogrlica int not null,
ekstroventno bit not null
);

create table muskarac_decko(
sifra int not null primary key auto_increment,
muskarac int not null,
decko int not null
);

create table muskarac(
sifra int not null primary key auto_increment,
haljina varchar(47),
drugiputa datetime not null,
treciputa datetime
);

create table becar(
sifra int not null primary key auto_increment,
eura decimal(15,10) not null,
treciputa datetime,
prviputa datetime,
muskarac int not null
);

create table neprijatelj(
sifra int not null primary key auto_increment,
kratkamajica varchar(44),
introvertno bit,
indiferentno bit,
ogrlica int not null,
becar int not null
);

create table brat(
sifra int not null primary key auto_increment,
introvertno bit,
novcica decimal(14,7) not null,
treciputa datetime,
neprijatelj int
);

alter table cura add foreign key (prijateljica) references prijateljica(sifra);

alter table muskarac_decko add foreign key (muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key (decko) references decko(sifra);

alter table becar add foreign key (muskarac) references muskarac(sifra);

alter table neprijatelj add foreign key (becar) references becar(sifra);

alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);

#1. U tablice neprijatelj, becar i muskarac_decko unesite po 3 retka.
#describe neprijatelj;
#describe becar;
#describe muskarac;
#describe decko;
#describe muskarac_decko;

insert into decko(kuna,lipa,bojakose,treciputa,ogrlica,ekstroventno) values
(1.1,4.4,'AB','2020-01-01',1,1),
(2.2,5.5,'CD','2020-02-02',2,1),
(3.3,6.6,'EF','2020-03-03',3,1);

insert into muskarac(haljina,drugiputa,treciputa) values
('AB','2020-01-01','2020-04-04'),
('CD','2020-02-02','2020-05-05'),
('EF','2020-03-03','2020-06-06');

insert into muskarac_decko(muskarac,decko) values
(1,1),(2,2),(3,3);

insert into becar(eura,treciputa,prviputa,muskarac) values
(1.1,'2020-01-01','2020-04-04',1),
(2.2,'2020-02-02','2020-05-05',2),
(3.3,'2020-03-03','2020-06-06',3);

insert into neprijatelj(kratkamajica,introvertno,indiferentno,ogrlica,becar) values
('AB',1,1,1,1),
('CD',1,1,2,2),
('EF',1,1,3,3);

#2. U tablici cura postavite svim zapisima kolonu indiferentno na vrijednost false.

#describe cura;
#describe prijateljica;

insert into prijateljica(vesta,nausnica,introvertno) values
('AB',1,1),
('CD',2,1),
('EF',3,1);

insert into cura(nausnica,indiferentno,ogrlica,gustoca,drugiputa,vesta,prijateljica) values
(1,1,1,1.1,'2020-01-01','AB',1),
(1,1,2,2.2,'2020-02-02','cd',2),
(1,1,3,3.3,'2020-03-03','ef',3);

update cura set indiferentno=0;

select * from cura;

#3. U tablici brat obrišite sve zapise čija je vrijednost kolone novcica različito od 12,75.

#describe brat;

insert into brat(introvertno,novcica,treciputa,neprijatelj) values
(1,12.75,'2020-01-01',1),
(1,1.1,'2020-02-02',2),
(1,2.2,'2020-03-03',3);

delete from brat where novcica != 12.75;

select * from brat;

#4. Izlistajte prviputa iz tablice becar uz uvjet da vrijednost kolone treciputa nepoznate.

select prviputa from becar where treciputa is null;

#5. Prikažite bojakose iz tablice decko, neprijatelj iz tablice brat te
#   introvertno iz tablice neprijatelj uz uvjet da su vrijednosti kolone
#   treciputa iz tablice becar poznate te da su vrijednosti kolone
#   drugiputa iz tablice muskarac poznate. Podatke posložite po
#   introvertno iz tablice neprijatelj silazno.

select a.bojakose, f.neprijatelj, e.introvertno 
from decko a inner join muskarac_decko b on a.sifra=b.decko 
inner join muskarac c on c.sifra=b.muskarac 
inner join becar d on c.sifra=d.muskarac 
inner join neprijatelj e on d.sifra=e.becar 
inner join brat f on e.sifra=f.neprijatelj 
where d.treciputa is not null and c.drugiputa is not null 
order by e.introvertno asc;

#6. Prikažite kolone drugiputa i treciputa iz tablice muskarac čiji se
#   primarni ključ ne nalaze u tablici muskarac_decko.

select c.drugiputa, c.treciputa
from muskarac c left join muskarac_decko b on c.sifra=b.muskarac 
where b.sifra is null;