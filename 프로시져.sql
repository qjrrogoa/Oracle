set serverout on;
CREATE OR REPLACE PROCEDURE SP_INS_MEMBER(
    ID_ IN MEMBER.ID%TYPE,
    PWD_ MEMBER.PWD%TYPE,
    NAME_ MEMBER.NAME%TYPE,
    RTVAL OUT NVARCHAR2
)
IS
BEGIN
    INSERT INTO MEMBER(ID,PWD,NAME)
    VALUES(ID_,PWD_,NAME_);
    
    IF SQL%FOUND THEN
        RTVAL :='�Է� ����';
        COMMIT;
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RTVAL :='�Է½���-�ߺ�Ű�ų� �Է°��� ũ��';
            
END;
/

var RTVAL nvarchar2(50);
exec SP_INS_MEMBER('KOSMO',1234,'�Ѽ���',:RTVAL);
print RTVAL;

select *
from member;


create or replace procedure SP_UP_MEMBER(
    ID_ IN MEMBER.ID%TYPE,
    PWD_ MEMBER.PWD%TYPE,
    NAME_ MEMBER.NAME%TYPE,
    RTVAL OUT  Char
)
IS
BEGIN
    update member
    set pwd = pwd_, name = name_
    where id = id_;
    
     IF SQL%FOUND THEN
        RTVAL :='SUCCESS';
        COMMIT;
    else 
        RTVAL := 'FAIL : NOT FOUND ID : ' || id_;
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RTVAL :='FAIL : TOO MUCH VALUE';
END;
/

var RT_VAR CHAR(50);
exec SP_UP_MEMBER('KIM1','9999','���浿',:RT_VAR);
print rt_var;

select *
from member;


create or replace procedure SP_DEL_MEMBER(
    ID_ IN MEMBER.ID%TYPE,
    AFFECTED OUT  NUMBER
)
is
begin
    delete member
    where id =id_;
    
    if SQL%FOUND then
        DBMS_OUTPUT.put_LINE(ID_||'�� �����Ǿ����');
        AFFECTED := SQL%ROWCOUNT;
        commit;
    else 
         DBMS_OUTPUT.put_LINE(ID_||'�� �������� �ʾƿ�');
         AFFECTED := -1;
       end if;
         
     EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
           DBMS_OUTPUT.put_LINE('�ڽ��� �����ϰ� �־��');
            AFFECTED := -2;
end;
/

create table bbs(
    No number primary key,
    ID varchar2(10) references member(id),
    title nvarchar2(50) not null,
    postdate date default sysdate
)

create sequence seq_bbs
nocache
nocycle;

insert into bbs 
values(SEQ_BBS.NEXTVAL,'KIM','���浿�Դϴ�',SYSDATE);

COMMIT;

var return_var number;
exec SP_DEL_MEMBER('KIM',:return_var);
print return_var;

/* 
    out �Ķ���Ͱ�
        - ȸ���� ��� : 1
        - ���̵�� ��ġ�ϳ� ����� ����ġ : 0
        - ���̵� ����ġ : -1
*/

create or replace procedure sp_ismember(
    id_ member.id%type,
    pwd_ member.pwd%type,
    RTVAL out number)
is
    FLAG number(1);
begin
    select count(*)
    into FLAG
    from member
    where id=id_;
    
    if FLAG = 0 then
        RTVAL := -1;
    else -- ���̵� ��ġ
        select count(*)
        into FLAG
        from member
        where id=id_ and pwd = pwd_;
        
        if flag = 0 then -- ��й�ȣ �� ��ġ
            RTVAL := 0;
        else 
            RTVAL := 1;
        end if;
    end if;
end;
/

select *
from member;

--ȸ���� ���
exec SP_ismember('KIM','9999',:return_var);
print return_var;

--���̵�� ��ġ�ϴµ� ��й�ȣ Ʋ�����
exec SP_ismember('KIM','99',:return_var);
print return_var;

-- ���̵� �� ��ġ
exec SP_ismember('KIM1','9999',:return_var);
print return_var;


