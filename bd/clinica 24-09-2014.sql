/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50538
Source Host           : localhost:3306
Source Database       : clinica

Target Server Type    : MYSQL
Target Server Version : 50538
File Encoding         : 65001

Date: 2014-09-24 18:04:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bieregdocumento
-- ----------------------------
DROP TABLE IF EXISTS `bieregdocumento`;
CREATE TABLE `bieregdocumento` (
  `nBieRegCodigo` int(11) NOT NULL,
  `cDocCodigo` varchar(100) NOT NULL,
  `nBieRegDocEstado` int(11) NOT NULL,
  PRIMARY KEY (`nBieRegCodigo`,`cDocCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bieregdocumento
-- ----------------------------

-- ----------------------------
-- Table structure for docbieregdistribucion
-- ----------------------------
DROP TABLE IF EXISTS `docbieregdistribucion`;
CREATE TABLE `docbieregdistribucion` (
  `cDocCodigo` varchar(20) NOT NULL,
  `estado` int(11) DEFAULT NULL,
  `nAlmOrigen` int(11) NOT NULL,
  `nAlmDestino` int(11) NOT NULL,
  `nBieRegCodigo` int(11) NOT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cDocCodigo`,`nBieRegCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of docbieregdistribucion
-- ----------------------------

-- ----------------------------
-- Table structure for docbieregistro
-- ----------------------------
DROP TABLE IF EXISTS `docbieregistro`;
CREATE TABLE `docbieregistro` (
  `cDocCodigo` varchar(15) CHARACTER SET latin1 NOT NULL,
  `nNroItem` int(11) NOT NULL,
  `nBieRegCodigo` int(11) NOT NULL,
  `nEstado` int(11) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`nNroItem`,`nBieRegCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docbieregistro
-- ----------------------------

-- ----------------------------
-- Table structure for doccompdetvalor
-- ----------------------------
DROP TABLE IF EXISTS `doccompdetvalor`;
CREATE TABLE `doccompdetvalor` (
  `cDocCodigo` varchar(15) CHARACTER SET latin1 NOT NULL,
  `nNroItem` int(11) NOT NULL,
  `nMoneda` int(11) NOT NULL,
  `fValor` double(11,2) NOT NULL,
  `fDescuento` double(11,2) DEFAULT NULL,
  `fIGV` double(11,2) DEFAULT NULL,
  `dGravado` date DEFAULT NULL,
  PRIMARY KEY (`cDocCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doccompdetvalor
-- ----------------------------

-- ----------------------------
-- Table structure for doccomprobante
-- ----------------------------
DROP TABLE IF EXISTS `doccomprobante`;
CREATE TABLE `doccomprobante` (
  `cDocCodigo` varchar(15) CHARACTER SET latin1 NOT NULL,
  `nTipo` int(11) NOT NULL,
  `nMoneda` int(11) NOT NULL,
  `fmonto` float(11,0) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`nTipo`,`nMoneda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doccomprobante
-- ----------------------------

-- ----------------------------
-- Table structure for doccontenido
-- ----------------------------
DROP TABLE IF EXISTS `doccontenido`;
CREATE TABLE `doccontenido` (
  `cDocCodigo` varchar(15) NOT NULL,
  `nDocParCodigo` int(11) NOT NULL,
  `nDocParClase` int(11) NOT NULL,
  `cDocConContenido` text NOT NULL,
  `nDocConEstado` int(11) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`nDocParCodigo`,`nDocParClase`),
  UNIQUE KEY `idx_pk` (`cDocCodigo`,`nDocParClase`,`nDocParCodigo`) USING BTREE,
  UNIQUE KEY `nDocParCodigo_UNIQUE` (`nDocParCodigo`) USING BTREE,
  UNIQUE KEY `nDocParClase_UNIQUE` (`nDocParClase`) USING BTREE,
  KEY `idx_clase_codigo` (`nDocParClase`,`nDocParCodigo`) USING BTREE,
  KEY `idx_cdoccodigo` (`cDocCodigo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of doccontenido
-- ----------------------------

-- ----------------------------
-- Table structure for docestado
-- ----------------------------
DROP TABLE IF EXISTS `docestado`;
CREATE TABLE `docestado` (
  `cDocCodigo` varchar(15) NOT NULL,
  `nDocParCodigo` int(11) unsigned NOT NULL,
  `nDocParClase` int(11) unsigned NOT NULL,
  `dDocEstFecha` datetime NOT NULL,
  `cDocEstGlosa` text,
  PRIMARY KEY (`cDocCodigo`,`nDocParCodigo`,`nDocParClase`,`dDocEstFecha`),
  UNIQUE KEY `idx_pk` (`cDocCodigo`,`nDocParClase`,`nDocParCodigo`,`dDocEstFecha`) USING BTREE,
  KEY `idx_cdoccodigo` (`cDocCodigo`) USING BTREE,
  KEY `idex_clase_codigo` (`nDocParClase`,`nDocParCodigo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docestado
-- ----------------------------

-- ----------------------------
-- Table structure for docidentifica
-- ----------------------------
DROP TABLE IF EXISTS `docidentifica`;
CREATE TABLE `docidentifica` (
  `cDocCodigo` varchar(15) NOT NULL,
  `nDocTipoNum` int(11) NOT NULL,
  `cDocNDoc` varchar(100) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`nDocTipoNum`),
  UNIQUE KEY `idx_pk` (`cDocCodigo`,`nDocTipoNum`) USING BTREE,
  KEY `idx_cdocndoc` (`cDocNDoc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docidentifica
-- ----------------------------

-- ----------------------------
-- Table structure for docparametro
-- ----------------------------
DROP TABLE IF EXISTS `docparametro`;
CREATE TABLE `docparametro` (
  `cDocCodigo` varchar(15) NOT NULL,
  `nParClase` int(11) unsigned NOT NULL,
  `nParCodigo` int(11) unsigned NOT NULL,
  `cDocParObservacion` varchar(500) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`nParClase`,`nParCodigo`),
  UNIQUE KEY `idx_pk` (`cDocCodigo`,`nParClase`,`nParCodigo`) USING BTREE,
  UNIQUE KEY `cDocCodigo_UNIQUE` (`cDocCodigo`) USING BTREE,
  KEY `idx_cdoccodigo` (`cDocCodigo`) USING BTREE,
  KEY `idx_clase_codigo` (`nParClase`,`nParCodigo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docparametro
-- ----------------------------

-- ----------------------------
-- Table structure for docparparametro
-- ----------------------------
DROP TABLE IF EXISTS `docparparametro`;
CREATE TABLE `docparparametro` (
  `cDocCodigo` varchar(20) CHARACTER SET latin1 NOT NULL,
  `nParSrcCodigo` int(11) NOT NULL,
  `nParSrcClase` int(11) NOT NULL,
  `nParDstCodigo` int(11) NOT NULL,
  `nParDstClase` int(11) NOT NULL,
  `cParParValor` varchar(250) CHARACTER SET latin1 DEFAULT NULL,
  `cParParGlosa` text CHARACTER SET latin1,
  PRIMARY KEY (`cDocCodigo`,`nParSrcCodigo`,`nParSrcClase`,`nParDstCodigo`,`nParDstClase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docparparametro
-- ----------------------------

-- ----------------------------
-- Table structure for docperparametro
-- ----------------------------
DROP TABLE IF EXISTS `docperparametro`;
CREATE TABLE `docperparametro` (
  `cDocCodigo` varchar(20) NOT NULL,
  `cPerCodigo` varchar(20) NOT NULL,
  `nParCodigo` int(11) NOT NULL,
  `nParClase` int(11) NOT NULL,
  `cDocPerParValor` varchar(500) DEFAULT NULL,
  `cDocPerParGlosa` text,
  `nDocPerParEstado` int(4) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`cPerCodigo`,`nParCodigo`,`nParClase`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of docperparametro
-- ----------------------------

-- ----------------------------
-- Table structure for docpersona
-- ----------------------------
DROP TABLE IF EXISTS `docpersona`;
CREATE TABLE `docpersona` (
  `cDocCodigo` varchar(15) NOT NULL,
  `nDocPerTipo` int(11) NOT NULL,
  `cPerCodigo` varchar(20) NOT NULL,
  `nPerRelacion` int(11) NOT NULL,
  `nDocTipo` int(11) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`nDocPerTipo`,`cPerCodigo`,`nPerRelacion`,`nDocTipo`),
  UNIQUE KEY `id_pk` (`cDocCodigo`,`nDocPerTipo`,`cPerCodigo`,`nPerRelacion`,`nDocTipo`) USING BTREE,
  KEY `idx_cdoccodigo` (`cDocCodigo`) USING BTREE,
  KEY `idx_cpercodigo` (`cPerCodigo`) USING BTREE,
  KEY `idx_cdoc_ndoc_cper` (`cDocCodigo`,`nDocPerTipo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docpersona
-- ----------------------------

-- ----------------------------
-- Table structure for docref
-- ----------------------------
DROP TABLE IF EXISTS `docref`;
CREATE TABLE `docref` (
  `cDocCodigo` varchar(15) NOT NULL DEFAULT '',
  `cDocRefCodigo` varchar(15) NOT NULL,
  PRIMARY KEY (`cDocCodigo`,`cDocRefCodigo`),
  UNIQUE KEY `idx_pk` (`cDocCodigo`,`cDocRefCodigo`) USING BTREE,
  KEY `idx_cdoccodigo` (`cDocCodigo`) USING BTREE,
  KEY `idx_cdocrefcodigo` (`cDocRefCodigo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docref
-- ----------------------------

-- ----------------------------
-- Table structure for docrefdestino
-- ----------------------------
DROP TABLE IF EXISTS `docrefdestino`;
CREATE TABLE `docrefdestino` (
  `cDocCodigo` varchar(15) CHARACTER SET latin1 NOT NULL,
  `cLugarOrigen` text CHARACTER SET latin1 NOT NULL,
  `nOrigTipo` int(11) NOT NULL,
  `cOrigDireccion` varchar(200) CHARACTER SET latin1 NOT NULL,
  `cOrigManz` varchar(100) CHARACTER SET latin1 NOT NULL,
  `cOrigLote` varchar(100) CHARACTER SET latin1 NOT NULL,
  `nOrigTipoRes` int(11) NOT NULL,
  `cOrigResidencia` varchar(200) CHARACTER SET latin1 NOT NULL,
  `cLugarDestino` text CHARACTER SET latin1 NOT NULL,
  `nDestTipo` int(11) NOT NULL,
  `cDestDireccion` varchar(200) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`cDocCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docrefdestino
-- ----------------------------

-- ----------------------------
-- Table structure for documento
-- ----------------------------
DROP TABLE IF EXISTS `documento`;
CREATE TABLE `documento` (
  `cDocCodigo` varchar(15) NOT NULL,
  `dDocFecha` datetime NOT NULL,
  `cDocObservacion` varchar(1000) NOT NULL,
  `nDocTipo` int(11) NOT NULL,
  `nDocEstado` tinyint(3) NOT NULL,
  PRIMARY KEY (`cDocCodigo`),
  UNIQUE KEY `idx_cdoccodigo` (`cDocCodigo`) USING BTREE,
  KEY `idx_cdoccodigo_ndoctipo` (`cDocCodigo`,`nDocTipo`) USING BTREE,
  KEY `idx_nDocTipo` (`nDocTipo`) USING BTREE,
  KEY `idx_nEstado` (`nDocEstado`,`cDocCodigo`,`nDocTipo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of documento
-- ----------------------------

-- ----------------------------
-- Table structure for docvigencia
-- ----------------------------
DROP TABLE IF EXISTS `docvigencia`;
CREATE TABLE `docvigencia` (
  `cDocCodigo` varchar(15) NOT NULL,
  `dFecha` date NOT NULL,
  `dFechaFin` date NOT NULL,
  `dHora` datetime NOT NULL,
  PRIMARY KEY (`cDocCodigo`),
  UNIQUE KEY `Codigo` (`cDocCodigo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of docvigencia
-- ----------------------------

-- ----------------------------
-- Table structure for parametro
-- ----------------------------
DROP TABLE IF EXISTS `parametro`;
CREATE TABLE `parametro` (
  `nParCodigo` int(11) unsigned NOT NULL,
  `nParClase` int(11) NOT NULL,
  `cParJerarquia` varchar(20) NOT NULL,
  `cParNombre` varchar(100) NOT NULL,
  `cParDescripcion` varchar(500) NOT NULL,
  `nParEstado` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`nParClase`,`nParCodigo`),
  UNIQUE KEY `idx_pk_parametro` (`nParCodigo`,`nParClase`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parametro
-- ----------------------------
INSERT INTO `parametro` VALUES ('0', '1000', '10', 'ESTADO CIVIL', '.:::. ESTADO CIVIL (CONYUGAL) .:::.', '0');
INSERT INTO `parametro` VALUES ('1', '1000', '1001', 'Soltero', 'Soltero', '1');
INSERT INTO `parametro` VALUES ('2', '1000', '1002', 'Casado', 'Casado', '1');
INSERT INTO `parametro` VALUES ('3', '1000', '1003', 'Viudo', 'Viudo', '1');
INSERT INTO `parametro` VALUES ('4', '1000', '1004', 'Divorciado', 'Divorciado', '1');
INSERT INTO `parametro` VALUES ('5', '1000', '1005', 'Conviviente', 'Conviviente', '1');
INSERT INTO `parametro` VALUES ('0', '1002', '10', 'SEXO', '.:::. SEXO .:::.', '0');
INSERT INTO `parametro` VALUES ('1', '1002', '1001', 'M', 'Masculino', '1');
INSERT INTO `parametro` VALUES ('2', '1002', '1002', 'F', 'Femenino', '1');
INSERT INTO `parametro` VALUES ('0', '1005', '10', 'RUBRO O ACTIVIDAD COMERCIAL', '.:::. RUBRO O ACTIVIDAD COMERCIAL .:::.', '0');
INSERT INTO `parametro` VALUES ('1', '1005', '1001', 'AGRICULTURA, GANADERÍA CAZA Y SILVICULTURA', 'AGRICULTURA, GANADERÍA CAZA Y SILVICULTURA', '1');
INSERT INTO `parametro` VALUES ('2', '1005', '1002', 'PESCA', 'PESCA', '1');
INSERT INTO `parametro` VALUES ('3', '1005', '1003', 'EXPLOTACIÓN DE MINAS Y CANTERAS', 'EXPLOTACIÓN DE MINAS Y CANTERAS', '1');
INSERT INTO `parametro` VALUES ('4', '1005', '1004', 'INDUSTRIAS MANUFACTURERAS NO METÁLICAS', 'INDUSTRIAS MANUFACTURERAS NO METÁLICAS', '1');
INSERT INTO `parametro` VALUES ('5', '1005', '1005', 'INDUSTRIAS MANUFACTURERAS METÁLICAS', 'INDUSTRIAS MANUFACTURERAS METÁLICAS', '1');
INSERT INTO `parametro` VALUES ('6', '1005', '1006', 'SUMINISTRO DE ELECTRICIDAD, GAS Y AGUA', 'SUMINISTRO DE ELECTRICIDAD, GAS Y AGUA', '1');
INSERT INTO `parametro` VALUES ('7', '1005', '1007', 'CONSTRUCCIÓN', 'CONSTRUCCIÓN', '1');
INSERT INTO `parametro` VALUES ('10', '1005', '1010', 'TRANSPORTE, ALMACENAMIENTO Y COMUNICACIONES', 'TRANSPORTE, ALMACENAMIENTO Y COMUNICACIONES', '1');
INSERT INTO `parametro` VALUES ('11', '1005', '1011', 'INTERMEDIACIÓN FINANCIERA', 'INTERMEDIACIÓN FINANCIERA', '1');
INSERT INTO `parametro` VALUES ('13', '1005', '1013', 'ADM. PÚBLICA Y DEFENSA; PLANES DE SEG. SOCIAL, AFILIACIÓN OBLIGATORIA', 'ADM. PÚBLICA Y DEFENSA; PLANES DE SEG. SOCIAL, AFILIACIÓN OBLIGATORIA', '1');
INSERT INTO `parametro` VALUES ('0', '1010', '10', 'Tipos De Documentos', 'Tipos De Documentos', '0');
INSERT INTO `parametro` VALUES ('1', '1010', '11', 'Documento Nacional De Identidad', 'DNI', '1');
INSERT INTO `parametro` VALUES ('2', '1010', '12', 'Registro Unico Del Contribuyente', 'RUC', '1');
INSERT INTO `parametro` VALUES ('10', '5000', '10', 'MODULO SISTEMA WEB', 'MODULO SISTEMA WEB', '0');
INSERT INTO `parametro` VALUES ('1001', '5000', '1001', '{\"icono\":{\"bsClase\":\"glyphicon glyphicon-th-list\",\"color\":\"cl-verde\"}}', 'Tablas maestras', '1');
INSERT INTO `parametro` VALUES ('100101', '5000', '100101', '{\"nParClase\":\"1010\",\"nombreRuta\":\"personas\"}', 'Personas', '1');
INSERT INTO `parametro` VALUES ('10010101', '5001', '10010101', '{\"nombre\":\"Agregar\",\"clase\":\"agregar\",\"icono\":\"glyphicon glyphicon-plus-sign\"}', 'Nuevo', '1');
INSERT INTO `parametro` VALUES ('10010102', '5001', '10010102', '{\"nombre\":\"Editar\",\"clase\":\"editar\",\"icono\":\"glyphicon glyphicon-edit\"}', 'Editar', '1');
INSERT INTO `parametro` VALUES ('10010103', '5001', '10010103', '{\"nombre\":\"Eliminar\",\"clase\":\"eliminar\",\"icono\":\"glyphicon glyphicon-trash\"}', 'Eliminar', '1');

-- ----------------------------
-- Table structure for pardetalle
-- ----------------------------
DROP TABLE IF EXISTS `pardetalle`;
CREATE TABLE `pardetalle` (
  `nParCodigo` int(11) unsigned NOT NULL,
  `nParClase` int(11) unsigned NOT NULL,
  `nParItem` int(11) unsigned NOT NULL,
  `nParItemS` int(11) unsigned NOT NULL,
  `cParDetValor` varchar(250) CHARACTER SET utf8 NOT NULL,
  `cParDetGlosa` text CHARACTER SET utf8,
  PRIMARY KEY (`nParCodigo`,`nParClase`,`nParItem`,`nParItemS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of pardetalle
-- ----------------------------

-- ----------------------------
-- Table structure for parimagen
-- ----------------------------
DROP TABLE IF EXISTS `parimagen`;
CREATE TABLE `parimagen` (
  `nParCodigo` int(11) unsigned NOT NULL,
  `nParClase` int(11) unsigned NOT NULL,
  `nParImgTipo` int(11) unsigned NOT NULL,
  `cParImgRuta` varchar(1000) NOT NULL,
  `cParImgGlosa` text,
  `nParImgEstado` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`nParCodigo`,`nParClase`,`nParImgTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parimagen
-- ----------------------------

-- ----------------------------
-- Table structure for parparametro
-- ----------------------------
DROP TABLE IF EXISTS `parparametro`;
CREATE TABLE `parparametro` (
  `nParSrcCodigo` int(11) unsigned NOT NULL DEFAULT '0',
  `nParSrcClase` int(11) unsigned NOT NULL,
  `nParDstCodigo` int(11) unsigned NOT NULL,
  `nParDstClase` int(11) unsigned NOT NULL,
  `cValor` varchar(250) DEFAULT NULL,
  `nParParEstado` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`nParSrcCodigo`,`nParSrcClase`,`nParDstCodigo`,`nParDstClase`),
  UNIQUE KEY `idx_pk_all` (`nParSrcCodigo`,`nParSrcClase`,`nParDstCodigo`,`nParDstClase`) USING BTREE,
  KEY `idx_pk_src` (`nParSrcCodigo`,`nParSrcClase`) USING BTREE,
  KEY `idx_pk_dst` (`nParDstCodigo`,`nParDstClase`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parparametro
-- ----------------------------
INSERT INTO `parparametro` VALUES ('100101', '5000', '10010101', '5001', 'Nuevo', '1');
INSERT INTO `parparametro` VALUES ('100101', '5000', '10010102', '5001', 'Editar', '1');
INSERT INTO `parparametro` VALUES ('100101', '5000', '10010103', '5001', 'Eliminar', '1');

-- ----------------------------
-- Table structure for parparext
-- ----------------------------
DROP TABLE IF EXISTS `parparext`;
CREATE TABLE `parparext` (
  `nIntSrcCodigo` int(11) unsigned NOT NULL,
  `nIntSrcClase` int(11) unsigned NOT NULL,
  `nIntDstCodigo` int(11) unsigned NOT NULL,
  `nIntDstClase` int(11) unsigned NOT NULL,
  `nObjCodigo` int(11) unsigned NOT NULL,
  `nObjTipo` int(11) unsigned NOT NULL,
  `cValor` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`nIntSrcCodigo`,`nIntSrcClase`,`nIntDstCodigo`,`nIntDstClase`,`nObjCodigo`,`nObjTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of parparext
-- ----------------------------

-- ----------------------------
-- Table structure for percuenta
-- ----------------------------
DROP TABLE IF EXISTS `percuenta`;
CREATE TABLE `percuenta` (
  `nPerCtaCodigo` int(11) NOT NULL AUTO_INCREMENT,
  `cPerCodigo` varchar(20) CHARACTER SET latin1 NOT NULL,
  `cNroCuenta` varchar(20) CHARACTER SET latin1 NOT NULL,
  `nPerCtaTipo` int(11) unsigned NOT NULL,
  `cPerJurCodigo` varchar(20) CHARACTER SET latin1 NOT NULL,
  `nMonCodigo` int(11) unsigned NOT NULL,
  `nPerCtaEstado` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`nPerCtaCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of percuenta
-- ----------------------------

-- ----------------------------
-- Table structure for perdireccion
-- ----------------------------
DROP TABLE IF EXISTS `perdireccion`;
CREATE TABLE `perdireccion` (
  `cPerCodigo` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Codigo de la Persona a la que le pertenece esta direccion',
  `nUbiCodigo` int(11) NOT NULL COMMENT 'Codigo del ubigeo de esta direccion',
  `nPerDirTipo` int(11) NOT NULL COMMENT 'Codigo del tipo de la direccion (Casa - trabajo)',
  `cPerDirDescripcion` varchar(500) CHARACTER SET latin1 NOT NULL COMMENT 'Descripcion de la direccion',
  `cPerDirGlosa` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `nPerDirEstado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Se registra la diferentes direcciones de una persona';

-- ----------------------------
-- Records of perdireccion
-- ----------------------------
INSERT INTO `perdireccion` VALUES ('1000000001', '0', '1', 'Dirección 43', null, '0');
INSERT INTO `perdireccion` VALUES ('1000000001', '0', '1', 'Dirección 43', null, '0');
INSERT INTO `perdireccion` VALUES ('1000000001', '0', '1', 'Dirección 44', null, '0');
INSERT INTO `perdireccion` VALUES ('1000000001', '0', '1', 'Dirección 45', null, '1');

-- ----------------------------
-- Table structure for perdocumento
-- ----------------------------
DROP TABLE IF EXISTS `perdocumento`;
CREATE TABLE `perdocumento` (
  `cPerCodigo` varchar(20) NOT NULL COMMENT 'Codigo de la Persona a la que le pertenece este documento. ',
  `nPerDocTipo` int(11) NOT NULL COMMENT 'Codigo del tipo de documento',
  `cPerDocNumero` varchar(50) NOT NULL COMMENT 'Numero del documento',
  `dPerDocCaducidad` date NOT NULL,
  `nPerDocCategoria` int(11) DEFAULT NULL,
  `nPerDocEstado` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cPerCodigo`,`nPerDocTipo`,`cPerDocNumero`),
  UNIQUE KEY `idx_pk_PerDocumento` (`cPerCodigo`,`nPerDocTipo`) USING BTREE,
  UNIQUE KEY `idx_cPerDocNumero` (`cPerDocNumero`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Se registra los diferentes documentos de una persona ';

-- ----------------------------
-- Records of perdocumento
-- ----------------------------
INSERT INTO `perdocumento` VALUES ('1000000001', '1', '1234567810', '0000-00-00', '0', '0');
INSERT INTO `perdocumento` VALUES ('1000000001', '2', '9876543210', '0000-00-00', '0', '1');

-- ----------------------------
-- Table structure for perimagen
-- ----------------------------
DROP TABLE IF EXISTS `perimagen`;
CREATE TABLE `perimagen` (
  `cPerCodigo` varchar(10) NOT NULL,
  `cPerRuta` varchar(50) NOT NULL,
  `nPerTipo` int(11) NOT NULL,
  `nPerEstado` int(11) NOT NULL,
  PRIMARY KEY (`cPerCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of perimagen
-- ----------------------------

-- ----------------------------
-- Table structure for perjuridica
-- ----------------------------
DROP TABLE IF EXISTS `perjuridica`;
CREATE TABLE `perjuridica` (
  `cPerCodigo` varchar(20) NOT NULL,
  `nPerJurRubro` int(11) NOT NULL,
  `cPerJurDescripcion` varchar(250) NOT NULL,
  `nPerEmpresa` int(11) NOT NULL,
  PRIMARY KEY (`cPerCodigo`),
  UNIQUE KEY `idx_pk_cPerCodigo` (`cPerCodigo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of perjuridica
-- ----------------------------

-- ----------------------------
-- Table structure for permail
-- ----------------------------
DROP TABLE IF EXISTS `permail`;
CREATE TABLE `permail` (
  `cPerCodigo` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Codigo de la Persona a la que le pertenece este Email',
  `nPerMailItem` tinyint(3) NOT NULL COMMENT 'Codigo del tipo de email(personal - corporativo)',
  `cPerMail` varchar(250) NOT NULL COMMENT 'Descripcion del Email',
  `nPerMailEstado` tinyint(3) NOT NULL,
  PRIMARY KEY (`cPerCodigo`,`nPerMailItem`),
  UNIQUE KEY `idx_pk_PerMail` (`cPerCodigo`,`nPerMailItem`) USING BTREE,
  KEY `idx_cPerMail` (`cPerMail`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Se registra los diferentes email de una persona ';

-- ----------------------------
-- Records of permail
-- ----------------------------
INSERT INTO `permail` VALUES ('1000000001', '1', 'correo2', '0');
INSERT INTO `permail` VALUES ('1000000001', '2', 'correo 4', '0');

-- ----------------------------
-- Table structure for pernatural
-- ----------------------------
DROP TABLE IF EXISTS `pernatural`;
CREATE TABLE `pernatural` (
  `cPerCodigo` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Codigo de la Persona',
  `cPerNatApePaterno` varchar(250) NOT NULL COMMENT 'Registro del apellido paterno',
  `cPerNatApeMaterno` varchar(250) NOT NULL COMMENT 'Registro del apellido Materno',
  `nPerNatSexo` tinyint(3) unsigned NOT NULL COMMENT 'Codigo de la Persona a la que le pertenece este sexo',
  `nPerNatEstCivil` tinyint(3) unsigned NOT NULL COMMENT 'Codigo de la Persona a la que le pertenece este estado civil',
  PRIMARY KEY (`cPerCodigo`),
  UNIQUE KEY `idx_pk_pernatural` (`cPerCodigo`) USING BTREE,
  KEY `idx_cPerNatApePaterno` (`cPerNatApePaterno`) USING BTREE,
  KEY `idx_cPerNatApeMaterno` (`cPerNatApeMaterno`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='En esta tabla se registra los apellidos de una persona';

-- ----------------------------
-- Records of pernatural
-- ----------------------------
INSERT INTO `pernatural` VALUES ('1000000001', 'Apellido paterno 1', 'Apellido materno 1', '1', '1');

-- ----------------------------
-- Table structure for perparametro
-- ----------------------------
DROP TABLE IF EXISTS `perparametro`;
CREATE TABLE `perparametro` (
  `cPerCodigo` varchar(20) NOT NULL,
  `nParCodigo` int(11) NOT NULL,
  `nParClase` int(11) NOT NULL,
  `nPerParValor` int(11) DEFAULT NULL,
  `cPerParGlosa` varchar(255) DEFAULT NULL,
  `nPerParEstado` int(4) DEFAULT NULL,
  PRIMARY KEY (`cPerCodigo`,`nParCodigo`,`nParClase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of perparametro
-- ----------------------------

-- ----------------------------
-- Table structure for perrelacion
-- ----------------------------
DROP TABLE IF EXISTS `perrelacion`;
CREATE TABLE `perrelacion` (
  `cPerCodigo` varchar(20) CHARACTER SET latin1 NOT NULL,
  `nPerRelTipo` int(11) unsigned NOT NULL,
  `cPerJuridica` varchar(20) CHARACTER SET latin1 NOT NULL,
  `dPerRelacion` date NOT NULL,
  `cPerObservacion` varchar(500) NOT NULL,
  `nPerRelEstado` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`cPerCodigo`,`nPerRelTipo`,`cPerJuridica`),
  UNIQUE KEY `idx_pk_PerRelacion` (`cPerCodigo`,`nPerRelTipo`) USING BTREE,
  KEY `idx_cPerJuridica` (`cPerJuridica`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of perrelacion
-- ----------------------------

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `cPerCodigo` varchar(20) NOT NULL COMMENT 'Codigo de la persona.',
  `cPerNombre` varchar(500) NOT NULL COMMENT 'Nombre de la persona.',
  `cPerApellidos` varchar(500) DEFAULT NULL,
  `dPerNacimiento` date NOT NULL COMMENT 'Fecha de nacimiento de la persona.',
  `nPerTipo` tinyint(3) unsigned NOT NULL COMMENT 'Codigo si es una persona  juridica o natural.',
  `nPerEstado` tinyint(3) unsigned NOT NULL COMMENT 'Codigo si esta persona esta activa o inactivo.',
  PRIMARY KEY (`cPerCodigo`),
  UNIQUE KEY `idx_pk_persona` (`cPerCodigo`) USING BTREE,
  KEY `idx_cPerNombre` (`cPerNombre`(255)) USING BTREE,
  KEY `idx_cParApellidos` (`cPerApellidos`(255)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='En esta tabla se registran los nombres de una persona';

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES ('1', 'Andy', 'Diaz Valdiviezo', '1987-02-04', '1', '1');
INSERT INTO `persona` VALUES ('1000000001', 'Nombre 1', 'Apellido paterno 1 Apellido materno 1', '2014-09-26', '1', '1');

-- ----------------------------
-- Table structure for pertelefono
-- ----------------------------
DROP TABLE IF EXISTS `pertelefono`;
CREATE TABLE `pertelefono` (
  `cPerCodigo` varchar(20) NOT NULL COMMENT 'Codigo de la Persona a la cual le pertenece este Numero Telefonico',
  `nPerTelTipo` int(11) NOT NULL COMMENT 'Tipo de Telefono (Fijo - Celular Movistar - Celular Claro)',
  `nPerTelItem` tinyint(3) unsigned NOT NULL,
  `cPerTelNumero` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Numero del Telefono',
  `nPerTelEstado` tinyint(3) NOT NULL,
  PRIMARY KEY (`cPerCodigo`,`nPerTelItem`,`nPerTelTipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Almacena los telefonos de una determinada Persona';

-- ----------------------------
-- Records of pertelefono
-- ----------------------------
INSERT INTO `pertelefono` VALUES ('1000000001', '0', '1', 'tel2', '0');
INSERT INTO `pertelefono` VALUES ('1000000001', '0', '2', 'tel4', '0');

-- ----------------------------
-- Table structure for perusuacceso
-- ----------------------------
DROP TABLE IF EXISTS `perusuacceso`;
CREATE TABLE `perusuacceso` (
  `cPerCodigo` varchar(20) NOT NULL COMMENT 'Codigo de la persona quien tendra acceso al sistema.',
  `nPerUsuAccGrupo` int(11) unsigned NOT NULL COMMENT 'Codigo de un determinado grupo a la que una persona tendra acceso.',
  `nPerUsuAccTipo` int(11) unsigned NOT NULL COMMENT 'Codigo de un determinado grupo a la que una persona tendra acceso.',
  `nPerUsuAccObjCodigo` int(11) unsigned NOT NULL COMMENT 'Codigo del permiso al que tendra una persona.',
  `nPerUsuAccCodigo` int(11) unsigned NOT NULL COMMENT 'Codigo del permiso al que tendra una persona.',
  `nPerUsuAccPrdCodigo` int(11) unsigned NOT NULL COMMENT 'Codigo de un determinado periodo al que un usuario tendra acceso.',
  `nPerUsuAccEstado` tinyint(3) unsigned NOT NULL COMMENT 'Codigo del estado de un usuario(activo - inactivo).',
  PRIMARY KEY (`cPerCodigo`,`nPerUsuAccGrupo`,`nPerUsuAccTipo`,`nPerUsuAccObjCodigo`,`nPerUsuAccCodigo`,`nPerUsuAccPrdCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='En esta tabla se registraran los permisos de un determinado ';

-- ----------------------------
-- Records of perusuacceso
-- ----------------------------
INSERT INTO `perusuacceso` VALUES ('1', '10', '1', '5000', '1001', '0', '1');
INSERT INTO `perusuacceso` VALUES ('1', '10', '1', '5000', '100101', '0', '1');
INSERT INTO `perusuacceso` VALUES ('1', '1001', '1', '5001', '10010101', '0', '1');
INSERT INTO `perusuacceso` VALUES ('1', '1001', '1', '5001', '10010102', '0', '1');
INSERT INTO `perusuacceso` VALUES ('1', '1001', '1', '5001', '10010103', '0', '1');

-- ----------------------------
-- Table structure for perusuario
-- ----------------------------
DROP TABLE IF EXISTS `perusuario`;
CREATE TABLE `perusuario` (
  `cPerCodigo` varchar(20) CHARACTER SET latin1 NOT NULL COMMENT 'Codigo de la persona ',
  `cPerUsuCodigo` varchar(50) NOT NULL COMMENT 'Registro del nombre del usuario.',
  `cPerUsuClave` varchar(50) NOT NULL COMMENT 'Registro de la clave del usuario.',
  `nPerUsuEstado` tinyint(3) unsigned NOT NULL COMMENT 'Codigo del estado del usuario(activo - inactivo)',
  PRIMARY KEY (`cPerCodigo`,`cPerUsuCodigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of perusuario
-- ----------------------------
INSERT INTO `perusuario` VALUES ('1', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1');

-- ----------------------------
-- Table structure for transaccion
-- ----------------------------
DROP TABLE IF EXISTS `transaccion`;
CREATE TABLE `transaccion` (
  `cTraCodigo` varchar(100) NOT NULL COMMENT 'Codigo de la transaccion que se va a realizar.',
  `nOpeCodigo` int(11) NOT NULL COMMENT 'Codigo de la operacion que se esta realizando',
  `cPerCodigo` varchar(20) NOT NULL COMMENT 'Codigo de la persona quien esta realizando una determinada transaccion.',
  `dTraFecha` datetime NOT NULL COMMENT 'Fecha en que se realiza una determinada transaccion.',
  `cComputer` varchar(250) NOT NULL COMMENT 'Descripcion del equipo que se esta utilizando',
  `cTraDescripcion` longtext NOT NULL COMMENT 'Descripcion de la transaccion que se esta realizando',
  PRIMARY KEY (`cTraCodigo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='En esta tabla se registrara las transaciones que realiza un ';

-- ----------------------------
-- Records of transaccion
-- ----------------------------

-- ----------------------------
-- Procedure structure for usp_Buscar_Parametro
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Buscar_Parametro`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Buscar_Parametro`(nParCodigo int (11), nParClase int(11))
BEGIN
	
		SELECT 
				parametro.nParCodigo,
				parametro.cParJerarquia , 
				parametro.cParNombre,
				parametro.cParDescripcion
		FROM parametro
		WHERE parametro.nParEstado = 1
		AND parametro.nParClase = nParClase
		AND parametro.nParCodigo = nParCodigo;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Del_PerDireccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Del_PerDireccion`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Del_PerDireccion`(cPerCodigo  varchar(20))
BEGIN
  UPDATE perdireccion pd SET
				pd.nPerDirEstado = 0
	WHERE pd.cPerCodigo=cPerCodigo;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Del_PerDocumento
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Del_PerDocumento`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Del_PerDocumento`(cPerCodigo  varchar(20))
BEGIN
UPDATE perdocumento pd
SET pd.nPerDocEstado = 0
WHERE
	pd.cPerCodigo = cPerCodigo;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Del_PerMail
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Del_PerMail`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Del_PerMail`(cPerCodigo  varchar(20))
BEGIN

UPDATE permail pm
SET pm.nPerMailEstado = 0
WHERE pm.cPerCodigo = cPerCodigo;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Del_Persona
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Del_Persona`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Del_Persona`(cPerCodigo  varchar(20))
BEGIN
  UPDATE persona p SET
				p.nPerEstado=0
	WHERE p.cPerCodigo=cPerCodigo;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Del_PerTelefono
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Del_PerTelefono`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Del_PerTelefono`(cPerCodigo  varchar(20))
BEGIN
UPDATE pertelefono pt
SET pt.nPerTelEstado = 0
WHERE
	pt.cPerCodigo = cPerCodigo;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Filtrar_Parametro
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Filtrar_Parametro`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Filtrar_Parametro`(nOriReg Int(4), nCanReg Int(4), nPagRegistro Int(4) , nParClase int(11) , cParNombre varchar(100), cParDescripcion varchar(500))
BEGIN

	IF  (nPagRegistro = 1 ) THEN
		SET @sentencia = CONCAT('SELECT parametro.nParCodigo,
							parametro.cParNombre,
							IFNULL(parametro.cParDescripcion,"") cParDescripcion
					FROM parametro
					WHERE parametro.nParClase="',nParClase,'"
					AND parametro.nParEstado = 1
					AND( ( "',cParNombre ,'" 				= "-" )	OR ( parametro.cParNombre like "',cParNombre ,'%") )
					AND( ( "',cParDescripcion ,'" 	= "-" ) OR ( parametro.cParDescripcion like "',cParDescripcion ,'%") )
					ORDER BY parametro.cParDescripcion ASC
					LIMIT  ',nOriReg,',',nCanReg,' ; ');
					prepare consulta FROM @sentencia;
					execute consulta;
	ELSE
		SELECT parametro.nParCodigo,
				parametro.cParNombre,
				IFNULL(parametro.cParDescripcion,"") cParDescripcion
		FROM parametro
		WHERE parametro.nParClase = nParClase
		AND parametro.nParEstado = 1
		AND ( ( cParNombre 			= "-" ) OR ( parametro.cParNombre 			LIKE CONCAT(cParNombre,'%') ) )
		AND	( ( cParDescripcion = "-" ) OR ( parametro.cParDescripcion 	LIKE CONCAT(cParDescripcion,'%') ) )
		ORDER BY parametro.cParDescripcion ASC ;
	END IF;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Filtrar_Persona
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Filtrar_Persona`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Filtrar_Persona`(nOriReg int(4), nCanReg int(4), nPagRegistro int(4), cPerNombre varchar(200), cPerDirDescripcion varchar(20), cPerDocNumero varchar(20), cPerTelNumero varchar(100), cPerMail varchar(50))
BEGIN

IF (nPagRegistro = 1) THEN
	SELECT
    p.cPerCodigo,
    p.cPerNombre,
    p.cPerApellidos,
		p.nPerTipo,
    IF(pd.nPerDirEstado = 1, pd.cperdirdescripcion, '') as cPerDirDescripcion ,
    IF(pdoc.nPerDocEstado = 1, pdoc.cperdocnumero, '') as cPerDocNumero ,
    IF(pt.nPerTelEstado = 1, pt.cpertelnumero, '') as cPerTelNumero ,
    IF(pm.nPerMailEstado = 1, pm.cPerMail, '') as cPerMail ,
    pd.nPerDirEstado,
    pdoc.nPerDocEstado,
    pt.nPerTelEstado,
    pm.nPerMailEstado
FROM
    persona p          
LEFT JOIN
    (
        SELECT
            * 
        FROM
            perdireccion 
        order by
            perdireccion.nPerDirEstado DESC
    ) pd                 
        ON pd.cpercodigo = p.cpercodigo          
LEFT JOIN
    (
        SELECT
            * 
        FROM
            perdocumento 
        order by
            perdocumento.nPerDocEstado DESC
    ) pdoc                 
        ON pdoc.cpercodigo = p.cpercodigo          
LEFT JOIN
    (
        SELECT
            * 
        FROM
            pertelefono 
        order by
            pertelefono.nPerTelEstado DESC
    )  pt                 
        ON pt.cpercodigo = p.cpercodigo          
LEFT JOIN
    (
        SELECT
            * 
        FROM
            permail 
        order by
            permail.nPerMailEstado DESC
    )  pm                 
        ON pm.cpercodigo = p.cpercodigo   
WHERE
    p.nperestado = 1          
    AND (
        p.cpernombre LIKE Concat('%', cpernombre, '%')                 
        OR p.cperapellidos LIKE Concat('%', cpernombre, '%')                 
        OR Concat(p.cpernombre, ' ', p.cperapellidos) LIKE                    Concat('%', cpernombre, '%') 
    )          
    AND (
        IF (cperdirdescripcion = '', 1, 0) = 1                 
        OR pd.cperdirdescripcion LIKE Concat('%', cperdirdescripcion, '%')              
    )          
    AND (
        IF (cperdocnumero = '', 1, 0) = 1                 
        OR pdoc.cperdocnumero LIKE Concat('%', cperdocnumero, '%') 
    )          
    AND (
        IF (cpertelnumero = '', 1, 0) = 1                 
        OR pt.cpertelnumero LIKE Concat('%', cpertelnumero, '%') 
    )          
    AND (
        IF (cpermail = '', 1, 0) = 1                 
        OR pm.cpermail LIKE Concat('%', cpermail, '%') 
    )   
GROUP BY
    p.cPerCodigo  
ORDER  BY
    p.cpernombre ASC
	LIMIT nOriReg,
	nCanReg;


ELSE
	SELECT
		p.cPerCodigo,
		p.cPerNombre,
		IFNULL(p.cPerApellidos, "") cPerApellidos,
		p.dPerNacimiento
	FROM
		persona p
	WHERE
		p.nPerEstado = 1
	AND (
		(cPerNombre = "-")
		OR (
			p.cPerNombre LIKE CONCAT(cPerNombre, '%')
		)
	)
	AND (
		(cPerApellidos = "-")
		OR (
			p.cPerApellidos LIKE CONCAT(cPerApellidos, '%')
		)
	)
	ORDER BY
		p.cPerNombre ASC;


END
IF;


END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_Parametro_By_cParClase
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_Parametro_By_cParClase`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_Parametro_By_cParClase`(nParClase int(11))
BEGIN
		SELECT parametro.nParCodigo,
				parametro.cParNombre,
				parametro.cParDescripcion
		FROM parametro
		WHERE parametro.nParEstado = 1
		AND parametro.nParClase = nParClase
		ORDER BY 	parametro.cParDescripcion ,
		parametro.cParNombre  ASC;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_PerDireccion_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_PerDireccion_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_PerDireccion_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
SELECT
	pd.*
FROM
	perdireccion pd
INNER JOIN persona p ON pd.cPerCodigo = p.cPerCodigo
WHERE
	pd.cPerCodigo = cPerCodigo
AND pd.nPerDirEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_PerDocumento_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_PerDocumento_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_PerDocumento_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
SELECT
	pd.*
FROM
	perdocumento pd
INNER JOIN persona p ON pd.cPerCodigo = p.cPerCodigo
WHERE
	pd.cPerCodigo = cPerCodigo
AND pd.nPerDocEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_PerJuridica_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_PerJuridica_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_PerJuridica_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
SELECT
	*
FROM
	perjuridica pj
INNER JOIN persona p ON pj.cPerCodigo = p.cPerCodigo
WHERE
	pj.cPerCodigo = cPerCodigo
AND p.nPerEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_PerMail_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_PerMail_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_PerMail_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
SELECT
	pm.*
FROM
	permail pm
INNER JOIN persona p ON pm.cPerCodigo = p.cPerCodigo
WHERE
	pm.cPerCodigo = cPerCodigo
AND pm.nPerMailEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_Permisos_Botonera_By_Usuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_Permisos_Botonera_By_Usuario`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_Permisos_Botonera_By_Usuario`(nPerTipo int(4), nPerEstado int(4), nPerUsuEstado Int(4), nPerUsuAccEstado Int(4), nParClase Int(4),cPerCodigo  varchar(20), nPerUsuAccGrupo Int(4), nParTipo Int(4), nParSrcClase Int(4), nParSrcCodigo Int(4))
BEGIN
	SELECT persona.cPerCodigo,
		persona.cPerNombre,
		persona.nPerTipo,
		perusuacceso.nPerUsuAccGrupo,
    perusuacceso.nPerUsuAccCodigo,
		perusuacceso.nPerUsuAccEstado,
		parametro.cParJerarquia,
		parametro.cParNombre,
    parametro.cParDescripcion,
		(length(parametro.cParJerarquia)) as CanJerarquia,
		parparametro.cValor
	FROM persona
  INNER JOIN perusuario  	ON persona.cPerCodigo    = perusuario.cPerCodigo
  INNER JOIN perusuacceso ON perusuario.cPerCodigo = perusuacceso.cPerCodigo
  INNER JOIN parametro    ON parametro.nParCodigo  = perusuacceso.nPerUsuAccCodigo AND parametro.nParClase = perusuacceso.nPerUsuAccObjCodigo
	INNER JOIN parparametro	ON parparametro.nParDstClase = parametro.nParClase AND parparametro.nParDstCodigo = parametro.nParCodigo
	WHERE persona.nPerTipo             = nPerTipo
  AND persona.nPerEstado             <> nPerEstado
  AND perusuario.nPerUsuEstado       <> nPerUsuEstado
  AND perusuacceso.nPerUsuAccEstado  <>	nPerUsuAccEstado
  AND parametro.nParClase            = nParClase
  AND persona.cPerCodigo             = cPerCodigo
	AND perusuacceso.nPerUsuAccGrupo	 = nPerUsuAccGrupo
	AND parametro.nParEstado			   		 = nParTipo
	AND parparametro.nParSrcClase			 = nParSrcClase
	AND parparametro.nParSrcCodigo		 = nParSrcCodigo
	ORDER BY parametro.cParJerarquia;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_Permisos_By_Usuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_Permisos_By_Usuario`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_Permisos_By_Usuario`(nPerTipo int(4), nPerEstado int(4), nPerUsuEstado Int(4), nPerUsuAccEstado Int(4), nParClase Int(4), cPerCodigo  varchar(20), nPerUsuAccGrupo Int(4))
BEGIN
	SELECT persona.cPerCodigo,
		persona.cPerNombre,
		persona.nPerTipo,
		perusuacceso.nPerUsuAccGrupo,
    perusuacceso.nPerUsuAccCodigo,
		perusuacceso.nPerUsuAccEstado,
		parametro.cParJerarquia,
		parametro.cParNombre,
    Concat(left(parametro.cParDescripcion,1),lower(right(parametro.cParDescripcion,(length(parametro.cParDescripcion)-1)))) AS NombreMenu,
		(length(parametro.cParJerarquia)) as CanJerarquia
	FROM persona
  INNER JOIN perusuario   ON persona.cPerCodigo    = perusuario.cPerCodigo
  INNER JOIN perusuacceso ON perusuario.cPerCodigo = perusuacceso.cPerCodigo
  INNER JOIN parametro    ON parametro.nParCodigo  = perusuacceso.nPerUsuAccCodigo AND parametro.nParClase = perusuacceso.nPerUsuAccObjCodigo
	WHERE persona.nPerTipo            = nPerTipo
  AND persona.nPerEstado            <> nPerEstado
  AND perusuario.nPerUsuEstado      <> nPerUsuEstado
  AND perusuacceso.nPerUsuAccEstado <> nPerUsuAccEstado
  AND parametro.nParClase           = nParClase
  AND persona.cPerCodigo            = cPerCodigo
	AND perusuacceso.nPerUsuAccGrupo	= nPerUsuAccGrupo
	ORDER BY parametro.cParJerarquia;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_PerNatural_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_PerNatural_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_PerNatural_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
SELECT
	*
FROM
	pernatural pn
INNER JOIN persona p ON pn.cPerCodigo = p.cPerCodigo
WHERE
	pn.cPerCodigo = cPerCodigo
AND p.nPerEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_Persona_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_Persona_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_Persona_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
	SELECT
		*
	FROM
		persona p
	WHERE
		p.cPerCodigo = cPerCodigo
	AND p.nPerEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Get_PerTelefono_By_nPerCodigo
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Get_PerTelefono_By_nPerCodigo`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Get_PerTelefono_By_nPerCodigo`(cPerCodigo  varchar(20))
BEGIN
SELECT
	pt.*
FROM
	pertelefono pt
INNER JOIN persona p ON pt.cPerCodigo = p.cPerCodigo
WHERE
	pt.cPerCodigo = cPerCodigo
AND pt.nPerTelEstado = 1;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_Parametro
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_Parametro`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_Parametro`(nParClase int(11) ,cParNombre varchar(100), cParDescripcion varchar(500))
BEGIN
  DECLARE nParCodigo INT;
	DECLARE cParJerarquia VARCHAR(20);
-- Generar codigo para el parametro
  SELECT 	IFNULL( MAX(parametro.nParCodigo)+1 , 1 ) INTO nParCodigo
	FROM		parametro
	WHERE		parametro.nParClase = nParClase;
-- Generar jerarquia para el parametro
  -- SELECT 	LPAD(IFNULL( MAX(parametro.cParJerarquia)+1 , 1001 ),4,'0') INTO cParJerarquia
	SELECT 	IFNULL( MAX(parametro.cParJerarquia)+1 , 1001 ) INTO cParJerarquia
	FROM 		parametro
	WHERE 	parametro.nParClase=nParClase AND parametro.nParCodigo <> 0 ;

		INSERT INTO parametro (parametro.nParCodigo,
												 parametro.nParClase,
												 parametro.cParJerarquia,
												 parametro.cParNombre,
												 parametro.cParDescripcion,
												 parametro.nParEstado)
  VALUES(nParCodigo, nParClase, cParJerarquia, cParNombre, cParDescripcion,	1);

	SELECT nParCodigo, cParJerarquia;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerDireccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerDireccion`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerDireccion`(cPerCodigo varchar(20), cPerDirDescripcion varchar(100), nPerDirTipo int(11), nPerDirEstado int(11))
BEGIN

INSERT INTO perdireccion (perdireccion.cPerCodigo,
												 perdireccion.cPerDirDescripcion,
												perdireccion.nPerDirTipo,
												perdireccion.nPerDirEstado)
VALUES(cPerCodigo, cPerDirDescripcion, nPerDirTipo, nPerDirEstado);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerDocumento
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerDocumento`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerDocumento`(cPerCodigo VARCHAR(20), nPerDocTipo INT , cPerDocNumero VARCHAR(20) , dPerDocCaducidad DATE, nPerDocCategoria INT)
BEGIN

	INSERT INTO perdocumento (
	perdocumento.cPerCodigo,
	perdocumento.nPerDocTipo,
	perdocumento.cPerDocNumero,
	perdocumento.dPerDocCaducidad,
	perdocumento.nPerDocCategoria,
	perdocumento.nPerDocEstado
)
VALUES (cPerCodigo, nPerDocTipo, cPerDocNumero, dPerDocCaducidad, nPerDocCategoria, 1);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerJuridica
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerJuridica`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerJuridica`(cPerCodigo VARCHAR(20), cPerJurDescripcion varchar(250) , nPerEmpresa INT, nPerJurRubro INT)
BEGIN
INSERT INTO perjuridica (
	perjuridica.cPerCodigo,
	perjuridica.cPerJurDescripcion,
	perjuridica.nPerEmpresa,
	perjuridica.nPerJurRubro
)
VALUES
	(
		cPerCodigo,
		cPerJurDescripcion,
		nPerEmpresa,
		nPerJurRubro
	);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerMail
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerMail`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerMail`(cPerCodigo VARCHAR(20),  cPerMail VARCHAR(120))
BEGIN
	DECLARE nPerMailItem_ INT ;

	SELECT IFNULL(MAX(permail.nPerMailItem ) +1 ,1) INTO nPerMailItem_
	FROM permail
	WHERE permail.cPerCodigo = cPerCodigo ;


	INSERT INTO permail (permail.cPerCodigo, permail.nPerMailItem, permail.cPerMail, permail.nPerMailEstado)
	VALUES (cPerCodigo, nPerMailItem_ , cPerMail , 1 );

	SELECT cPerCodigo , nPerMailItem_ AS nPerMailItem ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerNatural
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerNatural`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerNatural`(cPerCodigo VARCHAR(20), cPerNatApePaterno VARCHAR(250), cPerNatApeMaterno VARCHAR(250) , nPerNatSexo INT, nPerNatEstCivi INT)
BEGIN

	INSERT INTO pernatural (
		pernatural.cPerCodigo,
		pernatural.cPerNatApePaterno,
		pernatural.cPerNatApeMaterno,
		pernatural.nPerNatSexo,
		pernatural.nPerNatEstCivil
	)
 VALUES (cPerCodigo, cPerNatApePaterno, cPerNatApeMaterno, nPerNatSexo, nPerNatEstCivi);

SELECT cPerCodigo ;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_Persona
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_Persona`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_Persona`(cPerNombre varchar(500), cPerApellidos varchar(500), dPerNacimiento varchar(20), nPerTipo int(3), nPerEstado int(3))
BEGIN
	# declarar variable
		DECLARE cPerCodigo_ VARCHAR(20);


  SELECT 	IFNULL( MAX(persona.cPerCodigo)+1 , CONCAT(nPerTipo , '000000001') )   INTO cPerCodigo_
	FROM		persona
	WHERE		LENGTH(persona.cPerCodigo) > 9
	AND 	persona.nPerTipo = nPerTipo;


	INSERT INTO persona(persona.cPerCodigo,
											persona.cPerNombre,
											persona.cPerApellidos,
											persona.dPerNacimiento,
											persona.nPerTipo,
											persona.nPerEstado)
	VALUES (cPerCodigo_,
					cPerNombre,
					cPerApellidos,
					dPerNacimiento,
					nPerTipo,
					nPerEstado);
	# seleccionar codigo
		SELECT cPerCodigo_ AS cPerCodigo;



END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerTelefono
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerTelefono`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerTelefono`(cPerCodigo VARCHAR(20), nPerTelTipo INT,  cPerTelNumero VARCHAR(20))
BEGIN
	DECLARE nPerTelItem_ INT ;

	SELECT IFNULL(MAX(pertelefono.nPerTelItem ) +1 ,1) INTO nPerTelItem_
	FROM pertelefono
	WHERE pertelefono.cPerCodigo = cPerCodigo ;

	INSERT INTO pertelefono (
		pertelefono.cPerCodigo,
		pertelefono.nPerTelTipo,
		pertelefono.nPerTelItem,
		pertelefono.cPerTelNumero,
		pertelefono.nPerTelEstado
	)
	VALUES (cPerCodigo, nPerTelTipo, nPerTelItem_ , cPerTelNumero, 1);

	SELECT cPerCodigo, nPerTelItem_  AS nPerTelItem ;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Set_PerUsuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Set_PerUsuario`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Set_PerUsuario`(cPerCodigo varchar(20), cPerUsuCodigo  varchar(50), cPerUsuClave  varchar(100))
BEGIN

	INSERT INTO perusuario (cPerCodigo, cPerUsuCodigo, cPerUsuClave, nPerUsuEstado)
	VALUES (cPerCodigo, cPerUsuCodigo, cPerUsuClave,  1);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_Parametro
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_Parametro`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_Parametro`(nParCodigo int(11), nParClase  int(11) , cParNombre varchar(100), cParDescripcion varchar(255))
BEGIN

		UPDATE parametro
			SET parametro.cParNombre = cParNombre,
					parametro.cParDescripcion = cParDescripcion
		WHERE parametro.nParCodigo = nParCodigo
		AND parametro.nParClase = nParClase
		AND parametro.nParEstado = 1;

	SELECT  nParCodigo  ;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_Parametro_Estado
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_Parametro_Estado`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_Parametro_Estado`(nParCodigo int(11), nParClase int(11) ,   nParEstado int(3))
BEGIN
  UPDATE parametro SET
				parametro.nParEstado = nParEstado
	WHERE parametro.nParCodigo = nParCodigo
	AND parametro.nParClase = nParClase ;

SELECT nParCodigo  ;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_PerDireccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_PerDireccion`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_PerDireccion`(cPerCodigo varchar(20), cPerDirDescripcion varchar(100), nPerDirTipo int(11))
BEGIN

	UPDATE perdireccion pd
	SET pd.cPerDirDescripcion		=	cPerDirDescripcion,
pd.nPerDirTipo 		=	nPerDirTipo 
	WHERE pd.cPerCodigo =  cPerCodigo
AND pd.nPerDirEstado = 1;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_PerDocumento
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_PerDocumento`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_PerDocumento`(cPerCodigo VARCHAR(20), nPerDocTipo INT, cPerDocNumero VARCHAR(20))
BEGIN

	UPDATE perdocumento pd
	SET pd.nPerDocTipo		=	nPerDocTipo,
			pd.cPerDocNumero	=	cPerDocNumero
	WHERE pd.cPerCodigo =  cPerCodigo
AND pd.nPerDocEstado = 1;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_PerJuridica
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_PerJuridica`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_PerJuridica`(cPerCodigo VARCHAR (20), cPerJurDescripcion VARCHAR (250), nPerEmpresa INT, nPerJurRubro INT)
BEGIN

UPDATE perjuridica pj
SET pj.cPerJurDescripcion = cPerJurDescripcion,
 pj.nPerEmpresa = nPerEmpresa,
 pj.nPerJurRubro = nPerJurRubro
WHERE
	pj.cPerCodigo = cPerCodigo;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_PerMail
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_PerMail`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_PerMail`(cPerCodigo VARCHAR(20),  cPerMail VARCHAR(120))
BEGIN

	UPDATE permail pm
	SET pm.cPerMail		=	cPerMail
	WHERE pm.cPerCodigo =  cPerCodigo
AND pm.nPerMailEstado = 1;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_PerNatural
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_PerNatural`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_PerNatural`(cPerCodigo VARCHAR(20), cPerNatApePaterno VARCHAR(250), cPerNatApeMaterno VARCHAR(250) , nPerNatSexo INT, nPerNatEstCivi INT)
BEGIN

	UPDATE pernatural pn
	SET pn.cPerNatApePaterno		=	cPerNatApePaterno,
			pn.cPerNatApeMaterno	=	cPerNatApeMaterno,
			pn.nPerNatSexo=	nPerNatSexo ,
			pn.nPerNatEstCivil		= nPerNatEstCivil
	WHERE pn.cPerCodigo =  cPerCodigo;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_Persona
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_Persona`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_Persona`(cPerCodigo varchar(20), cPerNombre varchar(500), cPerApellidos varchar(500), dPerNacimiento varchar(20),  nPerEstado int(3))
BEGIN

	UPDATE persona p
	SET p.cPerNombre		=	cPerNombre,
			p.cPerApellidos	=	cPerApellidos,
			p.dPerNacimiento=	dPerNacimiento ,
			p.nPerEstado		= nPerEstado
	WHERE p.cPerCodigo	=  cPerCodigo;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for usp_Upd_PerTelefono
-- ----------------------------
DROP PROCEDURE IF EXISTS `usp_Upd_PerTelefono`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_Upd_PerTelefono`(cPerCodigo VARCHAR(20), nPerTelTipo INT,  cPerTelNumero VARCHAR(20))
BEGIN

	UPDATE pertelefono pt
	SET pt.nPerTelTipo		=	nPerTelTipo,
			pt.cPerTelNumero	=	cPerTelNumero
	WHERE pt.cPerCodigo =  cPerCodigo
AND pt.nPerTelEstado = 1;

END
;;
DELIMITER ;
