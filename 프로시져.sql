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
        RTVAL :='입력 성공';
        COMMIT;
    END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RTVAL :='입력실패-중복키거나 입력값이 크다';
            
END;
/

var RTVAL nvarchar2(50);
exec SP_INS_MEMBER('KOSMO',1234,'한소인',:RTVAL);
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
exec SP_UP_MEMBER('KIM1','9999','가길동',:RT_VAR);
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
        DBMS_OUTPUT.put_LINE(ID_||'가 삭제되었어요');
        AFFECTED := SQL%ROWCOUNT;
        commit;
    else 
         DBMS_OUTPUT.put_LINE(ID_||'가 존재하지 않아요');
         AFFECTED := -1;
       end if;
         
     EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
           DBMS_OUTPUT.put_LINE('자식이 참조하고 있어요');
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
values(SEQ_BBS.NEXTVAL,'KIM','가길동입니다',SYSDATE);

COMMIT;

var return_var number;
exec SP_DEL_MEMBER('KIM',:return_var);
print return_var;

/* 
    out 파라미터값
        - 회원인 경우 : 1
        - 아이디는 일치하나 비번이 불일치 : 0
        - 아이디 불일치 : -1
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
    else -- 아이디 일치
        select count(*)
        into FLAG
        from member
        where id=id_ and pwd = pwd_;
        
        if flag = 0 then -- 비밀번호 불 일치
            RTVAL := 0;
        else 
            RTVAL := 1;
        end if;
    end if;
end;
/

select *
from member;

--회원인 경우
exec SP_ismember('KIM','9999',:return_var);
print return_var;

--아이디는 일치하는데 비밀번호 틀린경우
exec SP_ismember('KIM','99',:return_var);
print return_var;

-- 아이디 불 일치
exec SP_ismember('KIM1','9999',:return_var);
print return_var;


