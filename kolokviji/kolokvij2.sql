drop database if exists kolokvij2;
create database kolokvij2;
use kolokvij2;

create table prijateljica(
    sifra int not null primary key auto_increment,
    dukserica varchar(39),
    eura decimal(14,7),
    treciputa datetime,
    hlace varchar(44),
    zarucnik int
);

create table punac(
    sifra int not null primary key auto_increment,
    suknja varchar(40),
    vesta varchar(49) not null,
    prviputa datetime,
    brat int
);

create table zarucnik(
    sifra int not null primary key auto_increment,
    indiferentno boolean,
    carape varchar(38),
    kratkamajica varchar(39),
    ekstroventno boolean not null,
    narukvica int,
    kuna decimal(14,8)
);

create table neprijateljica(
    sifra int not null primary key auto_increment,
    introvertno boolean,
    vesta varchar(50) not null,
    gustoca decimal(16,8),
    carape varchar(38) not null,
    lipa decimal(18,5) not null,
    prijateljica int not null
);

create table brat(
    sifra int not null primary key auto_increment,
    gustoca decimal(13,7),
    bojaociju varchar(47),
    modelnaocala varchar(47) not null,
    suknja varchar(44),
    maraka decimal(12,10) not null,
    hlace varchar(48) not null
);

create table svekar(
    sifra int not null primary key auto_increment,
    prstena int not null,
    jmbag char(11),
    lipa decimal(17,7) not null,
    eura decimal(17,9) not null,
    neprijateljica int not null
);

create table punica(
    sifra int not null primary key auto_increment,
    bojaociju varchar(36),
    bojakose varchar(42) not null,
    majica varchar(30),
    prviputa datetime,
    hlace varchar(31),
    asocijalno boolean not null
);

create table zarucnik_punica(
    sifra int not null primary key auto_increment,
    zarucnik int not null,
    punica int not null
);

alter table prijateljica add foreign key (zarucnik) references zarucnik(sifra);

alter table neprijateljica add foreign key (prijateljica) references prijateljica(sifra);

alter table svekar add foreign key (neprijateljica) references neprijateljica(sifra);

alter table zarucnik_punica add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_punica add foreign key (punica) references punica(sifra);

alter table punac add foreign key (brat) references brat(sifra);