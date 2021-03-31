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