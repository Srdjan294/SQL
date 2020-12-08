drop database if exists kolokvij3;
create database kolokvij3;
use kolokvij3;

create table cura(
    sifra int not null primary key auto_increment,
    suknja varchar(35),
    gustoca decimal(16,8),
    ogrlica int not null,
    narukvica int,
    hlace varchar(40),
    decko int
);

create table decko(
    sifra int not null primary key auto_increment,
    suknja varchar(45) not null,
    carape varchar(30) not null,
    dukserica varchar(32) not null
);

create table neprijatelj(
    sifra int not null primary key auto_increment,
    prstena int,
    carape varchar(36),
    nausnica int,
    prviputa datetime,
    stilfrizura varchar(39),
    becar int not null
);

create table becar(
    sifra int not null primary key auto_increment,
    vesta varchar(42) not null,
    novcica decimal(14,9),
    ekstroventno boolean,
    modelnaocala varchar(35) not null,
    bojaociju varchar(44),
    maraka decimal(16,8)
);

create table brat(
    sifra int not null primary key auto_increment,
    narukvica int,
    introvertno boolean,
    ekstroventno boolean not null,
    vesta varchar(50) not null,
    nausnica int not null,
    neprijatelj int
);

create table becar_djevojka(
    sifra int not null primary key auto_increment,
    becar int not null,
    djevojka int not null
);

create table prijatelj(
    sifra int not null primary key auto_increment,
    kuna decimal(17,5),
    asocijalno boolean,
    bojaociju varchar(43) not null,
    prviputa datetime not null,
    hlace varchar(45),
    modelnaocala varchar(37) not null,
    brat int
);

create table djevojka(
    sifra int not null primary key auto_increment,
    introvertno boolean not null,
    maraka decimal(18,9),
    haljina varchar(47),
    hlace varchar(33) not null,
    prviputa datetime
);

alter table cura add foreign key (decko) references decko(sifra);

alter table neprijatelj add foreign key (becar) references becar(sifra);

alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);

alter table prijatelj add foreign key (brat) references brat(sifra);

alter table becar_djevojka add foreign key (becar) references becar(sifra);
alter table becar_djevojka add foreign key (djevojka) references djevojka(sifra);