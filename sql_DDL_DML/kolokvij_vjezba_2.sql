drop database if exists kolokvij_vjezba_2;
create database kolokvij_vjezba_2;
use kolokvij_vjezba_2;

create table prijatelj(
    sifra int not null primary key auto_increment,
    modelnaocala varchar(37),
    treciputa datetime not null,
    ekstroventno boolean not null,
    prviputa datetime,
    svekar int not null
);

create table svekar(
    sifra int not null primary key auto_increment,
    stilfrizura varchar(48),
    ogrlica int not null,
    asocijalno boolean not null
);

create table decko(
    sifra int not null primary key auto_increment,
    indiferentno boolean,
    vesta varchar(34),
    asocijalno boolean not null
);

create table decko_zarucnica(
    sifra int not null primary key auto_increment,
    decko int not null,
    zarucnica int not null
);

create table zarucnica(
    sifra int not null primary key auto_increment,
    narukvica int,
    bojakose varchar(37) not null,
    novcica decimal(15,9),
    lipa decimal(15,8) not null,
    indiferentno boolean not null
);

create table cura(
    sifra int not null primary key auto_increment,
    haljina varchar(33) not null,
    drugiputa datetime,
    suknja varchar(38),
    narukvica int,
    introvertno boolean,
    majica varchar(40) not null,
    decko int
);

create table neprijatelj(
    sifra int not null primary key auto_increment,
    majica varchar(32),
    haljina varchar(43) not null,
    lipa decimal(16,8),
    modelnaocala varchar(49) not null,
    kuna decimal(12,6) not null,
    jmbag char(11),
    cura int
);

create table brat(
    sifra int not null primary key auto_increment,
    suknja varchar(47),
    ogrlica int not null,
    asocijalno boolean not null,
    neprijatelj int not null
);

alter table prijatelj add foreign key (svekar) references svekar(sifra);

alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);

alter table neprijatelj add foreign key (cura) references cura(sifra);

alter table cura add foreign key (decko) references decko(sifra);

alter table decko_zarucnica add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);

#1. U tablice neprijatelj, cura i decko_zarucnica unesite po 3 retka. (7)

#describe neprijatelj;
#describe cura;
#describe decko;
#describe decko_zarucnica;
#describe zarucnica;

insert into zarucnica  (narukvica,bojakose,novcica,lipa,indiferentno) values
(1,'smeđa',11.11,22.22,1),
(2,'plava',12.21,32.21,1),
(3,'crvena',31.12,21.21,1);

select * from zarucnica;

insert into decko (indiferentno,vesta,asocijalno) values
(1,'vunena',1),
(1,'ljetna',1),
(1,'zimska',1);

select * from decko;

insert into decko_zarucnica (decko,zarucnica) values
(1,1),(2,2),(1,2);

select * from decko_zarucnica;

insert into cura (haljina,drugiputa,suknja,narukvica,introvertno,majica,decko) values
('plava',null,'plava',1,1,'crvena',1),
('žuta','2020-02-01','žuta',2,1,'plava',2),
('crvena','2020-01-02','crvena',3,1,'žuta',3);

select * from cura;

insert into neprijatelj (majica,haljina,lipa,modelnaocala,kuna,jmbag,cura) values
('smeđa','plava',12.11,'okrugle',11.21,'11111111111',1),
('plava','crvena',31.21,'rayban',31.22,'22222222222',2),
('ljubičasta','crna',12.22,'crne',12.21,'33333333333',3);

select * from neprijatelj;

#2. U tablici prijatelj postavite svim zapisima kolonu treciputa na vrijednost 30. travnja 2020. (4)
#describe prijatelj;
#describe svekar;

insert into svekar (ogrlica,asocijalno) values
(1,1),(2,1),(3,1);

select * from svekar;

insert into prijatelj (treciputa,ekstroventno,svekar) values
('2020-01-01',1,1),
('2020-02-02',1,2),
('2020-03-03',1,3);

update prijatelj set treciputa='2020-04-30';

select * from prijatelj;

#3. U tablici brat obrišite sve zapise čija je vrijednost kolone ogrlica različito od 14. (4)
#describe brat;

insert into brat (ogrlica,asocijalno,neprijatelj) values
(14,1,1),(1,1,2),(1,1,3);

delete from brat where ogrlica!=14;

select * from brat;

#4. Izlistajte suknja iz tablice cura uz uvjet da vrijednost kolone drugiputa nepoznate. (6)

select suknja from cura where drugiputa is null;

#5. Prikažite novcica iz tablice zarucnica, neprijatelj iz tablice brat te haljina iz tablice neprijatelj 
#uz uvjet da su vrijednosti kolone drugiputa iz tablice cura poznate te da su vrijednosti kolone vesta iz 
#tablice decko sadrže niz znakova ba. Podatke posložite po haljina iz tablice neprijatelj silazno. (10)

select a.novcica, f.neprijatelj, e.haljina 
from zarucnica a inner join decko_zarucnica b on a.sifra=b.zarucnica 
inner join decko c on c.sifra=b.decko 
inner join cura d on d.decko=c.sifra 
inner join neprijatelj e on e.cura=d.sifra 
inner join brat f on f.neprijatelj=e.sifra 
where d.drugiputa is not null and c.vesta like '%ba%'
order by e.haljina desc;

#6. Prikažite kolone vesta i asocijalno iz tablice decko čiji se primarni ključ ne nalaze u tablici decko_zarucnica. (5)

select a.vesta, a.asocijalno 
from decko a left join decko_zarucnica b on a.sifra=b.decko 
where b.decko is null;