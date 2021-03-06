DROP TABLE st4hdc.CHARGE_OPD;

CREATE TABLE st4hdc.CHARGE_OPD
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16) NOT NULL,
    DATE_SERV date NOT NULL,
    CLINIC varchar(5) NOT NULL,
    CHARGEITEM varchar(2) NOT NULL,
    CHARGELIST varchar(6) NOT NULL,
    QUANTITY numeric(11,0),
    INSTYPE varchar(4) NOT NULL,
    COST numeric(11,2),
    PRICE numeric(11,2) NOT NULL,
    PAYPRICE numeric(11,2),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.CHARGE_OPD ADD CONSTRAINT CHARGE_OPD_PK PRIMARY KEY (HOSPCODE, PID, SEQ, DATE_SERV, CHARGEITEM, CHARGELIST, INSTYPE) ENABLED;

CREATE PROJECTION st4hdc.CHARGE_OPD /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 DATE_SERV,
 CLINIC,
 CHARGEITEM,
 CHARGELIST,
 QUANTITY,
 INSTYPE,
 COST,
 PRICE,
 PAYPRICE,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT CHARGE_OPD.HOSPCODE,
        CHARGE_OPD.PID,
        CHARGE_OPD.SEQ,
        CHARGE_OPD.DATE_SERV,
        CHARGE_OPD.CLINIC,
        CHARGE_OPD.CHARGEITEM,
        CHARGE_OPD.CHARGELIST,
        CHARGE_OPD.QUANTITY,
        CHARGE_OPD.INSTYPE,
        CHARGE_OPD.COST,
        CHARGE_OPD.PRICE,
        CHARGE_OPD.PAYPRICE,
        CHARGE_OPD.D_UPDATE,
        CHARGE_OPD.CID,
        CHARGE_OPD.HDC_DATE,
        CHARGE_OPD.SOURCE_DATA
 FROM st4hdc.CHARGE_OPD
 ORDER BY CHARGE_OPD.HOSPCODE,
          CHARGE_OPD.PID,
          CHARGE_OPD.SEQ,
          CHARGE_OPD.DATE_SERV,
          CHARGE_OPD.CHARGEITEM,
          CHARGE_OPD.CHARGELIST,
          CHARGE_OPD.INSTYPE
SEGMENTED BY hash(CHARGE_OPD.HOSPCODE, CHARGE_OPD.PID, CHARGE_OPD.SEQ, CHARGE_OPD.DATE_SERV, CHARGE_OPD.CHARGEITEM, CHARGE_OPD.CHARGELIST, CHARGE_OPD.INSTYPE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
