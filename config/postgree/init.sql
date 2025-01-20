set client_min_messages = WARNING;
alter table if exists Charge drop constraint if exists FKmcrrn231iqvgeyehoe36w81m1;
alter table if exists Station drop constraint if exists FKmjikxk4hsxgjjbpfw3dk3ma6y;
drop table if exists Charge cascade;
drop table if exists Condominium cascade;
drop table if exists Station cascade;
drop sequence if exists charge_id_seq;

create sequence charge_id_seq start with 1 increment by 1;
create table Charge (
    energyConsumption integer,
    status smallint not null check (status between 0 and 1),
    chargeEnd timestamp(6),
    chargeEndPreview timestamp(6),
    chargeId bigint not null,
    chargeStart timestamp(6) not null,
    userId bigint not null,
    stationId varchar(255) not null,
    primary key (chargeId)
);

create table Condominium (
    cnpj varchar(14) not null,
    address varchar(50) not null,
    name varchar(50) not null,
    primary key (cnpj)
);

create table Station (
    condominiumId integer not null,
    number integer not null,
    status smallint not null check (status between 0 and 2),
    creationDt timestamp(6) not null,
    lastUpdate timestamp(6) not null,
    condominiumCnpj varchar(255) not null,
    id varchar(255) not null,
    primary key (id)
);

alter table if exists Charge
    add constraint FKmcrrn231iqvgeyehoe36w81m1
    foreign key (stationId)
    references Station;

alter table if exists Station
    add constraint FKmjikxk4hsxgjjbpfw3dk3ma6y
    foreign key (condominiumCnpj)
    references Condominium;

insert into Condominium (address, name, cnpj) values ('Rua São Tomé, 705', 'Vila Sul', '12312312300012');
insert into Condominium (address, name, cnpj) values ('Av. Interlagos, 12', 'Lumina', '44312555300017');

insert into Station (condominiumId, condominiumCnpj, creationDt, lastUpdate, number, status, id) values (1, '12312312300012', NOW(), NOW(), 1, 0, '6cc501c3-6a23-4bb4-a5c1-de6d44ef66fd');

insert into Station (condominiumId, condominiumCnpj, creationDt, lastUpdate, number, status, id) values (1, '12312312300012', NOW(), NOW(), 2, 0, 'bebb7052-45d9-4331-8f63-5cd36b4421f9');

insert into Station (condominiumId, condominiumCnpj, creationDt, lastUpdate, number, status, id) values (1, '12312312300012', NOW(), NOW(), 3, 0, '5e4d684f-9c9d-4950-aa87-05b49195fe52');

insert into Station (condominiumId, condominiumCnpj, creationDt, lastUpdate, number, status, id) values (1, '44312555300017', NOW(), NOW(), 1, 0, '777a91b7-46eb-4472-b2b0-050d1b1a9c93');
