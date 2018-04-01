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
  title         VARCHAR(128)                          NOT NULL
  COMMENT '文章标题',
  summary       VARCHAR(1024)                         NOT NULL
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
  thumb             VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '缩略图地址',
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
  icon         VARCHAR(128)                          NOT NULL                    DEFAULT ''
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

-- ----------------------------
--  Table structure for tb_dictionary
-- ----------------------------
DROP TABLE
IF EXISTS tb_dictionary;

CREATE TABLE tb_dictionary
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         VARCHAR(32)                           NOT NULL
  COMMENT '字典代码',
  value        VARCHAR(128)                          NOT NULL
  COMMENT '字典的值',
  type         VARCHAR(16)                           NOT NULL
  COMMENT '字典类型',
  sort         INT(11)                               NOT NULL                DEFAULT 0
  COMMENT '排序(从0开始)',
  is_deleted   TINYINT                               NOT NULL                DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '字典表';
CREATE INDEX created_time_ix
  ON tb_dictionary (created_time);
CREATE INDEX type_ix
  ON tb_dictionary (type);
CREATE INDEX sort_ix
  ON tb_dictionary (sort);

-- ----------------------------
--  Table structure for tb_guest
-- ----------------------------
DROP TABLE
IF EXISTS tb_guest;

CREATE TABLE tb_guest
(
  id              BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  realname        VARCHAR(32)                           NOT NULL
  COMMENT '昵称',
  email           VARCHAR(64)                           NOT NULL
  COMMENT '邮箱',
  content         VARCHAR(2048)                         NOT NULL
  COMMENT '内容',
  status          VARCHAR(16)                           NOT NULL                    DEFAULT 'WAITING'
  COMMENT '状态:{"WAITING":"待审核", "REJECT":"拒绝", "COMPLETE":"审核通过"}',
  adjust_username VARCHAR(16)                           NOT NULL                    DEFAULT ''
  COMMENT '审核人',
  ip              VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT 'IP',
  ip_info         VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT 'IP信息',
  reply_message   LONGTEXT                              NOT NULL
  COMMENT '回复信息',
  reply_username  VARCHAR(16)                           NOT NULL                    DEFAULT ''
  COMMENT '回复人',
  is_deleted      TINYINT                               NOT NULL                    DEFAULT '0'
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '留言表';
CREATE INDEX id_status
  ON tb_guest (status);

-- ----------------------------
--  Table structure for tb_life
-- ----------------------------
DROP TABLE
IF EXISTS tb_life;

CREATE TABLE tb_life
(
  id            BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  title         VARCHAR(64)                           NOT NULL
  COMMENT '生活标题',
  summary       VARCHAR(128)                          NOT NULL
  COMMENT '摘要',
  category_code VARCHAR(32)                           NOT NULL
  COMMENT '栏目代码',
  content       LONGTEXT                              NOT NULL
  COMMENT '内容',
  is_deleted    TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '生活表';
CREATE INDEX id_category_code
  ON tb_life (category_code);

-- ----------------------------
--  Table structure for tb_novel
-- ----------------------------
DROP TABLE
IF EXISTS tb_novel;

CREATE TABLE tb_novel
(
  id            BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  name          VARCHAR(32)                           NOT NULL
  COMMENT '书名',
  author        VARCHAR(32)                           NOT NULL
  COMMENT '作者',
  category_code VARCHAR(32)                           NOT NULL
  COMMENT '分类代码',
  pic_url       VARCHAR(256)                          NOT NULL                    DEFAULT '/upload/default-book.png'
  COMMENT '封面图片地址',
  code          INT(11)                               NOT NULL
  COMMENT '书籍代码',
  descp         VARCHAR(2048)                         NOT NULL
  COMMENT '描述',
  is_deleted    TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '书籍表';
CREATE UNIQUE INDEX code_UNIQUE
  ON tb_novel (code);
CREATE INDEX ix_category_code
  ON tb_novel (category_code);

-- ----------------------------
--  Table structure for tb_section
-- ----------------------------
DROP TABLE
IF EXISTS tb_section;

CREATE TABLE tb_section
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         INT(11)                               NOT NULL
  COMMENT '章节代码',
  title        VARCHAR(64)                           NOT NULL
  COMMENT '标题',
  content      LONGTEXT                              NOT NULL
  COMMENT '内容',
  novel_code   INT(11)                               NOT NULL
  COMMENT '小说代码',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '章节表';
CREATE UNIQUE INDEX code_UNIQUE
  ON tb_section (code);
CREATE INDEX ix_novel_code
  ON tb_section (novel_code);

-- ----------------------------
--  Table structure for tb_login_log
-- ----------------------------
DROP TABLE
IF EXISTS tb_login_log;

CREATE TABLE tb_login_log
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  username     VARCHAR(32)                           NOT NULL
  COMMENT '用户名',
  ip           VARCHAR(20)                           NOT NULL
  COMMENT '登录IP',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '章节表';
CREATE INDEX ix_username
  ON tb_login_log (username);
CREATE INDEX ix_created_time
  ON tb_login_log (created_time);

-- ----------------------------
--  Table structure for tb_music
-- ----------------------------
DROP TABLE
IF EXISTS tb_music;

CREATE TABLE tb_music
(
  id               BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  name             VARCHAR(64)                           NOT NULL
  COMMENT '歌曲名',
  singer           VARCHAR(64)                           NOT NULL
  COMMENT '歌手',
  album            VARCHAR(64)                           NOT NULL
  COMMENT '专辑',
  album_cover_path VARCHAR(128)                          NOT NULL
  COMMENT '专辑封面路径',
  music_path       VARCHAR(128)                          NOT NULL
  COMMENT 'mp3文件路径',
  duration         INT(11)                               NOT NULL
  COMMENT '时长(秒)',
  size             BIGINT(20)                            NOT NULL
  COMMENT '文件大小(byte)',
  category_code    VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '栏目代码',
  upload_username  VARCHAR(16)                           NOT NULL                    DEFAULT ''
  COMMENT '上传人',
  upload_remark    VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '上传备注',
  status           VARCHAR(16)                           NOT NULL                    DEFAULT 'WAITING'
  COMMENT '状态:{"WAITING":"待审核", "REJECT":"拒绝", "COMPLETE":"审核通过"}',
  adjust_username  VARCHAR(16)                           NOT NULL                    DEFAULT ''
  COMMENT '审核人',
  is_deleted       TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time     TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time     TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '音乐表';
CREATE UNIQUE INDEX id_unique_name_singer
  ON tb_music (name, singer);
CREATE INDEX ix_category_code
  ON tb_music (category_code);

-- ----------------------------
--  Table structure for tb_photo
-- ----------------------------
DROP TABLE
IF EXISTS tb_photo;

CREATE TABLE tb_photo
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  title        VARCHAR(64)                           NOT NULL
  COMMENT '相册标题',
  cover_img    VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '相册封面',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '相册表';

-- ----------------------------
--  Table structure for tb_monitor
-- ----------------------------
DROP TABLE
IF EXISTS tb_monitor;

CREATE TABLE tb_monitor
(
  id               BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  app              VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '应用名称',
  type             VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '监控类型',
  description      VARCHAR(2048)                         NOT NULL                    DEFAULT ''
  COMMENT '监控描述',
  begin_time       TIMESTAMP                             NULL
  COMMENT '开始时间',
  end_time         TIMESTAMP                             NULL
  COMMENT '结束时间',
  has_return_value TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '是否有返回值:{0:没有返回值, 1:有返回值}',
  return_value     LONGTEXT                              NOT NULL
  COMMENT '返回值',
  args             LONGTEXT                              NOT NULL
  COMMENT '参数',
  username         VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '用户名',
  is_deleted       TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time     TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time     TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '章节表';
CREATE INDEX ix_app
  ON tb_monitor (app);
CREATE INDEX ix_type
  ON tb_monitor (type);

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
  ('SYSTEM_DICTIONARY', '数据字典', 'SYSTEM', 'system/dictionary', 4, ''),
  ('SYSTEM_CACHE', '缓存管理', 'SYSTEM', 'system/cache', 5, ''),
  ('SYSTEM_LOGIN', '登录日志', 'SYSTEM', 'system/login', 6, ''),
  ('SYSTEM_SQL', '执行脚本', 'SYSTEM', 'system/sql', 7, ''),

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
  ('other', '其他', 'ARTICLE', 5),

  ('mood', '每日心情', 'LIFE', 0),
  ('trifle', '生活琐事', 'LIFE', 1),
  ('goal', '小目标', 'LIFE', 2),
  ('history', '历史事件', 'LIFE', 3),
  ('shit', '我的吐槽', 'LIFE', 4),

  ('old', '怀旧', 'MUSIC', 0),
  ('rhythm', '节奏', 'MUSIC', 1),
  ('light', '轻音乐', 'MUSIC', 2),
  ('net', '网络', 'MUSIC', 3),
  ('other', '其他', 'MUSIC', 4),

  ('xuanhuan', '玄幻', 'NOVEL', 0),
  ('dushi', '都市', 'NOVEL', 1),
  ('xiuzhen', '修真', 'NOVEL', 2),
  ('lishi', '历史', 'NOVEL', 3),
  ('yanqing', '言情', 'NOVEL', 4),
  ('wangyou', '网游', 'NOVEL', 5),
  ('kehuan', '科幻', 'NOVEL', 6),
  ('qita', '其他', 'NOVEL', 7);

INSERT INTO tb_tool
(CODE, is_top, NAME, icon)
VALUES
  ('qr', 1, '生成二维码', 'static/app/images/tools/qr.png'),
  ('qr2', 1, '解析二维码', 'static/app/images/tools/qr2.png'),
  ('bazi', 1, '八字、五行', 'static/app/images/tools/bazi.png'),
  ('xml', 1, 'XML格式化', 'static/app/images/tools/xml.png'),
  ('idcard', 1, '身份证查询', 'static/app/images/tools/idcard.png'),
  ('gencard', 1, '生成身份证', 'static/app/images/tools/gencard.png'),
  ('ascll', 0, 'ASCLL码对照表', 'static/app/images/tools/ascll.png'),
  ('html', 0, 'HTML转义字符', 'static/app/images/tools/html.png'),
  ('sql', 0, 'SQL格式化', 'static/app/images/tools/sql.png'),
  ('json', 0, 'JSON格式化', 'static/app/images/tools/json.png'),
  ('js', 0, 'JS压缩', 'static/app/images/tools/js.png'),
  ('css', 0, 'CSS压缩', 'static/app/images/tools/css.png'),
  ('charset', 0, '编码转换', 'static/app/images/tools/charset.png'),
  ('compare', 0, 'properties文件对比', 'static/app/images/tools/compare.png');

INSERT tb_guest
(realname, email, ip_info, content, status, reply_message)
VALUES
  ('康永敢', 'java@kangyonggan.com', '上海市网友', '新版博客出炉，老版本的留言没去保留。', 'COMPLETE', '');

INSERT INTO tb_life
(title, summary, category_code, content)
VALUES

  ('今天新版博客上线，新的样式看起来又是一番新的心情', '老版本看了一年多了，有点腻了，所以就动手重构了一把，不然自己都懒得看自己的博客了，新版博客还增加了一些小小的功能...', 'mood', '## 老版本
1. 拥有注册的功能。
2. 首页没有看小说界面。
3. 没有相册。
4. 没有生活动态。

## 新版本
1. 干掉了注册的功能，因为就我自己玩。
2. 在首页上加了看小说的界面。
3. 增加了相册。
4. 增加了生活动态。
'),
  ('再过几个月，偶就要做爸爸了，时间过的真快啊，想当年我还只是个小孩子', '这个时刻一定要记住，一定要记住，这绝对是一个人一生中比较重大的转折点，可能会改变我的生活方式，对我影响会比较大...', 'history',
   '坐等当爸爸...'),
  ('不想花钱买苹果开发者账号，但是又想把我写的一个小说app上架到App Store',
   '由于我个人比较喜欢看小说，但是App Store中的小说app都太多广告和限制，所以我就写了一个爬虫去爬去某网站上的小说，然后自己再写了一个app，但是一直不能上架...', 'trifle',
   '之前也借了一个苹果开发者账号，想要把我的app上架，但是由于自己是业余中的业余，上架两次都因为各种原因被苹果审核人员拒绝了，原因也找到了，等下次有时间在重新上架试试，等忙完手里的事，我还要再写一个app，然后上架，目测我是需要买开发者账号了，这学习成本是真大，每年还有域名费和服务器费，马上快要养不起了。'),
  ('给自己定一个本阶段的小目标', '人生不能没有目标,如果没有目标,就会像一只黑夜中找不到灯塔的航船,在茫茫大海中迷失了方向,只能随波逐流,达不到岸边,甚至会触礁而毁...', 'goal', '1. 重构博客
2. 使用upsource优化代码质量
3. 对博客进行简单的兼容性测试
4. 登录日志
5. extra扩展操作日志功能
6. extra增加全局开关
7. ftl组件抽取
8. 用户体检琢磨优化
9. 整理一份最新的项目原型
10. 管理系统支持多主题多皮肤');