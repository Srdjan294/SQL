#1. U tablice neprijatelj, sestra i zarucnica_mladic unesite po 3 retka. (7)

#describe neprijatelj;
#describe sestra;
#describe zarucnica_mladic;
#describe zarucnica;
#describe mladic;

insert into mladic (majica,eura,hlace,nausnica,bojaociju) values
('crvena',11.22,'duge',1,'plava'),
('plava',22.11,'kratke',2,'smeđa'),
('crna',33.11,'srednje',3,'zelena');

select * from mladic;

insert into zarucnica (ekstroventno,jmbag,novcica,treciputa) values
(1,'11111111111',12.11,'2020-02-01'),
(1,'22222222222',21.22,'2020-03-02'),
(1,'33333333333',31.22,'2020-03-01');

select * from zarucnica;

insert into zarucnica_mladic (zarucnica,mladic) values
(1,1),
(2,2),
(3,3);

select * from zarucnica_mladic;

insert into sestra (indiferentno,prviputa,suknja,haljina,majica,zarucnica) values
(1,'2020-03-05','kratka','plava','kratka',1),
(1,'2020-03-01','duga','crvena','duga',2),
(1,'2020-03-04','srednja','žuta','srednja',3);

select * from sestra;

insert into neprijatelj (prviputa,indiferentno,introvertno,nausnica,vesta,novcica,sestra) values
('2020-03-01',1,1,1,'vunena',11.22,1),
('2020-03-02',1,1,2,'zimska',33.22,2),
('2020-03-04',1,1,3,'ljetna',22.11,3);

select * from neprijatelj;

#2. U tablici prijateljica postavite svim zapisima kolonu ogrlica na vrijednost 17. (4)
#describe prijateljica;
#describe svekrva;
insert into svekrva (hlace,stilfrizura,gustoca) values
('kratke','jež',11.22),
('duge','gel',22.33),
('srednje','kratka',33.22);

#select * from svekrva;
insert into prijateljica (suknja,ogrlica,eura,introvertno,svekrva) values
('kratka',12,22.11,1,1),
('duga',32,22.45,1,2),
('srednja',21,33.22,1,3);

update prijateljica set ogrlica=17;
select * from prijateljica;

#3. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone haljina veće od AB. (4)

delete from prijatelj where haljina>'AB';

#4. Izlistajte suknja iz tablice sestra uz uvjet da vrijednost kolone prviputa nepoznate. (6)

select suknja from sestra where prviputa=null;

#5. Prikažite eura iz tablice prijateljica, lipa iz tablice prijatelj te indiferentno iz tablice neprijatelj
#uz uvjet da su vrijednosti kolone prviputa iz tablice sestra poznate te da su vrijednosti kolone jmbag iz tablice zarucnica poznate.
#Podatke posložite po indiferentno iz tablice neprijatelj silazno. (10)

select d.lipa, c.indiferentno 
from zarucnica a 
inner join sestra b on a.sifra=b.zarucnica 
inner join neprijatelj c on b.sifra=c.sestra 
inner join prijatelj d on c.sifra=d.neprijatelj 
where b.prviputa!=null and a.jmbag!=null;

#6. Prikažite kolone jmbag i novcica iz tablice zarucnica čiji se primarni ključ ne nalaze u tablici zarucnica_mladic. (5)

select jmbag, novcica from zarucnica 
where sifra not in (select zarucnica from zarucnica_mladic);