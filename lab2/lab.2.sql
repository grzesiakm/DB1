CREATE TABLE  emp (empno NUMERIC(4,0) PRIMARY KEY,               
                   ename VARCHAR(10),
                   job VARCHAR(10),
                   comm NUMERIC(7,2),
                   mgr VARCHAR(10),
                   sal NUMERIC (7,2),
                   deptno INT
);
              
INSERT INTO emp (empno, ename, job, mgr, sal, deptno) VALUES (7369, 'Smith', 'clerk', 7902, 800, 20);
INSERT INTO emp (empno, ename, job, mgr, sal, comm, deptno) VALUES (7499, 'Allen', 'salesman', 7698, 1600, 300, 30);
INSERT INTO emp (empno, ename, job, mgr, sal, comm, deptno) VALUES (7521, 'Ward', 'salesman', 7698, 1250, 500, 30);
INSERT INTO emp (empno, ename, job, mgr, sal, deptno) VALUES (7566, 'Jones','manager', 7839, 2975, 20);
INSERT INTO emp (empno, ename, job, mgr, sal, comm, deptno) VALUES (7654, 'Martin', 'salesman', 7698, 1250, 1400, 30);

SELECT deptno, ename, mgr FROM emp;

SELECT (sal+250)*12 FROM emp;

SELECT DISTINCT deptno FROM emp;
 
SELECT * FROM emp WHERE mgr='CLERK';

SELECT * FROM emp WHERE job='CLERK';

SELECT * FROM emp WHERE comm>sal;

SELECT * FROM emp WHERE sal BETWEEN 1000 AND 2000;

SELECT * FROM emp WHERE ename LIKE 'S%';

SELECT * FROM emp WHERE LENGTH(ename)=4;

SELECT * FROM emp WHERE mgr IS NULL;

SELECT * FROM emp WHERE ename NOT LIKE 'M%';
