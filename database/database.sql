create database if not exists Ollie default char set 'utf8mb4';

use Ollie;

create table if not exists User (
  id char(36) not null,
  document varchar(15) not null,
  createAt bigint not null,
  updatedAt bigint not null,
  fullName varchar(255) not null,
  birthDate bigint not null,
  idCountry char(36) not null,

  constraint fk_idCountry (idCountry) references Country(id)
);

create table if not exists Follower (
  idFollower char(36) not null,
  idUserFollowed char(36) not null,

  constraint fk_idFollower (idFollower) references User(id),
  constraint fk_idUserFollowed (idUserFollowed) references User(id)
);

create table if not exists Post (
  id char(36) not null,
  createdAt bigint not null,
  url varchar(2048), -- saves the url of the file that was uploaded
  media enum('image', 'video'),
  type enum('story'),
  message varchar(500),
  idGroup char(36) -- if the post was did in a group and will not appers in the user page
);

create table if not exists Comment (
  id char(36) not null,
  createdAt bigint not null,
  idPost char(36) not null,
  message varchar(500) not null,
  replyTo char(36) not null,

  constraint fk_idPost (id) references Post(id)
);

create table if not exists Pin (
  id char(36) not null,
  createdAt bigint not null,
  idPost char(36) not null,

  constraint fk_idPost (idPost) references Post(id)
);

create table if not exists Group (
  id char(36) not null,
  name varchar(100) not null,
  description varchar(100) not null,
  image varchar(2048), -- url of the hero image that was uploaded
);

create table if not exists GroupMember (
  idGroup char(36) not null,
  idUser char(36) not null,
  createdAt bigint not null,

  constraint fk_idUser (idUser) references User(id),
  constraint fk_idGroup (idGroup) references Group(id)
);

-- special table to add support for new countries
create table if not exists Country (
  id char(36) not null,
  createdAt bigint not null,
  name varchar(255) not null,
  description varchar(1000)
);
