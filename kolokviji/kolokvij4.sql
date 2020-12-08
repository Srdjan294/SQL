drop database if exists kolokvij4;
create database kolokvij4;
use kolokvij4;

create table svekrva(
    sifra int not null primary key auto_increment,
    hlace varchar(44) not null,
    stilfrizura varchar(33) not null,
    treciputa datetime,
    carape varchar(39),
    gustoca decimal(16,10) not null
);

create table prijateljica(
    sifra int not null primary key auto_increment,
    suknja varchar(46),
    ogrlica int not null,
    eura decimal(12,7) not null,
    introvertno boolean not null,
    svekrva int not null
);

create table sestra(
    sifra int not null primary key auto_increment,
    indiferentno boolean not null,
    prviputa datetime not null,
    suknja varchar(38),
    haljina varchar(31) not null,
    majica varchar(41) not null,
    zarucnica int
);

create table zarucnica(
    sifra int not null primary key auto_increment,
    ekstroventno boolean,
    jmbag char(11),
    novcica decimal(18,6) not null,
    treciputa datetime not null
);

create table neprijatelj(
    sifra int not null primary key auto_increment,
    prviputa datetime not null,
    indiferentno boolean not null,
    introvertno boolean not null,
    nausnica int,
    vesta varchar(35),
    novcica decimal(17,9),
    sestra int not null
);

create table zarucnica_mladic(
    sifra int not null primary key auto_increment,
    zarucnica int not null,
    mladic int not null
);

create table mladic(
    sifra int not null primary key auto_increment,
    majica varchar(42) not null,
    eura decimal(16,9) not null,
    hlace varchar(45) not null,
    nausnica int,
    bojaociju varchar(35) not null
);

create table prijatelj(
    sifra int not null primary key auto_increment,
    indiferentno boolean,
    haljina varchar(40),
    ekstroventno boolean,
    lipa decimal(18,5),
    ogrlica int not null,
    neprijatelj int
);

alter table prijateljica add foreign key (svekrva) references svekrva(sifra);

alter table sestra add foreign key (zarucnica) references zarucnica(sifra);

alter table neprijatelj add foreign key (sestra) references sestra(sifra);

alter table prijatelj add foreign key (neprijatelj) references neprijatelj(sifra);

alter table zarucnica_mladic add foreign key (zarucnica) references zarucnica(sifra);
alter table zarucnica_mladic add foreign key (mladic) references mladic(sifra);