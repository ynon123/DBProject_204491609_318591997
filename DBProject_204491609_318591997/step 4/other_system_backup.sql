﻿prompt PL/SQL Developer Export Tables for user SYS@XE
prompt Created by yaako on יום שני 01 יולי 2024
set feedback off
set define off

prompt Creating UNIT...
create table UNIT
(
  unitid       INTEGER not null,
  unitlocation VARCHAR2(20) not null,
  unitname     VARCHAR2(20) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table UNIT
  add primary key (UNITID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, update, delete on UNIT to C##SHLSHAPI;

prompt Creating EXCELLENCE...
create table EXCELLENCE
(
  excellencetype VARCHAR2(20) not null,
  excellenceyear NUMBER(4) not null,
  have_money     CHAR(1) not null,
  unitid         INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EXCELLENCE
  add primary key (EXCELLENCETYPE, EXCELLENCEYEAR)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EXCELLENCE
  add foreign key (UNITID)
  references UNIT (UNITID);
alter table EXCELLENCE
  add check (have_money in ('T', 'F'));
grant select, update, delete on EXCELLENCE to C##SHLSHAPI;

prompt Creating PROJECTS...
create table PROJECTS
(
  projectid   INTEGER not null,
  projectname VARCHAR2(20) not null,
  begindate   DATE not null,
  enddate     DATE not null,
  status      VARCHAR2(10) default 'new' not null,
  budget      FLOAT not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PROJECTS
  add primary key (PROJECTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PROJECTS
  add check (status in ('new', 'start', 'middle', 'end' ));
alter table PROJECTS
  add check (budget >= 0);
grant select, update, delete on PROJECTS to C##SHLSHAPI;

prompt Creating INPROJECT...
create table INPROJECT
(
  projectid INTEGER not null,
  personid  INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INPROJECT
  add primary key (PROJECTID, PERSONID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INPROJECT
  add foreign key (PROJECTID)
  references PROJECTS (PROJECTID);
grant select, update, delete on INPROJECT to C##SHLSHAPI;

prompt Creating PERSON...
create table PERSON
(
  personid   NUMBER,
  personname VARCHAR2(20),
  personrole VARCHAR2(20),
  personrank VARCHAR2(20) not null,
  unitid     NUMBER
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
grant select, update, delete on PERSON to C##SHLSHAPI;

prompt Creating RESOURCES...
create table RESOURCES
(
  resourceid    INTEGER not null,
  resourcename  VARCHAR2(20) not null,
  quantity      INTEGER not null,
  resourcestype VARCHAR2(10) not null,
  unitid        INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table RESOURCES
  add primary key (RESOURCEID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table RESOURCES
  add foreign key (UNITID)
  references UNIT (UNITID);
alter table RESOURCES
  add constraint RESOURCESTYPE
  check (resourcesType IN ('low level', 'medium lev', 'high level'));
alter table RESOURCES
  add constraint RESOURCES_TYPE_CHECK
  check (resourcesType IN ('low level', 'medium lev', 'high level'));
grant select, update, delete on RESOURCES to C##SHLSHAPI;

prompt Creating TASK...
create table TASK
(
  taskid    INTEGER not null,
  projectid INTEGER not null,
  enddate   DATE not null,
  begindate DATE not null,
  status    VARCHAR2(10) default 'new'
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TASK
  add primary key (TASKID, PROJECTID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TASK
  add foreign key (PROJECTID)
  references PROJECTS (PROJECTID);
alter table TASK
  add check (status in ('new', 'start', 'middle', 'end' ));
grant select, update, delete on TASK to C##SHLSHAPI;

prompt Disabling triggers for UNIT...
alter table UNIT disable all triggers;
prompt Disabling triggers for EXCELLENCE...
alter table EXCELLENCE disable all triggers;
prompt Disabling triggers for PROJECTS...
alter table PROJECTS disable all triggers;
prompt Disabling triggers for INPROJECT...
alter table INPROJECT disable all triggers;
prompt Disabling triggers for PERSON...
alter table PERSON disable all triggers;
prompt Disabling triggers for RESOURCES...
alter table RESOURCES disable all triggers;
prompt Disabling triggers for TASK...
alter table TASK disable all triggers;
prompt Disabling foreign key constraints for EXCELLENCE...
alter table EXCELLENCE disable constraint SYS_C009490;
prompt Disabling foreign key constraints for INPROJECT...
alter table INPROJECT disable constraint SYS_C009504;
prompt Disabling foreign key constraints for RESOURCES...
alter table RESOURCES disable constraint SYS_C009512;
prompt Disabling foreign key constraints for TASK...
alter table TASK disable constraint SYS_C009520;
prompt Deleting TASK...
delete from TASK;
commit;
prompt Deleting RESOURCES...
delete from RESOURCES;
commit;
prompt Deleting PERSON...
delete from PERSON;
commit;
prompt Deleting INPROJECT...
delete from INPROJECT;
commit;
prompt Deleting PROJECTS...
delete from PROJECTS;
commit;
prompt Deleting EXCELLENCE...
delete from EXCELLENCE;
commit;
prompt Deleting UNIT...
delete from UNIT;
commit;
prompt Loading UNIT...
insert into UNIT (unitid, unitlocation, unitname)
values (1, 'Eilat', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (2, 'Nazareth', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (3, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (4, 'Tel Aviv', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (5, 'Netanya', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (6, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (7, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (8, 'Tiberias', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (9, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (10, 'Tel Aviv', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (11, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (12, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (13, 'Tel Aviv', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (14, 'Tiberias', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (15, 'Netanya', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (16, 'Tel Aviv', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (17, 'Tel Aviv', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (18, 'Tiberias', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (19, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (20, 'Tel Aviv', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (21, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (22, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (23, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (24, 'Eilat', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (25, 'Eilat', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (26, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (27, 'Beersheba', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (28, 'Jerusalem', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (29, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (30, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (31, 'Tel Aviv', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (32, 'Beersheba', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (33, 'Haifa', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (34, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (35, 'Jerusalem', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (36, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (37, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (38, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (39, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (40, 'Jerusalem', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (41, 'Tel Aviv', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (42, 'Ashdod', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (43, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (44, 'Beersheba', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (45, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (46, 'Beersheba', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (47, 'Ashdod', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (48, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (49, 'Haifa', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (50, 'Beersheba', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (51, 'Eilat', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (52, 'Eilat', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (53, 'Beersheba', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (54, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (55, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (56, 'Beersheba', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (57, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (58, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (59, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (60, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (61, 'Netanya', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (62, 'Nazareth', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (63, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (64, 'Nazareth', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (65, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (66, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (67, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (68, 'Tiberias', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (69, 'Ashdod', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (70, 'Nazareth', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (71, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (72, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (73, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (74, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (75, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (76, 'Ashdod', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (77, 'Eilat', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (78, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (79, 'Eilat', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (80, 'Haifa', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (81, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (82, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (83, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (84, 'Tiberias', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (85, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (86, 'Haifa', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (87, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (88, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (89, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (90, 'Netanya', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (91, 'Eilat', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (92, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (93, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (94, 'Haifa', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (95, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (96, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (97, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (98, 'Beersheba', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (99, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (100, 'Tiberias', 'yard');
commit;
prompt 100 records committed...
insert into UNIT (unitid, unitlocation, unitname)
values (101, 'Tiberias', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (102, 'Ashdod', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (103, 'Beersheba', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (104, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (105, 'Beersheba', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (106, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (107, 'Beersheba', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (108, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (109, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (110, 'Beersheba', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (111, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (112, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (113, 'Eilat', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (114, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (115, 'Tel Aviv', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (116, 'Tel Aviv', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (117, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (118, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (119, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (120, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (121, 'Tel Aviv', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (122, 'Beersheba', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (123, 'Haifa', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (124, 'Netanya', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (125, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (126, 'Netanya', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (127, 'Netanya', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (128, 'Nazareth', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (129, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (130, 'Netanya', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (131, 'Netanya', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (132, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (133, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (134, 'Ashdod', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (135, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (136, 'Nazareth', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (137, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (138, 'Beersheba', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (139, 'Netanya', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (140, 'Tiberias', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (141, 'Ashdod', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (142, 'Nazareth', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (143, 'Tiberias', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (144, 'Beersheba', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (145, 'Nazareth', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (146, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (147, 'Eilat', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (148, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (149, 'Jerusalem', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (150, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (151, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (152, 'Haifa', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (153, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (154, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (155, 'Haifa', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (156, 'Ashdod', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (157, 'Ashdod', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (158, 'Tel Aviv', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (159, 'Beersheba', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (160, 'Tel Aviv', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (161, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (162, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (163, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (164, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (165, 'Nazareth', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (166, 'Netanya', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (167, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (168, 'Eilat', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (169, 'Ashdod', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (170, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (171, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (172, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (173, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (174, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (175, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (176, 'Ashdod', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (177, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (178, 'Eilat', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (179, 'Beersheba', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (180, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (181, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (182, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (183, 'Haifa', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (184, 'Netanya', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (185, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (186, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (187, 'Jerusalem', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (188, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (189, 'Nazareth', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (190, 'Beersheba', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (191, 'Netanya', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (192, 'Haifa', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (193, 'Netanya', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (194, 'Haifa', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (195, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (196, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (197, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (198, 'Haifa', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (199, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (200, 'Netanya', 'kilogram');
commit;
prompt 200 records committed...
insert into UNIT (unitid, unitlocation, unitname)
values (201, 'Tiberias', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (202, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (203, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (204, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (205, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (206, 'Nazareth', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (207, 'Netanya', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (208, 'Tel Aviv', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (209, 'Netanya', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (210, 'Nazareth', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (211, 'Nazareth', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (212, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (213, 'Tiberias', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (214, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (215, 'Ashdod', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (216, 'Nazareth', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (217, 'Tel Aviv', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (218, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (219, 'Tel Aviv', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (220, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (221, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (222, 'Eilat', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (223, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (224, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (225, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (226, 'Ashdod', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (227, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (228, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (229, 'Tiberias', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (230, 'Eilat', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (231, 'Jerusalem', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (232, 'Tiberias', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (233, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (234, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (235, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (236, 'Jerusalem', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (237, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (238, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (239, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (240, 'Nazareth', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (241, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (242, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (243, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (244, 'Eilat', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (245, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (246, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (247, 'Beersheba', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (248, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (249, 'Ashdod', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (250, 'Eilat', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (251, 'Tiberias', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (252, 'Tiberias', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (253, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (254, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (255, 'Tiberias', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (256, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (257, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (258, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (259, 'Nazareth', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (260, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (261, 'Nazareth', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (262, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (263, 'Jerusalem', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (264, 'Beersheba', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (265, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (266, 'Ashdod', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (267, 'Tel Aviv', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (268, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (269, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (270, 'Netanya', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (271, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (272, 'Ashdod', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (273, 'Jerusalem', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (274, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (275, 'Ashdod', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (276, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (277, 'Tel Aviv', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (278, 'Jerusalem', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (279, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (280, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (281, 'Haifa', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (282, 'Nazareth', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (283, 'Netanya', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (284, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (285, 'Tiberias', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (286, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (287, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (288, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (289, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (290, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (291, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (292, 'Ashdod', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (293, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (294, 'Tiberias', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (295, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (296, 'Tel Aviv', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (297, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (298, 'Netanya', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (299, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (300, 'Tiberias', 'pound');
commit;
prompt 300 records committed...
insert into UNIT (unitid, unitlocation, unitname)
values (301, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (302, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (303, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (304, 'Tel Aviv', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (305, 'Netanya', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (306, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (307, 'Beersheba', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (308, 'Eilat', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (309, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (310, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (311, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (312, 'Tiberias', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (313, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (314, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (315, 'Netanya', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (316, 'Haifa', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (317, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (318, 'Haifa', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (319, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (320, 'Nazareth', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (321, 'Netanya', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (322, 'Haifa', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (323, 'Jerusalem', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (324, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (325, 'Beersheba', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (326, 'Eilat', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (327, 'Eilat', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (328, 'Tiberias', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (329, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (330, 'Eilat', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (331, 'Tiberias', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (332, 'Tiberias', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (333, 'Nazareth', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (334, 'Eilat', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (335, 'Nazareth', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (336, 'Jerusalem', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (337, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (338, 'Beersheba', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (339, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (340, 'Tiberias', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (341, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (342, 'Ashdod', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (343, 'Tiberias', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (344, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (345, 'Nazareth', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (346, 'Tel Aviv', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (347, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (348, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (349, 'Tel Aviv', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (350, 'Nazareth', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (351, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (352, 'Tel Aviv', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (353, 'Beersheba', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (354, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (355, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (356, 'Ashdod', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (357, 'Jerusalem', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (358, 'Ashdod', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (359, 'Netanya', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (360, 'Eilat', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (361, 'Tiberias', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (362, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (363, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (364, 'Nazareth', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (365, 'Tel Aviv', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (366, 'Ashdod', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (367, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (368, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (369, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (370, 'Haifa', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (371, 'Netanya', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (372, 'Jerusalem', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (373, 'Netanya', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (374, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (375, 'Tel Aviv', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (376, 'Tel Aviv', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (377, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (378, 'Jerusalem', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (379, 'Netanya', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (380, 'Tel Aviv', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (381, 'Tel Aviv', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (382, 'Netanya', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (383, 'Netanya', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (384, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (385, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (386, 'Nazareth', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (387, 'Nazareth', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (388, 'Nazareth', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (389, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (390, 'Eilat', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (391, 'Jerusalem', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (392, 'Eilat', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (393, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (394, 'Tiberias', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (395, 'Ashdod', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (396, 'Netanya', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (397, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (398, 'Eilat', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (399, 'Ashdod', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (400, 'Nazareth', 'pound');
commit;
prompt 400 records committed...
insert into UNIT (unitid, unitlocation, unitname)
values (401, 'Jerusalem', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (402, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (403, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (404, 'Ashdod', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (405, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (406, 'Haifa', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (407, 'Tiberias', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (408, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (409, 'Tel Aviv', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (410, 'Ashdod', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (411, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (412, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (413, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (414, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (415, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (416, 'Netanya', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (417, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (418, 'Haifa', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (419, 'Ashdod', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (420, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (421, 'Eilat', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (422, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (423, 'Tel Aviv', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (424, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (425, 'Ashdod', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (426, 'Ashdod', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (427, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (428, 'Ashdod', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (429, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (430, 'Tel Aviv', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (431, 'Netanya', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (432, 'Eilat', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (433, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (434, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (435, 'Tel Aviv', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (436, 'Beersheba', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (437, 'Beersheba', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (438, 'Tiberias', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (439, 'Jerusalem', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (440, 'Jerusalem', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (441, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (442, 'Nazareth', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (443, 'Beersheba', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (444, 'Ashdod', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (445, 'Beersheba', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (446, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (447, 'Haifa', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (448, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (449, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (450, 'Tiberias', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (451, 'Tiberias', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (452, 'Eilat', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (453, 'Jerusalem', 'meter');
insert into UNIT (unitid, unitlocation, unitname)
values (454, 'Jerusalem', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (455, 'Jerusalem', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (456, 'Eilat', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (457, 'Beersheba', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (458, 'Haifa', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (459, 'Nazareth', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (460, 'Tel Aviv', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (461, 'Haifa', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (462, 'Netanya', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (463, 'Haifa', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (464, 'Jerusalem', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (465, 'Tel Aviv', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (466, 'Tel Aviv', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (467, 'Netanya', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (468, 'Nazareth', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (469, 'Tel Aviv', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (470, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (471, 'Ashdod', 'pound');
insert into UNIT (unitid, unitlocation, unitname)
values (472, 'Tiberias', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (473, 'Tiberias', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (474, 'Nazareth', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (475, 'Haifa', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (476, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (477, 'Netanya', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (478, 'Beersheba', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (479, 'Beersheba', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (480, 'Haifa', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (481, 'Nazareth', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (482, 'Nazareth', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (483, 'Tiberias', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (484, 'Eilat', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (485, 'Nazareth', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (486, 'Tel Aviv', 'ounce');
insert into UNIT (unitid, unitlocation, unitname)
values (487, 'Tiberias', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (488, 'Jerusalem', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (489, 'Jerusalem', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (490, 'Beersheba', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (491, 'Netanya', 'inch');
insert into UNIT (unitid, unitlocation, unitname)
values (492, 'Tiberias', 'gallon');
insert into UNIT (unitid, unitlocation, unitname)
values (493, 'Tel Aviv', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (494, 'Tiberias', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (495, 'Eilat', 'kilogram');
insert into UNIT (unitid, unitlocation, unitname)
values (496, 'Ashdod', 'yard');
insert into UNIT (unitid, unitlocation, unitname)
values (497, 'Eilat', 'liter');
insert into UNIT (unitid, unitlocation, unitname)
values (498, 'Ashdod', 'gram');
insert into UNIT (unitid, unitlocation, unitname)
values (499, 'Jerusalem', 'ton');
insert into UNIT (unitid, unitlocation, unitname)
values (500, 'Jerusalem', 'pound');
commit;
prompt 500 records loaded
prompt Loading EXCELLENCE...
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 1905, 'T', 14);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 1964, 'T', 262);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 2024, 'T', 298);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 1978, 'F', 238);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 1973, 'F', 249);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 1916, 'T', 393);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 2038, 'F', 73);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 2057, 'F', 393);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 2047, 'F', 452);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 2046, 'F', 157);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 1941, 'F', 205);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 2070, 'T', 70);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 2065, 'T', 459);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 1992, 'T', 320);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 2009, 'F', 115);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 2069, 'F', 194);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 2020, 'T', 229);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 1927, 'T', 293);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 2051, 'F', 298);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Chief of Staff', 2010, 'T', 133);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 2088, 'T', 446);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 2077, 'F', 173);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Corps commander', 1937, 'T', 23);
insert into EXCELLENCE (excellencetype, excellenceyear, have_money, unitid)
values ('Prime Minister', 1970, 'F', 237);
commit;
prompt 24 records loaded
prompt Loading PROJECTS...
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (3, 'Mary Murphy', to_date('07-04-2018', 'dd-mm-yyyy'), to_date('15-08-2027', 'dd-mm-yyyy'), 'start', 7962807);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (5, 'Carl Hall', to_date('12-05-2019', 'dd-mm-yyyy'), to_date('04-07-2026', 'dd-mm-yyyy'), 'middle', 6521343.642);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (6, 'Amy Johnson', to_date('19-07-2023', 'dd-mm-yyyy'), to_date('03-06-2029', 'dd-mm-yyyy'), 'end', 3670333);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (7, 'Becky Dawson', to_date('28-06-2021', 'dd-mm-yyyy'), to_date('17-09-2028', 'dd-mm-yyyy'), 'end', 6716434);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (8, 'Susan Rodriguez', to_date('18-10-2022', 'dd-mm-yyyy'), to_date('23-12-2027', 'dd-mm-yyyy'), 'new', 381661);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (10, 'Marissa Schmidt', to_date('18-11-2014', 'dd-mm-yyyy'), to_date('03-12-2029', 'dd-mm-yyyy'), 'start', 7749274);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (11, 'Melissa Holland', to_date('20-05-2018', 'dd-mm-yyyy'), to_date('20-01-2025', 'dd-mm-yyyy'), 'end', 3735788);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (15, 'Andrea Chung', to_date('08-12-2018', 'dd-mm-yyyy'), to_date('29-09-2031', 'dd-mm-yyyy'), 'start', 8112202);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (17, 'Dylan Ross', to_date('11-10-2023', 'dd-mm-yyyy'), to_date('31-01-2033', 'dd-mm-yyyy'), 'new', 4533953);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (18, 'Anne Ward', to_date('05-10-2017', 'dd-mm-yyyy'), to_date('01-04-2027', 'dd-mm-yyyy'), 'start', 3830443);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (20, 'Melissa Blake', to_date('19-08-2019', 'dd-mm-yyyy'), to_date('16-09-2033', 'dd-mm-yyyy'), 'middle', 6163086.358);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (22, 'Angela Holmes', to_date('18-11-2019', 'dd-mm-yyyy'), to_date('27-03-2028', 'dd-mm-yyyy'), 'start', 7275529);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (23, 'Michael Estrada', to_date('05-01-2024', 'dd-mm-yyyy'), to_date('16-03-2031', 'dd-mm-yyyy'), 'middle', 6521318.353);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (26, 'John Williams', to_date('02-11-2017', 'dd-mm-yyyy'), to_date('08-06-2030', 'dd-mm-yyyy'), 'end', 5119954);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (27, 'Jacob Wright', to_date('24-11-2014', 'dd-mm-yyyy'), to_date('11-05-2029', 'dd-mm-yyyy'), 'new', 6269040);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (29, 'Karen Green', to_date('30-09-2015', 'dd-mm-yyyy'), to_date('08-06-2033', 'dd-mm-yyyy'), 'end', 4888798);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (30, 'Michelle Todd', to_date('18-07-2020', 'dd-mm-yyyy'), to_date('02-06-2027', 'dd-mm-yyyy'), 'end', 3866036);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (32, 'Devin Pham', to_date('14-07-2017', 'dd-mm-yyyy'), to_date('18-06-2032', 'dd-mm-yyyy'), 'middle', 3706283.966);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (34, 'Valerie Singleton', to_date('05-01-2019', 'dd-mm-yyyy'), to_date('24-03-2029', 'dd-mm-yyyy'), 'middle', 13280636.809);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (35, 'Hannah Jones', to_date('21-05-2016', 'dd-mm-yyyy'), to_date('09-07-2033', 'dd-mm-yyyy'), 'new', 7676762);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (37, 'Misty Jones', to_date('14-12-2014', 'dd-mm-yyyy'), to_date('11-02-2031', 'dd-mm-yyyy'), 'start', 8015907);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (39, 'Beth Cline', to_date('27-03-2017', 'dd-mm-yyyy'), to_date('12-10-2030', 'dd-mm-yyyy'), 'end', 6191196);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (43, 'Dustin Thomas', to_date('24-12-2017', 'dd-mm-yyyy'), to_date('13-11-2029', 'dd-mm-yyyy'), 'middle', 1953174.619);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (44, 'Caleb Jenkins', to_date('25-08-2021', 'dd-mm-yyyy'), to_date('30-03-2032', 'dd-mm-yyyy'), 'end', 4157409);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (47, 'Michael Burton', to_date('27-05-2019', 'dd-mm-yyyy'), to_date('11-12-2027', 'dd-mm-yyyy'), 'start', 3325899);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (49, 'Joshua Cowan', to_date('26-01-2022', 'dd-mm-yyyy'), to_date('02-03-2025', 'dd-mm-yyyy'), 'new', 2200949);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (50, 'Mr. Austin Williams', to_date('07-12-2015', 'dd-mm-yyyy'), to_date('30-03-2029', 'dd-mm-yyyy'), 'new', 2409744);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (52, 'William King', to_date('17-06-2018', 'dd-mm-yyyy'), to_date('25-07-2030', 'dd-mm-yyyy'), 'start', 2098430);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (54, 'Chad Thomas', to_date('02-11-2019', 'dd-mm-yyyy'), to_date('27-06-2033', 'dd-mm-yyyy'), 'middle', 12974798.298);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (55, 'James King', to_date('12-07-2016', 'dd-mm-yyyy'), to_date('06-07-2032', 'dd-mm-yyyy'), 'start', 301538);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (56, 'Scott Mendoza', to_date('09-04-2024', 'dd-mm-yyyy'), to_date('09-12-2028', 'dd-mm-yyyy'), 'middle', 10958341.284);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (57, 'Jessica Sutton', to_date('14-12-2021', 'dd-mm-yyyy'), to_date('16-02-2029', 'dd-mm-yyyy'), 'end', 6862982);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (59, 'Elizabeth Russell', to_date('01-03-2015', 'dd-mm-yyyy'), to_date('11-12-2028', 'dd-mm-yyyy'), 'middle', 7882721.055);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (60, 'Ryan Foster', to_date('28-01-2019', 'dd-mm-yyyy'), to_date('21-08-2031', 'dd-mm-yyyy'), 'new', 3348694);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (63, 'Anthony Dunn', to_date('01-06-2019', 'dd-mm-yyyy'), to_date('31-08-2026', 'dd-mm-yyyy'), 'start', 8360768);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (66, 'Melanie House', to_date('10-01-2015', 'dd-mm-yyyy'), to_date('05-02-2030', 'dd-mm-yyyy'), 'start', 3732435);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (68, 'Andrea Rice', to_date('15-06-2016', 'dd-mm-yyyy'), to_date('02-11-2029', 'dd-mm-yyyy'), 'middle', 9312081.955);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (69, 'Heidi Chan', to_date('08-01-2021', 'dd-mm-yyyy'), to_date('06-08-2029', 'dd-mm-yyyy'), 'new', 7221966);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (70, 'Kent Hughes', to_date('17-06-2020', 'dd-mm-yyyy'), to_date('13-08-2025', 'dd-mm-yyyy'), 'start', 3953459);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (71, 'Nicole Potter', to_date('23-12-2023', 'dd-mm-yyyy'), to_date('14-02-2029', 'dd-mm-yyyy'), 'new', 9557648);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (73, 'Vanessa Walton', to_date('11-08-2020', 'dd-mm-yyyy'), to_date('08-09-2027', 'dd-mm-yyyy'), 'start', 179773);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (74, 'Angel Gordon', to_date('20-12-2017', 'dd-mm-yyyy'), to_date('09-09-2029', 'dd-mm-yyyy'), 'middle', 7058006.835);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (77, 'Gabriella Brown', to_date('28-12-2021', 'dd-mm-yyyy'), to_date('12-08-2028', 'dd-mm-yyyy'), 'start', 2862556);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (78, 'Tammy Martinez', to_date('06-01-2018', 'dd-mm-yyyy'), to_date('22-06-2030', 'dd-mm-yyyy'), 'middle', 11525715.971);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (79, 'Christopher Perry', to_date('18-01-2022', 'dd-mm-yyyy'), to_date('21-01-2025', 'dd-mm-yyyy'), 'middle', 11211641.232);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (80, 'Maria Dyer', to_date('21-03-2015', 'dd-mm-yyyy'), to_date('09-02-2027', 'dd-mm-yyyy'), 'end', 2148163);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (84, 'Joshua Martin', to_date('11-11-2020', 'dd-mm-yyyy'), to_date('14-09-2033', 'dd-mm-yyyy'), 'start', 967555);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (85, 'Jacob Caldwell', to_date('27-11-2014', 'dd-mm-yyyy'), to_date('24-12-2025', 'dd-mm-yyyy'), 'middle', 5341404.156);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (89, 'Ashley Atkinson', to_date('21-04-2020', 'dd-mm-yyyy'), to_date('09-02-2030', 'dd-mm-yyyy'), 'new', 9441069);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (90, 'Kathryn Estrada', to_date('02-02-2018', 'dd-mm-yyyy'), to_date('04-06-2025', 'dd-mm-yyyy'), 'end', 8118911);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (92, 'David Williams', to_date('07-02-2023', 'dd-mm-yyyy'), to_date('14-09-2027', 'dd-mm-yyyy'), 'start', 6968703);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (93, 'Ann Byrd', to_date('25-03-2023', 'dd-mm-yyyy'), to_date('06-07-2033', 'dd-mm-yyyy'), 'start', 5850012);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (94, 'Michael Gonzales', to_date('26-09-2019', 'dd-mm-yyyy'), to_date('05-06-2032', 'dd-mm-yyyy'), 'end', 1231389);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (97, 'Shawn Hutchinson', to_date('29-09-2014', 'dd-mm-yyyy'), to_date('28-01-2031', 'dd-mm-yyyy'), 'end', 7389559);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (98, 'Heather Hill', to_date('23-09-2019', 'dd-mm-yyyy'), to_date('20-02-2027', 'dd-mm-yyyy'), 'end', 7039497);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (99, 'Jason Farmer', to_date('19-10-2017', 'dd-mm-yyyy'), to_date('13-01-2033', 'dd-mm-yyyy'), 'middle', 949048.254);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (100, 'Charlotte Conner', to_date('03-10-2015', 'dd-mm-yyyy'), to_date('19-02-2029', 'dd-mm-yyyy'), 'start', 487445);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (102, 'Jordan Adams', to_date('26-08-2017', 'dd-mm-yyyy'), to_date('17-01-2029', 'dd-mm-yyyy'), 'new', 5295450);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (107, 'Jake York', to_date('30-01-2022', 'dd-mm-yyyy'), to_date('03-02-2030', 'dd-mm-yyyy'), 'middle', 5332017.944);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (109, 'Kenneth Robinson', to_date('25-05-2020', 'dd-mm-yyyy'), to_date('11-09-2029', 'dd-mm-yyyy'), 'start', 8463211);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (110, 'John Young', to_date('20-08-2017', 'dd-mm-yyyy'), to_date('11-12-2030', 'dd-mm-yyyy'), 'end', 6064757);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (111, 'Randy Monroe', to_date('06-10-2018', 'dd-mm-yyyy'), to_date('25-09-2028', 'dd-mm-yyyy'), 'middle', 3513597.758);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (112, 'Edwin Hernandez', to_date('16-07-2014', 'dd-mm-yyyy'), to_date('13-10-2031', 'dd-mm-yyyy'), 'end', 4526676);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (116, 'Dana Hansen', to_date('04-02-2017', 'dd-mm-yyyy'), to_date('25-05-2028', 'dd-mm-yyyy'), 'new', 9339146);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (119, 'Stephen Casey', to_date('19-03-2024', 'dd-mm-yyyy'), to_date('30-07-2024', 'dd-mm-yyyy'), 'middle', 4927404.592);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (120, 'Donald Wagner', to_date('21-09-2023', 'dd-mm-yyyy'), to_date('03-01-2029', 'dd-mm-yyyy'), 'middle', 4388350.923);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (121, 'Michael Reeves', to_date('19-08-2014', 'dd-mm-yyyy'), to_date('18-01-2031', 'dd-mm-yyyy'), 'new', 4506498);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (126, 'Steven Brown', to_date('05-09-2019', 'dd-mm-yyyy'), to_date('22-11-2032', 'dd-mm-yyyy'), 'middle', 11675084.784);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (127, 'Hannah Galvan', to_date('27-11-2023', 'dd-mm-yyyy'), to_date('25-02-2032', 'dd-mm-yyyy'), 'start', 280087);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (128, 'Christopher Peters', to_date('09-11-2017', 'dd-mm-yyyy'), to_date('24-08-2024', 'dd-mm-yyyy'), 'end', 8881173);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (130, 'Olivia Roberts', to_date('27-10-2022', 'dd-mm-yyyy'), to_date('25-09-2031', 'dd-mm-yyyy'), 'new', 7518779);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (131, 'Sandra Zimmerman', to_date('27-06-2017', 'dd-mm-yyyy'), to_date('29-12-2031', 'dd-mm-yyyy'), 'new', 4447845);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (133, 'Logan Roy', to_date('24-05-2019', 'dd-mm-yyyy'), to_date('24-12-2032', 'dd-mm-yyyy'), 'start', 7996073);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (140, 'Christopher Vega', to_date('02-06-2020', 'dd-mm-yyyy'), to_date('20-10-2025', 'dd-mm-yyyy'), 'end', 4867618);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (144, 'Karen Bailey', to_date('28-07-2017', 'dd-mm-yyyy'), to_date('06-01-2028', 'dd-mm-yyyy'), 'start', 3542081);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (145, 'Jason Andersen', to_date('28-02-2023', 'dd-mm-yyyy'), to_date('22-12-2025', 'dd-mm-yyyy'), 'middle', 6755119.151);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (146, 'Elizabeth Spence', to_date('18-05-2022', 'dd-mm-yyyy'), to_date('05-08-2031', 'dd-mm-yyyy'), 'start', 9393654);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (147, 'Benjamin Brown', to_date('31-05-2014', 'dd-mm-yyyy'), to_date('08-05-2031', 'dd-mm-yyyy'), 'new', 4479114);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (148, 'Carl Mcintyre', to_date('15-04-2022', 'dd-mm-yyyy'), to_date('11-10-2030', 'dd-mm-yyyy'), 'new', 3073090);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (150, 'Christian Brown', to_date('16-04-2021', 'dd-mm-yyyy'), to_date('06-01-2031', 'dd-mm-yyyy'), 'new', 4779356);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (151, 'Angela Houston', to_date('10-01-2018', 'dd-mm-yyyy'), to_date('18-10-2027', 'dd-mm-yyyy'), 'middle', 4912497.392);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (152, 'Eric Ortiz', to_date('05-10-2019', 'dd-mm-yyyy'), to_date('06-06-2029', 'dd-mm-yyyy'), 'middle', 4975988.754);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (154, 'Denise Black', to_date('01-05-2024', 'dd-mm-yyyy'), to_date('02-10-2027', 'dd-mm-yyyy'), 'end', 7254506);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (155, 'Amber Alvarez', to_date('01-05-2022', 'dd-mm-yyyy'), to_date('16-08-2032', 'dd-mm-yyyy'), 'start', 7908537);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (156, 'Sheila Greene', to_date('17-05-2019', 'dd-mm-yyyy'), to_date('01-06-2033', 'dd-mm-yyyy'), 'end', 34573);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (157, 'Bonnie Brown MD', to_date('02-02-2022', 'dd-mm-yyyy'), to_date('30-06-2024', 'dd-mm-yyyy'), 'end', 6750096);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (159, 'Christopher Larsen', to_date('17-07-2018', 'dd-mm-yyyy'), to_date('13-02-2027', 'dd-mm-yyyy'), 'end', 8738729);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (160, 'Elizabeth Wilson', to_date('15-01-2024', 'dd-mm-yyyy'), to_date('03-05-2025', 'dd-mm-yyyy'), 'new', 7511117);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (161, 'Charles Klein', to_date('23-12-2022', 'dd-mm-yyyy'), to_date('25-08-2030', 'dd-mm-yyyy'), 'end', 3832492);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (163, 'Marcia Craig', to_date('18-07-2018', 'dd-mm-yyyy'), to_date('18-03-2028', 'dd-mm-yyyy'), 'middle', 4216890.172);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (164, 'Kayla Miller', to_date('05-06-2014', 'dd-mm-yyyy'), to_date('08-06-2024', 'dd-mm-yyyy'), 'middle', 5609194.701);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (165, 'Samuel Bailey', to_date('25-04-2020', 'dd-mm-yyyy'), to_date('18-05-2025', 'dd-mm-yyyy'), 'end', 3310815);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (166, 'Misty Villanueva', to_date('14-06-2016', 'dd-mm-yyyy'), to_date('26-11-2025', 'dd-mm-yyyy'), 'middle', 7815194.101);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (170, 'Stephanie Johnson', to_date('29-08-2015', 'dd-mm-yyyy'), to_date('14-11-2028', 'dd-mm-yyyy'), 'start', 8805362);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (176, 'Anthony Parker', to_date('03-05-2023', 'dd-mm-yyyy'), to_date('23-06-2024', 'dd-mm-yyyy'), 'end', 7839073);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (177, 'Alan Juarez', to_date('19-05-2024', 'dd-mm-yyyy'), to_date('19-08-2031', 'dd-mm-yyyy'), 'middle', 8455850.986);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (179, 'Patricia Saunders', to_date('08-07-2021', 'dd-mm-yyyy'), to_date('24-02-2028', 'dd-mm-yyyy'), 'end', 6245681);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (180, 'David Gutierrez', to_date('03-05-2019', 'dd-mm-yyyy'), to_date('30-11-2028', 'dd-mm-yyyy'), 'end', 8165865);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (181, 'Rodney Sullivan', to_date('31-03-2017', 'dd-mm-yyyy'), to_date('27-12-2026', 'dd-mm-yyyy'), 'middle', 13031347.164);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (182, 'Carolyn Hall', to_date('10-06-2019', 'dd-mm-yyyy'), to_date('24-02-2033', 'dd-mm-yyyy'), 'start', 8264861);
commit;
prompt 100 records committed...
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (183, 'Brandon Tran', to_date('07-04-2024', 'dd-mm-yyyy'), to_date('20-02-2031', 'dd-mm-yyyy'), 'start', 14951.2);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (185, 'Kelly Garcia', to_date('27-02-2018', 'dd-mm-yyyy'), to_date('08-07-2029', 'dd-mm-yyyy'), 'middle', 12547293.077);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (186, 'John Ramirez', to_date('23-07-2023', 'dd-mm-yyyy'), to_date('29-11-2028', 'dd-mm-yyyy'), 'middle', 2581016.636);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (191, 'Trevor Mcbride', to_date('01-11-2016', 'dd-mm-yyyy'), to_date('29-09-2028', 'dd-mm-yyyy'), 'end', 6319792);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (192, 'Kenneth Henry', to_date('24-11-2015', 'dd-mm-yyyy'), to_date('02-04-2028', 'dd-mm-yyyy'), 'start', 1014375);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (194, 'Anne Mitchell', to_date('24-10-2014', 'dd-mm-yyyy'), to_date('08-05-2028', 'dd-mm-yyyy'), 'start', 518560);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (195, 'Blake Brown', to_date('30-07-2016', 'dd-mm-yyyy'), to_date('18-01-2030', 'dd-mm-yyyy'), 'start', 7157526);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (196, 'Philip Spencer', to_date('12-07-2020', 'dd-mm-yyyy'), to_date('20-08-2026', 'dd-mm-yyyy'), 'start', 9825666);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (197, 'Joe Mcdaniel', to_date('01-03-2019', 'dd-mm-yyyy'), to_date('19-09-2032', 'dd-mm-yyyy'), 'middle', 4980486.203);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (200, 'Michael Lewis', to_date('11-01-2020', 'dd-mm-yyyy'), to_date('26-04-2033', 'dd-mm-yyyy'), 'start', 6765711);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (204, 'Amanda Edwards', to_date('23-03-2020', 'dd-mm-yyyy'), to_date('21-06-2026', 'dd-mm-yyyy'), 'middle', 9702171.435);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (206, 'Lisa Torres', to_date('24-03-2017', 'dd-mm-yyyy'), to_date('08-01-2030', 'dd-mm-yyyy'), 'start', 6052049);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (207, 'Todd Lewis', to_date('25-08-2020', 'dd-mm-yyyy'), to_date('07-06-2030', 'dd-mm-yyyy'), 'new', 820918);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (208, 'Chelsea Boyle', to_date('25-08-2015', 'dd-mm-yyyy'), to_date('16-04-2030', 'dd-mm-yyyy'), 'end', 5926302);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (209, 'Jose Martin', to_date('04-08-2017', 'dd-mm-yyyy'), to_date('25-06-2032', 'dd-mm-yyyy'), 'start', 6913394);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (210, 'Katherine Shaw', to_date('20-04-2017', 'dd-mm-yyyy'), to_date('07-08-2033', 'dd-mm-yyyy'), 'middle', 64659.98);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (220, 'Alexandra Stewart', to_date('29-07-2015', 'dd-mm-yyyy'), to_date('22-07-2024', 'dd-mm-yyyy'), 'end', 1156565);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (223, 'Nancy Miller', to_date('19-03-2023', 'dd-mm-yyyy'), to_date('25-10-2031', 'dd-mm-yyyy'), 'start', 1451291);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (224, 'Christopher Nichols', to_date('15-12-2017', 'dd-mm-yyyy'), to_date('17-06-2025', 'dd-mm-yyyy'), 'new', 1452211);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (225, 'Walter Ortega', to_date('10-12-2023', 'dd-mm-yyyy'), to_date('22-01-2034', 'dd-mm-yyyy'), 'end', 5962159);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (226, 'Aaron Walker', to_date('17-01-2016', 'dd-mm-yyyy'), to_date('31-08-2030', 'dd-mm-yyyy'), 'middle', 752868.171);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (227, 'Katherine Anderson', to_date('11-08-2019', 'dd-mm-yyyy'), to_date('28-03-2030', 'dd-mm-yyyy'), 'new', 4668142);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (228, 'Brandi Wright', to_date('09-12-2015', 'dd-mm-yyyy'), to_date('25-07-2025', 'dd-mm-yyyy'), 'start', 7542820);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (229, 'Michael Patrick', to_date('27-12-2022', 'dd-mm-yyyy'), to_date('05-06-2032', 'dd-mm-yyyy'), 'end', 6529897);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (231, 'Charles Mack', to_date('04-09-2018', 'dd-mm-yyyy'), to_date('19-01-2028', 'dd-mm-yyyy'), 'start', 1453155);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (232, 'Holly Miller', to_date('10-12-2015', 'dd-mm-yyyy'), to_date('26-04-2026', 'dd-mm-yyyy'), 'middle', 695607.22);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (233, 'Aaron Martinez', to_date('20-03-2017', 'dd-mm-yyyy'), to_date('14-10-2029', 'dd-mm-yyyy'), 'end', 5836943);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (234, 'Heather Herrera', to_date('31-03-2023', 'dd-mm-yyyy'), to_date('02-01-2032', 'dd-mm-yyyy'), 'new', 7168478);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (237, 'Daniel Rodriguez', to_date('11-09-2019', 'dd-mm-yyyy'), to_date('12-06-2029', 'dd-mm-yyyy'), 'middle', 2376980.991);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (248, 'Dr. Terrence Cline', to_date('23-08-2016', 'dd-mm-yyyy'), to_date('24-08-2024', 'dd-mm-yyyy'), 'middle', 3612854.421);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (249, 'Eric Reeves', to_date('08-04-2023', 'dd-mm-yyyy'), to_date('17-06-2030', 'dd-mm-yyyy'), 'end', 5994674);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (255, 'Jason Hood', to_date('26-10-2017', 'dd-mm-yyyy'), to_date('27-04-2032', 'dd-mm-yyyy'), 'end', 5440979);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (256, 'Douglas Pittman', to_date('17-08-2019', 'dd-mm-yyyy'), to_date('19-01-2025', 'dd-mm-yyyy'), 'start', 2942912);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (258, 'Alec Quinn', to_date('14-05-2018', 'dd-mm-yyyy'), to_date('10-06-2026', 'dd-mm-yyyy'), 'start', 7124758);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (259, 'Matthew Rodriguez', to_date('05-06-2022', 'dd-mm-yyyy'), to_date('01-10-2028', 'dd-mm-yyyy'), 'new', 2918728);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (262, 'Andrea Hensley', to_date('19-11-2020', 'dd-mm-yyyy'), to_date('12-06-2026', 'dd-mm-yyyy'), 'end', 4366430);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (264, 'Kevin Swanson', to_date('04-09-2022', 'dd-mm-yyyy'), to_date('08-03-2026', 'dd-mm-yyyy'), 'middle', 369971.415);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (266, 'Larry Davis', to_date('28-01-2015', 'dd-mm-yyyy'), to_date('15-10-2029', 'dd-mm-yyyy'), 'end', 4417526);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (267, 'Jose Burton', to_date('06-08-2020', 'dd-mm-yyyy'), to_date('31-12-2028', 'dd-mm-yyyy'), 'start', 4291137);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (268, 'Tamara Gonzalez', to_date('02-02-2018', 'dd-mm-yyyy'), to_date('13-02-2029', 'dd-mm-yyyy'), 'middle', 6936848.567);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (270, 'Christopher Walker', to_date('10-07-2023', 'dd-mm-yyyy'), to_date('20-04-2030', 'dd-mm-yyyy'), 'middle', 213721.332);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (271, 'Jaime Bowers', to_date('09-04-2021', 'dd-mm-yyyy'), to_date('14-12-2024', 'dd-mm-yyyy'), 'new', 4916972);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (272, 'Jennifer Harding', to_date('17-07-2018', 'dd-mm-yyyy'), to_date('14-06-2026', 'dd-mm-yyyy'), 'start', 4081771);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (274, 'James Cross', to_date('31-03-2021', 'dd-mm-yyyy'), to_date('10-03-2028', 'dd-mm-yyyy'), 'end', 2032037);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (276, 'Eric Thornton', to_date('31-03-2019', 'dd-mm-yyyy'), to_date('07-07-2031', 'dd-mm-yyyy'), 'middle', 10871056.966);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (278, 'Jason Collins', to_date('17-09-2017', 'dd-mm-yyyy'), to_date('12-09-2033', 'dd-mm-yyyy'), 'start', 6967187);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (280, 'Nichole Livingston', to_date('31-01-2017', 'dd-mm-yyyy'), to_date('11-04-2034', 'dd-mm-yyyy'), 'end', 1484262);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (281, 'Dylan Kennedy', to_date('24-11-2016', 'dd-mm-yyyy'), to_date('22-01-2032', 'dd-mm-yyyy'), 'end', 4634163);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (285, 'Pamela Dean', to_date('07-01-2022', 'dd-mm-yyyy'), to_date('02-12-2028', 'dd-mm-yyyy'), 'new', 4273397);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (289, 'Tonya Flores', to_date('28-03-2018', 'dd-mm-yyyy'), to_date('15-02-2030', 'dd-mm-yyyy'), 'end', 3725594);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (290, 'Joyce Lynch', to_date('31-05-2015', 'dd-mm-yyyy'), to_date('08-06-2028', 'dd-mm-yyyy'), 'start', 9689884);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (291, 'Richard Martinez', to_date('31-12-2015', 'dd-mm-yyyy'), to_date('21-06-2031', 'dd-mm-yyyy'), 'start', 2715536);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (292, 'Maria Orozco', to_date('27-02-2016', 'dd-mm-yyyy'), to_date('01-10-2031', 'dd-mm-yyyy'), 'end', 8324819);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (294, 'Brian Rodriguez', to_date('24-05-2018', 'dd-mm-yyyy'), to_date('14-04-2031', 'dd-mm-yyyy'), 'end', 683017);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (296, 'Reginald Clark', to_date('28-04-2024', 'dd-mm-yyyy'), to_date('15-09-2030', 'dd-mm-yyyy'), 'start', 832539.4);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (298, 'Michael Berg Jr.', to_date('04-11-2014', 'dd-mm-yyyy'), to_date('13-03-2034', 'dd-mm-yyyy'), 'end', 5168860);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (300, 'Joshua Montgomery', to_date('16-06-2020', 'dd-mm-yyyy'), to_date('03-09-2028', 'dd-mm-yyyy'), 'end', 3192332);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (301, 'Christopher Turner', to_date('12-06-2019', 'dd-mm-yyyy'), to_date('28-02-2030', 'dd-mm-yyyy'), 'new', 937522);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (307, 'Calvin Knapp', to_date('06-12-2016', 'dd-mm-yyyy'), to_date('08-08-2029', 'dd-mm-yyyy'), 'middle', 7137665.854);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (312, 'James Garcia', to_date('25-11-2018', 'dd-mm-yyyy'), to_date('27-03-2026', 'dd-mm-yyyy'), 'middle', 10111308.856);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (316, 'Paul Parker', to_date('07-02-2023', 'dd-mm-yyyy'), to_date('24-07-2030', 'dd-mm-yyyy'), 'start', 2262507);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (317, 'Elizabeth Davis', to_date('23-08-2019', 'dd-mm-yyyy'), to_date('24-06-2025', 'dd-mm-yyyy'), 'end', 5337009);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (318, 'Steve Martinez', to_date('10-10-2020', 'dd-mm-yyyy'), to_date('19-12-2028', 'dd-mm-yyyy'), 'middle', 5953559.007);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (319, 'Charles Riley', to_date('18-09-2022', 'dd-mm-yyyy'), to_date('11-05-2029', 'dd-mm-yyyy'), 'middle', 8891450.018);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (322, 'Javier Myers', to_date('20-06-2021', 'dd-mm-yyyy'), to_date('07-09-2032', 'dd-mm-yyyy'), 'middle', 12385482.076);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (323, 'Frank Hamilton', to_date('11-11-2019', 'dd-mm-yyyy'), to_date('01-12-2024', 'dd-mm-yyyy'), 'middle', 6940534.106);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (324, 'Eric Miller', to_date('17-06-2015', 'dd-mm-yyyy'), to_date('21-07-2030', 'dd-mm-yyyy'), 'middle', 10234197.424);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (326, 'Michael Chang', to_date('09-05-2015', 'dd-mm-yyyy'), to_date('13-12-2032', 'dd-mm-yyyy'), 'new', 6571441);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (328, 'Carl Patel', to_date('24-04-2024', 'dd-mm-yyyy'), to_date('21-01-2027', 'dd-mm-yyyy'), 'end', 7885275);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (329, 'Laura Hunter', to_date('27-05-2023', 'dd-mm-yyyy'), to_date('22-08-2032', 'dd-mm-yyyy'), 'new', 8028831);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (331, 'Amy Moore', to_date('14-12-2014', 'dd-mm-yyyy'), to_date('12-02-2030', 'dd-mm-yyyy'), 'new', 6470266);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (335, 'Elizabeth Moore', to_date('30-12-2014', 'dd-mm-yyyy'), to_date('28-07-2031', 'dd-mm-yyyy'), 'middle', 11548043.496);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (337, 'Dr. Kimberly Kramer', to_date('25-06-2022', 'dd-mm-yyyy'), to_date('19-01-2028', 'dd-mm-yyyy'), 'middle', 6178211.842);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (339, 'Philip Kelly', to_date('27-01-2017', 'dd-mm-yyyy'), to_date('11-08-2032', 'dd-mm-yyyy'), 'start', 5234999);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (340, 'David Cohen', to_date('15-08-2019', 'dd-mm-yyyy'), to_date('05-06-2028', 'dd-mm-yyyy'), 'new', 4002845);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (341, 'Dale Neal', to_date('15-05-2020', 'dd-mm-yyyy'), to_date('23-05-2033', 'dd-mm-yyyy'), 'start', 5256396);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (342, 'Laura Prince', to_date('14-06-2016', 'dd-mm-yyyy'), to_date('28-06-2029', 'dd-mm-yyyy'), 'end', 6181483);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (344, 'James Moreno', to_date('02-12-2022', 'dd-mm-yyyy'), to_date('30-01-2029', 'dd-mm-yyyy'), 'end', 4132148);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (347, 'Elizabeth Hayes', to_date('07-04-2016', 'dd-mm-yyyy'), to_date('25-05-2034', 'dd-mm-yyyy'), 'new', 2856106);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (348, 'Christopher Moreno', to_date('14-03-2019', 'dd-mm-yyyy'), to_date('04-09-2030', 'dd-mm-yyyy'), 'middle', 4297596.688);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (349, 'Diana Kim', to_date('31-05-2014', 'dd-mm-yyyy'), to_date('03-10-2032', 'dd-mm-yyyy'), 'new', 4061939);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (350, 'Leslie Carr', to_date('06-10-2016', 'dd-mm-yyyy'), to_date('15-08-2031', 'dd-mm-yyyy'), 'middle', 1510526.611);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (351, 'Charles Bell', to_date('17-02-2018', 'dd-mm-yyyy'), to_date('28-02-2027', 'dd-mm-yyyy'), 'middle', 7400960.281);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (353, 'Erika Hernandez MD', to_date('26-04-2023', 'dd-mm-yyyy'), to_date('22-08-2026', 'dd-mm-yyyy'), 'middle', 9839987.168);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (354, 'Susan Nolan', to_date('29-11-2017', 'dd-mm-yyyy'), to_date('13-09-2027', 'dd-mm-yyyy'), 'end', 2887400);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (357, 'Toni Hall', to_date('10-06-2018', 'dd-mm-yyyy'), to_date('02-11-2032', 'dd-mm-yyyy'), 'new', 5292257);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (358, 'Jason Dyer', to_date('14-10-2019', 'dd-mm-yyyy'), to_date('13-04-2028', 'dd-mm-yyyy'), 'start', 7360929);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (362, 'Regina Salazar', to_date('24-05-2020', 'dd-mm-yyyy'), to_date('18-02-2028', 'dd-mm-yyyy'), 'middle', 11655395.301);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (363, 'Howard Thompson', to_date('29-10-2023', 'dd-mm-yyyy'), to_date('09-12-2030', 'dd-mm-yyyy'), 'new', 3311656);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (364, 'Sarah Young', to_date('08-11-2020', 'dd-mm-yyyy'), to_date('28-06-2032', 'dd-mm-yyyy'), 'start', 3945185);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (366, 'Matthew Cruz', to_date('28-10-2015', 'dd-mm-yyyy'), to_date('05-02-2030', 'dd-mm-yyyy'), 'end', 1945429);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (370, 'Sara Atkinson', to_date('22-05-2024', 'dd-mm-yyyy'), to_date('24-10-2028', 'dd-mm-yyyy'), 'middle', 9148387.589);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (371, 'Thomas Hansen', to_date('12-02-2021', 'dd-mm-yyyy'), to_date('03-03-2025', 'dd-mm-yyyy'), 'start', 7446278);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (374, 'Leah Reed', to_date('29-12-2023', 'dd-mm-yyyy'), to_date('09-06-2031', 'dd-mm-yyyy'), 'end', 2935738);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (376, 'Linda Wilson', to_date('18-12-2015', 'dd-mm-yyyy'), to_date('23-10-2024', 'dd-mm-yyyy'), 'new', 9331430);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (377, 'Gregory Ellis', to_date('25-06-2018', 'dd-mm-yyyy'), to_date('29-05-2031', 'dd-mm-yyyy'), 'middle', 10003531.131);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (379, 'Richard Cooper', to_date('07-12-2017', 'dd-mm-yyyy'), to_date('18-08-2024', 'dd-mm-yyyy'), 'end', 8305489);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (384, 'Paul Perez', to_date('03-02-2024', 'dd-mm-yyyy'), to_date('03-01-2031', 'dd-mm-yyyy'), 'start', 106795.7);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (385, 'Michael Cook', to_date('17-12-2022', 'dd-mm-yyyy'), to_date('23-12-2028', 'dd-mm-yyyy'), 'middle', 1980043.516);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (387, 'Jessica Jones', to_date('22-05-2015', 'dd-mm-yyyy'), to_date('11-08-2031', 'dd-mm-yyyy'), 'end', 4969494);
commit;
prompt 200 records committed...
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (388, 'Ann Moore', to_date('11-02-2018', 'dd-mm-yyyy'), to_date('20-12-2025', 'dd-mm-yyyy'), 'middle', 1781341.188);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (391, 'Barbara Stephens', to_date('21-10-2018', 'dd-mm-yyyy'), to_date('23-04-2027', 'dd-mm-yyyy'), 'start', 6951341);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (394, 'William Allen', to_date('27-03-2024', 'dd-mm-yyyy'), to_date('01-03-2029', 'dd-mm-yyyy'), 'new', 8555532);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (395, 'Manuel Garcia', to_date('27-03-2022', 'dd-mm-yyyy'), to_date('10-08-2029', 'dd-mm-yyyy'), 'new', 3761308);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (396, 'Kayla Sullivan', to_date('27-04-2020', 'dd-mm-yyyy'), to_date('17-03-2026', 'dd-mm-yyyy'), 'start', 6252543);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (397, 'Meghan Gibbs', to_date('16-05-2021', 'dd-mm-yyyy'), to_date('02-12-2025', 'dd-mm-yyyy'), 'new', 4529062);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (398, 'Diana Scott', to_date('21-06-2014', 'dd-mm-yyyy'), to_date('03-08-2033', 'dd-mm-yyyy'), 'new', 909200);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (399, 'Raymond Farmer', to_date('23-11-2022', 'dd-mm-yyyy'), to_date('30-08-2033', 'dd-mm-yyyy'), 'end', 5606210);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (400, 'Nathaniel West', to_date('22-06-2014', 'dd-mm-yyyy'), to_date('20-05-2031', 'dd-mm-yyyy'), 'start', 8038705);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (402, 'Sandra Johnson', to_date('11-12-2016', 'dd-mm-yyyy'), to_date('05-10-2025', 'dd-mm-yyyy'), 'end', 5913225);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (403, 'Karen Reyes', to_date('12-08-2022', 'dd-mm-yyyy'), to_date('10-09-2031', 'dd-mm-yyyy'), 'new', 4206798);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (404, 'Spencer Everett', to_date('04-11-2014', 'dd-mm-yyyy'), to_date('24-11-2024', 'dd-mm-yyyy'), 'middle', 9029811.461);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (405, 'Jeffrey Oconnell', to_date('12-01-2022', 'dd-mm-yyyy'), to_date('05-04-2030', 'dd-mm-yyyy'), 'middle', 640172.401);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (407, 'Elizabeth Ramirez', to_date('09-05-2022', 'dd-mm-yyyy'), to_date('02-12-2029', 'dd-mm-yyyy'), 'new', 770014);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (408, 'Caitlin Braun', to_date('29-12-2020', 'dd-mm-yyyy'), to_date('17-03-2032', 'dd-mm-yyyy'), 'start', 6001645);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (409, 'Bryan Hart', to_date('08-10-2022', 'dd-mm-yyyy'), to_date('18-11-2028', 'dd-mm-yyyy'), 'end', 763434);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (410, 'Teresa Bryant', to_date('11-06-2018', 'dd-mm-yyyy'), to_date('14-12-2027', 'dd-mm-yyyy'), 'new', 796601);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (413, 'Keith Ali', to_date('08-09-2021', 'dd-mm-yyyy'), to_date('01-04-2033', 'dd-mm-yyyy'), 'new', 6693555);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (416, 'James Riley', to_date('18-07-2016', 'dd-mm-yyyy'), to_date('30-09-2033', 'dd-mm-yyyy'), 'middle', 5792287.061);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (417, 'Teresa Bryant', to_date('16-10-2015', 'dd-mm-yyyy'), to_date('27-01-2033', 'dd-mm-yyyy'), 'new', 9995493);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (418, 'Kimberly Williams', to_date('13-11-2020', 'dd-mm-yyyy'), to_date('28-08-2032', 'dd-mm-yyyy'), 'start', 5965137);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (419, 'Shelby Alvarez', to_date('21-11-2022', 'dd-mm-yyyy'), to_date('07-11-2029', 'dd-mm-yyyy'), 'middle', 10375232.846);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (420, 'Phillip Barker', to_date('04-01-2016', 'dd-mm-yyyy'), to_date('29-07-2029', 'dd-mm-yyyy'), 'end', 2696124);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (421, 'Eric Cooper', to_date('16-03-2015', 'dd-mm-yyyy'), to_date('12-10-2027', 'dd-mm-yyyy'), 'start', 2858240);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (424, 'Bobby Lewis', to_date('18-03-2017', 'dd-mm-yyyy'), to_date('19-04-2031', 'dd-mm-yyyy'), 'middle', 3247027.74);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (427, 'Rachel Salinas', to_date('30-06-2014', 'dd-mm-yyyy'), to_date('28-01-2030', 'dd-mm-yyyy'), 'middle', 10137484.302);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (429, 'Robert Jones', to_date('16-01-2015', 'dd-mm-yyyy'), to_date('04-06-2033', 'dd-mm-yyyy'), 'start', 1984478);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (431, 'Megan Robertson', to_date('14-02-2022', 'dd-mm-yyyy'), to_date('21-11-2029', 'dd-mm-yyyy'), 'start', 4350916);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (432, 'Kathy Simon', to_date('09-01-2016', 'dd-mm-yyyy'), to_date('13-05-2032', 'dd-mm-yyyy'), 'new', 6169009);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (433, 'Robert Cannon', to_date('05-09-2020', 'dd-mm-yyyy'), to_date('27-05-2033', 'dd-mm-yyyy'), 'new', 3262091);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (434, 'Thomas Mendez', to_date('17-08-2017', 'dd-mm-yyyy'), to_date('22-06-2033', 'dd-mm-yyyy'), 'start', 4295106);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (435, 'Ronald Scott', to_date('26-11-2023', 'dd-mm-yyyy'), to_date('21-07-2027', 'dd-mm-yyyy'), 'start', 2076701);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (436, 'David Thomas', to_date('14-02-2022', 'dd-mm-yyyy'), to_date('13-09-2025', 'dd-mm-yyyy'), 'end', 9261118);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (437, 'Hector Moody', to_date('03-10-2015', 'dd-mm-yyyy'), to_date('09-08-2032', 'dd-mm-yyyy'), 'end', 2139582);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (438, 'Gabrielle Murphy', to_date('19-06-2015', 'dd-mm-yyyy'), to_date('22-04-2033', 'dd-mm-yyyy'), 'middle', 11837477.432);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (439, 'Kevin Smith', to_date('18-01-2015', 'dd-mm-yyyy'), to_date('18-05-2026', 'dd-mm-yyyy'), 'end', 2035058);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (441, 'Heather Huber', to_date('25-08-2020', 'dd-mm-yyyy'), to_date('11-01-2034', 'dd-mm-yyyy'), 'start', 7023055);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (442, 'Susan Gonzalez', to_date('06-09-2022', 'dd-mm-yyyy'), to_date('25-07-2027', 'dd-mm-yyyy'), 'start', 7539091);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (443, 'Adam Lee', to_date('21-09-2015', 'dd-mm-yyyy'), to_date('10-12-2027', 'dd-mm-yyyy'), 'end', 2388958);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (444, 'Amanda Harris', to_date('28-12-2020', 'dd-mm-yyyy'), to_date('24-10-2032', 'dd-mm-yyyy'), 'end', 3934263);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (445, 'Karen Young', to_date('27-04-2015', 'dd-mm-yyyy'), to_date('11-03-2030', 'dd-mm-yyyy'), 'start', 7336467);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (446, 'David Smith', to_date('31-07-2021', 'dd-mm-yyyy'), to_date('05-09-2032', 'dd-mm-yyyy'), 'middle', 7178383.806);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (449, 'Kevin Blackwell', to_date('21-02-2016', 'dd-mm-yyyy'), to_date('24-05-2032', 'dd-mm-yyyy'), 'middle', 9422034.534);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (450, 'Linda Strong', to_date('18-08-2016', 'dd-mm-yyyy'), to_date('18-03-2028', 'dd-mm-yyyy'), 'start', 8903707);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (451, 'Kevin Erickson', to_date('05-08-2023', 'dd-mm-yyyy'), to_date('08-06-2031', 'dd-mm-yyyy'), 'new', 6491755);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (453, 'Sarah Garcia', to_date('11-05-2021', 'dd-mm-yyyy'), to_date('23-10-2030', 'dd-mm-yyyy'), 'new', 5342690);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (455, 'Daniel Thompson', to_date('26-08-2015', 'dd-mm-yyyy'), to_date('03-06-2033', 'dd-mm-yyyy'), 'middle', 3366594.132);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (457, 'Paula Webster', to_date('19-04-2023', 'dd-mm-yyyy'), to_date('27-07-2029', 'dd-mm-yyyy'), 'middle', 8829603.772);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (458, 'Charles Ramirez', to_date('03-12-2015', 'dd-mm-yyyy'), to_date('25-11-2031', 'dd-mm-yyyy'), 'start', 6052955);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (459, 'Bruce Lam', to_date('04-08-2017', 'dd-mm-yyyy'), to_date('20-08-2027', 'dd-mm-yyyy'), 'new', 5580048);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (461, 'Andrea Lawson', to_date('01-06-2015', 'dd-mm-yyyy'), to_date('19-10-2026', 'dd-mm-yyyy'), 'middle', 685313.266);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (462, 'Jon Jordan', to_date('03-02-2016', 'dd-mm-yyyy'), to_date('06-09-2030', 'dd-mm-yyyy'), 'new', 5164141);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (464, 'Gregory Hughes', to_date('24-06-2023', 'dd-mm-yyyy'), to_date('01-11-2032', 'dd-mm-yyyy'), 'middle', 9367269.208);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (465, 'Amanda Baker', to_date('06-11-2019', 'dd-mm-yyyy'), to_date('17-11-2031', 'dd-mm-yyyy'), 'start', 4472942);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (467, 'Linda Patel', to_date('02-04-2016', 'dd-mm-yyyy'), to_date('07-03-2034', 'dd-mm-yyyy'), 'new', 4036368);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (468, 'Brenda Stewart', to_date('11-09-2021', 'dd-mm-yyyy'), to_date('02-12-2030', 'dd-mm-yyyy'), 'end', 9550320);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (469, 'Joseph Brown', to_date('26-10-2022', 'dd-mm-yyyy'), to_date('15-04-2034', 'dd-mm-yyyy'), 'middle', 11298136.267);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (472, 'Timothy Cortez', to_date('10-12-2016', 'dd-mm-yyyy'), to_date('29-12-2032', 'dd-mm-yyyy'), 'middle', 10726876.391);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (475, 'Rachel Burton', to_date('05-02-2016', 'dd-mm-yyyy'), to_date('11-05-2034', 'dd-mm-yyyy'), 'middle', 5818290.808);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (477, 'Jennifer Jenkins', to_date('29-10-2023', 'dd-mm-yyyy'), to_date('24-01-2025', 'dd-mm-yyyy'), 'start', 3836552);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (479, 'Julian Johnson', to_date('06-11-2023', 'dd-mm-yyyy'), to_date('14-05-2028', 'dd-mm-yyyy'), 'start', 5088846);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (481, 'Kevin Knight', to_date('04-06-2022', 'dd-mm-yyyy'), to_date('19-04-2030', 'dd-mm-yyyy'), 'end', 4580369);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (491, 'Megan Durham', to_date('24-01-2023', 'dd-mm-yyyy'), to_date('12-02-2031', 'dd-mm-yyyy'), 'middle', 1551462.847);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (492, 'David Woods', to_date('22-10-2018', 'dd-mm-yyyy'), to_date('01-10-2032', 'dd-mm-yyyy'), 'start', 6821068);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (499, 'Kathryn Welch', to_date('19-12-2018', 'dd-mm-yyyy'), to_date('10-04-2034', 'dd-mm-yyyy'), 'middle', 4197167.414);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (1000, 'Project A', to_date('01-01-2023', 'dd-mm-yyyy'), to_date('31-12-2023', 'dd-mm-yyyy'), 'new', 50000);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (1001, 'projectA', to_date('27-06-2024 15:03:19', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-12-2025 15:03:19', 'dd-mm-yyyy hh24:mi:ss'), 'new', 0);
insert into PROJECTS (projectid, projectname, begindate, enddate, status, budget)
values (1002, 'projectA', to_date('27-06-2024 15:03:28', 'dd-mm-yyyy hh24:mi:ss'), to_date('27-12-2025 15:03:28', 'dd-mm-yyyy hh24:mi:ss'), 'new', 0);
commit;
prompt 268 records loaded
prompt Loading INPROJECT...
insert into INPROJECT (projectid, personid)
values (3, 210499951);
insert into INPROJECT (projectid, personid)
values (3, 314868697);
insert into INPROJECT (projectid, personid)
values (50, 280167432);
insert into INPROJECT (projectid, personid)
values (50, 338922388);
insert into INPROJECT (projectid, personid)
values (98, 397289299);
insert into INPROJECT (projectid, personid)
values (157, 350007970);
insert into INPROJECT (projectid, personid)
values (192, 210499951);
insert into INPROJECT (projectid, personid)
values (192, 221610570);
insert into INPROJECT (projectid, personid)
values (192, 397289299);
insert into INPROJECT (projectid, personid)
values (229, 221610570);
insert into INPROJECT (projectid, personid)
values (229, 314868697);
insert into INPROJECT (projectid, personid)
values (229, 329347769);
insert into INPROJECT (projectid, personid)
values (229, 397289299);
insert into INPROJECT (projectid, personid)
values (231, 221610570);
insert into INPROJECT (projectid, personid)
values (231, 314868697);
insert into INPROJECT (projectid, personid)
values (231, 340778495);
insert into INPROJECT (projectid, personid)
values (270, 299220674);
insert into INPROJECT (projectid, personid)
values (274, 221610570);
insert into INPROJECT (projectid, personid)
values (274, 230662764);
insert into INPROJECT (projectid, personid)
values (274, 286164536);
insert into INPROJECT (projectid, personid)
values (274, 308731807);
insert into INPROJECT (projectid, personid)
values (274, 397289299);
insert into INPROJECT (projectid, personid)
values (280, 367961125);
insert into INPROJECT (projectid, personid)
values (285, 254918738);
insert into INPROJECT (projectid, personid)
values (326, 300141857);
insert into INPROJECT (projectid, personid)
values (344, 308731807);
insert into INPROJECT (projectid, personid)
values (391, 210499951);
insert into INPROJECT (projectid, personid)
values (391, 308731807);
insert into INPROJECT (projectid, personid)
values (391, 397289299);
insert into INPROJECT (projectid, personid)
values (403, 249336919);
insert into INPROJECT (projectid, personid)
values (1001, 200457145);
insert into INPROJECT (projectid, personid)
values (1001, 209974888);
insert into INPROJECT (projectid, personid)
values (1001, 217392173);
insert into INPROJECT (projectid, personid)
values (1001, 221118046);
insert into INPROJECT (projectid, personid)
values (1001, 221267362);
insert into INPROJECT (projectid, personid)
values (1001, 226278361);
insert into INPROJECT (projectid, personid)
values (1001, 237720837);
insert into INPROJECT (projectid, personid)
values (1001, 251632815);
insert into INPROJECT (projectid, personid)
values (1001, 263070907);
insert into INPROJECT (projectid, personid)
values (1001, 286716258);
insert into INPROJECT (projectid, personid)
values (1001, 297527400);
insert into INPROJECT (projectid, personid)
values (1001, 318833257);
insert into INPROJECT (projectid, personid)
values (1001, 332709488);
insert into INPROJECT (projectid, personid)
values (1001, 349396203);
insert into INPROJECT (projectid, personid)
values (1001, 349458165);
insert into INPROJECT (projectid, personid)
values (1001, 352567354);
insert into INPROJECT (projectid, personid)
values (1001, 360927762);
insert into INPROJECT (projectid, personid)
values (1001, 379975164);
insert into INPROJECT (projectid, personid)
values (1002, 203679333);
insert into INPROJECT (projectid, personid)
values (1002, 210514704);
insert into INPROJECT (projectid, personid)
values (1002, 221768748);
insert into INPROJECT (projectid, personid)
values (1002, 245511965);
insert into INPROJECT (projectid, personid)
values (1002, 263525307);
insert into INPROJECT (projectid, personid)
values (1002, 265361023);
insert into INPROJECT (projectid, personid)
values (1002, 273294384);
insert into INPROJECT (projectid, personid)
values (1002, 283286843);
insert into INPROJECT (projectid, personid)
values (1002, 298526665);
insert into INPROJECT (projectid, personid)
values (1002, 300500308);
insert into INPROJECT (projectid, personid)
values (1002, 301878407);
insert into INPROJECT (projectid, personid)
values (1002, 343032790);
insert into INPROJECT (projectid, personid)
values (1002, 352235228);
insert into INPROJECT (projectid, personid)
values (1002, 361008568);
insert into INPROJECT (projectid, personid)
values (1002, 365608271);
insert into INPROJECT (projectid, personid)
values (1002, 368511515);
insert into INPROJECT (projectid, personid)
values (1002, 393401801);
insert into INPROJECT (projectid, personid)
values (1002, 395655396);
commit;
prompt 66 records loaded
prompt Loading PERSON...
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (323178622, 'PatriciaDupree', 'Soldier', 'corporal', 218);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (217532247, 'GordieStamp', 'Soldier', 'major', 427);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (321775301, 'GinFogerty', 'Commander', 'general', 352);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (215685909, 'TerenceGoldwyn', 'Commander', 'sergeant', 277);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (244915083, 'FairuzaShocked', 'Cleaner', 'sergeant', 75);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (314824195, 'JulianneParish', 'Soldier', 'corporal', 348);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (330826545, 'JackieBlossoms', 'Commander', 'sergeant', 40);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (215856004, 'RobNash', 'Soldier', 'major general', 220);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (382135584, 'AustinMcConaughey', 'Commander', 'captain', 233);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (233051595, 'JeffBachman', 'Commander', 'general', 41);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (208634382, 'LupeWariner', 'Commander', 'sergeant', 265);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (377404400, 'PatDillon', 'Secretary', 'sergeant', 321);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (230662764, 'RalphHaslam', 'Cleaner', 'major', 62);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (265188157, 'GladysTurturro', 'Secretary', 'major general', 68);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (359247349, 'AndrewSoda', 'Soldier', 'sergeant', 242);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (367334346, 'DrewDillane', 'Soldier', 'major general', 77);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (393623530, 'RogerSpiner', 'Secretary', 'general', 31);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (365254951, 'JudiMcFerrin', 'Assistant', 'general', 329);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (226765254, 'ToniFrancis', 'Cleaner', 'general', 246);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (228735519, 'SineadGellar', 'Commander', 'general', 63);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (399547623, 'RipTomlin', 'Cleaner', 'sergeant', 474);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (281523540, 'KelliDarren', 'Assistant', 'sergeant', 212);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (394167300, 'AngieTate', 'Secretary', 'major general', 200);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (370237144, 'RickLynn', 'Cleaner', 'captain', 40);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (307445738, 'MerrillHawn', 'Cleaner', 'captain', 266);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (302219097, 'ChristianBloch', 'Cleaner', 'sergeant', 400);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (394640208, 'TanyaLavigne', 'Cleaner', 'sergeant', 181);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (367961125, 'WesIsaak', 'Cleaner', 'captain', 211);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (224387654, 'LarryRuiz', 'Assistant', 'sergeant', 397);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (213723535, 'ColeGill', 'Soldier', 'sergeant', 329);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (235406345, 'AdamWhitford', 'Soldier', 'general', 325);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (379975164, 'KazemWomack', 'Soldier', 'sergeant', 138);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (335580356, 'NatalieWeston', 'Soldier', 'major general', 462);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (271278628, 'MadeleineHutton', 'Assistant', 'corporal', 312);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (234051846, 'MartinLeoni', 'Assistant', 'captain', 144);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (373245891, 'DelroyStampley', 'Soldier', 'sergeant', 310);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (246946162, 'SherylAndrews', 'Cleaner', 'captain', 51);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (382189141, 'GailardSuvari', 'Soldier', 'captain', 308);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (367354742, 'MaggieHeron', 'Assistant', 'major', 238);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (363091985, 'RadneyHoskins', 'Cleaner', 'major general', 375);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (240200846, 'RosannaCarlton', 'Cleaner', 'captain', 46);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (301525951, 'WillShort', 'Cleaner', 'major general', 357);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (332613083, 'ShannynMcCabe', 'Secretary', 'major', 431);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (265137302, 'RoryCreek', 'Soldier', 'sergeant', 21);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (240431765, 'Jean-LucLoggia', 'Secretary', 'major', 325);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (240329172, 'DavyBalin', 'Commander', 'sergeant', 164);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (321473063, 'OlympiaHoffman', 'Secretary', 'general', 295);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (359763999, 'RandyTorino', 'Assistant', 'captain', 14);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (296175983, 'PaulLewis', 'Assistant', 'major general', 375);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (286311285, 'BrittanyKilmer', 'Secretary', 'captain', 343);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (306257147, 'BretKing', 'Assistant', 'major', 92);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (369065658, 'MacChestnut', 'Cleaner', 'major general', 399);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (371998395, 'PenelopeLee', 'Assistant', 'captain', 304);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (237060255, 'AnthonyKahn', 'Commander', 'sergeant', 317);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (238792192, 'JimmyHewett', 'Cleaner', 'sergeant', 119);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (346300410, 'CathyLeto', 'Soldier', 'major', 351);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (253569853, 'AndreaCoolidge', 'Secretary', 'major', 270);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (245742662, 'TarynHenriksen', 'Assistant', 'general', 371);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (361737577, 'LizzyShatner', 'Commander', 'captain', 459);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (377844067, 'LucyGriggs', 'Secretary', 'captain', 181);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (365245294, 'DeborahPantoliano', 'Secretary', 'sergeant', 303);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (279306827, 'JenaBall', 'Secretary', 'general', 370);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (232413325, 'DabneyFishburne', 'Secretary', 'captain', 135);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (297643235, 'JeffreyCattrall', 'Secretary', 'major general', 5);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (300141857, 'DavidSteenburgen', 'Cleaner', 'general', 46);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (389185929, 'BillyFoxx', 'Assistant', 'major', 119);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (259128227, 'HectorHoly', 'Soldier', 'major general', 178);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (214168452, 'LievCrystal', 'Commander', 'sergeant', 61);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (262717017, 'DwightNelson', 'Soldier', 'general', 395);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (394501139, 'AmyRaye', 'Commander', 'major general', 396);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (350007970, 'PattiSnider', 'Commander', 'sergeant', 95);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (249867303, 'ReginaFrakes', 'Secretary', 'corporal', 192);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (223846705, 'RonnieGill', 'Secretary', 'major general', 45);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (377764741, 'MarianneHawkins', 'Cleaner', 'sergeant', 124);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (274323260, 'JudgeLiu', 'Commander', 'captain', 244);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (293117550, 'MaceoMcDiarmid', 'Cleaner', 'sergeant', 475);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (388403434, 'ElvisConnery', 'Soldier', 'general', 447);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (393083256, 'AndraeHerndon', 'Secretary', 'general', 216);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (336317949, 'EddieTippe', 'Commander', 'captain', 116);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (362680255, 'GrantBates', 'Secretary', 'corporal', 12);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (375334423, 'Jean-LucRain', 'Assistant', 'captain', 166);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (386860568, 'GeraldineBoothe', 'Commander', 'captain', 62);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (361537156, 'RonnieCumming', 'Secretary', 'major general', 27);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (384652907, 'MiaRuffalo', 'Secretary', 'captain', 379);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (310239725, 'RobertaMalone', 'Soldier', 'sergeant', 149);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (331001052, 'RickyLynch', 'Soldier', 'major', 181);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (395655396, 'JoaquinSaucedo', 'Commander', 'sergeant', 207);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (381922545, 'AndreMcGowan', 'Secretary', 'sergeant', 226);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (230450347, 'ReneeSample', 'Commander', 'major general', 396);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (368612693, 'KelliVassar', 'Cleaner', 'sergeant', 28);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (315804703, 'GeraldineMitra', 'Assistant', 'corporal', 307);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (276118885, 'BrianDonovan', 'Assistant', 'captain', 35);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (202606382, 'LanceStatham', 'Assistant', 'general', 42);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (372210217, 'HelenCraddock', 'Cleaner', 'general', 452);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (354402757, 'LeslieMirren', 'Soldier', 'sergeant', 301);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (302067441, 'SaraFerrell', 'Commander', 'major general', 38);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (352735127, 'RicardoDillon', 'Secretary', 'general', 341);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (314418211, 'HarrisonHeron', 'Commander', 'sergeant', 319);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (335481005, 'BillyGayle', 'Soldier', 'sergeant', 303);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (234742655, 'GeorgeHolmes', 'Assistant', 'major', 288);
commit;
prompt 100 records committed...
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (208829212, 'HeathFariq', 'Cleaner', 'general', 55);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (251174252, 'BrentPaul', 'Cleaner', 'major', 283);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (223512790, 'JasonLange', 'Commander', 'major', 287);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (228721020, 'MillieHarrison', 'Assistant', 'sergeant', 381);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (355924724, 'MartinBriscoe', 'Assistant', 'general', 258);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (317432028, 'NicolasOrlando', 'Commander', 'sergeant', 218);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (384741476, 'DennyOntiveros', 'Commander', 'major', 207);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (270134204, 'FionaLillard', 'Secretary', 'major', 348);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (203679333, 'KirkKeen', 'Secretary', 'major general', 34);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (335364469, 'BobLachey', 'Commander', 'major', 302);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (361008568, 'LoreenaWinger', 'Soldier', 'sergeant', 39);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (241122176, 'MikiSalt', 'Soldier', 'general', 189);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (266450413, 'RandyTurturro', 'Soldier', 'sergeant', 89);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (235066865, 'HopeHutton', 'Cleaner', 'sergeant', 267);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (356081844, 'ClintWarburton', 'Cleaner', 'sergeant', 211);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (396786329, 'ArtHenstridge', 'Cleaner', 'sergeant', 73);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (355873175, 'KittyRicci', 'Assistant', 'corporal', 269);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (287759995, 'SineadApple', 'Assistant', 'sergeant', 291);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (234483474, 'FatsFender', 'Secretary', 'major general', 453);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (254642611, 'TerryWilson', 'Assistant', 'general', 188);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (285938782, 'BretCumming', 'Cleaner', 'sergeant', 484);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (351493253, 'ZooeyReubens', 'Soldier', 'major general', 58);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (232818149, 'LonnieSuchet', 'Commander', 'general', 43);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (296574641, 'GordGagnon', 'Commander', 'corporal', 250);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (290572481, 'GilMcKellen', 'Commander', 'sergeant', 33);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (329347769, 'TonyHingle', 'Cleaner', 'major', 468);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (383601203, 'MekhiPaquin', 'Commander', 'captain', 470);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (283286843, 'AdamPortman', 'Assistant', 'sergeant', 170);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (353711728, 'ThomasNorton', 'Soldier', 'captain', 343);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (240139537, 'FrancesSizemore', 'Assistant', 'sergeant', 6);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (251586743, 'JeffreySharp', 'Secretary', 'sergeant', 493);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (381257563, 'CubaRydell', 'Secretary', 'corporal', 373);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (251884308, 'HoraceRowlands', 'Cleaner', 'sergeant', 108);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (301622541, 'EdwardHawn', 'Secretary', 'corporal', 268);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (382595766, 'LariPerry', 'Commander', 'major general', 114);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (302192200, 'Judevon Sydow', 'Cleaner', 'sergeant', 278);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (309286465, 'AshtonKleinenberg', 'Assistant', 'sergeant', 339);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (226191875, 'TalvinStiers', 'Assistant', 'sergeant', 138);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (264844292, 'CateByrne', 'Assistant', 'sergeant', 451);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (254976329, 'HerbieGlover', 'Assistant', 'sergeant', 429);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (265361023, 'MikeRossellini', 'Assistant', 'corporal', 316);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (329086875, 'TobeyBell', 'Assistant', 'sergeant', 126);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (202771483, 'SheenaLunch', 'Secretary', 'sergeant', 21);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (310128824, 'LanceLightfoot', 'Secretary', 'captain', 288);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (254875516, 'StevenRed', 'Commander', 'corporal', 451);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (249094237, 'OlympiaSawa', 'Commander', 'major general', 365);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (303367773, 'KevnHarry', 'Soldier', 'corporal', 431);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (376754988, 'BrentHingle', 'Secretary', 'sergeant', 177);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (300500308, 'NellyBenoit', 'Soldier', 'captain', 53);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (281751147, 'MauraPastore', 'Soldier', 'sergeant', 256);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (375002988, 'JohnGoldberg', 'Secretary', 'major general', 469);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (391999670, 'JulianneBroza', 'Assistant', 'major general', 386);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (317886719, 'JannNoseworthy', 'Secretary', 'sergeant', 500);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (325048404, 'MattCrow', 'Cleaner', 'captain', 274);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (338754476, 'VerucaStamp', 'Secretary', 'corporal', 107);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (323000399, 'JimmieBelle', 'Cleaner', 'general', 427);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (233245154, 'ParkerHenstridge', 'Secretary', 'major', 320);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (237633545, 'ElisabethManning', 'Commander', 'major', 432);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (352235228, 'DerekLipnicki', 'Cleaner', 'corporal', 410);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (381340504, 'HikaruTorino', 'Cleaner', 'sergeant', 453);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (213423223, 'HarrietStuart', 'Soldier', 'captain', 175);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (209513971, 'VerucaArmstrong', 'Secretary', 'major general', 399);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (245922004, 'IsaacPeebles', 'Cleaner', 'major', 345);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (250002237, 'ArnoldSpader', 'Cleaner', 'sergeant', 326);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (208483869, 'OmarCraddock', 'Secretary', 'major general', 252);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (345260070, 'KevnRudd', 'Assistant', 'sergeant', 272);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (271983460, 'CubaBalaban', 'Secretary', 'major general', 4);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (322819904, 'LarryMakeba', 'Secretary', 'captain', 346);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (206783490, 'CrispinStallone', 'Soldier', 'major general', 63);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (259708345, 'BrendaJoli', 'Cleaner', 'major general', 10);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (365608271, 'JoeDonelly', 'Soldier', 'sergeant', 229);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (356432986, 'LisaOrton', 'Commander', 'general', 135);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (202550069, 'HumbertoRhymes', 'Secretary', 'major', 150);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (286164536, 'GrantBlige', 'Assistant', 'corporal', 17);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (318833257, 'LariRauhofer', 'Secretary', 'major general', 144);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (334739263, 'CarleneStarr', 'Soldier', 'captain', 176);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (275961294, 'ChuckCarr', 'Secretary', 'major general', 188);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (297106747, 'AndrePlimpton', 'Soldier', 'general', 389);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (266871506, 'JaniceJay', 'Secretary', 'major', 96);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (345847944, 'FranzKing', 'Cleaner', 'major general', 12);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (385722686, 'GlennOlin', 'Soldier', 'captain', 13);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (337388569, 'NancyMcGregor', 'Commander', 'major general', 311);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (286940502, 'NickPatillo', 'Commander', 'corporal', 495);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (271532785, 'NanciO''Neal', 'Secretary', 'corporal', 94);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (274145722, 'JimmyMitra', 'Soldier', 'sergeant', 35);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (269942208, 'ThomasSpacek', 'Secretary', 'corporal', 114);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (309590248, 'HalleBedelia', 'Soldier', 'sergeant', 68);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (289185221, 'PamelaColon', 'Secretary', 'sergeant', 295);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (284725963, 'BenAustin', 'Assistant', 'major', 71);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (233981607, 'RodneyRicci', 'Assistant', 'major general', 487);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (342531392, 'IsabellaHurley', 'Secretary', 'general', 18);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (386267486, 'RachelMoraz', 'Commander', 'captain', 69);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (292221174, 'ChantÃ©Whitaker', 'Assistant', 'general', 82);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (315705573, 'MikoMcGriff', 'Assistant', 'captain', 342);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (206963350, 'DannyZevon', 'Secretary', 'corporal', 82);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (287265741, 'BarryHead', 'Commander', 'major general', 279);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (345229456, 'AmySobieski', 'Cleaner', 'captain', 312);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (231500901, 'BonnieBalk', 'Commander', 'sergeant', 343);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (386402435, 'RadeGraham', 'Soldier', 'captain', 7);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (393143196, 'JacksonBates', 'Secretary', 'sergeant', 170);
commit;
prompt 200 records committed...
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (221267362, 'GoldieSisto', 'Cleaner', 'general', 336);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (223645500, 'JeanCarradine', 'Commander', 'corporal', 84);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (388009977, 'PattiPayton', 'Cleaner', 'major', 420);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (333293238, 'SammyGallagher', 'Assistant', 'general', 3);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (294348032, 'PabloFarina', 'Cleaner', 'major', 16);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (368511515, 'Jean-ClaudeSalt', 'Cleaner', 'captain', 427);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (216420452, 'EthanWinwood', 'Assistant', 'sergeant', 116);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (329992555, 'RhettPhifer', 'Assistant', 'corporal', 346);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (315059310, 'DonDiddley', 'Secretary', 'captain', 359);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (297268457, 'ElisabethUtada', 'Secretary', 'general', 493);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (360069606, 'OzzyGallagher', 'Assistant', 'major', 242);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (375354261, 'JoseLavigne', 'Commander', 'major general', 24);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (303141872, 'ReneAniston', 'Secretary', 'major', 286);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (329086324, 'SuziBegley', 'Commander', 'captain', 316);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (290022578, 'AdrienDupree', 'Commander', 'major', 394);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (220781019, 'NaomiMellencamp', 'Commander', 'captain', 212);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (352567354, 'CatherineShearer', 'Secretary', 'corporal', 303);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (216838728, 'MerilleeLynn', 'Secretary', 'sergeant', 142);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (271302028, 'VickieCurtis', 'Soldier', 'general', 117);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (378918169, 'RichieNicholas', 'Cleaner', 'sergeant', 204);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (349116470, 'UmaLangella', 'Assistant', 'corporal', 79);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (305306018, 'DennyGuilfoyle', 'Cleaner', 'sergeant', 398);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (286716258, 'JohnetteUnger', 'Assistant', 'sergeant', 313);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (338106853, 'CarolynSteiger', 'Assistant', 'general', 323);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (200457145, 'KathleenCurry', 'Secretary', 'corporal', 437);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (301878407, 'WillieJordan', 'Soldier', 'captain', 304);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (273187344, 'FairuzaBell', 'Cleaner', 'sergeant', 53);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (389337136, 'MelbaJohnson', 'Soldier', 'captain', 492);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (378722632, 'DebraGagnon', 'Secretary', 'general', 238);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (259759097, 'JohnMcDowall', 'Secretary', 'sergeant', 153);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (270579252, 'SethReilly', 'Secretary', 'sergeant', 300);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (265701137, 'TayeKrabbe', 'Secretary', 'corporal', 462);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (375589643, 'BrothersElizabeth', 'Commander', 'major general', 184);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (373667401, 'FamkeSpiner', 'Secretary', 'captain', 237);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (283025971, 'PeaboFlatts', 'Secretary', 'general', 30);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (394346147, 'IvanHorizon', 'Cleaner', 'major general', 198);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (269856474, 'SonnyLeguizamo', 'Soldier', 'captain', 21);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (388041874, 'Jean-LucPerrineau', 'Commander', 'captain', 436);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (252759631, 'AnnTwilley', 'Soldier', 'general', 270);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (360927762, 'ChristianClose', 'Assistant', 'sergeant', 417);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (207521125, 'AlanaLattimore', 'Cleaner', 'general', 147);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (217743430, 'MerylKelly', 'Commander', 'captain', 462);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (346438635, 'KirstenJohansen', 'Secretary', 'major general', 31);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (386563000, 'MartinO''Keefe', 'Assistant', 'captain', 283);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (394359429, 'KyleSewell', 'Secretary', 'corporal', 134);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (381258476, 'HankMifune', 'Assistant', 'corporal', 255);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (353975778, 'ManuFirth', 'Commander', 'corporal', 156);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (217283433, 'TonyByrne', 'Secretary', 'major general', 263);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (201003176, 'MilesDuschel', 'Commander', 'general', 144);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (246402027, 'RodneyGracie', 'Secretary', 'captain', 45);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (399866376, 'CateFuray', 'Secretary', 'sergeant', 71);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (225988306, 'JuanPhoenix', 'Assistant', 'major general', 133);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (380518239, 'DennisBlack', 'Soldier', 'general', 263);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (288520840, 'JoanAdler', 'Secretary', 'sergeant', 56);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (367016390, 'VickieRowlands', 'Assistant', 'captain', 440);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (326897666, 'PamTarantino', 'Cleaner', 'corporal', 145);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (398482696, 'UmaChild', 'Commander', 'major general', 236);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (361196535, 'RedReilly', 'Commander', 'major', 380);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (233070548, 'HerbieHopkins', 'Assistant', 'sergeant', 231);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (302505486, 'Jean-LucFord', 'Secretary', 'major', 346);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (275564959, 'JoshJackson', 'Assistant', 'major', 105);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (379448719, 'HeathBuffalo', 'Secretary', 'major general', 500);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (319240475, 'GoldieMadsen', 'Cleaner', 'major general', 184);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (343032790, 'BobCoolidge', 'Assistant', 'corporal', 58);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (342601897, 'ElizaEdmunds', 'Secretary', 'corporal', 260);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (215438113, 'GeneSkerritt', 'Secretary', 'general', 468);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (251632815, 'KarenDean', 'Cleaner', 'sergeant', 188);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (398380777, 'PaulFisher', 'Cleaner', 'corporal', 10);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (308176959, 'FreddySchwarzenegger', 'Commander', 'corporal', 395);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (206669675, 'TeriLizzy', 'Secretary', 'major', 247);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (235077356, 'WaymanJonze', 'Assistant', 'sergeant', 63);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (342583947, 'CarlosMorse', 'Secretary', 'major', 129);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (238698303, 'LorraineMcAnally', 'Secretary', 'captain', 362);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (276695729, 'MarisaMichaels', 'Assistant', 'corporal', 200);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (239455155, 'CharltonLeguizamo', 'Commander', 'sergeant', 247);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (350763226, 'AngelinaGore', 'Assistant', 'general', 485);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (250976918, 'HookahAstin', 'Secretary', 'major general', 444);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (268319085, 'JonathaBiggs', 'Commander', 'major', 240);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (298526665, 'AlfieEaston', 'Assistant', 'general', 394);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (288579091, 'CarleneNeeson', 'Cleaner', 'general', 395);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (317304751, 'JudyCoburn', 'Cleaner', 'major general', 25);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (289296167, 'NathanMorrison', 'Soldier', 'major general', 136);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (321259857, 'KyraNeil', 'Assistant', 'corporal', 371);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (314184694, 'SteveScott', 'Soldier', 'captain', 183);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (383032830, 'AlanaDreyfuss', 'Cleaner', 'major', 167);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (270540137, 'MerrillLiu', 'Secretary', 'sergeant', 478);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (215658349, 'NenehBachman', 'Commander', 'captain', 169);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (292678988, 'BetteCube', 'Soldier', 'captain', 90);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (396649391, 'DonnaMcElhone', 'Secretary', 'major', 100);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (336824020, 'BrittanyStiller', 'Assistant', 'major', 289);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (325089525, 'JeffreyTippe', 'Commander', 'sergeant', 213);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (223059853, 'GloriaLeary', 'Assistant', 'captain', 352);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (252358001, 'CyndiEvanswood', 'Commander', 'captain', 112);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (389983831, 'RoryLevert', 'Soldier', 'sergeant', 305);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (377112666, 'GranGreen', 'Commander', 'major', 85);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (277677218, 'EddiePlace', 'Commander', 'sergeant', 421);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (245155685, 'TildaCraddock', 'Soldier', 'major general', 343);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (304621697, 'JeffLuPone', 'Cleaner', 'corporal', 404);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (344807073, 'EllenSevenfold', 'Commander', 'corporal', 148);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (254186189, 'LeonMathis', 'Commander', 'general', 354);
commit;
prompt 300 records committed...
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (238411048, 'RayShawn', 'Assistant', 'sergeant', 495);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (336308982, 'MorganEldard', 'Commander', 'major', 190);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (220600189, 'KurtwoodRed', 'Commander', 'sergeant', 77);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (240000172, 'RichPryce', 'Commander', 'corporal', 352);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (343942406, 'GregHauer', 'Soldier', 'captain', 438);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (342289416, 'SpikeStiller', 'Cleaner', 'general', 240);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (302595729, 'ColleenHynde', 'Soldier', 'major', 302);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (289243999, 'DonalD''Onofrio', 'Assistant', 'major', 451);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (314595903, 'HughSilverman', 'Assistant', 'major', 229);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (214682215, 'RobertaKinski', 'Assistant', 'captain', 3);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (393401801, 'VingStrong', 'Cleaner', 'sergeant', 347);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (312207054, 'ColeStiers', 'Commander', 'captain', 384);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (249323642, 'FionaAdler', 'Cleaner', 'captain', 35);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (326185210, 'RitchieVega', 'Assistant', 'major', 353);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (311459033, 'BenicioO''Keefe', 'Assistant', 'corporal', 85);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (377296395, 'GordPhillips', 'Assistant', 'captain', 81);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (210761808, 'MeredithShannon', 'Secretary', 'major', 458);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (388277969, 'DevonBell', 'Commander', 'major', 304);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (314868697, 'ParkerWeisberg', 'Commander', 'corporal', 395);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (225489882, 'TerenceManning', 'Assistant', 'corporal', 338);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (355308793, 'JackieMars', 'Soldier', 'corporal', 277);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (321924924, 'EwanKeen', 'Soldier', 'major general', 375);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (237720837, 'MindyMarshall', 'Assistant', 'major', 224);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (397289299, 'LenaSheen', 'Soldier', 'major general', 140);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (375703320, 'AustinColon', 'Secretary', 'major general', 84);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (340778495, 'AlfredZevon', 'Commander', 'general', 117);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (338922388, 'DougAllison', 'Commander', 'major general', 55);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (372173483, 'AhmadStreet', 'Commander', 'sergeant', 135);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (256102569, 'HikaruMyers', 'Soldier', 'corporal', 334);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (246882215, 'PaulaOntiveros', 'Commander', 'captain', 294);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (263525307, 'MadeleinePitt', 'Commander', 'major', 289);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (320551446, 'RoyBlossoms', 'Secretary', 'captain', 269);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (339660305, 'DennisJamal', 'Soldier', 'corporal', 301);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (338873856, 'RamseyCondition', 'Cleaner', 'captain', 217);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (316554694, 'HectorCoward', 'Commander', 'general', 21);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (268215500, 'LaurenceGertner', 'Assistant', 'sergeant', 77);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (308604997, 'VondieBryson', 'Cleaner', 'general', 433);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (332688553, 'HookahArmstrong', 'Assistant', 'sergeant', 239);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (249336919, 'Jonny LeeHoffman', 'Soldier', 'sergeant', 230);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (273294384, 'AnnDouglas', 'Secretary', 'captain', 127);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (276817946, 'SallyPenn', 'Cleaner', 'corporal', 126);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (294761929, 'DianeCervine', 'Soldier', 'sergeant', 406);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (358327748, 'JoaquinBright', 'Commander', 'general', 378);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (215706386, 'FranceRedgrave', 'Soldier', 'major', 127);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (394911411, 'AntonioLeto', 'Secretary', 'captain', 389);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (387733220, 'TayeButler', 'Cleaner', 'corporal', 260);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (296440465, 'StephenCarradine', 'Secretary', 'major general', 405);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (399112473, 'JudiGiamatti', 'Soldier', 'sergeant', 179);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (367806735, 'PamRoundtree', 'Soldier', 'corporal', 431);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (228648401, 'TalvinWarwick', 'Commander', 'corporal', 301);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (396873999, 'HazelBradford', 'Commander', 'sergeant', 139);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (365369409, 'DomWheel', 'Secretary', 'general', 195);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (284812463, 'NatashaHaggard', 'Soldier', 'corporal', 137);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (259663310, 'TimothyHughes', 'Cleaner', 'sergeant', 107);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (309441047, 'KurtwoodPorter', 'Assistant', 'sergeant', 111);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (321482887, 'JesusFlanagan', 'Soldier', 'captain', 472);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (362202477, 'VondiePaquin', 'Soldier', 'major', 471);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (331246774, 'JohnnieWine', 'Assistant', 'major', 107);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (349396203, 'MerrillMcGregor', 'Soldier', 'major', 270);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (379060648, 'CarlaRichards', 'Secretary', 'major general', 414);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (398294114, 'DelroyKane', 'Secretary', 'sergeant', 262);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (297883731, 'MerrillCollins', 'Soldier', 'sergeant', 14);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (358764079, 'DougRibisi', 'Soldier', 'corporal', 116);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (206265610, 'RebeccaTorn', 'Secretary', 'sergeant', 420);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (341026292, 'TerenceScaggs', 'Soldier', 'sergeant', 419);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (226278361, 'JudePosey', 'Soldier', 'sergeant', 406);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (280167432, 'JoaquimIrving', 'Cleaner', 'major', 226);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (292268993, 'AlexMcIntyre', 'Secretary', 'general', 423);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (368037637, 'FionaChambers', 'Soldier', 'captain', 33);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (216057203, 'GordonBotti', 'Secretary', 'major', 478);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (243155289, 'BrendanStrathairn', 'Secretary', 'general', 193);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (224203441, 'JillLloyd', 'Secretary', 'captain', 84);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (279244609, 'EddieFlack', 'Cleaner', 'sergeant', 397);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (232972288, 'StephanieMewes', 'Commander', 'captain', 433);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (363031071, 'OrlandoCarrington', 'Soldier', 'captain', 477);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (376616149, 'ToddKeaton', 'Commander', 'captain', 149);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (201919621, 'ToniParish', 'Cleaner', 'sergeant', 429);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (354604258, 'AliciaDillon', 'Commander', 'corporal', 44);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (252180717, 'HazelBarrymore', 'Commander', 'sergeant', 147);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (213421990, 'CandiceWeisberg', 'Cleaner', 'corporal', 454);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (208269172, 'Carrie-AnneHawke', 'Cleaner', 'sergeant', 3);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (228565494, 'LennieShepherd', 'Assistant', 'corporal', 360);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (243900815, 'CliveCozier', 'Secretary', 'corporal', 45);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (202356634, 'GailardO''Sullivan', 'Commander', 'sergeant', 90);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (245511965, 'LynnMalkovich', 'Secretary', 'sergeant', 178);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (343203240, 'RyanTinsley', 'Soldier', 'major general', 80);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (328726717, 'PeteTripplehorn', 'Commander', 'sergeant', 346);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (341929679, 'NastassjaDeLuise', 'Assistant', 'major', 228);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (378457036, 'BrianMurray', 'Soldier', 'general', 347);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (310802729, 'SuzanneCash', 'Secretary', 'corporal', 74);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (203260673, 'JackJordan', 'Commander', 'major', 31);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (300877774, 'MoeOwen', 'Commander', 'major', 92);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (344581880, 'EdwinRonstadt', 'Commander', 'sergeant', 280);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (363290307, 'RichardDushku', 'Commander', 'sergeant', 64);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (231499952, 'DonnaBrosnan', 'Assistant', 'corporal', 259);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (370117744, 'ShirleyHudson', 'Commander', 'major general', 95);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (221610570, 'FionnulaFender', 'Cleaner', 'corporal', 81);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (260436558, 'HankNicholson', 'Cleaner', 'major general', 463);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (318664966, 'TraceHewett', 'Secretary', 'major general', 150);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (227199714, 'BernardStuermer', 'Assistant', 'corporal', 131);
commit;
prompt 400 records committed...
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (207591891, 'JoshCollie', 'Soldier', 'major', 45);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (210559429, 'DennisGaines', 'Soldier', 'major general', 364);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (297527400, 'HoraceLee', 'Commander', 'corporal', 477);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (313260234, 'PetulaKretschmann', 'Cleaner', 'general', 17);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (313477455, 'JimmieMollard', 'Cleaner', 'sergeant', 429);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (203727355, 'BradleyParsons', 'Commander', 'captain', 195);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (227238329, 'EdieKaryo', 'Commander', 'major', 257);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (222475406, 'PenelopeKeen', 'Soldier', 'corporal', 99);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (368199834, 'HowieQuinones', 'Assistant', 'sergeant', 120);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (357462387, 'JamesOsborne', 'Soldier', 'corporal', 17);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (204656352, 'CurtisOakenfold', 'Secretary', 'captain', 253);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (304014007, 'GladysAskew', 'Secretary', 'corporal', 9);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (336250683, 'TonyCohn', 'Cleaner', 'major', 218);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (274943311, 'HarrisonMahoney', 'Soldier', 'sergeant', 496);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (288175708, 'TziFirth', 'Cleaner', 'major', 383);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (276490617, 'MelbaCosta', 'Commander', 'sergeant', 80);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (347758860, 'SusanTravers', 'Commander', 'general', 21);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (215708777, 'BrianFarris', 'Assistant', 'sergeant', 12);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (334054409, 'ElleWhitwam', 'Secretary', 'major', 30);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (254918738, 'ColeCaviezel', 'Assistant', 'major', 418);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (241068560, 'SethBurns', 'Secretary', 'sergeant', 413);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (278860424, 'EricHawthorne', 'Assistant', 'major', 439);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (345242361, 'MillaCopeland', 'Soldier', 'major', 265);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (390163926, 'WesleyCosta', 'Assistant', 'general', 132);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (217817430, 'LivVega', 'Secretary', 'major', 166);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (398766005, 'BarryHidalgo', 'Secretary', 'captain', 71);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (332709488, 'SineadBrowne', 'Commander', 'sergeant', 471);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (320896911, 'RoscoeDay-Lewis', 'Cleaner', 'sergeant', 211);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (210514704, 'CandiceMacLachlan', 'Commander', 'general', 142);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (353262510, 'DelroyWarden', 'Soldier', 'major', 215);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (289273859, 'DylanDevine', 'Commander', 'captain', 375);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (238046725, 'SamanthaSedaka', 'Commander', 'major general', 71);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (362619319, 'StevenBurstyn', 'Secretary', 'captain', 405);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (384359292, 'NinaDuvall', 'Assistant', 'major', 430);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (275929815, 'ValDomino', 'Soldier', 'major general', 491);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (361753825, 'JoyRyan', 'Soldier', 'sergeant', 248);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (221118046, 'JillSingletary', 'Assistant', 'sergeant', 234);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (231441194, 'JuanHolly', 'Cleaner', 'captain', 425);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (220676087, 'RosannaSandoval', 'Assistant', 'sergeant', 456);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (230823218, 'NataschaIrons', 'Soldier', 'major', 251);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (241603613, 'CeCeChestnut', 'Commander', 'sergeant', 51);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (376971670, 'MandyWeiss', 'Secretary', 'captain', 119);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (229843930, 'DonalJordan', 'Secretary', 'corporal', 291);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (204677589, 'KimDupree', 'Assistant', 'sergeant', 70);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (205852829, 'KatrinStone', 'Secretary', 'major general', 245);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (304695914, 'RemyDickinson', 'Secretary', 'sergeant', 352);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (211925241, 'PaulPhoenix', 'Cleaner', 'sergeant', 48);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (377810422, 'VerticalDuke', 'Soldier', 'sergeant', 343);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (351904712, 'LloydKleinenberg', 'Soldier', 'major', 412);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (370343983, 'AnneDench', 'Commander', 'corporal', 249);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (213900687, 'GarthVoight', 'Cleaner', 'general', 384);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (306739126, 'BoydScott', 'Soldier', 'sergeant', 176);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (216638609, 'TeriHunter', 'Commander', 'general', 492);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (284833921, 'StanleyVan Helden', 'Assistant', 'captain', 249);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (270067830, 'RawlinsMitra', 'Commander', 'captain', 22);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (349458165, 'MarcBurton', 'Soldier', 'sergeant', 119);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (390852328, 'JuddLyonne', 'Cleaner', 'major general', 321);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (209974888, 'MarieFlanery', 'Assistant', 'sergeant', 284);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (363369250, 'MelHatchet', 'Commander', 'general', 132);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (217392173, 'MarisaChecker', 'Cleaner', 'major general', 305);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (386840254, 'GilbertKahn', 'Commander', 'major', 83);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (266670280, 'BridgetteStampley', 'Cleaner', 'major', 116);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (299220674, 'BrentGayle', 'Soldier', 'major general', 110);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (339849089, 'NigelEpps', 'Assistant', 'major general', 234);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (218471485, 'ChristopherCarrack', 'Commander', 'sergeant', 170);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (255620856, 'RadeParm', 'Assistant', 'captain', 330);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (291839096, 'ManuElwes', 'Secretary', 'general', 272);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (240973276, 'JakeGilley', 'Commander', 'sergeant', 222);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (293767945, 'LarryHewett', 'Commander', 'general', 450);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (390527865, 'TaraBusey', 'Cleaner', 'major general', 484);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (263070907, 'HikaruBroza', 'Commander', 'sergeant', 440);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (329198649, 'UmaGarza', 'Secretary', 'major', 3);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (219982520, 'BrentOsborne', 'Assistant', 'corporal', 438);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (243796168, 'GrahamWayans', 'Assistant', 'sergeant', 413);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (253720016, 'MollyCrimson', 'Secretary', 'major general', 451);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (299201797, 'DerekNielsen', 'Soldier', 'corporal', 489);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (321177175, 'JeroenLillard', 'Cleaner', 'corporal', 377);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (304737366, 'JimmieDorn', 'Secretary', 'major', 193);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (347375977, 'SethTsettos', 'Cleaner', 'major general', 61);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (346355110, 'ElisabethTilly', 'Assistant', 'captain', 185);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (268301082, 'ThomasMahood', 'Secretary', 'general', 223);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (350272920, 'DonaldMoriarty', 'Commander', 'sergeant', 259);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (306742113, 'GraceCassidy', 'Secretary', 'general', 257);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (393679907, 'RonFarris', 'Soldier', 'sergeant', 258);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (221768748, 'ColinColton', 'Cleaner', 'sergeant', 35);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (228137283, 'ChristineCollette', 'Assistant', 'major', 178);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (322463641, 'GordSolido', 'Soldier', 'major', 479);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (331299553, 'HalLewis', 'Secretary', 'sergeant', 267);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (286538135, 'LaurieKeaton', 'Secretary', 'general', 275);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (252581018, 'RoscoeTwilley', 'Assistant', 'sergeant', 79);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (274455800, 'GaryShearer', 'Cleaner', 'sergeant', 246);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (268392592, 'JoelyFierstein', 'Assistant', 'major general', 44);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (279688785, 'DanClooney', 'Commander', 'general', 11);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (212573930, 'FairuzaStowe', 'Cleaner', 'sergeant', 245);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (305731971, 'HexGracie', 'Cleaner', 'major general', 187);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (397645868, 'EmmaHolden', 'Secretary', 'major', 238);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (210499951, 'CurtisNicks', 'Cleaner', 'sergeant', 26);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (392508183, 'LoreenaMcDowell', 'Secretary', 'general', 348);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (308731807, 'JimmieAykroyd', 'Soldier', 'corporal', 480);
insert into PERSON (personid, personname, personrole, personrank, unitid)
values (272207651, 'LydiaFrancis', 'Soldier', 'sergeant', 9);
commit;
prompt 500 records loaded
prompt Loading RESOURCES...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5468, 'plane', 11751, 'medium lev', 265);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90133, 'plane', 6200, 'low level', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (19363, 'ship', 1735, 'high level', 499);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (22284, 'gun', 43, 'low level', 139);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (93021, 'gun', 13688, 'high level', 458);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (12946, 'ship', 5903, 'high level', 152);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34098, 'cannon', 13130, 'medium lev', 255);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (19319, 'cannon', 14651, 'medium lev', 372);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81572, 'ship', 2887, 'low level', 311);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96565, 'gun', 13331, 'medium lev', 168);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (1263, 'gun', 17996, 'high level', 415);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (75662, 'rifle', 957, 'high level', 427);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (82778, 'tank', 14061, 'low level', 243);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27618, 'tank', 4133, 'medium lev', 447);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50060, 'plane', 14330, 'medium lev', 215);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36942, 'gun', 2190, 'medium lev', 237);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (1228, 'tank', 8788, 'low level', 380);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14478, 'cannon', 7184, 'medium lev', 422);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71185, 'ship', 7749, 'low level', 253);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (4732, 'cannon', 9549, 'low level', 395);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (40664, 'rifle', 3290, 'high level', 317);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (42203, 'ship', 16827, 'high level', 216);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (79173, 'ship', 10719, 'low level', 191);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90954, 'tank', 11777, 'high level', 74);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (37851, 'tank', 5337, 'medium lev', 369);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18211, 'cannon', 18740, 'low level', 243);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (83044, 'ship', 3300, 'medium lev', 412);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (12233, 'plane', 4429, 'low level', 252);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13358, 'cannon', 15619, 'low level', 118);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13365, 'gun', 12851, 'medium lev', 467);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13694, 'gun', 17578, 'medium lev', 473);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (91392, 'plane', 14788, 'medium lev', 227);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (166, 'gun', 18284, 'low level', 188);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (28152, 'cannon', 1735, 'medium lev', 91);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81456, 'gun', 12973, 'low level', 365);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (58235, 'cannon', 3361, 'high level', 489);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36042, 'tank', 10322, 'high level', 294);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (38645, 'ship', 17949, 'medium lev', 71);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62273, 'tank', 14623, 'high level', 187);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66861, 'tank', 7902, 'medium lev', 167);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30623, 'cannon', 4484, 'low level', 255);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (1949, 'plane', 8716, 'high level', 491);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (35925, 'cannon', 12011, 'high level', 476);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71657, 'rifle', 878, 'high level', 389);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (43148, 'rifle', 5423, 'high level', 271);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25793, 'cannon', 1421, 'low level', 430);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24747, 'rifle', 38, 'low level', 64);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29171, 'gun', 16347, 'medium lev', 15);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (31763, 'gun', 3744, 'medium lev', 391);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (31977, 'gun', 18342, 'medium lev', 106);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6266, 'plane', 9729, 'high level', 460);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18050, 'plane', 7148, 'medium lev', 321);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (60353, 'rifle', 17654, 'low level', 231);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68356, 'gun', 14052, 'medium lev', 191);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98205, 'plane', 743, 'high level', 355);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (94240, 'ship', 18385, 'high level', 359);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73829, 'cannon', 16898, 'high level', 123);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (49041, 'ship', 13943, 'high level', 326);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39288, 'tank', 12907, 'high level', 14);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23614, 'ship', 8092, 'medium lev', 313);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77812, 'cannon', 8662, 'medium lev', 491);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27515, 'rifle', 17292, 'low level', 475);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14284, 'tank', 18917, 'medium lev', 412);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59243, 'cannon', 11063, 'high level', 333);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (83641, 'rifle', 10147, 'low level', 396);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32342, 'plane', 13322, 'high level', 401);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96725, 'gun', 5440, 'low level', 96);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (55473, 'rifle', 6752, 'medium lev', 404);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (4659, 'tank', 17477, 'medium lev', 293);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (20169, 'rifle', 3686, 'high level', 153);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7732, 'plane', 14771, 'low level', 420);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36010, 'tank', 17199, 'high level', 493);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14706, 'cannon', 5650, 'low level', 189);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25688, 'rifle', 9813, 'high level', 100);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14409, 'plane', 4239, 'low level', 358);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (58198, 'gun', 5907, 'low level', 283);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (4747, 'ship', 19215, 'high level', 498);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13273, 'cannon', 8555, 'low level', 143);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16204, 'tank', 5573, 'low level', 289);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (40672, 'gun', 13624, 'low level', 468);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98595, 'ship', 18351, 'high level', 36);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59953, 'tank', 4578, 'medium lev', 399);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (92710, 'tank', 11376, 'medium lev', 240);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46581, 'rifle', 11942, 'high level', 202);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13638, 'ship', 10046, 'low level', 187);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24424, 'tank', 12922, 'high level', 238);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (11323, 'rifle', 925, 'high level', 195);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39563, 'plane', 678, 'high level', 390);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77547, 'rifle', 19070, 'high level', 455);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81788, 'cannon', 10174, 'high level', 204);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18206, 'ship', 2482, 'low level', 224);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (54660, 'rifle', 19962, 'high level', 180);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36846, 'cannon', 18402, 'medium lev', 166);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (28692, 'ship', 17697, 'medium lev', 472);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (60985, 'ship', 14281, 'high level', 288);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (51366, 'cannon', 12953, 'medium lev', 109);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18347, 'plane', 3838, 'high level', 285);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88581, 'gun', 5344, 'medium lev', 105);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16621, 'rifle', 11402, 'high level', 230);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (40988, 'gun', 162, 'high level', 478);
commit;
prompt 100 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29329, 'plane', 2435, 'high level', 381);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71714, 'rifle', 9100, 'high level', 15);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (22906, 'rifle', 10719, 'low level', 45);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5513, 'ship', 11276, 'medium lev', 189);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7440, 'gun', 9487, 'high level', 426);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (69673, 'ship', 1082, 'low level', 157);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36996, 'rifle', 11084, 'medium lev', 188);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50163, 'gun', 5445, 'high level', 359);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56234, 'tank', 13734, 'high level', 236);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (89022, 'tank', 15348, 'low level', 92);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (69438, 'gun', 10971, 'high level', 288);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56834, 'rifle', 15963, 'low level', 184);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27296, 'tank', 15476, 'medium lev', 483);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (53814, 'rifle', 17934, 'high level', 200);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (67126, 'cannon', 10734, 'low level', 248);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30595, 'cannon', 284, 'low level', 134);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34885, 'ship', 7282, 'medium lev', 320);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (31635, 'cannon', 14578, 'low level', 444);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (43614, 'ship', 11692, 'medium lev', 356);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56450, 'plane', 1303, 'medium lev', 195);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14030, 'tank', 11988, 'low level', 325);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62874, 'cannon', 14550, 'high level', 202);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (80236, 'cannon', 9213, 'high level', 155);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (8531, 'tank', 10847, 'high level', 484);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (58028, 'plane', 17666, 'medium lev', 38);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (97893, 'tank', 14033, 'medium lev', 315);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46458, 'tank', 1986, 'high level', 426);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (78930, 'gun', 11305, 'medium lev', 210);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96267, 'tank', 14257, 'low level', 44);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71806, 'gun', 7495, 'high level', 137);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (12911, 'rifle', 4683, 'low level', 284);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18334, 'ship', 16355, 'low level', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98322, 'rifle', 1541, 'medium lev', 149);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71539, 'rifle', 485, 'low level', 466);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (55537, 'tank', 16176, 'medium lev', 5);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5682, 'plane', 16687, 'medium lev', 222);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (15258, 'gun', 3160, 'high level', 319);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74858, 'gun', 2297, 'medium lev', 396);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74279, 'gun', 511, 'high level', 322);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88998, 'rifle', 1706, 'low level', 377);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (94081, 'tank', 6342, 'high level', 210);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66063, 'ship', 1922, 'high level', 231);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74769, 'gun', 2829, 'high level', 62);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (64607, 'gun', 13119, 'low level', 133);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (26256, 'ship', 12052, 'low level', 188);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (58029, 'plane', 15757, 'low level', 229);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86435, 'cannon', 7410, 'high level', 111);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86926, 'tank', 11344, 'low level', 473);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16268, 'rifle', 5237, 'low level', 427);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (75280, 'ship', 471, 'medium lev', 94);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (15473, 'tank', 10033, 'medium lev', 329);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25993, 'rifle', 715, 'high level', 435);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81120, 'rifle', 19849, 'low level', 231);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77786, 'plane', 9500, 'medium lev', 211);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56125, 'ship', 1844, 'low level', 151);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14954, 'cannon', 4367, 'high level', 361);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16735, 'tank', 18348, 'high level', 414);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30170, 'plane', 16582, 'low level', 303);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (8679, 'ship', 6914, 'low level', 251);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (54666, 'gun', 4780, 'low level', 174);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (92191, 'rifle', 10364, 'medium lev', 149);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46019, 'rifle', 14782, 'medium lev', 251);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77673, 'tank', 672, 'low level', 250);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (67624, 'plane', 10902, 'high level', 261);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (57717, 'tank', 205, 'low level', 351);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (61966, 'gun', 4453, 'low level', 12);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (48679, 'rifle', 1413, 'medium lev', 94);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18388, 'rifle', 17793, 'medium lev', 195);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77408, 'tank', 17899, 'low level', 262);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21259, 'cannon', 8543, 'high level', 121);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (67165, 'ship', 12050, 'high level', 338);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (42705, 'rifle', 9720, 'medium lev', 104);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (22572, 'ship', 13462, 'low level', 59);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71483, 'gun', 18718, 'medium lev', 457);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (67830, 'ship', 14312, 'high level', 210);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (52505, 'cannon', 2655, 'medium lev', 169);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86672, 'tank', 19073, 'medium lev', 399);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6131, 'tank', 683, 'low level', 26);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27871, 'ship', 2575, 'medium lev', 437);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (8969, 'ship', 7101, 'low level', 330);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7774, 'cannon', 8851, 'high level', 470);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (4710, 'rifle', 12368, 'low level', 164);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (42614, 'cannon', 9501, 'high level', 461);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (80846, 'plane', 17184, 'low level', 402);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (9467, 'rifle', 10912, 'medium lev', 209);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (51072, 'gun', 12767, 'high level', 197);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46936, 'gun', 688, 'high level', 280);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30214, 'cannon', 16957, 'low level', 459);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96160, 'ship', 11402, 'low level', 15);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34646, 'tank', 5935, 'low level', 182);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30940, 'cannon', 506, 'low level', 289);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (92870, 'cannon', 19849, 'medium lev', 420);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (63726, 'ship', 15187, 'low level', 366);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (64285, 'tank', 7526, 'low level', 22);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23296, 'tank', 16320, 'low level', 97);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (45536, 'rifle', 2191, 'low level', 445);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (11410, 'tank', 12895, 'high level', 407);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (49380, 'ship', 7923, 'low level', 353);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (40698, 'plane', 13265, 'low level', 458);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77067, 'cannon', 16769, 'medium lev', 341);
commit;
prompt 200 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (65945, 'plane', 8993, 'high level', 186);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27957, 'gun', 10218, 'low level', 204);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (26870, 'ship', 16792, 'medium lev', 45);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5854, 'ship', 17323, 'low level', 313);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (53805, 'gun', 10579, 'medium lev', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46434, 'plane', 6482, 'low level', 115);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29564, 'gun', 5142, 'high level', 436);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10603, 'plane', 9952, 'high level', 29);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (82555, 'cannon', 1593, 'low level', 151);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (20716, 'tank', 777, 'medium lev', 449);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88982, 'rifle', 18959, 'low level', 307);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66684, 'ship', 12348, 'high level', 76);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (17205, 'cannon', 12125, 'medium lev', 75);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (33344, 'ship', 12345, 'medium lev', 329);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36056, 'ship', 210, 'low level', 447);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5224, 'cannon', 6790, 'low level', 23);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62536, 'cannon', 17500, 'low level', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46343, 'cannon', 17403, 'high level', 192);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24043, 'tank', 17616, 'low level', 339);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (37160, 'ship', 17861, 'medium lev', 430);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (87304, 'cannon', 6844, 'high level', 478);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34499, 'cannon', 13001, 'high level', 143);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (41838, 'cannon', 770, 'high level', 169);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (9397, 'rifle', 10797, 'high level', 251);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (51287, 'ship', 5810, 'low level', 249);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68729, 'cannon', 11358, 'high level', 347);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (82483, 'ship', 10139, 'high level', 271);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (85309, 'ship', 11421, 'medium lev', 238);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21107, 'rifle', 3144, 'low level', 399);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (4227, 'cannon', 18130, 'high level', 386);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (65274, 'gun', 15126, 'low level', 95);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66716, 'cannon', 13604, 'low level', 29);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (85741, 'tank', 15795, 'low level', 61);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (53095, 'tank', 13033, 'medium lev', 90);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34926, 'plane', 17390, 'high level', 476);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (99575, 'tank', 5167, 'medium lev', 289);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7688, 'tank', 12242, 'low level', 12);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46126, 'rifle', 16279, 'medium lev', 492);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86231, 'ship', 1605, 'high level', 44);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30541, 'rifle', 8200, 'high level', 332);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (70729, 'ship', 18733, 'medium lev', 266);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13442, 'ship', 9239, 'medium lev', 181);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (87625, 'tank', 857, 'medium lev', 281);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6591, 'cannon', 14689, 'low level', 339);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10173, 'gun', 18124, 'low level', 32);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (38657, 'rifle', 2792, 'low level', 456);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (2137, 'plane', 8838, 'medium lev', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34908, 'cannon', 3428, 'medium lev', 356);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36604, 'tank', 15996, 'medium lev', 228);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66272, 'ship', 11776, 'low level', 301);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29134, 'cannon', 16063, 'medium lev', 347);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (45204, 'tank', 9138, 'high level', 435);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88984, 'gun', 13756, 'high level', 352);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66975, 'plane', 18996, 'high level', 323);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (15289, 'tank', 12272, 'medium lev', 121);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21669, 'gun', 19721, 'low level', 354);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (78107, 'cannon', 13386, 'high level', 141);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90542, 'rifle', 17225, 'high level', 439);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (8249, 'ship', 2205, 'low level', 194);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96746, 'cannon', 2602, 'medium lev', 21);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6327, 'gun', 3548, 'medium lev', 75);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (61017, 'tank', 2619, 'medium lev', 202);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (51397, 'gun', 6955, 'low level', 353);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23894, 'gun', 6096, 'high level', 258);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74478, 'gun', 1721, 'medium lev', 398);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (93876, 'rifle', 18010, 'low level', 294);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (43177, 'gun', 8060, 'medium lev', 390);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71561, 'cannon', 6719, 'medium lev', 320);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (11946, 'tank', 12062, 'low level', 466);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39836, 'plane', 9480, 'high level', 323);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5517, 'tank', 18403, 'medium lev', 80);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90830, 'plane', 3672, 'low level', 360);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (85029, 'gun', 4699, 'low level', 221);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (61971, 'cannon', 14127, 'high level', 394);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (51774, 'gun', 4541, 'high level', 5);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10104, 'gun', 18972, 'low level', 296);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62191, 'rifle', 6414, 'medium lev', 111);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (42506, 'plane', 18624, 'high level', 30);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (57238, 'ship', 18805, 'medium lev', 93);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (60761, 'rifle', 6847, 'low level', 38);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (52596, 'gun', 19566, 'low level', 198);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74209, 'gun', 11027, 'high level', 55);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90320, 'rifle', 5658, 'high level', 144);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7827, 'gun', 277, 'low level', 100);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (83379, 'ship', 15452, 'high level', 303);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (70519, 'plane', 6142, 'low level', 477);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (48667, 'cannon', 16530, 'low level', 297);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50227, 'ship', 3125, 'low level', 176);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (49972, 'tank', 1381, 'medium lev', 335);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73922, 'plane', 14158, 'low level', 266);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66212, 'plane', 2559, 'high level', 434);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (44402, 'gun', 15764, 'low level', 346);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18320, 'plane', 9251, 'medium lev', 89);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23374, 'gun', 5273, 'medium lev', 434);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36726, 'plane', 9861, 'high level', 162);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (2653, 'tank', 14250, 'high level', 244);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86567, 'tank', 1483, 'high level', 399);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73778, 'plane', 14583, 'high level', 276);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96067, 'ship', 8253, 'low level', 204);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (2112, 'cannon', 2712, 'medium lev', 494);
commit;
prompt 300 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10900, 'ship', 17775, 'high level', 288);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (15949, 'ship', 9395, 'medium lev', 128);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30296, 'rifle', 9375, 'low level', 158);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (65306, 'gun', 3656, 'high level', 333);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25258, 'tank', 11071, 'low level', 390);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (70505, 'cannon', 6186, 'high level', 159);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (1878, 'cannon', 15136, 'low level', 217);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98235, 'cannon', 15860, 'low level', 483);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (9548, 'gun', 6223, 'high level', 53);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (54120, 'rifle', 9370, 'low level', 278);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (11117, 'rifle', 2418, 'low level', 58);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96908, 'tank', 14562, 'low level', 459);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86112, 'tank', 19762, 'low level', 129);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (41578, 'gun', 9069, 'low level', 437);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (35044, 'plane', 15105, 'medium lev', 234);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (58277, 'plane', 13615, 'low level', 102);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (49079, 'gun', 4210, 'low level', 111);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (72066, 'rifle', 74, 'low level', 168);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10934, 'rifle', 18948, 'high level', 30);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56501, 'gun', 14304, 'low level', 276);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56337, 'gun', 5399, 'high level', 391);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73142, 'ship', 9196, 'high level', 361);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56633, 'tank', 927, 'high level', 374);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (70476, 'ship', 10512, 'low level', 286);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (38773, 'cannon', 6195, 'low level', 28);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (819, 'gun', 3164, 'high level', 389);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (44895, 'plane', 18323, 'high level', 6);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73575, 'cannon', 4920, 'medium lev', 189);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6497, 'ship', 15104, 'medium lev', 62);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (19196, 'rifle', 14299, 'high level', 345);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73910, 'gun', 8861, 'medium lev', 249);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21534, 'ship', 15929, 'high level', 307);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (56719, 'rifle', 3162, 'medium lev', 10);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68079, 'rifle', 6106, 'medium lev', 221);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (1203, 'ship', 17747, 'high level', 334);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (99421, 'rifle', 19990, 'low level', 377);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (12975, 'ship', 17581, 'high level', 330);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (92024, 'plane', 6018, 'medium lev', 63);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (33114, 'plane', 2515, 'low level', 378);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13615, 'ship', 19040, 'low level', 376);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50395, 'plane', 5549, 'medium lev', 237);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29254, 'rifle', 17443, 'high level', 183);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (87014, 'cannon', 1661, 'low level', 209);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39758, 'rifle', 7714, 'low level', 224);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86681, 'gun', 6670, 'high level', 408);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (83867, 'gun', 8309, 'high level', 195);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68477, 'tank', 17973, 'medium lev', 389);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62585, 'ship', 34, 'medium lev', 148);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (43507, 'plane', 17430, 'low level', 219);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29780, 'gun', 18324, 'high level', 231);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (30578, 'ship', 12508, 'high level', 389);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68599, 'gun', 259, 'high level', 151);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (8010, 'plane', 16160, 'low level', 283);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (19861, 'ship', 12084, 'medium lev', 331);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7499, 'cannon', 10156, 'low level', 498);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77505, 'tank', 7576, 'low level', 135);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (49071, 'ship', 1937, 'medium lev', 196);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98664, 'cannon', 10275, 'low level', 123);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39650, 'rifle', 2717, 'low level', 189);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23362, 'plane', 9337, 'high level', 358);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68061, 'gun', 5830, 'medium lev', 6);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (42215, 'plane', 16111, 'high level', 38);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32472, 'tank', 442, 'medium lev', 266);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21370, 'cannon', 2508, 'low level', 29);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88755, 'cannon', 17955, 'high level', 61);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73294, 'plane', 19223, 'high level', 428);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16127, 'tank', 7957, 'medium lev', 258);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81246, 'gun', 8041, 'low level', 473);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16090, 'gun', 18766, 'low level', 2);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25635, 'cannon', 4168, 'low level', 73);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98251, 'gun', 5533, 'medium lev', 146);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (53109, 'plane', 7823, 'high level', 422);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18459, 'cannon', 8032, 'high level', 312);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (55494, 'ship', 15768, 'medium lev', 200);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (26954, 'gun', 1617, 'high level', 135);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16840, 'tank', 18937, 'medium lev', 104);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13226, 'gun', 9908, 'low level', 420);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24012, 'plane', 18436, 'high level', 256);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6279, 'ship', 7571, 'medium lev', 303);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50818, 'plane', 4866, 'high level', 444);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (60156, 'gun', 17576, 'high level', 44);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98827, 'tank', 11707, 'low level', 301);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (31269, 'cannon', 10558, 'medium lev', 90);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (40998, 'rifle', 8390, 'medium lev', 301);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (92433, 'tank', 5858, 'high level', 9);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (48345, 'gun', 9146, 'low level', 6);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34864, 'tank', 5506, 'medium lev', 219);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16257, 'cannon', 15800, 'medium lev', 296);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39973, 'tank', 5273, 'high level', 467);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27148, 'rifle', 12812, 'medium lev', 390);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (63800, 'tank', 12098, 'high level', 243);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (20948, 'ship', 7164, 'low level', 418);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24711, 'cannon', 15936, 'low level', 29);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (75925, 'tank', 486, 'high level', 22);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25695, 'ship', 7713, 'low level', 79);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (60594, 'gun', 12315, 'high level', 196);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32532, 'plane', 4775, 'low level', 454);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (84415, 'gun', 7843, 'low level', 61);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74518, 'gun', 12261, 'medium lev', 464);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81668, 'gun', 17243, 'low level', 390);
commit;
prompt 400 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (91571, 'rifle', 14479, 'high level', 189);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90762, 'plane', 12741, 'medium lev', 130);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (26622, 'tank', 5858, 'low level', 440);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71392, 'tank', 10589, 'high level', 231);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (11530, 'plane', 17623, 'high level', 124);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (15736, 'ship', 13835, 'low level', 135);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24532, 'ship', 5263, 'low level', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88493, 'gun', 4925, 'high level', 411);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (63735, 'plane', 14403, 'medium lev', 122);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (55264, 'gun', 692, 'medium lev', 276);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90675, 'rifle', 10020, 'high level', 175);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (60854, 'plane', 12502, 'medium lev', 112);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6583, 'ship', 17430, 'high level', 450);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (79680, 'ship', 17607, 'medium lev', 115);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (38238, 'gun', 14257, 'high level', 233);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10992, 'ship', 160, 'medium lev', 15);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86105, 'gun', 12002, 'low level', 385);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13172, 'tank', 8272, 'medium lev', 190);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (31341, 'cannon', 5051, 'high level', 207);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (95317, 'rifle', 13092, 'medium lev', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66303, 'tank', 5311, 'high level', 409);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (91827, 'cannon', 13547, 'high level', 298);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (11718, 'gun', 13326, 'medium lev', 331);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68081, 'cannon', 2130, 'medium lev', 73);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68965, 'plane', 3006, 'high level', 495);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23733, 'cannon', 19454, 'medium lev', 190);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34085, 'ship', 8199, 'medium lev', 15);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5989, 'rifle', 14269, 'high level', 262);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27638, 'rifle', 16562, 'medium lev', 152);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (99574, 'gun', 17632, 'high level', 33);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (77389, 'rifle', 10724, 'medium lev', 368);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (54386, 'plane', 11087, 'low level', 187);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (85451, 'tank', 9883, 'high level', 492);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27135, 'plane', 5407, 'medium lev', 152);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24124, 'plane', 7970, 'low level', 433);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (80951, 'ship', 4775, 'low level', 77);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (91464, 'tank', 18588, 'high level', 213);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88193, 'rifle', 17696, 'low level', 145);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24899, 'plane', 13367, 'medium lev', 339);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (47868, 'cannon', 6441, 'high level', 492);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (75255, 'tank', 387, 'low level', 39);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (41184, 'cannon', 7893, 'high level', 136);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (90451, 'tank', 4253, 'low level', 213);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (38383, 'cannon', 6396, 'low level', 184);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (4406, 'tank', 86, 'high level', 244);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18130, 'ship', 19964, 'medium lev', 14);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (78280, 'tank', 12578, 'low level', 301);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (98687, 'cannon', 11094, 'high level', 372);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (54591, 'rifle', 17411, 'high level', 49);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (89231, 'plane', 18912, 'high level', 165);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66108, 'ship', 9678, 'high level', 391);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (81075, 'gun', 6422, 'high level', 488);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46942, 'cannon', 11473, 'high level', 284);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (93567, 'gun', 11814, 'low level', 305);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29339, 'plane', 11077, 'low level', 251);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (99316, 'tank', 2026, 'low level', 69);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32402, 'tank', 19939, 'high level', 341);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59358, 'gun', 16605, 'medium lev', 160);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (64709, 'ship', 12240, 'low level', 413);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32154, 'cannon', 16358, 'low level', 93);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27724, 'rifle', 16564, 'low level', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62216, 'ship', 809, 'medium lev', 359);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27315, 'cannon', 11224, 'low level', 269);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (35911, 'cannon', 7132, 'medium lev', 211);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32824, 'ship', 15455, 'medium lev', 334);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (94805, 'ship', 17389, 'low level', 35);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (73215, 'tank', 19162, 'high level', 58);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (52086, 'cannon', 16883, 'low level', 398);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (84172, 'tank', 15505, 'low level', 317);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46385, 'plane', 9967, 'low level', 241);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24773, 'rifle', 4511, 'high level', 460);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (20930, 'plane', 8306, 'low level', 238);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23895, 'tank', 3446, 'medium lev', 269);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (15646, 'plane', 4407, 'low level', 444);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (955, 'ship', 2015, 'high level', 134);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36910, 'rifle', 9066, 'high level', 109);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (89308, 'rifle', 18950, 'medium lev', 181);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (5278, 'plane', 9284, 'medium lev', 438);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (79751, 'ship', 2305, 'medium lev', 159);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (6998, 'plane', 10779, 'medium lev', 238);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (52517, 'gun', 10217, 'high level', 458);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (71725, 'gun', 12079, 'high level', 189);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (84904, 'ship', 3085, 'high level', 458);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (97741, 'plane', 11824, 'medium lev', 146);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (64839, 'tank', 13493, 'medium lev', 52);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (28546, 'ship', 3508, 'low level', 220);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (14160, 'rifle', 7838, 'medium lev', 432);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (82024, 'rifle', 18705, 'low level', 187);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (85665, 'gun', 14945, 'medium lev', 73);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (26830, 'ship', 7092, 'medium lev', 279);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (51198, 'cannon', 2987, 'high level', 117);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21497, 'ship', 5629, 'low level', 469);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (500, 'gun', 18344, 'high level', 29);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (61098, 'plane', 16165, 'low level', 157);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (28436, 'gun', 9453, 'low level', 349);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (45567, 'tank', 16995, 'high level', 98);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (57851, 'tank', 6982, 'high level', 458);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74128, 'tank', 5510, 'medium lev', 149);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (32917, 'tank', 9538, 'low level', 7);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (773677, 'plane', 11840, 'low level', 490);
commit;
prompt 500 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (106354, 'tank', 9062, 'high level', 157);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (797241, 'plane', 17471, 'medium lev', 355);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (192287, 'cannon', 3044, 'high level', 53);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (194181, 'ship', 6187, 'high level', 146);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (600720, 'ship', 9803, 'medium lev', 209);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (575556, 'gun', 6781, 'high level', 377);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (706819, 'plane', 11232, 'medium lev', 190);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (884947, 'rifle', 19493, 'low level', 162);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (690615, 'cannon', 14987, 'low level', 243);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (682873, 'tank', 9519, 'low level', 26);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (255970, 'tank', 4828, 'medium lev', 50);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (79886, 'rifle', 9119, 'medium lev', 431);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (975284, 'ship', 16960, 'high level', 428);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (209296, 'ship', 5141, 'medium lev', 466);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (109437, 'cannon', 2109, 'medium lev', 199);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (262342, 'ship', 18409, 'low level', 85);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (112814, 'cannon', 13272, 'low level', 49);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (207290, 'plane', 10690, 'low level', 105);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (260767, 'rifle', 12807, 'medium lev', 317);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (373468, 'rifle', 4762, 'high level', 268);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (994148, 'cannon', 11181, 'medium lev', 259);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (414278, 'cannon', 9593, 'low level', 282);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (224902, 'cannon', 14383, 'high level', 313);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (582189, 'gun', 12127, 'low level', 121);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50876, 'ship', 19052, 'medium lev', 141);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66049, 'ship', 5869, 'medium lev', 338);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (649205, 'rifle', 15039, 'low level', 139);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (169421, 'plane', 597, 'low level', 479);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (618712, 'ship', 5589, 'high level', 167);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (660379, 'rifle', 13435, 'high level', 112);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (284832, 'gun', 16908, 'high level', 223);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (510914, 'plane', 5345, 'high level', 382);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (528487, 'tank', 12840, 'medium lev', 260);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (780205, 'plane', 15194, 'low level', 67);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (115335, 'cannon', 17849, 'low level', 29);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (393114, 'ship', 2043, 'medium lev', 159);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (346572, 'gun', 13903, 'low level', 303);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (335751, 'cannon', 11602, 'low level', 325);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (689363, 'tank', 15302, 'medium lev', 404);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (146399, 'tank', 988, 'low level', 438);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (936584, 'rifle', 11279, 'high level', 40);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (834983, 'gun', 3387, 'low level', 62);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (954344, 'tank', 625, 'medium lev', 478);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (330081, 'rifle', 17102, 'high level', 82);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (264251, 'rifle', 16807, 'high level', 482);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (541741, 'rifle', 18127, 'low level', 294);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (138010, 'tank', 17367, 'high level', 14);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (953533, 'tank', 7987, 'low level', 171);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (617334, 'plane', 19123, 'low level', 497);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (630957, 'gun', 15346, 'high level', 264);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (474663, 'rifle', 1883, 'medium lev', 242);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (467826, 'tank', 17258, 'medium lev', 259);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (662436, 'plane', 9565, 'medium lev', 446);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (700313, 'plane', 9852, 'low level', 205);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (823026, 'rifle', 9776, 'low level', 314);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (12253, 'tank', 5292, 'high level', 292);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10624, 'cannon', 2487, 'high level', 311);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (247714, 'rifle', 17972, 'high level', 430);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (472579, 'cannon', 16560, 'medium lev', 158);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (650110, 'cannon', 14627, 'medium lev', 160);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (213706, 'gun', 10891, 'high level', 406);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (973971, 'ship', 16389, 'low level', 291);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (685255, 'rifle', 6001, 'low level', 129);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (578099, 'plane', 2158, 'high level', 13);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (363043, 'rifle', 3338, 'low level', 381);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (20031, 'gun', 8262, 'high level', 191);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (769341, 'ship', 4578, 'high level', 485);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (543756, 'rifle', 15356, 'high level', 84);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (712779, 'cannon', 13063, 'low level', 360);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (498181, 'rifle', 16328, 'medium lev', 459);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (732502, 'cannon', 5488, 'high level', 329);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (955251, 'cannon', 14661, 'medium lev', 371);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (999364, 'ship', 15234, 'high level', 163);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (926544, 'cannon', 7645, 'high level', 6);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (810769, 'tank', 10645, 'high level', 290);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (417943, 'plane', 9268, 'high level', 193);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (379232, 'tank', 13294, 'high level', 205);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (426291, 'ship', 19706, 'high level', 329);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (420384, 'plane', 4095, 'high level', 354);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (682082, 'gun', 18471, 'low level', 213);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (156529, 'plane', 319, 'high level', 291);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (790918, 'rifle', 2563, 'medium lev', 33);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (329368, 'gun', 15310, 'medium lev', 352);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (236002, 'plane', 15763, 'medium lev', 195);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (722746, 'ship', 6343, 'high level', 119);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (786958, 'ship', 16706, 'low level', 180);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (95694, 'ship', 15764, 'medium lev', 261);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29206, 'rifle', 17879, 'medium lev', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (380141, 'gun', 7565, 'high level', 481);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (295526, 'gun', 11312, 'medium lev', 399);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68934, 'ship', 17267, 'low level', 102);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59713, 'gun', 5965, 'low level', 191);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (970835, 'tank', 18393, 'medium lev', 227);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (154059, 'ship', 12630, 'medium lev', 300);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (502258, 'ship', 5454, 'high level', 304);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (810023, 'ship', 11068, 'low level', 283);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (483435, 'rifle', 12262, 'high level', 210);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (807616, 'gun', 17124, 'high level', 382);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (571663, 'plane', 6910, 'medium lev', 97);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (766105, 'plane', 1123, 'medium lev', 169);
commit;
prompt 600 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59081, 'tank', 2154, 'low level', 51);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (129128, 'plane', 9102, 'low level', 240);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (349295, 'cannon', 13314, 'low level', 46);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (503761, 'gun', 11639, 'low level', 294);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68774, 'cannon', 16763, 'high level', 180);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (17978, 'ship', 7505, 'low level', 491);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (27760, 'plane', 11142, 'high level', 24);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (76747, 'plane', 7257, 'medium lev', 163);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (183872, 'cannon', 13243, 'medium lev', 239);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (636264, 'tank', 11533, 'high level', 482);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (942276, 'gun', 10153, 'low level', 7);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (691032, 'tank', 6381, 'low level', 414);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (611628, 'tank', 12475, 'low level', 64);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (392130, 'plane', 19821, 'medium lev', 460);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (187553, 'plane', 9421, 'low level', 230);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (899554, 'plane', 6057, 'high level', 63);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (917632, 'cannon', 7793, 'low level', 76);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (29559, 'plane', 2827, 'medium lev', 3);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (876284, 'tank', 4032, 'high level', 334);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (801872, 'ship', 9297, 'low level', 262);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (107057, 'plane', 3100, 'high level', 36);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (433973, 'rifle', 13134, 'medium lev', 146);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (336097, 'rifle', 1072, 'low level', 292);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (983070, 'plane', 2031, 'medium lev', 84);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (886556, 'gun', 1323, 'low level', 275);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (13024, 'rifle', 3349, 'high level', 256);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (791874, 'ship', 18285, 'medium lev', 8);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (176290, 'ship', 11876, 'high level', 444);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (278701, 'plane', 9131, 'medium lev', 72);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (761976, 'rifle', 6287, 'medium lev', 333);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (330284, 'tank', 3838, 'low level', 109);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (883280, 'cannon', 5905, 'low level', 389);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10845, 'plane', 8859, 'low level', 52);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (373003, 'plane', 17130, 'medium lev', 47);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (193430, 'tank', 649, 'low level', 84);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (437317, 'ship', 9617, 'low level', 139);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (350260, 'tank', 13588, 'medium lev', 42);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (997840, 'tank', 2240, 'medium lev', 438);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (698458, 'plane', 3687, 'medium lev', 35);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (242896, 'plane', 14271, 'high level', 367);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (307445, 'rifle', 6291, 'low level', 480);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (523097, 'ship', 4330, 'low level', 327);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (330028, 'rifle', 3711, 'high level', 455);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (176548, 'ship', 4802, 'low level', 326);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (379478, 'cannon', 9015, 'medium lev', 83);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (467674, 'gun', 18659, 'low level', 133);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (802514, 'cannon', 15866, 'high level', 33);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (383162, 'plane', 5482, 'medium lev', 76);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (255272, 'tank', 13002, 'high level', 121);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (861591, 'plane', 19953, 'high level', 384);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (138792, 'tank', 16580, 'low level', 157);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (952196, 'plane', 5522, 'low level', 176);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (154630, 'gun', 5722, 'low level', 244);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (715666, 'cannon', 4743, 'high level', 363);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (62519, 'ship', 17203, 'high level', 371);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (208142, 'gun', 11808, 'high level', 329);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (722955, 'rifle', 15727, 'high level', 451);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (941369, 'tank', 18797, 'medium lev', 442);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (250755, 'ship', 7818, 'high level', 196);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (599630, 'rifle', 946, 'low level', 98);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (653506, 'cannon', 1276, 'medium lev', 424);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (830255, 'ship', 4324, 'low level', 276);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (243814, 'plane', 9666, 'medium lev', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (421525, 'ship', 7824, 'low level', 445);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (459064, 'rifle', 13673, 'low level', 49);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (452340, 'tank', 6677, 'high level', 173);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59218, 'plane', 19623, 'low level', 413);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (854428, 'gun', 12849, 'low level', 441);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (64890, 'ship', 11242, 'high level', 85);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (582799, 'plane', 5190, 'medium lev', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (806625, 'gun', 15164, 'high level', 500);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (55916, 'plane', 15071, 'low level', 158);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (144848, 'rifle', 4887, 'medium lev', 83);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16358, 'rifle', 17881, 'high level', 106);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (850610, 'cannon', 13255, 'medium lev', 374);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (287924, 'cannon', 3379, 'medium lev', 352);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (372557, 'plane', 1176, 'medium lev', 245);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (378755, 'gun', 14679, 'medium lev', 180);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (318172, 'plane', 1604, 'medium lev', 485);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (314637, 'plane', 2941, 'medium lev', 174);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (9471, 'rifle', 13873, 'high level', 70);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (794648, 'plane', 18879, 'high level', 446);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (997845, 'rifle', 5720, 'low level', 300);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (555253, 'ship', 19091, 'low level', 290);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (501742, 'gun', 19872, 'low level', 254);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (21342, 'ship', 1508, 'high level', 30);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (927280, 'rifle', 197, 'low level', 299);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (726021, 'ship', 5838, 'medium lev', 389);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7742, 'cannon', 456, 'high level', 414);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (907720, 'cannon', 18286, 'medium lev', 304);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (216184, 'tank', 17695, 'high level', 18);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (955897, 'gun', 11207, 'high level', 200);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (28134, 'cannon', 13842, 'medium lev', 357);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (287721, 'rifle', 3869, 'low level', 483);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (901486, 'tank', 14009, 'high level', 166);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (610212, 'cannon', 16566, 'low level', 266);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (560351, 'rifle', 9905, 'medium lev', 233);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (667797, 'plane', 3073, 'low level', 323);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (881597, 'gun', 12711, 'low level', 452);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (306731, 'ship', 12153, 'low level', 336);
commit;
prompt 700 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (449360, 'gun', 3073, 'low level', 25);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (317659, 'plane', 3753, 'medium lev', 355);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (226652, 'gun', 17766, 'high level', 415);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (858458, 'cannon', 15984, 'medium lev', 364);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (856604, 'rifle', 4292, 'low level', 463);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (623737, 'rifle', 1029, 'medium lev', 220);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (411612, 'tank', 7579, 'low level', 138);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (127577, 'gun', 8321, 'low level', 247);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (18965, 'tank', 18011, 'medium lev', 82);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (814706, 'ship', 7547, 'high level', 266);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (269072, 'ship', 8910, 'low level', 383);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24909, 'tank', 18902, 'medium lev', 23);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (719658, 'gun', 15121, 'low level', 243);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (418452, 'rifle', 9468, 'low level', 229);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (708689, 'ship', 14077, 'high level', 279);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (139241, 'tank', 9101, 'low level', 416);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (142899, 'plane', 17801, 'low level', 101);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59866, 'cannon', 12861, 'low level', 416);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (500078, 'cannon', 9908, 'medium lev', 358);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (730920, 'rifle', 16230, 'low level', 208);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (34252, 'cannon', 17181, 'low level', 81);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (458830, 'gun', 10195, 'high level', 452);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (666066, 'tank', 11869, 'high level', 319);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (74069, 'rifle', 12148, 'medium lev', 56);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (338502, 'plane', 9785, 'low level', 92);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (737770, 'gun', 1618, 'low level', 265);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (283157, 'gun', 1797, 'medium lev', 51);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (381835, 'rifle', 13377, 'low level', 7);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (736949, 'cannon', 3674, 'high level', 305);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (398159, 'cannon', 10712, 'medium lev', 117);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (736126, 'rifle', 12695, 'medium lev', 63);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (798987, 'tank', 4909, 'low level', 62);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (755989, 'cannon', 10242, 'low level', 461);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (575343, 'tank', 19394, 'medium lev', 113);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (723555, 'rifle', 8999, 'low level', 97);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (196297, 'tank', 4897, 'medium lev', 291);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (368859, 'gun', 2580, 'low level', 290);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (431049, 'ship', 11683, 'low level', 236);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (561254, 'tank', 15794, 'medium lev', 315);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (751048, 'cannon', 2398, 'low level', 119);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (262427, 'ship', 6379, 'medium lev', 258);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (792982, 'ship', 992, 'medium lev', 96);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (580386, 'gun', 15368, 'medium lev', 91);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (548038, 'tank', 5381, 'low level', 17);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (190884, 'cannon', 14271, 'medium lev', 470);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (400850, 'cannon', 643, 'medium lev', 183);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (667200, 'tank', 14577, 'low level', 53);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (685485, 'rifle', 1215, 'low level', 467);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88233, 'plane', 19577, 'high level', 201);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (368223, 'rifle', 2294, 'high level', 81);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (241244, 'rifle', 11496, 'medium lev', 151);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (620176, 'tank', 16653, 'high level', 203);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (861447, 'rifle', 10379, 'medium lev', 128);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (719578, 'tank', 11961, 'medium lev', 161);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (218929, 'cannon', 14604, 'high level', 140);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (736254, 'gun', 9821, 'high level', 324);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (36147, 'plane', 9874, 'low level', 487);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (111917, 'cannon', 18333, 'medium lev', 470);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (759313, 'rifle', 13273, 'medium lev', 19);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (372014, 'gun', 11068, 'high level', 49);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (676724, 'rifle', 13916, 'medium lev', 474);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (100335, 'tank', 13046, 'high level', 89);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (838993, 'ship', 2667, 'low level', 56);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (789080, 'rifle', 15063, 'low level', 458);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (252719, 'ship', 1719, 'high level', 377);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (556900, 'ship', 7634, 'low level', 411);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (952972, 'rifle', 11686, 'high level', 184);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (818337, 'tank', 11262, 'medium lev', 219);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (373387, 'rifle', 637, 'low level', 494);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (102234, 'tank', 16813, 'low level', 387);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (488378, 'tank', 7319, 'high level', 167);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (167003, 'plane', 4945, 'low level', 425);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (562295, 'rifle', 10959, 'low level', 70);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (659163, 'ship', 2805, 'medium lev', 414);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (567909, 'rifle', 13875, 'medium lev', 46);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (621205, 'gun', 6001, 'low level', 274);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (493830, 'plane', 1664, 'high level', 88);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (487813, 'cannon', 391, 'medium lev', 176);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (409875, 'gun', 10499, 'low level', 30);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (628431, 'rifle', 7657, 'high level', 459);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (363502, 'cannon', 13077, 'medium lev', 352);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (311525, 'rifle', 7364, 'low level', 371);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (501728, 'plane', 15439, 'low level', 100);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (994255, 'cannon', 2338, 'low level', 269);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (313907, 'tank', 7344, 'low level', 488);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (392966, 'tank', 10087, 'medium lev', 369);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (133930, 'gun', 10478, 'high level', 217);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (677679, 'plane', 6840, 'medium lev', 12);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (88231, 'tank', 12691, 'high level', 28);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (669810, 'ship', 18832, 'low level', 487);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (91059, 'tank', 3990, 'low level', 166);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (919496, 'gun', 14011, 'medium lev', 499);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (333167, 'rifle', 12374, 'medium lev', 455);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (309360, 'ship', 12594, 'low level', 187);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (547009, 'cannon', 16036, 'medium lev', 183);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (188021, 'ship', 13116, 'low level', 465);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (223121, 'plane', 14291, 'medium lev', 138);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (291507, 'cannon', 18064, 'high level', 118);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (461167, 'ship', 13957, 'high level', 134);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (676602, 'tank', 6091, 'low level', 407);
commit;
prompt 800 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (327585, 'plane', 2162, 'medium lev', 260);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (879358, 'gun', 12451, 'low level', 68);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (22452, 'ship', 11890, 'high level', 155);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (337236, 'tank', 11857, 'low level', 477);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (893544, 'cannon', 14237, 'high level', 449);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (86956, 'tank', 4837, 'high level', 3);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (938063, 'gun', 12643, 'medium lev', 254);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (684717, 'cannon', 15886, 'low level', 142);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (964800, 'gun', 451, 'medium lev', 441);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (503439, 'plane', 15759, 'high level', 486);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (613841, 'plane', 15377, 'medium lev', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (855653, 'gun', 7214, 'low level', 7);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (10087, 'tank', 13994, 'low level', 237);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (83011, 'tank', 19691, 'high level', 423);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (523108, 'rifle', 17525, 'high level', 449);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (656745, 'plane', 10080, 'medium lev', 278);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (981848, 'tank', 18182, 'high level', 350);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (760124, 'tank', 136, 'high level', 178);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (310850, 'plane', 4382, 'medium lev', 481);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (586699, 'tank', 2384, 'high level', 482);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (977544, 'ship', 14629, 'medium lev', 338);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (999214, 'tank', 12001, 'medium lev', 245);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (430131, 'tank', 4814, 'low level', 159);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66147, 'cannon', 18141, 'high level', 193);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (925395, 'plane', 3607, 'high level', 472);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (638393, 'ship', 10934, 'high level', 274);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (357610, 'ship', 16518, 'high level', 143);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (359948, 'gun', 16138, 'low level', 125);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (966390, 'ship', 12554, 'high level', 491);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (636463, 'rifle', 14331, 'low level', 388);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (685032, 'tank', 9258, 'low level', 225);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (926245, 'tank', 1961, 'medium lev', 90);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (454475, 'cannon', 13666, 'medium lev', 33);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (582612, 'plane', 3692, 'medium lev', 338);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (633569, 'plane', 19553, 'low level', 431);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (176663, 'ship', 15593, 'low level', 434);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (746773, 'gun', 16513, 'high level', 457);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (78193, 'plane', 3005, 'high level', 186);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (787893, 'ship', 15194, 'high level', 294);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (882009, 'rifle', 1761, 'medium lev', 192);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (205720, 'ship', 6598, 'high level', 383);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (349949, 'cannon', 12857, 'medium lev', 310);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96844, 'ship', 13095, 'low level', 440);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (707849, 'gun', 5234, 'low level', 331);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (84994, 'ship', 5829, 'medium lev', 420);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (704043, 'rifle', 4953, 'medium lev', 163);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (437586, 'plane', 18856, 'low level', 259);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (614360, 'rifle', 18237, 'medium lev', 79);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (221099, 'rifle', 15808, 'medium lev', 163);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (680302, 'cannon', 6735, 'high level', 355);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (290093, 'rifle', 1517, 'low level', 60);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (104794, 'tank', 12192, 'medium lev', 447);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (702497, 'rifle', 9896, 'high level', 170);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (16022, 'tank', 10788, 'medium lev', 210);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (318886, 'rifle', 1926, 'low level', 234);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (556967, 'cannon', 10956, 'high level', 190);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (938148, 'ship', 4985, 'medium lev', 257);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (778717, 'gun', 8709, 'low level', 126);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (908860, 'ship', 18143, 'medium lev', 81);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (122119, 'cannon', 7759, 'low level', 82);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (797344, 'ship', 8916, 'medium lev', 68);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (277192, 'plane', 14150, 'high level', 168);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (952080, 'gun', 16347, 'medium lev', 54);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (925542, 'ship', 13010, 'high level', 480);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (742705, 'plane', 4472, 'medium lev', 16);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (610310, 'plane', 4696, 'high level', 421);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (432445, 'ship', 665, 'high level', 345);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (553327, 'tank', 5173, 'low level', 312);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (128208, 'rifle', 15900, 'low level', 289);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (962830, 'ship', 17288, 'high level', 324);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (605069, 'cannon', 364, 'low level', 311);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59635, 'gun', 1906, 'high level', 224);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (84147, 'gun', 8880, 'low level', 274);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (7689, 'tank', 16861, 'medium lev', 254);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (817261, 'rifle', 17839, 'medium lev', 412);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (978843, 'cannon', 13630, 'low level', 249);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (660857, 'ship', 19901, 'medium lev', 349);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (24106, 'rifle', 2896, 'high level', 307);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (267988, 'cannon', 5843, 'low level', 415);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (76938, 'plane', 6727, 'high level', 495);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (153124, 'gun', 15954, 'low level', 134);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (590880, 'ship', 3573, 'low level', 331);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (252689, 'cannon', 7401, 'high level', 274);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (826568, 'rifle', 8565, 'low level', 469);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (777129, 'rifle', 10510, 'medium lev', 412);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (964256, 'cannon', 12200, 'medium lev', 387);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (690309, 'gun', 16817, 'low level', 200);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (840074, 'rifle', 11517, 'low level', 280);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (121792, 'tank', 6693, 'low level', 49);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (499742, 'plane', 5624, 'high level', 434);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (979443, 'tank', 5255, 'low level', 87);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (744923, 'cannon', 18173, 'high level', 83);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (46427, 'ship', 3602, 'low level', 384);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (727244, 'tank', 9294, 'medium lev', 191);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (480450, 'rifle', 19292, 'low level', 41);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (235893, 'gun', 14937, 'high level', 263);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (946547, 'ship', 6718, 'high level', 169);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (938894, 'tank', 18681, 'high level', 204);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (170425, 'rifle', 5900, 'medium lev', 441);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (288393, 'ship', 6181, 'medium lev', 473);
commit;
prompt 900 records committed...
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (559702, 'gun', 8324, 'high level', 274);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (398946, 'ship', 11724, 'high level', 317);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (267889, 'ship', 2301, 'medium lev', 22);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (767282, 'tank', 6163, 'high level', 264);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (733258, 'gun', 8887, 'low level', 482);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (535132, 'tank', 12004, 'medium lev', 341);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (874089, 'tank', 14109, 'low level', 163);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (915583, 'tank', 10875, 'low level', 184);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (825930, 'ship', 15335, 'medium lev', 353);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (720816, 'rifle', 7326, 'medium lev', 357);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (927769, 'rifle', 10216, 'medium lev', 121);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (457445, 'plane', 17033, 'medium lev', 328);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (665008, 'ship', 17161, 'medium lev', 227);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (507360, 'ship', 13401, 'high level', 201);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (20294, 'cannon', 7858, 'high level', 141);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (299750, 'rifle', 369, 'medium lev', 464);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (231102, 'gun', 6302, 'high level', 83);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (416057, 'gun', 17311, 'low level', 321);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (868007, 'cannon', 6290, 'high level', 433);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (66711, 'plane', 10445, 'high level', 474);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (492320, 'tank', 11725, 'high level', 96);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (649002, 'gun', 445, 'medium lev', 301);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (488671, 'cannon', 12511, 'high level', 194);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (951867, 'gun', 4134, 'medium lev', 473);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (59711, 'tank', 4645, 'high level', 334);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (328294, 'rifle', 5601, 'low level', 481);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (378909, 'gun', 7475, 'high level', 425);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (621827, 'tank', 5006, 'medium lev', 105);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (585898, 'rifle', 15351, 'medium lev', 210);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (122927, 'ship', 17931, 'medium lev', 240);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (239476, 'gun', 6240, 'medium lev', 460);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (156155, 'plane', 763, 'low level', 135);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (78729, 'rifle', 7522, 'medium lev', 372);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (372749, 'plane', 14417, 'medium lev', 105);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (45273, 'tank', 10466, 'low level', 217);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (257755, 'plane', 15934, 'high level', 65);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (551856, 'tank', 1020, 'low level', 383);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (68874, 'gun', 1585, 'low level', 9);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (506952, 'plane', 16717, 'low level', 325);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (218140, 'gun', 2006, 'medium lev', 158);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (684097, 'ship', 19074, 'high level', 146);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (299908, 'plane', 6111, 'low level', 106);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (221002, 'ship', 9010, 'high level', 400);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (371968, 'rifle', 12198, 'low level', 355);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (409458, 'gun', 784, 'low level', 163);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (23370, 'gun', 8033, 'medium lev', 222);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (55189, 'tank', 9031, 'medium lev', 374);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (25195, 'plane', 13032, 'medium lev', 200);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (609707, 'ship', 4918, 'low level', 336);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (271694, 'ship', 11253, 'low level', 97);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (566214, 'plane', 2464, 'low level', 382);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (91251, 'rifle', 9925, 'low level', 16);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (331347, 'gun', 15889, 'high level', 152);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (152156, 'rifle', 11003, 'low level', 247);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (496482, 'ship', 4877, 'medium lev', 384);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (919589, 'plane', 8960, 'high level', 202);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (198888, 'plane', 7893, 'high level', 197);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (250143, 'cannon', 2972, 'low level', 351);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (646845, 'rifle', 15593, 'medium lev', 264);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (50993, 'plane', 2044, 'low level', 148);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (946282, 'cannon', 8133, 'medium lev', 114);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (295102, 'tank', 3789, 'low level', 243);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (672191, 'cannon', 12983, 'high level', 337);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (884030, 'tank', 7629, 'medium lev', 365);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (238389, 'rifle', 5044, 'high level', 179);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (198569, 'gun', 17534, 'medium lev', 166);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (596767, 'plane', 9630, 'medium lev', 253);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (486987, 'gun', 4186, 'medium lev', 104);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (204372, 'tank', 12495, 'low level', 363);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (823637, 'tank', 7967, 'high level', 106);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (96100, 'tank', 10787, 'low level', 476);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (39716, 'gun', 18623, 'low level', 295);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (354864, 'ship', 5870, 'low level', 324);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (95244, 'ship', 1182, 'high level', 137);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (842394, 'ship', 4578, 'medium lev', 98);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (639722, 'plane', 16830, 'low level', 332);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (804812, 'gun', 10993, 'medium lev', 422);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (310664, 'plane', 8346, 'low level', 318);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (460278, 'tank', 17371, 'medium lev', 381);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (456884, 'tank', 8543, 'low level', 295);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (973855, 'cannon', 11814, 'low level', 456);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (759562, 'tank', 3225, 'low level', 338);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (889788, 'rifle', 12766, 'medium lev', 65);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (471189, 'plane', 3706, 'high level', 370);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (186114, 'rifle', 7805, 'low level', 480);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (12988, 'cannon', 14189, 'low level', 203);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (203435, 'tank', 17637, 'medium lev', 81);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (277849, 'tank', 2532, 'low level', 320);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (841278, 'ship', 17006, 'low level', 138);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (490714, 'tank', 15368, 'high level', 402);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (174272, 'ship', 3652, 'high level', 439);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (694170, 'rifle', 6438, 'medium lev', 7);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (78844, 'plane', 5637, 'high level', 116);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (166234, 'plane', 6666, 'medium lev', 94);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (141786, 'gun', 17737, 'low level', 203);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (152557, 'ship', 2047, 'high level', 83);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (107408, 'cannon', 10254, 'low level', 420);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (518863, 'plane', 17301, 'medium lev', 17);
insert into RESOURCES (resourceid, resourcename, quantity, resourcestype, unitid)
values (972542, 'plane', 19881, 'medium lev', 58);
commit;
prompt 999 records loaded
prompt Loading TASK...
insert into TASK (taskid, projectid, enddate, begindate, status)
values (1, 379, to_date('20-07-2023', 'dd-mm-yyyy'), to_date('15-04-2041', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (2, 444, to_date('30-11-2010', 'dd-mm-yyyy'), to_date('10-04-2064', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (3, 159, to_date('17-04-2024', 'dd-mm-yyyy'), to_date('25-11-2036', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (5, 266, to_date('25-05-2022', 'dd-mm-yyyy'), to_date('12-01-2034', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (8, 418, to_date('27-05-2005', 'dd-mm-yyyy'), to_date('10-12-2048', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (9, 6, to_date('05-06-2011', 'dd-mm-yyyy'), to_date('14-03-2033', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (10, 322, to_date('22-10-2020', 'dd-mm-yyyy'), to_date('30-06-2072', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (11, 226, to_date('06-04-2016', 'dd-mm-yyyy'), to_date('26-06-2070', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (13, 262, to_date('22-01-2020', 'dd-mm-yyyy'), to_date('06-10-2091', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (14, 349, to_date('28-02-2006', 'dd-mm-yyyy'), to_date('15-11-2059', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (15, 5, to_date('10-05-2008', 'dd-mm-yyyy'), to_date('21-06-2038', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (16, 344, to_date('14-04-2013', 'dd-mm-yyyy'), to_date('13-06-2029', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (17, 80, to_date('31-12-2005', 'dd-mm-yyyy'), to_date('30-05-2028', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (21, 443, to_date('25-09-2022', 'dd-mm-yyyy'), to_date('07-01-2090', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (22, 120, to_date('07-11-2021', 'dd-mm-yyyy'), to_date('02-08-2055', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (23, 116, to_date('29-03-2014', 'dd-mm-yyyy'), to_date('01-08-2052', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (25, 341, to_date('03-01-2023', 'dd-mm-yyyy'), to_date('25-09-2053', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (26, 396, to_date('02-01-2023', 'dd-mm-yyyy'), to_date('13-01-2057', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (29, 455, to_date('15-11-2013', 'dd-mm-yyyy'), to_date('22-04-2071', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (32, 329, to_date('21-07-2019', 'dd-mm-yyyy'), to_date('31-07-2041', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (33, 340, to_date('07-10-2008', 'dd-mm-yyyy'), to_date('21-08-2064', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (35, 208, to_date('08-10-2011', 'dd-mm-yyyy'), to_date('03-09-2031', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (36, 32, to_date('17-11-2009', 'dd-mm-yyyy'), to_date('01-11-2090', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (37, 22, to_date('03-01-2007', 'dd-mm-yyyy'), to_date('30-12-2077', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (39, 69, to_date('05-04-2011', 'dd-mm-yyyy'), to_date('16-11-2056', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (40, 66, to_date('11-07-2009', 'dd-mm-yyyy'), to_date('16-06-2051', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (41, 465, to_date('06-07-2006', 'dd-mm-yyyy'), to_date('29-09-2090', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (42, 417, to_date('28-03-2006', 'dd-mm-yyyy'), to_date('23-09-2040', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (43, 335, to_date('06-09-2022', 'dd-mm-yyyy'), to_date('02-02-2029', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (44, 6, to_date('02-08-2008', 'dd-mm-yyyy'), to_date('07-11-2098', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (45, 385, to_date('10-01-2010', 'dd-mm-yyyy'), to_date('27-11-2040', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (47, 18, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('15-12-2065', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (48, 15, to_date('09-03-2008', 'dd-mm-yyyy'), to_date('25-10-2068', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (49, 441, to_date('09-04-2021', 'dd-mm-yyyy'), to_date('05-01-2088', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (50, 281, to_date('16-03-2011', 'dd-mm-yyyy'), to_date('13-06-2037', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (52, 271, to_date('24-06-2006', 'dd-mm-yyyy'), to_date('02-12-2059', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (53, 363, to_date('06-04-2008', 'dd-mm-yyyy'), to_date('10-07-2085', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (55, 262, to_date('06-06-2005', 'dd-mm-yyyy'), to_date('14-01-2049', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (56, 492, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('24-05-2062', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (57, 224, to_date('14-08-2021', 'dd-mm-yyyy'), to_date('15-12-2036', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (58, 89, to_date('15-04-2015', 'dd-mm-yyyy'), to_date('21-08-2046', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (59, 409, to_date('29-11-2019', 'dd-mm-yyyy'), to_date('20-05-2059', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (63, 427, to_date('25-08-2019', 'dd-mm-yyyy'), to_date('06-02-2038', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (64, 407, to_date('12-02-2009', 'dd-mm-yyyy'), to_date('20-03-2033', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (65, 339, to_date('08-01-2013', 'dd-mm-yyyy'), to_date('04-11-2030', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (66, 499, to_date('21-06-2010', 'dd-mm-yyyy'), to_date('08-03-2036', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (67, 364, to_date('24-07-2023', 'dd-mm-yyyy'), to_date('18-02-2042', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (68, 371, to_date('04-03-2009', 'dd-mm-yyyy'), to_date('12-05-2083', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (70, 289, to_date('29-04-2012', 'dd-mm-yyyy'), to_date('16-04-2059', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (71, 161, to_date('30-05-2010', 'dd-mm-yyyy'), to_date('10-04-2091', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (73, 160, to_date('18-06-2010', 'dd-mm-yyyy'), to_date('27-02-2084', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (74, 229, to_date('10-10-2016', 'dd-mm-yyyy'), to_date('13-11-2093', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (75, 317, to_date('09-01-2011', 'dd-mm-yyyy'), to_date('26-06-2047', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (76, 434, to_date('13-01-2023', 'dd-mm-yyyy'), to_date('31-01-2090', 'dd-mm-yyyy'), 'end');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (77, 400, to_date('10-06-2007', 'dd-mm-yyyy'), to_date('14-09-2066', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (78, 351, to_date('13-07-2013', 'dd-mm-yyyy'), to_date('20-03-2089', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (80, 445, to_date('04-07-2020', 'dd-mm-yyyy'), to_date('20-03-2084', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (81, 102, to_date('12-10-2016', 'dd-mm-yyyy'), to_date('15-07-2065', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (82, 262, to_date('21-02-2018', 'dd-mm-yyyy'), to_date('30-10-2058', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (83, 388, to_date('13-12-2007', 'dd-mm-yyyy'), to_date('11-10-2063', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (84, 56, to_date('22-05-2020', 'dd-mm-yyyy'), to_date('18-07-2096', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (85, 68, to_date('04-12-2009', 'dd-mm-yyyy'), to_date('03-06-2063', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (86, 210, to_date('13-05-2008', 'dd-mm-yyyy'), to_date('28-12-2036', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (88, 468, to_date('22-11-2005', 'dd-mm-yyyy'), to_date('26-05-2084', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (89, 289, to_date('28-08-2015', 'dd-mm-yyyy'), to_date('18-01-2037', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (90, 148, to_date('04-04-2008', 'dd-mm-yyyy'), to_date('08-02-2041', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (91, 259, to_date('16-10-2014', 'dd-mm-yyyy'), to_date('30-05-2049', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (92, 416, to_date('02-01-2008', 'dd-mm-yyyy'), to_date('26-04-2051', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (94, 39, to_date('25-02-2012', 'dd-mm-yyyy'), to_date('04-10-2052', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (95, 317, to_date('10-07-2010', 'dd-mm-yyyy'), to_date('27-04-2040', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (96, 159, to_date('18-05-2018', 'dd-mm-yyyy'), to_date('11-08-2075', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (98, 145, to_date('26-10-2005', 'dd-mm-yyyy'), to_date('20-02-2085', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (99, 395, to_date('10-05-2012', 'dd-mm-yyyy'), to_date('23-09-2098', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (100, 26, to_date('08-01-2024', 'dd-mm-yyyy'), to_date('10-04-2083', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (101, 410, to_date('23-09-2017', 'dd-mm-yyyy'), to_date('24-11-2085', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (102, 437, to_date('18-04-2024', 'dd-mm-yyyy'), to_date('25-09-2095', 'dd-mm-yyyy'), 'end');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (104, 449, to_date('08-03-2022', 'dd-mm-yyyy'), to_date('27-08-2084', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (106, 388, to_date('25-12-2014', 'dd-mm-yyyy'), to_date('12-06-2051', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (108, 34, to_date('31-12-2006', 'dd-mm-yyyy'), to_date('22-06-2050', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (109, 232, to_date('11-03-2024', 'dd-mm-yyyy'), to_date('26-10-2085', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (110, 77, to_date('15-12-2017', 'dd-mm-yyyy'), to_date('16-07-2046', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (111, 342, to_date('03-04-2021', 'dd-mm-yyyy'), to_date('08-11-2030', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (114, 276, to_date('22-10-2006', 'dd-mm-yyyy'), to_date('12-05-2079', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (115, 455, to_date('30-09-2007', 'dd-mm-yyyy'), to_date('28-12-2042', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (116, 208, to_date('27-01-2015', 'dd-mm-yyyy'), to_date('22-07-2083', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (117, 154, to_date('04-08-2014', 'dd-mm-yyyy'), to_date('26-11-2037', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (118, 78, to_date('22-07-2013', 'dd-mm-yyyy'), to_date('28-05-2051', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (120, 50, to_date('06-02-2012', 'dd-mm-yyyy'), to_date('22-12-2063', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (121, 196, to_date('23-01-2021', 'dd-mm-yyyy'), to_date('25-07-2028', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (122, 439, to_date('15-11-2015', 'dd-mm-yyyy'), to_date('21-01-2099', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (123, 413, to_date('18-03-2023', 'dd-mm-yyyy'), to_date('18-04-2097', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (126, 54, to_date('07-09-2020', 'dd-mm-yyyy'), to_date('28-07-2057', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (127, 379, to_date('04-01-2013', 'dd-mm-yyyy'), to_date('10-09-2061', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (128, 294, to_date('24-08-2023', 'dd-mm-yyyy'), to_date('05-04-2097', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (131, 316, to_date('26-01-2018', 'dd-mm-yyyy'), to_date('17-12-2026', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (133, 229, to_date('01-03-2014', 'dd-mm-yyyy'), to_date('06-02-2082', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (134, 444, to_date('23-08-2008', 'dd-mm-yyyy'), to_date('17-02-2055', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (137, 441, to_date('03-10-2006', 'dd-mm-yyyy'), to_date('11-05-2055', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (138, 319, to_date('26-07-2017', 'dd-mm-yyyy'), to_date('20-03-2031', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (139, 100, to_date('05-04-2015', 'dd-mm-yyyy'), to_date('21-05-2081', 'dd-mm-yyyy'), 'new');
commit;
prompt 100 records committed...
insert into TASK (taskid, projectid, enddate, begindate, status)
values (140, 350, to_date('08-12-2014', 'dd-mm-yyyy'), to_date('27-03-2034', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (141, 291, to_date('26-10-2005', 'dd-mm-yyyy'), to_date('31-05-2026', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (142, 358, to_date('17-05-2015', 'dd-mm-yyyy'), to_date('11-05-2072', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (143, 296, to_date('18-10-2010', 'dd-mm-yyyy'), to_date('10-10-2038', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (145, 331, to_date('20-07-2023', 'dd-mm-yyyy'), to_date('13-03-2035', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (146, 324, to_date('31-01-2013', 'dd-mm-yyyy'), to_date('09-04-2081', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (148, 357, to_date('19-10-2022', 'dd-mm-yyyy'), to_date('12-08-2026', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (149, 298, to_date('01-08-2005', 'dd-mm-yyyy'), to_date('18-03-2059', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (150, 107, to_date('09-07-2007', 'dd-mm-yyyy'), to_date('29-03-2026', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (153, 450, to_date('23-12-2017', 'dd-mm-yyyy'), to_date('18-11-2033', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (154, 481, to_date('17-07-2016', 'dd-mm-yyyy'), to_date('03-07-2057', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (155, 152, to_date('10-01-2010', 'dd-mm-yyyy'), to_date('08-06-2060', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (156, 234, to_date('05-11-2013', 'dd-mm-yyyy'), to_date('12-05-2079', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (157, 107, to_date('16-07-2017', 'dd-mm-yyyy'), to_date('23-01-2082', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (159, 90, to_date('15-05-2006', 'dd-mm-yyyy'), to_date('23-11-2058', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (160, 151, to_date('17-08-2010', 'dd-mm-yyyy'), to_date('12-10-2028', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (161, 324, to_date('13-02-2009', 'dd-mm-yyyy'), to_date('04-10-2040', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (164, 197, to_date('02-02-2024', 'dd-mm-yyyy'), to_date('08-02-2057', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (166, 264, to_date('26-01-2016', 'dd-mm-yyyy'), to_date('26-02-2027', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (167, 276, to_date('07-01-2007', 'dd-mm-yyyy'), to_date('29-04-2082', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (168, 387, to_date('02-03-2024', 'dd-mm-yyyy'), to_date('10-01-2071', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (171, 176, to_date('27-12-2015', 'dd-mm-yyyy'), to_date('07-08-2029', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (173, 453, to_date('28-12-2014', 'dd-mm-yyyy'), to_date('16-04-2068', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (174, 319, to_date('12-08-2020', 'dd-mm-yyyy'), to_date('07-06-2077', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (175, 156, to_date('05-03-2007', 'dd-mm-yyyy'), to_date('30-07-2032', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (177, 52, to_date('26-07-2010', 'dd-mm-yyyy'), to_date('05-03-2031', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (178, 191, to_date('16-01-2016', 'dd-mm-yyyy'), to_date('24-02-2097', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (179, 450, to_date('28-11-2010', 'dd-mm-yyyy'), to_date('10-10-2065', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (181, 434, to_date('20-09-2008', 'dd-mm-yyyy'), to_date('23-02-2073', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (182, 182, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('17-10-2082', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (184, 110, to_date('16-07-2012', 'dd-mm-yyyy'), to_date('12-08-2075', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (185, 227, to_date('27-05-2022', 'dd-mm-yyyy'), to_date('23-05-2088', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (186, 492, to_date('18-11-2008', 'dd-mm-yyyy'), to_date('08-04-2029', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (187, 20, to_date('05-04-2022', 'dd-mm-yyyy'), to_date('19-05-2029', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (188, 344, to_date('26-03-2019', 'dd-mm-yyyy'), to_date('18-05-2065', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (189, 10, to_date('31-12-2022', 'dd-mm-yyyy'), to_date('18-06-2067', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (192, 290, to_date('10-08-2023', 'dd-mm-yyyy'), to_date('26-03-2030', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (193, 66, to_date('05-03-2024', 'dd-mm-yyyy'), to_date('29-11-2025', 'dd-mm-yyyy'), 'end');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (194, 179, to_date('25-01-2022', 'dd-mm-yyyy'), to_date('18-03-2039', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (196, 362, to_date('13-07-2007', 'dd-mm-yyyy'), to_date('14-01-2098', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (197, 457, to_date('16-02-2022', 'dd-mm-yyyy'), to_date('28-03-2025', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (199, 358, to_date('28-10-2021', 'dd-mm-yyyy'), to_date('25-09-2034', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (200, 461, to_date('22-05-2013', 'dd-mm-yyyy'), to_date('29-03-2040', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (202, 195, to_date('21-07-2018', 'dd-mm-yyyy'), to_date('19-06-2028', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (206, 271, to_date('02-10-2023', 'dd-mm-yyyy'), to_date('22-12-2045', 'dd-mm-yyyy'), 'end');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (209, 154, to_date('13-12-2019', 'dd-mm-yyyy'), to_date('09-11-2079', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (210, 353, to_date('20-07-2021', 'dd-mm-yyyy'), to_date('13-01-2088', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (211, 347, to_date('30-07-2021', 'dd-mm-yyyy'), to_date('03-08-2073', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (212, 477, to_date('25-11-2005', 'dd-mm-yyyy'), to_date('13-12-2073', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (213, 130, to_date('20-04-2013', 'dd-mm-yyyy'), to_date('13-07-2033', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (215, 121, to_date('27-08-2016', 'dd-mm-yyyy'), to_date('18-01-2081', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (216, 23, to_date('19-05-2015', 'dd-mm-yyyy'), to_date('21-08-2079', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (217, 220, to_date('22-01-2018', 'dd-mm-yyyy'), to_date('09-11-2080', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (218, 66, to_date('24-06-2018', 'dd-mm-yyyy'), to_date('24-05-2077', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (220, 384, to_date('21-03-2009', 'dd-mm-yyyy'), to_date('01-10-2043', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (221, 402, to_date('05-01-2011', 'dd-mm-yyyy'), to_date('01-03-2080', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (224, 59, to_date('18-10-2005', 'dd-mm-yyyy'), to_date('03-03-2040', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (225, 164, to_date('16-08-2011', 'dd-mm-yyyy'), to_date('01-09-2042', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (227, 97, to_date('27-01-2019', 'dd-mm-yyyy'), to_date('24-12-2036', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (229, 209, to_date('14-07-2015', 'dd-mm-yyyy'), to_date('18-05-2045', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (230, 491, to_date('26-10-2010', 'dd-mm-yyyy'), to_date('08-08-2057', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (231, 23, to_date('21-02-2011', 'dd-mm-yyyy'), to_date('17-09-2071', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (233, 29, to_date('22-06-2006', 'dd-mm-yyyy'), to_date('31-05-2064', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (234, 68, to_date('15-02-2010', 'dd-mm-yyyy'), to_date('08-04-2072', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (236, 154, to_date('13-08-2021', 'dd-mm-yyyy'), to_date('07-08-2096', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (237, 79, to_date('31-10-2017', 'dd-mm-yyyy'), to_date('08-08-2049', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (238, 63, to_date('19-10-2019', 'dd-mm-yyyy'), to_date('17-10-2060', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (239, 55, to_date('30-10-2015', 'dd-mm-yyyy'), to_date('27-04-2081', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (240, 469, to_date('10-10-2010', 'dd-mm-yyyy'), to_date('14-01-2025', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (242, 166, to_date('04-11-2023', 'dd-mm-yyyy'), to_date('22-09-2027', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (244, 421, to_date('06-06-2018', 'dd-mm-yyyy'), to_date('25-08-2095', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (245, 270, to_date('25-06-2010', 'dd-mm-yyyy'), to_date('11-06-2080', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (248, 180, to_date('29-06-2016', 'dd-mm-yyyy'), to_date('12-12-2057', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (249, 438, to_date('04-09-2011', 'dd-mm-yyyy'), to_date('24-12-2086', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (250, 183, to_date('24-03-2017', 'dd-mm-yyyy'), to_date('18-05-2030', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (251, 165, to_date('12-07-2009', 'dd-mm-yyyy'), to_date('18-05-2099', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (252, 405, to_date('01-06-2016', 'dd-mm-yyyy'), to_date('11-07-2044', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (253, 43, to_date('20-12-2019', 'dd-mm-yyyy'), to_date('13-09-2048', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (254, 71, to_date('26-11-2010', 'dd-mm-yyyy'), to_date('16-12-2033', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (256, 268, to_date('17-04-2019', 'dd-mm-yyyy'), to_date('31-12-2058', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (257, 35, to_date('02-12-2021', 'dd-mm-yyyy'), to_date('11-04-2085', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (258, 57, to_date('17-03-2017', 'dd-mm-yyyy'), to_date('22-06-2094', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (259, 344, to_date('07-10-2008', 'dd-mm-yyyy'), to_date('14-02-2050', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (260, 410, to_date('07-12-2021', 'dd-mm-yyyy'), to_date('28-04-2044', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (261, 84, to_date('19-04-2023', 'dd-mm-yyyy'), to_date('26-11-2045', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (262, 419, to_date('03-03-2023', 'dd-mm-yyyy'), to_date('22-03-2072', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (263, 192, to_date('31-12-2014', 'dd-mm-yyyy'), to_date('25-02-2052', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (264, 258, to_date('15-11-2011', 'dd-mm-yyyy'), to_date('26-01-2034', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (265, 7, to_date('02-04-2009', 'dd-mm-yyyy'), to_date('01-04-2061', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (266, 94, to_date('05-03-2008', 'dd-mm-yyyy'), to_date('05-07-2061', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (267, 301, to_date('07-06-2008', 'dd-mm-yyyy'), to_date('28-09-2084', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (268, 182, to_date('06-08-2010', 'dd-mm-yyyy'), to_date('09-06-2097', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (269, 140, to_date('07-03-2017', 'dd-mm-yyyy'), to_date('03-10-2026', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (270, 462, to_date('22-03-2009', 'dd-mm-yyyy'), to_date('20-08-2076', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (271, 109, to_date('29-12-2017', 'dd-mm-yyyy'), to_date('27-02-2062', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (272, 133, to_date('05-04-2013', 'dd-mm-yyyy'), to_date('02-10-2052', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (274, 353, to_date('03-03-2010', 'dd-mm-yyyy'), to_date('04-11-2091', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (276, 472, to_date('03-09-2007', 'dd-mm-yyyy'), to_date('13-09-2093', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (277, 32, to_date('27-04-2014', 'dd-mm-yyyy'), to_date('03-02-2048', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (278, 384, to_date('14-02-2023', 'dd-mm-yyyy'), to_date('09-02-2039', 'dd-mm-yyyy'), 'new');
commit;
prompt 200 records committed...
insert into TASK (taskid, projectid, enddate, begindate, status)
values (279, 444, to_date('05-09-2012', 'dd-mm-yyyy'), to_date('26-09-2098', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (280, 248, to_date('11-02-2006', 'dd-mm-yyyy'), to_date('05-09-2088', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (281, 194, to_date('05-08-2005', 'dd-mm-yyyy'), to_date('01-12-2059', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (283, 409, to_date('07-12-2006', 'dd-mm-yyyy'), to_date('16-07-2076', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (284, 377, to_date('19-06-2009', 'dd-mm-yyyy'), to_date('15-08-2062', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (285, 285, to_date('31-03-2006', 'dd-mm-yyyy'), to_date('25-05-2031', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (287, 276, to_date('23-03-2016', 'dd-mm-yyyy'), to_date('22-11-2094', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (289, 186, to_date('29-05-2023', 'dd-mm-yyyy'), to_date('28-03-2051', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (290, 35, to_date('12-11-2020', 'dd-mm-yyyy'), to_date('03-01-2073', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (291, 26, to_date('13-01-2022', 'dd-mm-yyyy'), to_date('16-10-2046', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (292, 155, to_date('26-01-2008', 'dd-mm-yyyy'), to_date('02-10-2076', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (293, 442, to_date('22-10-2010', 'dd-mm-yyyy'), to_date('27-01-2060', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (294, 170, to_date('09-06-2018', 'dd-mm-yyyy'), to_date('14-05-2068', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (295, 374, to_date('29-11-2015', 'dd-mm-yyyy'), to_date('04-03-2083', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (296, 197, to_date('27-05-2007', 'dd-mm-yyyy'), to_date('27-11-2030', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (297, 344, to_date('24-02-2014', 'dd-mm-yyyy'), to_date('19-09-2088', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (298, 337, to_date('21-07-2015', 'dd-mm-yyyy'), to_date('06-12-2088', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (299, 419, to_date('15-11-2008', 'dd-mm-yyyy'), to_date('04-12-2044', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (300, 161, to_date('24-05-2011', 'dd-mm-yyyy'), to_date('14-09-2076', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (301, 181, to_date('10-05-2010', 'dd-mm-yyyy'), to_date('24-05-2061', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (305, 27, to_date('07-06-2009', 'dd-mm-yyyy'), to_date('16-04-2033', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (306, 60, to_date('17-09-2016', 'dd-mm-yyyy'), to_date('14-09-2089', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (307, 459, to_date('14-08-2019', 'dd-mm-yyyy'), to_date('04-07-2092', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (308, 43, to_date('28-03-2009', 'dd-mm-yyyy'), to_date('29-08-2030', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (310, 256, to_date('25-01-2013', 'dd-mm-yyyy'), to_date('04-05-2031', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (311, 208, to_date('16-11-2021', 'dd-mm-yyyy'), to_date('10-01-2043', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (312, 403, to_date('26-04-2008', 'dd-mm-yyyy'), to_date('23-10-2058', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (313, 126, to_date('07-09-2015', 'dd-mm-yyyy'), to_date('30-09-2096', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (314, 27, to_date('01-02-2009', 'dd-mm-yyyy'), to_date('03-12-2071', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (316, 399, to_date('27-02-2010', 'dd-mm-yyyy'), to_date('24-09-2059', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (317, 63, to_date('31-10-2015', 'dd-mm-yyyy'), to_date('27-07-2066', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (318, 234, to_date('06-10-2011', 'dd-mm-yyyy'), to_date('30-12-2085', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (320, 307, to_date('28-08-2010', 'dd-mm-yyyy'), to_date('03-06-2074', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (321, 133, to_date('03-12-2014', 'dd-mm-yyyy'), to_date('20-01-2061', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (322, 436, to_date('03-10-2007', 'dd-mm-yyyy'), to_date('10-05-2089', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (323, 268, to_date('09-07-2018', 'dd-mm-yyyy'), to_date('27-03-2089', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (325, 85, to_date('06-12-2017', 'dd-mm-yyyy'), to_date('01-02-2055', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (326, 131, to_date('24-03-2020', 'dd-mm-yyyy'), to_date('13-01-2056', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (327, 455, to_date('28-10-2009', 'dd-mm-yyyy'), to_date('16-01-2083', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (329, 394, to_date('26-04-2013', 'dd-mm-yyyy'), to_date('01-08-2050', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (331, 224, to_date('27-12-2010', 'dd-mm-yyyy'), to_date('24-02-2076', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (332, 163, to_date('30-08-2013', 'dd-mm-yyyy'), to_date('19-02-2043', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (333, 366, to_date('09-01-2006', 'dd-mm-yyyy'), to_date('20-05-2092', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (334, 150, to_date('18-03-2012', 'dd-mm-yyyy'), to_date('04-02-2039', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (336, 23, to_date('03-06-2012', 'dd-mm-yyyy'), to_date('08-07-2059', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (337, 8, to_date('13-02-2012', 'dd-mm-yyyy'), to_date('29-06-2051', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (338, 200, to_date('22-07-2011', 'dd-mm-yyyy'), to_date('14-08-2091', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (339, 278, to_date('31-07-2016', 'dd-mm-yyyy'), to_date('12-06-2094', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (340, 44, to_date('24-06-2011', 'dd-mm-yyyy'), to_date('20-03-2087', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (342, 296, to_date('29-01-2007', 'dd-mm-yyyy'), to_date('24-11-2043', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (345, 370, to_date('31-05-2021', 'dd-mm-yyyy'), to_date('15-08-2027', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (346, 111, to_date('03-12-2010', 'dd-mm-yyyy'), to_date('26-05-2062', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (347, 20, to_date('27-06-2021', 'dd-mm-yyyy'), to_date('30-08-2066', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (348, 435, to_date('07-10-2021', 'dd-mm-yyyy'), to_date('14-07-2042', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (349, 420, to_date('10-09-2011', 'dd-mm-yyyy'), to_date('06-05-2088', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (352, 424, to_date('16-02-2007', 'dd-mm-yyyy'), to_date('06-06-2097', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (354, 144, to_date('03-03-2018', 'dd-mm-yyyy'), to_date('10-10-2075', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (355, 458, to_date('20-09-2021', 'dd-mm-yyyy'), to_date('21-09-2056', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (356, 353, to_date('19-10-2011', 'dd-mm-yyyy'), to_date('29-02-2088', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (358, 479, to_date('27-07-2009', 'dd-mm-yyyy'), to_date('16-12-2090', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (359, 492, to_date('04-04-2024', 'dd-mm-yyyy'), to_date('22-10-2063', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (360, 436, to_date('15-04-2009', 'dd-mm-yyyy'), to_date('18-06-2043', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (362, 131, to_date('14-12-2020', 'dd-mm-yyyy'), to_date('15-09-2042', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (363, 74, to_date('06-11-2023', 'dd-mm-yyyy'), to_date('08-04-2070', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (364, 388, to_date('19-11-2014', 'dd-mm-yyyy'), to_date('17-09-2092', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (365, 404, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('03-12-2061', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (366, 207, to_date('23-11-2022', 'dd-mm-yyyy'), to_date('25-10-2080', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (367, 147, to_date('26-04-2010', 'dd-mm-yyyy'), to_date('14-10-2070', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (368, 80, to_date('24-01-2024', 'dd-mm-yyyy'), to_date('24-06-2082', 'dd-mm-yyyy'), 'end');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (370, 416, to_date('13-09-2021', 'dd-mm-yyyy'), to_date('02-08-2060', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (371, 128, to_date('18-01-2023', 'dd-mm-yyyy'), to_date('19-03-2085', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (373, 292, to_date('16-10-2019', 'dd-mm-yyyy'), to_date('01-02-2052', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (374, 109, to_date('24-07-2013', 'dd-mm-yyyy'), to_date('09-07-2062', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (375, 223, to_date('26-05-2012', 'dd-mm-yyyy'), to_date('11-07-2087', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (376, 429, to_date('10-07-2015', 'dd-mm-yyyy'), to_date('14-01-2031', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (377, 307, to_date('10-01-2010', 'dd-mm-yyyy'), to_date('01-09-2039', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (379, 151, to_date('18-05-2010', 'dd-mm-yyyy'), to_date('23-04-2098', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (381, 354, to_date('16-02-2008', 'dd-mm-yyyy'), to_date('22-02-2040', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (383, 70, to_date('15-05-2012', 'dd-mm-yyyy'), to_date('20-01-2099', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (384, 237, to_date('19-09-2014', 'dd-mm-yyyy'), to_date('01-07-2069', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (385, 225, to_date('18-10-2022', 'dd-mm-yyyy'), to_date('17-04-2075', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (387, 177, to_date('04-10-2018', 'dd-mm-yyyy'), to_date('07-11-2088', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (388, 49, to_date('15-03-2013', 'dd-mm-yyyy'), to_date('09-10-2029', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (389, 398, to_date('19-01-2024', 'dd-mm-yyyy'), to_date('18-03-2078', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (390, 432, to_date('05-10-2022', 'dd-mm-yyyy'), to_date('21-05-2078', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (391, 102, to_date('16-05-2015', 'dd-mm-yyyy'), to_date('23-01-2060', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (392, 73, to_date('16-07-2020', 'dd-mm-yyyy'), to_date('25-06-2030', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (393, 328, to_date('10-05-2008', 'dd-mm-yyyy'), to_date('28-08-2031', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (394, 35, to_date('21-12-2019', 'dd-mm-yyyy'), to_date('14-05-2055', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (395, 185, to_date('06-11-2008', 'dd-mm-yyyy'), to_date('10-01-2049', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (396, 160, to_date('31-10-2009', 'dd-mm-yyyy'), to_date('30-03-2047', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (397, 296, to_date('01-06-2015', 'dd-mm-yyyy'), to_date('26-08-2078', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (398, 323, to_date('05-10-2020', 'dd-mm-yyyy'), to_date('24-07-2057', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (401, 47, to_date('12-04-2014', 'dd-mm-yyyy'), to_date('24-04-2028', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (402, 17, to_date('04-05-2012', 'dd-mm-yyyy'), to_date('02-12-2058', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (403, 316, to_date('31-08-2014', 'dd-mm-yyyy'), to_date('04-03-2025', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (405, 458, to_date('06-10-2012', 'dd-mm-yyyy'), to_date('18-08-2075', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (407, 204, to_date('20-02-2019', 'dd-mm-yyyy'), to_date('02-04-2088', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (408, 98, to_date('04-08-2005', 'dd-mm-yyyy'), to_date('05-01-2064', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (409, 467, to_date('11-01-2024', 'dd-mm-yyyy'), to_date('07-06-2048', 'dd-mm-yyyy'), 'start');
commit;
prompt 300 records committed...
insert into TASK (taskid, projectid, enddate, begindate, status)
values (410, 458, to_date('15-11-2009', 'dd-mm-yyyy'), to_date('04-03-2055', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (411, 11, to_date('01-02-2016', 'dd-mm-yyyy'), to_date('30-10-2041', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (413, 278, to_date('20-07-2011', 'dd-mm-yyyy'), to_date('30-11-2079', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (414, 317, to_date('20-06-2011', 'dd-mm-yyyy'), to_date('14-12-2031', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (415, 204, to_date('09-01-2018', 'dd-mm-yyyy'), to_date('15-07-2064', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (416, 228, to_date('19-01-2016', 'dd-mm-yyyy'), to_date('02-03-2029', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (417, 404, to_date('05-01-2023', 'dd-mm-yyyy'), to_date('12-01-2029', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (418, 462, to_date('18-01-2020', 'dd-mm-yyyy'), to_date('25-06-2091', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (419, 420, to_date('07-01-2021', 'dd-mm-yyyy'), to_date('02-01-2057', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (420, 481, to_date('11-06-2015', 'dd-mm-yyyy'), to_date('20-05-2042', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (421, 100, to_date('14-12-2010', 'dd-mm-yyyy'), to_date('14-04-2051', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (422, 479, to_date('21-05-2024', 'dd-mm-yyyy'), to_date('27-06-2058', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (424, 318, to_date('15-07-2014', 'dd-mm-yyyy'), to_date('23-04-2037', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (425, 99, to_date('06-11-2019', 'dd-mm-yyyy'), to_date('30-08-2062', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (426, 270, to_date('24-05-2009', 'dd-mm-yyyy'), to_date('23-04-2063', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (428, 451, to_date('13-01-2015', 'dd-mm-yyyy'), to_date('07-01-2040', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (429, 92, to_date('09-11-2009', 'dd-mm-yyyy'), to_date('04-05-2070', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (431, 146, to_date('27-07-2023', 'dd-mm-yyyy'), to_date('16-11-2052', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (433, 337, to_date('24-04-2023', 'dd-mm-yyyy'), to_date('20-09-2031', 'dd-mm-yyyy'), 'end');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (437, 233, to_date('15-05-2020', 'dd-mm-yyyy'), to_date('16-06-2078', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (440, 255, to_date('19-03-2018', 'dd-mm-yyyy'), to_date('06-01-2055', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (442, 433, to_date('06-06-2008', 'dd-mm-yyyy'), to_date('02-10-2063', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (443, 329, to_date('12-03-2022', 'dd-mm-yyyy'), to_date('16-02-2040', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (444, 112, to_date('03-01-2010', 'dd-mm-yyyy'), to_date('24-11-2044', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (445, 90, to_date('28-11-2019', 'dd-mm-yyyy'), to_date('16-05-2093', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (446, 27, to_date('16-10-2019', 'dd-mm-yyyy'), to_date('08-10-2049', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (447, 154, to_date('17-12-2015', 'dd-mm-yyyy'), to_date('31-10-2032', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (448, 404, to_date('04-09-2020', 'dd-mm-yyyy'), to_date('09-07-2046', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (449, 249, to_date('03-03-2007', 'dd-mm-yyyy'), to_date('22-11-2048', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (450, 272, to_date('22-01-2012', 'dd-mm-yyyy'), to_date('09-01-2079', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (451, 450, to_date('26-01-2020', 'dd-mm-yyyy'), to_date('18-03-2051', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (452, 379, to_date('11-07-2014', 'dd-mm-yyyy'), to_date('12-03-2036', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (453, 73, to_date('13-03-2011', 'dd-mm-yyyy'), to_date('13-09-2099', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (455, 30, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('06-08-2065', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (456, 397, to_date('08-07-2019', 'dd-mm-yyyy'), to_date('22-09-2079', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (457, 431, to_date('04-05-2010', 'dd-mm-yyyy'), to_date('09-08-2091', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (458, 468, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('02-01-2029', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (462, 249, to_date('03-11-2009', 'dd-mm-yyyy'), to_date('29-04-2055', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (463, 420, to_date('08-03-2007', 'dd-mm-yyyy'), to_date('05-09-2043', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (464, 340, to_date('25-02-2011', 'dd-mm-yyyy'), to_date('10-04-2083', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (465, 176, to_date('03-09-2014', 'dd-mm-yyyy'), to_date('14-10-2072', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (466, 206, to_date('21-05-2021', 'dd-mm-yyyy'), to_date('02-11-2097', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (467, 312, to_date('30-04-2013', 'dd-mm-yyyy'), to_date('05-12-2038', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (468, 446, to_date('14-04-2007', 'dd-mm-yyyy'), to_date('25-04-2052', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (469, 377, to_date('15-08-2020', 'dd-mm-yyyy'), to_date('10-06-2074', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (471, 127, to_date('04-02-2017', 'dd-mm-yyyy'), to_date('10-07-2034', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (472, 376, to_date('13-06-2018', 'dd-mm-yyyy'), to_date('15-07-2092', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (473, 107, to_date('19-06-2008', 'dd-mm-yyyy'), to_date('18-10-2054', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (474, 348, to_date('06-10-2017', 'dd-mm-yyyy'), to_date('26-02-2081', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (476, 348, to_date('30-04-2018', 'dd-mm-yyyy'), to_date('08-01-2034', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (477, 300, to_date('01-04-2012', 'dd-mm-yyyy'), to_date('24-04-2055', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (478, 119, to_date('19-04-2018', 'dd-mm-yyyy'), to_date('30-11-2062', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (479, 402, to_date('19-09-2008', 'dd-mm-yyyy'), to_date('29-12-2048', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (480, 408, to_date('10-06-2005', 'dd-mm-yyyy'), to_date('26-09-2089', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (481, 398, to_date('10-07-2014', 'dd-mm-yyyy'), to_date('02-11-2085', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (482, 127, to_date('21-09-2015', 'dd-mm-yyyy'), to_date('23-08-2059', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (483, 231, to_date('21-09-2005', 'dd-mm-yyyy'), to_date('29-06-2037', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (484, 185, to_date('19-06-2006', 'dd-mm-yyyy'), to_date('17-10-2075', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (485, 93, to_date('28-06-2017', 'dd-mm-yyyy'), to_date('23-03-2091', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (487, 267, to_date('29-11-2022', 'dd-mm-yyyy'), to_date('14-02-2036', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (488, 280, to_date('05-10-2006', 'dd-mm-yyyy'), to_date('05-12-2057', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (489, 79, to_date('05-12-2010', 'dd-mm-yyyy'), to_date('13-04-2085', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (491, 475, to_date('11-06-2023', 'dd-mm-yyyy'), to_date('23-11-2072', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (492, 464, to_date('14-04-2017', 'dd-mm-yyyy'), to_date('13-06-2088', 'dd-mm-yyyy'), 'middle');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (493, 37, to_date('13-03-2020', 'dd-mm-yyyy'), to_date('09-07-2041', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (496, 328, to_date('24-02-2010', 'dd-mm-yyyy'), to_date('02-01-2027', 'dd-mm-yyyy'), 'start');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (497, 225, to_date('07-11-2008', 'dd-mm-yyyy'), to_date('28-06-2072', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (498, 197, to_date('29-09-2018', 'dd-mm-yyyy'), to_date('03-05-2049', 'dd-mm-yyyy'), 'new');
insert into TASK (taskid, projectid, enddate, begindate, status)
values (500, 7, to_date('01-10-2005', 'dd-mm-yyyy'), to_date('08-12-2099', 'dd-mm-yyyy'), 'start');
commit;
prompt 369 records loaded
prompt Enabling foreign key constraints for EXCELLENCE...
alter table EXCELLENCE enable constraint SYS_C009490;
prompt Enabling foreign key constraints for INPROJECT...
alter table INPROJECT enable constraint SYS_C009504;
prompt Enabling foreign key constraints for RESOURCES...
alter table RESOURCES enable constraint SYS_C009512;
prompt Enabling foreign key constraints for TASK...
alter table TASK enable constraint SYS_C009520;
prompt Enabling triggers for UNIT...
alter table UNIT enable all triggers;
prompt Enabling triggers for EXCELLENCE...
alter table EXCELLENCE enable all triggers;
prompt Enabling triggers for PROJECTS...
alter table PROJECTS enable all triggers;
prompt Enabling triggers for INPROJECT...
alter table INPROJECT enable all triggers;
prompt Enabling triggers for PERSON...
alter table PERSON enable all triggers;
prompt Enabling triggers for RESOURCES...
alter table RESOURCES enable all triggers;
prompt Enabling triggers for TASK...
alter table TASK enable all triggers;

set feedback on
set define on
prompt Done
