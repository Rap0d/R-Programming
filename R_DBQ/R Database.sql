-- Use R connection

create table test_table(
	id varchar2(50) primary key,
	pass varchar2(30) not null, 
	name varchar2(25) not null, 
	age number(2)
);

insert into test_table values('hong', '1234', '홍길동', 35) ;
insert into test_table values('kim', '5678', '김길동', 45) ;

commit ;

select * from test_table ;

-------------------------------------------------------------

create table goods(
    pcode char(10) primary key,
    pname varchar2(50) not null,
    price number(10) not null,
    maker varchar2(25) not null
);

insert into goods values('1001', '냉장고', 2000000, 'SS');
insert into goods values('1002', '세탁기', 700000, 'LG');
insert into goods values('1003', 'UHDTV', 2500000, 'GM');

commit;