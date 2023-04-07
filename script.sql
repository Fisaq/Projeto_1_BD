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
 
 /*QUESTÃO 5*/
 
    CREATE VIEW Identificadores AS
SELECT
    CONCAT(i.fname, " ", i.lname) "Cliente",
    i.cust_id "IdCliente",
    a.account_id "IdConta",
    br.branch_id "IdAgencia",
    a.avail_balance "Saldo",
    c.city "Cidade"
FROM
    individual i,
    account a,
    branch br,
    customer c
WHERE
    br.branch_id = a.open_branch_id
    AND
    a.cust_id = c.cust_id
    AND
    c.cust_id = i.cust_id
union
SELECT
    b.name,
    b.cust_id,
    a.account_id,
    br.branch_id,
    a.avail_balance,
    c.city
FROM
    business b,
    account a,
    branch br,
    customer c
WHERE
    br.branch_id = a.open_branch_id
    AND
    a.cust_id = c.cust_id
    AND
    c.cust_id = b.cust_id;
    
 /*Visualização da 2*/
SELECT DISTINCT
    Cliente
FROM
    Identificadores id,
    branch br
WHERE
	id.IdAgencia = br.branch_id
    AND
    id.Cidade != br.city;
    
 /*Visulaização da 4*/
SELECT
    IdConta,
    Cliente,
    br.name "Nome"
FROM
    Identificadores id,
    branch br,
	(SELECT
     	    IdAgencia,	
     	    MAX(Saldo) "max"
        FROM
     	    Identificadores
        GROUP BY
     	    IdAgencia) cl2
WHERE
    id.Saldo = cl2.max
    AND
    id.IdAgencia = cl2.IdAgencia
    AND
    id.IdAgencia = br.branch_id
ORDER BY
    id.IdAgencia;
