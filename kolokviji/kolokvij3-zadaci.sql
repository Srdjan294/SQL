#1. U tablice brat, neprijatelj i becar_djevojka unesite po 3 retka. (7)

#describe brat;
#describe neprijatelj;
#describe becar;
#describe becar_djevojka;
#describe djevojka;


insert into becar (vesta,novcica,ekstroventno,modelnaocala,bojaociju,maraka) values
('vunena',11.22,1,'okrugle','zelena',12.22),
('kratka',22.22,1,'pepeljarke','smeđe',11.22),
('duga',12.11,1,'crne','plave',32.12);

select * from becar;

insert into djevojka (introvertno,maraka,haljina,hlace,prviputa) values
(1,11.22,'zelena','duge','2020-04-03'),
(1,22.11,'crna','kratke','2020-04-01'),
(1,11.11,'plava','srednje','2020-03-01');

select * from djevojka;

insert into becar_djevojka (becar,djevojka) values
(1,1),
(2,2),
(3,3);

select * from becar_djevojka;

insert into neprijatelj (prstena,carape,nausnica,prviputa,stilfrizura,becar) values
(1,'ana',1,'2020-04-03','jež',1),
(2,'crne',2,'2020-01-01','gel',2),
(3,'crvene',3,'2020-02-02','kratka',3);

select * from neprijatelj;

insert into brat (narukvica,introvertno,ekstroventno,vesta,nausnica,neprijatelj) values
(1,1,1,'vunena',1,1),
(2,1,1,'ljetna',2,2),
(3,1,1,'zimska',3,3);

select * from brat;

#2. U tablici cura postavite svim zapisima kolonu gustoca na vrijednost 14,76. (4)

#describe cura;
#describe decko;
insert into decko(suknja,carape,dukserica) values
('crna','crne','crna'),
('bijela','bijele','bijela'),
('crvena','crvene','crvena');

insert into cura (suknja,gustoca,ogrlica,narukvica,hlace,decko) values
('kratka',11.21,1,1,'crne',1),
('duga',21.11,2,2,'bijele',2),
('srednja',12.11,3,3,'crvene',3);

update cura set gustoca=14.76;

select * from cura;

#3. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone asocijalno false. (4)

#describe prijatelj;

insert into prijatelj (kuna,asocijalno,bojaociju,prviputa,hlace,modelnaocala,brat) values
(11.21,1,'smeđa','2020-01-02','crne','pepeljarke',1),
(21.11,0,'zelena','2020-02-02','bijele','rayban',2),
(12.11,1,'plava','2020-02-01','crvene','okrugle',3);

delete from prijatelj where asocijalno=0;
select * from prijatelj;

#4. Izlistajte nausnica iz tablice neprijatelj uz uvjet da vrijednost kolone carape sadrže slova ana. (6)

select *,nausnica from neprijatelj where carape='%ana%';

#5. Prikažite ogrlica iz tablice cura, prviputa iz tablice prijatelj te introvertno iz tablice brat
#uz uvjet da su vrijednosti kolone carape iz tablice neprijatelj počinju slovom a te da su vrijednosti kolone novcica
#iz tablice becar različite od 28. Podatke posložite po introvertno iz tablice brat silazno. (10)

select d.prviputa, c.introvertno 
from becar a
inner join neprijatelj b on a.sifra=b.becar
inner join brat c on b.sifra=c.neprijatelj
inner join prijatelj d on c.sifra=d.brat 
where b.carape='a%' and a.novcica!=28; 


#6. Prikažite kolone novcica i ekstroventno iz tablice becar čiji se primarni ključ ne nalaze u tablici becar_djevojka. (5)

select novcica, ekstroventno from becar 
where sifra not in (select becar from becar_djevojka);