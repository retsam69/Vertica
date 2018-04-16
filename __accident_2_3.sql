DROP TABLE st4hdc.ACCIDENT;

CREATE TABLE st4hdc.ACCIDENT
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    SEQ varchar(16) NOT NULL,
    DATETIME_SERV timestamp NOT NULL,
    DATETIME_AE timestamp,
    AETYPE varchar(2),
    AEPLACE varchar(2) NOT NULL,
    TYPEIN_AE varchar(1) NOT NULL,
    TRAFFIC varchar(1),
    VEHICLE varchar(2),
    ALCOHOL varchar(1) NOT NULL,
    NACROTIC_DRUG varchar(1) NOT NULL,
    BELT varchar(1),
    HELMET varchar(1),
    AIRWAY varchar(1) NOT NULL,
    STOPBLEED varchar(1) NOT NULL,
    SPLINT varchar(1) NOT NULL,
    FLUID varchar(1) NOT NULL,
    URGENCY varchar(1) NOT NULL,
    COMA_EYE varchar(1),
    COMA_SPEAK varchar(1),
    COMA_MOVEMENT varchar(1),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.ACCIDENT ADD CONSTRAINT ACCIDENT_PK PRIMARY KEY (HOSPCODE, PID, SEQ, DATETIME_SERV) ENABLED;

CREATE PROJECTION st4hdc.ACCIDENT /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 SEQ,
 DATETIME_SERV,
 DATETIME_AE,
 AETYPE,
 AEPLACE,
 TYPEIN_AE,
 TRAFFIC,
 VEHICLE,
 ALCOHOL,
 NACROTIC_DRUG,
 BELT,
 HELMET,
 AIRWAY,
 STOPBLEED,
 SPLINT,
 FLUID,
 URGENCY,
 COMA_EYE,
 COMA_SPEAK,
 COMA_MOVEMENT,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT ACCIDENT.HOSPCODE,
        ACCIDENT.PID,
        ACCIDENT.SEQ,
        ACCIDENT.DATETIME_SERV,
        ACCIDENT.DATETIME_AE,
        ACCIDENT.AETYPE,
        ACCIDENT.AEPLACE,
        ACCIDENT.TYPEIN_AE,
        ACCIDENT.TRAFFIC,
        ACCIDENT.VEHICLE,
        ACCIDENT.ALCOHOL,
        ACCIDENT.NACROTIC_DRUG,
        ACCIDENT.BELT,
        ACCIDENT.HELMET,
        ACCIDENT.AIRWAY,
        ACCIDENT.STOPBLEED,
        ACCIDENT.SPLINT,
        ACCIDENT.FLUID,
        ACCIDENT.URGENCY,
        ACCIDENT.COMA_EYE,
        ACCIDENT.COMA_SPEAK,
        ACCIDENT.COMA_MOVEMENT,
        ACCIDENT.D_UPDATE,
        ACCIDENT.CID,
        ACCIDENT.HDC_DATE,
        ACCIDENT.SOURCE_DATA
 FROM st4hdc.ACCIDENT
 ORDER BY ACCIDENT.HOSPCODE,
          ACCIDENT.PID,
          ACCIDENT.SEQ,
          ACCIDENT.DATETIME_SERV
SEGMENTED BY hash(ACCIDENT.HOSPCODE, ACCIDENT.PID, ACCIDENT.SEQ, ACCIDENT.DATETIME_SERV) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
