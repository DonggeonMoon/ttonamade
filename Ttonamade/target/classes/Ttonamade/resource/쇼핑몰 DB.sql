drop table order_detail purge;
drop table order_info purge;
drop table cart_info purge;
drop table Customer_info purge;
drop table product_info purge;
drop sequence order_seq;
drop sequence cart_id_seq;
drop sequence cust_id_seq;
drop sequence prod_id_seq;
drop sequence order_detail_seq;

create table Customer_Info(
    cust_id varchar2(50) not null,
    cust_name varchar2(50) not null,
    cust_password varchar2(50) not null,
    cust_sex varchar2(50),
    cust_telephone varchar(20) ,
    cust_birthday varchar2(20),
    cust_manager char(2),
    cust_date date default sysdate,
    constraint cust_id_pk primary key(cust_id)
    );

create table Order_Info (
    order_id varchar2(50) NOT NULL,
    cust_id varchar(50) NOT NULL ,
    order_totalAmount number,
    order_zipcode varchar(10) ,
    order_add1 varchar(100),
    order_add2 varchar(100) ,
    order_telephone varchar(20) ,
    order_status char(2) ,
    order_date date default sysdate,
    constraint order_id_pk primary key(order_id),
    constraint cust_id_fk foreign key(cust_id) references Customer_Info(cust_id)
    );

create table Product_Info(
    prod_id number NOT NULL ,
    prod_name varchar2(50)NOT NULL,
    prod_price number,
    prod_count int ,
    prod_desc varchar2(4000),
    prod_imgsrc varchar2(100),
    prod_rating number(2,1) DEFAULT 0,
    prod_date date default sysdate,
    constraint prod_id_pk primary key(prod_id)
    );

create sequence prod_id_seq ;
 
create table Order_Detail(    
    order_seq number not null, 
    order_id varchar2(50) not null,
    prod_id number not null, 
    prod_name varchar2(50) not null,
    prod_price number default 0,
    order_count int default 1 ,
    constraint order_seq_pk primary key (order_seq),
    constraint order_id_fk foreign key(order_id) references Order_Info(order_id),
    constraint prod_id_fk foreign key(prod_id) references Product_Info(prod_id)   
);

create sequence order_detail_seq ;
 
create table cart_Info(
    cart_id number not null,
    cust_id varchar(50) not null,
    prod_id number not null,
    prod_name varchar2(50),
    prod_count int default 1,
    prod_price number default 0, 
    constraint cart_id_pk primary key(cart_id)  ,
    constraint prod_id1_fk foreign key(prod_id) references Product_Info(prod_id),
    constraint cust_id1_fk foreign key(cust_id) references Customer_Info(cust_id)
);

create sequence cart_id_seq ;

select * from product_info;
select * from customer_info;
select * from cart_info;
select * from order_info;
select * from order_detail;

insert into product_info values(prod_id_seq.nextval, '제품1', 10000, 100, '제품입니다.', 'b9ca692e-b8a5-4e3d-a85b-a58430b889c9_1_jhaUd018svc1tgyk4h5vol5f_yj6is8.jpg',  4.5, sysdate);
insert into customer_info values('test', '홍길동', '11', 'M', '010-0000-0000', '00/01/01', 'U', sysdate);
insert into cart_info values(cart_id_seq.nextval, 'test', 1, '제품1', 100, 10000);
insert into order_info values('vvvv', 'test', 1000000, '00100', '서울시 강남구', '개포동', '010-0000-0000', 'T', sysdate);
insert into order_detail values(order_detail_seq.nextval, 'vvvv', 1, '제품1', 100, 10000);
 
commit;

create table product_choice(
cust_id varchar2(50),
prod_id number
);

create table product_review(
order_id number not null,
prod_id number not null,
prod_review varchar2(1000),
prod_rating float,
review_imgsrc varchar(200),
cust_id varchar2(50)
);

create table goods_category (
cateName varchar2(20) not null,
cateCode varchar2(30) not null,
cateCodeRef varchar2(30) null,
primary key(cateCode),
foreign key (cateCodeRef) references goods_category(cateCode)
);

create table qna(
qna_id number,
child_level number not null,
parent_level number,      
title varchar2(100),
content varchar2(1000),
cust_id varchar(100),
writerDate date,
privateFlag char(2),
password varchar2(50),
constraint qna_id_pk primary key(qna_id)
);

commit;