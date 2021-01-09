drop database if exists kolokvij_vjezba_6;
create database kolokvij_vjezba_6;
use kolokvij_vjezba_6;

create table punac(
sifra int not null primary key auto_increment,
ekstroventno bit not null,
suknja varchar(30) not null,
majica varchar(44) not null,
prviputa datetime not null
);

create table svekrva(
sifra int not null primary key auto_increment,
hlace varchar(48) not null,
suknja varchar(42) not null,
ogrlica int not null,
treciputa datetime not null,
dukserica varchar(32) not null,
narukvica int not null,
punac int
);

create table ostavljena(
sifra int not null primary key auto_increment,
prviputa datetime not null,
kratkamajica varchar(39) not null,
drugiputa datetime,
maraka decimal(14,10)
);

create table prijatelj_ostavljena(
sifra int not null primary key auto_increment,
prijatelj int not null,
ostavljena int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
haljina varchar(39),
prstena int not null,
introvertno bit,
stilfrizura varchar(36) not null
);

create table brat(
sifra int not null primary key auto_increment,
nausnica int not null,
treciputa datetime not null,
narukvica int not null,
hlace varchar(31),
prijatelj int
);

create table zena(
sifra int not null primary key auto_increment,
novcica decimal(14,8) not null,
narukvica int not null,
dukserica varchar(40) not null,
haljina varchar(30),
hlace varchar(32),
brat int not null
);

create table decko(
sifra int not null primary key auto_increment,
prviputa datetime,
modelnaocala varchar(41),
nausnica int,
zena int not null
);

alter table svekrva add foreign key (punac) references punac(sifra);

alter table prijatelj_ostavljena add foreign key (prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key (ostavljena) references ostavljena(sifra);

alter table brat add foreign key (prijatelj) references prijatelj(sifra);

alter table zena add foreign key (brat) references brat(sifra);

alter table decko add foreign key (zena) references zena(sifra);

#1. U tablice zena, brat i prijatelj_ostavljena unesite po 3 retka.
#describe zena;
#describe brat;
#describe prijatelj;
#describe prijatelj_ostavljena;
#describe ostavljena;

insert into ostavljena(prviputa,kratkamajica,drugiputa,maraka) values
('2020-01-01','AB','2020-04-04',1.2),
('2020-02-02','CD','2020-05-05',2.3),
('2020-03-03','EF','2020-06-06',3.4);

insert into prijatelj(haljina,prstena,introvertno,stilfrizura) values
('AB',1,1,'XY'),
('CD',2,1,'GH'),
('EF',3,1,'IJ');

insert into prijatelj_ostavljena(prijatelj,ostavljena) values
(1,1),
(2,2),
(3,3);

insert into brat(nausnica,treciputa,narukvica,hlace,prijatelj) values
(1,'2020-01-01',1,'AB',1),
(2,'2020-02-02',2,'CD',2),
(3,'2020-03-03',3,'EF',3);

insert into zena(novcica,narukvica,dukserica,haljina,hlace,brat) values
(1.2,1,'AB','plava','kratke',1),
(2.3,2,'CD','crvena','duge',2),
(3.4,3,'EF','žuta','srednje',3);

#2. U tablici svekrva postavite svim zapisima kolonu suknja na vrijednost Osijek.

select * from svekrva;
select * from punac;
#describe punac;
#describe svekrva;

insert into punac(ekstroventno,suknja,majica,prviputa) values
(1,'kratka','AB','2020-01-01'),
(1,'duga','CD','2020-02-02'),
(0,'srednja','EF','2020-03-03');

insert into svekrva(hlace,suknja,ogrlica,treciputa,dukserica,narukvica,punac) values
('crvene','duga',1,'2020-01-01','AB',1,1),
('plave','kratka',2,'2020-02-02','CD',2,2),
('žute','srednja',3,'2020-03-03','EF',3,3);

update svekrva set suknja = "Osijek";

#3. U tablici decko obrišite sve zapise čija je vrijednost kolone modelnaocala manje od AB.

delete from decko where modelnaocala < 'AB';

#4. Izlistajte narukvica iz tablice brat uz uvjet da vrijednost kolone treciputa nepoznate.

select narukvica from brat where treciputa is null;

#5. Prikažite drugiputa iz tablice ostavljena, zena iz tablice decko te
#   narukvica iz tablice zena uz uvjet da su vrijednosti kolone treciputa iz
#   tablice brat poznate te da su vrijednosti kolone prstena iz tablice
#   prijatelj jednake broju 219. Podatke posložite po narukvica iz tablice
#   zena silazno.

select a.drugiputa, f.zena, e.narukvica 
from ostavljena a inner join prijatelj_ostavljena b on a.sifra=b.ostavljena
inner join prijatelj c on c.sifra=b.prijatelj 
inner join brat d on c.sifra=d.prijatelj 
inner join zena e on d.sifra=e.brat 
inner join decko f on e.sifra=f.zena 
where d.treciputa is not null and c.prstena=219
order by e.narukvica desc;

#6. Prikažite kolone prstena i introvertno iz tablice prijatelj čiji se
#   primarni ključ ne nalaze u tablici prijatelj_ostavljena.

select c.prstena, c.introvertno 
from prijatelj c left join prijatelj_ostavljena b on c.sifra=b.prijatelj
where b.sifra is null;