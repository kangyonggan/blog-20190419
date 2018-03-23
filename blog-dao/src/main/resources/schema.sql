DROP DATABASE IF EXISTS blog;

CREATE DATABASE blog
  DEFAULT CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE blog;

-- ----------------------------
--  Table structure for tb_user
-- ----------------------------
DROP TABLE
IF EXISTS tb_user;

CREATE TABLE tb_user
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  username     VARCHAR(32)                           NOT NULL
  COMMENT '用户名',
  realname     VARCHAR(32)                           NOT NULL
  COMMENT '真实姓名',
  password     VARCHAR(64)                           NOT NULL
  COMMENT '密码',
  salt         VARCHAR(64)                           NOT NULL
  COMMENT '密码盐',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '用户表';
CREATE UNIQUE INDEX username_UNIQUE
  ON tb_user (username);

-- ----------------------------
--  Table structure for tb_role
-- ----------------------------
DROP TABLE
IF EXISTS tb_role;

CREATE TABLE tb_role
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         VARCHAR(32)                           NOT NULL
  COMMENT '角色代码',
  name         VARCHAR(32)                           NOT NULL
  COMMENT '角色名称',
  is_deleted   TINYINT                               NOT NULL                DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '角色表';
CREATE UNIQUE INDEX code_UNIQUE
  ON tb_role (code);

-- ----------------------------
--  Table structure for tb_menu
-- ----------------------------
DROP TABLE
IF EXISTS tb_menu;

CREATE TABLE tb_menu
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         VARCHAR(32)                           NOT NULL
  COMMENT '菜单代码',
  name         VARCHAR(32)                           NOT NULL
  COMMENT '菜单名称',
  pcode        VARCHAR(32)                           NOT NULL                DEFAULT ''
  COMMENT '父菜单代码',
  url          VARCHAR(128)                          NOT NULL                DEFAULT ''
  COMMENT '菜单地址',
  sort         INT(11)                               NOT NULL                DEFAULT 0
  COMMENT '菜单排序(从0开始)',
  icon         VARCHAR(128)                          NOT NULL                DEFAULT ''
  COMMENT '菜单图标的样式',
  is_deleted   TINYINT                               NOT NULL                DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '菜单表';
CREATE INDEX sort_ix
  ON tb_menu (sort);
CREATE UNIQUE INDEX code_UNIQUE
  ON tb_menu (code);

-- ----------------------------
--  Table structure for tb_user_role
-- ----------------------------
DROP TABLE
IF EXISTS tb_user_role;

CREATE TABLE tb_user_role
(
  username  VARCHAR(32) NOT NULL
  COMMENT '用户名',
  role_code VARCHAR(32) NOT NULL
  COMMENT '角色代码',
  PRIMARY KEY (username, role_code)
)
  COMMENT '用户角色表';

-- ----------------------------
--  Table structure for rtb_ole_menu
-- ----------------------------
DROP TABLE
IF EXISTS tb_role_menu;

CREATE TABLE tb_role_menu
(
  role_code VARCHAR(32) NOT NULL
  COMMENT '角色代码',
  menu_code VARCHAR(32) NOT NULL
  COMMENT '菜单代码',
  PRIMARY KEY (role_code, menu_code)
)
  COMMENT '角色菜单表';

-- ----------------------------
--  Table structure for tb_category
-- ----------------------------
DROP TABLE
IF EXISTS tb_category;

CREATE TABLE tb_category
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         VARCHAR(32)                           NOT NULL
  COMMENT '栏目代码',
  name         VARCHAR(32)                           NOT NULL
  COMMENT '栏目名称',
  type         VARCHAR(16)                           NOT NULL
  COMMENT '栏目类型',
  sort         INT(11)                               NOT NULL                    DEFAULT 0
  COMMENT '栏目排序(从0开始)',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '栏目表';
CREATE UNIQUE INDEX code_type_UNIQUE
  ON tb_category (code, type);
CREATE INDEX id_type
  ON tb_category (type);

-- ----------------------------
--  Table structure for tb_article
-- ----------------------------
DROP TABLE
IF EXISTS tb_article;

CREATE TABLE tb_article
(
  id            BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  title         VARCHAR(64)                           NOT NULL
  COMMENT '文章标题',
  summary       VARCHAR(128)                          NOT NULL
  COMMENT '摘要',
  category_code VARCHAR(32)                           NOT NULL
  COMMENT '栏目代码',
  content       LONGTEXT                              NOT NULL
  COMMENT '文章内容',
  is_top        TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '是否推荐:{0:不推荐, 1:推荐}',
  is_deleted    TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '文章表';
CREATE INDEX id_category_code
  ON tb_article (category_code);

-- ----------------------------
--  Table structure for tb_attachment
-- ----------------------------
DROP TABLE
IF EXISTS tb_attachment;

CREATE TABLE tb_attachment
(
  id                BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  type              VARCHAR(16)                           NOT NULL
  COMMENT '附件类型',
  source_id         BIGINT(20)                            NOT NULL
  COMMENT '附件来源',
  url               VARCHAR(256)                          NOT NULL
  COMMENT '附件地址',
  original_filename VARCHAR(128)                          NOT NULL                    DEFAULT ''
  COMMENT '附件原名',
  is_deleted        TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time      TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time      TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '附件表';
CREATE INDEX id_type_source_id
  ON tb_attachment (type, source_id);

-- ----------------------------
--  Table structure for tb_tool
-- ----------------------------
DROP TABLE
IF EXISTS tb_tool;

CREATE TABLE tb_tool
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         VARCHAR(32)                           NOT NULL
  COMMENT '工具代码',
  name         VARCHAR(32)                           NOT NULL
  COMMENT '工具名称',
  icon         VARCHAR(64)                           NOT NULL
  COMMENT '图标',
  is_top       TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '是否推荐:{0:不推荐, 1:推荐}',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '工具表';
CREATE UNIQUE INDEX code_UNIQUE
  ON tb_tool (code);
#====================初始数据====================#

-- ----------------------------
--  data for tb_user
-- ----------------------------
INSERT INTO tb_user
(username, realname, password, salt)
VALUES
  # 用户 admin 密码 111111
  ('admin', '管理员', '25500f5b85a66895e0b99117a12cd51b6d07eb13', '93fab0ba521763fc');

-- ----------------------------
--  data for tb_role
-- ----------------------------
INSERT INTO tb_role
(code, name)
VALUES
  ('ROLE_ADMIN', '管理员'),
  ('ROLE_USER', '普通用户');

-- ----------------------------
--  data for tb_menu
-- ----------------------------
INSERT INTO tb_menu
(code, name, pcode, url, sort, icon)
VALUES
  ('DASHBOARD', '工作台', '', 'index', 0, 'menu-icon fa fa-dashboard'),

  ('SYSTEM', '系统', 'DASHBOARD', 'system', 1, 'menu-icon fa fa-cogs'),
  ('SYSTEM_USER', '用户管理', 'SYSTEM', 'system/user', 0, ''),
  ('SYSTEM_ROLE', '角色管理', 'SYSTEM', 'system/role', 1, ''),
  ('SYSTEM_MENU', '菜单管理', 'SYSTEM', 'system/menu', 2, ''),
  ('SYSTEM_CATEGORY', '栏目管理', 'SYSTEM', 'system/category', 3, ''),
  ('SYSTEM_CACHE', '缓存管理', 'SYSTEM', 'system/cache', 4, ''),

  ('MANAGE', '管理', 'DASHBOARD', 'manage', 2, 'menu-icon fa fa-desktop'),
  ('MANAGE_ARTICLE', '文章管理', 'MANAGE', 'manage/article', 0, ''),
  ('MANAGE_TOOL', '工具管理', 'MANAGE', 'manage/tool', 1, ''),
  ('MANAGE_NOVEL', '小说管理', 'MANAGE', 'manage/novel', 2, ''),
  ('MANAGE_MUSIC', '音乐管理', 'MANAGE', 'manage/music', 3, ''),
  ('MANAGE_PHOTO', '相册管理', 'MANAGE', 'manage/photo', 4, ''),
  ('MANAGE_LIFE', '生活动态', 'MANAGE', 'manage/life', 5, ''),
  ('MANAGE_GUEST', '留言管理', 'MANAGE', 'manage/guest', 6, ''),

  ('USER', '我的', 'DASHBOARD', 'user', 3, 'menu-icon fa fa-user'),
  ('USER_INFO', '基本信息', 'USER', 'user/info', 0, '');

-- ----------------------------
--  data for tb_user_role
-- ----------------------------
INSERT INTO tb_user_role
VALUES
  ('admin', 'ROLE_ADMIN');

-- ----------------------------
--  data for tb_role_menu
-- ----------------------------
INSERT INTO tb_role_menu SELECT
                           'ROLE_ADMIN',
                           code
                         FROM tb_menu;

INSERT INTO tb_role_menu SELECT
                           'ROLE_USER',
                           code
                         FROM tb_menu
                         WHERE code LIKE 'USER%' OR code = 'DASHBOARD';

INSERT INTO tb_category
(code, name, type, sort)
VALUES
  ('db', '数据库', 'ARTICLE', 0),
  ('server', '后台', 'ARTICLE', 1),
  ('web', '前端', 'ARTICLE', 2),
  ('linux', 'Linux', 'ARTICLE', 3),
  ('architect', '架构', 'ARTICLE', 4),
  ('code', '代码片段', 'ARTICLE', 5),
  ('other', '其他', 'ARTICLE', 5);