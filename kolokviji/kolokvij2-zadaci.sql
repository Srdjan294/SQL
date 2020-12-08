#1. U tablice neprijateljica, prijateljica i zarucnik_punica unesite po 3 retka. (7)

#describe neprijateljica;
#describe prijateljica;
#describe zarucnik;
#describe zarucnik_punica;
#describe punica;

insert into zarucnik (indiferentno,carape,kratkamajica,ekstroventno,narukvica,kuna) values
(1,'ba','bijela',1,1,12.33),
(1,'lanene','crna',1,2,11.22),
(1,'pamučne','crvena',1,3,13.22);

select * from zarucnik;

insert into punica (bojaociju,bojakose,majica,prviputa,hlace,asocijalno) values
('smeđa','smeđa','crvena','2020-03-03','kratke',1),
('plava','plava','crna','2020-04-03','duge',1),
('zelena','crna','bijela','2020-03-01','šorc',1);

select * from punica;

insert into zarucnik_punica (zarucnik,punica) values
(1,1),
(2,2),
(3,3);

select * from zarucnik_punica;

insert into prijateljica (dukserica,eura,treciputa,hlace,zarucnik) values
('topla',84,'2020-03-03','crvene',1),
('široka',23.22,'2020-04-01','bijele',2),
('ljetna',22.33,'2020-03-01','crne',3);

select * from prijateljica;

insert into neprijateljica (introvertno,vesta,gustoca,carape,lipa,prijateljica) values
(1,'vunena',1.2,'bijele',12.32,1),
(1,'crvena',3.2,'crne',21.11,2),
(1,'crna',2.1,'crne',12.11,3);

select * from neprijateljica;

#2. U tablici punac postavite svim zapisima kolonu vesta na vrijednost Osijek. (4)
#describe punac;
insert into punac (vesta) values
('crna'),('bijela'),('crvena');
update punac set vesta='Osijek';

select * from punac;

#3. U tablici svekar obrišite sve zapise čija je vrijednost kolone jmbag 00000000007. (4)
#describe svekar;
insert into svekar (prstena,jmbag,lipa,eura,neprijateljica) values
(1,'00000000007',1.11,23.21,1),
(2,'22222222222',2.11,21.21,2),
(3,'33333333333',3.21,23.11,3);

delete from svekar where jmbag='00000000007';
select * from svekar;

#4. Izlistajte treciputa iz tablice prijateljica uz uvjet da vrijednost kolone eura nije 6,14,19,30 ili 40. (6)

select *,treciputa from prijateljica where eura not in (6,14,19,30,40);

#5. Prikažite prviputa iz tablice punac, eura iz tablice svekar te vesta iz tablice neprijateljica
#uz uvjet da su vrijednosti kolone eura iz tablice prijateljica jednako 84te da su vrijednosti 
#kolone carape iz tablice zarucnik sadrže niz znakova ba. Podatke posložite po vesta iz tablice neprijateljica silazno. (10)

select d.eura, c.vesta
from zarucnik a
inner join prijateljica b on a.sifra=b.zarucnik 
inner join neprijateljica c on b.sifra=c.prijateljica 
inner join svekar d on c.sifra=d.neprijateljica
where b.eura=84 and a.carape='%ba%';

#6. Prikažite kolone carape i kratkamajica iz tablice zarucnik čiji se primarni ključ ne nalaze u tablici zarucnik_punica. (5)

select carape, kratkamajica from zarucnik 
where sifra not in (select zarucnik from zarucnik_punica);