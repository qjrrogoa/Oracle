 accept deptno prompt '�μ��ڵ� �Է�'
            declare
                --Ŀ�� ����
                CURSOR mycursor is
                select ename,trim(to_char(sal,'$99,999')) sal, dname,loc
                from emp e join dept d on e.deptno= d.deptno
                where e.deptno = &deptno;
                --���� ����
                ename_ emp.ename%type;
                sal_ varchar2(10);
                dname_ dept.dname%type;
                loc_ dept.loc%type;
            begin
                --Ŀ�� ����
                open mycursor;

                --FETCH�ϱ�
                fetch mycursor 
                into ename_,sal_,dname_,loc_;

                while mycursor%found loop
                    --���
                    dbms_output.put_line(ename_ || ' : ' || sal_ || ' : ' || dname_ || ' : ' || loc_);
                    --FETCH�ϱ�
                     fetch mycursor 
                     into ename_,sal_,dname_,loc_;
                end loop;
                --Ŀ�� �ݱ�
                close mycursor;
            end;
            /