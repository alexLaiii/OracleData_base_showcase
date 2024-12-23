


SELECT prod_name, prod_sell
FROM products
WHERE UPPER(prod_type) LIKE 'SPORT WEAR'
AND prod_sell < (SELECT MIN(prod_sell)
                FROM products
                WHERE UPPER(prod_type)
                NOT LIKE 'SPORT WEAR')
ORDER by 2 desc,1;


SELECT prod_no, prod_name, prod_type
FROM products
WHERE prod_type LIKE (SELECT prod_type
                    FROM products
                    WHERE prod_sell = (SELECT MAX(prod_sell)
                                        FROM products));
                                        
                                        
SELECT to_char(sysdate+1, 'Month" "dd" of year "yyyy') AS "tomorrow"
FROM dual;


SELECT city, country_cd, NVL(prov_state, 'State Missing')
FROM customers
WHERE city LIKE 's_______%';


