/*
 Navicat Premium Data Transfer

 Source Server         : liu
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : localhost:3306
 Source Schema         : plms

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : 65001

 Date: 29/04/2020 22:10:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '部门名称',
  `parentId` int(11) DEFAULT NULL,
  `depPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `isParent` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '股东会', -1, '.1', 1, 1);
INSERT INTO `department` VALUES (4, '董事会', 1, '.1.4', 1, 1);
INSERT INTO `department` VALUES (5, '总办', 4, '.1.4.5', 1, 1);
INSERT INTO `department` VALUES (8, '财务部', 5, '.1.4.5.8', 1, 0);
INSERT INTO `department` VALUES (78, '市场部', 5, '.1.4.5.78', 1, 1);
INSERT INTO `department` VALUES (81, '东北市场部', 78, '.1.4.5.78.81', 1, 1);
INSERT INTO `department` VALUES (82, '华南市场部', 78, '.1.4.5.78.82', 1, 0);
INSERT INTO `department` VALUES (86, '西北市场部', 78, '.1.4.5.78.86', 1, 1);
INSERT INTO `department` VALUES (87, '西安市场部', 86, '.1.4.5.78.86.87', 1, 0);
INSERT INTO `department` VALUES (91, '技术部', 5, '.1.4.5.91', 1, 0);
INSERT INTO `department` VALUES (92, '运维部', 5, '.1.4.5.92', 1, 1);
INSERT INTO `department` VALUES (93, '运维1部', 92, '.1.4.5.92.93', 1, 0);
INSERT INTO `department` VALUES (94, '运维2部', 92, '.1.4.5.92.94', 1, 0);
INSERT INTO `department` VALUES (108, '兰州市场部', 86, '.1.4.5.78.86.108', 1, 0);
INSERT INTO `department` VALUES (109, '辽宁市场部', 81, '.1.4.5.78.81.109', 1, 0);
INSERT INTO `department` VALUES (110, '吉林市场部', 81, '.1.4.5.78.81.110', 1, 0);
INSERT INTO `department` VALUES (112, '人力部', 5, '.1.4.5.112', 1, 0);
INSERT INTO `department` VALUES (113, '客服部', 5, '.1.4.5.113', 1, 1);
INSERT INTO `department` VALUES (114, '客服一部', 113, '.1.4.5.113.114', 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `idCard` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '籍贯',
  `politicId` int(8) DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(11) DEFAULT NULL COMMENT '所属部门',
  `jobLevelId` int(11) DEFAULT NULL COMMENT '职称ID',
  `posId` int(11) DEFAULT NULL COMMENT '职位ID',
  `engageForm` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '聘用形式',
  `tiptopDegree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '所属专业',
  `school` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '毕业院校',
  `beginDate` date DEFAULT NULL COMMENT '入职日期',
  `workState` enum('在职','离职') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '在职' COMMENT '在职状态',
  `workID` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工号',
  `contractTerm` double DEFAULT NULL COMMENT '合同期限',
  `conversionTime` date DEFAULT NULL COMMENT '转正日期',
  `notWorkDate` date DEFAULT NULL COMMENT '离职日期',
  `beginContract` date DEFAULT NULL COMMENT '合同起始日期',
  `endContract` date DEFAULT NULL COMMENT '合同终止日期',
  `workAge` int(11) DEFAULT NULL COMMENT '工龄',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `workID`(`workID`) USING BTREE,
  INDEX `departmentId`(`departmentId`) USING BTREE,
  INDEX `jobId`(`jobLevelId`) USING BTREE,
  INDEX `dutyId`(`posId`) USING BTREE,
  INDEX `nationId`(`nationId`) USING BTREE,
  INDEX `politicId`(`politicId`) USING BTREE,
  INDEX `workID_key`(`workID`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`jobLevelId`) REFERENCES `joblevel` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`posId`) REFERENCES `position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`nationId`) REFERENCES `nation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`politicId`) REFERENCES `politicsstatus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 140 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '刘子陶', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 87, 9, 31, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, '2018-04-01', NULL, '2018-01-02', '2020-09-01', NULL);
INSERT INTO `employee` VALUES (2, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 91, 12, 29, '劳动合同', '高中', '市场营销', '武汉大学', '2018-06-09', '在职', '00000002', 3, '2018-09-10', NULL, '2018-06-09', '2021-06-08', NULL);
INSERT INTO `employee` VALUES (3, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3, '2018-04-01', NULL, '2018-01-01', '2021-01-01', NULL);
INSERT INTO `employee` VALUES (4, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'lucunliang@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3, '2018-04-01', NULL, '2018-01-01', '2021-01-01', NULL);
INSERT INTO `employee` VALUES (5, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (6, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (7, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (8, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (9, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (10, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 4, '2018-01-31', NULL, '2018-01-01', '2022-01-01', NULL);
INSERT INTO `employee` VALUES (11, '何乔', '男', '1990-01-01', '610122199001011252', '已婚', 1, '陕西', 13, 'heqiao@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2020-01-01', '在职', '00000011', 2, '2020-05-01', NULL, '2020-01-01', '2022-01-01', NULL);
INSERT INTO `employee` VALUES (12, '陈二', '女', '1989-02-01', '421288198902011231', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2019-06-09', '在职', '00000012', 4, '2019-07-10', NULL, '2019-06-09', '2023-06-08', NULL);
INSERT INTO `employee` VALUES (13, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2019-01-01', '在职', '00000013', 4, '2019-01-01', NULL, '2019-01-01', '2023-01-30', NULL);
INSERT INTO `employee` VALUES (14, '刘波', '男', '1997-01-01', '610122199701011259', '未婚', 1, '陕西', 13, 'liubo@qq.com', '18565558894', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '网络工程', '深圳大学', '2019-01-01', '在职', '00000014', 3, '2019-04-01', NULL, '2019-01-01', '2022-01-01', NULL);
INSERT INTO `employee` VALUES (15, '刘静', '女', '1998-02-01', '513902199802011234', '已婚', 1, '海南', 1, 'liu@qq.com', '18795556693', '四川省成都市龙泉驿区', 91, 12, 29, '劳动合同', '高中', '市场营销', '四川师范大学', '2018-06-09', '在职', '00000015', 4, '2019-09-10', NULL, '2019-06-09', '2023-06-08', NULL);
INSERT INTO `employee` VALUES (16, '刘刚刚', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'liugang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2020-01-01', '在职', '00000016', 3, '2020-01-01', NULL, '2020-01-01', '2023-01-01', NULL);
INSERT INTO `employee` VALUES (17, '陈美', '女', '1989-02-01', '421288198902011237', '已婚', 1, '海南', 1, 'chenmei@qq.com', '18795556693', '海南省海口市美兰区', 8, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2019-06-09', '在职', '00000017', 5, '2019-06-09', NULL, '2019-06-09', '2024-06-08', NULL);
INSERT INTO `employee` VALUES (18, '陈画', '女', '1986-02-01', '421288198902011232', '已婚', 1, '海南', 1, 'chenhua@qq.com', '18795556693', '深圳市南山区', 8, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2019-06-09', '在职', '00000018', 5, '2019-06-09', NULL, '2019-06-09', '2024-06-08', NULL);
INSERT INTO `employee` VALUES (19, '刘萍', '女', '1998-02-13', '513902199802137895', '未婚', 1, '四川简阳', 3, 'liuyuping@qq.com', '17789456315', '四川简阳', 1, 13, 30, '劳动合同', '本科', '网络工程', '四川师范大学', '2019-02-04', '在职', '00000019', 8, '2016-01-02', NULL, '2016-02-04', '2022-02-04', NULL);
INSERT INTO `employee` VALUES (20, '何主', '男', '1993-02-02', '513698199302025466', '已婚', 1, '四川成都', 1, 'hezhu@qq.com', '15578934597', '四川成都', 5, 9, 29, '劳动合同', '博士', '计算机科学与技术', '四川大学', '2016-02-10', '在职', '00000020', 6, '2016-04-12', NULL, '2016-02-29', '2022-02-10', NULL);
INSERT INTO `employee` VALUES (21, '朱底', '男', '1992-02-05', '519768199202252463', '已婚', 1, '四川南充', 1, 'zhudi@qq.com', '15775197746', '四川成都', 8, 9, 29, '劳动合同', '硕士', '电气工程', '电子科技大学', '2018-03-15', '在职', '00000021', 6, '2018-05-10', NULL, '2018-05-11', '2024-05-02', NULL);
INSERT INTO `employee` VALUES (22, '刘思', '男', '1997-03-06', '513902199703065478', '已婚', 1, '四川南充', 13, 'liusi@qq.com', '17765483523', '深圳', 78, 9, 29, '劳动合同', '本科', '市场营销', '江苏大学', '2017-03-08', '在职', '00000022', 5.92, '2017-04-01', NULL, '2017-04-01', '2023-03-08', NULL);
INSERT INTO `employee` VALUES (69, '234', '女', '2020-03-06', '513902199802205469', '已婚', 1, 'hsi', 9, '32@qq.com', '144566', 'we', 87, 9, 29, '劳动合同', '高中', 'asd', 'asd', '2020-03-30', '在职', '00000023', 5, '2020-03-30', NULL, '2020-03-23', '2025-03-15', NULL);
INSERT INTO `employee` VALUES (139, '刘洪', '男', '1998-02-03', '513902199802035467', '未婚', 1, '河南郑州', 13, 'liuhong@qq.com', '15779846513', '河南郑州', 92, 9, 30, '劳动合同', '本科', '计算机科学与技术', '河南科技大学', '2017-03-09', '在职', '00000024', 6, '2017-03-30', NULL, '2017-03-30', '2023-03-31', NULL);

-- ----------------------------
-- Table structure for employeeec
-- ----------------------------
DROP TABLE IF EXISTS `employeeec`;
CREATE TABLE `employeeec`  (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `eid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号',
  `ecDate` date NOT NULL COMMENT '奖惩日期',
  `ecReason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖惩原因',
  `ecPoint` int(255) NOT NULL COMMENT '奖惩分',
  `ecType` int(255) NOT NULL COMMENT '奖惩类型：0为减分，1为加分',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employeeec
-- ----------------------------
INSERT INTO `employeeec` VALUES (1, '00000001', '2019-12-05', '被评选为优秀员工', 2, 1, '工作表现优异');
INSERT INTO `employeeec` VALUES (2, '00000002', '2020-03-03', '迟到', 1, 0, '严禁迟到噢');
INSERT INTO `employeeec` VALUES (3, '00000003', '2020-03-12', '业绩突出', 2, 1, '在市场调研、市场分析方面取得优秀的成绩');
INSERT INTO `employeeec` VALUES (4, '00000004', '2020-03-12', '业绩突出', 2, 1, '在市场调研、市场分析方面取得优秀的成绩');
INSERT INTO `employeeec` VALUES (5, '00000005', '2019-12-05', '被评选为优秀员工', 2, 1, '工作表现优异');
INSERT INTO `employeeec` VALUES (6, '00000007', '2020-03-03', '迟到', 1, 0, '严禁迟到噢');

-- ----------------------------
-- Table structure for employeetrain
-- ----------------------------
DROP TABLE IF EXISTS `employeetrain`;
CREATE TABLE `employeetrain`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '员工编号',
  `trainDate` date DEFAULT NULL COMMENT '培训日期',
  `trainContent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '培训内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `eid`(`eid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of employeetrain
-- ----------------------------
INSERT INTO `employeetrain` VALUES (2, '00000001', '2019-02-01', '商务礼仪（包括说话礼仪、行为礼仪、介绍礼仪、餐桌礼仪、乘车礼仪等）', '提升个人形象，提高沟通表达能力');
INSERT INTO `employeetrain` VALUES (3, '00000002', '2019-03-29', '技能培训', '提升员工专业技能水平');
INSERT INTO `employeetrain` VALUES (4, '00000003', '2019-03-29', '技能培训', '提升员工专业技能水平');
INSERT INTO `employeetrain` VALUES (5, '00000004', '2019-03-29', '技能培训', '提升员工专业技能水平');
INSERT INTO `employeetrain` VALUES (6, '00000005', '2020-03-29', '技能培训', '提升员工专业技能水平');
INSERT INTO `employeetrain` VALUES (7, '00000006', '2020-01-01', '企业文化培训', '增强对企业文化的理解');

-- ----------------------------
-- Table structure for empsalary
-- ----------------------------
DROP TABLE IF EXISTS `empsalary`;
CREATE TABLE `empsalary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `eid`(`eid`) USING BTREE,
  INDEX `empsalary_ibfk_2`(`sid`) USING BTREE,
  CONSTRAINT `empsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `empsalary_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `salary` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of empsalary
-- ----------------------------
INSERT INTO `empsalary` VALUES (84, 2, 14);
INSERT INTO `empsalary` VALUES (85, 3, 14);
INSERT INTO `empsalary` VALUES (86, 4, 13);
INSERT INTO `empsalary` VALUES (87, 5, 13);
INSERT INTO `empsalary` VALUES (88, 8, 14);
INSERT INTO `empsalary` VALUES (90, 9, 13);
INSERT INTO `empsalary` VALUES (91, 1, 9);

-- ----------------------------
-- Table structure for hr
-- ----------------------------
DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'hrID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '住宅电话',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '联系地址',
  `enabled` tinyint(1) DEFAULT 1,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `userface` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr
-- ----------------------------
INSERT INTO `hr` VALUES (3, '系统管理员', '18568887789', '029-82881234', '深圳南山', 1, 'admin', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', NULL);
INSERT INTO `hr` VALUES (5, '李白', '18568123489', '029-82123434', '海口美兰', 1, 'libai', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1070276884,3427109893&fm=26&gp=0.jpg', NULL);
INSERT INTO `hr` VALUES (10, '韩愈', '18568123666', '029-82111555', '广州番禺', 1, 'hanyu', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582715040009&di=f43a2ef9d37b01a08072ced2b56aa83b&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn10%2F461%2Fw750h511%2F20180913%2Facf9-fzrwica4221016.jpg', NULL);
INSERT INTO `hr` VALUES (11, '柳宗元', '18568123377', '029-82111333', '广州天河', 1, 'liuzongyuan', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582715089730&di=f91f4787e0f81953858d78ffd815c061&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20190526s%2F192%2Fw1024h768%2F20190526%2Fa51c-hxntqyy9410996.jpg', NULL);
INSERT INTO `hr` VALUES (12, '曾巩', '18568128888', '029-82111222', '广州越秀', 1, 'zenggong', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582715140381&di=0e811c3cfa7e570119338207c0f841a3&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Ffront%2F391%2Fw1080h911%2F20190106%2FwEN5-hrfcctn0650750.jpg', NULL);

-- ----------------------------
-- Table structure for hr_role
-- ----------------------------
DROP TABLE IF EXISTS `hr_role`;
CREATE TABLE `hr_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hrid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `hr_role_ibfk_1`(`hrid`) USING BTREE,
  CONSTRAINT `hr_role_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `hr_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_role
-- ----------------------------
INSERT INTO `hr_role` VALUES (1, 3, 6);
INSERT INTO `hr_role` VALUES (79, 12, 1);
INSERT INTO `hr_role` VALUES (80, 5, 2);
INSERT INTO `hr_role` VALUES (81, 10, 3);
INSERT INTO `hr_role` VALUES (82, 11, 5);

-- ----------------------------
-- Table structure for joblevel
-- ----------------------------
DROP TABLE IF EXISTS `joblevel`;
CREATE TABLE `joblevel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '职称名称',
  `titleLevel` enum('正高级','副高级','中级','初级','员级') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createDate` timestamp(0) DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of joblevel
-- ----------------------------
INSERT INTO `joblevel` VALUES (9, '教授', '正高级', '2018-01-11 00:00:00', 1);
INSERT INTO `joblevel` VALUES (10, '副教授', '副高级', '2018-01-11 21:19:20', 1);
INSERT INTO `joblevel` VALUES (12, '助教', '初级', '2018-01-11 21:35:39', 1);
INSERT INTO `joblevel` VALUES (13, '讲师', '中级', '2018-01-11 00:00:00', 0);
INSERT INTO `joblevel` VALUES (14, '初级工程师', '初级', '2018-01-14 00:00:00', 1);
INSERT INTO `joblevel` VALUES (15, '中级工程师', '中级', '2018-01-14 00:00:00', 1);
INSERT INTO `joblevel` VALUES (16, '高级工程师', '副高级', '2018-01-14 16:19:14', 1);
INSERT INTO `joblevel` VALUES (17, '骨灰级工程师', '正高级', '2018-01-14 16:19:24', 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `iconCls` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `keepAlive` tinyint(1) DEFAULT NULL,
  `requireAuth` tinyint(1) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parentId`(`parentId`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '/', NULL, NULL, '所有', NULL, NULL, NULL, NULL, 1);
INSERT INTO `menu` VALUES (2, '/', '/home', 'Home', '员工资料', 'fa fa-user-circle-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (3, '/', '/home', 'Home', '人事管理', 'fa fa-address-card-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (4, '/', '/home', 'Home', '薪资管理', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (5, '/', '/home', 'Home', '个税管理', 'fa fa-user-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (6, '/', '/home', 'Home', '系统管理', 'fa fa-windows', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (7, '/employee/basic/**', '/emp/basic', 'EmpBasic', '基本资料', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (8, '/personnel/ec/**', '/per/ec', 'PerEc', '员工奖惩', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (9, '/personnel/train/**', '/per/train', 'PerTrain', '员工培训', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (10, '/salary/sob/**', '/sal/sob', 'SalSob', '工资账套管理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (11, '/salary/sobcfg/**', '/sal/sobcfg', 'SalSobCfg', '员工账套设置', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (12, '/ic/collection/**', '/ic/collection', 'ICCollection', '人员信息采集', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (13, '/ic/search/**', '/ic/search', 'ICSearch', '个税信息查询', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (14, '/system/basic/**', '/sys/basic', 'SysBasic', '基础信息设置', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (15, '/system/hr/**', '/sys/hr', 'SysHr', '操作员管理', NULL, NULL, 1, 6, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 368 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (161, 7, 3);
INSERT INTO `menu_role` VALUES (280, 7, 14);
INSERT INTO `menu_role` VALUES (281, 8, 14);
INSERT INTO `menu_role` VALUES (282, 9, 14);
INSERT INTO `menu_role` VALUES (293, 7, 13);
INSERT INTO `menu_role` VALUES (323, 7, 6);
INSERT INTO `menu_role` VALUES (324, 8, 6);
INSERT INTO `menu_role` VALUES (325, 9, 6);
INSERT INTO `menu_role` VALUES (326, 10, 6);
INSERT INTO `menu_role` VALUES (327, 11, 6);
INSERT INTO `menu_role` VALUES (328, 12, 6);
INSERT INTO `menu_role` VALUES (329, 13, 6);
INSERT INTO `menu_role` VALUES (330, 14, 6);
INSERT INTO `menu_role` VALUES (331, 15, 6);
INSERT INTO `menu_role` VALUES (332, 16, 6);
INSERT INTO `menu_role` VALUES (333, 17, 6);
INSERT INTO `menu_role` VALUES (334, 18, 6);
INSERT INTO `menu_role` VALUES (335, 19, 6);
INSERT INTO `menu_role` VALUES (336, 20, 6);
INSERT INTO `menu_role` VALUES (337, 21, 6);
INSERT INTO `menu_role` VALUES (338, 22, 6);
INSERT INTO `menu_role` VALUES (339, 23, 6);
INSERT INTO `menu_role` VALUES (340, 24, 6);
INSERT INTO `menu_role` VALUES (341, 25, 6);
INSERT INTO `menu_role` VALUES (342, 26, 6);
INSERT INTO `menu_role` VALUES (350, 7, 2);
INSERT INTO `menu_role` VALUES (351, 8, 2);
INSERT INTO `menu_role` VALUES (352, 9, 2);
INSERT INTO `menu_role` VALUES (353, 7, 4);
INSERT INTO `menu_role` VALUES (354, 9, 4);
INSERT INTO `menu_role` VALUES (355, 7, 5);
INSERT INTO `menu_role` VALUES (356, 8, 5);
INSERT INTO `menu_role` VALUES (357, 10, 5);
INSERT INTO `menu_role` VALUES (358, 11, 5);
INSERT INTO `menu_role` VALUES (359, 12, 5);
INSERT INTO `menu_role` VALUES (360, 13, 5);
INSERT INTO `menu_role` VALUES (361, 7, 1);
INSERT INTO `menu_role` VALUES (362, 8, 1);
INSERT INTO `menu_role` VALUES (363, 9, 1);
INSERT INTO `menu_role` VALUES (364, 10, 1);
INSERT INTO `menu_role` VALUES (365, 11, 1);
INSERT INTO `menu_role` VALUES (366, 12, 1);
INSERT INTO `menu_role` VALUES (367, 13, 1);

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of nation
-- ----------------------------
INSERT INTO `nation` VALUES (1, '汉族');
INSERT INTO `nation` VALUES (2, '蒙古族');
INSERT INTO `nation` VALUES (3, '回族');
INSERT INTO `nation` VALUES (4, '藏族');
INSERT INTO `nation` VALUES (5, '维吾尔族');
INSERT INTO `nation` VALUES (6, '苗族');
INSERT INTO `nation` VALUES (7, '彝族');
INSERT INTO `nation` VALUES (8, '壮族');
INSERT INTO `nation` VALUES (9, '布依族');
INSERT INTO `nation` VALUES (10, '朝鲜族');
INSERT INTO `nation` VALUES (11, '满族');
INSERT INTO `nation` VALUES (12, '侗族');
INSERT INTO `nation` VALUES (13, '瑶族');
INSERT INTO `nation` VALUES (14, '白族');
INSERT INTO `nation` VALUES (15, '土家族');
INSERT INTO `nation` VALUES (16, '哈尼族');
INSERT INTO `nation` VALUES (17, '哈萨克族');
INSERT INTO `nation` VALUES (18, '傣族');
INSERT INTO `nation` VALUES (19, '黎族');
INSERT INTO `nation` VALUES (20, '傈僳族');
INSERT INTO `nation` VALUES (21, '佤族');
INSERT INTO `nation` VALUES (22, '畲族');
INSERT INTO `nation` VALUES (23, '高山族');
INSERT INTO `nation` VALUES (24, '拉祜族');
INSERT INTO `nation` VALUES (25, '水族');
INSERT INTO `nation` VALUES (26, '东乡族');
INSERT INTO `nation` VALUES (27, '纳西族');
INSERT INTO `nation` VALUES (28, '景颇族');
INSERT INTO `nation` VALUES (29, '柯尔克孜族');
INSERT INTO `nation` VALUES (30, '土族');
INSERT INTO `nation` VALUES (31, '达斡尔族');
INSERT INTO `nation` VALUES (32, '仫佬族');
INSERT INTO `nation` VALUES (33, '羌族');
INSERT INTO `nation` VALUES (34, '布朗族');
INSERT INTO `nation` VALUES (35, '撒拉族');
INSERT INTO `nation` VALUES (36, '毛难族');
INSERT INTO `nation` VALUES (37, '仡佬族');
INSERT INTO `nation` VALUES (38, '锡伯族');
INSERT INTO `nation` VALUES (39, '阿昌族');
INSERT INTO `nation` VALUES (40, '普米族');
INSERT INTO `nation` VALUES (41, '塔吉克族');
INSERT INTO `nation` VALUES (42, '怒族');
INSERT INTO `nation` VALUES (43, '乌孜别克族');
INSERT INTO `nation` VALUES (44, '俄罗斯族');
INSERT INTO `nation` VALUES (45, '鄂温克族');
INSERT INTO `nation` VALUES (46, '崩龙族');
INSERT INTO `nation` VALUES (47, '保安族');
INSERT INTO `nation` VALUES (48, '裕固族');
INSERT INTO `nation` VALUES (49, '京族');
INSERT INTO `nation` VALUES (50, '塔塔尔族');
INSERT INTO `nation` VALUES (51, '独龙族');
INSERT INTO `nation` VALUES (52, '鄂伦春族');
INSERT INTO `nation` VALUES (53, '赫哲族');
INSERT INTO `nation` VALUES (54, '门巴族');
INSERT INTO `nation` VALUES (55, '珞巴族');
INSERT INTO `nation` VALUES (56, '基诺族');

-- ----------------------------
-- Table structure for politicsstatus
-- ----------------------------
DROP TABLE IF EXISTS `politicsstatus`;
CREATE TABLE `politicsstatus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of politicsstatus
-- ----------------------------
INSERT INTO `politicsstatus` VALUES (1, '中共党员');
INSERT INTO `politicsstatus` VALUES (2, '中共预备党员');
INSERT INTO `politicsstatus` VALUES (3, '共青团员');
INSERT INTO `politicsstatus` VALUES (4, '民革党员');
INSERT INTO `politicsstatus` VALUES (5, '民盟盟员');
INSERT INTO `politicsstatus` VALUES (6, '民建会员');
INSERT INTO `politicsstatus` VALUES (7, '民进会员');
INSERT INTO `politicsstatus` VALUES (8, '农工党党员');
INSERT INTO `politicsstatus` VALUES (9, '致公党党员');
INSERT INTO `politicsstatus` VALUES (10, '九三学社社员');
INSERT INTO `politicsstatus` VALUES (11, '台盟盟员');
INSERT INTO `politicsstatus` VALUES (12, '无党派民主人士');
INSERT INTO `politicsstatus` VALUES (13, '普通公民');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '职位',
  `createDate` timestamp(0) DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES (29, '技术总监', '2018-01-11 08:00:00', 1);
INSERT INTO `position` VALUES (30, '运营总监', '2018-01-11 21:13:48', 1);
INSERT INTO `position` VALUES (31, '市场总监', '2018-01-11 00:00:00', 1);
INSERT INTO `position` VALUES (33, '研发工程师', '2018-01-14 00:00:00', 0);
INSERT INTO `position` VALUES (34, '运维工程师', '2018-01-14 16:11:41', 1);
INSERT INTO `position` VALUES (36, 'Java研发经理', '2019-10-01 00:00:00', 1);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `nameZh` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_manager', '部门经理');
INSERT INTO `role` VALUES (2, 'ROLE_personnel', '人事专员');
INSERT INTO `role` VALUES (3, 'ROLE_recruiter', '招聘主管');
INSERT INTO `role` VALUES (4, 'ROLE_train', '培训主管');
INSERT INTO `role` VALUES (5, 'ROLE_performance', '薪酬绩效主管');
INSERT INTO `role` VALUES (6, 'ROLE_admin', '系统管理员');
INSERT INTO `role` VALUES (13, 'ROLE_test2', '测试角色2');
INSERT INTO `role` VALUES (14, 'ROLE_test1', '测试角色1');

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basicSalary` int(11) DEFAULT NULL COMMENT '基本工资',
  `bonus` int(11) DEFAULT NULL COMMENT '奖金',
  `lunchSalary` int(11) DEFAULT NULL COMMENT '午餐补助',
  `trafficSalary` int(11) DEFAULT NULL COMMENT '交通补助',
  `allSalary` int(11) DEFAULT NULL COMMENT '应发工资',
  `createDate` timestamp(0) DEFAULT NULL COMMENT '启用时间',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '账套名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (9, 9000, 4000, 800, 500, 14300, '2020-03-11 16:48:57', '市场部工资账套');
INSERT INTO `salary` VALUES (10, 5000, 2000, 500, 500, 8000, '2020-03-11 16:43:53', '人事部工资账套');
INSERT INTO `salary` VALUES (13, 7000, 3000, 500, 500, 11000, '2020-03-11 16:46:12', '运维部工资账套');
INSERT INTO `salary` VALUES (14, 12000, 5000, 500, 500, 18000, '2020-03-17 11:33:00', '技术部账套');
INSERT INTO `salary` VALUES (15, 15000, 6000, 1000, 500, 22500, '2020-03-17 11:36:33', '总办账套');
INSERT INTO `salary` VALUES (16, 5000, 3000, 500, 500, 9000, '2020-03-17 11:37:43', '财务部账套');
INSERT INTO `salary` VALUES (17, 20000, 6000, 1000, 500, 27500, '2020-03-17 11:38:42', '股东会账套');

-- ----------------------------
-- Table structure for tax
-- ----------------------------
DROP TABLE IF EXISTS `tax`;
CREATE TABLE `tax`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '员工编号',
  `salary` int(255) DEFAULT NULL COMMENT '工资',
  `otherSalary` int(255) DEFAULT NULL COMMENT '其他所得',
  `insurance` int(255) DEFAULT NULL COMMENT '五险一金\r\n',
  `otherDeduct` int(255) DEFAULT NULL,
  `threshold` int(255) DEFAULT NULL COMMENT '起征点',
  `taxPay` double DEFAULT NULL COMMENT '应纳税额',
  `afterTax` double DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `eid`(`eid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tax
-- ----------------------------
INSERT INTO `tax` VALUES (63, '00000001', 14300, 3000, 5000, 2000, NULL, 820, 9480);
INSERT INTO `tax` VALUES (64, '00000002', 18000, 2000, 5000, 1000, NULL, 1390, 12610);
INSERT INTO `tax` VALUES (65, '00000003', 18000, 4000, 5000, 1000, NULL, 1790, 14210);
INSERT INTO `tax` VALUES (66, '00000004', 11000, 4000, 5000, 300, NULL, 760, 8940);
INSERT INTO `tax` VALUES (67, '00000005', 11000, 2000, 5000, 1000, NULL, 490, 6510);

-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
  declare did int;
  declare pDepPath varchar(64);
  insert into department set name=depName,parentId=parentId,enabled=enabled;
  select row_count() into result;
  select last_insert_id() into did;
  set result2=did;
  select depPath into pDepPath from department where id=parentId;
  update department set depPath=concat(pDepPath,'.',did) where id=did;
  update department set isParent=true where id=parentId;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDep`(in did int,out result int)
begin
  declare ecount int;
  declare pid int;
  declare pcount int;
  declare a int;
  select count(*) into a from department where id=did and isParent=false;
  if a=0 then set result=-2;
  else
  select count(*) into ecount from employee where departmentId=did;
  if ecount>0 then set result=-1;
  else 
  select parentId into pid from department where id=did;
  delete from department where id=did and isParent=false;
  select row_count() into result;
  select count(*) into pcount from department where parentId=pid;
  if pcount=0 then update department set isParent=false where id=pid;
  end if;
  end if;
  end if;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
