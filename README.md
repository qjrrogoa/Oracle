# Oracle

# DDL
# TABLE

1] create
---
    Create tabel 테이블명{
     컬러명1 자료형1 [not null],
     컬러명2 자료형2 [not null]

2] 테이블 이름 미 컬러 명명규칙
---
  - 문자로 시작한다
  
  - 30자 이내로 지정 한다
  
  - 대소문자를 구별하지 않는다

  - 동일하 이름으 사용할 수 없다. 또하 예역어도 사용할 수 없다

3] 테이블 제약 조건
---
[1] 기본키(pk) (Not Null + Unique)

  - 참조무결성을 유지하기 위해 제약조건이다

  - 하나의 테이블에느 하나의 pkaks whswogksek.

  - PK로 설정되면 그 칼럼은 값이 중복되거나 NULL을 허용하지 않는다.

[2] NOT NULL

  - NULL값을 절대로 허용하지 않는 컬럼
  
[3] UINQUE 

  - 중복을 허용하지 않는다. NULL은 허용한다(여러번)

[4] DEFAULT

[5] FK 

  - 컬럼 옆에 
  
  - creat문 마지막에

4] Check
---
  - WHERE절 이라고 생각하면 된다.
    
        create table chktbl(
        col1 number primary key,
        col2 Char(1) constraint chk_chktbl_col2 check(col2 IN ('F','M')),
        col3 number check(col3 >= 100 and col3 <= 200),
        col4 date check(col4 >= To_DATE('2021-02-24' and col4 <= TO_DATE('2021-08-23)),
        col5 char(14) check(regexp_like(col5,'^[0-9]{6}-[1-4]{7}$');

5] 테이블 변경
---
  - 안하는게 낫다,

  - 테이블 구조와 데이터는 그대로 복사되지만, 제약조건(pk,fk,unique등)은 복사가 안된다.

        Create table emp_copy
        as 
        select empno, ename, sal, job, hiredate, deptno
        from emp

6] Alter
---
  - 새로운 칼럼, 제약조건 추가

        Alter Table 테이블명 Add 컬럼명 자료형 Not Null    //가장 위험하다 칼럼 not null 하려면 그 행 다 지워야 한다,,
        alter table emp_copy add comm number(6,2)
        alter table emp_copy add constraint PK_emp_copy primary key(empno)
        alter table emp_copy drop constraint PK_emp_copy;
        alter table emp_copy drop column comm;
        alter table emp_copy modify empno NUMBER(2)  // 컬럼 자료형 바꿀때 반드시 더 큰 자료형으로 바꿔야 한다. 
        원본 데이터는 number(4) 2로바꾸면 오류 6을 바꾸면 성공
        alter table emp_copy rename column sal to salary // sal -> salar로 칼럼 명 변경
        rename emp_copy to EMP2    // 테이블 명 변경
 
 7] DROP 
 ---
  - 부모 테이블은 삭제가 안된다 (삭제하려면 함수 다름)

        Drop table emp2 // emp2 삭제
        Flashback table emp2 to before drop // 삭제한 테이블 복원
        Drop table emp2 pudge // 복원 불가능 완전 삭제
        
        Drop table 부모테이블 Cascade constraint // 부모 테이블 삭제
        
# 시퀀스

 - 테이블의 필드에 일련번호 부여
 - 테이블 생성 후 시퀀스(일련번호)를 따로 만들어야 한다.
 - 테이블 하나 당 시퀀스 하나를 만들자
 - DUAL : 출력을 위한 임시 테이블로 모든 사용자 계정이 가질 수 있다.

        create sequence 시퀀스명
        [increment by 증가값]
        [start with seed값]
        [maxvalues n / minvalues n] 
        [cycle / nocycle] // 무조건 1보다 커야함
        // 최대 최소값을 도달한 후 계속 값을 생성할 지 여부 지정 (디폴트 노사이클)
        [cache / nocache] // CACHE메모리에 오라클 서버가 SEQUENCE값을 할당하는가 여부 지정 (디폴트로 CACHE) 
        // 캐쉬 기본 값이 20이라 maxvalues가 20보다 낮으면 오류다,
        // 그래서 노캐쉬 하던가 사이클을 maxvalues보다 낮게 지정하면 된다.
        
        create sequence seq_exam1
        increment by 5
        start with 20
        maxvalue 40
        nocache
        cycle;
        //싸이클 5번 돌면 시퀀스 1로 간다,,  -> 노 사이클 해야함,,
        
        create sequence seq_exam2
        increment by 5
        start with 20
        maxvalue 40
        cache 2
        nocycle;
        // 40 넘어가면 종료
        
        
        create sequence SEQ_bbs1
        NOCACHE
        NOCYCLE;
        // 제일 깔끔
        
# 데이터 값 입력
1]INSERT 문
---
        Insert into 테이블명 (컬럼1, 컬럼2, 컬럼n)
        values(값1,값2,값n)
        
        
        insert into dmltbl 
        values(seq_dmltbl.NEXTVAL,'ID'||seq_dmltbl.NEXTVAL,20,default);
        
        
        accept id prompt '삭제할 아이디'
        declare 
        id_ MEMBER.id%TYPE := '&id';
        begin
            delete MEMBER
            where id = id_;
        end;
        /
        
        accept id prompt '삭제할 아이디'
        declare 
        id_ MEMBER.id%TYPE := '&id';
        begin
            delete MEMBER
            where id like '%' || id_ || '%';
        end;
        /
2]Update문
---
 - WHERE절 없으면 모든 행 다 바뀐다

        update 테이블명
        set 컬러명 = 바꿀 값
        
        update dmltbl
        set age = 40, id = 'kosmo';
        
        update dmltbl 
        set id='KIM', age = 20
        where no=1;
        
3]Delete문
---
        delete 
        from dmltbl
        where no=5;
        
        delete dmltbl
        where no >=2;
        
        
        TRUNCATE table 테이블명 : 즉 테이블안에 있는 모든 데이터를 삭제한다.
        (delete from 테이블 명과 같다, 속도는 빠르지만 복원 불가,,)
        
        
# 뷰
 - 물리적인 공간을 차지하지 않는다.
 - 하나 또는 그 이상의 테이블로부터 생성된 가상의 테이블이다.
 - DB의 선택적인 내용을 보여줄 수 있기 때문에 DB에 대한 엑세스 제한 기능 (보안 기능)
 - 복작한 질의어를 통해 얻을 수 있는 결과를 간단한 질의어를 써 구할 수 있다.
 - 하나의 테이블로 만든 VIEW에서는 DML문장을 수행 할 수 있지만 여러 테이블로 만든 VIEW에서는 DML문을 수행 할 수 없다. 단, UPDATE와 DELETE는 가능
 - 뷰의 목적은 SELECT다.

        create [or replace] view view명 // 별칭 하려면 ""로 감싸줘야한다.  [or replace] 같은 뷰 있으면 대체하겠다라는 뜻 
        as
        select 구문
        [with read only] // 뷰를 읽기 전용으로
        
        //생성
        create or replace view vw_emp("사원번호","이름","직무","입사일","부서코드")
        as
        select empno,ename,job, hiredate,deptno
        from emp
        order by sal;
        
         create or replace view VW_emp_dept
        as
        select E.*,dname,loc
        from emp E join dept d on e.deptno = d.deptno
        order by sal;
        
        
        //삭제
        drop view VW_EMP;
        
        drop view vw_emp_dept;
        
# 인덱스

- 행의 검색 속도를 향상 시킬 수 있는 개체
- 인덱스를 명시적 (Create index) 또는 자동적으로 (primary key, unique key)로 생성 할 수 있다.
- 컬럼에 대한 인덱스가 없으면 한 테이블 전체를 검색, 즉 인덱스는 쿼리의 성능을 향상 시키는 것이 목적
- Insert/update/delete가 많은 컬럼에 대해서 index를 되도록이면 설정하지 말아라
- 인덱스가 많은 것이 항상 좋은것은 아니다, 왜냐하면 인덱스를 가진 테이블에 대한 DML작업은 인덱스도 갱신되여 함을 의미하기 때문
- 인덱스는 수정 불가 수정시에는 삭제후 다시 생성

- 어느 컬럼에 인덱스를 설정하는가?!
    - WHERE조건이나 조인 조건에서 자주 사용되는 컬럼
    - 광범위한 값을 포함하는 컬럼
    - 많은 null값을 포함하는 칼럼
    - 테이블에 자료의 양이 적거나 자주 갱신되는 테이블은 오히려 인덱스를 걸지 말아라
           
          //생성
          Create index idx_emp on emp(deptno,sal,comm)  //조인이 많아서, 범위 넓어서, null이 많아서
          
          //삭제
          drop index idx_emp;
       

   
# DCL
# select

1]  || : 문장과 열 합칠 때
---
2]  ' ' : 문장
---
3]  AS : 별칭 (생략 가능)
---
    SELECT ename || '의 연봉은 ' || sal
    FROM emp;
    
    SELECT sal * 1.5 AS 연봉, sal
    FROM emp;
    
    SELECT sal * 1.5 연봉, sal
    FROM emp; //"" 생략 가능
    
    SELECT sal * 1.5 2021년의 연봉, sal
    FROM emp; //오류 별칭에 빈 공백이 나와서
    
    SELECT sal * 1.5 "2021년의 연봉", sal
    FROM emp; //" " 로 감싸줘면 된다.
    
    SELECT sal * 1.5 "2021's 연봉", sal //'를 사용하고 싶으면 무조건 "" 넣어야한다.
    FROM emp; 
    
    SELECT ename || '의 연봉은' || sal || '입니다.'.
    FROM emp;
    // 셀 이름이 ename || '의 연봉은' || sal || '입니다.'.   
 
    SELECT ename || '의 연봉은' || sal || '입니다.' 연봉
    FROM emp;
    // 셀 이름이 연봉
  
4] distinct : 중복행 제거 (키워드는 항상 SELECT 바로 다음에 기술한다.)
---
모든 칼럼이 영향 받는다.
    
    SELECT DISTINCT job 
    FROM emp; 
    
    SELECT DISTINCT job.deptno // 칼럼.칼럼 => & 연산
    FROM emp;

  
5] where절 : 특정행의 검색
---
  and, or, not은 그대로 기술
  
  Between a and b, in, like
    
    SELECT ename, sal
    FROM emp
    WHERE sal >=2000;

    SELECT enam, sal, job
    FROM emp
    WHERE sal >= 1500 and jab = 'SALESMAM'
    
    SELECT enam, sal, job
    FROM emp
    WHERE sal >= 1500 or jab = 'SALESMAM'
    
    SELECT ename, sal, job
    FROM emp
    WHERE jab <> 'SALESMAM';
    
    SELECT ename,sal
    FROM emp
    WHERE sal Between 2000 and 3000;
    
    SELECT ename,sal
    FROM emp
    WHERE sal >= 2000 and sal <= 3000;
    
    SELECT SYSDATE+1 //날짜 더하기 가능! Java는 안된다.
    FROM dual;
    
    SELCET ename.sal.hiredate
    FROM emp
    WHERE hiredate BETWEEN TO_DATE('81/01/01') AND TO_DATE('81/12/31') AND sal >= 2000;
    
    SELCET ename.sal.hiredate
    FROM emp
    WHERE hiredate BETWEEN '81/01/01' AND '81/12/31' AND sal >= 2000;
    
    SELECT empno,ename,job
    FROM emp
    WHERE job in('SALESMAN','CLERK');
    
    SELECT ename, job, deptno
    FROM emp
    WHERE (job,deptno) in (('CLERK',20),('SALESMAN',30))
    
    //위에거랑 똑같이 고급
    SELECT ename, job, deptno
    FROM emp
    WHERE job = 'CLERK' and deptno=20 or job='SALESMAN' and deptno=30
    
6] Like 연산자 : 검색 스트링 값에 대한 와일드 카드 검색
---
% : 임의의 0개이상의 문자열

_ : 임의의 한 글자
    
    SELECT ename
    FROM emp
    WHERE ename LIKE 'S%';
    
    SELECT ename
    FROM emp
    WHERE ename LIKE '%S';
    
    SELECT ename
    FROM emp
    WHERE ename LIKE '%A%';
    
    SELECT ename
    FROM emp
    WHERE ename LIKE '_A%';
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NULL;
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NOT NULL;
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NOT NULL and comm != 0;
    
    SELECT ename,job,comm
    FROM emp
    WHERE comm IS NOT NULL and NOT comm = 0;
    
    //문1
    SELECT empno, ename, job, sal
    FROM emp
    WHERE job = 'MANAGER' and sal Between 2500 and 3000;

    //문2
    SELECT ename,deptno sal, job
    FROM emp
    WHERE job != 'SALESMAN' and deptno = 30 and sal>=1500;
    
    //문3
    SELECT *
    FROM emp
    WHERE deptno in ('20','30') and sal < 2000;
    
    //문4
    SELECT *
    FROM emp
    WHERE comm IS NOT NULL and sal >= 1500;
    
    //문5
    SELECT FIRST_NAME || ' ' || LAST_NAME "성명", COMMISSION_PCT,SALARY
    FROM employees
    WHERE COMMISSION_PCT IS NOT NULL and SALARY >= 5000 and LAST_NAME LIKE 'S%'
    
    //문6
    SELECT FIRST_NAME || ' ' || LAST_NAME "성명", COMMISSION_PCT,SALARY
    FROM employees
    WHERE COMMISSION_PCT IS NOT NULL and SALARY >= 5000 and LAST_NAME LIKE '_a%'
    
    //문7
    SELECT FIRST_NAME || ' ' || LAST_NAME "성명", COMMISSION_PCT,SALARY
    FROM employees
    WHERE phone_number LIKE '011%'

7] Order By 절 사용한다
---
  
    SELECT ename, job, sal
    FROM emp;
    ORDER BY sal;
    
    SELECT ename, job,deptno
    FROM emp;
    ORDER BY job DESC, deptno;
    
    //문8
    SELECT *
    FROM emp
    ORDER BY sal DESC;
    
    //문9
    SELECT name, deptno, sal, comm
    FROM emp
    WHERE comm >= 100
    ORDER BY sal;
    
    //문10
    SELECT *
    FROM emp
    WHERE ename LIKE '%A%'
    ORDER BY sal,depto DESC;
    
8] Gropu by절
---
그룹함수는 Select문에서 단독으로 쓸 수 있으나, 다른 칼럼정보를 함께 출력할 수 없다.

Select절에서 group by절 이외 모든 컬럼 group by 해야한다.

ORDER BY절 전에 기술해야 한다

그룹에 대한 조건은 HAVING절에서 기술해야 한다.

쿼리 실행 순서 : FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
  
     SELCECT count(sal)
     FROM emp;
     
     SELCECT avg(sal)
     FROM emp; 
     
     SELCECT sum(sal)
     FROM emp;
     
     SELCECT max(sal)
     FROM emp;
     
     SELECT job,MAX(sal)
     From emp;
     Group by job;
     
     SELECT deptno,job,min(sal)
     FROM emp
     GROUP BY deptno, job;
     
     SELECT deptno,min(sal)
     FROM emp
     GROUP BY deptn;
     
     SELECT deptno,min(sal)
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno;
     //순서가 Where -> Gruop by
  
9] HAVING절 
---
GROUP BY절에 대한 조건

     SELECT deptno,min(sal)
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno
     HAVING min(sal) >= 2000;
     
     SELECT deptno,min(sal) 최소연봉 // (4) 별칭
     FROM emp // (1)
     WHERE sal >= 1000 // (2)
     GROUP BY deptno // (3)
     ORDER BY 최소연봉; // (5)
     
     
     SELECT deptno,min(sal) 최소연봉
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno
     HAVING 최소연봉 >= 1000
     ORDER BY 최소연봉;
     //오류난다  why? HAVING절이 SELECT절보다 먼저 읽는다. 최소연봉이라는 별칭이 들어오기전에 HAVING함
     
     SELECT deptno,min(sal) 최소연봉
     FROM emp
     WHERE sal >= 1000
     GROUP BY deptno
     HAVING min(sal) >= 1000
     ORDER BY 최소연봉; 
     //가능하다
     
     //문11
     SELECT count(*)
     FROM emp
     WHERE sal>=1000 and ename LIKE '%S';
  
# join

1] inner join
---

2개 이상의 테이블로부터 자료를 검색하기 위해서 Join을 사용한다.

일반적으로 pk와 fk을 사용하여 join하는 경우가 대부분

가장 많이 사용되는 조인문으로 테이블 간에 연결 조건을 모두 만족하는 행을 검색하는데 사용한다

검색시 검색되는 컬럼이 조인하는 테이블 모두에 존재한다면 반드시 컬럼명에 테이블 이름을 "테이블명.컬럼명'의 형태로 기술

자식테이블 레코드 10개, 부모테이블 레코드 100개 inner join하면 레코드 수는 10개
PK : 중복 X, Null X

테이블 칭을 명부여하여 긴 테이블 명을 간단하게 사용 (as 사용 불가)

    [정규 표현]
    SELECT 칼럼명
    FROM 테이블1 join 테이블2 On 테이블1.pk = 테이블2.fk
    join 테이블3 on 테이블2.pk = 테이블3.fk

    SELECT ename,sal,job,dname
    FROM emp e JOIN dept d ON e.deptno = d.deptno;

2] outer join
---
어느 한쪽 테이블에서 결과값을 모두 가져오는 join문이다.

어느 쪽 테이블에서 가져올지 즉 왼쪽인지 오른쪽인지 아니면 양쪽 테이블인지 반드시 기술해야 한다.

자식테이블 left outer join 부모테이블은 ineer join과 같다

RDMS는 full outer join 의미가 없다.

자식에 없는 부모 튜플도 outer join으로 알 수 있다. 
      
        SELECT 부모테이블 칼럼
        FROM 부모테이블 부 left outer join 자식테이블 자 on 부.pk = 자.fk;
        WHERE 자.pk is null


3] self join
---

# 서브쿼리 (SUBQUERY)

서브쿼리는 다른 하나의 SQL문장에 기술된 SELECT문장을 말한다

서브쿼리는 괄호로 묶어야 한다.

서브쿼리만을 단독 실행시 실행이 된다.

서브쿼리는 연산자의 오른쪽에 기술 되어야 한다.

단일행 서브 쿼리에는 단일행 연산자를 다중행 서브쿼리에는 복수행 연산자를 사용한다

서브쿼리는 SELECT, FROM, WHERE절 등에 위치할 수 있다

FROM절 서브쿼리를 쓸 때 SELECT이랑 칼럼이 같거나 더 커야함


    //문12
    SELECT sal, ename, job
    FROM emp
    where sal in ((select max(sal) from emp), (select min(sal) from emp))
    order by sal  
    
    //문13
    SELECT ename, sal, d.deptno, dname, hiredate
    from dept d join emp e on d.deptno = e.deptno
    where (e.deptno,sal) in (select e.deptno, max(sal) from emp e group by e.deptno)


# TOP쿼리

반드시 정렬되어야 한다

얻어진 질의 결과에서 위에서부터 순서대로 몇 개만 가져오는 경우에 사용함

데이터가 입력된 순서대로 혹은 서브쿼리에 의해 생성된 테이블에 레코드가 생성된 순서대로 내부적으로 번호가 순차적으로 부여되고 그 부여된 번호는 ROWNUM이라는 컬럼에 내부적으로 저장되어 있다.

    기본 구조
    Select * 
    from (select * from 테이블명 order by PK컬러명)
    where rownum <= n;
  
    select ename, sal, job
    from (select * from emp order by sal desc)
    where rownum <=3

1] 특정 구간에 있는 레코드
---

STEP 1] 서브쿼리안의 서브쿼리는 특정 컬럼으로 ORDER BY DESC 그리고 생성된 테이블 별칭을 부여

STEP 2] 서브쿼리안의 SELECT절에서 STEP1의 별칭.*,ROWNUM 컬럼별칭을 기술한다

STEP 3] 밖의 WHERE절에서 ROWNUM을 별칭한 이름으로 between a and b


혹시 top로 구해서 Not in 구하면 되는지,,
    SELECT * 
    FROM (SELECT T.*, ROWNUM R FROM(SELECT * FROM emp ORDER BY sal DESC)T)
    WHERE R BETWEEN 4 AND 6
    
    SELECT LAST_NAME || ' ' || FIRST_NAME name , SALARY, department_name, city
    FROM(SELECT T.*,ROWNUM R FROM(SELECT * FROM employees ORDER BY salary desc)T)e
    join departments d on e.department_id = d.department_id 
    join locations l on d.location_id = l.location_id
    WHERE R BETWEEN 11 and 20
    
    SELECT ename, sal, e.deptno, dname, hiredate
    FROM(SELECT T.*,ROWNUM R FROM(select * from emp order by sal)T)e
    join dept p on e.deptno = p.deptno
    WHERE R between 6 and 10
    
# DCL
 - 아래 작업은 DBA역할이 있는 최고 관리자(SYSTEM/SYS)로 접속해야 한다.

1] 사용자 생성 및 암호 설정
---
 - 사용자는 DB에 엑세스하기 위해 시스템 권한이 필요하고 DB 개체의 내용을 조작하기 위해 개체 권한이 필요하다
 - 시스템 권한의 종류는 200개 이상 개체권한은 28개
 - 시스템 권한은 주로 DBA가 부여한다.(SYS/SYSTEM)
 - DBA는 상급의 시스템권한을 부여한다.
 - 역할
    - DBA : 최고 권한
    - connect : DB에 엑세스 할 수 있는 권한
    - resource : 개체를 생성 할 수 있는 권한


           //시스템 권한 확인
           SELECT * FROM SYSTEM_PRIVILEGE_MAP
          //개체 권한 확인
          SELECT * FROM TABLE_PRIVILEGE_MAP          
          //사용자 목록 확인
          SELECT username from dba_users             // system 계정에서 해야함
          //사용자 구조
          desc DBA_USERS

          //생성
          CREATE USER 아이디 IDENTIFIED BY 암호            // 사용자는 생성된 후 어떠한 권한도 가지지 못한다.
          create user user03 identified by user03; //아이디 user03 비밀번호 user03
            
            
          //권한 부여
          Grant 시스템 권한1,[시스템 권한2...] | 역할1, [역할2...]
          to 사용자1,[사용자2...] | 역할1, [역할2...]
          [With admin option]                            // 받은 시스템 권한을 다른 사용자에게 부여 할 수 있는 권한
            
          grant connect, resource to user03; //테이블을 만들 수 있는 권한
          grant create view to user03;                  // 뷰를 만들 수 있는 권한
            
           
          //수정 
          alter user user03 identified by 1234; //비밀번호 1234 로 변경
            
          //계정 lock 걸고 풀기
          alter user user03 account lock;                   //lock
          alter user user03 account unlock identified by user03     // lock 풀자마자 비밀번호 변경
          
          
          //다른 계정에서 테이블 DCL 사용할 수 있는 권한 
          grant select, delete On scott.emp To user03;    //user03은 scott.emp 테이블 select,delete 할 수 있다.
          
          //삭제
          drop user user04 cascade
          
          
          
# PL/SQL
 - 프로그래밍 언어의 특성을 수용한 SQL의 확장
 - SQL의 데이터 조작(DML)과 질의문 블락 구조에 절차적 단위(IF, FOR, WHILE, LOOP등)로 된 커맨드를 포함 할 수 있음
 - PL/SQL블락내에서 한 문장이 종료할때마나 세미콜론(;)을 붙인다.
 - END뒤에 세미콜론(;)을 붙여 하나의 BLOCK이 끝났다는 것을 명시
 - 마지막에 반드시 / 를 붙여야 한다.
 - -- 한줄 주석
 - /* 여러줄 주석

1] PL/SQL 구조
---
- 변수명 [CONSTANT] 자료형 [NOT NULLL] [ := 초기값 | DEFAULT 초기값 ];
- 한 라인에 하나의 식별자만 가능
- 상수선언에서 CONSTANT는 자료형보다 먼저 기술
- 대소문자를 구분하지 않는다.

[PL:SQL](https://user-images.githubusercontent.com/79241184/112919510-364fca80-9142-11eb-98e0-b2d73956ac3d.png)

        DECLARE
            변수 및 상수, CURSOR, EXCEPTION 선언 등;         // 선언부 - 선택 사항
        BEGIN
            SQL, Pl/SQL문;                              // 실행부 - 필수 사항

            EXCEPTION
            BEGIN

            예외처리;                                     // 예외처리부 - 실행 사항

            END;

        END;
        /                                               // 반드시 붙여라!     

[1] 바인드 변수 선언
 - 호스트 환경에서 선언 된 변수
 - PL/SQL 프로그램의 내부나 외부에서 전달하기 위해서 사용
 - PL/SQL문이 프로시저나 함수 안에 잇지 않는다면 호스트에서 선언된 변수를 PL/SQL문장에서 참조 할 수 있다.
 - 호스트 변수와 PL/SQL내에서의 변수를 구분하기 위해 호스트 변수 앞에 콜론(:)을 붙인다.
 - 선언만 할 수 있고 호스트 변수는 선언시에 값을 할당 못한다.
 - dbms_output.put_line 사용하려면 set serverout ON; 해야한다.
 
        Var 변수명 자료형
        DECLARE
        BEGIN
        : 변수 := 300;
        end;
        /
        [1]
        var num number
        BEGIN
        :num := 14;
        end;
        /

        print num

        select :num from dual;

        [2]
        var str varchar2(10)
        declare
        fnum number :=1;
        snum number :=10;
        begin
        :num := fnum + snum;
        :str := '합은 ' || :num;
        end;
        /
        
        print num str;

        select :num, :str 
        from dual;
        
        print fnum;                 // 오류

[2] SELECT문
 - into절 사용해야 한다.
 - 무조건 레코드가 1개 나와야 한다. 아니면 오류!

        var dname varchar2(14)
        var loc varchar2(13)
        declare
        p_deptno dept.deptno%type :=30;
        begin 
        select dname, loc into :dname, :loc
        from dept
        where deptno = p_deptno;
        end;
        /
        
        print dname loc;
        
        select :dname, :loc
        from dual;
 
[3] if문
           
        if condition(조건식) then
            statements;
        [elsif condition then statemensts;]
        [else statements;]
        
        end if;
        
        var result nvarchar2(10)
        declare
        str nvarchar2(10) := 'JAVA';
        begin
            if str = 'Java' then
            begin
                dbms_output.put_line('Java');
                :result := 'Java';
            end;

            elsif str ='JaVa' then
            begin
                dbms_output.put_line('JaVa');
                :result := 'JaVa';
            end;

            else
                 dbms_output.put_line('JAVA');
                :result := 'JAVA';
            end if;
        end;
        /

        print result;

- 사용자에게 값을 입력 받기    

    accept p_num prompt '숫자를 입력하세요:' 
    
    &주의해라
    
        accept p_num prompt '숫자를 입력하세요:'
        declare 
        num number := &p_num;
        begin
            DBMS_OUTPUT.put_line('입력한 숫자는 ' || num);
            if mod(num,2) = 0 then
                DBMS_OUTPUT.put_line(num ||'은 짝수다');
            else
                DBMS_OUTPUT.put_line(num ||'은 홀수다');
            end if;
        end;
        /
        
        accept akor prompt '국어점수?'
        accept aeng prompt '영어점수?'
        accept amath prompt '수학점수?'
        declare
            kor number(3) := &akor;
            eng number(3) := &aeng;
            math number(3) := 0;
        begin
            dbms_output.put_line('성적 출력하기');
            if ((kor+eng+&amath)/3) >= 90 then
                 dbms_output.put_line('A');
            elsif ((kor+eng+&amath)/3) >= 80 then
                 dbms_output.put_line('B');
            elsif ((kor+eng+&amath)/3) >= 70 then
                 dbms_output.put_line('C');
            elsif ((kor+eng+&amath)/3) >= 60 then
                 dbms_output.put_line('D');
            else 
                 dbms_output.put_line('F');
            end if;
        end;
        /
        
        accept num prompt '숫자 입력'
        begin
        if(mod(&num,3)=0 and mod(&num,5)=0) then
            dbms_output.put_line('3과 5의 공배수');
        elsif(mod(&num,3)=0) then
            dbms_output.put_line('3의 배수');
        elsif(mod(&num,5)=0) then
            dbms_output.put_line('5의 배수');
        else 
            dbms_output.put_line('3과 5의 배수가 아니다');
        end if;
        end;
        /

        
[4] Loop문

 - do while문하고 똑같다

        Loop
        
            statement1;
            statement2;
            Exit [when condition];
            
        end loop;


        begin
            loop
                dbms_output.put_line('Hello World');
                exit;
            end loop;
        end;
        /
        
        accept num prompt '끝 숫자 입력하세요'
        declare
            hap number := 0;
            num number := &num;
        begin
            loop
                hap := hap+num;
                num := num -1;
                exit when num = 0;
            end loop;
            dbms_output.put_line(&num||'까지의 누적합:'||hap);
        end;
        /
        
        accept snum prompt '시작 숫자 입력하세요'
        accept enum prompt '끝 숫자 입력하세요'
        declare
            hap number := 0;
            snum number := &snum;
        begin
        if &snum >= &enum then
            dbms_output.put_line('시작값이 종료값보다 크거나 같아요');
        else 
                 loop
                    hap := hap+snum;
                    snum := snum+1;
                    exit when &enum < snum;
                end loop;
                dbms_output.put_line(&snum||'부터'||&enum||'까지의 누적합:'||hap);
        end if;
        end;
        /
        
[5] for문
 - 인덱스 터는 자도응로 선언된 변수
 - for문은 1씩밖에 증가 못한다.
 - 항상 초기값이 종료값보다 작아야한다.초기값이 더 크면 반복하지 않는다.

        begin
            for i in 1 ..10 loop
                dbms_output.put_line(i);
            end loop;
        end;
        /
        
        accept snum prompt '시작 숫자 입력하세요'
        accept enum prompt '끝 숫자 입력하세요'
        declare
            hap number := 0;
        begin
            for k in &snum .. &enum loop
                if mod(k,2) = 0 then
                    hap:= hap+k;
                end if;
            end loop;
            dbms_output.put_line(&snum||'부터'||&enum||'까지 짝수의 합'||hap);
        end;
        /
        
 - put하면 줄 띄우기 안하 반드시 줄 띄우기 라인 하나 만들어야 실행된다.
 
        begin
            dbms_output.put('A');
            dbms_output.put('가');
            dbms_output.new_line;
        end;
        
        
        begin
        for k in 1..4 loop
            for j in 1..4 loop
                if k=j then
                    dbms_output.put('1 ');
                else
                    dbms_output.put('0 ');
                end if;
            end loop;
                dbms_output.New_line;
        end loop;
        end;
        /
        
       
        begin
        for i in 1..9 loop
            for j in 2..9 loop
                dbms_output.put('  '||j || '  *  ' || i || '  =  ' || i*j);
            end loop;
            dbms_output.New_line;
        end loop;
        end;
        /
        
        create table member(
        id varchar2(10) primary key,
        pwd varchar2(10) not null,
        name nvarchar2(10) not null,
        regidate date default sysdate);


        accept cnt prompt '레코드 수 입력'
        begin
            for i in 1 .. &cnt loop
                insert into member(id,pwd,name)
                values('GA' ||i,'1234','가길동'||i);   
        end loop;
        end;
        /

[6] while문

        declare
        hap number := 0;
        i number := 1;
        begin
            while i <= 10 loop
                hap := hap + i;
                i:=i+1;
            end loop;
            dbms_output.put_line('1부터 10까지 누적 합:'||hap);
        end;
        /
        
        accept num prompt '숫자 입력'
        declare
            num number := &num;
        begin
            while true loop
                dbms_output.put_line('num은' || num);
                num := num -1;
                exit when num = 0;
            end loop;
        end;
        /
        
        declare
        i number := 1;
        j number;
        begin
            while i <= 9 loop
                j:=2;
                while j <=9 loop
                    dbms_output.put(j || '  *  ' || i || ' = ' || j*i|| '   ');
                    j := j+1;
                end loop;
                dbms_output.new_line;
                i := i+1;
            end loop;
        end;
        /

        
[7] SQL%FOUND
 - 영향 받은 행의 수?
        
        accept id prompt '삭제할 아이디'
        declare 
        id_ MEMBER.id%TYPE := '&id';
        begin
            delete MEMBER
            where id like '%' || id_ || '%';
            if SQL%found then
                dbms_output.put_line(SQL%ROWCOUNT||'행이 삭제 되었어요');
            else 
                dbms_output.put_line('그런 아이디는 없어요 : ' || SQL%rowcount);
            end if;
        end;
        /

[8] 예외처리

 - Exception : PL/SQl에서 발생하는 ERROR
 - ORACLE Server 에러가 발생하면 이와 관련된 EXCEPTION이 자동 발생
 
        accept id prompt '아이디 입력'
        declare
            name_ MEMBER.name%type;
            id_ MEMBER.id%type :='&id';
        begin
            --select id into id_ from member;
            select id,name
            into id_, name_
            from member
            where id = id_;
            DBMS_output.put_line('이름:' || name_);
            DBMS_output.put_line('이름:' || id_);


        exception -- 예외 처리부
        when TOO_MANY_ROWS then 
            dbms_output.put_line('여러개의 레코드가 검색되었어요');
        when NO_DATA_FOUND then
            dbms_output.put_line(ID_ ||'로 검색된 회원이 없어요.  ');
        when others then
            dbms_output.put_line('에러번호'||sqlcode);
            dbms_output.put_line('에러메시지'||sqlerrm);
        end;
        /
        
        
        accept num prompt '숫자 입력?'
        declare
            -- 변수 선언
            num varchar2(20);
            -- 예외 선언
            not_number exception;
            pragma exception_init(not_number,-01722);
        begin
            select 10 + '&num'
            into num
            from dual;
            dbms_output.put_line('당신의 10년 후 나이:' || num);
            --예외 처리부
            Exception
            when not_number then
                dbms_output.put_line('나이는 숫자만');
            when others then
                dbms_output.put_line('오류 발생'||SQLERRM);
        end;
        /
        
        accept num prompt '숫자 입력?'
        declare
            -- 예외 선언
            even_number exception;

        begin
            if mod('&num',2)=0 then
                raise even_number;
            end if;
            dbms_output.put_line('&num'||'는 홀수');
            --예외 처리부
            Exception
            when even_number then
                dbms_output.put_line('짝수는 안돼요');
            when others then
                dbms_output.put_line('오류 발생'||SQLERRM);
        end;
        /
        
[9] 트랜잭션
 - 일련의 작업에서 하나의 작업이라도 실패한다면 모든 작업을 취소 시킨다.
 - 일련의 작업이 정상적으로 끝나면 COMMIT한다.
 - 자동 COMMIT이 일어나는 경우
    - DDL/DCL문장 완료시 (create/alter/drop/grant/revoke)
    - SQL*PLUS 정상 종료시
 - 자동 ROLLBACK이 일어나는 경우
    - SQL*PLUS 비정상 종료시 혹은 시스템 실패 시



            select * from member;
            begin
            -- 수정 작업
            update member
            set name='코스모2'
            where id = 'GA3';

            --  삭제 작업
            delete member
            where id = 'kosmo';

            -- 입력 작업
            insert into member(id,pwd,name) 
            values('dfasdafsdfa',1234,'한소인');
            commit;
            dbms_output.put_line('일련의 작업(트랜잭션)이 성공했어요');

            exception
            when others then
                rollback;
                dbms_output.put_line('모든 작업이 취소되었어요');

            end;
            /



# 주요 내장 함수
 - 무조건 값을 반환한다.
 
1] NVL
---
 - NVL(컬럼명, NULL인 경우 대체할 값)

        select enmae, job, NVL(comm,-1) comm
        from emp;
        
        // null인 값 모두 -1로 반환

2] LOWER
---
 - LOWER('문자열') : 영문자를 소문자로 변환

        select lower('HELLO WORLD')
        from dual;
        
        select lower(ename), ename
        from emp;

3] UPPER
---
 - UPPER('문자열') : 영문자를 대문자로 변환

        select UPPER('hello world')
        from dual;
        
        select Upper(lower(ename)), ename
        from emp;
        
4] initcap
 ---
 - initcap('문자열') : 첫 글자만 대글자로 변경

        select ename, initcap(ename), job, initcap(job)
        from emp;

5] concat
---
 - concat('문자열','문자열') : 문자열 연결 

        select concat('ORACLE','JAVA')
        from dual;

6] LENGTH() 
--- 
 - LENGTH('문자열') : 문자열 길이

        select length('자바')
        from dual;

7] LENGTHB
---
 - LENGTHB('문자열') : 문자열 비트 길이

        select lengthb('자바')
        from dual;
        // 6
        
8] LPAD
---
 - LPAD('문자열',전체 자리수,'채울 문자열') : 좌측을 지정한 값으로 채운다

        select LPAD('HELLO',10,'X')
        from dual
        // HELLOXXXXX
        
9] RPAD
---
 - RPAD('문자열',전체 자리수,'채울 문자열') : 우측을 지정한 값으로 채운다
    
        select RPAD('HELLO',10,'X')
        from dual
        // XXXXXHELLO

10] INSTR
---
 - INSTR('문자열','찾을 문자열') : 찾은 문자열의 인덱스 변환, 인덱스는 1부터 시작
 - like 사용하는것보다 속도면에서 우수하다.
 - 없으면 0 반환

        select instr('ABCDEFG','DE') 
        from dual;
        // 4
        
        select ename
        from emp
        --where ename like 'S%';
        where instr(upper(ename),'S') =1;
        
        select ename
        from emp
        --where ename like '%S';
        where instr(upper(ename),'S') =length(ename);
        
        select ename
        from emp
        --where ename like '%S%';
        where instr(upper(ename),'S') != 0;
        
11] SUBSTR
---
 - SUBSTR('문자열',시작인덱스,길이) : 문자열에서 시작인덱스부터 길이만큼 가져옴, 인덱스는 1부터
 
        select substr('kosmo',3,3)
        from dual;
        // SMO
        
        select ename,RPAD(substr(ename,1,1),length(ename),'*')
        from emp;
       
12 REPLACE
---
 - REPLACE('문자열','찾을 문자열','바꿀 문자열')

        select replace ('HELLO WORLD','HELLO','JAVA')
        from dual;
        
        select replace(replace(upper(job),'MAN','WOMAN'),'WOMANAGER','MANAGER') job
        FROM emp;

13 TO_CHAR
---
 - TO_CHAR(숫자 혹은 날짜) : CHAR형으로 바꿔준다.
 - TO_CHAR(숫자, '숫자형식 포맷 문자열') 
    - 9는 값이 있으면 표시, 없으면 표시 안함
    - 0은 값이 있으면 표시, 없으면 0으로 표시
    - 단, 소수점은 9든 0이든 값이 없으면 모두 0으로 표시됨
    - 소수점은 실제값의 자리수가 많으면 나머지는 짤림
    - 정수인 경우는 실제값의 자리수가 많으면 값이 #으로 표시됨
            
            select to_char(1004,'99')
            from dual;
            // ###

            select to_char(1004,'9999')
            from dual;
            // 1004

            select to_char(1004,'9,999')
            from dual;
            // 1,004

            select to_char(1004,'$9,999')
            from dual;
            // $1,004

            select to_char(1004,'L9,999')
            from dual;
            // \1,004 (원)

            select to_char(3.1459,'999,999.99')
            from dual;
            // 3.15

            select to_char(3.1,'999,999.99')
            from dual;
            // 3.10
            
 - TO_CHAR(날짜,'날짜형식 포맷 문자열')
    - d : 요일 반환 (일요일은 1, 월요일은 2)
    - dd : 일
    - ddd : 365일 중 오늘 며칠째인지
    - day : 수요일
    - dy : 수
    
            select to_char(sysdate,'YYYY-mm-dd hh:mi:ss')
            from dual;

            select to_char(sysdate,'YYYY"년"mm"월"dd"일" hh:mi:ss')
            from dual;

            select to_char(sysdate,'ddd')
            from dual;
            // 90
            
            select sysdate +1 
            from dual;
            // 2021-04-01
            
            select to_date('2021-03-31') +1
            from dual;
            // 21-04-01
            
            select '내일은 ' || to_char(to_date('2021-03-31')+1,'yyyy-mm-dd') || '입니다'
            from dual;
            // 내일은 2021-04-01입니다.
            
            select to_char(to_date('2021-08-13') - sysdate,999)
            from dual;
            // 135
            
            select to_char(hiredate,'yyyy-mm-dd') hiredate
            from emp
            where '1981-05-01' >= hiredate;
            
            select months_between(sysdate,'2021-08-13')
            from dual;
            // -4
            
            select add_months(sysdate,2)
            from dual;
            // 21/05/31
            
            
14] MATH
---
- DECODE(컬럼,결과값1,값1,결과값2,값2,값3)

           select decode(upper(job),'CLERK','점원','MANAGER','매니져','기타') job
           from emp;
           
           select decode(deptno,'10','회계부','20','조사부','영업부') 부서
           from emp;
          
           select round(3.5) 
           from dual;
           // 4
           
           select floor(3.5)
           from dual;
           // 3
           
           select ceil(3.5)
           from dual;
           // 4
            
           select power(2,3)
           from dual;
           // 8
           
           select sqrt(9)
           from dual;
           // 3
           
15] CASE
---
    CASE 칼럼 WHEN '조건1' THEN '값1'
            WHEN '조건2' THEN '값2'
            ELSE '기타'
    end 별칭
    
    select 
    case deptno when 10 then '재정부'
    when 20 then '조사부'
    else '영업부'
    end 부서, ename
    from emp;
    
    select ename,
    case
    when sal >= 3000 then '고액 연봉'
    when sal >= 2000 then '중간 연봉'
    else '저액 연봉'
    end salary, sal
    from emp;

    select LAST_NAME, RPAD(substr(email,1,1),length(email),'*') email,
    case
    when salary >= 10000 then '고액 연봉'
    when salary >= 5000 then '중간'
    else '보통'
    end 등급
    ,to_char(salary,'$999,999') salary
    ,to_char(hire_date,'yyyy"년"mm"월"dd"일"') hire_date
    from employees
    where instr(last_name,'t') = length(last_name);

# CURSUR
 - select 문장에 의해 여러행이 RETURN되는 경우 각 행에 접근하기 위한 것

1] CURSOR 문법
---
        CURSOR 커서명 IS
            SELECT문장 ----- DECLARE부에서 한다
            (INTO절이 없는 SELECT문)
       
            OPEN 커서명
            
            FETCH 커서명 INTO{variable1[,variable2,...]};
            
            CLOSE 커서명
            
            
            
            accept deptno prompt '부서코드 입력'
            declare
                --커서 정의
                CURSOR mycursor is
                select ename,trim(to_char(sal,'$99,999')) sal, dname,loc
                from emp e join dept d on e.deptno= d.deptno
                where e.deptno = &deptno;
                --변수 정의
                ename_ emp.ename%type;
                sal_ varchar2(10);
                dname_ dept.dname%type;
                loc_ dept.loc%type;
            begin
                --커서 오픈
                open mycursor;

                --FETCH하기
                fetch mycursor 
                into ename_,sal_,dname_,loc_;

                while mycursor%found loop
                    --출력
                    dbms_output.put_line(ename_ || ' : ' || sal_ || ' : ' || dname_ || ' : ' || loc_);
                    --FETCH하기
                     fetch mycursor 
                     into ename_,sal_,dname_,loc_;
                end loop;
                --커서 닫기
                close mycursor;
            end;
            /
            
# FUNTION

 - 다른 계정에 함수 실행권한 주기
    - grant execute on 소유계정.함수명 to 부여받는 계정;
    - grant execute on scott.get to hr;




            create or replace function getsum(num1 number, num2 in number)
            --반환타입 정의
            return number  --자리수 지정, 세미콜론 X
            --함수 시작
            is
            --변수 선언
                hap number :=0;
            begin
                for i  in num1 .. num2 loop
                    hap := hap + i;
                end loop;
             return hap;
            end;
            /

            --호출 2가지 방법
            select getsum(1,10)
            from dual;

            var hap number;
            exec :hap := getsum(1,10)
            print hap;



            create or replace function get(en_ varchar2)
            return varchar2
            IS
            begin
               return  RPAD(substr(en_,1,1),length(en_),'*');
            end;
            /

            var ename_ varchar2;
            exec :ename_ := get('abcde')
            print ename_;

            select ename,get(ename)
            from emp;
            
            
            
            
            
            create or replace function getday(en_ date)
            return varchar2
            IS
            begin
               return  to_char(en_,'yyyy-mm-dd');
            end;

            select getday('21-08-13')
            from dual;

            select hiredate,getday(hiredate)
            from emp;


# 저장 프로시져
 - 프로시저는 RETURN문이 없다. OUT 매개변수로 값을 RETURN한다.
 - 저장 프로시져의 장점
    - 매우 좋은 성능 (여러명이 사용할 때 SQL문은 할때마다 parsing, 프로시져는 처음에 한번 만)
    - 보안성을 높일 수 있음
    - 다양한 처리가 가능
    - 네트웍의 부하를 줄일 수 있음
 - 무조건 EXECUTE해야한다.

        //입력값 받는 프로스져
        create or replace procedure SP_INS_MEMBER(
            id_ member.id%type,
            pwd member.pwd%type,
            name_ member.name%type,
            RTVAR out NVARCHAR2
        )
        IS
        begin
            insert into member(id,pwd,name)
            values(id_,pwd_,name_);

            if SQL%FOUND then 
                RTVAR := '입력 성공';
                COMMIT;
            end if;

            exception
                when others then
                    ROLLBACK;
                    RTVAL := '입력실패 - 중복키거나 입력 값이 크다';
        end;
        /
        
        VAR RTVAL NVARCHAR2(50)

        EXEC SP_INS_MEMBER('KIM','1234','김길동',:RTVAL)
        
        
        

        PRINT RTVAL

        SELECT * FROM MEMBER
        
        
        // 수정하는 프로시져
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
        exec SP_DEL_MEMBER('KOSMO',:return_var);
        print return_var;


        //회원아이디와 비밀번호를 받아 회원인지 판단하는 프로시져
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
        
        --회원인 경우
        exec SP_ismember('KIM','9999',:return_var);
        print return_var;

        --아이디는 일치하는데 비밀번호 틀린경우
        exec SP_ismember('KIM','99',:return_var);
        print return_var;

        -- 아이디 불 일치
        exec SP_ismember('KIM1','9999',:return_var);
        print return_var;
        
        
# 트리거
 - 자동으로 실행되는 프로시저의 한 종류, 직접 (exec) 실행 불가
 - 하나의 테이블에 최대 3개까지 트리거 적용 가능 단, 트리거 많을 수록 성능 저하 초래
 - 트리거 몸체(PL/SQL)안에는 COMMIT;,ROLLBACK불가
 - :NEW(변경 후), :OLD(변경 전) 임시테이블을 행 단위 트리거에서만 사용 가능
    
    
       //트리거 생성
       Create Trigger 트리거명
       타이밍 [Before/after] 이벤트[insert [or] | update [or] | delete]
       on 트리거를 걸 테이블 명
       [for each row] --- 생략시 문자단위 트리거
       [when 트리거 조건]
       declare
       begin
       end;
       /
       
       
       // after 테이블
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
        
        // before 트리거
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



        // 상품 트리거


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

