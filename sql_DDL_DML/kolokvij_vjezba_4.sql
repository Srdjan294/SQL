drop database if exists kolokvij_vjezba_4;
create database kolokvij_vjezba_4;
use kolokvij_vjezba_4;

create table ostavljen(
sifra int not null primary key auto_increment,
modelnaocala varchar(43),
introvertno bit,
kuna decimal(14,10)
);

create table punac(
sifra int not null primary key auto_increment,
treciputa datetime,
majica varchar(46),
jmbag char(11) not null,
novcica decimal(18,7) not null,
maraka decimal(12,6) not null,
ostavljen int not null
);

create table mladic(
sifra int not null primary key auto_increment,
kuna decimal(15,9),
lipa decimal(18,5),
nausnica int,
stilfrizura varchar(49),
vesta varchar(34) not null
);

create table zena_mladic(
sifra int not null primary key auto_increment,
zena int not null,
mladic int not null
);

create table zena(
sifra int not null primary key auto_increment,
suknja varchar(39) not null,
lipa decimal(18,7),
prstena int not null
);

create table snasa(
sifra int not null primary key auto_increment,
introvertno bit,
treciputa datetime,
haljina varchar(44) not null,
zena int not null
);

create table becar(
sifra int not null primary key auto_increment,
novcica decimal(14,8),
kratkamajica varchar(48) not null,
bojaociju varchar(36) not null,
snasa int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
eura decimal(16,9),
prstena int not null,
gustoca decimal(16,5),
jmbag char(11) not null,
suknja varchar(47) not null,
becar int not null
);

alter table punac add foreign key (ostavljen) references ostavljen(sifra);

alter table zena_mladic add foreign key (mladic) references mladic(sifra);
alter table zena_mladic add foreign key (zena) references zena(sifra);

alter table snasa add foreign key (zena) references zena(sifra);

alter table becar add  foreign key (snasa) references snasa(sifra);

alter table prijatelj add foreign key (becar) references becar(sifra);

#1. U tablice becar, snasa i zena_mladic unesite po 3 retka.
#describe becar;
#describe snasa;
#describe zena;
#describe zena_mladic;
#describe mladic;

insert into mladic(kuna,lipa,nausnica,stilfrizura,vesta) values
(12.4,1.2,1,'AB','crvena'),
(13.2,2.3,2,'CD','žuta'),
(14.2,3.1,3,'EF','crna');

select * from mladic;

insert into zena(suknja,lipa,prstena) values
('crvena',1.2,1),
('žuta',2.3,2),
('plava',3.2,3);

select * from zena;

insert into zena_mladic(zena,mladic) values
(1,1),
(2,2),
(3,3);

select * from zena_mladic;

insert into snasa(introvertno,treciputa,haljina,zena) values
(1,'2020-01-01','plava',1),
(1,'2020-02-02','crna',2),
(1,'2020-03-03','žuta',3);

select * from snasa;

insert into becar(novcica,kratkamajica,bojaociju,snasa) values
(12.2,'crna','plave',1),
(13.3,'crvena','smeđe',2),
(14.4,'žuta','zelene',3);

select * from becar;

#2. U tablici punac postavite svim zapisima kolonu majica na vrijednost Osijek.

select * from punac;
#describe punac;
#describe ostavljen;

insert into ostavljen(modelnaocala,introvertno,kuna) values
('AB',1,1.2),
('CD',1,2.3),
('EF',1,3.4);

insert into punac(treciputa,majica,jmbag,novcica,maraka,ostavljen) values
('2020-01-01','AB',11111111111,1.2,12.1,1),
('2020-02-02','CD',22222222222,2.3,13.1,2),
('2020-03-03','EF',33333333333,3.4,14.1,3);

update punac set majica="Osijek";

#3. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone prstena veće od 17.

select * from prijatelj;
#describe prijatelj;

insert into prijatelj(eura,prstena,gustoca,jmbag,suknja,becar) values
(1.2,1,13.1,11111111111,'ab',1),
(2.2,2,14.1,22222222222,'cd',2),
(3.2,18,18.1,33333333333,'ef',3);

delete from prijatelj where prstena > 17;

#4. Izlistajte haljina iz tablice snasa uz uvjet da vrijednost kolone treciputa nepoznate.

select * from snasa;

select haljina from snasa where treciputa is null;

#5. Prikažite nausnica iz tablice mladic, jmbag iz tablice prijatelj te
#   kratkamajica iz tablice becar uz uvjet da su vrijednosti kolone
#   treciputa iz tablice snasa poznate te da su vrijednosti kolone lipa iz
#   tablice zena različite od 29. Podatke posložite po kratkamajica iz
#   tablice becar silazno.

select a.nausnica, f.jmbag, e.kratkamajica 
from mladic a inner join zena_mladic b on a.sifra=b.mladic 
inner join zena c on c.sifra=b.zena 
inner join snasa d on c.sifra=d.zena 
inner join becar e on d.sifra=e.snasa 
inner join prijatelj f on e.sifra=f.becar 
where d.treciputa is not null and c.lipa != 29;

#6. Prikažite kolone lipa i prstena iz tablice zena čiji se primarni ključ ne nalaze u tablici zena_mladic.

select c.lipa, c.prstena 
from zena c left join zena_mladic b on c.sifra=b.zena
where b.zena is null;
