drop database if exists kolokvij_vjezba_3;
create database kolokvij_vjezba_3;
use kolokvij_vjezba_3;

create table cura(
sifra int not null primary key auto_increment,
dukserica varchar(49),
maraka decimal(13,7),
drugiputa datetime,
majica varchar(49),
novcica decimal(15,8),
ogrlica int not null
);

create table svekar(
sifra int not null primary key auto_increment,
novcica decimal(16,8) not null,
suknja varchar(44) not null,
bojakose varchar(36),
prstena int,
narukvica int not null,
cura int not null
);

create table brat(
sifra int not null primary key auto_increment,
jmbag char(11),
ogrlica int not null,
ekstroventno int not null
);

create table prijatelj_brat(
sifra int not null primary key auto_increment,
prijatelj int not null,
brat int not null
);

create table prijatelj(
sifra int not null primary key auto_increment,
kuna decimal(16,10),
haljina varchar(37),
lipa decimal(13,10),
dukserica varchar(31),
indiferentno bit not null
);

create table ostavljena(
sifra int not null primary key auto_increment,
kuna decimal(17,5),
lipa decimal(15,6),
majica varchar(36),
modelnaocala varchar(31) not null,
prijatelj int
);

create table snasa(
sifra int not null primary key auto_increment,
introvertno bit,
kuna decimal(15,6) not null,
eura decimal(12,9) not null,
treciputa datetime,
ostavljena int not null
);

create table punica(
sifra int not null primary key auto_increment,
asocijalno bit,
kratkamajica varchar(44),
kuna decimal(13,8) not null,
vesta varchar(32) not null,
snasa int
);

alter table svekar add foreign key (cura) references cura(sifra);

alter table prijatelj_brat add foreign key (brat) references brat(sifra);
alter table prijatelj_brat add foreign key (prijatelj) references prijatelj(sifra);

alter table ostavljena add foreign key (prijatelj) references prijatelj(sifra);

alter table snasa add foreign key (ostavljena) references ostavljena(sifra);

alter table punica add foreign key (snasa) references snasa(sifra);

#1.  U tablice snasa, ostavljena i prijatelj_brat unesite po 3 retka.
#describe snasa;
#describe ostavljena;
#describe prijatelj;
#describe brat;
#describe prijatelj_brat;

insert into prijatelj(kuna,haljina,lipa,dukserica,indiferentno) values
(1.2,'crvena',2.3,'plava',1),
(2.3,'bijela',3.23,'crvena',0),
(3.1,'crna',4.2,'žuta',1);

select *  from prijatelj;

insert into brat(jmbag,ogrlica,ekstroventno) values 
(11111111111,1,4),
(22222222222,2,5),
(33333333333,3,6);

select * from brat;

insert into prijatelj_brat(prijatelj,brat) values
(1,1),
(2,2),
(3,3);

select * from prijatelj_brat; 

insert into ostavljena(kuna,lipa,majica,modelnaocala,prijatelj) values
(1.2,5.6,'kratka','okrugle',1),
(2.1,6.7,'duga','kockaste',2),
(3.1,7.5,'srednja','trokutaste',3);

select * from ostavljena;

insert into snasa(introvertno,kuna,eura,treciputa,ostavljena) values
(1,12.1,1.2,'2020-01-01',1),
(1,2.13,2.3,'2020-02-02',2),
(0,3.12,3.4,'2020-03-03',3);

select * from snasa;

# 2. U tablici svekar postavite svim zapisima kolonu suknja na vrijednost Osijek.
#describe svekar;
#describe cura;

insert into cura(dukserica,maraka,drugiputa,majica,novcica,ogrlica) values
('zelena',1.2,'2020-03-03','kratka',4.3,1),
('crvena',2.3,'2020-04-04','srednja',5.2,2),
('žuta',3.1,'2020-05-05','duga',6.3,3);

select * from cura;

insert into svekar(novcica,suknja,bojakose,prstena,narukvica,cura) values
(1.2,'zelena','plava',1,1,1),
(2.3,'plava','smeđa',2,2,2),
(3.2,'crvena','crvena',3,3,3);

select * from svekar;

update svekar set suknja = 'Osijek';

#3. U tablici punica obrišite sve zapise čija je vrijednost kolone kratkamajica jednako AB.
#describe punica;

insert into punica(asocijalno,kratkamajica,kuna,vesta,snasa) values
(1,'AB',1.2,'kratka',1),
(1,'C',2.3,'duga',2),
(0,'D',3.2,'srednja',3);

select * from punica;

delete from punica where kratkamajica = 'AB';

#4. Izlistajte majica iz tablice ostavljena uz uvjet da vrijednost kolone lipa nije 9,10,20,30 ili 35.
#describe ostavljena;
select * from ostavljena;

select majica from ostavljena where lipa not in (9,10,20,30,35);

#5. Prikažite ekstroventno iz tablice brat, vesta iz tablice punica te kuna iz tablice snasa uz uvjet 
#   da su vrijednosti kolone lipa iz tablice ostavljena različito od 91 te da su vrijednosti kolone haljina
#   iz tablice prijatelj sadrže niz znakova ba. Podatke posložite po kuna iz tablice snasa silazno.

select a.ekstroventno, f.vesta, e.kuna 
from brat a inner join prijatelj_brat b on a.sifra=b.brat 
inner join prijatelj c on b.prijatelj=c.sifra 
inner join ostavljena d on d.prijatelj=c.sifra 
inner join snasa e on d.sifra=e.ostavljena 
inner join punica f on e.sifra=f.snasa 
where d.lipa !=91 and c.haljina like '%ba%';

#6 Prikažite kolone haljina i lipa iz tablice prijatelj čiji se primarni ključ ne nalazi u tablici prijatelj_brat.

select a.haljina, a.lipa 
from prijatelj a left join prijatelj_brat b on a.sifra=b.prijatelj 
where b.prijatelj is null;