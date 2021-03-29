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
          
          
            
          
          
          //다른 계정에서 테이블 DCL 사용할 수 있는 권한
          //다른 계정에서 테이블 DCL 사용할 수 있는 권한 
234


