*********************CURRENT DAY IS BREAKING PREVIOUS MONTH HIGH CLOSING********************************

SELECT 
PRV_M.SYMBOL,
PRV_M.prev_mon_max_close,CUR_D."Close",
CASE WHEN PRV_M.prev_mon_max_close >= CUR_D."Close" THEN 0 ELSE 1 END AS PRV_MON_CLS_BO
FROM
(SELECT SYMBOL,prev_mon_max_close FROM (
SELECT DISTINCT PREV_MON.SYMBOL,
PREV_MON.prev_mon_max_close,curr_m.curr_mon_max_close,
PREV_MON.prev_mon_max_volume,curr_m.curr_mon_max_volume,
CASE WHEN PREV_MON.prev_mon_max_close >= curr_m.curr_mon_max_close THEN 0 ELSE 1 END AS CLS_BO,
CASE WHEN PREV_MON.prev_mon_max_volume >= curr_m.curr_mon_max_volume THEN 0 ELSE 1 END AS VOL_BO
FROM 
(SELECT SYMBOL,MAX("Close") as prev_mon_max_close,MAX(Volume) AS prev_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE-30 , 'mm') FROM SYS.DUAL )
GROUP BY SYMBOL ) PREV_MON
INNER JOIN 
(SELECT SYMBOL,MAX("Close") as curr_mon_max_close,MAX(Volume) AS curr_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE , 'mm') FROM SYS.DUAL ) AND 
"Date" <> (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual)
GROUP BY SYMBOL ) curr_m
ON PREV_MON.SYMBOL = curr_m.SYMBOL
) WHERE CLS_BO = 0) PRV_M
INNER JOIN
(SELECT SYMBOL ,"Close",Volume FROM MARKET.T1 t WHERE "Date" = (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual)) CUR_D
ON PRV_M.SYMBOL = CUR_D.SYMBOL;



==============================================================================================================
CODE
==============================================================================================================
CREATE OR REPLACE VIEW MARKET.V_CUR_D_BO_PRV_MON_CLS AS 
SELECT 
PRV_M.SYMBOL,
PRV_M.prev_mon_max_close,CUR_D."Close",
CASE WHEN PRV_M.prev_mon_max_close >= CUR_D."Close" THEN 0 ELSE 1 END AS PRV_MON_CLS_BO
FROM
(SELECT SYMBOL,prev_mon_max_close FROM (
SELECT DISTINCT PREV_MON.SYMBOL,
PREV_MON.prev_mon_max_close,curr_m.curr_mon_max_close,
PREV_MON.prev_mon_max_volume,curr_m.curr_mon_max_volume,
CASE WHEN PREV_MON.prev_mon_max_close >= curr_m.curr_mon_max_close THEN 0 ELSE 1 END AS CLS_BO,
CASE WHEN PREV_MON.prev_mon_max_volume >= curr_m.curr_mon_max_volume THEN 0 ELSE 1 END AS VOL_BO
FROM 
(SELECT SYMBOL,MAX("Close") as prev_mon_max_close,MAX(Volume) AS prev_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE-30 , 'mm') FROM SYS.DUAL )
GROUP BY SYMBOL ) PREV_MON
INNER JOIN 
(SELECT SYMBOL,MAX("Close") as curr_mon_max_close,MAX(Volume) AS curr_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE , 'mm') FROM SYS.DUAL ) AND 
"Date" <> (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual)
GROUP BY SYMBOL ) curr_m
ON PREV_MON.SYMBOL = curr_m.SYMBOL
) WHERE CLS_BO = 0) PRV_M
INNER JOIN
(SELECT SYMBOL ,"Close",Volume FROM MARKET.T1 t WHERE "Date" = (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual)) CUR_D
ON PRV_M.SYMBOL = CUR_D.SYMBOL;


DROP TABLE MARKET.T_CUR_D_BO_PRV_MON_CLS;

CREATE TABLE MARKET.T_CUR_D_BO_PRV_MON_CLS AS SELECT * FROM MARKET.V_CUR_D_BO_PRV_MON_CLS;





*********************CURRENT DAY IS BREAKING PREVIOUS MONTH HIGH VOLUME********************************
SELECT 
PRV_M.SYMBOL,
PRV_M.prev_mon_max_volume,CUR_D.Volume,
CASE WHEN PRV_M.prev_mon_max_volume >= CUR_D.Volume THEN 0 ELSE 1 END AS PRV_MON_VOL_BO
FROM
(SELECT SYMBOL,prev_mon_max_volume FROM (
SELECT DISTINCT PREV_MON.SYMBOL,
PREV_MON.prev_mon_max_volume,curr_m.curr_mon_max_volume,
CASE WHEN PREV_MON.prev_mon_max_volume >= curr_m.curr_mon_max_volume THEN 0 ELSE 1 END AS VOL_BO
FROM 
(SELECT SYMBOL ,MAX(Volume) AS prev_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE-30 , 'mm') FROM SYS.DUAL )
GROUP BY SYMBOL ) PREV_MON
INNER JOIN 
(SELECT SYMBOL,MAX(Volume) AS curr_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE-1 , 'mm') FROM SYS.DUAL ) AND 
"Date" <> (SELECT TO_CHAR(SYSDATE-1, 'YYYY-MM-DD') FROM dual)
GROUP BY SYMBOL ) curr_m
ON PREV_MON.SYMBOL = curr_m.SYMBOL
) WHERE VOL_BO = 0) PRV_M
INNER JOIN
(SELECT SYMBOL ,Volume FROM MARKET.T1 t WHERE "Date" = (SELECT TO_CHAR(SYSDATE-1, 'YYYY-MM-DD') FROM dual)) CUR_D
ON PRV_M.SYMBOL = CUR_D.SYMBOL;


==============================================================================================================
CODE
==============================================================================================================
CREATE OR REPLACE VIEW MARKET.V_CUR_D_BO_PRV_MON_VOL AS 
SELECT 
PRV_M.SYMBOL,
PRV_M.prev_mon_max_volume,CUR_D.Volume,
CASE WHEN PRV_M.prev_mon_max_volume >= CUR_D.Volume THEN 0 ELSE 1 END AS PRV_MON_VOL_BO
FROM
(SELECT SYMBOL,prev_mon_max_volume FROM (
SELECT DISTINCT PREV_MON.SYMBOL,
PREV_MON.prev_mon_max_volume,curr_m.curr_mon_max_volume,
CASE WHEN PREV_MON.prev_mon_max_volume >= curr_m.curr_mon_max_volume THEN 0 ELSE 1 END AS VOL_BO
FROM 
(SELECT SYMBOL ,MAX(Volume) AS prev_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE-30 , 'mm') FROM SYS.DUAL )
GROUP BY SYMBOL ) PREV_MON
INNER JOIN 
(SELECT SYMBOL,MAX(Volume) AS curr_mon_max_volume FROM MARKET.T1 t 
WHERE SUBSTR("Date",6,2) = (SELECT TO_CHAR(SYSDATE , 'mm') FROM SYS.DUAL ) AND 
"Date" <> (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual)
GROUP BY SYMBOL ) curr_m
ON PREV_MON.SYMBOL = curr_m.SYMBOL
) WHERE VOL_BO = 0) PRV_M
INNER JOIN
(SELECT SYMBOL ,Volume FROM MARKET.T1 t WHERE "Date" = (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM dual)) CUR_D
ON PRV_M.SYMBOL = CUR_D.SYMBOL;


DROP TABLE MARKET.T_CUR_D_BO_PRV_MON_VOL;

CREATE TABLE MARKET.T_CUR_D_BO_PRV_MON_VOL AS SELECT * FROM MARKET.V_CUR_D_BO_PRV_MON_VOL;





*********************SUPERTREND IS IN BUYING AS OF TODAY********************************
SELECT cnt1.symbol , cnt0.cnt0 AS no_of_0, cnt1.cnt1 AS no_of_1
FROM 
(SELECT SYMBOL ,count("in-uptrend") AS cnt1 FROM MARKET.T1 t WHERE "in-uptrend" = 1 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt1
INNER  JOIN 
(SELECT SYMBOL ,count("in-uptrend") AS cnt0 FROM MARKET.T1 t WHERE "in-uptrend" = 0 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt0
ON cnt1.symbol = cnt0.symbol 
WHERE cnt1.cnt1 = 1
;

==============================================================================================================
CODE :- VIEW IS MORE THAN ENOUGH TO GAIN INSIGHTS -- SUPERTREND AS OF TODAY
==============================================================================================================

CREATE OR REPLACE VIEW MARKET.V_BUY_ST_AS_OF_TODAY AS 
SELECT cnt1.symbol , cnt0.cnt0 AS no_of_0, cnt1.cnt1 AS no_of_1
FROM 
(SELECT SYMBOL ,count("in-uptrend") AS cnt1 FROM MARKET.T1 t WHERE "in-uptrend" = 1 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt1
INNER  JOIN 
(SELECT SYMBOL ,count("in-uptrend") AS cnt0 FROM MARKET.T1 t WHERE "in-uptrend" = 0 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt0
ON cnt1.symbol = cnt0.symbol 
WHERE cnt1.cnt1 = 1
;

DROP TABLE MARKET.t_BUY_ST_AS_OF_TODAY;

CREATE TABLE MARKET.T_BUY_ST_AS_OF_TODAY AS SELECT * FROM MARKET.V_BUY_ST_AS_OF_TODAY;


==============================================================================================================
CODE :- VIEW IS MORE THAN ENOUGH TO GAIN INSIGHTS -- SUPERTREND AS OF YESTERDAY
==============================================================================================================

CREATE OR REPLACE VIEW MARKET.V_BUY_ST_AS_OF_YSTRDY AS 
SELECT cnt1.symbol , cnt0.cnt0 AS no_of_0, cnt1.cnt1 AS no_of_1
FROM 
(SELECT SYMBOL ,count("in-uptrend") AS cnt1 FROM MARKET.T1 t WHERE "in-uptrend" = 1 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt1
INNER  JOIN 
(SELECT SYMBOL ,count("in-uptrend") AS cnt0 FROM MARKET.T1 t WHERE "in-uptrend" = 0 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt0
ON cnt1.symbol = cnt0.symbol 
WHERE cnt1.cnt1 = 2
;


==============================================================================================================
CODE :- VIEW IS MORE THAN ENOUGH TO GAIN INSIGHTS -- SUPERTREND AS OF DAY BEFORE YESTERDAY
==============================================================================================================

CREATE OR REPLACE VIEW MARKET.V_BUY_ST_AS_OF_D_BFR_YSTRDY AS 
SELECT cnt1.symbol , cnt0.cnt0 AS no_of_0, cnt1.cnt1 AS no_of_1
FROM 
(SELECT SYMBOL ,count("in-uptrend") AS cnt1 FROM MARKET.T1 t WHERE "in-uptrend" = 1 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt1
INNER  JOIN 
(SELECT SYMBOL ,count("in-uptrend") AS cnt0 FROM MARKET.T1 t WHERE "in-uptrend" = 0 AND "Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) GROUP BY SYMBOL) cnt0
ON cnt1.symbol = cnt0.symbol 
WHERE cnt1.cnt1 = 3
;



==============================================================================================================
CODE :- VIEW IS MORE THAN ENOUGH TO GAIN INSIGHTS -- SUPERTREND WHERE CHANGE HAS HAPPANED WITH IN 10 DAYS
==============================================================================================================

CREATE OR REPLACE  VIEW MARKET.V_BUY_ST_AVGG AS
SELECT 
DISTINCT T.*, T2.AVGG
FROM 
MARKET.T1 t 
INNER JOIN 
(SELECT * FROM (
SELECT SYMBOL , AVG("in-uptrend") avgg FROM (
SELECT DISTINCT * FROM MARKET.T1 t 
WHERE --"Date" =  (SELECT TO_CHAR(SYSDATE-1, 'YYYY-MM-DD') FROM dual) AND 
"Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual)
) GROUP BY SYMBOL 
) WHERE avgg NOT IN (0,1) ORDER BY avgg ASC ) T2
ON T.SYMBOL = T2.SYMBOL AND T."Date" > (SELECT TO_CHAR(SYSDATE-10, 'YYYY-MM-DD') FROM dual) 
ORDER BY T2.AVGG ASC,T.SYMBOL ASC,T."Date" ASC;


