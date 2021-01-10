drop database if exists kolokvij_vjezba_7;
create database kolokvij_vjezba_7;
use kolokvij_vjezba_7;

create table cura(
sifra int not null primary key auto_increment,
lipa decimal(12,9) not null,
introvertno bit,
modelnaocala varchar(40),
narukvica int,
treciputa datetime,
kuna decimal(14,9)
);

create table punica(
sifra int not null primary key auto_increment,
majica varchar(40),
eura decimal(12,6) not null,
prstena int,
cura int not null
);

create table sestra(
sifra int not null primary key auto_increment,
bojakose varchar(34) not null,
hlace varchar(36) not null,
lipa decimal(15,6),
stilfrizura varchar(40) not null,
maraka decimal(12,8) not null,
prijateljica int
);

create table prijateljica(
sifra int not null primary key auto_increment,
haljina varchar(45),
gustoca decimal(15,10) not null,
ogrlica int,
novcica decimal(12,5),
ostavljen int
);

create table ostavljen(
sifra int not null primary key auto_increment,
lipa decimal(14,6),
introvertno bit not null,
kratkamajica varchar(38) not null,
prstena int not null,
zarucnik int
);

create table zarucnik(
sifra int not null primary key auto_increment,
vesta varchar(39),
asocijalno bit not null,
modelnaocala varchar(43),
narukvica int not null,
novcica decimal(15,5) not null
);

create table zarucnik_mladic(
sifra int not null primary key auto_increment,
zarucnik int not null,
mladic int not null
);

create table mladic(
sifra int not null primary key auto_increment,
prstena int,
lipa decimal(14,5) not null,
narukvica int not null,
drugiputa datetime not null
);

alter table punica add foreign key (cura) references cura(sifra);

alter table sestra add foreign key (prijateljica) references prijateljica(sifra);

alter table prijateljica add foreign key (ostavljen) references ostavljen(sifra);

alter table ostavljen add foreign key (zarucnik) references zarucnik(sifra);

alter table zarucnik_mladic add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_mladic add foreign key (mladic) references mladic(sifra);

#1. U tablice prijateljica, ostavljen i zarucnik_mladic unesite po 3 retka.
#describe prijateljica;
#describe ostavljen;
#describe zarucnik;
#describe zarucnik_mladic;
#describe mladic;

insert into mladic(prstena,lipa,narukvica,drugiputa) values
(1,1.2,1,'2020-01-01'),
(2,1.3,2,'2020-02-02'),
(3,1.3,3,'2020-03-03');

insert into zarucnik(vesta,asocijalno,modelnaocala,narukvica,novcica) values 
('AB',1,'XY',1,1.2),
('CD',1,'IJ',2,1.3),
('EF',1,'GH',3,1.3);

insert into zarucnik_mladic(zarucnik,mladic) values
(1,1),
(2,2),
(3,3);

insert into ostavljen(lipa,introvertno,kratkamajica,prstena,zarucnik) values
(1.2,1,'AB',1,1),
(1.3,1,'CD',2,2),
(1.3,1,'EF',3,3);

insert into prijateljica(haljina,gustoca,ogrlica,novcica,ostavljen) values
('AB',1.2,1,3.1,1),
('CD',1.3,2,3.2,2),
('EF',1.4,3,3.3,3);

#2. U tablici punica postavite svim zapisima kolonu eura na vrijednost 15,77.
#describe punica;
#describe cura;

insert into cura(lipa,introvertno,modelnaocala,narukvica,treciputa,kuna) values
(1.2,1,'AB',1,'2020-01-01',1.2),
(2.2,1,'CD',2,'2020-02-02',2.3),
(3.2,1,'EF',3,'2020-03-03',3.3);

insert into punica(majica,eura,prstena,cura) values
('AB',1.2,1,1),
('CD',1.3,2,2),
('EF',1.4,3,3);

update punica set eura=15.77;

select * from punica;

#3.U tablici sestra obrišite sve zapise čija je vrijednost kolone hlace manje od AB.
#describe sestra;

insert into sestra(bojakose,hlace,lipa,stilfrizura,maraka,prijateljica) values
('ab','duge',1.2,'kratka',2.3,1),
('cd','kratke',2.3,'duga',3.4,2),
('ef','srednje',3.4,'srednja',3.5,3);

delete from sestra where hlace<'AB';

#4. Izlistajte kratkamajica iz tablice ostavljen uz uvjet da vrijednost kolone introvertno nepoznate.

select kratkamajica from ostavljen where introvertno is null;

#5. Prikažite narukvica iz tablice mladic, stilfrizura iz tablice sestra te
#   gustoca iz tablice prijateljica uz uvjet da su vrijednosti kolone
#   introvertno iz tablice ostavljen poznate te da su vrijednosti kolone
#   asocijalno iz tablice zarucnik poznate. Podatke posložite po gustoca iz
#   tablice prijateljica silazno.

select a.narukvica, f.stilfrizura, e.gustoca 
from mladic a inner join zarucnik_mladic b on a.sifra=b.mladic 
inner join zarucnik c on c.sifra=b.zarucnik 
inner join ostavljen d on c.sifra=d.zarucnik 
inner join prijateljica e on d.sifra=e.ostavljen 
inner join sestra f on e.sifra=f.prijateljica
where d.introvertno is not null and c.asocijalno is not null
order by e.gustoca desc;

#6. Prikažite kolone asocijalno i modelnaocala iz tablice zarucnik čiji se
#   primarni ključ ne nalaze u tablici zarucnik_mladic.

select c.asocijalno, c.modelnaocala
from zarucnik c left join zarucnik_mladic b on c.sifra=b.zarucnik 
where b.sifra is null;