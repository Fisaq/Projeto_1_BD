/*QUESTÃO 1*/
SELECT
	CONCAT(o.fname, "," , o.lname) "Nome ADM",
    b.name "Empresa",
    c.city "Local"
FROM
	officer o,
    business b,
    customer c
WHERE
    c.cust_id = b.cust_id
    AND
    o.cust_id = b.cust_id;

/*QUESTÃO 2*/

SELECT DISTINCT
	CASE c.cust_type_cd
    	when "B" THEN b.name
        ELSE CONCAT(i.fname, " ", i.lname)
    END "Cliente"
FROM
	individual i,
    business b,
    customer c,
    branch br,
    account a
WHERE
	a.open_branch_id = br.branch_id
    AND
    (c.cust_id = i.cust_id
    OR
    b.cust_id = c.cust_id)
    AND
    a.cust_id = c.cust_id
    AND
    br.city != c.city;
 
 /*QUESTÃO 3*/
 
 SELECT
 	CONCAT(e.fname, " " ,e.lname) "Funcionário",
    YEAR(a.open_date) "Ano",
    COUNT(1) "Transações p/ano"
 FROM
 	employee e,
    account a
 WHERE
 	e.emp_id = a.open_emp_id
 GROUP BY
 	 e.emp_id, YEAR(a.open_date)
 order by 
 	e.fname,
    e.start_date,
    YEAR(a.open_date);

/*QUESTÃO 4*/

SELECT DISTINCT
	CASE c.cust_type_cd
    	when "B" THEN b.name
        ELSE CONCAT(i.fname, " ", i.lname)
    END "Cliente",
    a.account_id,
    br.name
FROM
	(SELECT
     max(a.avail_balance) "max"
    FROM
     	branch br,
    	account a
     WHERE
     	br.branch_id = a.open_branch_id
     GROUP BY 
 		br.branch_id) i2,
	individual i,
    business b,
    customer c,
    branch br,
    account a
WHERE
	a.open_branch_id = br.branch_id
    AND
    (c.cust_id = i.cust_id
    OR
    b.cust_id = c.cust_id)
    AND
    a.cust_id = c.cust_id
    AND
    i2.max = a.avail_balance;
