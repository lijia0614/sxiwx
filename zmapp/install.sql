/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : xiaoshuo

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-11-15 13:58:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for zhimeng_ad
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_ad`;
CREATE TABLE `zhimeng_ad` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT '0' COMMENT '1为图片广告,2为代码广告,3为友情链接',
  `postion_id` int(10) DEFAULT NULL COMMENT '广告位置id',
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `start_time` int(11) DEFAULT '0',
  `end_time` int(11) DEFAULT '0',
  `content` text,
  `status` int(1) NOT NULL DEFAULT '1',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='广告表';

-- ----------------------------
-- Records of zhimeng_ad
-- ----------------------------
INSERT INTO `zhimeng_ad` VALUES ('6', '1', '27', '福利活动', '/uploads/img/20181109/5e33d18c4b6b8864da647a6b14dd0188.png', 'http://www.zmcms.com.cn/', '1534407823', '1731130616', '', '1', '1541735307', '1541741832');
INSERT INTO `zhimeng_ad` VALUES ('5', '1', '1', '黑夜传说', '/uploads/img/20181109/779de88387c9cdcb777eb699ec146712.jpg', 'http://www.ivears.com/', '1526918400', '1716566400', '', '1', '1527139435', '1541735290');

-- ----------------------------
-- Table structure for zhimeng_admin
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_admin`;
CREATE TABLE `zhimeng_admin` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `u_name` varchar(50) NOT NULL COMMENT '管理员用户名',
  `u_passwd` varchar(32) NOT NULL COMMENT '管理员密码',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `u_ip` varchar(15) NOT NULL COMMENT '管理员登陆IP',
  `u_photo` varchar(100) DEFAULT NULL COMMENT '管理员头像',
  `u_username` varchar(50) DEFAULT NULL COMMENT '姓名',
  `u_sex` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '性别 0：保密 1：男 2：女',
  `u_phone` varchar(11) NOT NULL COMMENT '手机',
  `u_email` varchar(50) NOT NULL COMMENT 'Email',
  `u_qq` varchar(13) DEFAULT NULL COMMENT 'QQ',
  `u_description` text COMMENT '描述',
  `u_countlog` int(11) NOT NULL COMMENT '登陆次数',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '启用/停用,1：启用，0：停用',
  `lastlogin_time` int(10) DEFAULT NULL COMMENT '最后登陆时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`u_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='管理员';

-- ----------------------------
-- Records of zhimeng_admin
-- ----------------------------
INSERT INTO `zhimeng_admin` VALUES ('2', 'admin', '21232f297a57a5a743894a0e4a801fc3', '1', '127.0.0.1', '', '真诚', '1', '11', '', '22', null, '206', '1', '2018', '2018', '1524048082');
INSERT INTO `zhimeng_admin` VALUES ('24', 'test11', 'f696282aa4cd4f614aa995190cf442fe', '65', '', null, 'test11', '1', '', '', '', null, '0', '1', null, '1525925013', '1525925013');

-- ----------------------------
-- Table structure for zhimeng_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_admin_log`;
CREATE TABLE `zhimeng_admin_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '登陆日志ID',
  `u_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登陆者ID',
  `u_name` varchar(60) NOT NULL DEFAULT '' COMMENT '登陆管理员',
  `create_time` int(10) DEFAULT NULL COMMENT '登陆时间',
  `log_ip` varchar(15) NOT NULL COMMENT '登陆IP',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8 COMMENT='管理员日志';

-- ----------------------------
-- Records of zhimeng_admin_log
-- ----------------------------
INSERT INTO `zhimeng_admin_log` VALUES ('27', '2', 'admin', '1523501618', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('28', '2', 'admin', '1523505350', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('29', '2', 'admin', '1523596885', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('30', '2', 'admin', '1523617014', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('31', '23', 'test11', '1523620562', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('32', '2', 'admin', '1523620617', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('33', '23', 'test11', '1523620659', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('34', '2', 'admin', '1523620749', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('35', '23', 'test11', '1523620765', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('36', '2', 'admin', '1523620802', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('37', '23', 'test11', '1523625441', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('38', '2', 'admin', '1523625452', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('39', '23', 'test11', '1523625471', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('40', '2', 'admin', '1523625613', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('41', '23', 'test11', '1523625639', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('42', '2', 'admin', '1523721776', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('43', '2', 'admin', '1523802536', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('44', '2', 'admin', '1523939651', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('45', '2', 'admin', '1524021247', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('46', '2', 'admin', '1524064127', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('47', '2', 'admin', '1524110729', '222.211.205.106');
INSERT INTO `zhimeng_admin_log` VALUES ('48', '2', 'admin', '1524237587', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('49', '2', 'admin', '1524278757', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('50', '2', 'admin', '1524320433', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('51', '2', 'admin', '1524422793', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('52', '2', 'admin', '1524451676', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('53', '2', 'admin', '1524483611', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('54', '2', 'admin', '1524539359', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('55', '2', 'admin', '1524626797', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('56', '2', 'admin', '1524640779', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('57', '2', 'admin', '1524673437', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('58', '2', 'admin', '1524824094', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('59', '2', 'admin', '1524829886', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('60', '2', 'admin', '1524831837', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('61', '2', 'admin', '1524832316', '192.168.111.126');
INSERT INTO `zhimeng_admin_log` VALUES ('62', '2', 'admin', '1524832477', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('63', '2', 'admin', '1524984291', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('64', '2', 'admin', '1525024455', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('65', '2', 'admin', '1525344812', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('66', '2', 'admin', '1525350045', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('67', '2', 'admin', '1525350167', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('68', '2', 'admin', '1525350177', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('69', '2', 'admin', '1525350684', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('70', '2', 'admin', '1525360491', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('71', '2', 'admin', '1525422024', '192.168.1.126');
INSERT INTO `zhimeng_admin_log` VALUES ('72', '2', 'admin', '1525519436', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('73', '2', 'admin', '1525520908', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('74', '2', 'admin', '1525575643', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('75', '2', 'admin', '1525575739', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('76', '2', 'admin', '1525575834', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('77', '2', 'admin', '1525575853', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('78', '2', 'admin', '1525577422', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('79', '2', 'admin', '1525578714', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('80', '2', 'admin', '1525585643', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('81', '2', 'admin', '1525586538', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('82', '2', 'admin', '1525586651', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('83', '2', 'admin', '1525586754', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('84', '2', 'admin', '1525586785', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('85', '2', 'admin', '1525920539', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('86', '24', 'test11', '1525925044', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('87', '2', 'admin', '1526264096', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('88', '2', 'admin', '1526456008', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('89', '2', 'admin', '1526979345', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('90', '2', 'admin', '1527134660', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('91', '2', 'admin', '1540202506', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('92', '2', 'admin', '1540259376', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('93', '2', 'admin', '1540344742', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('94', '2', 'admin', '1540349754', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('95', '2', 'admin', '1540436528', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('96', '2', 'admin', '1540517338', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('97', '2', 'admin', '1540777206', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('98', '2', 'admin', '1540867854', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('99', '2', 'admin', '1540952483', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('100', '2', 'admin', '1541037777', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('101', '2', 'admin', '1541122368', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('102', '2', 'admin', '1541472834', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('103', '2', 'admin', '1541490537', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('104', '2', 'admin', '1541561638', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('105', '2', 'admin', '1541650604', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('106', '2', 'admin', '1541729809', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('107', '2', 'admin', '1541988126', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('108', '2', 'admin', '1542072622', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('109', '2', 'admin', '1542160071', '127.0.0.1');
INSERT INTO `zhimeng_admin_log` VALUES ('110', '2', 'admin', '1542247110', '127.0.0.1');

-- ----------------------------
-- Table structure for zhimeng_ad_postion
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_ad_postion`;
CREATE TABLE `zhimeng_ad_postion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `alias` varchar(30) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `update_time` int(11) NOT NULL DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='广告位置表 ';

-- ----------------------------
-- Records of zhimeng_ad_postion
-- ----------------------------
INSERT INTO `zhimeng_ad_postion` VALUES ('1', '首页广告1', 'index_img', '1', '1541735223', '1510024857');
INSERT INTO `zhimeng_ad_postion` VALUES ('27', '首页广告2', 'index_b', '1', '1541735471', '1523120375');

-- ----------------------------
-- Table structure for zhimeng_article
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_article`;
CREATE TABLE `zhimeng_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT '文章分类ID',
  `image` varchar(100) DEFAULT NULL,
  `title` varchar(100) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `source` varchar(60) DEFAULT NULL COMMENT '文章来源',
  `author` varchar(50) DEFAULT 'admin' COMMENT '文章作者',
  `keyword` varchar(255) DEFAULT NULL COMMENT '文章关键词（多关键词之间用空格或者“,”隔开）',
  `description` varchar(255) DEFAULT NULL COMMENT '文章描述',
  `click` int(10) NOT NULL DEFAULT '0' COMMENT '点击数',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否审核',
  `is_recommend` int(1) DEFAULT '0' COMMENT '推荐： 1代表推荐',
  `is_seo` int(1) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `seo_desc` text,
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2837 DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of zhimeng_article
-- ----------------------------

-- ----------------------------
-- Table structure for zhimeng_auth_config
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_auth_config`;
CREATE TABLE `zhimeng_auth_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(300) DEFAULT NULL,
  `desc` varchar(500) DEFAULT NULL,
  `author` varchar(200) DEFAULT NULL,
  `value` varchar(1000) DEFAULT NULL COMMENT '商户号',
  `module` varchar(50) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '0为禁用，1为启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='第三方登录插件配置表';

-- ----------------------------
-- Records of zhimeng_auth_config
-- ----------------------------
INSERT INTO `zhimeng_auth_config` VALUES ('2', 'QQ登录', '使用QQ帐户登录网页端,注册地址：https://connect.qq.com/', '四川挚梦科技有限公司', '{\"appid\":\"101435608\",\"AppKey\":\"4d2b8205599a0804ae1ec9f0f55d6a2a\"}', 'qqconnect', '1524459865', '1');
INSERT INTO `zhimeng_auth_config` VALUES ('3', '微信网页登录', '使用微信帐号登录网页端，注册地址：https://open.weixin.qq.com', '四川挚梦科技有限公司', '{\"appid\":\"wxcf37498f9c333e27\",\"AppSecret\":\"8cfb7fd79a652d36aa1c99e020654bbc\"}', 'wxpc', '1525345461', '1');
INSERT INTO `zhimeng_auth_config` VALUES ('4', '微信小程序', '微信小程序参数配置', '四川挚梦科技有限公司', '{\"appid\":\"wx6371c3c6493e01b3\",\"AppSecret\":\"46b10e308bfd292d8b2a66d84f385c80\"}', 'wxapp', '1525345458', '1');

-- ----------------------------
-- Table structure for zhimeng_book
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_book`;
CREATE TABLE `zhimeng_book` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '书名',
  `u_id` int(10) NOT NULL COMMENT '作者ID',
  `cid` int(11) NOT NULL COMMENT '分类',
  `is_recommend` int(11) NOT NULL DEFAULT '0' COMMENT '是否推荐：1推荐，0不推荐',
  `is_index` int(11) NOT NULL DEFAULT '0' COMMENT '首页show',
  `is_fine` int(11) NOT NULL DEFAULT '0' COMMENT '是否精品：1是',
  `is_original` int(11) NOT NULL DEFAULT '0' COMMENT '是否原创：1是',
  `is_okami` int(11) NOT NULL DEFAULT '0' COMMENT '是否大神推荐：1是',
  `is_end` int(11) NOT NULL DEFAULT '0' COMMENT '是否完结：1是',
  `is_del` int(11) NOT NULL DEFAULT '0' COMMENT '删除：1',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '完结时间',
  `sort` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `info` tinytext NOT NULL COMMENT '简介',
  `type` int(2) DEFAULT NULL COMMENT '1独家首发，2驻站作品',
  `author` varchar(255) DEFAULT NULL COMMENT '作者',
  `title` tinytext COMMENT '小标题',
  `words_num` int(11) NOT NULL DEFAULT '0' COMMENT '总字数',
  `clicks` int(11) NOT NULL DEFAULT '0' COMMENT '点击量',
  `takes` int(11) NOT NULL DEFAULT '0' COMMENT '订阅',
  `price` varchar(10) DEFAULT NULL COMMENT '价格',
  `node` varchar(11) DEFAULT NULL COMMENT '收费节点，按章节数算',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhimeng_book
-- ----------------------------
INSERT INTO `zhimeng_book` VALUES ('1', '传奇', '1', '7', '0', '0', '1', '0', '1', '0', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2', '/uploads/img/20181030/662bdb1341108c316e0dfbab59a7efa6.jpg', '沈若初的胳膊忽的被抓住，下意识地抬起头，对视上一双漆黑深邃的黑眸，心跳莫名加速，楞了楞，很快反应过来，挣扎就要抽出自己的胳膊', null, '王五', '', '4541', '6', '600', '600', '');
INSERT INTO `zhimeng_book` VALUES ('2', '完美世界', '2', '7', '0', '0', '1', '1', '1', '0', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '3', '/uploads/img/20181026/f3bef126de7cce824ab111c9923b618a.jpg', '你有没有爱过一个人，倾尽所有，爱而不得？ 段七七盛装嫁给楚如斯，最终鲜血染红了婚纱。 “想娶小三，除非我死。” 她死去的时候，一个人躺在冰冷的灵堂，用她的血起誓。 楚如斯，我', null, '李四', '', '0', '14', '0', '', '2');
INSERT INTO `zhimeng_book` VALUES ('3', '一起去看流星雨', '2', '6', '0', '1', '1', '1', '0', '0', '0', '2018-10-23 16:57:56', '0000-00-00 00:00:00', '3', '/uploads/img/20181108/ff6ec0d0fc0f4a8d2539263ade782d89.jpg', '她这辈子做的最大胆的事情，便是同一个陌生男人闪婚。 传闻中她的新婚老公不举，可那个每天睡她成瘾的男人又是谁？ 沈若初懵了，一度以为这是一场梦。', null, '张三', '', '-889', '11', '35', '', '1');
INSERT INTO `zhimeng_book` VALUES ('4', '诛仙', '2', '5', '1', '1', '1', '1', '1', '0', '0', '2018-10-23 17:10:29', '0000-00-00 00:00:00', '1', '/uploads/img/20181023/06b4097adf66de87971a238b8d6fe878.jpg', '她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。', null, '程东', '', '0', '20', '0', '', '1');
INSERT INTO `zhimeng_book` VALUES ('10', '一念永恒', '2', '7', '0', '1', '0', '1', '0', '0', '0', '2018-10-26 10:34:48', '0000-00-00 00:00:00', '1', '/uploads/img/20181026/bdfdc5871fa9b9f1a3343b726493a798.jpg', '想当年本草在忘忧山时吃香喝辣好不快活。 自从遇见那小道长，打不过躲不掉，还得当跟班四处历练收妖。 动不动就来大喝一声，斩草除根！吓得本草心头哇凉一片。 只期望有朝一日揪了他的', '2', '橘橘橘子', null, '0', '16', '0', null, '1');
INSERT INTO `zhimeng_book` VALUES ('26', '南风未起飞飞', '2', '6', '1', '1', '0', '0', '0', '0', '0', '2018-10-26 17:25:47', '0000-00-00 00:00:00', '1', '/uploads/img/20181026/24051e5daac3095adc1977dfedb18407.jpg', '为了心爱的人，她夜夜忍受折磨，追寻真相，却被小叔当场强暴。 最爱的人将她推下悬崖，冰冷的海水刺痛她的骨髓。 强势回归，她步步为营，在他身下一遍一遍耳鬓厮磨。', '1', '橘橘橘子', '', '0', '21', '0', '500', '');
INSERT INTO `zhimeng_book` VALUES ('27', '小甜妻', '0', '10', '1', '1', '1', '1', '0', '1', '0', '2018-10-30 14:40:27', '0000-00-00 00:00:00', '1', '/uploads/img/20181030/ea9134973c5bc3a45ec872d3d1744504.jpg', '在爱情的道路上，三人行，江沁阑总是旁观的那一个~~~', null, '李四', '', '0', '12', '0', '30', '');
INSERT INTO `zhimeng_book` VALUES ('28', '不负红尘不负你', '0', '9', '1', '1', '1', '0', '0', '0', '0', '2018-10-30 14:41:04', '0000-00-00 00:00:00', '1', '/uploads/img/20181030/ac083b976edd47ec1d326ebfbfd9d9bb.jpg', '他的皇叔，却将他侄子的妃子压在榻上狠狠欺辱；他恨透了她，如今回来了，势必要将她脚踏到尘埃里，往死里整她……', null, '王五', '回眸三生，而你还在！', '0', '42', '0', '500', null);
INSERT INTO `zhimeng_book` VALUES ('29', '我曾在低谷时仰望你', '2', '8', '1', '1', '1', '1', '1', '0', '0', '2018-10-30 15:57:13', '0000-00-00 00:00:00', '1', '/uploads/img/20181030/9a3f1b95c254b8f3b3bce47a082e9940.jpg', '为了偿还债务，我来到雇主的家里照顾他的孩子。 某天他为了赶走上门的女人，请我帮他演一场戏。 谁知却假戏真做，那晚他把我压在客厅的沙发上。 事后他给我五万块，说是我的辛苦费。', null, '落栀', '我曾在低谷时仰望你', '14072', '460', '85', '', '3');
INSERT INTO `zhimeng_book` VALUES ('30', '不服来战', '0', '5', '1', '0', '0', '1', '1', '0', '0', '2018-10-31 10:22:51', '0000-00-00 00:00:00', '1', '/uploads/img/20181031/ace7e7f7e9eab56b04f1765367f96fa1.jpg', '莫子欣做梦也没想到，精心照料植物人老公三年，他醒来做的第一件事，却是将她推到别的男人床上…… “莫子欣，你这个贱人！离婚！” 莫子欣撩着长发，笑得妖娆妩媚，“秦先生，你确定', null, '半夏', '名门夺爱：秦少，不服来战！', '5268', '34', '1000', '500', '');
INSERT INTO `zhimeng_book` VALUES ('31', '圣墟', '0', '7', '0', '1', '0', '0', '1', '0', '0', '2018-11-01 10:16:52', '0000-00-00 00:00:00', '1', '/uploads/img/20181101/fe7877a0a4e3371852be69a7f51f15af.jpg', '在破败中重生在破败中重生在破败中重生在破败中重生在破败中重生', null, '橘子', '在破败中重生', '15', '1', '200', '200', '');
INSERT INTO `zhimeng_book` VALUES ('32', '农家小酒女', '0', '5', '0', '0', '0', '0', '1', '0', '0', '2018-11-01 11:37:43', '0000-00-00 00:00:00', '1', '/uploads/img/20181101/268f0120e58267a23757bf8e454d46a7.jpg', '顺风顺水二十多年，叶小双怎么也没想到，有一天会莫名其妙穿越到了个穷乡僻壤。 克母克夫，爹爹软弱，从小受尽欺凌，还被叔伯逼迫，嫁给了个残疾又病入膏肓的夫君。 老天爷，你还敢让', null, '小媛', '农家小酒女', '9847', '23', '600', '300', '');

-- ----------------------------
-- Table structure for zhimeng_book_category
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_book_category`;
CREATE TABLE `zhimeng_book_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `sort` varchar(255) NOT NULL COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '1正常，0禁用',
  `is_del` varchar(255) DEFAULT '0' COMMENT '1:删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhimeng_book_category
-- ----------------------------
INSERT INTO `zhimeng_book_category` VALUES ('9', '都市异能', '2018-10-30 10:52:13', '1', '1', '0');
INSERT INTO `zhimeng_book_category` VALUES ('8', '时空穿越', '2018-10-30 10:51:57', '1', '1', '0');
INSERT INTO `zhimeng_book_category` VALUES ('7', '玄幻仙侠', '2018-10-23 16:58:28', '3', '1', '0');
INSERT INTO `zhimeng_book_category` VALUES ('5', '都市言情', '2018-10-23 15:00:34', '2', '1', '0');
INSERT INTO `zhimeng_book_category` VALUES ('6', '浪漫青春', '2018-10-23 15:03:10', '1', '1', '0');
INSERT INTO `zhimeng_book_category` VALUES ('10', '总裁豪门', '2018-10-30 10:52:23', '1', '1', '0');
INSERT INTO `zhimeng_book_category` VALUES ('11', '悬疑灵异', '2018-10-30 10:52:37', '1', '1', '0');

-- ----------------------------
-- Table structure for zhimeng_category
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_category`;
CREATE TABLE `zhimeng_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章分类ID',
  `model` varchar(200) DEFAULT NULL COMMENT '所属模型',
  `title` varchar(50) NOT NULL COMMENT '分类名称',
  `alias` varchar(32) NOT NULL COMMENT '分类别名',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父ID',
  `description` text NOT NULL COMMENT '分类描述',
  `sort` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `image` varchar(300) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `is_menu` int(1) DEFAULT '0' COMMENT '是否在导航上显示',
  `language` int(2) unsigned NOT NULL DEFAULT '1' COMMENT '1 中文  2 英文',
  `is_seo` int(1) DEFAULT '0',
  `seo_title` varchar(255) DEFAULT NULL,
  `seo_keywords` varchar(255) DEFAULT NULL,
  `seo_desc` text,
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of zhimeng_category
-- ----------------------------
INSERT INTO `zhimeng_category` VALUES ('7', 'goods', '手机', 'mobile', '0', '手机', '1', '', '1', '0', '1', '0', '', '', '', '1524898017', '1525105210');
INSERT INTO `zhimeng_category` VALUES ('8', 'goods', '三星', '三星', '7', '三星', '1', '', '1', '0', '1', '0', '', '', '', '1524898027', '1525365301');

-- ----------------------------
-- Table structure for zhimeng_chapter
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_chapter`;
CREATE TABLE `zhimeng_chapter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(10) NOT NULL COMMENT '书ID',
  `number` int(11) NOT NULL DEFAULT '1' COMMENT '章节数',
  `name` varchar(255) NOT NULL COMMENT '章节名称',
  `price` int(11) NOT NULL COMMENT '章节价格(书币)',
  `content` text NOT NULL COMMENT '内容',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '是否审核：1审核；0未审核；2草稿',
  `is_del` int(255) NOT NULL DEFAULT '0' COMMENT '1:删除；0：未删除',
  `time` int(11) DEFAULT NULL,
  `sort` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhimeng_chapter
-- ----------------------------
INSERT INTO `zhimeng_chapter` VALUES ('27', '29', '1', '第一章 抓奸', '10', '“呲！”指尖传来一阵猛烈的疼痛，秦青绾回过神来，才发现针扎到手指，鲜血从指尖渗出来，她赶忙将血拭去，可还是被心思细腻的觅儿看到了。觅儿拉住秦青绾的手放在面前，“觅儿给娘亲吹吹。”看到觅儿已经被...\r\n三年前，白晚舟被迫与秦戎和离，从此消失无踪，他疯了一样的打下一座又一座城池，只为找到她。 三年后，他们相撞，他却冷冷嘲讽：白晚舟，不人不鬼，这就是你要追求的荣华富贵？', '1', '0', '1540974975', null);
INSERT INTO `zhimeng_chapter` VALUES ('30', '29', '2', '第二章 结婚', '0', '现在开到付来了', '1', '0', '1540889940', null);
INSERT INTO `zhimeng_chapter` VALUES ('31', '29', '3', '第三章 薛桑', '20', '三年前，白晚舟被迫与秦戎和离，从此消失无踪，他疯了一样的打下一座又一座城池，只为找到她。 三年后，他们相撞，他却冷冷嘲讽：白晚舟，不人不鬼，这就是你要追求的荣华富贵？\r\n三年前，白晚舟被迫与秦戎和离，从此消失无踪，他疯了一样的打下一座又一座城池，只为找到她。 三年后，他们相撞，他却冷冷嘲讽：白晚舟，不人不鬼，这就是你要追求的荣华富贵？', '1', '0', '1540974958', null);
INSERT INTO `zhimeng_chapter` VALUES ('32', '29', '4', '第四章 手段', '0', '<p>\r\n	她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n</p>\r\n<p>\r\n	最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32\r\n到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32\r\n到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32\r\n到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我\r\n</p>\r\n<p>\r\n	<p>\r\n		她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n	</p>\r\n	<p>\r\n		最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我\r\n	</p>\r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p>\r\n		她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n	</p>\r\n	<p>\r\n		最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我\r\n	</p>\r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p>\r\n		她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n	</p>\r\n	<p>\r\n		最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我\r\n	</p>\r\n	<p>\r\n		<br />\r\n	</p>\r\n	<p>\r\n		她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。\r\n	</p>\r\n	<p>\r\n		最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我她本宫中一品女医，一朝重生，却变成了顾府却软弱无用，还患着痴傻之症的沈素言。夫君厌她，姨娘欺她，连姨娘身边的小丫鬟，也敢生些不该有的心思。 最新章节 第202章 口是心非 更新时间：2018-10-27 18:47:32 到了地方，欢欢喜喜放风筝的人也只有冬梅和星凤而已。沈素言心事满满，哪有心情放风筝，而亦书又怎么可能丢下她一个人呢？“公主不去放风筝么？”亦书看着沈素言的侧脸，而沈素言则抬头望着天空。“不了，我\r\n	</p>\r\n</p>', '1', '0', '1541052939', null);
INSERT INTO `zhimeng_chapter` VALUES ('34', '29', '5', '第五章 小水做的枣糕', '0', '“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她\r\n\r\n“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她。“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她“孩子确实是因为你才会有的，但是，孩子不是你的！”叶清清眯着眼睛，回想着那一夜，“我察觉到你对小晚不是没感觉的，就故意约小晚到这附近，本来我是想让一群小混混毁了她的清白，然后再出来救她', '1', '0', '1541057305', null);
INSERT INTO `zhimeng_chapter` VALUES ('37', '32', '1', '第一章 爱他入骨', '0', '<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她爱他入骨，执意要嫁给他为妻。谁知道，他恨不得要她的性命。为了救他心爱的女人，他要她肚子里的孩子做药引。到最后，他将她送入棺木，活活闷死，她才知道自己爱错了这一场。若有来世，她定不要相遇，爱上他！</span></span>\r\n</p>', '1', '0', '1541129203', null);
INSERT INTO `zhimeng_chapter` VALUES ('36', '29', '6', '第六章 万里江山不如你', '0', '<p>\r\n	<span font-size:14px;background-color:#ffffff;\"=\"\" style=\"color: rgb(119, 119, 119);\">&nbsp; &nbsp; &nbsp; &nbsp; 她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……<span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span></span>\r\n</p>\r\n<p>\r\n	<span font-size:14px;background-color:#ffffff;\"=\"\" style=\"color: rgb(119, 119, 119);\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span font-size:14px;background-color:#ffffff;\"=\"\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span></span>\r\n</p>', '1', '0', '1541140220', null);
INSERT INTO `zhimeng_chapter` VALUES ('38', '32', '2', '第二章 是不是不喜欢我了？', '0', '<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span></span>\r\n</p>', '1', '0', '1541139174', null);
INSERT INTO `zhimeng_chapter` VALUES ('39', '30', '1', '第一章 不服来战', '0', '<p>\r\n	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><br />\r\n</span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……</span><br />\r\n</span>\r\n</p>', '1', '0', '1541142566', null);
INSERT INTO `zhimeng_chapter` VALUES ('40', '1', '1', '第一章 传奇的开始', '0', '<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp; &nbsp;<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp; &nbsp; &nbsp; 半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp; &nbsp;半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><br />\r\n</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp; &nbsp; &nbsp; 半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n	</p>\r\n	<p>\r\n		<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp; &nbsp;半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进半个月后。许久没发生过大事的帝都再一次沸腾了。上一次还是因为白家千金绑架杀人的案件，震惊了整个帝都。而这次，则是穆氏总裁穆呈延和顾氏总裁前妻江诗妍的婚礼。要知道，这位江小姐不仅亲手将前夫送进</span>\r\n	</p>\r\n<br />\r\n</span>\r\n</p>', '1', '0', '1541488473', null);
INSERT INTO `zhimeng_chapter` VALUES ('41', '32', '3', '第三章 一发入魂', '0', '<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">有时候苏韵锦会想，是不是自己对他太苛刻了？回国后的时间里，她看着他的改变，看着他作为一个男人跟父亲的担当跟责任，所做的任何事，都顾及着她跟孩子。如果，真的自己就这样去了，真没有半点遗憾了吗？</span>', '1', '0', '1541490958', null);
INSERT INTO `zhimeng_chapter` VALUES ('42', '3', '1', '第一章 开学的第一天', '0', '<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span></span>\r\n</p>\r\n<p>\r\n	<span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp; &nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">帕森的脸色一沉，似乎所眼前所发生的情况有些拿不定主意，我看见莎莎忽然站到帕森的身边拉住他的手臂。“我们必须救父亲！”帕森皱了皱眉，眼底闪过一抹不甘心，最后还是让了步。“将军，我让你把那个女人带</span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><span style=\"color:#777777;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\"></span><br />\r\n</span>\r\n</p>', '1', '0', '1541561697', null);
INSERT INTO `zhimeng_chapter` VALUES ('43', '29', '7', '第七章 测试', '0', '测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试<span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span>测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试<span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span><span>测试</span>测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试', '1', '0', '1541661991', null);
INSERT INTO `zhimeng_chapter` VALUES ('44', '31', '1', '1', '0', '的范德萨发第三方的', '1', '0', '1541662283', null);
INSERT INTO `zhimeng_chapter` VALUES ('47', '3', '2', '第二章 测试', '0', '她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……', '1', '0', '1541743565', null);
INSERT INTO `zhimeng_chapter` VALUES ('50', '3', '0', '第四章  万马奔腾', '0', '她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……', '2', '0', '1541743635', null);
INSERT INTO `zhimeng_chapter` VALUES ('49', '3', '4', '第三章 千军万马', '0', '她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……她与陌生男人一夜迷情，被老公婆婆扫地出门。 五年后，她携萌宝回归，虐渣，恋爱两不误。 “叔叔，你来晚了！她和另个叔叔去民政局了。”小奶包叼着棒棒糖，拽拽地说道。 “什么叔叔！我是你爹地！小兔崽子！”某醋缸教训完儿子，开着玛莎拉蒂冲到民政局。 宋蓁蓁还没说话，人已经被他狠狠壁咚在墙上：“女人，你还敢和其他男人扯证，看来是我昨晚对你太温柔……', '0', '0', '1541743609', null);

-- ----------------------------
-- Table structure for zhimeng_collection
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_collection`;
CREATE TABLE `zhimeng_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `small_img_url` varchar(200) DEFAULT NULL,
  `collect_url` varchar(400) DEFAULT NULL,
  `get_content_urls_box` varchar(100) DEFAULT NULL COMMENT '内容url所属容器',
  `collect_content_type` varchar(50) DEFAULT NULL,
  `collect_page_status` int(1) DEFAULT '0',
  `collect_page_min` int(11) DEFAULT '1' COMMENT '采集分页开始页',
  `collect_page_max` int(11) DEFAULT '10' COMMENT '采集分页结束页',
  `get_content_collect_urls` varchar(500) DEFAULT NULL,
  `get_content_collect_urls_remove` varchar(200) DEFAULT NULL,
  `collect_content_urls` text,
  `collect_content_box` varchar(100) DEFAULT NULL COMMENT '采集内容所属容器',
  `collect_title` varchar(100) DEFAULT NULL,
  `collect_data` varchar(2000) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `get_content_page` varchar(100) DEFAULT NULL COMMENT '获取内容分页URL的规则',
  `is_get_content_small_image` int(1) DEFAULT '0',
  `is_get_content_url` int(1) DEFAULT '0',
  `is_remove_a` int(1) DEFAULT '0',
  `is_remove_script` int(1) DEFAULT '0',
  `is_remove_div` int(1) DEFAULT '0',
  `is_remove_p` int(1) DEFAULT '0',
  `is_remove_img` int(1) DEFAULT NULL,
  `is_remove_input` int(1) DEFAULT '0',
  `is_remove_textarea` int(1) DEFAULT '0',
  `is_remove_from` int(1) DEFAULT '0',
  `is_remove_iframe` int(1) DEFAULT '0',
  `is_remove_span` int(1) DEFAULT '0',
  `is_remove_li` int(1) DEFAULT '0',
  `is_remove_mark` varchar(1000) DEFAULT NULL,
  `remove_keyword` varchar(1000) DEFAULT '0',
  `replace_keyword` varchar(1000) DEFAULT '0',
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='采集规则表\r\n';

-- ----------------------------
-- Records of zhimeng_collection
-- ----------------------------
INSERT INTO `zhimeng_collection` VALUES ('15', 'download', '236', 'img', 'http://www.1ppt.com/hangye/ppt_hangye_分页.html', '.tplist li', 'GB2312', '1', '1', '23', 'a', 'moban', null, null, '行业PPT模板下载', '{\"title\":\"h1###text\",\"content\":\".content###html\",\"filesrc\":\".downurllist a###href\"}', '1', '', '1', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', null, '', '第一PPT|IVEARS', '2017', '2017');
INSERT INTO `zhimeng_collection` VALUES ('16', 'download', '354', 'img', 'http://www.1ppt.com/jieri/ppt_jieri_分页.html', '.tplist li', 'GB2312', '1', '1', '23', 'a', 'moban', null, null, '节日PPT模板下载', '{\"title\":\"h1###text\",\"content\":\".content###html\",\"filesrc\":\".downurllist a###href\"}', '1', '', '1', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', null, '', '第一PPT|IVEARS', '2017', '2017');
INSERT INTO `zhimeng_collection` VALUES ('18', 'download', '355', 'img', 'http://www.pptbz.com/ppt/symb/index_分页.html', '.module-list .list-icon', 'GB2312', '1', '2', '30', 'a', '', null, null, '商业模板', '{\"title\":\"h1###text\",\"content\":\"#soft-intro###html\",\"filesrc\":\".xiazai###html\"}', '1', '', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', null, 'document.writeln', '', '2017', '2017');
INSERT INTO `zhimeng_collection` VALUES ('19', 'article', '156', 'img', 'http://www.1ppt.com/powerpoint/ppt_jiaocheng_分页.html', '.arclist li', 'GB2312', '1', '1', '15', 'a', '', null, null, 'ppt教程', '{\"title\":\"h1###text\",\"content\":\".content###html\"}', '1', '', '0', '0', '1', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '-h1\r\n-.arc_info\r\n-.bdshare\r\n-#bdshare\r\n-.dede_pages\r\n-table', '<h1>(.×?)<\\/h1>', '1ppt.com|ttddcc.cn', '2017', '2017');
INSERT INTO `zhimeng_collection` VALUES ('14', 'download', '236', 'img', 'http://www.1ppt.com/moban/ppt_moban_分页.html', '.tplist li', 'GB2312', '1', '1', '71', 'a', 'moban', null, null, '模板ppt', '{\"title\":\"h1###text\",\"content\":\".content###html\",\"filesrc\":\".downurllist a###href\"}', '1', '', '1', '0', '1', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', null, '', '第一PPT|IVEARS', '2017', '2017');
INSERT INTO `zhimeng_collection` VALUES ('20', 'article', '334', 'img', 'http://www.1ppt.com/word/word_jiaocheng_分页.html', '.arclist li', 'GB2312', '1', '1', '20', 'a', '', null, null, 'word教程', '{\"title\":\"h1###text\",\"content\":\".content###html\"}', '1', '', '0', '0', '1', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '-h1\r\n-.arc_info\r\n-.bdshare\r\n-#bdshare\r\n-.dede_pages\r\n-table', '<h1>(.×?)<\\/h1>', '1ppt.com|ttddcc.cn', '2017', '2017');
INSERT INTO `zhimeng_collection` VALUES ('21', 'article', '14', 'img', 'http://www.1ppt.com/excel/excel_jiaocheng_分页.html', '.arclist li', 'GB2312', '1', '1', '21', 'a', '', null, null, 'Excel教程', '{\"model\":\"\",\"title\":\"h1###text\",\"content\":\".content###html\"}', '1', '', '0', '0', '1', '1', '0', '0', '0', '0', '0', '1', '0', '0', '0', '-h1\r\n-.arc_info\r\n-.bdshare\r\n-#bdshare\r\n-.dede_pages\r\n-table', '<h1>(.*?)<\\/h1>', '1ppt.com|ttddcc.cn', '2017', '2018');
INSERT INTO `zhimeng_collection` VALUES ('22', 'article', '14', 'img', 'http://www.1ppt.com/excel/excel_jiaocheng_分页.html', '.arclist li', 'GB2312', '1', '1', '21', 'a', '', null, null, 'Excel教程', '{\"model\":\"\",\"title\":\"h1###text\",\"content\":\".content###html\"}', '1', '', '1', '0', '1', '1', '1', '0', '0', '0', '0', '1', '0', '0', '0', '-h1\r\n-.arc_info\r\n-.bdshare\r\n-#bdshare\r\n-.dede_pages\r\n-table', '<h1>(.×?)<\\/h1>', '', '2017', '2018');

-- ----------------------------
-- Table structure for zhimeng_collection_url
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_collection_url`;
CREATE TABLE `zhimeng_collection_url` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `collects_id` int(11) DEFAULT NULL,
  `small_img` varchar(300) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `status` int(1) DEFAULT '0',
  `code` varchar(32) DEFAULT NULL COMMENT '0',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7221 DEFAULT CHARSET=utf8 COMMENT='待采集内容URL';

-- ----------------------------
-- Records of zhimeng_collection_url
-- ----------------------------

-- ----------------------------
-- Table structure for zhimeng_config
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_config`;
CREATE TABLE `zhimeng_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动增长id',
  `c_type` varchar(100) DEFAULT NULL,
  `c_key` varchar(100) NOT NULL DEFAULT '' COMMENT '配置key必须是唯一',
  `c_value` text COMMENT '配置值,多值以逗号分割',
  `c_value_desc` varchar(100) NOT NULL DEFAULT '' COMMENT '配置值描述',
  `c_create_time` int(11) DEFAULT NULL COMMENT '记录创建时间',
  `c_update_time` int(11) DEFAULT NULL COMMENT '记录最后更新时间',
  `status` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='系统配置';

-- ----------------------------
-- Records of zhimeng_config
-- ----------------------------
INSERT INTO `zhimeng_config` VALUES ('22', 'system', 'WEB_SITE', '{\"site_name\":\"\\u53cc\\u6eaa\\u6587\\u5b66\",\"site_url\":\"http:\\/\\/www.ivears.com\\/\",\"site_title\":\"\\u53cc\\u6eaa\\u6587\\u5b66\",\"site_keywords\":\"\\u53cc\\u6eaa\\u6587\\u5b66\",\"site_description\":\"\\u53cc\\u6eaa\\u6587\\u5b66\",\"site_icp\":\"\\u6d59ICP\\u590718033749\\u53f7\",\"site_copyright\":\"\\u7248\\u6743\",\"site_tongji\":\"\\u7edf\\u8ba1\\u4ee3\\u7801\",\"site_status\":\"1\",\"request_cache_except\":\"\"}', '站点全局设置', '1522900396', '1541650620', '1');
INSERT INTO `zhimeng_config` VALUES ('23', 'system', 'SMTP_CONFIG', '{\"s\":\"\\/admin\\/smtp\\/setting.html\",\"random\":\"0.9059154442663122\",\"mail_name\":\"\\u56db\\u5ddd\\u631a\\u68a6\\u79d1\\u6280\\u6709\\u9650\\u516c\\u53f8\",\"smtp\":\"smtp.exmail.qq.com\",\"smtp_ssl\":\"1\",\"smtp_port\":\"465\",\"smtp_user\":\"info@zhi-meng.cn\",\"smtp_pwd\":\"Is6cyx771122\",\"test_address\":\"905873908@qq.com\",\"status\":\"1\",\"mail_address\":\"info@zhi-meng.cn\"}', 'SMTP邮件配置', '1522900396', '1525318042', '1');
INSERT INTO `zhimeng_config` VALUES ('24', 'system', 'STATIC_CACHE', '{\"CACHE_ON\":\"1\",\"CACHE_RULES\":{\"*\":[\"{$_SERVER.REQUEST_URI|md5}\"]},\"CACHE_TIME\":\"3600\",\"CACHE_NO_GROUP\":[\"admin\",\"member\"],\"CACHE_NO_MODULE\":[\"\\/home\\/login\\/\",\"\\/home\\/weixin\\/\",\"\\/home\\/product\\/\",\"\\/home\\/ajax\\/\",\"\\/home\\/oauth\\/\",\"\\/home\\/api\\/\"],\"CACHE_NO_ACTION\":[\"\\/home\\/download\\/downloadfile\",\"\\/home\\/download\\/index\"]}', '静态缓存配置', '1523010494', '1525943694', '1');
INSERT INTO `zhimeng_config` VALUES ('25', 'system', 'TEMPLATE_CONFIG', '{\"s\":\"\\/Admin\\/template\\/index.html\",\"random\":\"0.20567764409730116\",\"pc_template\":\"default\",\"mobile_template\":\"default\",\"members_template\":\"default\"}', '模板设置', '1523073629', '1524132127', '0');
INSERT INTO `zhimeng_config` VALUES ('28', 'imgset', 'IMG_PRODUCT_IMAGE', '{\"s\":\"\\/Admin\\/setting\\/imgset_edit.html\",\"title\":\"\\u4ea7\\u54c1\\u7f29\\u7565\\u56fe\",\"module\":\"product\",\"action\":\"image\",\"width\":\"200\",\"height\":\"200\",\"status\":\"1\",\"water_status\":\"1\",\"waterImage\":\"\\/public\\/images\\/logo.png\",\"water_position\":\"1\",\"water_op\":\"60\"}', '产品缩略图', '1524279004', '1524456834', '1');
INSERT INTO `zhimeng_config` VALUES ('27', 'imgset', 'IMG_ARTICLE_IMAGE', '{\"s\":\"\\/Admin\\/setting\\/imgset_edit.html\",\"title\":\"\\u8d44\\u8baf\\u7f29\\u7565\\u56fe\",\"module\":\"article\",\"action\":\"image\",\"width\":\"100\",\"height\":\"100\",\"status\":\"1\",\"water_status\":\"1\",\"waterImage\":\"\\/public\\/images\\/logo.png\",\"water_position\":\"5\",\"water_op\":\"10\"}', '资讯缩略图', '1524251495', '1524470957', '1');
INSERT INTO `zhimeng_config` VALUES ('30', 'codeset', 'MANAGE_CODE', '{\"s\":\"\\/system\\/setting\\/code_edit.html\",\"c_key\":\"MANAGE_CODE\",\"code_type\":\"2\",\"code_length\":\"4\",\"code_width\":\"105\",\"code_height\":\"33\",\"status\":\"1\"}', '后台验证码', '1524279004', '1525575870', '1');
INSERT INTO `zhimeng_config` VALUES ('31', 'codeset', 'MEMBER_CODE', '{\"s\":\"\\/system\\/setting\\/code_edit.html\",\"c_key\":\"MEMBER_CODE\",\"code_type\":\"2\",\"code_length\":\"4\",\"code_width\":\"100\",\"code_height\":\"35\",\"status\":\"1\"}', '前台验证码', '1524279004', '1525575710', '1');
INSERT INTO `zhimeng_config` VALUES ('32', 'system', 'CUSTOMIZE_SITE', '{\"site_tel\":\"13880713476\",\"logo\":\"\\/uploads\\/img\\/20181102\\/b5e7373ffb39fec81328b3cb4e9bbf9c.PNG\",\"tel\":\"400-886-3878\",\"qq\":\"1181894949\",\"site_address\":\"\\u56db\\u5ddd\\u6210\\u90fd11\",\"site_kefu\":\"\"}', '自定义站点设置', '1525113143', '1541144430', '1');

-- ----------------------------
-- Table structure for zhimeng_gift
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_gift`;
CREATE TABLE `zhimeng_gift` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) NOT NULL COMMENT '书籍id',
  `u_id` int(11) NOT NULL COMMENT '用户id',
  `gift_name` varchar(255) NOT NULL COMMENT '礼物名',
  `number` int(11) NOT NULL COMMENT '礼物数量',
  `total` varchar(255) NOT NULL COMMENT '总价',
  `msg` varchar(255) NOT NULL COMMENT '留言',
  `time` int(11) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='打赏，礼物';

-- ----------------------------
-- Records of zhimeng_gift
-- ----------------------------
INSERT INTO `zhimeng_gift` VALUES ('1', '29', '2', '玫瑰花', '2', '100', '感激涕零，潸然泪下，于是想给您一朵玫瑰！', '1541586038');
INSERT INTO `zhimeng_gift` VALUES ('2', '29', '2', '玫瑰花', '1', '50', '感激涕零，潸然泪下，于是想给您一朵玫瑰！', '1541586087');
INSERT INTO `zhimeng_gift` VALUES ('4', '29', '2', '钻石', '1', '999', '爱情恒久远，钻石永流传！', '1541641507');
INSERT INTO `zhimeng_gift` VALUES ('5', '29', '2', '玫瑰花', '1', '888', '感激涕零，潸然泪下，于是想给一朵玫瑰！', '1541641738');
INSERT INTO `zhimeng_gift` VALUES ('7', '29', '2', '巧克力', '2', '198', '爱你，就给你松露巧克力，追文甜甜又蜜蜜！', '1541646787');
INSERT INTO `zhimeng_gift` VALUES ('8', '28', '2', '金元宝', '2', '1040', '爱你，就要送你金元宝！', '1541647716');
INSERT INTO `zhimeng_gift` VALUES ('9', '27', '2', '玫瑰花', '1', '50', '感激涕零，潸然泪下，于是想给您一朵玫瑰！', '1542075674');

-- ----------------------------
-- Table structure for zhimeng_images
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_images`;
CREATE TABLE `zhimeng_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(100) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  `fileds_name` varchar(100) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=228 DEFAULT CHARSET=utf8 COMMENT='图片中间表';

-- ----------------------------
-- Records of zhimeng_images
-- ----------------------------
INSERT INTO `zhimeng_images` VALUES ('161', 'Article', '1932', 'cert', '/uploads/img/20180418/3fa4891c2e38ae35960a9eee7bde849c.jpg', '1523980865', '1523980865');
INSERT INTO `zhimeng_images` VALUES ('160', 'Article', '1932', 'images', '/uploads/img/20180418/aa8925eba9ed0bbfadf7a3e2ba973326.jpg', '1523980865', '1523980865');
INSERT INTO `zhimeng_images` VALUES ('172', 'Article', '1931', 'images', '/uploads/img/20180418/565a839622a29ec2b452e64c9a4f8314.jpg', '1524024753', '1524024753');
INSERT INTO `zhimeng_images` VALUES ('171', 'Article', '1931', 'images', '/uploads/img/20180418/85801c32e08310459c16c6e2469a0ced.jpg', '1524024753', '1524024753');
INSERT INTO `zhimeng_images` VALUES ('221', 'Goods', '4', 'mult_image', '/uploads/img/20180428/fd8dd75b1889724bd1c60f35c0a49058.jpg', '1524907496', '1524907496');
INSERT INTO `zhimeng_images` VALUES ('220', 'Goods', '4', 'mult_image', '/uploads/img/20180428/195248c26d4adf63cfe8f34e143481a4.jpg', '1524907496', '1524907496');
INSERT INTO `zhimeng_images` VALUES ('227', 'Test', '2', 'images', '/uploads/img/20180524/79bea8876a5ac316550f8845b7911a50.jpg', '1527166156', '1527166156');

-- ----------------------------
-- Table structure for zhimeng_links
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_links`;
CREATE TABLE `zhimeng_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `display_type` int(1) DEFAULT '1' COMMENT '1为首页显示,2为全站显示',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '友情链接文字，显示在友情链接上的文字',
  `image` varchar(255) DEFAULT '' COMMENT '友情链接图片地址',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT '友情链接地址，url',
  `description` text COMMENT '链接描述',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序，升序规定前台友情链接的显示顺序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '友情链接状态，1正常,0禁用',
  `start_time` int(10) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(10) DEFAULT NULL COMMENT '结束时间',
  `create_time` int(10) DEFAULT NULL COMMENT '友情链接添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '友情链接最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=142 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of zhimeng_links
-- ----------------------------
INSERT INTO `zhimeng_links` VALUES ('139', '2', '落尘文学', '', 'https://www.luochen.com/', null, '1', '1', '1541472942', '1541433600', '1541472952', '1541472952');
INSERT INTO `zhimeng_links` VALUES ('140', '2', '有梦文学', '', 'http://www.yomeng.com/', null, '1', '1', '1534407823', '1716566400', '1541472981', '1541473042');
INSERT INTO `zhimeng_links` VALUES ('141', '2', '安夏书院', '', 'http://new.axshuyuan.com/#/home/homeindex', null, '1', '1', '1534407823', '1730868225', '1541473030', '1541473037');

-- ----------------------------
-- Table structure for zhimeng_member
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_member`;
CREATE TABLE `zhimeng_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL COMMENT '真实姓名',
  `sex` int(20) NOT NULL COMMENT '1男2女',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '余额',
  `image` varchar(255) NOT NULL COMMENT '头像',
  `wechat` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL COMMENT '密码',
  `time` datetime NOT NULL,
  `pen_name` varchar(255) NOT NULL COMMENT '笔名',
  `qq` varchar(255) DEFAULT NULL,
  `id_num` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `is_author` int(255) DEFAULT '0' COMMENT '1为原创作者',
  `author_time` datetime DEFAULT NULL COMMENT '申请作者时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhimeng_member
-- ----------------------------
INSERT INTO `zhimeng_member` VALUES ('2', '18200398346', '江双琴', '2', '4738', '/uploads/img/20181105/eadce6359ecc9dbec7e33f50e07cf320.jpg', 'juzi0614', 'b9e79361b4040a3f3a71668163d2f058', '2018-10-24 17:09:51', '橘橘橘橘子！', '1181894949', '510824199606140411', '成都天府三街新希望大厦B座507', '1', '2018-10-25 15:46:50');
INSERT INTO `zhimeng_member` VALUES ('3', '', '橘子', '0', '100', '/uploads/img/20181105/eadce6359ecc9dbec7e33f50e07cf320.jpg', 'juzijiang', '', '0000-00-00 00:00:00', '局橘子', '354112311', '515664122001', '环球中心', '0', null);
INSERT INTO `zhimeng_member` VALUES ('4', '18200398347', '', '0', '0', '', '', '14e1b600b1fd579f47433b88e8d85291', '2018-11-09 14:39:49', '', null, null, null, '0', null);

-- ----------------------------
-- Table structure for zhimeng_message
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_message`;
CREATE TABLE `zhimeng_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(10) unsigned NOT NULL COMMENT '留言者id',
  `b_id` int(10) unsigned NOT NULL COMMENT '书籍id',
  `content` text NOT NULL COMMENT '留言内容',
  `author_id` int(10) unsigned NOT NULL COMMENT '作者id',
  `time` int(11) NOT NULL COMMENT '留言时间',
  `image` varchar(255) NOT NULL COMMENT '留言者头像',
  `u_name` varchar(255) DEFAULT NULL COMMENT '留言者昵称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Records of zhimeng_message
-- ----------------------------
INSERT INTO `zhimeng_message` VALUES ('3', '2', '29', '地方第三方', '3', '1541148788', '/uploads/img/20181030/662bdb1341108c316e0dfbab59a7efa6.jpg', '橘橘橘橘子！');
INSERT INTO `zhimeng_message` VALUES ('4', '2', '29', '这本书写的真的不错呀！', '3', '1541148846', '/uploads/img/20181030/662bdb1341108c316e0dfbab59a7efa6.jpg', '橘橘橘橘子！');
INSERT INTO `zhimeng_message` VALUES ('5', '2', '30', '减肥的季后赛的海景房圣诞节焊接或', '0', '1541473662', '/uploads/img/20181105/eadce6359ecc9dbec7e33f50e07cf320.jpg', '橘橘橘橘子！');
INSERT INTO `zhimeng_message` VALUES ('6', '2', '30', '减肥的季后赛的海景房圣诞节焊接或', '0', '1541473663', '/uploads/img/20181105/eadce6359ecc9dbec7e33f50e07cf320.jpg', '橘橘橘橘子！');
INSERT INTO `zhimeng_message` VALUES ('7', '2', '3', '525555', '2', '1541473952', '/uploads/img/20181105/eadce6359ecc9dbec7e33f50e07cf320.jpg', '橘橘橘橘子！');
INSERT INTO `zhimeng_message` VALUES ('8', '2', '3', '多福多寿发的', '2', '1541473960', '/uploads/img/20181105/eadce6359ecc9dbec7e33f50e07cf320.jpg', '橘橘橘橘子！');

-- ----------------------------
-- Table structure for zhimeng_message_tpl
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_message_tpl`;
CREATE TABLE `zhimeng_message_tpl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(15) DEFAULT NULL,
  `template_alias` varchar(50) DEFAULT NULL,
  `template_code` varchar(50) DEFAULT NULL COMMENT '模板id',
  `code` varchar(10) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `content` text,
  `status` int(1) NOT NULL DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  `param` varchar(200) DEFAULT NULL,
  `is_system` int(1) DEFAULT '0',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='消息模板';

-- ----------------------------
-- Records of zhimeng_message_tpl
-- ----------------------------
INSERT INTO `zhimeng_message_tpl` VALUES ('19', 'sms', 'login', 'SMS_130750188', 'aliyun', '登录确认验证码', '验证码${code}，您正在登录，若非本人操作，请勿泄露。', '1', '1522995585', 'code', '0', '1524675336');
INSERT INTO `zhimeng_message_tpl` VALUES ('20', 'sms', null, 'SMS_148861825', 'aliyun', '用户注册验证码', '验证码为：${code}，您正在注册成为平台会员，感谢您的支持！', '1', '1522995585', 'code', '0', '1522996736');
INSERT INTO `zhimeng_message_tpl` VALUES ('21', 'sms', null, 'SMS_130750185', 'aliyun', '修改密码验证码', '验证码${code}，您正在尝试修改登录密码，请妥善保管账户信息。', '1', '1522995585', 'code', '0', '1522996730');
INSERT INTO `zhimeng_message_tpl` VALUES ('22', 'sms', '', 'SMS_150743030', 'aliyun', '信息变更验证码', '验证码为：${code}，您正在修改手机号码，请妥善保管账户信息。', '1', '1522995585', 'code', '0', '1525589674');
INSERT INTO `zhimeng_message_tpl` VALUES ('25', 'sms', 'login', '297680', 'ucpaas', '忘记密码', '您正在找回密码,验证码:{1},如非本人操作,请忽略此条短信。', '1', '1524646746', '{1}', '0', '1524673498');

-- ----------------------------
-- Table structure for zhimeng_module
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_module`;
CREATE TABLE `zhimeng_module` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `category_status` int(1) DEFAULT '0' COMMENT '判断是否有分类',
  `category_alias` varchar(50) DEFAULT NULL,
  `title` varchar(300) NOT NULL COMMENT '模型名称',
  `table` varchar(200) NOT NULL COMMENT '模型表名',
  `system` int(1) DEFAULT '0' COMMENT '是否系统默认模型',
  `desc` varchar(200) DEFAULT NULL COMMENT '描述',
  `update_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='模型表';

-- ----------------------------
-- Records of zhimeng_module
-- ----------------------------
INSERT INTO `zhimeng_module` VALUES ('1', '0', null, '文章(系统)', 'article', '1', '资讯内容管理系统', '1484370183', '1464152652');
INSERT INTO `zhimeng_module` VALUES ('2', '0', null, '产品(系统)', 'product', '1', '产品信息管理系统', '1484273977', '1464152652');
INSERT INTO `zhimeng_module` VALUES ('3', '0', null, '单页 系统 ', 'webpage', '1', '单页信息介绍管理系统', '1486172365', '1464152652');
INSERT INTO `zhimeng_module` VALUES ('4', '0', null, '全局(系统)', 'setting', '1', '系统全局自定义设置', '1484273939', '1464152652');
INSERT INTO `zhimeng_module` VALUES ('9', '0', '', '投稿通道', 'tougao', '0', '投稿通道', '1542160151', '1542160151');

-- ----------------------------
-- Table structure for zhimeng_module_fields
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_module_fields`;
CREATE TABLE `zhimeng_module_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) NOT NULL,
  `title` varchar(25) NOT NULL COMMENT '字段标题',
  `fields` varchar(25) NOT NULL COMMENT '字段名称，必须英文',
  `fields_type` varchar(25) NOT NULL,
  `fields_value` text,
  `link_table_status` int(1) DEFAULT '0',
  `link_table_name` varchar(50) DEFAULT NULL,
  `link_table_where` varchar(200) DEFAULT NULL,
  `link_table_fields` varchar(50) DEFAULT NULL,
  `link_table_fields_display_name` varchar(50) DEFAULT NULL,
  `deputy_table` varchar(100) DEFAULT NULL,
  `deputy_table_status` int(1) DEFAULT '0' COMMENT '1代表生成副表',
  `sort` int(2) NOT NULL,
  `is_show` int(1) NOT NULL COMMENT '是否在列表显示',
  `list_show` int(1) DEFAULT '0' COMMENT '是否在列表中显示字段',
  `list_width` int(2) DEFAULT NULL,
  `verify` int(11) DEFAULT NULL,
  `verify_type` varchar(100) DEFAULT NULL,
  `info` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=180 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='模型字段表';

-- ----------------------------
-- Records of zhimeng_module_fields
-- ----------------------------
INSERT INTO `zhimeng_module_fields` VALUES ('167', '4', 'setting', '联系电话', 'site_tel', 'text', '', '0', '', '', '', '', '', '0', '1', '1', '0', '10', '0', 'required', '联系电话');
INSERT INTO `zhimeng_module_fields` VALUES ('152', '2', 'product', '缩略图', 'image', 'image', '', '0', '', '', null, null, '', '0', '0', '1', '0', '10', '0', '', '缩略图');
INSERT INTO `zhimeng_module_fields` VALUES ('169', '4', 'setting', '联系地址', 'site_address', 'text', '', '0', '', '', '', '', '', '0', '2', '1', '0', '10', '0', '', '联系地址');
INSERT INTO `zhimeng_module_fields` VALUES ('168', '4', 'setting', '客服代码', 'site_kefu', 'textarea', '', '0', '', '', '', '', '', '0', '5', '1', '0', '10', '0', '', '客服代码');
INSERT INTO `zhimeng_module_fields` VALUES ('171', '2', 'product', '多图展示', 'images', 'multfile', '', '0', '', '', '', '', '', '0', '1', '1', '0', '10', '0', '', '多图展示');
INSERT INTO `zhimeng_module_fields` VALUES ('177', '4', 'setting', 'logo', 'logo', 'image', '', '0', '', '', '', '', '', '0', '1', '1', '0', '10', '0', '', 'logo');
INSERT INTO `zhimeng_module_fields` VALUES ('178', '4', 'setting', '客户电话', 'tel', 'text', '', '0', '', '', '', '', '', '0', '1', '1', '0', '10', '0', '', '客户电话');
INSERT INTO `zhimeng_module_fields` VALUES ('179', '4', 'setting', '咨询QQ', 'qq', 'text', '', '0', '', '', '', '', '', '0', '1', '1', '0', '10', '0', '', '客户电话');

-- ----------------------------
-- Table structure for zhimeng_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_operation_log`;
CREATE TABLE `zhimeng_operation_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '登陆日志ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登陆者ID',
  `controller` varchar(100) DEFAULT NULL,
  `remark` varchar(1000) DEFAULT NULL,
  `action` enum('delete','update','add') DEFAULT NULL COMMENT '登陆时间',
  `action_time` int(11) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=406 DEFAULT CHARSET=utf8 COMMENT='操作日志';

-- ----------------------------
-- Records of zhimeng_operation_log
-- ----------------------------
INSERT INTO `zhimeng_operation_log` VALUES ('1', '2', 'AdPostion', '{\"id\":\"27\",\"name\":\"资讯广告位\",\"alias\":\"article_img\",\"sort\":\"1\",\"dialogid\":\"dialogid0.7130005230738397\",\"update_time\":\"2018-05-04 11:17:11\"}', 'update', '1525403831');
INSERT INTO `zhimeng_operation_log` VALUES ('2', '2', 'RoleNav', '{\"id\":34,\"pid\":7,\"name\":\"会员\",\"status\":1,\"sort\":1,\"class_name\":\"icon-user\",\"image\":null,\"update_time\":\"1970-01-01 08:33:38\",\"create_time\":\"2018-05-03 20:31:52\"}', 'delete', '1525411520');
INSERT INTO `zhimeng_operation_log` VALUES ('3', '2', 'RoleNav', '{\"id\":7,\"pid\":0,\"name\":\"会员中心\",\"status\":1,\"sort\":50,\"class_name\":null,\"image\":\"\",\"update_time\":\"2018-04-13 19:36:21\",\"create_time\":\"2018-04-13 19:36:21\"}', 'delete', '1525411522');
INSERT INTO `zhimeng_operation_log` VALUES ('4', '2', 'RoleNav', '{\"id\":32,\"pid\":31,\"name\":\"商品\",\"status\":1,\"sort\":1,\"class_name\":\"icon-product\",\"image\":\"http:\\/\\/ivears-aliyun-test.oss-cn-shenzhen.aliyuncs.com\\/uploads\\/img\\/20180427\\/8cbfb2e6f51d2e316243ed9e3405cce4.png\",\"update_time\":\"1970-01-01 08:33:38\",\"create_time\":\"2018-04-27 11:18:06\"}', 'delete', '1525411548');
INSERT INTO `zhimeng_operation_log` VALUES ('5', '2', 'RoleNav', '{\"id\":31,\"pid\":0,\"name\":\"商城管理\",\"status\":0,\"sort\":25,\"class_name\":\"\",\"image\":\"\",\"update_time\":\"1970-01-01 08:33:38\",\"create_time\":\"2018-04-27 11:13:02\"}', 'delete', '1525411550');
INSERT INTO `zhimeng_operation_log` VALUES ('6', '2', 'Article', '{\"id\":\"1952\",\"cid\":\"1\",\"title\":\"test11\",\"content\":\"111\",\"sort\":\"1\",\"is_recommend\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.7442005984845752\",\"update_time\":\"2018-05-04 13:38:46\"}', 'update', '1525412326');
INSERT INTO `zhimeng_operation_log` VALUES ('7', '2', 'Product', '{\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.6665984414292445\",\"create_time\":\"2018-05-04 16:36:53\",\"update_time\":\"2018-05-04 16:36:53\",\"id\":\"104\"}', 'add', '1525423013');
INSERT INTO `zhimeng_operation_log` VALUES ('8', '2', 'Product', '{\"s\":\"\\/Admin\\/product\\/categoryedit.html\",\"id\":\"12\",\"pid\":\"0\",\"title\":\"电脑产品\",\"alias\":\"电脑产品\",\"description\":\"电脑产品\",\"image\":\"\",\"sort\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.41557822671921496\",\"update_time\":\"2018-05-04 16:37:12\"}', 'update', '1525423032');
INSERT INTO `zhimeng_operation_log` VALUES ('9', '2', 'Product', '{\"id\":\"104\",\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"11\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.7962538960816645\",\"update_time\":\"2018-05-04 16:37:21\"}', 'update', '1525423041');
INSERT INTO `zhimeng_operation_log` VALUES ('10', '2', 'Product', '{\"id\":\"104\",\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.6852897796636914\",\"update_time\":\"2018-05-04 16:37:26\"}', 'update', '1525423046');
INSERT INTO `zhimeng_operation_log` VALUES ('11', '2', 'Product', '{\"id\":\"104\",\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"1\",\"seo_title\":\"asdf\",\"seo_keywords\":\"asdf\",\"seo_desc\":\"asdf\",\"dialogid\":\"dialogid0.1892871943670782\",\"update_time\":\"2018-05-04 16:37:32\"}', 'update', '1525423052');
INSERT INTO `zhimeng_operation_log` VALUES ('12', '2', 'Product', '{\"id\":\"104\",\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"asdf\",\"seo_keywords\":\"asdf\",\"seo_desc\":\"asdf\",\"dialogid\":\"dialogid0.27026793312801645\",\"update_time\":\"2018-05-04 16:37:36\"}', 'update', '1525423056');
INSERT INTO `zhimeng_operation_log` VALUES ('13', '2', 'Product', '{\"id\":\"104\",\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"1\",\"seo_title\":\"asdf\",\"seo_keywords\":\"asdf\",\"seo_desc\":\"asdf\",\"dialogid\":\"dialogid0.08361530282924257\",\"update_time\":\"2018-05-04 16:37:41\"}', 'update', '1525423061');
INSERT INTO `zhimeng_operation_log` VALUES ('14', '2', 'Product', '{\"id\":\"104\",\"cid\":\"12\",\"title\":\"asf\",\"content\":\"asdf\",\"image\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"1\",\"seo_title\":\"asdf\",\"seo_keywords\":\"asdf\",\"seo_desc\":\"asdf\",\"dialogid\":\"dialogid0.22626642647437545\",\"update_time\":\"2018-05-04 16:40:11\"}', 'update', '1525423211');
INSERT INTO `zhimeng_operation_log` VALUES ('15', '2', 'Fields', '{\"s\":\"\\/Admin\\/fields\\/add.html\",\"module_id\":\"2\",\"mtag\":\"\",\"title\":\"多图展示\",\"fields\":\"images\",\"link_table_status\":\"0\",\"fields_type\":\"multfile\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"多图展示\",\"sort\":\"1\",\"dialogid\":\"dialogid0.634617589407515\",\"table_name\":\"product\",\"update_time\":\"2018-05-04 16:41:04\",\"create_time\":\"2018-05-04 16:41:04\",\"id\":\"171\"}', 'add', '1525423264');
INSERT INTO `zhimeng_operation_log` VALUES ('16', '2', 'Fields', '{\"s\":\"\\/Admin\\/fields\\/edit.html\",\"id\":\"152\",\"module_id\":\"2\",\"mtag\":\"缩略图\",\"title\":\"缩略图\",\"fields\":\"image\",\"link_table_status\":\"0\",\"fields_type\":\"image\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"缩略图\",\"sort\":\"0\",\"dialogid\":\"dialogid0.634617589407515\",\"update_time\":\"2018-05-04 16:41:10\"}', 'update', '1525423270');
INSERT INTO `zhimeng_operation_log` VALUES ('17', '2', 'Product', '{\"id\":\"103\",\"cid\":\"13\",\"title\":\"3434343\",\"content\":\"asdf\",\"image\":\"\",\"encode_fields\":{\"images\":\"images\"},\"sort\":\"1\",\"is_recommend\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.3768925801237366\",\"images\":null,\"update_time\":\"2018-05-04 16:41:54\"}', 'update', '1525423314');
INSERT INTO `zhimeng_operation_log` VALUES ('18', '2', 'WebPage', '{\"id\":\"182\",\"pid\":\"179\",\"title\":\"关于我们\",\"image\":\"\",\"content\":\"关于我们关于我们关于我们关于我们关于我们\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"test11\",\"seo_keywords\":\"test11\",\"seo_desc\":\"test11\",\"dialogid\":\"dialogid0.5831512779602179\",\"update_time\":\"2018-05-04 18:49:33\"}', 'update', '1525430973');
INSERT INTO `zhimeng_operation_log` VALUES ('19', '2', 'WebPage', '{\"id\":\"181\",\"pid\":\"179\",\"title\":\"联系我们\",\"image\":\"\",\"content\":\"联系我们联系我们联系我们\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.811397492926254\",\"update_time\":\"2018-05-04 18:49:37\"}', 'update', '1525430977');
INSERT INTO `zhimeng_operation_log` VALUES ('20', '2', 'WebPage', '{\"id\":\"179\",\"pid\":\"0\",\"title\":\"企业介绍\",\"image\":\"\",\"content\":\"关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.8413584092017916\",\"update_time\":\"2018-05-04 18:49:40\"}', 'update', '1525430980');
INSERT INTO `zhimeng_operation_log` VALUES ('21', '2', 'Article', '{\"id\":\"1952\",\"cid\":\"1\",\"title\":\"test11\",\"content\":\"111\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.24157549242794674\",\"update_time\":\"2018-05-04 18:49:51\"}', 'update', '1525430991');
INSERT INTO `zhimeng_operation_log` VALUES ('22', '2', 'WebPage', '{\"id\":\"181\",\"pid\":\"179\",\"title\":\"联系我们\",\"image\":\"\",\"content\":\"联系我们联系我们联系我们\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.7397557824837806\",\"update_time\":\"2018-05-04 20:52:32\"}', 'update', '1525438352');
INSERT INTO `zhimeng_operation_log` VALUES ('23', '2', 'Product', '{\"id\":\"103\",\"cid\":\"13\",\"title\":\"3434343\",\"content\":\"asdf\",\"image\":\"\",\"encode_fields\":{\"images\":\"images\"},\"sort\":\"1\",\"is_recommend\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.6111913065065715\",\"images\":null,\"update_time\":\"2018-05-04 21:09:15\"}', 'update', '1525439355');
INSERT INTO `zhimeng_operation_log` VALUES ('24', '2', 'Product', '{\"id\":\"103\",\"cid\":\"13\",\"title\":\"3434343\",\"content\":\"asdf\",\"image\":\"\",\"encode_fields\":{\"images\":\"images\"},\"sort\":\"1\",\"is_recommend\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.5862018093555472\",\"images\":null,\"update_time\":\"2018-05-04 21:09:45\"}', 'update', '1525439385');
INSERT INTO `zhimeng_operation_log` VALUES ('25', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"110\\\",\\\"code_height\\\":\\\"50\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525520922,\"update_time\":\"2018-05-05 19:48:42\"}', 'update', '1525520922');
INSERT INTO `zhimeng_operation_log` VALUES ('26', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"100\\\",\\\"code_height\\\":\\\"50\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525520967,\"update_time\":\"2018-05-05 19:49:27\"}', 'update', '1525520967');
INSERT INTO `zhimeng_operation_log` VALUES ('27', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"95\\\",\\\"code_height\\\":\\\"50\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521018,\"update_time\":\"2018-05-05 19:50:18\"}', 'update', '1525521018');
INSERT INTO `zhimeng_operation_log` VALUES ('28', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"100\\\",\\\"code_height\\\":\\\"45\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521030,\"update_time\":\"2018-05-05 19:50:30\"}', 'update', '1525521030');
INSERT INTO `zhimeng_operation_log` VALUES ('29', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"100\\\",\\\"code_height\\\":\\\"50\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521096,\"update_time\":\"2018-05-05 19:51:36\"}', 'update', '1525521096');
INSERT INTO `zhimeng_operation_log` VALUES ('30', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"100\\\",\\\"code_height\\\":\\\"48\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521107,\"update_time\":\"2018-05-05 19:51:47\"}', 'update', '1525521107');
INSERT INTO `zhimeng_operation_log` VALUES ('31', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"100\\\",\\\"code_height\\\":\\\"40\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521116,\"update_time\":\"2018-05-05 19:51:56\"}', 'update', '1525521116');
INSERT INTO `zhimeng_operation_log` VALUES ('32', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"120\\\",\\\"code_height\\\":\\\"40\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521165,\"update_time\":\"2018-05-05 19:52:45\"}', 'update', '1525521165');
INSERT INTO `zhimeng_operation_log` VALUES ('33', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"110\\\",\\\"code_height\\\":\\\"40\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525521175,\"update_time\":\"2018-05-05 19:52:55\"}', 'update', '1525521175');
INSERT INTO `zhimeng_operation_log` VALUES ('34', '2', 'Setting', '{\"c_key\":\"MEMBER_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MEMBER_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"130\\\",\\\"code_height\\\":\\\"35\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525575656,\"update_time\":\"2018-05-06 11:00:56\"}', 'update', '1525575656');
INSERT INTO `zhimeng_operation_log` VALUES ('35', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"120\\\",\\\"code_height\\\":\\\"40\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525575702,\"update_time\":\"2018-05-06 11:01:42\"}', 'update', '1525575702');
INSERT INTO `zhimeng_operation_log` VALUES ('36', '2', 'Setting', '{\"c_key\":\"MEMBER_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MEMBER_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"100\\\",\\\"code_height\\\":\\\"35\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525575710,\"update_time\":\"2018-05-06 11:01:50\"}', 'update', '1525575710');
INSERT INTO `zhimeng_operation_log` VALUES ('37', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"120\\\",\\\"code_height\\\":\\\"35\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525575748,\"update_time\":\"2018-05-06 11:02:28\"}', 'update', '1525575748');
INSERT INTO `zhimeng_operation_log` VALUES ('38', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"110\\\",\\\"code_height\\\":\\\"35\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525575841,\"update_time\":\"2018-05-06 11:04:01\"}', 'update', '1525575841');
INSERT INTO `zhimeng_operation_log` VALUES ('39', '2', 'Setting', '{\"c_key\":\"MANAGE_CODE\",\"c_value\":\"{\\\"s\\\":\\\"\\\\\\/system\\\\\\/setting\\\\\\/code_edit.html\\\",\\\"c_key\\\":\\\"MANAGE_CODE\\\",\\\"code_type\\\":\\\"2\\\",\\\"code_length\\\":\\\"4\\\",\\\"code_width\\\":\\\"105\\\",\\\"code_height\\\":\\\"33\\\",\\\"status\\\":\\\"1\\\"}\",\"c_type\":\"codeset\",\"status\":\"1\",\"c_update_time\":1525575870,\"update_time\":\"2018-05-06 11:04:30\"}', 'update', '1525575870');
INSERT INTO `zhimeng_operation_log` VALUES ('40', '2', 'RoleNode', '{\"nav_id\":\"30\",\"action\":\"index\",\"action_name\":\"站内链接\",\"module\":\"SeoLinks\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"100\",\"dialogid\":\"dialogid0.6339516341853273\",\"create_time\":\"2018-05-10 11:00:57\",\"update_time\":\"2018-05-10 11:00:57\",\"id\":\"688\"}', 'add', '1525921257');
INSERT INTO `zhimeng_operation_log` VALUES ('41', '2', 'RoleNode', '{\"nav_id\":\"30\",\"action\":\"add\",\"action_name\":\"添加站内链接\",\"module\":\"SeoLinks\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.6339516341853273\",\"create_time\":\"2018-05-10 11:01:49\",\"update_time\":\"2018-05-10 11:01:49\",\"id\":\"689\"}', 'add', '1525921309');
INSERT INTO `zhimeng_operation_log` VALUES ('42', '2', 'RoleNode', '{\"nav_id\":\"30\",\"action\":\"edit\",\"action_name\":\"编缉站内链接\",\"module\":\"SeoLinks\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.6339516341853273\",\"create_time\":\"2018-05-10 11:02:09\",\"update_time\":\"2018-05-10 11:02:09\",\"id\":\"690\"}', 'add', '1525921329');
INSERT INTO `zhimeng_operation_log` VALUES ('43', '2', 'RoleNode', '{\"id\":\"667\",\"nav_id\":\"30\",\"action\":\"do\",\"action_name\":\"删除友情链接\",\"module\":\"Links\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.6339516341853273\",\"update_time\":\"2018-05-10 11:02:32\"}', 'update', '1525921352');
INSERT INTO `zhimeng_operation_log` VALUES ('44', '2', 'RoleNode', '{\"id\":\"667\",\"nav_id\":\"30\",\"action\":\"doDelete\",\"action_name\":\"删除友情链接\",\"module\":\"Links\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.6339516341853273\",\"update_time\":\"2018-05-10 11:04:36\"}', 'update', '1525921476');
INSERT INTO `zhimeng_operation_log` VALUES ('45', '2', 'RoleNode', '{\"nav_id\":\"30\",\"action\":\"doDelete\",\"action_name\":\"删除站内链接\",\"module\":\"SeoLinks\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.6339516341853273\",\"create_time\":\"2018-05-10 11:05:10\",\"update_time\":\"2018-05-10 11:05:10\",\"id\":\"691\"}', 'add', '1525921510');
INSERT INTO `zhimeng_operation_log` VALUES ('46', '2', 'SeoLinks', '{\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"status\":\"1\",\"dialogid\":\"dialogid0.3403498390524373\",\"create_time\":\"2018-05-10 11:09:20\",\"update_time\":\"2018-05-10 11:09:20\",\"id\":\"139\"}', 'add', '1525921760');
INSERT INTO `zhimeng_operation_log` VALUES ('47', '2', 'SeoLinks', '{\"title\":\"百度\",\"link\":\"http:\\/\\/www.baidu.com\\/\",\"status\":\"1\",\"dialogid\":\"dialogid0.8828984704501779\",\"create_time\":\"2018-05-10 11:09:35\",\"update_time\":\"2018-05-10 11:09:35\",\"id\":\"140\"}', 'add', '1525921775');
INSERT INTO `zhimeng_operation_log` VALUES ('48', '2', 'SeoLinks', '{\"id\":\"139\",\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"target\":\"1\",\"status\":\"0\",\"dialogid\":\"dialogid0.9934868278166333\",\"update_time\":\"2018-05-10 11:22:50\"}', 'update', '1525922570');
INSERT INTO `zhimeng_operation_log` VALUES ('49', '2', 'SeoLinks', '{\"id\":\"139\",\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"target\":\"0\",\"status\":\"0\",\"dialogid\":\"dialogid0.979563754967538\",\"update_time\":\"2018-05-10 11:22:53\"}', 'update', '1525922573');
INSERT INTO `zhimeng_operation_log` VALUES ('50', '2', 'SeoLinks', '{\"id\":\"139\",\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"target\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.48693579650584207\",\"update_time\":\"2018-05-10 11:22:57\"}', 'update', '1525922577');
INSERT INTO `zhimeng_operation_log` VALUES ('51', '2', 'SeoLinks', '{\"id\":\"139\",\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"target\":\"0\",\"status\":\"1\",\"dialogid\":\"dialogid0.22790125801098027\",\"update_time\":\"2018-05-10 11:26:21\"}', 'update', '1525922781');
INSERT INTO `zhimeng_operation_log` VALUES ('52', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"3\",\"mtag\":\"\",\"title\":\"test11\",\"fields\":\"test11\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"test11\",\"sort\":\"11\",\"dialogid\":\"dialogid0.528913218475684\",\"table_name\":\"web_page\",\"update_time\":\"2018-05-10 11:38:36\",\"create_time\":\"2018-05-10 11:38:36\",\"id\":\"172\"}', 'add', '1525923516');
INSERT INTO `zhimeng_operation_log` VALUES ('53', '2', 'RoleNode', '{\"id\":\"658\",\"nav_id\":\"33\",\"action\":\"index\",\"action_name\":\"单页管理\",\"module\":\"Web_page\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"100\",\"dialogid\":\"dialogid0.19639097626293078\",\"update_time\":\"2018-05-10 11:43:18\"}', 'update', '1525923798');
INSERT INTO `zhimeng_operation_log` VALUES ('54', '2', 'RoleNode', '{\"id\":\"676\",\"nav_id\":\"33\",\"action\":\"do\",\"action_name\":\"删除单页\",\"module\":\"Web_page\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.19639097626293078\",\"update_time\":\"2018-05-10 11:43:30\"}', 'update', '1525923810');
INSERT INTO `zhimeng_operation_log` VALUES ('55', '2', 'RoleNode', '{\"id\":\"674\",\"nav_id\":\"33\",\"action\":\"add\",\"action_name\":\"添加单页\",\"module\":\"Web_page\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"101\",\"dialogid\":\"dialogid0.19639097626293078\",\"update_time\":\"2018-05-10 11:43:35\"}', 'update', '1525923815');
INSERT INTO `zhimeng_operation_log` VALUES ('56', '2', 'RoleNode', '{\"id\":\"675\",\"nav_id\":\"33\",\"action\":\"edit\",\"action_name\":\"编缉单页\",\"module\":\"Web_page\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"103\",\"dialogid\":\"dialogid0.19639097626293078\",\"update_time\":\"2018-05-10 11:43:40\"}', 'update', '1525923820');
INSERT INTO `zhimeng_operation_log` VALUES ('57', '2', 'RoleNode', '{\"id\":\"658\",\"nav_id\":\"33\",\"action\":\"index\",\"action_name\":\"单页管理\",\"module\":\"WebPage\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"100\",\"dialogid\":\"dialogid0.9157762676800452\",\"update_time\":\"2018-05-10 11:50:37\"}', 'update', '1525924237');
INSERT INTO `zhimeng_operation_log` VALUES ('58', '2', 'RoleNode', '{\"id\":\"676\",\"nav_id\":\"33\",\"action\":\"do\",\"action_name\":\"删除单页\",\"module\":\"WebPage\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.9157762676800452\",\"update_time\":\"2018-05-10 11:50:40\"}', 'update', '1525924240');
INSERT INTO `zhimeng_operation_log` VALUES ('59', '2', 'RoleNode', '{\"id\":\"674\",\"nav_id\":\"33\",\"action\":\"add\",\"action_name\":\"添加单页\",\"module\":\"WebPage\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"101\",\"dialogid\":\"dialogid0.9157762676800452\",\"update_time\":\"2018-05-10 11:50:44\"}', 'update', '1525924244');
INSERT INTO `zhimeng_operation_log` VALUES ('60', '2', 'RoleNode', '{\"id\":\"675\",\"nav_id\":\"33\",\"action\":\"edit\",\"action_name\":\"编缉单页\",\"module\":\"WebPage\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"103\",\"dialogid\":\"dialogid0.9157762676800452\",\"update_time\":\"2018-05-10 11:50:48\"}', 'update', '1525924248');
INSERT INTO `zhimeng_operation_log` VALUES ('61', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/edit.html\",\"id\":\"172\",\"module_id\":\"3\",\"mtag\":\"test11\",\"title\":\"test11\",\"fields\":\"test11\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"test11\",\"sort\":\"11\",\"dialogid\":\"dialogid0.4238672982110334\",\"update_time\":\"2018-05-10 11:53:13\"}', 'update', '1525924393');
INSERT INTO `zhimeng_operation_log` VALUES ('62', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/edit.html\",\"id\":\"172\",\"module_id\":\"3\",\"mtag\":\"test11\",\"title\":\"test111\",\"fields\":\"test11\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"test11\",\"sort\":\"11\",\"dialogid\":\"dialogid0.4238672982110334\",\"update_time\":\"2018-05-10 11:53:16\"}', 'update', '1525924396');
INSERT INTO `zhimeng_operation_log` VALUES ('63', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"3\",\"mtag\":\"\",\"title\":\"test22\",\"fields\":\"test22\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"1\",\"verify_type\":\"required\",\"info\":\"asf\",\"sort\":\"1\",\"dialogid\":\"dialogid0.6918271881488893\",\"table_name\":\"webpage\",\"update_time\":\"2018-05-10 11:53:49\",\"create_time\":\"2018-05-10 11:53:49\",\"id\":\"173\"}', 'add', '1525924429');
INSERT INTO `zhimeng_operation_log` VALUES ('64', '2', 'RoleNode', '{\"id\":\"658\",\"nav_id\":\"33\",\"action\":\"index\",\"action_name\":\"单页管理\",\"module\":\"Webpage\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"100\",\"dialogid\":\"dialogid0.09363939262035759\",\"update_time\":\"2018-05-10 11:57:48\"}', 'update', '1525924668');
INSERT INTO `zhimeng_operation_log` VALUES ('65', '2', 'RoleNode', '{\"id\":\"676\",\"nav_id\":\"33\",\"action\":\"do\",\"action_name\":\"删除单页\",\"module\":\"Webpage\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"100\",\"dialogid\":\"dialogid0.09363939262035759\",\"update_time\":\"2018-05-10 11:57:51\"}', 'update', '1525924671');
INSERT INTO `zhimeng_operation_log` VALUES ('66', '2', 'RoleNode', '{\"id\":\"674\",\"nav_id\":\"33\",\"action\":\"add\",\"action_name\":\"添加单页\",\"module\":\"Webpage\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"101\",\"dialogid\":\"dialogid0.09363939262035759\",\"update_time\":\"2018-05-10 11:57:55\"}', 'update', '1525924675');
INSERT INTO `zhimeng_operation_log` VALUES ('67', '2', 'RoleNode', '{\"id\":\"675\",\"nav_id\":\"33\",\"action\":\"edit\",\"action_name\":\"编缉单页\",\"module\":\"Webpage\",\"status\":\"1\",\"is_show\":\"0\",\"sort\":\"103\",\"dialogid\":\"dialogid0.09363939262035759\",\"update_time\":\"2018-05-10 11:57:59\"}', 'update', '1525924679');
INSERT INTO `zhimeng_operation_log` VALUES ('68', '2', 'Webpage', '{\"id\":\"179\",\"pid\":\"0\",\"title\":\"企业介绍\",\"image\":\"\",\"content\":\"关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们\",\"test22\":\"df\",\"test11\":\"\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.2547737583618508\",\"update_time\":\"2018-05-10 11:59:10\"}', 'update', '1525924750');
INSERT INTO `zhimeng_operation_log` VALUES ('69', '2', 'Webpage', '{\"id\":\"181\",\"pid\":\"179\",\"title\":\"联系我们1\",\"image\":\"\",\"content\":\"联系我们联系我们联系我们\",\"test22\":\"1\",\"test11\":\"\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.2918500289939301\",\"update_time\":\"2018-05-10 11:59:16\"}', 'update', '1525924756');
INSERT INTO `zhimeng_operation_log` VALUES ('70', '2', 'Webpage', '{\"id\":\"181\",\"pid\":\"179\",\"title\":\"联系我们\",\"image\":\"\",\"content\":\"联系我们联系我们联系我们\",\"test22\":\"1\",\"test11\":\"\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.04090547735985606\",\"update_time\":\"2018-05-10 11:59:22\"}', 'update', '1525924762');
INSERT INTO `zhimeng_operation_log` VALUES ('71', '2', 'Webpage', '{\"id\":\"182\",\"pid\":\"179\",\"title\":\"关于我们\",\"image\":\"\",\"content\":\"关于我们关于我们关于我们关于我们关于我们\",\"test22\":\"dsfasdf\",\"test11\":\"\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"test11\",\"seo_keywords\":\"test11\",\"seo_desc\":\"test11\",\"dialogid\":\"dialogid0.7236341202757857\",\"update_time\":\"2018-05-10 11:59:27\"}', 'update', '1525924767');
INSERT INTO `zhimeng_operation_log` VALUES ('72', '2', 'System', '{\"u_name\":\"test11\",\"u_username\":\"test11\",\"u_password\":\"test11\",\"role_id\":\"65\",\"u_phone\":\"\",\"u_qq\":\"\",\"u_email\":\"\",\"status\":\"1\",\"dialogid\":\"dialogid0.2814968061608474\",\"u_passwd\":\"f696282aa4cd4f614aa995190cf442fe\",\"create_time\":\"2018-05-10 12:03:33\",\"update_time\":\"2018-05-10 12:03:33\",\"u_id\":\"24\"}', 'add', '1525925013');
INSERT INTO `zhimeng_operation_log` VALUES ('73', '2', 'Role', '{\"s\":\"\\/system\\/role\\/edit.html\",\"id\":\"65\",\"oldname\":\"普通管理员\",\"access_node\":[\"4\",\"16\",\"630\",\"5\",\"29\",\"638\",\"637\",\"659\",\"660\",\"661\",\"662\",\"663\",\"664\",\"30\",\"642\",\"665\",\"666\",\"667\",\"688\",\"2\",\"11\",\"577\",\"641\"],\"name\":\"普通管理员\",\"dialogid\":\"dialogid0.2843331591932625\",\"update_time\":\"2018-05-10 12:03:45\"}', 'update', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('74', '2', 'Role', '{\"id\":671,\"role_id\":65,\"node_id\":650}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('75', '2', 'Role', '{\"id\":670,\"role_id\":65,\"node_id\":646}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('76', '2', 'Role', '{\"id\":669,\"role_id\":65,\"node_id\":32}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('77', '2', 'Role', '{\"id\":668,\"role_id\":65,\"node_id\":31}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('78', '2', 'Role', '{\"id\":667,\"role_id\":65,\"node_id\":667}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('79', '2', 'Role', '{\"id\":666,\"role_id\":65,\"node_id\":666}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('80', '2', 'Role', '{\"id\":665,\"role_id\":65,\"node_id\":665}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('81', '2', 'Role', '{\"id\":664,\"role_id\":65,\"node_id\":642}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('82', '2', 'Role', '{\"id\":663,\"role_id\":65,\"node_id\":30}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('83', '2', 'Role', '{\"id\":662,\"role_id\":65,\"node_id\":664}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('84', '2', 'Role', '{\"id\":661,\"role_id\":65,\"node_id\":663}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('85', '2', 'Role', '{\"id\":660,\"role_id\":65,\"node_id\":662}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('86', '2', 'Role', '{\"id\":659,\"role_id\":65,\"node_id\":661}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('87', '2', 'Role', '{\"id\":658,\"role_id\":65,\"node_id\":660}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('88', '2', 'Role', '{\"id\":657,\"role_id\":65,\"node_id\":659}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('89', '2', 'Role', '{\"id\":656,\"role_id\":65,\"node_id\":637}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('90', '2', 'Role', '{\"id\":655,\"role_id\":65,\"node_id\":638}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('91', '2', 'Role', '{\"id\":654,\"role_id\":65,\"node_id\":29}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('92', '2', 'Role', '{\"id\":653,\"role_id\":65,\"node_id\":5}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('93', '2', 'Role', '{\"id\":652,\"role_id\":65,\"node_id\":630}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('94', '2', 'Role', '{\"id\":651,\"role_id\":65,\"node_id\":16}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('95', '2', 'Role', '{\"id\":650,\"role_id\":65,\"node_id\":4}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('96', '2', 'Role', '{\"id\":672,\"role_id\":65,\"node_id\":647}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('97', '2', 'Role', '{\"id\":673,\"role_id\":65,\"node_id\":648}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('98', '2', 'Role', '{\"id\":674,\"role_id\":65,\"node_id\":649}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('99', '2', 'Role', '{\"id\":675,\"role_id\":65,\"node_id\":654}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('100', '2', 'Role', '{\"id\":676,\"role_id\":65,\"node_id\":655}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('101', '2', 'Role', '{\"id\":677,\"role_id\":65,\"node_id\":2}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('102', '2', 'Role', '{\"id\":678,\"role_id\":65,\"node_id\":11}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('103', '2', 'Role', '{\"id\":679,\"role_id\":65,\"node_id\":577}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('104', '2', 'Role', '{\"id\":680,\"role_id\":65,\"node_id\":641}', 'delete', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('105', '2', 'Role', '{\"role_id\":65,\"node_id\":\"4\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"681\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('106', '2', 'Role', '{\"role_id\":65,\"node_id\":\"16\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"682\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('107', '2', 'Role', '{\"role_id\":65,\"node_id\":\"630\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"683\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('108', '2', 'Role', '{\"role_id\":65,\"node_id\":\"5\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"684\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('109', '2', 'Role', '{\"role_id\":65,\"node_id\":\"29\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"685\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('110', '2', 'Role', '{\"role_id\":65,\"node_id\":\"638\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"686\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('111', '2', 'Role', '{\"role_id\":65,\"node_id\":\"637\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"687\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('112', '2', 'Role', '{\"role_id\":65,\"node_id\":\"659\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"688\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('113', '2', 'Role', '{\"role_id\":65,\"node_id\":\"660\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"689\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('114', '2', 'Role', '{\"role_id\":65,\"node_id\":\"661\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"690\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('115', '2', 'Role', '{\"role_id\":65,\"node_id\":\"662\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"691\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('116', '2', 'Role', '{\"role_id\":65,\"node_id\":\"663\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"692\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('117', '2', 'Role', '{\"role_id\":65,\"node_id\":\"664\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"693\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('118', '2', 'Role', '{\"role_id\":65,\"node_id\":\"30\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"694\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('119', '2', 'Role', '{\"role_id\":65,\"node_id\":\"642\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"695\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('120', '2', 'Role', '{\"role_id\":65,\"node_id\":\"665\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"696\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('121', '2', 'Role', '{\"role_id\":65,\"node_id\":\"666\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"697\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('122', '2', 'Role', '{\"role_id\":65,\"node_id\":\"667\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"698\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('123', '2', 'Role', '{\"role_id\":65,\"node_id\":\"688\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"699\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('124', '2', 'Role', '{\"role_id\":65,\"node_id\":\"2\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"700\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('125', '2', 'Role', '{\"role_id\":65,\"node_id\":\"11\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"701\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('126', '2', 'Role', '{\"role_id\":65,\"node_id\":\"577\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"702\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('127', '2', 'Role', '{\"role_id\":65,\"node_id\":\"641\",\"create_time\":\"2018-05-10 12:03:45\",\"update_time\":\"2018-05-10 12:03:45\",\"id\":\"703\"}', 'add', '1525925025');
INSERT INTO `zhimeng_operation_log` VALUES ('128', '2', 'Role', '{\"s\":\"\\/system\\/role\\/edit.html\",\"id\":\"65\",\"oldname\":\"普通管理员\",\"access_node\":[\"4\",\"16\",\"630\",\"5\",\"29\",\"638\",\"637\",\"659\",\"660\",\"661\",\"662\",\"663\",\"664\",\"30\",\"642\",\"665\",\"666\",\"667\",\"688\",\"690\",\"2\",\"11\",\"577\",\"641\"],\"name\":\"普通管理员\",\"dialogid\":\"dialogid0.1951001998627271\",\"update_time\":\"2018-05-10 12:04:38\"}', 'update', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('129', '2', 'Role', '{\"id\":703,\"role_id\":65,\"node_id\":641}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('130', '2', 'Role', '{\"id\":702,\"role_id\":65,\"node_id\":577}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('131', '2', 'Role', '{\"id\":701,\"role_id\":65,\"node_id\":11}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('132', '2', 'Role', '{\"id\":700,\"role_id\":65,\"node_id\":2}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('133', '2', 'Role', '{\"id\":699,\"role_id\":65,\"node_id\":688}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('134', '2', 'Role', '{\"id\":698,\"role_id\":65,\"node_id\":667}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('135', '2', 'Role', '{\"id\":697,\"role_id\":65,\"node_id\":666}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('136', '2', 'Role', '{\"id\":696,\"role_id\":65,\"node_id\":665}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('137', '2', 'Role', '{\"id\":695,\"role_id\":65,\"node_id\":642}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('138', '2', 'Role', '{\"id\":694,\"role_id\":65,\"node_id\":30}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('139', '2', 'Role', '{\"id\":693,\"role_id\":65,\"node_id\":664}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('140', '2', 'Role', '{\"id\":692,\"role_id\":65,\"node_id\":663}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('141', '2', 'Role', '{\"id\":691,\"role_id\":65,\"node_id\":662}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('142', '2', 'Role', '{\"id\":690,\"role_id\":65,\"node_id\":661}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('143', '2', 'Role', '{\"id\":689,\"role_id\":65,\"node_id\":660}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('144', '2', 'Role', '{\"id\":688,\"role_id\":65,\"node_id\":659}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('145', '2', 'Role', '{\"id\":687,\"role_id\":65,\"node_id\":637}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('146', '2', 'Role', '{\"id\":686,\"role_id\":65,\"node_id\":638}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('147', '2', 'Role', '{\"id\":685,\"role_id\":65,\"node_id\":29}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('148', '2', 'Role', '{\"id\":684,\"role_id\":65,\"node_id\":5}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('149', '2', 'Role', '{\"id\":683,\"role_id\":65,\"node_id\":630}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('150', '2', 'Role', '{\"id\":682,\"role_id\":65,\"node_id\":16}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('151', '2', 'Role', '{\"id\":681,\"role_id\":65,\"node_id\":4}', 'delete', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('152', '2', 'Role', '{\"role_id\":65,\"node_id\":\"4\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"704\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('153', '2', 'Role', '{\"role_id\":65,\"node_id\":\"16\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"705\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('154', '2', 'Role', '{\"role_id\":65,\"node_id\":\"630\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"706\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('155', '2', 'Role', '{\"role_id\":65,\"node_id\":\"5\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"707\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('156', '2', 'Role', '{\"role_id\":65,\"node_id\":\"29\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"708\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('157', '2', 'Role', '{\"role_id\":65,\"node_id\":\"638\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"709\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('158', '2', 'Role', '{\"role_id\":65,\"node_id\":\"637\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"710\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('159', '2', 'Role', '{\"role_id\":65,\"node_id\":\"659\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"711\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('160', '2', 'Role', '{\"role_id\":65,\"node_id\":\"660\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"712\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('161', '2', 'Role', '{\"role_id\":65,\"node_id\":\"661\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"713\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('162', '2', 'Role', '{\"role_id\":65,\"node_id\":\"662\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"714\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('163', '2', 'Role', '{\"role_id\":65,\"node_id\":\"663\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"715\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('164', '2', 'Role', '{\"role_id\":65,\"node_id\":\"664\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"716\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('165', '2', 'Role', '{\"role_id\":65,\"node_id\":\"30\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"717\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('166', '2', 'Role', '{\"role_id\":65,\"node_id\":\"642\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"718\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('167', '2', 'Role', '{\"role_id\":65,\"node_id\":\"665\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"719\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('168', '2', 'Role', '{\"role_id\":65,\"node_id\":\"666\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"720\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('169', '2', 'Role', '{\"role_id\":65,\"node_id\":\"667\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"721\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('170', '2', 'Role', '{\"role_id\":65,\"node_id\":\"688\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"722\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('171', '2', 'Role', '{\"role_id\":65,\"node_id\":\"690\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"723\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('172', '2', 'Role', '{\"role_id\":65,\"node_id\":\"2\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"724\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('173', '2', 'Role', '{\"role_id\":65,\"node_id\":\"11\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"725\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('174', '2', 'Role', '{\"role_id\":65,\"node_id\":\"577\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"726\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('175', '2', 'Role', '{\"role_id\":65,\"node_id\":\"641\",\"create_time\":\"2018-05-10 12:04:38\",\"update_time\":\"2018-05-10 12:04:38\",\"id\":\"727\"}', 'add', '1525925078');
INSERT INTO `zhimeng_operation_log` VALUES ('176', '24', 'SeoLinks', '{\"id\":\"139\",\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"target\":\"0\",\"status\":\"1\",\"dialogid\":\"dialogid0.70309805689781\",\"update_time\":\"2018-05-10 12:04:43\"}', 'update', '1525925083');
INSERT INTO `zhimeng_operation_log` VALUES ('177', '24', 'SeoLinks', '{\"id\":\"139\",\"title\":\"艾威尔\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"target\":\"0\",\"status\":\"0\",\"dialogid\":\"dialogid0.911940894296386\",\"update_time\":\"2018-05-10 12:04:47\"}', 'update', '1525925087');
INSERT INTO `zhimeng_operation_log` VALUES ('178', '24', 'SeoLinks', '{\"id\":\"140\",\"title\":\"百度\",\"link\":\"http:\\/\\/www.baidu.com\\/\",\"target\":\"0\",\"status\":\"1\",\"dialogid\":\"dialogid0.4882678126943856\",\"update_time\":\"2018-05-10 12:04:50\"}', 'update', '1525925090');
INSERT INTO `zhimeng_operation_log` VALUES ('179', '2', 'Role', '{\"s\":\"\\/system\\/role\\/edit.html\",\"id\":\"65\",\"oldname\":\"普通管理员\",\"access_node\":[\"4\",\"16\",\"630\",\"5\",\"29\",\"638\",\"637\",\"659\",\"660\",\"661\",\"662\",\"663\",\"664\",\"2\",\"11\",\"577\",\"641\"],\"name\":\"普通管理员\",\"dialogid\":\"dialogid0.5387434223038088\",\"update_time\":\"2018-05-10 12:05:20\"}', 'update', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('180', '2', 'Role', '{\"id\":727,\"role_id\":65,\"node_id\":641}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('181', '2', 'Role', '{\"id\":726,\"role_id\":65,\"node_id\":577}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('182', '2', 'Role', '{\"id\":725,\"role_id\":65,\"node_id\":11}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('183', '2', 'Role', '{\"id\":724,\"role_id\":65,\"node_id\":2}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('184', '2', 'Role', '{\"id\":723,\"role_id\":65,\"node_id\":690}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('185', '2', 'Role', '{\"id\":722,\"role_id\":65,\"node_id\":688}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('186', '2', 'Role', '{\"id\":721,\"role_id\":65,\"node_id\":667}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('187', '2', 'Role', '{\"id\":720,\"role_id\":65,\"node_id\":666}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('188', '2', 'Role', '{\"id\":719,\"role_id\":65,\"node_id\":665}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('189', '2', 'Role', '{\"id\":718,\"role_id\":65,\"node_id\":642}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('190', '2', 'Role', '{\"id\":717,\"role_id\":65,\"node_id\":30}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('191', '2', 'Role', '{\"id\":716,\"role_id\":65,\"node_id\":664}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('192', '2', 'Role', '{\"id\":715,\"role_id\":65,\"node_id\":663}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('193', '2', 'Role', '{\"id\":714,\"role_id\":65,\"node_id\":662}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('194', '2', 'Role', '{\"id\":713,\"role_id\":65,\"node_id\":661}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('195', '2', 'Role', '{\"id\":712,\"role_id\":65,\"node_id\":660}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('196', '2', 'Role', '{\"id\":711,\"role_id\":65,\"node_id\":659}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('197', '2', 'Role', '{\"id\":710,\"role_id\":65,\"node_id\":637}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('198', '2', 'Role', '{\"id\":709,\"role_id\":65,\"node_id\":638}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('199', '2', 'Role', '{\"id\":708,\"role_id\":65,\"node_id\":29}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('200', '2', 'Role', '{\"id\":707,\"role_id\":65,\"node_id\":5}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('201', '2', 'Role', '{\"id\":706,\"role_id\":65,\"node_id\":630}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('202', '2', 'Role', '{\"id\":705,\"role_id\":65,\"node_id\":16}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('203', '2', 'Role', '{\"id\":704,\"role_id\":65,\"node_id\":4}', 'delete', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('204', '2', 'Role', '{\"role_id\":65,\"node_id\":\"4\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"728\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('205', '2', 'Role', '{\"role_id\":65,\"node_id\":\"16\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"729\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('206', '2', 'Role', '{\"role_id\":65,\"node_id\":\"630\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"730\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('207', '2', 'Role', '{\"role_id\":65,\"node_id\":\"5\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"731\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('208', '2', 'Role', '{\"role_id\":65,\"node_id\":\"29\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"732\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('209', '2', 'Role', '{\"role_id\":65,\"node_id\":\"638\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"733\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('210', '2', 'Role', '{\"role_id\":65,\"node_id\":\"637\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"734\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('211', '2', 'Role', '{\"role_id\":65,\"node_id\":\"659\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"735\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('212', '2', 'Role', '{\"role_id\":65,\"node_id\":\"660\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"736\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('213', '2', 'Role', '{\"role_id\":65,\"node_id\":\"661\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"737\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('214', '2', 'Role', '{\"role_id\":65,\"node_id\":\"662\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"738\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('215', '2', 'Role', '{\"role_id\":65,\"node_id\":\"663\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"739\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('216', '2', 'Role', '{\"role_id\":65,\"node_id\":\"664\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"740\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('217', '2', 'Role', '{\"role_id\":65,\"node_id\":\"2\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"741\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('218', '2', 'Role', '{\"role_id\":65,\"node_id\":\"11\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"742\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('219', '2', 'Role', '{\"role_id\":65,\"node_id\":\"577\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"743\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('220', '2', 'Role', '{\"role_id\":65,\"node_id\":\"641\",\"create_time\":\"2018-05-10 12:05:20\",\"update_time\":\"2018-05-10 12:05:20\",\"id\":\"744\"}', 'add', '1525925120');
INSERT INTO `zhimeng_operation_log` VALUES ('221', '2', 'Role', '{\"s\":\"\\/system\\/role\\/edit.html\",\"id\":\"65\",\"oldname\":\"普通管理员\",\"access_node\":[\"4\",\"16\",\"630\",\"5\",\"29\",\"638\",\"637\",\"659\",\"660\",\"661\",\"662\",\"663\",\"664\",\"30\",\"642\",\"665\",\"666\",\"667\",\"688\",\"689\",\"690\",\"691\",\"2\",\"11\",\"577\",\"641\"],\"name\":\"普通管理员\",\"dialogid\":\"dialogid0.8444678186881773\",\"update_time\":\"2018-05-10 12:05:37\"}', 'update', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('222', '2', 'Role', '{\"id\":744,\"role_id\":65,\"node_id\":641}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('223', '2', 'Role', '{\"id\":743,\"role_id\":65,\"node_id\":577}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('224', '2', 'Role', '{\"id\":742,\"role_id\":65,\"node_id\":11}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('225', '2', 'Role', '{\"id\":741,\"role_id\":65,\"node_id\":2}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('226', '2', 'Role', '{\"id\":740,\"role_id\":65,\"node_id\":664}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('227', '2', 'Role', '{\"id\":739,\"role_id\":65,\"node_id\":663}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('228', '2', 'Role', '{\"id\":738,\"role_id\":65,\"node_id\":662}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('229', '2', 'Role', '{\"id\":737,\"role_id\":65,\"node_id\":661}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('230', '2', 'Role', '{\"id\":736,\"role_id\":65,\"node_id\":660}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('231', '2', 'Role', '{\"id\":735,\"role_id\":65,\"node_id\":659}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('232', '2', 'Role', '{\"id\":734,\"role_id\":65,\"node_id\":637}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('233', '2', 'Role', '{\"id\":733,\"role_id\":65,\"node_id\":638}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('234', '2', 'Role', '{\"id\":732,\"role_id\":65,\"node_id\":29}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('235', '2', 'Role', '{\"id\":731,\"role_id\":65,\"node_id\":5}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('236', '2', 'Role', '{\"id\":730,\"role_id\":65,\"node_id\":630}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('237', '2', 'Role', '{\"id\":729,\"role_id\":65,\"node_id\":16}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('238', '2', 'Role', '{\"id\":728,\"role_id\":65,\"node_id\":4}', 'delete', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('239', '2', 'Role', '{\"role_id\":65,\"node_id\":\"4\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"745\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('240', '2', 'Role', '{\"role_id\":65,\"node_id\":\"16\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"746\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('241', '2', 'Role', '{\"role_id\":65,\"node_id\":\"630\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"747\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('242', '2', 'Role', '{\"role_id\":65,\"node_id\":\"5\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"748\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('243', '2', 'Role', '{\"role_id\":65,\"node_id\":\"29\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"749\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('244', '2', 'Role', '{\"role_id\":65,\"node_id\":\"638\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"750\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('245', '2', 'Role', '{\"role_id\":65,\"node_id\":\"637\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"751\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('246', '2', 'Role', '{\"role_id\":65,\"node_id\":\"659\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"752\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('247', '2', 'Role', '{\"role_id\":65,\"node_id\":\"660\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"753\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('248', '2', 'Role', '{\"role_id\":65,\"node_id\":\"661\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"754\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('249', '2', 'Role', '{\"role_id\":65,\"node_id\":\"662\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"755\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('250', '2', 'Role', '{\"role_id\":65,\"node_id\":\"663\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"756\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('251', '2', 'Role', '{\"role_id\":65,\"node_id\":\"664\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"757\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('252', '2', 'Role', '{\"role_id\":65,\"node_id\":\"30\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"758\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('253', '2', 'Role', '{\"role_id\":65,\"node_id\":\"642\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"759\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('254', '2', 'Role', '{\"role_id\":65,\"node_id\":\"665\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"760\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('255', '2', 'Role', '{\"role_id\":65,\"node_id\":\"666\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"761\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('256', '2', 'Role', '{\"role_id\":65,\"node_id\":\"667\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"762\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('257', '2', 'Role', '{\"role_id\":65,\"node_id\":\"688\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"763\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('258', '2', 'Role', '{\"role_id\":65,\"node_id\":\"689\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"764\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('259', '2', 'Role', '{\"role_id\":65,\"node_id\":\"690\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"765\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('260', '2', 'Role', '{\"role_id\":65,\"node_id\":\"691\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"766\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('261', '2', 'Role', '{\"role_id\":65,\"node_id\":\"2\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"767\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('262', '2', 'Role', '{\"role_id\":65,\"node_id\":\"11\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"768\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('263', '2', 'Role', '{\"role_id\":65,\"node_id\":\"577\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"769\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('264', '2', 'Role', '{\"role_id\":65,\"node_id\":\"641\",\"create_time\":\"2018-05-10 12:05:37\",\"update_time\":\"2018-05-10 12:05:37\",\"id\":\"770\"}', 'add', '1525925137');
INSERT INTO `zhimeng_operation_log` VALUES ('265', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"3\",\"mtag\":\"\",\"title\":\"test11\",\"fields\":\"test11\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"11\",\"sort\":\"1\",\"dialogid\":\"dialogid0.060931234894068265\",\"table_name\":\"webpage\",\"update_time\":\"2018-05-10 16:37:16\",\"create_time\":\"2018-05-10 16:37:16\",\"id\":\"174\"}', 'add', '1525941437');
INSERT INTO `zhimeng_operation_log` VALUES ('266', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/edit.html\",\"id\":\"174\",\"module_id\":\"3\",\"mtag\":\"test11\",\"title\":\"test11\",\"fields\":\"test11\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"11\",\"sort\":\"1\",\"dialogid\":\"dialogid0.060931234894068265\",\"update_time\":\"2018-05-10 16:37:21\"}', 'update', '1525941441');
INSERT INTO `zhimeng_operation_log` VALUES ('267', '2', 'Setting', '{\"c_key\":\"STATIC_CACHE\",\"c_value\":\"{\\\"CACHE_ON\\\":\\\"0\\\",\\\"CACHE_RULES\\\":{\\\"*\\\":[\\\"{$_SERVER.REQUEST_URI|md5}\\\"]},\\\"CACHE_TIME\\\":\\\"10\\\",\\\"CACHE_NO_GROUP\\\":[\\\"admin\\\",\\\"member\\\"],\\\"CACHE_NO_MODULE\\\":[\\\"\\\\\\/home\\\\\\/login\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/weixin\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/product\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/ajax\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/oauth\\\\\\/\\\"],\\\"CACHE_NO_ACTION\\\":[\\\"\\\\\\/home\\\\\\/download\\\\\\/downloadfile\\\",\\\"\\\\\\/home\\\\\\/download\\\\\\/index\\\"]}\",\"c_value_desc\":\"静态缓存配置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1525941708,\"update_time\":\"2018-05-10 16:41:48\"}', 'update', '1525941708');
INSERT INTO `zhimeng_operation_log` VALUES ('268', '2', 'Setting', '{\"c_key\":\"STATIC_CACHE\",\"c_value\":\"{\\\"CACHE_ON\\\":\\\"0\\\",\\\"CACHE_RULES\\\":{\\\"*\\\":[\\\"{$_SERVER.REQUEST_URI|md5}\\\"]},\\\"CACHE_TIME\\\":\\\"10\\\",\\\"CACHE_NO_GROUP\\\":[\\\"admin\\\",\\\"member\\\"],\\\"CACHE_NO_MODULE\\\":[\\\"\\\\\\/home\\\\\\/login\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/weixin\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/product\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/ajax\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/oauth\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/api\\\\\\/\\\"],\\\"CACHE_NO_ACTION\\\":[\\\"\\\\\\/home\\\\\\/download\\\\\\/downloadfile\\\",\\\"\\\\\\/home\\\\\\/download\\\\\\/index\\\"]}\",\"c_value_desc\":\"静态缓存配置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1525941733,\"update_time\":\"2018-05-10 16:42:13\"}', 'update', '1525941733');
INSERT INTO `zhimeng_operation_log` VALUES ('269', '2', 'Setting', '{\"c_key\":\"STATIC_CACHE\",\"c_value\":\"{\\\"CACHE_ON\\\":\\\"1\\\",\\\"CACHE_RULES\\\":{\\\"*\\\":[\\\"{$_SERVER.REQUEST_URI|md5}\\\"]},\\\"CACHE_TIME\\\":\\\"10\\\",\\\"CACHE_NO_GROUP\\\":[\\\"admin\\\",\\\"member\\\"],\\\"CACHE_NO_MODULE\\\":[\\\"\\\\\\/home\\\\\\/login\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/weixin\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/product\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/ajax\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/oauth\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/api\\\\\\/\\\"],\\\"CACHE_NO_ACTION\\\":[\\\"\\\\\\/home\\\\\\/download\\\\\\/downloadfile\\\",\\\"\\\\\\/home\\\\\\/download\\\\\\/index\\\"]}\",\"c_value_desc\":\"静态缓存配置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1525941752,\"update_time\":\"2018-05-10 16:42:32\"}', 'update', '1525941752');
INSERT INTO `zhimeng_operation_log` VALUES ('270', '2', 'Setting', '{\"c_key\":\"STATIC_CACHE\",\"c_value\":\"{\\\"CACHE_ON\\\":\\\"1\\\",\\\"CACHE_RULES\\\":{\\\"*\\\":[\\\"{$_SERVER.REQUEST_URI|md5}\\\"]},\\\"CACHE_TIME\\\":\\\"200\\\",\\\"CACHE_NO_GROUP\\\":[\\\"admin\\\",\\\"member\\\"],\\\"CACHE_NO_MODULE\\\":[\\\"\\\\\\/home\\\\\\/login\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/weixin\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/product\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/ajax\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/oauth\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/api\\\\\\/\\\"],\\\"CACHE_NO_ACTION\\\":[\\\"\\\\\\/home\\\\\\/download\\\\\\/downloadfile\\\",\\\"\\\\\\/home\\\\\\/download\\\\\\/index\\\"]}\",\"c_value_desc\":\"静态缓存配置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1525941757,\"update_time\":\"2018-05-10 16:42:37\"}', 'update', '1525941757');
INSERT INTO `zhimeng_operation_log` VALUES ('271', '2', 'SeoLinks', '{\"id\":\"140\",\"title\":\"百度\",\"link\":\"http:\\/\\/www.baidu.com\\/\",\"target\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.2738651058620012\",\"update_time\":\"2018-05-10 17:14:22\"}', 'update', '1525943662');
INSERT INTO `zhimeng_operation_log` VALUES ('272', '2', 'Setting', '{\"c_key\":\"STATIC_CACHE\",\"c_value\":\"{\\\"CACHE_ON\\\":\\\"1\\\",\\\"CACHE_RULES\\\":{\\\"*\\\":[\\\"{$_SERVER.REQUEST_URI|md5}\\\"]},\\\"CACHE_TIME\\\":\\\"3600\\\",\\\"CACHE_NO_GROUP\\\":[\\\"admin\\\",\\\"member\\\"],\\\"CACHE_NO_MODULE\\\":[\\\"\\\\\\/home\\\\\\/login\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/weixin\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/product\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/ajax\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/oauth\\\\\\/\\\",\\\"\\\\\\/home\\\\\\/api\\\\\\/\\\"],\\\"CACHE_NO_ACTION\\\":[\\\"\\\\\\/home\\\\\\/download\\\\\\/downloadfile\\\",\\\"\\\\\\/home\\\\\\/download\\\\\\/index\\\"]}\",\"c_value_desc\":\"静态缓存配置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1525943694,\"update_time\":\"2018-05-10 17:14:54\"}', 'update', '1525943694');
INSERT INTO `zhimeng_operation_log` VALUES ('273', '2', 'Collection', '{\"status\":0,\"update_time\":\"2018-05-14 00:32:14\"}', 'update', '1526229134');
INSERT INTO `zhimeng_operation_log` VALUES ('274', '2', 'Collection', '{\"status\":1,\"update_time\":\"2018-05-14 00:32:16\"}', 'update', '1526229136');
INSERT INTO `zhimeng_operation_log` VALUES ('275', '2', 'Collection', '{\"id\":22,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"2017-06-29 00:15:11\",\"update', 'add', '1526229956');
INSERT INTO `zhimeng_operation_log` VALUES ('276', '2', 'Collection', '{\"id\":23,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"2017-06-29 00:15:11\",\"update', 'add', '1526230000');
INSERT INTO `zhimeng_operation_log` VALUES ('277', '2', 'Collection', '{\"id\":24,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"1970-01-01 08:00:00\",\"update', 'add', '1526230005');
INSERT INTO `zhimeng_operation_log` VALUES ('278', '2', 'Collection', '{\"id\":25,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"1970-01-01 08:00:00\",\"update', 'add', '1526230115');
INSERT INTO `zhimeng_operation_log` VALUES ('279', '2', 'Collection', '{\"id\":26,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"1970-01-01 08:00:00\",\"update', 'add', '1526230117');
INSERT INTO `zhimeng_operation_log` VALUES ('280', '2', 'Collection', '{\"id\":27,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"1970-01-01 08:00:00\",\"update', 'add', '1526230119');
INSERT INTO `zhimeng_operation_log` VALUES ('281', '2', 'Collection', '{\"status\":0,\"update_time\":\"2018-05-14 00:51:08\"}', 'update', '1526230268');
INSERT INTO `zhimeng_operation_log` VALUES ('282', '2', 'Collection', '{\"status\":1,\"update_time\":\"2018-05-14 00:51:10\"}', 'update', '1526230270');
INSERT INTO `zhimeng_operation_log` VALUES ('283', '2', 'Collection', '{\"id\":22,\"model\":\"article\",\"category_id\":362,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":21,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":0,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"create_time\":\"1970-01-01 08:33:37\",\"update', 'add', '1526230366');
INSERT INTO `zhimeng_operation_log` VALUES ('284', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"21\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526230808');
INSERT INTO `zhimeng_operation_log` VALUES ('285', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"21\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526230818');
INSERT INTO `zhimeng_operation_log` VALUES ('286', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"21\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"remove_keyword\":\"<h1>(.*?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526264259');
INSERT INTO `zhimeng_operation_log` VALUES ('287', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"21\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"is_remove_div\":\"1\",\"replace_keyword\":\"1ppt.com|ttddcc.cn\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526266095');
INSERT INTO `zhimeng_operation_log` VALUES ('288', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"21\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"is_remove_div\":\"1\",\"replace_keyword\":\"\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526268349');
INSERT INTO `zhimeng_operation_log` VALUES ('289', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"10\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"is_remove_div\":\"1\",\"replace_keyword\":\"\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526269926');
INSERT INTO `zhimeng_operation_log` VALUES ('290', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"10\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_get_content_small_image\":\"1\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"is_remove_div\":\"1\",\"replace_keyword\":\"\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526270343');
INSERT INTO `zhimeng_operation_log` VALUES ('291', '2', 'Collection', '{\"collect_title\":\"\",\"collect_url\":\"\",\"collect_content_type\":\"UTF-8\",\"collect_page_status\":\"0\",\"collect_page_min\":\"\",\"collect_page_max\":\"\",\"get_content_urls_box\":\"\",\"get_content_collect_urls\":\"\",\"small_img_url\":\"\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"replace_keyword\":\"\",\"remove_keyword\":\"\",\"status\":\"0\",\"is_remove_a\":0,\"is_remove_script\":0,\"is_remove_div\":0,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_get_content_small_image\":0,\"is_remove_mark\":\"\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"article\\\",\\\"title\\\":\\\"\\\",\\\"content\\\":\\\"\\\"}\",\"update_time\":\"1970-01-01 08:33:38\",\"create_time\":\"2018-05-14 12:51:25\",\"id\":\"28\"}', 'add', '1526273485');
INSERT INTO `zhimeng_operation_log` VALUES ('292', '2', 'Collection', '{\"id\":23,\"model\":\"article\",\"category_id\":14,\"small_img_url\":\"img\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"get_content_urls_box\":\".arclist li\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":1,\"collect_page_min\":1,\"collect_page_max\":10,\"get_content_collect_urls\":\"a\",\"get_content_collect_urls_remove\":\"\",\"collect_content_urls\":null,\"collect_content_box\":null,\"collect_title\":\"Excel教程\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"status\":1,\"get_content_page\":\"\",\"is_get_content_small_image\":1,\"is_get_content_url\":0,\"is_remove_a\":1,\"is_remove_script\":1,\"is_remove_div\":1,\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_from\":1,\"is_remove_iframe\":0,\"is_remove_span\":0,\"is_remove_li\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"replace_keyword\":\"\",\"create_time\":\"1970-01-01 08:33:37\",\"update_tim', 'add', '1526274720');
INSERT INTO `zhimeng_operation_log` VALUES ('293', '2', 'Collection', '{\"collect_title\":\"Excel教程\",\"collect_url\":\"http:\\/\\/www.1ppt.com\\/excel\\/excel_jiaocheng_分页.html\",\"collect_content_type\":\"GB2312\",\"collect_page_status\":\"1\",\"collect_page_min\":\"1\",\"collect_page_max\":\"21\",\"get_content_urls_box\":\".arclist li\",\"get_content_collect_urls\":\"a\",\"small_img_url\":\"img\",\"get_content_collect_urls_remove\":\"\",\"get_content_page\":\"\",\"is_get_content_small_image\":\"1\",\"is_remove_from\":\"1\",\"is_remove_a\":\"1\",\"is_remove_script\":\"1\",\"is_remove_div\":\"1\",\"replace_keyword\":\"\",\"remove_keyword\":\"<h1>(.×?)<\\\\\\/h1>\",\"status\":\"1\",\"is_remove_p\":0,\"is_remove_img\":0,\"is_remove_input\":0,\"is_remove_textarea\":0,\"is_remove_li\":0,\"is_remove_span\":0,\"is_remove_iframe\":0,\"is_remove_mark\":\"-h1\\r\\n-.arc_info\\r\\n-.bdshare\\r\\n-#bdshare\\r\\n-.dede_pages\\r\\n-table\",\"model\":\"article\",\"category_id\":\"14\",\"collect_data\":\"{\\\"model\\\":\\\"\\\",\\\"title\\\":\\\"h1###text\\\",\\\"content\\\":\\\".content###html\\\"}\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1526276175');
INSERT INTO `zhimeng_operation_log` VALUES ('294', '2', 'Webpage', '{\"id\":\"181\",\"pid\":\"179\",\"title\":\"联系我们\",\"image\":\"\",\"content\":\"联系我们联系我们联系我们\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.4365703205574383\",\"update_time\":\"2018-05-14 19:17:51\"}', 'update', '1526296671');
INSERT INTO `zhimeng_operation_log` VALUES ('295', '2', 'Ad', '{\"id\":\"4\",\"postion_id\":\"1\",\"name\":\"test11\",\"type\":\"2\",\"image\":\"\",\"content\":\"<script>\\r\\nalert(\\\"asdf\\\");\\r\\n<\\/script>\",\"link\":\"\",\"start_time\":\"2018-05-03 00:00:00\",\"end_time\":\"2018-05-04 00:00:00\",\"dialogid\":\"dialogid0.24697373677209078\",\"update_time\":\"2018-05-24 13:22:25\"}', 'update', '1527139345');
INSERT INTO `zhimeng_operation_log` VALUES ('296', '2', 'Ad', '{\"id\":\"4\",\"postion_id\":\"1\",\"name\":\"test11\",\"type\":\"1\",\"image\":\"http:\\/\\/img.ivears.com\\/public\\/default\\/images\\/ivears_logo.png\",\"content\":\"\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-03 00:00:00\",\"end_time\":\"2018-05-04 00:00:00\",\"dialogid\":\"dialogid0.5608747836716566\",\"update_time\":\"2018-05-24 13:23:34\"}', 'update', '1527139414');
INSERT INTO `zhimeng_operation_log` VALUES ('297', '2', 'Ad', '{\"postion_id\":\"1\",\"name\":\"test11\",\"type\":\"1\",\"image\":\"https:\\/\\/www.baidu.com\\/img\\/bd_logo1.png?where=super\",\"content\":\"\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-24 00:00:00\",\"end_time\":\"2018-05-26 00:00:00\",\"dialogid\":\"dialogid0.6289799593823291\",\"create_time\":\"2018-05-24 13:23:55\",\"update_time\":\"2018-05-24 13:23:55\",\"id\":\"5\"}', 'add', '1527139435');
INSERT INTO `zhimeng_operation_log` VALUES ('298', '2', 'Ad', '{\"id\":\"4\",\"postion_id\":\"1\",\"name\":\"test11\",\"type\":\"1\",\"image\":\"http:\\/\\/img.ivears.com\\/public\\/default\\/images\\/ivears_logo.png\",\"content\":\"\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-03 00:00:00\",\"end_time\":\"2018-05-31 00:00:00\",\"dialogid\":\"dialogid0.944578473488211\",\"update_time\":\"2018-05-24 13:41:47\"}', 'update', '1527140507');
INSERT INTO `zhimeng_operation_log` VALUES ('299', '2', 'Ad', '{\"id\":\"5\",\"postion_id\":\"1\",\"name\":\"test11\",\"type\":\"1\",\"image\":\"https:\\/\\/www.baidu.com\\/img\\/bd_logo1.png?where=super\",\"content\":\"\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-22 00:00:00\",\"end_time\":\"2018-05-23 00:00:00\",\"dialogid\":\"dialogid0.9076587117925539\",\"update_time\":\"2018-05-24 13:43:48\"}', 'update', '1527140628');
INSERT INTO `zhimeng_operation_log` VALUES ('300', '2', 'Ad', '{\"id\":\"5\",\"postion_id\":\"1\",\"name\":\"test11\",\"type\":\"1\",\"image\":\"https:\\/\\/www.baidu.com\\/img\\/bd_logo1.png?where=super\",\"content\":\"\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-22 00:00:00\",\"end_time\":\"2018-05-25 00:00:00\",\"dialogid\":\"dialogid0.6050167836119285\",\"update_time\":\"2018-05-24 13:46:56\"}', 'update', '1527140816');
INSERT INTO `zhimeng_operation_log` VALUES ('301', '2', 'Article', '{\"cid\":\"\",\"title\":\"\",\"image\":\"\",\"content\":\"\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"1\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.20032104990167432\",\"create_time\":\"2018-05-24 16:30:18\",\"update_time\":\"2018-05-24 16:30:18\",\"id\":\"2836\"}', 'add', '1527150618');
INSERT INTO `zhimeng_operation_log` VALUES ('302', '2', 'Article', '{\"id\":2836,\"cid\":0,\"image\":\"\",\"title\":\"\",\"content\":\"\",\"source\":null,\"author\":\"admin\",\"keyword\":null,\"description\":null,\"click\":0,\"sort\":1,\"status\":1,\"is_recommend\":0,\"is_seo\":1,\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"create_time\":\"2018-05-24 16:30:18\",\"update_time\":\"2018-05-24 16:30:18\"}', 'delete', '1527150634');
INSERT INTO `zhimeng_operation_log` VALUES ('303', '2', 'Webpage', '{\"id\":\"182\",\"pid\":\"179\",\"title\":\"关于我们\",\"image\":\"\",\"content\":\"关于我们关于我们关于我们关于我们关于我们\",\"sort\":\"100\",\"is_seo\":\"0\",\"seo_title\":\"test11\",\"seo_keywords\":\"test11\",\"seo_desc\":\"test11\",\"dialogid\":\"dialogid0.6103855715559514\",\"update_time\":\"2018-05-24 16:37:07\"}', 'update', '1527151027');
INSERT INTO `zhimeng_operation_log` VALUES ('304', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/addrolenav.html\",\"pid\":\"2\",\"name\":\"扩展\",\"class_name\":\"icon-itface\",\"status\":\"1\",\"sort\":\"5\",\"dialogid\":\"dialogid0.6488333580405978\",\"create_time\":\"2018-05-24 20:29:10\",\"update_time\":\"1970-01-01 08:33:38\",\"id\":\"35\"}', 'add', '1527164950');
INSERT INTO `zhimeng_operation_log` VALUES ('305', '2', 'Module', '{\"s\":\"\\/system\\/module\\/add.html\",\"title\":\"test\",\"table\":\"test\",\"desc\":\"test\",\"seo_status\":\"0\",\"category_status\":\"0\",\"category_alias\":\"\",\"dialogid\":\"dialogid0.48568572439656177\",\"update_time\":\"2018-05-24 20:30:29\",\"create_time\":\"2018-05-24 20:30:29\",\"id\":\"6\"}', 'add', '1527165029');
INSERT INTO `zhimeng_operation_log` VALUES ('306', '2', 'Module', '{\"title\":\"test\",\"desc\":\"test\",\"seo_status\":\"0\",\"category_alias\":\"test分类\",\"category_status\":\"1\",\"update_time\":\"2018-05-24 20:30:48\"}', 'update', '1527165048');
INSERT INTO `zhimeng_operation_log` VALUES ('307', '2', 'Module', '{\"title\":\"test\",\"desc\":\"test\",\"seo_status\":\"0\",\"category_alias\":\"test分类\",\"category_status\":\"1\",\"update_time\":\"2018-05-24 20:31:13\"}', 'update', '1527165073');
INSERT INTO `zhimeng_operation_log` VALUES ('308', '2', 'Module', '{\"title\":\"test\",\"desc\":\"test\",\"seo_status\":\"0\",\"category_alias\":\"test分类\",\"category_status\":\"1\",\"update_time\":\"2018-05-24 20:32:01\"}', 'update', '1527165121');
INSERT INTO `zhimeng_operation_log` VALUES ('309', '2', 'Module', '{\"title\":\"test\",\"desc\":\"test\",\"seo_status\":\"0\",\"category_alias\":\"test分类\",\"category_status\":\"1\",\"update_time\":\"2018-05-24 20:32:18\"}', 'update', '1527165138');
INSERT INTO `zhimeng_operation_log` VALUES ('310', '2', 'Module', '{\"title\":\"test\",\"desc\":\"test\",\"seo_status\":\"0\",\"category_alias\":\"test分类\",\"category_status\":\"0\",\"update_time\":\"2018-05-24 20:32:37\"}', 'update', '1527165157');
INSERT INTO `zhimeng_operation_log` VALUES ('311', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"6\",\"mtag\":\"\",\"title\":\"test11\",\"fields\":\"test\",\"link_table_status\":\"0\",\"fields_type\":\"link_table\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"1\",\"verify_type\":\"required\",\"info\":\"test11\",\"sort\":\"1\",\"dialogid\":\"dialogid0.7731570799751912\",\"table_name\":\"test\",\"update_time\":\"2018-05-24 20:33:29\",\"create_time\":\"2018-05-24 20:33:29\",\"id\":\"175\"}', 'add', '1527165209');
INSERT INTO `zhimeng_operation_log` VALUES ('312', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/edit.html\",\"id\":\"175\",\"module_id\":\"6\",\"mtag\":\"test11\",\"title\":\"test11\",\"fields\":\"test\",\"link_table_status\":\"0\",\"fields_type\":\"link_table\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"1\",\"list_width\":\"10\",\"verify\":\"1\",\"verify_type\":\"required\",\"info\":\"test11\",\"sort\":\"1\",\"dialogid\":\"dialogid0.7247922948346806\",\"update_time\":\"2018-05-24 20:34:59\"}', 'update', '1527165299');
INSERT INTO `zhimeng_operation_log` VALUES ('313', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/edit.html\",\"id\":\"175\",\"module_id\":\"6\",\"mtag\":\"test11\",\"title\":\"test11\",\"fields\":\"test\",\"link_table_status\":\"0\",\"fields_type\":\"link_table\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"1\",\"verify_type\":\"required\",\"info\":\"test11\",\"sort\":\"1\",\"dialogid\":\"dialogid0.48680518051592103\",\"update_time\":\"2018-05-24 20:35:15\"}', 'update', '1527165315');
INSERT INTO `zhimeng_operation_log` VALUES ('314', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"6\",\"mtag\":\"\",\"title\":\"images\",\"fields\":\"images\",\"link_table_status\":\"0\",\"fields_type\":\"multfile\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"1\",\"verify_type\":\"required\",\"info\":\"test11\",\"sort\":\"1\",\"dialogid\":\"dialogid0.28244311457070004\",\"table_name\":\"test\",\"update_time\":\"2018-05-24 20:38:48\",\"create_time\":\"2018-05-24 20:38:48\",\"id\":\"176\"}', 'add', '1527165528');
INSERT INTO `zhimeng_operation_log` VALUES ('315', '2', 'Test', '{\"title\":\"asdf\",\"content\":\"asdfasdfasdf\",\"encode_fields\":{\"images\":\"images\"},\"images\":\"[\\\"\\\\\\/uploads\\\\\\/img\\\\\\/20180524\\\\\\/7a755b6f70a8a7ce6ba6c66b85518cd8.jpg\\\",\\\"\\\\\\/uploads\\\\\\/img\\\\\\/20180524\\\\\\/023f3c2a30b2ab0a3055925cc025406a.jpg\\\"]\",\"sort\":\"1\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.15294745223508976\",\"create_time\":\"2018-05-24 20:40:02\",\"update_time\":\"2018-05-24 20:40:02\",\"id\":\"1\"}', 'add', '1527165602');
INSERT INTO `zhimeng_operation_log` VALUES ('316', '2', 'Test', '{\"title\":\"test1\",\"content\":\"11asdf\",\"encode_fields\":{\"images\":\"images\"},\"images\":[\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\",\"\\/uploads\\/img\\/20180524\\/a78ebe19ac2077cda9b6a9c7b35c0894.jpg\"],\"sort\":\"1\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.22259736468316915\",\"create_time\":\"2018-05-24 20:44:35\",\"update_time\":\"2018-05-24 20:44:35\",\"id\":\"2\"}', 'add', '1527165875');
INSERT INTO `zhimeng_operation_log` VALUES ('317', '2', 'Test', '{\"module\":\"Test\",\"module_id\":\"2\",\"fileds_name\":\"images\",\"image\":\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\",\"create_time\":\"2018-05-24 20:44:35\",\"update_time\":\"2018-05-24 20:44:35\",\"id\":\"222\"}', 'add', '1527165875');
INSERT INTO `zhimeng_operation_log` VALUES ('318', '2', 'Test', '{\"module\":\"Test\",\"module_id\":\"2\",\"fileds_name\":\"images\",\"image\":\"\\/uploads\\/img\\/20180524\\/a78ebe19ac2077cda9b6a9c7b35c0894.jpg\",\"create_time\":\"2018-05-24 20:44:35\",\"update_time\":\"2018-05-24 20:44:35\",\"id\":\"223\"}', 'add', '1527165875');
INSERT INTO `zhimeng_operation_log` VALUES ('319', '2', 'Test', '{\"id\":\"1\",\"title\":\"asdf\",\"content\":\"asdfasdfasdf\",\"encode_fields\":{\"images\":\"images\"},\"sort\":\"0\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.7845495818806867\",\"update_time\":\"2018-05-24 20:46:35\"}', 'update', '1527165995');
INSERT INTO `zhimeng_operation_log` VALUES ('320', '2', 'Test', '{\"id\":\"2\",\"title\":\"test1\",\"content\":\"11asdf\",\"encode_fields\":{\"images\":\"images\"},\"images\":[\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\",\"\\/uploads\\/img\\/20180524\\/a78ebe19ac2077cda9b6a9c7b35c0894.jpg\"],\"sort\":\"5\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.3633536789560323\",\"update_time\":\"2018-05-24 20:46:52\"}', 'update', '1527166012');
INSERT INTO `zhimeng_operation_log` VALUES ('321', '2', 'Test', '{\"module\":\"Test\",\"module_id\":\"2\",\"fileds_name\":\"images\",\"image\":\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\",\"create_time\":\"2018-05-24 20:46:52\",\"update_time\":\"2018-05-24 20:46:52\",\"id\":\"224\"}', 'add', '1527166012');
INSERT INTO `zhimeng_operation_log` VALUES ('322', '2', 'Test', '{\"module\":\"Test\",\"module_id\":\"2\",\"fileds_name\":\"images\",\"image\":\"\\/uploads\\/img\\/20180524\\/a78ebe19ac2077cda9b6a9c7b35c0894.jpg\",\"create_time\":\"2018-05-24 20:46:52\",\"update_time\":\"2018-05-24 20:46:52\",\"id\":\"225\"}', 'add', '1527166012');
INSERT INTO `zhimeng_operation_log` VALUES ('323', '2', 'Test', '{\"id\":\"1\",\"title\":\"asdf\",\"content\":\"asdfasdfasdf\",\"encode_fields\":{\"images\":\"images\"},\"sort\":\"10\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.11565866365525324\",\"update_time\":\"2018-05-24 20:47:30\"}', 'update', '1527166050');
INSERT INTO `zhimeng_operation_log` VALUES ('324', '2', 'Test', '{\"id\":\"2\",\"title\":\"test1\",\"content\":\"11asdf\",\"encode_fields\":{\"images\":\"images\"},\"images\":[\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\"],\"sort\":\"5\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.40271894320796275\",\"update_time\":\"2018-05-24 20:48:44\"}', 'update', '1527166125');
INSERT INTO `zhimeng_operation_log` VALUES ('325', '2', 'Test', '{\"module\":\"Test\",\"module_id\":\"2\",\"fileds_name\":\"images\",\"image\":\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\",\"create_time\":\"2018-05-24 20:48:45\",\"update_time\":\"2018-05-24 20:48:45\",\"id\":\"226\"}', 'add', '1527166125');
INSERT INTO `zhimeng_operation_log` VALUES ('326', '2', 'Test', '{\"id\":\"1\",\"title\":\"asdf\",\"content\":\"asdfasdfasdf\",\"encode_fields\":{\"images\":\"images\"},\"sort\":\"10\",\"is_recommend\":\"1\",\"dialogid\":\"dialogid0.6359311183053535\",\"update_time\":\"2018-05-24 20:49:11\"}', 'update', '1527166151');
INSERT INTO `zhimeng_operation_log` VALUES ('327', '2', 'Test', '{\"id\":\"2\",\"title\":\"test1\",\"content\":\"11asdf\",\"encode_fields\":{\"images\":\"images\"},\"images\":[\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\"],\"sort\":\"5\",\"is_recommend\":\"1\",\"dialogid\":\"dialogid0.2934413372610545\",\"update_time\":\"2018-05-24 20:49:16\"}', 'update', '1527166156');
INSERT INTO `zhimeng_operation_log` VALUES ('328', '2', 'Test', '{\"module\":\"Test\",\"module_id\":\"2\",\"fileds_name\":\"images\",\"image\":\"\\/uploads\\/img\\/20180524\\/79bea8876a5ac316550f8845b7911a50.jpg\",\"create_time\":\"2018-05-24 20:49:16\",\"update_time\":\"2018-05-24 20:49:16\",\"id\":\"227\"}', 'add', '1527166156');
INSERT INTO `zhimeng_operation_log` VALUES ('329', '2', 'Setting', '{\"c_key\":\"WEB_SITE\",\"c_value\":\"{\\\"site_name\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_url\\\":\\\"http:\\\\\\/\\\\\\/www.ivears.com\\\\\\/\\\",\\\"site_title\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_keywords\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_description\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_icp\\\":\\\"ICP\\\\u8bc1\\\\u4e66\\\\u53f7\\\",\\\"site_copyright\\\":\\\"\\\\u7248\\\\u6743\\\",\\\"site_tongji\\\":\\\"\\\\u7edf\\\\u8ba1\\\\u4ee3\\\\u7801\\\",\\\"site_status\\\":\\\"1\\\",\\\"request_cache_except\\\":\\\"\\\"}\",\"c_value_desc\":\"站点全局设置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1540202893,\"update_time\":\"2018-10-22 18:08:13\"}', 'update', '1540202893');
INSERT INTO `zhimeng_operation_log` VALUES ('330', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"4\",\"mtag\":\"\",\"title\":\"logo\",\"fields\":\"logo\",\"link_table_status\":\"0\",\"fields_type\":\"image\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"logo\",\"sort\":\"1\",\"dialogid\":\"dialogid0.6783740327767183\",\"table_name\":\"setting\",\"create_time\":\"2018-10-22 18:14:29\",\"update_time\":\"2018-10-22 18:14:29\",\"id\":\"177\"}', 'add', '1540203269');
INSERT INTO `zhimeng_operation_log` VALUES ('331', '2', 'Setting', '{\"c_key\":\"CUSTOMIZE_SITE\",\"c_value\":\"{\\\"site_tel\\\":\\\"13880713476\\\",\\\"logo\\\":\\\"\\\\\\/uploads\\\\\\/img\\\\\\/20181022\\\\\\/e301d1440b3b8c1e92d3bb80607d5ff0.jpg\\\",\\\"site_address\\\":\\\"\\\\u56db\\\\u5ddd\\\\u6210\\\\u90fd11\\\",\\\"site_kefu\\\":\\\"\\\"}\",\"c_value_desc\":\"自定义站点设置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1540203303,\"update_time\":\"2018-10-22 18:15:03\"}', 'update', '1540203303');
INSERT INTO `zhimeng_operation_log` VALUES ('332', '2', 'Product', '{\"id\":13,\"model\":\"product\",\"title\":\"test22\",\"alias\":\"test22\",\"pid\":12,\"description\":\"test22\",\"sort\":1,\"image\":\"\\/uploads\\/img\\/20180501\\/1014e7b5fa8efb8757ad05d81a34dba9.png\",\"status\":1,\"is_menu\":0,\"language\":1,\"is_seo\":0,\"seo_title\":\"SEO标题\",\"seo_keywords\":\"SEO关键词\",\"seo_desc\":\"SEO描述\",\"create_time\":\"2018-05-01 00:55:54\",\"update_time\":\"2018-05-02 12:51:39\"}', 'delete', '1540260193');
INSERT INTO `zhimeng_operation_log` VALUES ('333', '2', 'Product', '{\"id\":12,\"model\":\"product\",\"title\":\"电脑产品\",\"alias\":\"电脑产品\",\"pid\":0,\"description\":\"电脑产品\",\"sort\":1,\"image\":\"\",\"status\":1,\"is_menu\":0,\"language\":1,\"is_seo\":0,\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"create_time\":\"2018-05-01 00:54:53\",\"update_time\":\"2018-05-04 16:37:12\"}', 'delete', '1540260195');
INSERT INTO `zhimeng_operation_log` VALUES ('334', '2', 'Article', '{\"id\":14,\"model\":\"article\",\"title\":\"test11\",\"alias\":\"test11\",\"pid\":1,\"description\":\"test11\",\"sort\":1,\"image\":\"\",\"status\":1,\"is_menu\":0,\"language\":1,\"is_seo\":0,\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"create_time\":\"2018-05-02 01:09:08\",\"update_time\":\"2018-05-02 01:09:08\"}', 'delete', '1540260202');
INSERT INTO `zhimeng_operation_log` VALUES ('335', '2', 'Article', '{\"id\":1,\"model\":\"article\",\"title\":\"商业\\/管理\\/HR\",\"alias\":\"商业\\/管理\\/HR\",\"pid\":0,\"description\":\"商业\\/管理\\/HR\",\"sort\":26,\"image\":\"\\/uploads\\/img\\/20180501\\/4b807785be2a5e92291294fb31127024.png\",\"status\":1,\"is_menu\":1,\"language\":1,\"is_seo\":0,\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"create_time\":\"1970-01-01 08:33:37\",\"update_time\":\"2018-05-01 01:01:03\"}', 'delete', '1540260204');
INSERT INTO `zhimeng_operation_log` VALUES ('336', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/addrolenav.html\",\"pid\":\"2\",\"name\":\"书库管理\",\"class_name\":\".icon-wenzhang\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.33511648585102094\",\"create_time\":\"2018-10-23 10:08:04\",\"update_time\":\"1970-01-01 08:33:38\",\"id\":\"36\"}', 'add', '1540260484');
INSERT INTO `zhimeng_operation_log` VALUES ('337', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"index\",\"action_name\":\"书库\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.6840538445743807\",\"create_time\":\"2018-10-23 10:11:17\",\"update_time\":\"2018-10-23 10:11:17\",\"id\":\"694\"}', 'add', '1540260677');
INSERT INTO `zhimeng_operation_log` VALUES ('338', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/editrolenav.html\",\"id\":\"36\",\"pid\":\"2\",\"name\":\"书库\",\"class_name\":\".icon-wenzhang\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.6756332231157485\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1540260833');
INSERT INTO `zhimeng_operation_log` VALUES ('339', '2', 'Module', '{\"s\":\"\\/system\\/module\\/add.html\",\"title\":\"书\",\"table\":\"book\",\"desc\":\"书\",\"seo_status\":\"0\",\"category_status\":\"1\",\"category_alias\":\"分类\",\"dialogid\":\"dialogid0.38341487392094153\",\"update_time\":\"2018-10-23 10:19:37\",\"create_time\":\"2018-10-23 10:19:37\",\"id\":\"7\"}', 'add', '1540261177');
INSERT INTO `zhimeng_operation_log` VALUES ('340', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/editrolenav.html\",\"id\":\"36\",\"pid\":\"2\",\"name\":\"书库\",\"class_name\":\".icon-wenzhang\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.9685131545611823\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1540261405');
INSERT INTO `zhimeng_operation_log` VALUES ('341', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"index\",\"action_name\":\"书库\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.26747423326889086\",\"create_time\":\"2018-10-23 10:24:33\",\"update_time\":\"2018-10-23 10:24:33\",\"id\":\"697\"}', 'add', '1540261473');
INSERT INTO `zhimeng_operation_log` VALUES ('342', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"category\",\"action_name\":\"分类\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.6654632789951287\",\"create_time\":\"2018-10-23 10:56:11\",\"update_time\":\"2018-10-23 10:56:11\",\"id\":\"698\"}', 'add', '1540263371');
INSERT INTO `zhimeng_operation_log` VALUES ('343', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"categoryindex\",\"action_name\":\"分类\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.30702215548526746\",\"update_time\":\"2018-10-23 10:58:16\"}', 'update', '1540263496');
INSERT INTO `zhimeng_operation_log` VALUES ('344', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"chapter\",\"action_name\":\"章节\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.183366162851339\",\"create_time\":\"2018-10-23 17:35:35\",\"update_time\":\"2018-10-23 17:35:35\",\"id\":\"699\"}', 'add', '1540287335');
INSERT INTO `zhimeng_operation_log` VALUES ('345', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"4\",\"mtag\":\"\",\"title\":\"客户电话\",\"fields\":\"tel\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"客户电话\",\"sort\":\"1\",\"dialogid\":\"dialogid0.7313632556170453\",\"table_name\":\"setting\",\"create_time\":\"2018-10-29 18:11:30\",\"update_time\":\"2018-10-29 18:11:30\",\"id\":\"178\"}', 'add', '1540807890');
INSERT INTO `zhimeng_operation_log` VALUES ('346', '2', 'Fields', '{\"s\":\"\\/system\\/fields\\/add.html\",\"module_id\":\"4\",\"mtag\":\"\",\"title\":\"咨询QQ\",\"fields\":\"qq\",\"link_table_status\":\"0\",\"fields_type\":\"text\",\"link_table_name\":\"\",\"link_table_where\":\"\",\"deputy_table_status\":\"0\",\"deputy_table\":\"\",\"link_table_fields\":\"\",\"link_table_fields_display_name\":\"\",\"fields_value\":\"\",\"is_show\":\"1\",\"list_show\":\"0\",\"list_width\":\"10\",\"verify\":\"0\",\"verify_type\":\"\",\"info\":\"客户电话\",\"sort\":\"1\",\"dialogid\":\"dialogid0.7313632556170453\",\"table_name\":\"setting\",\"create_time\":\"2018-10-29 18:11:56\",\"update_time\":\"2018-10-29 18:11:56\",\"id\":\"179\"}', 'add', '1540807916');
INSERT INTO `zhimeng_operation_log` VALUES ('347', '2', 'Setting', '{\"c_key\":\"CUSTOMIZE_SITE\",\"c_value\":\"{\\\"site_tel\\\":\\\"13880713476\\\",\\\"logo\\\":\\\"\\\\\\/uploads\\\\\\/img\\\\\\/20181022\\\\\\/e301d1440b3b8c1e92d3bb80607d5ff0.jpg\\\",\\\"tel\\\":\\\"400-886-3878\\\",\\\"qq\\\":\\\"1181894949\\\",\\\"site_address\\\":\\\"\\\\u56db\\\\u5ddd\\\\u6210\\\\u90fd11\\\",\\\"site_kefu\\\":\\\"\\\"}\",\"c_value_desc\":\"自定义站点设置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1540807925,\"update_time\":\"2018-10-29 18:12:05\"}', 'update', '1540807925');
INSERT INTO `zhimeng_operation_log` VALUES ('348', '2', 'Setting', '{\"c_key\":\"CUSTOMIZE_SITE\",\"c_value\":\"{\\\"site_tel\\\":\\\"13880713476\\\",\\\"logo\\\":\\\"\\\\\\/uploads\\\\\\/img\\\\\\/20181030\\\\\\/e8f7a2609e0b6ea5cf98f43f16ac66f8.png\\\",\\\"tel\\\":\\\"400-886-3878\\\",\\\"qq\\\":\\\"1181894949\\\",\\\"site_address\\\":\\\"\\\\u56db\\\\u5ddd\\\\u6210\\\\u90fd11\\\",\\\"site_kefu\\\":\\\"\\\"}\",\"c_value_desc\":\"自定义站点设置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1540881741,\"update_time\":\"2018-10-30 14:42:21\"}', 'update', '1540881741');
INSERT INTO `zhimeng_operation_log` VALUES ('349', '2', 'Setting', '{\"c_key\":\"CUSTOMIZE_SITE\",\"c_value\":\"{\\\"site_tel\\\":\\\"13880713476\\\",\\\"logo\\\":\\\"\\\\\\/uploads\\\\\\/img\\\\\\/20181102\\\\\\/b5e7373ffb39fec81328b3cb4e9bbf9c.PNG\\\",\\\"tel\\\":\\\"400-886-3878\\\",\\\"qq\\\":\\\"1181894949\\\",\\\"site_address\\\":\\\"\\\\u56db\\\\u5ddd\\\\u6210\\\\u90fd11\\\",\\\"site_kefu\\\":\\\"\\\"}\",\"c_value_desc\":\"自定义站点设置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1541144430,\"update_time\":\"2018-11-02 15:40:30\"}', 'update', '1541144430');
INSERT INTO `zhimeng_operation_log` VALUES ('350', '2', 'Links', '{\"display_type\":\"2\",\"title\":\"落尘文学\",\"link\":\"https:\\/\\/www.luochen.com\\/\",\"start_time\":\"2018-11-06 10:55:42\",\"end_time\":\"2018-11-06 00:00:00\",\"sort\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.844430050888394\",\"create_time\":\"2018-11-06 10:55:52\",\"update_time\":\"2018-11-06 10:55:52\",\"id\":\"139\"}', 'add', '1541472952');
INSERT INTO `zhimeng_operation_log` VALUES ('351', '2', 'Links', '{\"display_type\":\"1\",\"title\":\"有梦文学\",\"link\":\"http:\\/\\/www.yomeng.com\\/\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2024-05-25 00:00:00\",\"sort\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.7990622228569777\",\"create_time\":\"2018-11-06 10:56:21\",\"update_time\":\"2018-11-06 10:56:21\",\"id\":\"140\"}', 'add', '1541472981');
INSERT INTO `zhimeng_operation_log` VALUES ('352', '2', 'Links', '{\"display_type\":\"1\",\"title\":\"安夏书院\",\"link\":\"http:\\/\\/new.axshuyuan.com\\/#\\/home\\/homeindex\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2024-11-06 12:43:45\",\"sort\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.2037213153866455\",\"create_time\":\"2018-11-06 10:57:10\",\"update_time\":\"2018-11-06 10:57:10\",\"id\":\"141\"}', 'add', '1541473030');
INSERT INTO `zhimeng_operation_log` VALUES ('353', '2', 'Links', '{\"id\":\"141\",\"display_type\":\"2\",\"title\":\"安夏书院\",\"link\":\"http:\\/\\/new.axshuyuan.com\\/#\\/home\\/homeindex\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2024-11-06 12:43:45\",\"sort\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.10651563807446585\",\"update_time\":\"2018-11-06 10:57:17\"}', 'update', '1541473037');
INSERT INTO `zhimeng_operation_log` VALUES ('354', '2', 'Links', '{\"id\":\"140\",\"display_type\":\"2\",\"title\":\"有梦文学\",\"link\":\"http:\\/\\/www.yomeng.com\\/\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2024-05-25 00:00:00\",\"sort\":\"1\",\"status\":\"1\",\"dialogid\":\"dialogid0.3085438511679637\",\"update_time\":\"2018-11-06 10:57:22\"}', 'update', '1541473042');
INSERT INTO `zhimeng_operation_log` VALUES ('355', '2', 'Setting', '{\"c_key\":\"WEB_SITE\",\"c_value\":\"{\\\"site_name\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_url\\\":\\\"http:\\\\\\/\\\\\\/www.ivears.com\\\\\\/\\\",\\\"site_title\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_keywords\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_description\\\":\\\"\\\\u53cc\\\\u6eaa\\\\u6587\\\\u5b66\\\",\\\"site_icp\\\":\\\"\\\\u6d59ICP\\\\u590718033749\\\\u53f7\\\",\\\"site_copyright\\\":\\\"\\\\u7248\\\\u6743\\\",\\\"site_tongji\\\":\\\"\\\\u7edf\\\\u8ba1\\\\u4ee3\\\\u7801\\\",\\\"site_status\\\":\\\"1\\\",\\\"request_cache_except\\\":\\\"\\\"}\",\"c_value_desc\":\"站点全局设置\",\"c_type\":\"system\",\"status\":1,\"c_update_time\":1541650620,\"update_time\":\"2018-11-08 12:17:00\"}', 'update', '1541650620');
INSERT INTO `zhimeng_operation_log` VALUES ('356', '2', 'Webpage', '{\"id\":\"179\",\"pid\":\"0\",\"title\":\"关于我们\",\"image\":\"\",\"content\":\"<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书文学网是新兴的原创阅读与创作平台。隶属于文心科技有限公司，成立于2018年4月。具有雄厚的实力，顶尖的团队，目前与众多的第三方平台、新媒体平台无线版权运营机构具有深度合作。主要提供在线阅读、无线阅读、动漫改编、影视改编、游戏改编、实体出版服务等业务。培育自有内容IP化，将内容产品推向影视市场，向社会输出各种精品版权，实现版权价值最大化。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书文学网长期致力于原创文学作者的挖掘与培养，尽力为每位作者打造一条属于他的成神之路，同时致力于打造社交化阅读平台，为读者提供良好的阅读体验。绾书绾书，以书为绳，将作者与读者紧密连在一起。让每位作者更加了解读者的兴趣点，让每位读者更有机会表现对作者的支持。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书是个萌新，但我们终会成长！\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书立志于成为中国原创阅读的重要一部分。绾书文学网真诚期待与各位作家以及版权运营商合作！\\r\\n<\\/p>\\r\\n<div class=\\\"dot-line\\\" style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot', 'update', '1541658089');
INSERT INTO `zhimeng_operation_log` VALUES ('357', '2', 'Webpage', '{\"pid\":\"0\",\"title\":\"联系我们\",\"image\":\"\",\"content\":\"<h6 style=\\\"font-size:16px;font-weight:400;color:#333333;font-family:PingFangSC-Regular, &quot;background-color:#FFFFFF;\\\">\\r\\n\\t杭州文心网络科技有限公司\\r\\n<\\/h6>\\r\\n<div style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t地址：中国（杭州）西湖区文二路391号西湖国际科技大厦B2座10楼\\r\\n<\\/div>\\r\\n<div style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t电话：400-998-1236\\r\\n<\\/div>\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.2938401351172182\",\"create_time\":\"2018-11-08 14:22:01\",\"update_time\":\"2018-11-08 14:22:01\",\"id\":\"184\"}', 'add', '1541658121');
INSERT INTO `zhimeng_operation_log` VALUES ('358', '2', 'Webpage', '{\"pid\":\"0\",\"title\":\"版权申明\",\"image\":\"\",\"content\":\"<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t本站一贯高度重视知识产权保护并遵守中华人民共和国各项知识产权法律、法规和具有约束力的规范性文件,坚信著作权拥有者的合法权益应该得到尊重和依法保护。本站坚决反对任何违反中华人民共和国有关著作权的法律法规的行为。由于我们无法对用户上传到本网站的所有作品内容进行充分的监测，我们制定了旨在保护知识产权权利人合法权益的措施和步骤，当著作权人和\\/或依法可以行使信息网络传播权的权利人（以下简称\\\"权利人\\\"）发现本站上用户上传内容侵犯其信息网络传播权时，权利人应事先向本站发出权利通知，本站将根据相关法律规定采取措施删除相关内容。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t在本站上传作品的用户视为同意本站上述及已采用的相应措施。本站不因此而承担任何违约责任或其他任何法律责任，包括不承担因侵权指控不成立而给原上传用户带来损害的赔偿责任。本站在收到上述通知后会通知上传该等作品的用户。对于多次上传涉嫌侵权作品的用户，我们将取消其用户资格。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书是个萌新，但我们终会成长！\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书立志于成为中国原创阅读的重要一部分。绾书文学网真诚期待与各位作家以及版权运营商合作！\\r\\n<\\/p>\\r\\n', 'add', '1541658148');
INSERT INTO `zhimeng_operation_log` VALUES ('359', '2', 'Webpage', '{\"pid\":\"0\",\"title\":\"关于我们\",\"image\":\"\",\"content\":\"\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.9175167946682004\",\"create_time\":\"2018-11-08 14:23:02\",\"update_time\":\"2018-11-08 14:23:02\",\"id\":\"186\"}', 'add', '1541658182');
INSERT INTO `zhimeng_operation_log` VALUES ('360', '2', 'Webpage', '{\"id\":\"179\",\"pid\":\"186\",\"title\":\"关于我们\",\"image\":\"\",\"content\":\"<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书文学网是新兴的原创阅读与创作平台。隶属于文心科技有限公司，成立于2018年4月。具有雄厚的实力，顶尖的团队，目前与众多的第三方平台、新媒体平台无线版权运营机构具有深度合作。主要提供在线阅读、无线阅读、动漫改编、影视改编、游戏改编、实体出版服务等业务。培育自有内容IP化，将内容产品推向影视市场，向社会输出各种精品版权，实现版权价值最大化。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书文学网长期致力于原创文学作者的挖掘与培养，尽力为每位作者打造一条属于他的成神之路，同时致力于打造社交化阅读平台，为读者提供良好的阅读体验。绾书绾书，以书为绳，将作者与读者紧密连在一起。让每位作者更加了解读者的兴趣点，让每位读者更有机会表现对作者的支持。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书是个萌新，但我们终会成长！\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书立志于成为中国原创阅读的重要一部分。绾书文学网真诚期待与各位作家以及版权运营商合作！\\r\\n<\\/p>\\r\\n<div class=\\\"dot-line\\\" style=\\\"color:#666666;font-family:PingFangSC-Regular, &qu', 'update', '1541658193');
INSERT INTO `zhimeng_operation_log` VALUES ('361', '2', 'Webpage', '{\"id\":\"185\",\"pid\":\"186\",\"title\":\"版权申明\",\"image\":\"\",\"content\":\"<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t本站一贯高度重视知识产权保护并遵守中华人民共和国各项知识产权法律、法规和具有约束力的规范性文件,坚信著作权拥有者的合法权益应该得到尊重和依法保护。本站坚决反对任何违反中华人民共和国有关著作权的法律法规的行为。由于我们无法对用户上传到本网站的所有作品内容进行充分的监测，我们制定了旨在保护知识产权权利人合法权益的措施和步骤，当著作权人和\\/或依法可以行使信息网络传播权的权利人（以下简称\\\"权利人\\\"）发现本站上用户上传内容侵犯其信息网络传播权时，权利人应事先向本站发出权利通知，本站将根据相关法律规定采取措施删除相关内容。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t在本站上传作品的用户视为同意本站上述及已采用的相应措施。本站不因此而承担任何违约责任或其他任何法律责任，包括不承担因侵权指控不成立而给原上传用户带来损害的赔偿责任。本站在收到上述通知后会通知上传该等作品的用户。对于多次上传涉嫌侵权作品的用户，我们将取消其用户资格。\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书是个萌新，但我们终会成长！\\r\\n<\\/p>\\r\\n<p style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t绾书立志于成为中国原创阅读的重要一部分。绾书文学网真诚期待与各位作家以及版权运营商合作！', 'update', '1541658199');
INSERT INTO `zhimeng_operation_log` VALUES ('362', '2', 'Webpage', '{\"id\":\"184\",\"pid\":\"186\",\"title\":\"联系我们\",\"image\":\"\",\"content\":\"<h6 style=\\\"font-size:16px;font-weight:400;color:#333333;font-family:PingFangSC-Regular, &quot;background-color:#FFFFFF;\\\">\\r\\n\\t杭州文心网络科技有限公司\\r\\n<\\/h6>\\r\\n<div style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t地址：中国（杭州）西湖区文二路391号西湖国际科技大厦B2座10楼\\r\\n<\\/div>\\r\\n<div style=\\\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\\\">\\r\\n\\t电话：400-998-1236\\r\\n<\\/div>\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.14726389515947425\",\"update_time\":\"2018-11-08 14:23:24\"}', 'update', '1541658204');
INSERT INTO `zhimeng_operation_log` VALUES ('363', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/addrolenav.html\",\"pid\":\"2\",\"name\":\"广告管理\",\"class_name\":\".icon-ad\",\"status\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.06645706104350424\",\"create_time\":\"2018-11-09 11:44:18\",\"update_time\":\"1970-01-01 08:33:38\",\"id\":\"37\"}', 'add', '1541735058');
INSERT INTO `zhimeng_operation_log` VALUES ('364', '2', 'RoleNav', '{\"id\":29,\"pid\":5,\"name\":\"广告\",\"status\":1,\"sort\":1,\"class_name\":\"icon-ad\",\"image\":\"\\/public\\/admin\\/default\\/images\\/login\\/ad.png\",\"update_time\":\"1970-01-01 08:33:38\",\"create_time\":\"2018-04-13 19:36:21\"}', 'delete', '1541735112');
INSERT INTO `zhimeng_operation_log` VALUES ('365', '2', 'AdPostion', '{\"id\":\"1\",\"name\":\"首页广告\",\"alias\":\"index_img\",\"sort\":\"1\",\"dialogid\":\"dialogid0.043692903432444474\",\"update_time\":\"2018-11-09 11:46:32\"}', 'update', '1541735192');
INSERT INTO `zhimeng_operation_log` VALUES ('366', '2', 'Ad', '{\"id\":4,\"type\":1,\"postion_id\":1,\"name\":\"test11\",\"image\":\"http:\\/\\/img.ivears.com\\/public\\/default\\/images\\/ivears_logo.png\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-03 00:00:00\",\"end_time\":\"2018-05-31 00:00:00\",\"content\":\"\",\"status\":1,\"create_time\":\"2018-05-03 19:09:04\",\"update_time\":\"2018-05-24 13:41:47\"}', 'delete', '1541735215');
INSERT INTO `zhimeng_operation_log` VALUES ('367', '2', 'AdPostion', '{\"id\":\"1\",\"name\":\"首页广告1\",\"alias\":\"index_img\",\"sort\":\"1\",\"dialogid\":\"dialogid0.9163791973675259\",\"update_time\":\"2018-11-09 11:47:03\"}', 'update', '1541735223');
INSERT INTO `zhimeng_operation_log` VALUES ('368', '2', 'AdPostion', '{\"id\":\"27\",\"name\":\"首页广告2\",\"alias\":\"index_img1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.6289138124077087\",\"update_time\":\"2018-11-09 11:47:33\"}', 'update', '1541735253');
INSERT INTO `zhimeng_operation_log` VALUES ('369', '2', 'Ad', '{\"id\":\"5\",\"postion_id\":\"1\",\"name\":\"黑夜传说\",\"type\":\"1\",\"image\":\"\\/uploads\\/img\\/20181109\\/779de88387c9cdcb777eb699ec146712.jpg\",\"content\":\"\",\"link\":\"http:\\/\\/www.ivears.com\\/\",\"start_time\":\"2018-05-22 00:00:00\",\"end_time\":\"2024-05-25 00:00:00\",\"dialogid\":\"dialogid0.4666418116399378\",\"update_time\":\"2018-11-09 11:48:10\"}', 'update', '1541735290');
INSERT INTO `zhimeng_operation_log` VALUES ('370', '2', 'Ad', '{\"postion_id\":\"27\",\"name\":\"福利活动\",\"type\":\"1\",\"image\":\"\\/uploads\\/img\\/20181109\\/5e33d18c4b6b8864da647a6b14dd0188.png\",\"content\":\"\",\"link\":\"http:\\/\\/www.zmcms.com.cn\\/\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2024-08-30 00:00:00\",\"dialogid\":\"dialogid0.20875306530157078\",\"create_time\":\"2018-11-09 11:48:27\",\"update_time\":\"2018-11-09 11:48:27\",\"id\":\"6\"}', 'add', '1541735307');
INSERT INTO `zhimeng_operation_log` VALUES ('371', '2', 'AdPostion', '{\"id\":\"27\",\"name\":\"首页广告2\",\"alias\":\"index_b\",\"sort\":\"1\",\"dialogid\":\"dialogid0.1551724117080442\",\"update_time\":\"2018-11-09 11:51:11\"}', 'update', '1541735471');
INSERT INTO `zhimeng_operation_log` VALUES ('372', '2', 'Ad', '{\"id\":\"6\",\"postion_id\":\"27\",\"name\":\"福利活动\",\"type\":\"1\",\"image\":\"\\/uploads\\/img\\/20181109\\/5e33d18c4b6b8864da647a6b14dd0188.png\",\"content\":\"\",\"link\":\"http:\\/\\/www.zmcms.com.cn\\/\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2018-11-09 13:36:56\",\"dialogid\":\"dialogid0.09952631341615437\",\"update_time\":\"2018-11-09 13:36:59\"}', 'update', '1541741819');
INSERT INTO `zhimeng_operation_log` VALUES ('373', '2', 'Ad', '{\"id\":\"6\",\"postion_id\":\"27\",\"name\":\"福利活动\",\"type\":\"1\",\"image\":\"\\/uploads\\/img\\/20181109\\/5e33d18c4b6b8864da647a6b14dd0188.png\",\"content\":\"\",\"link\":\"http:\\/\\/www.zmcms.com.cn\\/\",\"start_time\":\"2018-08-16 16:23:43\",\"end_time\":\"2024-11-09 13:36:56\",\"dialogid\":\"dialogid0.08865495791227396\",\"update_time\":\"2018-11-09 13:37:12\"}', 'update', '1541741832');
INSERT INTO `zhimeng_operation_log` VALUES ('374', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"examine\",\"action_name\":\"未审核章节\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"100\",\"dialogid\":\"dialogid0.7774156403397008\",\"create_time\":\"2018-11-09 13:44:47\",\"update_time\":\"2018-11-09 13:44:47\",\"id\":\"700\"}', 'add', '1541742287');
INSERT INTO `zhimeng_operation_log` VALUES ('375', '2', 'Webpage', '{\"pid\":\"0\",\"title\":\"用户协议\",\"image\":\"\",\"content\":\"<h2 class=\\\"text-center\\\" style=\\\"color:rgba(0, 0, 0, 0.85);font-weight:500;text-align:center;font-family:PingFangSC-Regular, &quot;\\\">\\r\\n\\t用户协议\\r\\n<\\/h2>\\r\\n<p style=\\\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\\\">\\r\\n\\t本《用户协议》是您(下称\\\"用户\\\")与杭州文心网络科技有限公司(下称“文心网络科技”)之间在使用文心网络科技出品的各类产品之前，注册用户(又名“帐号”，下统称“帐号”)在使用产品时签署的协议。\\r\\n<\\/p>\\r\\n<h3 style=\\\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\\\">\\r\\n\\t一、重要须知---在签署本协议之前，文心网络科技正式提醒用户：\\r\\n<\\/h3>\\r\\n<p style=\\\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\\\">\\r\\n\\t1.1 您应认真阅读(未成年人应当在监护人陪同下阅读)、充分理解本《用户协议》中各条款，特别是免除或者限制文心网络科技责任的免责条款，用户的权利限制条款，约定争议解决方式、司法管辖、法律适用的条款。\\r\\n<\\/p>\\r\\n<p style=\\\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\\\">\\r\\n\\t1.2 除非您接受本协议，否则用户无权也无必要继续接受文心网络科技的服务，可以退出本次注册。用户点击接受并继续使用文心网络科技的服务，视为用户已完全的接受本协议', 'add', '1541745658');
INSERT INTO `zhimeng_operation_log` VALUES ('376', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/addrolenav.html\",\"pid\":\"0\",\"name\":\"统计\",\"class_name\":\"\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.7393912507242546\",\"create_time\":\"2018-11-12 15:31:08\",\"update_time\":\"1970-01-01 08:33:38\",\"id\":\"38\"}', 'add', '1542007868');
INSERT INTO `zhimeng_operation_log` VALUES ('377', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/addrolenav.html\",\"pid\":\"0\",\"name\":\"统计\",\"class_name\":\"\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.1554804395018068\",\"create_time\":\"2018-11-12 15:32:44\",\"update_time\":\"1970-01-01 08:33:38\",\"id\":\"39\"}', 'add', '1542007964');
INSERT INTO `zhimeng_operation_log` VALUES ('378', '2', 'RoleNav', '{\"id\":39,\"pid\":0,\"name\":\"统计\",\"status\":1,\"sort\":1,\"class_name\":\"\",\"image\":null,\"update_time\":\"1970-01-01 08:33:38\",\"create_time\":\"2018-11-12 15:32:44\"}', 'delete', '1542008014');
INSERT INTO `zhimeng_operation_log` VALUES ('379', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/editrolenav.html\",\"id\":\"38\",\"pid\":\"2\",\"name\":\"统计\",\"class_name\":\".icon-tongji\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.5830037086379132\",\"update_time\":\"1970-01-01 08:33:38\"}', 'update', '1542008053');
INSERT INTO `zhimeng_operation_log` VALUES ('380', '2', 'RoleNode', '{\"nav_id\":\"38\",\"action\":\"take\",\"action_name\":\"订阅\",\"module\":\"Income\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"10\",\"dialogid\":\"dialogid0.33271313784730583\",\"create_time\":\"2018-11-12 15:36:38\",\"update_time\":\"2018-11-12 15:36:38\",\"id\":\"701\"}', 'add', '1542008198');
INSERT INTO `zhimeng_operation_log` VALUES ('381', '2', 'RoleNode', '{\"nav_id\":\"38\",\"action\":\"reward\",\"action_name\":\"打赏\",\"module\":\"Income\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.1736293465132257\",\"create_time\":\"2018-11-13 09:31:59\",\"update_time\":\"2018-11-13 09:31:59\",\"id\":\"702\"}', 'add', '1542072719');
INSERT INTO `zhimeng_operation_log` VALUES ('382', '2', 'RoleNode', '{\"nav_id\":\"38\",\"action\":\"reward\",\"action_name\":\"打赏\",\"module\":\"Income\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"10\",\"dialogid\":\"dialogid0.07108309285096248\",\"update_time\":\"2018-11-13 09:32:36\"}', 'update', '1542072756');
INSERT INTO `zhimeng_operation_log` VALUES ('383', '2', 'Module', '{\"s\":\"\\/system\\/module\\/add.html\",\"title\":\"解决方案\",\"table\":\"cases\",\"desc\":\"解决方案\",\"seo_status\":\"0\",\"category_status\":\"0\",\"category_alias\":\"\",\"dialogid\":\"dialogid0.5758200621491623\",\"update_time\":\"2018-11-13 15:48:08\",\"create_time\":\"2018-11-13 15:48:08\",\"id\":\"8\"}', 'add', '1542095288');
INSERT INTO `zhimeng_operation_log` VALUES ('384', '2', 'Module', '{\"s\":\"\\/system\\/module\\/add.html\",\"title\":\"投稿通道\",\"table\":\"tougao\",\"desc\":\"投稿通道\",\"seo_status\":\"0\",\"category_status\":\"0\",\"category_alias\":\"\",\"dialogid\":\"dialogid0.8854099007262368\",\"update_time\":\"2018-11-14 09:49:11\",\"create_time\":\"2018-11-14 09:49:11\",\"id\":\"9\"}', 'add', '1542160151');
INSERT INTO `zhimeng_operation_log` VALUES ('385', '2', 'Product', '{\"title\":\"麦芽\",\"content\":\"354122311\",\"sort\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.005300844305962782\",\"create_time\":\"2018-11-14 09:56:01\",\"update_time\":\"2018-11-14 09:56:01\",\"id\":\"105\"}', 'add', '1542160561');
INSERT INTO `zhimeng_operation_log` VALUES ('386', '2', 'Product', '{\"title\":\"小琳\",\"content\":\"354112311\",\"sort\":\"1\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.11193768209460297\",\"create_time\":\"2018-11-14 10:00:34\",\"update_time\":\"2018-11-14 10:00:34\",\"id\":\"106\"}', 'add', '1542160834');
INSERT INTO `zhimeng_operation_log` VALUES ('387', '2', 'Product', '{\"title\":\"logo\",\"content\":\"41525733\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.5369900399227878\",\"create_time\":\"2018-11-14 10:01:37\",\"update_time\":\"2018-11-14 10:01:37\",\"id\":\"107\"}', 'add', '1542160897');
INSERT INTO `zhimeng_operation_log` VALUES ('388', '2', 'Product', '{\"title\":\"发的\",\"content\":\"发多少\",\"sort\":\"1\",\"is_recommend\":\"0\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.11595645672132138\",\"create_time\":\"2018-11-14 10:02:17\",\"update_time\":\"2018-11-14 10:02:17\",\"id\":\"108\"}', 'add', '1542160937');
INSERT INTO `zhimeng_operation_log` VALUES ('389', '2', 'Tougao', '{\"title\":\"地方\",\"image\":\"地方d\",\"content\":\"的\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.7319149306178421\",\"create_time\":\"2018-11-14 10:13:16\",\"update_time\":\"2018-11-14 10:13:16\",\"id\":\"1\"}', 'add', '1542161596');
INSERT INTO `zhimeng_operation_log` VALUES ('390', '2', 'Tougao', '{\"id\":\"1\",\"title\":\"地方反反复复\",\"image\":\"\",\"content\":\"的\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.16138483500622924\",\"update_time\":\"2018-11-14 10:13:28\"}', 'update', '1542161608');
INSERT INTO `zhimeng_operation_log` VALUES ('391', '2', 'Tougao', '{\"title\":\"有卖\",\"content\":\"3541123311\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.7707095270251727\",\"create_time\":\"2018-11-14 10:17:47\",\"update_time\":\"2018-11-14 10:17:47\",\"id\":\"2\"}', 'add', '1542161867');
INSERT INTO `zhimeng_operation_log` VALUES ('392', '2', 'Tougao', '{\"title\":\"地方\",\"content\":\"地方\",\"sort\":\"10\",\"is_seo\":\"0\",\"seo_title\":\"\",\"seo_keywords\":\"\",\"seo_desc\":\"\",\"dialogid\":\"dialogid0.9513386912475887\",\"create_time\":\"2018-11-14 10:20:36\",\"update_time\":\"2018-11-14 10:20:36\",\"id\":\"3\"}', 'add', '1542162036');
INSERT INTO `zhimeng_operation_log` VALUES ('393', '2', 'Tougao', '{\"title\":\"关于我们\",\"content\":\"2552\",\"sort\":\"1\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.11291690165842194\",\"create_time\":\"2018-11-14 10:23:52\",\"update_time\":\"2018-11-14 10:23:52\",\"id\":\"4\"}', 'add', '1542162232');
INSERT INTO `zhimeng_operation_log` VALUES ('394', '2', 'Tougao', '{\"id\":\"4\",\"title\":\"麦芽\",\"content\":\"354112311\",\"sort\":\"1\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.253037205392193\",\"update_time\":\"2018-11-14 10:24:36\"}', 'update', '1542162276');
INSERT INTO `zhimeng_operation_log` VALUES ('395', '2', 'Tougao', '{\"title\":\"面包\",\"content\":\"354112311\",\"sort\":\"1\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.18862534804458142\",\"create_time\":\"2018-11-14 10:24:50\",\"update_time\":\"2018-11-14 10:24:50\",\"id\":\"5\"}', 'add', '1542162290');
INSERT INTO `zhimeng_operation_log` VALUES ('396', '2', 'Tougao', '{\"title\":\"橘子\",\"content\":\"354113111\",\"sort\":\"1\",\"is_recommend\":\"0\",\"dialogid\":\"dialogid0.21861090925855287\",\"create_time\":\"2018-11-14 10:25:00\",\"update_time\":\"2018-11-14 10:25:00\",\"id\":\"6\"}', 'add', '1542162300');
INSERT INTO `zhimeng_operation_log` VALUES ('397', '2', 'RoleNav', '{\"s\":\"\\/system\\/role_nav\\/addrolenav.html\",\"pid\":\"2\",\"name\":\"用户\",\"class_name\":\".icon-user\",\"status\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.2894353794984639\",\"create_time\":\"2018-11-14 13:40:46\",\"update_time\":\"1970-01-01 08:33:38\",\"id\":\"40\"}', 'add', '1542174046');
INSERT INTO `zhimeng_operation_log` VALUES ('398', '2', 'RoleNode', '{\"nav_id\":\"40\",\"action\":\"index\",\"action_name\":\"用户\",\"module\":\"Member\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"1\",\"dialogid\":\"dialogid0.5246107786457122\",\"create_time\":\"2018-11-14 13:41:50\",\"update_time\":\"2018-11-14 13:41:50\",\"id\":\"707\"}', 'add', '1542174110');
INSERT INTO `zhimeng_operation_log` VALUES ('399', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"轮播展示\",\"action_name\":\"lunbo\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.812911985186807\",\"create_time\":\"2018-11-15 10:24:02\",\"update_time\":\"2018-11-15 10:24:02\",\"id\":\"708\"}', 'add', '1542248642');
INSERT INTO `zhimeng_operation_log` VALUES ('400', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"lunbo\",\"action_name\":\"轮播展示\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.995858776586793\",\"update_time\":\"2018-11-15 10:24:38\"}', 'update', '1542248678');
INSERT INTO `zhimeng_operation_log` VALUES ('401', '2', 'RoleNode', '{\"nav_id\":\"33\",\"action\":\"recommend\",\"action_name\":\"编辑力荐\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.7814879655617637\",\"create_time\":\"2018-11-15 10:43:09\",\"update_time\":\"2018-11-15 10:43:09\",\"id\":\"709\"}', 'add', '1542249789');
INSERT INTO `zhimeng_operation_log` VALUES ('402', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"recommend\",\"action_name\":\"编辑力荐\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.8021423731965971\",\"create_time\":\"2018-11-15 10:45:49\",\"update_time\":\"2018-11-15 10:45:49\",\"id\":\"710\"}', 'add', '1542249949');
INSERT INTO `zhimeng_operation_log` VALUES ('403', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"fine\",\"action_name\":\"精品推荐\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.3659410405179915\",\"create_time\":\"2018-11-15 11:25:42\",\"update_time\":\"2018-11-15 11:25:42\",\"id\":\"711\"}', 'add', '1542252342');
INSERT INTO `zhimeng_operation_log` VALUES ('404', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"original\",\"action_name\":\"原创新品\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.3659410405179915\",\"create_time\":\"2018-11-15 11:26:15\",\"update_time\":\"2018-11-15 11:26:15\",\"id\":\"712\"}', 'add', '1542252375');
INSERT INTO `zhimeng_operation_log` VALUES ('405', '2', 'RoleNode', '{\"nav_id\":\"36\",\"action\":\"okami\",\"action_name\":\"大神专区\",\"module\":\"Book\",\"status\":\"1\",\"is_show\":\"1\",\"sort\":\"2\",\"dialogid\":\"dialogid0.3659410405179915\",\"create_time\":\"2018-11-15 11:26:48\",\"update_time\":\"2018-11-15 11:26:48\",\"id\":\"713\"}', 'add', '1542252408');

-- ----------------------------
-- Table structure for zhimeng_oss
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_oss`;
CREATE TABLE `zhimeng_oss` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(20) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `desc` varchar(200) DEFAULT NULL,
  `value` text,
  `status` int(1) NOT NULL DEFAULT '1',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='云存储表';

-- ----------------------------
-- Records of zhimeng_oss
-- ----------------------------
INSERT INTO `zhimeng_oss` VALUES ('2', 'aliyun', '阿里云存储', '阿里云存储 https://www.aliyun.com/product/oss/', '{\"AccessKeyID\":\"LTAIPwLN0ipGGmdu\",\"AccessKeySecret\":\"8t72DPAEzSW6FnIIi9zBxSWazGYMOb\",\"Endpoint\":\"oss-cn-shenzhen.aliyuncs.com\",\"Bucket\":\"ivears-aliyun-test\",\"DOMAIN\":\"http:\\/\\/ivears-aliyun-test.oss-cn-shenzhen.aliyuncs.com\\/\",\"local_file_save\":\"0\"}', '0', '1522954269');
INSERT INTO `zhimeng_oss` VALUES ('4', 'qiniu', '七牛云存储', '七牛云存储 https://www.qiniu.com/', '{\"accessKey\":\"bwjmRZOk6WnXrVOkb7ELwC1jpdL4OWoLE9aZXZ_l\",\"secretKey\":\"2R-vShgf6c8BaClHUhL_1q41hnc-v6rPuetGm9-l\",\"ENDPOINT\":\"opxwfh924.bkt.clouddn.com\",\"Bucket\":\"ttddcc\",\"DOMAIN\":\"\",\"local_file_save\":\"0\"}', '0', '1523006585');
INSERT INTO `zhimeng_oss` VALUES ('5', 'local', '本地储存', '本地数据储存', null, '1', null);

-- ----------------------------
-- Table structure for zhimeng_product
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_product`;
CREATE TABLE `zhimeng_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT '文章分类ID',
  `image` varchar(500) DEFAULT NULL,
  `title` varchar(50) NOT NULL COMMENT '文章标题',
  `content` text NOT NULL COMMENT '文章内容',
  `is_seo` int(1) DEFAULT '0' COMMENT '是否开启自定义SEO信息,0为不开启,1为开启',
  `seo_title` varchar(255) DEFAULT NULL COMMENT 'seo标题',
  `seo_keywords` varchar(500) DEFAULT NULL COMMENT 'seo关键词',
  `seo_desc` varchar(1000) DEFAULT NULL COMMENT 'seo描述 ',
  `click` int(10) NOT NULL DEFAULT '0' COMMENT '点击数',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否审核',
  `is_recommend` int(1) DEFAULT '0' COMMENT ' 是否推荐,0为不推荐,1为推荐',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `images` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='产品表';

-- ----------------------------
-- Records of zhimeng_product
-- ----------------------------
INSERT INTO `zhimeng_product` VALUES ('103', '13', '', '3434343', 'asdf', '0', '', '', '', '0', '1', '1', '1', '1523524615', '1525439385', null);
INSERT INTO `zhimeng_product` VALUES ('105', '0', null, '麦芽', '354122311', '0', '', '', '', '0', '1', '1', '0', '1542160561', '1542160561', null);
INSERT INTO `zhimeng_product` VALUES ('106', '0', null, '小琳', '354112311', '0', '', '', '', '0', '1', '1', '0', '1542160834', '1542160834', null);
INSERT INTO `zhimeng_product` VALUES ('107', '0', null, 'logo', '41525733', '0', '', '', '', '0', '1', '1', '0', '1542160897', '1542160897', null);
INSERT INTO `zhimeng_product` VALUES ('108', '0', null, '发的', '发多少', '0', '', '', '', '0', '1', '1', '0', '1542160937', '1542160937', null);

-- ----------------------------
-- Table structure for zhimeng_read_record
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_read_record`;
CREATE TABLE `zhimeng_read_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL COMMENT '用户id',
  `b_id` int(11) NOT NULL COMMENT '书籍id',
  `chapter_id` int(11) NOT NULL COMMENT '章节id',
  `time` int(11) NOT NULL COMMENT '最后阅读时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhimeng_read_record
-- ----------------------------
INSERT INTO `zhimeng_read_record` VALUES ('1', '2', '29', '34', '1542009211');
INSERT INTO `zhimeng_read_record` VALUES ('2', '2', '30', '39', '1542073760');
INSERT INTO `zhimeng_read_record` VALUES ('3', '2', '32', '38', '1542009250');
INSERT INTO `zhimeng_read_record` VALUES ('4', '2', '1', '40', '1541488503');
INSERT INTO `zhimeng_read_record` VALUES ('5', '2', '31', '44', '1541662304');
INSERT INTO `zhimeng_read_record` VALUES ('6', '2', '3', '47', '1542009269');

-- ----------------------------
-- Table structure for zhimeng_reward
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_reward`;
CREATE TABLE `zhimeng_reward` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `b_id` int(11) DEFAULT NULL COMMENT '书id，如果整本购买则填写，否则不填写',
  `z_id` int(11) DEFAULT NULL COMMENT '章节id',
  `u_id` int(11) NOT NULL COMMENT '用户id',
  `price` int(11) NOT NULL COMMENT '价格（书币）',
  `status` int(11) DEFAULT '1' COMMENT '1：未购买整本。2：购买整本',
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='订阅表';

-- ----------------------------
-- Records of zhimeng_reward
-- ----------------------------
INSERT INTO `zhimeng_reward` VALUES ('34', '29', '36', '2', '5', '1', '1542009206');
INSERT INTO `zhimeng_reward` VALUES ('35', '32', null, '2', '300', '2', '1542009241');
INSERT INTO `zhimeng_reward` VALUES ('36', '3', '47', '2', '35', '1', '1542009269');
INSERT INTO `zhimeng_reward` VALUES ('37', '30', null, '2', '500', '2', '1542073760');

-- ----------------------------
-- Table structure for zhimeng_role
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_role`;
CREATE TABLE `zhimeng_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `status` smallint(2) NOT NULL DEFAULT '1' COMMENT '该用户组是否显示：0为不显示，1为显示',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of zhimeng_role
-- ----------------------------
INSERT INTO `zhimeng_role` VALUES ('1', '超级管理员', '1', '1523620278');
INSERT INTO `zhimeng_role` VALUES ('65', '普通管理员', '1', '1525925137');

-- ----------------------------
-- Table structure for zhimeng_role_access
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_role_access`;
CREATE TABLE `zhimeng_role_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '节点id',
  `node_id` smallint(6) unsigned NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=771 DEFAULT CHARSET=utf8 COMMENT='角色节点关系表';

-- ----------------------------
-- Records of zhimeng_role_access
-- ----------------------------
INSERT INTO `zhimeng_role_access` VALUES ('770', '65', '641');
INSERT INTO `zhimeng_role_access` VALUES ('769', '65', '577');
INSERT INTO `zhimeng_role_access` VALUES ('768', '65', '11');
INSERT INTO `zhimeng_role_access` VALUES ('767', '65', '2');
INSERT INTO `zhimeng_role_access` VALUES ('766', '65', '691');
INSERT INTO `zhimeng_role_access` VALUES ('765', '65', '690');
INSERT INTO `zhimeng_role_access` VALUES ('764', '65', '689');
INSERT INTO `zhimeng_role_access` VALUES ('763', '65', '688');
INSERT INTO `zhimeng_role_access` VALUES ('762', '65', '667');
INSERT INTO `zhimeng_role_access` VALUES ('761', '65', '666');
INSERT INTO `zhimeng_role_access` VALUES ('760', '65', '665');
INSERT INTO `zhimeng_role_access` VALUES ('759', '65', '642');
INSERT INTO `zhimeng_role_access` VALUES ('758', '65', '30');
INSERT INTO `zhimeng_role_access` VALUES ('757', '65', '664');
INSERT INTO `zhimeng_role_access` VALUES ('756', '65', '663');
INSERT INTO `zhimeng_role_access` VALUES ('755', '65', '662');
INSERT INTO `zhimeng_role_access` VALUES ('754', '65', '661');
INSERT INTO `zhimeng_role_access` VALUES ('753', '65', '660');
INSERT INTO `zhimeng_role_access` VALUES ('752', '65', '659');
INSERT INTO `zhimeng_role_access` VALUES ('751', '65', '637');
INSERT INTO `zhimeng_role_access` VALUES ('750', '65', '638');
INSERT INTO `zhimeng_role_access` VALUES ('749', '65', '29');
INSERT INTO `zhimeng_role_access` VALUES ('748', '65', '5');
INSERT INTO `zhimeng_role_access` VALUES ('747', '65', '630');
INSERT INTO `zhimeng_role_access` VALUES ('746', '65', '16');
INSERT INTO `zhimeng_role_access` VALUES ('745', '65', '4');

-- ----------------------------
-- Table structure for zhimeng_role_nav
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_role_nav`;
CREATE TABLE `zhimeng_role_nav` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `pid` int(11) DEFAULT '0' COMMENT '父id',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '菜单启用及停用：1.启用，0.停用',
  `sort` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  `class_name` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL COMMENT '图标',
  `update_time` int(10) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- ----------------------------
-- Records of zhimeng_role_nav
-- ----------------------------
INSERT INTO `zhimeng_role_nav` VALUES ('1', '3', '帐户', '1', '1', 'icon-user', '/public/admin/default/images/login/role.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('2', '0', '内容管理', '1', '30', null, '', '1523619381', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('3', '0', '系统管理', '1', '100', null, '', '1523619381', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('4', '0', '控制台', '1', '10', null, '', '1523619381', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('5', '0', '扩展配置', '1', '20', null, '', '1523619381', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('11', '2', '产品', '0', '3', 'icon-product', '/public/admin/default/images/login/setting.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('12', '2', '资讯', '0', '1', 'icon-news', '/public/admin/default/images/login/article.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('13', '3', '系统', '1', '0', 'icon-system', '/public/admin/default/images/login/setting.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('15', '1', '角色', '1', '10', null, '/public/admin/default/images/login/role.png', '1523619381', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('16', '4', '首页', '1', '10', 'icon-homepage', '/public/admin/default/images/login/home.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('28', '3', '接口', '1', '3', 'icon-itface', '/public/admin/default/images/login/jk.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('38', '2', '统计', '1', '1', '.icon-tongji', null, '2018', '1542007868');
INSERT INTO `zhimeng_role_nav` VALUES ('40', '2', '用户', '1', '1', '.icon-user', null, '2018', '1542174046');
INSERT INTO `zhimeng_role_nav` VALUES ('30', '5', '链接', '1', '2', 'icon-link', '/public/admin/default/images/login/ad.png', '2018', '1523619381');
INSERT INTO `zhimeng_role_nav` VALUES ('33', '2', '单页', '1', '2', 'icon-news', null, '2018', '1525195190');
INSERT INTO `zhimeng_role_nav` VALUES ('35', '2', '扩展', '1', '5', 'icon-itface', null, '2018', '1527164950');
INSERT INTO `zhimeng_role_nav` VALUES ('36', '2', '书库', '1', '1', '.icon-wenzhang', null, '2018', '1540260484');
INSERT INTO `zhimeng_role_nav` VALUES ('37', '2', '广告管理', '1', '2', '.icon-ad', null, '2018', '1541735058');

-- ----------------------------
-- Table structure for zhimeng_role_node
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_role_node`;
CREATE TABLE `zhimeng_role_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '节点ID',
  `action` varchar(60) NOT NULL DEFAULT '' COMMENT '节点控制器',
  `action_name` varchar(60) NOT NULL DEFAULT '' COMMENT '节点控制器名称',
  `module` varchar(60) NOT NULL DEFAULT '' COMMENT '节点模型',
  `nav_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属菜单ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '节点是否可用:0为禁用,1为启用',
  `sort` smallint(6) NOT NULL DEFAULT '0' COMMENT '节点排序',
  `auth_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '授权模式：1:模块授权(module) 2:操作授权(action) 0:节点授权(node)',
  `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否菜单显示:0.不显示,1.显示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=714 DEFAULT CHARSET=utf8 COMMENT='节点表';

-- ----------------------------
-- Records of zhimeng_role_node
-- ----------------------------
INSERT INTO `zhimeng_role_node` VALUES ('454', 'index', '帐号列表', 'System', '1', '1', '0', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('38', 'index', '角色列表', 'Role', '1', '1', '10', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('527', 'addRole', '添加角色', 'Role', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('528', 'editRole', '编缉角色', 'Role', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('529', 'doDelete', '删除角色', 'Role', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('530', 'pageAddAdmin', '添加帐号', 'System', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('531', 'pageEditAdmin', '编缉帐号', 'System', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('532', 'doDelete', '删除帐号', 'System', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('533', 'index', '后台菜单', 'RoleNav', '13', '1', '3', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('534', 'index', ' 授权配置', 'RoleNode', '3', '1', '3', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('535', 'add', '添加后台菜单', 'RoleNav', '3', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('536', 'edit', '编缉后台菜单', 'RoleNav', '3', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('537', 'do ', '删除后台菜单', 'RoleNav', '3', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('538', 'add', '添加授权配置', 'RoleNode', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('539', 'edit', '编缉授权配置', 'RoleNode', '1', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('629', 'main', '首页', 'Index', '0', '1', '0', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('544', 'Cache', '清除缓存', 'Setting', '13', '1', '1000', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('573', 'index', '全局设置', 'Setting', '13', '1', '0', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('575', 'index', '模型管理', 'Module', '13', '1', '2', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('576', 'index', '新闻资讯', 'Article', '2', '1', '0', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('577', 'index', '产品中心', 'Product', '11', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('578', 'main', '欢迎页面', 'Index', '4', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('579', 'index', '支付方式管理', 'Paytype', '197', '0', '4', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('580', 'index', '单页管理', 'Page', '2', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('581', 'loglist', '登录日志', 'System', '1', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('582', 'index', '登录插件管理', 'Authorization', '197', '0', '1', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('583', 'index', '邮件管理配置', 'Mails', '197', '0', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('584', 'index', '友情链接管理', 'Links', '197', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('585', 'index', '图片轮换管理', 'Banner', '197', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('586', 'index', '菜单管理', 'Weixin', '198', '0', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('587', 'WeixinSetting', '公众号配置', 'Weixin', '198', '0', '1', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('588', 'UserList', '用户管理 ', 'Weixin', '198', '0', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('589', 'index', '短信模块配置', 'Sms', '197', '0', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('590', 'index', '留言信息管理', 'Message', '197', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('592', 'imageSetting', '图片设置', 'Setting', '3', '1', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('609', 'index', '会员列表', 'Users', '199', '0', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('610', 'index', '订单列表', 'Orders', '200', '0', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('611', 'index', '商家管理', 'Business', '201', '0', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('612', 'index', '标签管理', 'Tags', '2', '0', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('613', 'categoryindex', '标签库分类', 'Tags', '2', '0', '0', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('614', 'index', '文件下载', 'Download', '2', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('621', 'index', '商品管理', 'Goods', '202', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('622', 'index', '商品类型', 'GoodsType', '202', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('630', 'main', '欢迎页', 'Index', '16', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('634', 'index', '存储配置', 'Oss', '28', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('635', 'staticCache', '缓存设置', 'Setting', '13', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('636', 'index', '模板设置', 'Template', '13', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('637', 'postion', '广告位置', 'AdPostion', '29', '1', '1', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('638', 'lists', '广告列表', 'Ad', '29', '1', '0', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('639', 'index', '资讯中心', 'Article', '12', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('640', 'CategoryIndex', '分类管理', 'Article', '12', '1', '200', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('641', 'CategoryIndex', '分类管理', 'Product', '11', '1', '200', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('642', 'index', '友情链接', 'Links', '30', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('644', 'imgset', '上传设置', 'Setting', '13', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('645', 'codeset', '验证设置', 'Setting', '13', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('658', 'index', '单页管理', 'Webpage', '33', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('659', 'add', '添加广告', 'Ad', '29', '1', '1', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('660', 'edit', '编缉广告', 'Ad', '29', '1', '2', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('661', 'do', '删除广告', 'Ad', '29', '1', '3', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('662', 'add', '添加广告位', 'AdPostion', '29', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('663', 'edit', '编缉广告位', 'AdPostion', '29', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('664', 'do', '删除广告位', 'AdPostion', '29', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('665', 'add', '添加友情链接', 'Links', '30', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('666', 'edit', '编缉友情链接', 'Links', '30', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('667', 'doDelete', '删除友情链接', 'Links', '30', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('668', 'categoryadd', '添加分类', 'Article', '12', '1', '201', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('669', 'CategoryEdit', '编缉分类', 'Article', '12', '1', '202', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('670', 'Category', '删除分类', 'Article', '12', '1', '203', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('671', 'add', '添加资讯', 'Article', '12', '1', '101', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('672', 'edit', '编缉资讯', 'Article', '12', '1', '102', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('673', 'do', '删除资讯', 'Article', '12', '1', '103', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('674', 'add', '添加单页', 'Webpage', '33', '1', '101', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('675', 'edit', '编缉单页', 'Webpage', '33', '1', '103', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('676', 'do', '删除单页', 'Webpage', '33', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('677', 'add', '添加产品', 'Product', '11', '1', '101', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('678', 'edit', '编缉产品', 'Product', '11', '1', '102', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('679', 'do', '删除产品', 'Product', '11', '1', '103', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('680', 'categoryadd', '添加分类', 'Product', '11', '1', '201', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('681', 'CategoryEdit', '编缉产分类', 'Product', '11', '1', '202', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('682', 'Category', '删除分类', 'Product', '11', '1', '203', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('688', 'index', '站内链接', 'SeoLinks', '30', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('689', 'add', '添加站内链接', 'SeoLinks', '30', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('690', 'edit', '编缉站内链接', 'SeoLinks', '30', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('691', 'doDelete', '删除站内链接', 'SeoLinks', '30', '1', '100', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('698', 'categoryindex', '分类', 'Book', '36', '1', '1', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('697', 'index', '书库', 'Book', '36', '1', '1', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('700', 'examine', '未审核章节', 'Book', '36', '1', '100', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('701', 'take', '订阅', 'Income', '38', '1', '10', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('702', 'reward', '打赏', 'Income', '38', '1', '10', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('706', 'categoryindex', '分类管理', 'Tougao', '35', '0', '300', '0', '0');
INSERT INTO `zhimeng_role_node` VALUES ('705', 'index', '投稿通道', 'Tougao', '35', '1', '300', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('707', 'index', '用户', 'Member', '40', '1', '1', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('708', 'lunbo', '轮播展示', 'Book', '36', '1', '2', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('711', 'fine', '精品推荐', 'Book', '36', '1', '2', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('710', 'recommend', '编辑力荐', 'Book', '36', '1', '2', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('712', 'original', '原创新品', 'Book', '36', '1', '2', '0', '1');
INSERT INTO `zhimeng_role_node` VALUES ('713', 'okami', '大神专区', 'Book', '36', '1', '2', '0', '1');

-- ----------------------------
-- Table structure for zhimeng_seo_links
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_seo_links`;
CREATE TABLE `zhimeng_seo_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '内链的文字 ',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT '内链的地址',
  `description` text COMMENT '链接描述',
  `target` int(1) DEFAULT '0' COMMENT '0为当前窗口打开，1为新窗口打开 ',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1正常,0禁用',
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COMMENT='站内链接-SEO内链';

-- ----------------------------
-- Records of zhimeng_seo_links
-- ----------------------------
INSERT INTO `zhimeng_seo_links` VALUES ('139', '艾威尔', 'http://www.ivears.com/', null, '0', '1', '1525921760', '1525925087');
INSERT INTO `zhimeng_seo_links` VALUES ('140', '百度', 'http://www.baidu.com/', null, '1', '1', '1525921775', '1525943662');

-- ----------------------------
-- Table structure for zhimeng_sms
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_sms`;
CREATE TABLE `zhimeng_sms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alias` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL,
  `value` varchar(500) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='短信接口表 ';

-- ----------------------------
-- Records of zhimeng_sms
-- ----------------------------
INSERT INTO `zhimeng_sms` VALUES ('1', 'aliyun', '阿里云短信', '阿里云短信：https://www.aliyun.com/product/sms', '{\"accessKeyId\":\"LTAIiIWyPINcBOih\",\"accessKeySecret\":\"C5J86lpDFxSoJXkPmRkE51wWQ5tAKb\",\"signName\":\"\\u827e\\u5a01\\u5c14\\u7f51\\u7edc\"}', '1', '1524739972');
INSERT INTO `zhimeng_sms` VALUES ('4', 'ucpaas', '云之讯短信', '云之讯短信：http://www.ucpaas.com/login', '{\"appid\":\"0b76ae69a7544dcfa902e986d4832d57\",\"accountsid\":\"5c8dc561283a85cbeea0e561c60c4b9d\",\"token\":\"b6bd96a814f081daede8dfffd83fd5dc\"}', '0', '1524713903');
INSERT INTO `zhimeng_sms` VALUES ('5', 'netease', '网易云短信', '网易云短信：http://netease.im/sms', '{\"APP_KEY\":\"be6428ba568d59fcc7e4e34974750b95\",\"APP_SECRET\":\"64516e69c730\"}', '0', '1524714130');

-- ----------------------------
-- Table structure for zhimeng_take
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_take`;
CREATE TABLE `zhimeng_take` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL,
  `b_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='关注，书架';

-- ----------------------------
-- Records of zhimeng_take
-- ----------------------------
INSERT INTO `zhimeng_take` VALUES ('39', '2', '29');
INSERT INTO `zhimeng_take` VALUES ('40', '2', '30');
INSERT INTO `zhimeng_take` VALUES ('41', '2', '27');

-- ----------------------------
-- Table structure for zhimeng_tougao
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_tougao`;
CREATE TABLE `zhimeng_tougao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `title` varchar(500) NOT NULL,
  `content` text NOT NULL,
  `sort` int(1) DEFAULT '0',
  `status` int(1) DEFAULT '1',
  `click` int(11) DEFAULT '0',
  `is_recommend` int(1) DEFAULT '0',
  `is_seo` int(1) DEFAULT '0',
  `seo_title` varchar(200) DEFAULT NULL,
  `seo_keywords` varchar(200) DEFAULT NULL,
  `seo_desc` varchar(200) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of zhimeng_tougao
-- ----------------------------
INSERT INTO `zhimeng_tougao` VALUES ('4', null, '麦芽', '354112311', '1', '1', '0', '0', '0', null, null, null, '1542162232', '1542162276');
INSERT INTO `zhimeng_tougao` VALUES ('5', null, '面包', '354112311', '1', '1', '0', '0', '0', null, null, null, '1542162290', '1542162290');
INSERT INTO `zhimeng_tougao` VALUES ('6', null, '橘子', '354113111', '1', '1', '0', '0', '0', null, null, null, '1542162300', '1542162300');

-- ----------------------------
-- Table structure for zhimeng_webpage
-- ----------------------------
DROP TABLE IF EXISTS `zhimeng_webpage`;
CREATE TABLE `zhimeng_webpage` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章分类ID',
  `image` varchar(300) DEFAULT NULL,
  `title` varchar(100) NOT NULL COMMENT '标题',
  `keyword` varchar(100) NOT NULL COMMENT '关键词',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父ID',
  `content` text NOT NULL COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示',
  `is_seo` int(1) DEFAULT '0',
  `seo_title` varchar(200) DEFAULT NULL,
  `seo_keywords` varchar(300) DEFAULT NULL,
  `seo_desc` varchar(1000) DEFAULT NULL,
  `click` int(11) DEFAULT '0' COMMENT '点击次数',
  `sort` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COMMENT='单页面';

-- ----------------------------
-- Records of zhimeng_webpage
-- ----------------------------
INSERT INTO `zhimeng_webpage` VALUES ('179', '', '关于我们', '', '186', '<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	绾书文学网是新兴的原创阅读与创作平台。隶属于文心科技有限公司，成立于2018年4月。具有雄厚的实力，顶尖的团队，目前与众多的第三方平台、新媒体平台无线版权运营机构具有深度合作。主要提供在线阅读、无线阅读、动漫改编、影视改编、游戏改编、实体出版服务等业务。培育自有内容IP化，将内容产品推向影视市场，向社会输出各种精品版权，实现版权价值最大化。\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	绾书文学网长期致力于原创文学作者的挖掘与培养，尽力为每位作者打造一条属于他的成神之路，同时致力于打造社交化阅读平台，为读者提供良好的阅读体验。绾书绾书，以书为绳，将作者与读者紧密连在一起。让每位作者更加了解读者的兴趣点，让每位读者更有机会表现对作者的支持。\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	绾书是个萌新，但我们终会成长！\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	绾书立志于成为中国原创阅读的重要一部分。绾书文学网真诚期待与各位作家以及版权运营商合作！\r\n</p>\r\n<div class=\"dot-line\" style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n</div>\r\n<h6 style=\"font-size:16px;font-weight:400;color:#333333;font-family:PingFangSC-Regular, &quot;background-color:#FFFFFF;\">\r\n	重要提示：\r\n</h6>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	本网站为网友写作提供上传空间储存平台，请上传有合法版权的作品，如发现本站有侵犯权利人版权内容的，请联系客服向本站投诉，一经核实，本站将立即删除相关作品并对上传人ID账号作封号处理。\r\n</p>', '1', '0', '', '', '', '0', '10', '2017', '1541658193');
INSERT INTO `zhimeng_webpage` VALUES ('184', '', '联系我们', '', '186', '<h6 style=\"font-size:16px;font-weight:400;color:#333333;font-family:PingFangSC-Regular, &quot;background-color:#FFFFFF;\">\r\n	杭州文心网络科技有限公司\r\n</h6>\r\n<div style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	地址：中国（杭州）西湖区文二路391号西湖国际科技大厦B2座10楼\r\n</div>\r\n<div style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	电话：400-998-1236\r\n</div>', '1', '0', '', '', '', '0', '10', '1541658121', '1541658204');
INSERT INTO `zhimeng_webpage` VALUES ('185', '', '版权申明', '', '186', '<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	本站一贯高度重视知识产权保护并遵守中华人民共和国各项知识产权法律、法规和具有约束力的规范性文件,坚信著作权拥有者的合法权益应该得到尊重和依法保护。本站坚决反对任何违反中华人民共和国有关著作权的法律法规的行为。由于我们无法对用户上传到本网站的所有作品内容进行充分的监测，我们制定了旨在保护知识产权权利人合法权益的措施和步骤，当著作权人和/或依法可以行使信息网络传播权的权利人（以下简称\"权利人\"）发现本站上用户上传内容侵犯其信息网络传播权时，权利人应事先向本站发出权利通知，本站将根据相关法律规定采取措施删除相关内容。\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	在本站上传作品的用户视为同意本站上述及已采用的相应措施。本站不因此而承担任何违约责任或其他任何法律责任，包括不承担因侵权指控不成立而给原上传用户带来损害的赔偿责任。本站在收到上述通知后会通知上传该等作品的用户。对于多次上传涉嫌侵权作品的用户，我们将取消其用户资格。\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	绾书是个萌新，但我们终会成长！\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	绾书立志于成为中国原创阅读的重要一部分。绾书文学网真诚期待与各位作家以及版权运营商合作！\r\n</p>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	本站谢绝任何不符合本站原创文学发展方向的作品。任何在未征得原作者或本站同意，请不要转载本站作品内容，违者自负法律责任！如欲转载本站发表之原创作品，必须请作者或本站联系并取得书面许可，并且在转载时应保留本站信息。\r\n</p>\r\n<div class=\"dot-line\" style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n</div>\r\n<h6 style=\"font-size:16px;font-weight:400;color:#333333;font-family:PingFangSC-Regular, &quot;background-color:#FFFFFF;\">\r\n	免责条款：\r\n</h6>\r\n<p style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	本网站使用者因为违反本条款的规定而触犯中华人民共和国法律的，一切后果自己负责，本网站不承担任何责任。\r\n</p>\r\n<div style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	1、凡有本网用户未经作者许可，在本网站内上传作品，本网站对用户上传行为不负任何责任。\r\n</div>\r\n<div style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	2、若因本网站产生任何诉诸于诉讼程序的法律争议，将以本网站所有者所在的法院为管辖法院，除非中国法律对此有强制性规定。\r\n</div>\r\n<div style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	3、本网站之服务条款及其修改权、更新权及最终解释权均属本网站所有。\r\n</div>\r\n<div style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	4、以上网站条款于公布之日生效，访问者须仔细阅读并同意本条款。访问者对本网站包括但不限于的访问浏览、利用、上传、转载、宣传、链接等，均视为访问者同意本网站免责条款。\r\n</div>\r\n<div class=\"dot-line\" style=\"color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n</div>\r\n<div class=\"bottom\" style=\"text-align:right;color:#666666;font-family:PingFangSC-Regular, &quot;font-size:14px;background-color:#FFFFFF;\">\r\n	<div>\r\n		绾书文学网\r\n	</div>\r\n	<div>\r\n		https://www.wanshu.com\r\n	</div>\r\n	<div>\r\n		2018年4月16日\r\n	</div>\r\n</div>', '1', '0', '', '', '', '0', '10', '1541658148', '1541658199');
INSERT INTO `zhimeng_webpage` VALUES ('186', '', '关于我们', '', '0', '', '1', '0', '', '', '', '0', '10', '1541658182', '1541658182');
INSERT INTO `zhimeng_webpage` VALUES ('187', '', '用户协议', '', '0', '<h2 class=\"text-center\" style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;text-align:center;font-family:PingFangSC-Regular, &quot;\">\r\n	用户协议\r\n</h2>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	本《用户协议》是您(下称\"用户\")与杭州文心网络科技有限公司(下称“文心网络科技”)之间在使用文心网络科技出品的各类产品之前，注册用户(又名“帐号”，下统称“帐号”)在使用产品时签署的协议。\r\n</p>\r\n<h3 style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\">\r\n	一、重要须知---在签署本协议之前，文心网络科技正式提醒用户：\r\n</h3>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	1.1 您应认真阅读(未成年人应当在监护人陪同下阅读)、充分理解本《用户协议》中各条款，特别是免除或者限制文心网络科技责任的免责条款，用户的权利限制条款，约定争议解决方式、司法管辖、法律适用的条款。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	1.2 除非您接受本协议，否则用户无权也无必要继续接受文心网络科技的服务，可以退出本次注册。用户点击接受并继续使用文心网络科技的服务，视为用户已完全的接受本协议。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	1.3 本协议在您开始使用文心网络科技的服务，并注册成为文心网络科技产品的用户时即产生法律效力，请您慎重考虑是否接受本协议，如不接受本协议的任一条款，请自动退出并不再接受文心网络科技的任何服务。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	1.4 在您签署本协议之后，此文本可能因国家政策、产品以及履行本协议的环境发生变化而进行修改，我们会将修改后的协议发布在本网站上，若您对修改后的协议有异议的，请立即停止登录、使用文心网络科技产品及服务，若您登录或继续使用文心网络科技产品，视为认可修改后的协议。\r\n</p>\r\n<h3 style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\">\r\n	二、关于“帐号”及“付费会员”资格\r\n</h3>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2.1 文心网络科技在旗下业务平台（包括但不限于绾书文学网）提供用户注册通道，用户在认可并接受本协议之后，有权选择未被其他用户使用过的字母符号组合作为用户的帐号，并自行设置符合安全要求的密码。用户设置的帐号、密码是用户用以登录文心网络科技产品，接受文心网络科技服务的凭证。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	1) 用户可通过各种已有和未来新增的渠道注册账号及加入付费会员。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2) 在用户使用具体某种方式加入付费会员时，须阅读并确认相关的用户协议和使用方法。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3) 用户通过网络填写并提交注册表，表中所填写的内容与个人资料必须真实有效，否则文心网络科技有权拒绝其申请或撤销其账号或付费会员资格，并不予任何赔偿或退还会员费。用户的个人资料发生变化，应及时修改相关资料，否则由此造成的会员权力不能全面有效行使的责任由会员自己承担，文心网络科技有权因此取消其会员资格，并不予任何赔偿或退还会员费。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4) 成为付费会员后，会员有权利不接受文心网络科技的服务，可申请取消会员服务，但不获得任何服务费用的退还。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2.2 用户在注册了文心网络科技帐号并不意味获得全部文心网络科技产品的授权，仅仅是取得了接受文心网络科技服务的身份，用户在登录相关网页、加载应用、下载安装软件时需要另行签署单个产品的授权协议。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2.3 文心网络科技账户仅限于在文心网络科技网站上注册用户本人使用，禁止赠与、借用、租用、转让或售卖。如果文心网络科技发现或者有理由怀疑使用者并非帐号初始注册人，则有权在未经通知的情况下，暂停或终止向用户提供服务，并有权注销该帐号，而无需向该帐号使用人承担法律责任，由此带来的包括并不限于用户通讯中断、用户资料和信息等清空等损失由用户自行承担。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2.4 用户有责任维护个人帐号、密码的安全性与保密性，用户就其帐号及密码项下之一切活动负全部责任，包括用户数据的修改，发表的言论以及其他所有的损失。用户应重视文心网络科技帐号密码保护。用户如发现他人未经许可使用其帐号或发生其他任何安全漏洞问题时立即通知文心网络科技。如果用户在使用文心网络科技服务时违反上述规则而产生任何损失或损害，文心网络科技不承担任何责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2.5 用户帐号在丢失或遗忘密码后，可遵照文心网络科技的申诉途径及时申诉请求找回帐号。用户应提供能增加帐号安全性的个人密码保护资料。用户可以凭初始注册资料及个人密码保护资料填写申诉单向文心网络科技申请找回帐号，文心网络科技的密码找回机制仅负责识别申诉单上所填资料与系统记录资料的正确性，而无法识别申诉人是否系真正帐号有权使用人。对用户因被他人冒名申诉而致的任何损失，文心网络科技不承担任何责任，用户知晓帐号及密码保管责任在于用户，文心网络科技并无义务保证帐号丢失或遗忘密码后用户一定能通过申诉找回帐号。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2.6 用户应保证注册文心网络科技帐号时填写的身份信息的真实性，任何由于非法、不真实、不准确的用户信息所产生的责任由用户承担。用户应不断根据实际情况更新注册资料，符合及时、详尽、真实、准确的要求。所有原始键入的资料将引用用户的帐号注册资料。如果因用户的注册信息不真实而引起的问题，以及对问题发生所带来的后果，文心网络科技不负任何责任。如果用户提供的信息不准确、不真实、不合法或者文心网络科技有理由怀疑为错误、不实或不完整的资料或在个人资料中发布广告、不严肃内容及无关信息，文心网络科技有权暂停或终止向用户提供服务，注销该帐号，并拒绝用户现在和未来使用文心网络科技服务之全部或任何部分。因此产生的一切损失由用户自行承担。\r\n</p>\r\n<h3 style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\">\r\n	三、用户在使用文心网络科技产品时，应当遵守《中华人民共和国宪法》、《中华人民共和国刑法》、《中华人民共和国民法通则》、《中华人民共和国合同法》、《中华人民共和国著作权法》、《中华人民共和国电信条例》、《互联网信息服务管理办法》、《互联网电子公告服务管理规定》、《计算机信息网络国际互联网安全保护管理办法》等相关规定。用户不得利用文心网络科技服务产品从事违反法律法规、政策以及侵犯他人合法权益的行为，包括但不限于下列行为：\r\n</h3>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3.1 利用文心网络科技服务产品发表、传送、传播、储存反对宪法所确定的基本原则的、危害国家安全、国家统一、社会稳定的、煽动民族仇恨、民族歧视、破坏民族团结的内容，或侮辱诽谤、色情、暴力、引起他人不安及任何违反国家法律法规政策的内容或者设置含有上述内容的网名、角色名。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3.2 利用文心网络科技服务发表、传送、传播、储存侵害他人知识产权、商业机密、肖像权、隐私权等合法权利或其他道德上令人反感的内容。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3.3 进行任何危害计算机网络安全的行为，包括但不限于：使用未经许可的数据或进入未经许可的服务器/帐户;未经允许进入公众计算机网络或者他人计算机系统并删除、修改、增加存储信息;未经许可，企图探查、扫描、测试本“软件”系统或网络的弱点或其它实施破坏网络安全的行为;企图干涉、破坏本“软件”系统或网站的正常运行，故意传播恶意程序或病毒以及其他破坏干扰正常网络信息服务的行为;伪造TCP/IP数据包名称或部分名称;自行或利用其他软件对文心网络科技提供产品进行反向破解等违法行为。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3.4 进行任何诸如发布广告、推广信息、销售商品的行为，或者进行任何非法的侵害文心网络科技利益的行为。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3.5 进行其他任何违法以及侵犯其他个人、公司、社会团体、组织的合法权益的行为或者法律、行政法规、规章、条例以及任何具有法律效力之规范所限制或禁止的其他行为。在任何情况下，如果文心网络科技有理由认为用户的任何行为，包括但不限于用户的任何言论和其它行为违反或可能违反法律法规、国家政策以及本协议的任何规定，文心网络科技可在任何时候不经任何事先通知，即有权终止向用户提供服务。\r\n</p>\r\n<h3 style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\">\r\n	四、文心网络科技声明\r\n</h3>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4.1 用户须知，在使用文心网络科技服务可能存在有来自任何他人的包括威胁性的、诽谤性的、令人反感的或非法的内容或行为或对他人权利的侵犯(包括知识产权)的匿名或冒名的信息的风险，用户须承担以上风险，文心网络科技对服务不作担保，不论是明确的或隐含的，包括所有有关信息真实性、适当性、适于某一特定用途、所有权和非侵权性的默示担保和条件，对因此导致任何因用户不正当或非法使用服务产生的直接、间接、偶然、特殊及后续的损害，文心网络科技不承担任何责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4.2 使用文心网络科技服务必须遵守国家有关法律和政策等，维护国家利益，保护国家安全，并遵守本协议，对于用户违法行为或违反本协议的使用(包括但不限于言论发表、传送等)而引起的一切责任，由用户承担全部责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4.3 文心网络科技提供的所有信息、资讯、内容和服务均来自互联网，并不代表文心网络科技的观点，文心网络科技对其真实性、合法性概不负责，亦不承担任何法律责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4.4 文心网络科技所提供的产品和服务也属于互联网范畴，也易受到各种安全问题的困扰，包括但不限于：\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	1)个人资料被不法分子利用，造成现实生活中的骚扰;\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	2)哄骗、破译密码;\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	3)下载安装的其它软件中含有“特洛伊木马”等病毒程序，威胁到个人计算机上信息和数据的安全，继而威胁对本服务的使用。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4）以及其他类网络安全困扰问题\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	对于发生上述情况的，用户应当自行承担责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4.5 用户须明白，文心网络科技为了整体运营的需要，有权在公告通知后，在不事先通知用户的情况下修改、中断、中止或终止服务，而无须向用户或第三方负责，文心网络科技不承担任何赔偿责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	4.6 用户应理解，互联网技术存在不稳定性，可能导致政府管制、政策限制、病毒入侵、黑客攻击、服务器系统崩溃或者其他现今技术无法解决的风险发生。由以上原因可能导致文心网络科技服务中断或帐号信息损失，对此非人为因素引起的用户损失由用户自行承担责任。\r\n</p>\r\n<h3 style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\">\r\n	五、知识产权\r\n</h3>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	5.1 文心网络科技对其旗下运营的网页、应用、软件等产品和服务享有知识产权。受中国法律的保护。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	5.2用户不得对文心网络科技服务涉及的相关网页、应用、软件等产品进行反向工程、反向汇编、反向编译等。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	5.3 用户只能在本《用户协议》以及相应的授权许可协议授权的范围内使用文心网络科技知识产权，未经授权超范围使用的，构成对文心网络科技的侵权。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	5.4 用户在使用文心网络科技产品服务时发表上传的文字、图片、视频、软件以及表演等信息，用户的发表、上传行为是对文心网络科技服务平台的授权，为非独占性、永久性的授权，该授权可转授权。文心网络科技可将前述信息在文心网络科技旗下的所有服务平台上使用，可再次编辑后使用，也可以由文心网络科技授权给合作方使用。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	5.5 用户应保证，在使用文心网络科技产品服务时上传的文字、图片、视频、软件以及表演等的信息不侵犯任何第三方知识产权，包括但不限于商标权、著作权等。若用户在使用文心网络科技产品服务时上传的文字、图片、视频、软件以及表演等的信息中侵犯第三方知识产权，文心网络科技有权移除该侵权产品，并对此不负任何责任。用户应当负责处理前述第三方的权利主张，承担由此产生的全部费用，包括但不限于侵权赔偿、律师费及其他合理费用，并保证文心网络科技不会因此而遭受任何损失。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	5.6 任何单位或个人认为通过文心网络科技提供服务的内容可能涉嫌侵犯其知识产权或信息网络传播权，应该及时向文心网络科技提出书面权利通知投诉，并提供身份证明、权属证明及详细侵权情况证明。文心网络科技在收到上述法律文件后，将会依法尽快断开相关链接内容。文心网络科技提供投诉通道，lisen@yiwei.com。如投诉中未向文心网络科技提供合法有效的证明材料，文心网络科技有权不采取任何措施。\r\n</p>\r\n<h3 style=\"color:rgba(0, 0, 0, 0.85);font-weight:500;font-family:PingFangSC-Regular, &quot;\">\r\n	六、隐私保护\r\n</h3>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	文心网络科技非常重视用户的隐私权，用户在享受文心网络科技提供的服务时可能涉及用户的隐私，因此请用户仔细阅读本隐私保护条款。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	6.1 请用户注意勿在使用文心网络科技服务中透露自己的各类财产帐户、银行卡、信用卡、第三方支付账户及对应密码等重要信息资料，否则由此带来的任何损失由用户自行承担。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	6.2 用户的帐号、密码属于保密信息，文心网络科技会努力采取积极的措施保护用户帐号、密码的安全。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	6.3 互联网的开放性以及技术更新速度快，因非文心网络科技可控制的因素导致用户信息泄漏的，文心网络科技不承担任何责任。\r\n</p>\r\n<p style=\"text-indent:2em;color:rgba(0, 0, 0, 0.65);font-family:PingFangSC-Regular, &quot;font-size:14px;\">\r\n	6.4 用户在使用文心网络科技服务时不应将自认为隐私的信息发表、上传至文心网络科技，也不应将该等信息通过文心网络科技的服务传播给其他人，由于用户的行为引起的隐私泄漏，由用户自行承担责任。\r\n</p>', '1', '0', '', '', '', '0', '10', '1541745658', '1541745658');
