# Oracle

# 기본

1] 
---
DDL
DML
DCL


# select

1]  || : 문장과 열 합칠 때
  
2]  '' : 문장
  
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

어느 한쪽 테이블에서 결과각ㅂㅅ을 
모두

