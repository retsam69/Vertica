DROP TABLE st4hdc.APPOINTMENT;

CREATE TABLE st4hdc.APPOINTMENT
(
    HOSPCODE varchar(5) NOT NULL,
    PID varchar(15) NOT NULL,
    AN varchar(9),
    SEQ varchar(16) NOT NULL,
    DATE_SERV date NOT NULL,
    CLINIC varchar(5) NOT NULL,
    APDATE date NOT NULL,
    APTYPE varchar(3) NOT NULL,
    APDIAG varchar(6),
    PROVIDER varchar(15),
    D_UPDATE timestamp NOT NULL,
    CID varchar(13),
    HDC_DATE timestamp,
    SOURCE_DATA varchar(6)
);

ALTER TABLE st4hdc.APPOINTMENT ADD CONSTRAINT APPOINTMENT_PK PRIMARY KEY (HOSPCODE, PID, SEQ, APTYPE) ENABLED;

CREATE PROJECTION st4hdc.APPOINTMENT /*+createtype(A)*/ 
(
 HOSPCODE,
 PID,
 AN,
 SEQ,
 DATE_SERV,
 CLINIC,
 APDATE,
 APTYPE,
 APDIAG,
 PROVIDER,
 D_UPDATE,
 CID,
 HDC_DATE,
 SOURCE_DATA
)
AS
 SELECT APPOINTMENT.HOSPCODE,
        APPOINTMENT.PID,
        APPOINTMENT.AN,
        APPOINTMENT.SEQ,
        APPOINTMENT.DATE_SERV,
        APPOINTMENT.CLINIC,
        APPOINTMENT.APDATE,
        APPOINTMENT.APTYPE,
        APPOINTMENT.APDIAG,
        APPOINTMENT.PROVIDER,
        APPOINTMENT.D_UPDATE,
        APPOINTMENT.CID,
        APPOINTMENT.HDC_DATE,
        APPOINTMENT.SOURCE_DATA
 FROM st4hdc.APPOINTMENT
 ORDER BY APPOINTMENT.HOSPCODE,
          APPOINTMENT.PID,
          APPOINTMENT.SEQ,
          APPOINTMENT.APTYPE
SEGMENTED BY hash(APPOINTMENT.HOSPCODE, APPOINTMENT.PID, APPOINTMENT.SEQ, APPOINTMENT.APTYPE) ALL NODES KSAFE 1;

--SELECT MARK_DESIGN_KSAFE(1);
