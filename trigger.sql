create table before_RAISE(
    EVENT_STRING nvarchar2(10),
    postdate date default sysdate
);

create table target_trigger_table(
    no number primary key,
    title nvarchar2(10)
);

Create trigger trg_sample
after insert or delete or update
on target_trigger_table
for each row
declare
begin
    if inserting then
        insert into before_raise values('insert',sysdate);
    elsif deleting then
        insert into before_raise values('delete',sysdate);
    elsif updating then
        insert into before_raise values('update',sysdate);

    end if;
end;
/

select *
from before_raise;

select *
from target_trigger_table;

insert into target_trigger_table
values(3,'3번');

delete target_trigger_table
where no >=2;

update target_trigger_table
set title = '일번'
where no ='1';

drop trigger trg_sample1;

Create trigger trg_sample1
before insert
on target_trigger_table
for each row
declare
begin
    if to_char(sysdate,'dy') = '수' or to_char(sysdate,'hh24') >= 17 then
        raise_application_error(-20001,'수요일 혹은 오후 5시에는 입력 불가');
    else
         insert into before_raise values('입력성공',sysdate);
    end if;
end;
/

insert into target_trigger_table
values(6,'6번');

select *
from before_raise;

select *
from target_trigger_table;


--상품
create table product(
    p_code char(4) primary key,
    p_name nvarchar2(10) not null,
    p_price number,
    p_qty number default 0
)

--입고
create table ipgo(
    i_no number primary key,
    p_code char(4) references product(p_code),
    i_date date default sysdate,
    i_qty number,
    i_price number
)

-- 판매
create table sales(
    s_no number primary key,
    p_code char(4) references product(p_code),
    s_date date default sysdate,
    s_qty number,
    s_price number
)

select * from product;
select * from ipgo;
select * from sales;

insert into product(p_code,p_name,p_price)
values('p001','노트북',2000);

create trigger trg_ipgo1
after insert 
on ipgo
for each row
declare
begin
    update product set p_qty = p_qty + :new.i_qty
    where p_code = :new.p_code;
end;
/

insert into ipgo(i_no,p_code,i_qty,i_price)
values(2,'p001',100,1500);

create trigger trg_ipgo2
after update 
on ipgo
for each row
declare
begin
    update product set p_qty = p_qty - :old.i_qty + :new.i_qty
    where p_code = :new.p_code;
end;
/

update ipgo
set i_qty = 50
where i_no=2;

create trigger trg_sales1
before insert
on sales
for each row
declare
    qty number; -- 재고 수량
begin
    select p_qty
    into qty 
    from product
    where p_code = :new.p_code;
    if qty < :new.s_qty then
        raise_application_error(-20020,'재고가 없어요');
    else
        update product 
        set p_qty =p_qty - :new.s_qty
        where p_code = :new.p_code;
    end if;
end;
/

insert into sales(s_no,p_code,s_qty,s_price)
values(1,'p001',149,3000);

