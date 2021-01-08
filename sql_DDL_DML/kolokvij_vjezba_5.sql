drop database if exists kolokvij_vjezba_5;
create database kolokvij_vjezba_5;
use kolokvij_vjezba_5;

create table zarucnik(
sifra int not null primary key auto_increment,
jmbag char(11),
lipa decimal(12,8),
indiferentno bit not null
);

create table mladic(
sifra int not null primary key auto_increment,
kratkamajica varchar(48) not null,
haljina varchar(30) not null,
asocijalno bit,
zarucnik int
);

create table cura(
sifra int not null primary key auto_increment,
carape varchar(41) not null,
maraka decimal(17,10) not null,
asocijalno bit,
vesta varchar(47) not null
);

create table svekar_cura(
sifra int not null primary key auto_increment,
svekar int not null,
cura int not null
);

create table svekar(
sifra int not null primary key auto_increment,
bojakose varchar(33),
majica varchar(31),
carape varchar(31) not null,
haljina varchar(43),
narukvica int,
eura decimal(14,5) not null
);

create table punac(
sifra int not null primary key auto_increment,
dukserica varchar(33),
prviputa datetime not null,
majica varchar(36),
svekar int not null
);

create table punica(
sifra int not null primary key auto_increment,
hlace varchar(43) not null,
nausnica int not null,
ogrlica int,
vesta varchar(49) not null,
modelnaocala varchar(31) not null,
treciputa datetime not null,
punac int not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
majica varchar(33),
ogrlica int not null,
carape varchar(44),
stilfrizura varchar(42),
punica int not null
);

alter table mladic add foreign key (zarucnik) references zarucnik(sifra);

alter table svekar_cura add foreign key (cura) references cura(sifra);
alter table svekar_cura add foreign key (svekar) references svekar(sifra);

alter table punac add foreign key (svekar) references svekar(sifra);

alter table punica add foreign key (punac) references punac(sifra);

alter table ostavljena add foreign key (punica) references punica(sifra);

#1. U tablice punica, punac i svekar_cura unesite po 3 retka.
#describe punica;
#describe punac;
#describe svekar_cura;
#describe cura;
#describe svekar;

insert into svekar(bojakose,majica,carape,haljina,narukvica,eura) values
('plava','kratka','AB','XY',1,1.2),
('smeđa','duga','CD','ZG',2,3.2),
('crna','srednja','EF','OS',3,3.2);

insert into cura(carape,maraka,asocijalno,vesta) values
('Osijek',1.2,1,'AB'),
('Zagreb',2.2,0,'CD'),
('Rijeka',3.2,1,'EF');

insert into svekar_cura(svekar,cura) values
(1,1),
(2,2),
(3,3);

insert into punac(dukserica,prviputa,majica,svekar) values
('AB','2020-01-01','Osijek',1),
('CD','2020-02-02','Zagreb',2),
('EF','2020-03-03','Rijeka',3);

insert into punica(hlace,nausnica,ogrlica,vesta,modelnaocala,treciputa,punac) values
('AB',1,1,'OS','kockaste','2020-01-01',1),
('CD',2,2,'ZG','okrugle','2020-02-02',2),
('EF',3,3,'RI','trokutaste','2020-02-02',3);

#2. U tablici mladic postavite svim zapisima kolonu haljina na vrijednost Osijek.

select * from mladic;
#describe mladic;
#describe zarucnik;

insert into zarucnik(jmbag,lipa,indiferentno) values
(11111111111,1.2,1),
(22222222222,2.3,1),
(33333333333,3.2,1);

insert into mladic(kratkamajica,haljina,asocijalno,zarucnik) values
('AB','OS',1,1),
('CD','RI',1,2),
('EF','ZG',1,3);

update mladic set haljina = 'Osijek';

#3. U tablici ostavljena obrišite sve zapise čija je vrijednost kolone ogrlica jednako 17.
#describe ostavljena;

insert into ostavljena(majica,ogrlica,carape,stilfrizura,punica) values
('AB',17,'OS','dobra',1),
('CD',2,'ZG','loša',2),
('EF',3,'RI','SREDNJA',3);

delete from ostavljena where ogrlica=17;

select * from ostavljena;

#4. Izlistajte majica iz tablice punac uz uvjet da vrijednost kolone prviputa nepoznate.

select majica from punac where prviputa is null;

#5. Prikažite asocijalno iz tablice cura, stilfrizura iz tablice ostavljena te
#   nausnica iz tablice punica uz uvjet da su vrijednosti kolone prviputa iz
#   tablice punac poznate te da su vrijednosti kolone majica iz tablice
#   svekar sadrže niz znakova ba. Podatke posložite po nausnica iz tablice
#   punica silazno.

select a.asocijalno, f.stilfrizura, e.nausnica 
from cura a inner join svekar_cura b on a.sifra=b.cura 
inner join svekar c on c.sifra=b.svekar 
inner join punac d on c.sifra=d.svekar 
inner join punica e on d.sifra=e.punac 
inner join ostavljena f on e.sifra=f.punica 
where d.prviputa is not null and c.majica like '%ba%';

#6. Prikažite kolone majica i carape iz tablice svekar čiji se primarni ključ ne nalaze u tablici svekar_cura.

select c.majica, c.carape from svekar c left join svekar_cura b on c.sifra=b.svekar 
where b.sifra is null;