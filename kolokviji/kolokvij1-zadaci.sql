#1. U tablice cura, mladic i ostavljena_snasa unesite po 3 retka.

insert into snasa (eura,narukvica,drugiputa,carape) values
(12.34,1,'2020-03-03','vunene'),
(12.54,2,'2020-04-04','zimske'),
(12.43,3,'2020-04-01','ljetne');

#describe snasa;
#select * from snasa;

insert into ostavljena (jmbag,bojaociju,suknja,bojakose,prviputa,carape) values
('11111111111','abad','kratka','plava','2020-04-05','crvene'),
('22222222222','ba','duga','smeđa','2020-03-03','plave'),
('33333333333','ba','srednja','crvena','2020-03-01','crne');

#describe ostavljena;
#select * from ostavljena;

insert into ostavljena_snasa (ostavljena,snasa) values
(1,1),
(2,2),
(1,2);

#describe ostavljena_snasa;
#select * from ostavljena_snasa;

insert into mladic (prstena,maraka,suknja,narukvica,ostavljena) values
(1,9.12,'kratka',1,1),
(2,21.22,'duga',2,2),
(3,21.21,'srednja',3,3);

#describe mladic;
#select * from mladic;

insert into cura (bojakose,jmbag,prstena,dukserica,mladic) values
('smeđa','11111111111',1,'velika',1),
('plava','22222222222',2,'mala',2),
('crvena','33333333333',3,'srednja',3);

#describe cura;
#select * from cura;

#2. U tablici sestra postavite svim zapisima kolonu hlace na vrijednost Osijek.

insert into sestra (hlace,prviputa) values
('grozne','2020-03-03'),
('plave','2020-04-04'),
('crvene','2020-03-01');
#describe sestra;
update sestra set hlace='Osijek';
#select * from sestra;

#3. U tablici punac obrišite sve zapise čija je vrijednost kolone vesta različito od AB.

#describe punac;
insert into punac(ekstroventno,vesta,asocijalno,eura,prviputa) values
(1,'AB',1,12.22,'2020-03-03'),
(1,'debela',1,12.33,'2020-03-01'),
(1,'zimska',1,13.22,'2020-01-02');

#select * from punac;

delete from punac where vesta!='AB';

#4. Izlistajte suknja iz tablice mladic uz uvjet da vrijednost kolone maraka nije 7,11,18,25 ili 40.;

select suknja from mladic where maraka not in (7,11,18,25,40);

#describe mladic;

#5. Prikažite narukvica iz tablice snasa, prviputa iz tablice punac te jmbag
#iz tablice cura uz uvjet da su vrijednosti kolone maraka iz tablice
#mladic različito od 95te da su vrijednosti kolone bojaociju iz tablice
#ostavljena sadrže niz znakova ba. Podatke posložite po jmbag iz
#tablice cura silazno.

select f.narukvica , a.prviputa , b.jmbag
from punac a inner join cura b on a.cura =b.sifra
inner join mladic c on b.mladic =c.sifra
inner join ostavljena d on c.ostavljena =d.sifra
inner join ostavljena_snasa e on e.ostavljena =d.sifra
inner join snasa f on e.snasa =f.sifra
where c.maraka != 95 and d.bojakose like '%ba%'
order by b.jmbag desc;


#6. Prikažite kolone bojaociju i suknja iz tablice ostavljena čiji se
#primarni ključ ne nalaze u tablici ostavljena_snasa.

select a.bojaociju , a.suknja
from ostavljena a left join ostavljena_snasa b on a.sifra =b.ostavljena
where b.ostavljena is null;

