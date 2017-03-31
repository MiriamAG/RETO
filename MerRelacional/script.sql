DROP TABLE AVISOS CASCADE CONSTRAINTS ;

DROP TABLE CENTROS CASCADE CONSTRAINTS ;

DROP TABLE CONDUCEN CASCADE CONSTRAINTS ;

DROP TABLE PARTE CASCADE CONSTRAINTS ;

DROP TABLE TRABAJADORES CASCADE CONSTRAINTS ;

DROP TABLE USUARIOS CASCADE CONSTRAINTS ;

DROP TABLE VEHICULOS CASCADE CONSTRAINTS ;

DROP TABLE VIAJE CASCADE CONSTRAINTS ;

CREATE TABLE AVISOS
  (
    IDAviso       NUMBER (7) NOT NULL ,
    Descripcion   VARCHAR2 (1000 CHAR) NOT NULL ,
    PARTE_IDViaje NUMBER NOT NULL
  ) ;
CREATE UNIQUE INDEX AVISOS__IDX ON AVISOS
  (
    PARTE_IDViaje ASC
  )
  ;
ALTER TABLE AVISOS ADD CONSTRAINT AVISOS_PK PRIMARY KEY ( IDAviso ) ;


CREATE TABLE CENTROS
  (
    IDCent       NUMBER (7) NOT NULL ,
    Nombre       VARCHAR2 (50 CHAR) NOT NULL ,
    Calle        VARCHAR2 (200 CHAR) NOT NULL ,
    Numero       NUMBER (7) NOT NULL ,
    Ciudad       VARCHAR2 (50 CHAR) ,
    CodigoPostal NUMBER (7) NOT NULL ,
    Provincia    VARCHAR2 (50 CHAR) NOT NULL ,
    Telefono     NUMBER (7) NOT NULL
  ) ;
ALTER TABLE CENTROS ADD CONSTRAINT CENTROS_PK PRIMARY KEY ( IDCent ) ;


CREATE TABLE CONDUCEN
  (
    TRABAJADORES_IDLog NUMBER NOT NULL ,
    VEHICULOS_IDVehi   NUMBER NOT NULL ,
    Fecha              DATE
  ) ;
ALTER TABLE CONDUCEN ADD CONSTRAINT CONDUCEN_PK PRIMARY KEY ( TRABAJADORES_IDLog, VEHICULOS_IDVehi ) ;


CREATE TABLE PARTE
  (
    IDParte            NUMBER (7) NOT NULL ,
    Fecha              DATE NOT NULL ,
    KmInicial          NUMBER (7) NOT NULL ,
    KmFinal            NUMBER (7) NOT NULL ,
    GastosPeaje        NUMBER (7,2) ,
    GastosDietas       NUMBER (7,2) ,
    GastosCombustible  NUMBER (7,2) ,
    GastosOtros        NUMBER (7,2) ,
    Incidencias        VARCHAR2 (1000 CHAR) ,
    NotaAdministrativa VARCHAR2 (1000 CHAR)
  ) ;
ALTER TABLE PARTE ADD CONSTRAINT VALIDACION_PK PRIMARY KEY ( IDParte ) ;


CREATE TABLE TRABAJADORES
  (
    ID              NUMBER (7) NOT NULL ,
    DNI             VARCHAR2 (10 CHAR) NOT NULL ,
    Nombre          VARCHAR2 (50 CHAR) NOT NULL ,
    PrimerApellido  VARCHAR2 (50 CHAR) NOT NULL ,
    SegundoApellido VARCHAR2 (50 CHAR) ,
    Categoria       VARCHAR2 (50 CHAR) NOT NULL ,
    Calle           VARCHAR2 (200 CHAR) NOT NULL ,
    Numero          NUMBER (7) NOT NULL ,
    Piso            NUMBER (7) ,
    Mano            VARCHAR2 (15 CHAR) ,
    Ciudad          VARCHAR2 (50 CHAR) NOT NULL ,
    CodigoPostal    NUMBER (7) NOT NULL ,
    Provincia       VARCHAR2 (50 CHAR) ,
    MovilEmpresa    NUMBER (13) NOT NULL ,
    MovilPersonal   NUMBER (13) ,
    Salario         NUMBER (10,2) ,
    FechaNacimiento DATE ,
    CENTROS_IDCent  NUMBER NOT NULL
  ) ;

ALTER TABLE TRABAJADORES ADD CONSTRAINT TRABAJADORES_PK PRIMARY KEY ( ID ) ;


CREATE TABLE USUARIOS
  (
    Usuario         VARCHAR2 (50 CHAR) NOT NULL ,
    Password        VARCHAR2 (20 CHAR) NOT NULL ,
    TRABAJADORES_ID NUMBER NOT NULL
  ) ;
CREATE UNIQUE INDEX USUARIOS__IDX ON USUARIOS
  (
    TRABAJADORES_ID ASC
  )
  ;
ALTER TABLE USUARIOS ADD CONSTRAINT USUARIOS_PK PRIMARY KEY ( Usuario ) ;


CREATE TABLE VEHICULOS
  (
    IDVehi    NUMBER (7) NOT NULL ,
    Matricula VARCHAR2 (10 CHAR) NOT NULL ,
    Marca     VARCHAR2 (50 CHAR) NOT NULL ,
    Modelo    VARCHAR2 (50 CHAR) NOT NULL ,
    Km        NUMBER (7) NOT NULL
  ) ;
ALTER TABLE VEHICULOS ADD CONSTRAINT VEHICULOS_PK PRIMARY KEY ( IDVehi ) ;


CREATE TABLE VIAJE
  (
    IDViaje            NUMBER (7) NOT NULL ,
    HoraInicio         NUMBER (4,2) NOT NULL ,
    HoraFinal          NUMBER (4,2) NOT NULL ,
    Fecha              DATE NOT NULL ,
    TRABAJADORES_ID    NUMBER NOT NULL ,
    VALIDACION_IDParte NUMBER NOT NULL ,
    Estado             CHAR (1) NOT NULL
  ) ;

ALTER TABLE VIAJE ADD CONSTRAINT PARTE_PK PRIMARY KEY ( IDViaje ) ;


ALTER TABLE AVISOS ADD CONSTRAINT AVISOS_PARTE_FK FOREIGN KEY ( PARTE_IDViaje ) REFERENCES VIAJE ( IDViaje ) ;

ALTER TABLE CONDUCEN ADD CONSTRAINT FK_ASS_2 FOREIGN KEY ( TRABAJADORES_IDLog ) REFERENCES TRABAJADORES ( ID ) ;

ALTER TABLE CONDUCEN ADD CONSTRAINT FK_ASS_3 FOREIGN KEY ( VEHICULOS_IDVehi ) REFERENCES VEHICULOS ( IDVehi ) ;

ALTER TABLE VIAJE ADD CONSTRAINT PARTE_TRABAJADORES_FK FOREIGN KEY ( TRABAJADORES_ID ) REFERENCES TRABAJADORES ( ID ) ;

ALTER TABLE VIAJE ADD CONSTRAINT PARTE_VALIDACION_FK FOREIGN KEY ( VALIDACION_IDParte ) REFERENCES PARTE ( IDParte ) ;

ALTER TABLE TRABAJADORES ADD CONSTRAINT TRABAJADORES_CENTROS_FK FOREIGN KEY ( CENTROS_IDCent ) REFERENCES CENTROS ( IDCent ) ON
DELETE CASCADE ;

ALTER TABLE USUARIOS ADD CONSTRAINT USUARIOS_TRABAJADORES_FK FOREIGN KEY ( TRABAJADORES_ID ) REFERENCES TRABAJADORES ( ID ) ON
DELETE CASCADE ;