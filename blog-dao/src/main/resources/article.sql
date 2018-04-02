INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-dubbo-admin的安装配置', '下载war包、把war包上传到服务器、放在服务器下启动、配置、启动和停止', 'linux', '## 上传本地dubbo-admin到Ubuntu服务器
```
$ scp dubbo-admin.war root@121.40.66.176:/root/soft/
```

## 解压dubbo-monitor到tomcat/webapps/ROOT/目录下
```
$ unzip dubbo-admin.war -d /root/install/apache-tomcat-8.5.6/webapps/ROOT/
```

<!-- more -->

## 配置
修改`webapps/ROOT/WEB-INF/dubbo.properties`中`dubbo.registry.address`的值：

```
dubbo.registry.address=zookeeper://121.40.66.176:2181?backup=139.196.28.125:2181
```

修改tomcat的server.xml：

```
<Connector port="9090" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" ></Connector>
```

## 启动
```
$ sh bin/startup.sh
```

## 停止
```
$ sh bin/shutdown.sh
```

## 访问
http://localhost:9090/

', 0, 0, '2018-03-24 23:00:58', '2018-03-24 23:09:09');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-dubbo-monitor2.5.3的安装配置', '下载war包、把war包上传到服务器、放在服务器下启动、配置、启动和停止', 'linux', '## 下载[dubbo-monitor2.5.3](http://download.csdn.net/detail/liweifengwf/7864009)到本地

## 上传本地dubbo-monitor到Ubuntu服务器
```
$ scp dubbo-monitor-simple-2.5.3-assembly.tar.gz root@121.40.66.176:/root/soft/
```

## 解压dubbo-monitor到指定目录
```
$ tar -zxvf dubbo-monitor-simple-2.5.3-assembly.tar.gz -C /root/install/
```

## 配置
修改`conf/dubbo.properties`中`dubbo.registry.address`的值：

```
dubbo.registry.address=zookeeper://121.40.66.176:2181?backup=139.196.28.125:2181
```

<!-- more -->

## 启动
```
# ./bin/start.sh
```

## 停止
```
$ ./bin/stop.sh
```

## 重启
```
$ ./bin/restart.sh
```

## 访问
http://localhost:8080/

', 0, 0, '2018-03-24 23:01:58', '2018-03-24 23:09:03');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-git1.9.1的安装配置', '本例为在线安装，如果服务器不能联网，那就需要先下载离线包了，还有就是如果是离线安装，可能需要gcc等环境，因为离线为源码安装', 'linux', '## 更新apt-get
```
$ apt-get update
```

## 下载git
```
$ apt-get install git
```

## 测试git是否生效
```
$ git --version
```', 0, 0, '2018-03-24 23:03:51', '2018-03-24 23:08:58');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-jdk1.8的安装配', '下载jdk，解压后配置环境变量即可使用', 'linux', '## 下载[jdk1.8](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)到本地

## 上传本地jdk到Ubuntu服务器
```
$ scp jdk-8u111-linux-x64.tar.gz root@121.40.66.176:/root/soft/
```

## 解压jdk到指定目录
```
$ tar -zxvf jdk-8u111-linux-x64.tar.gz -C /root/install/
```

## 配置jdk的环境变量
在`/etc/profile`文件尾追加下面的配置:

```
export JAVA_HOME=/root/install/jdk1.8.0_111
export JRE_HOME=/root/install/jdk1.8.0_111/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
```

<!-- more -->

之后，重新加载配置，让配置生效:

```
$ source profile
```

## 测试环境变量是否生效
```
$ java -version
```



', 0, 0, '2018-03-24 23:05:31', '2018-03-24 23:08:53');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-jenkins的安装配置', '下载安装包，上传至服务器并启动，这些都比较简单，难的是安装插件，配置项目等', 'linux', '## 下载[jenkins](https://jenkins.io/index.html)到本地

## 上传本地jenkins到Ubuntu服务器

```
$ scp jenkins.war root@121.40.66.176:/root/soft/
```

## 直接把war包放入tomcat的webapps目录下并重启tomcat即可

<!-- more -->

## 安装maven插件
去这个地址[http://updates.jenkins-ci.org/download/plugins/](http://updates.jenkins-ci.org/download/plugins/)下载maven插件到本地

然后在jenkins-->系统管理-->管理插件-->高级-->上传插件-->选择maven插件(maven-plugin.hpi)-->上传-->重启

## jenkins执行shell重启tomcat无效
需要在Post steps中执行`export BUILD_ID=BUILD_BLOG`,如:

```
export BUILD_ID=BUILD_BLOG
sh /home/kyg/shell/deploy-blog.sh
```

## 构建时， 需要指定maven配置
如果没指定， 会使用默认配置，会联网下载依赖到.m2文件夹下，所以需要指定`settings.xml`配置文件的位置, 如下图:

![jenkins-maven](https://kangyonggan.com/upload/20170101020115076.png)




', 0, 0, '2018-03-24 23:07:06', '2018-03-24 23:08:48');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-maven3.3.9', '下载安装包、把安装包上传到服务器、解压后配置环境变量即可', 'linux', '## 下载[maven3.3.9](http://maven.apache.org/download.cgi)到本地

## 上传本地maven到Ubuntu服务器
```
$ scp apache-maven-3.3.9-bin.tar.gz root@121.40.66.176:/root/soft/
```

## 解压maven到指定目录
```
$ tar -zxvf apache-maven-3.3.9-bin.tar.gz -C /root/install/
```

## 配置maven的环境变量
在`/etc/profile`文件尾追加下面的配置:

```
export M2_HOME=/root/install/apache-maven-3.3.9
export PATH=$PATH:$M2_HOME/bin
```

<!-- more -->

之后，重新加载配置，让配置生效:

```
$ source profile
```

## 5. 测试环境变量是否生效
```
$ mvn -version
```

## 6. 配置本地仓库路径
在`/root/install/apache-maven-3.3.9/conf/settings.xml`文件中配置:

```
<localRepository>/root/data/repository</localRepository>
```

', 0, 0, '2018-03-24 23:08:36', '2018-03-24 23:08:36');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-mysql5.6的安装配置', '本例为在线安装，如果服务器不能联网，那就需要先下载离线包了，还有就是如果是离线安装，可能需要gcc等环境，因为离线为源码安装', 'db', '
## 安装
```
$ apt-get install mysql-server-5.6
```

## 启动
```
$ /etc/init.d/mysql start
```

## 停止
```
$ /etc/init.d/mysql stop
```

## 重启
```
$ /etc/init.d/mysql restart
```

## 调整内存
修改`/etc/mysql/my.cnf`,在`[mysqld]`后面追加

```
performance_schema_max_table_instances=200
table_definition_cache=200
table_open_cache=128
```


', 0, 0, '2018-03-24 23:09:57', '2018-03-24 23:09:57');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-nexus3.1.0的安装配置', 'nexus是一个maven仓库的管理工具，可以在公司内网环境搭建一个服务器，这样就可以保证系统间的依赖畅通又安全了', 'linux', '
## 下载[nexus3.1.0](https://www.sonatype.com/download-oss-sonatype)到本地

## 上传本地nexus到Ubuntu服务器
```
$ scp nexus-3.1.0-04-unix.tar.gz root@121.40.66.176:/root/soft/
```

## 解压nexus到指定目录
```
$ tar -zxvf nexus-3.1.0-04-unix.tar.gz -C /root/install/
```

## 启动
```
$ ./nexus start
```

<!-- more -->

## 停止
```
$ ./nexus stop
```

## 访问
http://localhost:8081/

- 用户名:admin
- 密码:admin123

## 使用

配置`settings.xml`

```
<servers>
    <server>
      <id>releases</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>snapshots</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>
```

配置`pom.xml`

```
<distributionManagement>
    <repository>
        <id>releases</id>
        <name>nexus releases</name>
        <url>http://kangyonggan.com:8081/repository/maven-releases/</url>
    </repository>

    <snapshotRepository>
        <id>snapshots</id>
        <name>nexus snapshots</name>
        <url>http://kangyonggan.com:8081/repository/maven-snapshots/</url>
    </snapshotRepository>
</distributionManagement>
```

', 0, 0, '2018-03-24 23:12:42', '2018-03-24 23:12:42');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-tomcat8.5.6的安装配置', '这是最简单的一个安装了，无非就是下载安装包、上传至服务器，解压、启动和停止', 'linux', '## 下载[tomcat8.5.6](http://tomcat.apache.org/download-80.cgi)到本地

## 上传本地tomcat到Ubuntu服务器
```
$ scp apache-tomcat-8.5.6.tar.gz root@121.40.66.176:/root/soft/
```

## 解压tomcat到指定目录
```
$ tar -zxvf apache-tomcat-8.5.6.tar.gz -C /root/install/
```

## 启动
```
$ sh startup.sh
```

## 停止
```
$ sh shutdown.sh
```



', 0, 0, '2018-03-24 23:13:56', '2018-03-24 23:13:56');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-zookeeper3.4.9的安装配置', '下面说明了zookeeper的下载和安装，并说明了zookeeper的启动和停止等命令，最后还说明了zookeeper集群的配置', 'linux', '## 下载[zookeeper3.4.9](http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.9/)到本地

## 上传本地zookeeper到Ubuntu服务器
```
$ scp zookeeper-3.4.9.tar.gz root@121.40.66.176:/root/soft/
```

## 解压zookeeper到指定目录

```
$ mkdir /root/install/server1
$ tar zxvf zookeeper-3.4.9.tar.gz -C /root/install/server1/
```

<!-- more -->

## 配置（集群）
在`server1`目录下创建两个目录，分别是`data`和`logs`

```
$ cd /root/install/server1/
$ mkdir data
$ mkdir logs
```

此时，server1目录下有三个文件

```
root@iZ23ldh8kudZ:~/install/server1# pwd
/root/install/server1
root@iZ23ldh8kudZ:~/install/server1# ll
total 20
drwxr-xr-x  5 root root 4096 Dec 17 15:43 ./
drwxr-xr-x  8 root root 4096 Dec 17 15:39 ../
drwxr-xr-x  2 root root 4096 Dec 17 15:43 data/
drwxr-xr-x  2 root root 4096 Dec 17 15:43 logs/
drwxr-xr-x 10 1001 1001 4096 Aug 23 15:42 zookeeper-3.4.9/
```

在`data`目录下创建文件`myid`,其内容为`1`

```
vi /data/myid
内容为1
```

复制配置文件`zookeeper-3.4.9/conf/zoo_sample.cfg`到`zookeeper-3.4.9/conf/zoo.cfg`, 并修改其内容:

```
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/root/install/server1/data
dataLogsDir=/root/install/server1/logs
clientPort=2181

server.1=121.40.66.176:2888:3888
server.2=139.196.28.125:2888:3888
```

> 每台服务器都要有类似的配置

## 环境变量

在`/etc/profile`文件最后追加:

```
export PATH=$PATH:/root/install/server1/zookeeper-3.4.9/bin
```

立即生效

```
$ source /etc/profile
```

## 启动

```
$ zkServer.sh start
```

## 查看是否启动

```
root@iZ23ldh8kudZ:~/install/server1/zookeeper-3.4.9# jps
7096 QuorumPeerMain
7114 Jps
```

看到`QuorumPeerMain`就说明启动成功了

## 停止

```
$ zkServer.sh stop
```


', 0, 0, '2018-03-24 23:15:53', '2018-03-24 23:15:53');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.04下配置ftp服务器', '下面给出了linux下ftp的在线安装方法，以及ftp的简单配置，最后给出了java利用ftp上传文件的代码片段', 'linux', '## 下载并安装
```
apt-get install vsftpd
```

## ftp服务器启动和重启
- 启动:`/etc/init.d/vsftpd start`
- 重启:`/etc/init.d/vsftpd restart`

<!-- more -->

## 创建ftp用户
ftp用户需满足下面条件：

- 此用户只是用来使用ftp服务的
- 此用户不可登录服务器
- 此用户不能访问ftp指定文件夹之外的文件

## 创建用户
```
useradd -d /home/ftp0 -m ftp0
passwd ftp0
```

## 修改ftp配置
修改`/etc/vsftpd.conf`的几个关键配置:

```
anonymous_enable=NO cal_user=YES# 只能访问自身的目录，此处有坑，需加上下面一行
allow_writeable_chroot=YES# 允许写自身发目录
```

## 让用户不能登录
```
usermod -s /sbin/nologin ftp0
```

注意，ubuntu下还需要在`/etc/shells`最后加上：`/sbin/nologin`

> 最后需要重启ftp服务器

## 测试
```
ftp> open 192.168.1.100
user:ftp0
pwd:xxxxx
success!
```

## 附javaftp上传代码
```
package com.kangyonggan.api.biz;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import java.io.File;
import java.io.FileInputStream;

/**
 * @author kangyonggan
 * @date 2016/12/25
 */
public class TestFtp {

    private FTPClient ftp;

    /**
     * @param path     上传到ftp服务器哪个路径下
     * @param addr     地址
     * @param port     端口号
     * @param username 用户名
     * @param password 密码
     * @return
     * @throws Exception
     */
    private boolean connect(String path, String addr, int port, String username, String password) throws Exception {
        boolean result = false;
        ftp = new FTPClient();
        int reply;
        ftp.connect(addr, port);
        ftp.login(username, password);
        ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
        reply = ftp.getReplyCode();
        if (!FTPReply.isPositiveCompletion(reply)) {
            ftp.disconnect();
            return result;
        }
        ftp.changeWorkingDirectory(path);
        result = true;
        return result;
    }

    /**
     * @param file 上传的文件或文件夹
     * @throws Exception
     */
    private void upload(File file) throws Exception {
        if (file.isDirectory()) {
            ftp.makeDirectory(file.getName());
            ftp.changeWorkingDirectory(file.getName());
            String[] files = file.list();
            for (int i = 0; i < files.length; i++) {
                File file1 = new File(file.getPath() + "\\" + files[i]);
                if (file1.isDirectory()) {
                    upload(file1);
                    ftp.changeToParentDirectory();
                } else {
                    File file2 = new File(file.getPath() + "\\" + files[i]);
                    FileInputStream input = new FileInputStream(file2);
                    ftp.storeFile(file2.getName(), input);
                    input.close();
                }
            }
        } else {
            File file2 = new File(file.getPath());
            FileInputStream input = new FileInputStream(file2);
            ftp.storeFile(file2.getName(), input);
            input.close();
        }
    }

    public static void main(String[] args) throws Exception {
        TestFtp t = new TestFtp();
        t.connect("/home/ftp0/", "192.168.1.100", 21, "ftp0", "123456");
        File file = new File("/Users/kyg/Downloads/blog.sql");
        t.upload(file);
    }

}
```



', 0, 0, '2018-03-24 23:17:30', '2018-03-24 23:17:30');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.04从命令行启动', '因为我的个人linux服务器是有界面的，但是大部分时候我不希望使用界面，所以需要让服务器从命令行启动，这样也省服务器内存', 'linux', '## 修改配置 /etc/default/grub
- 注释此行：`#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`
- `GRUB_CMDLINE_LINUX=""` 改为 `GRUB_CMDLINE_LINUX="text"`
- `#GRUB_TERMINAL=console` 的注释干掉

## 更新配置
```
update-grub
```

## 重启
不出意外会从命令行启动， 意外会发生在ubuntu16.04上
', 0, 0, '2018-03-24 23:19:25', '2018-03-24 23:19:25');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.04盒盖不休眠', '因为我的个人服务器是台笔记本电脑，既然是笔记本，那就总有盒盖的时候，但是默认情况下，盖子盒上一会之后电脑就休眠了，所以需要设置一下，让电脑盒盖不休眠', 'linux', '## 修改配置 /etc/systemd/logind.conf
然后将其中的：`#HandleLidSwitch=suspend` 改成： `HandleLidSwitch=ignore`

## 然后重启服务：
```
sudo restart systemd-logind
```

', 0, 0, '2018-03-24 23:21:14', '2018-03-24 23:21:14');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu14.0.4安装及配置系列-redis3.2.0的安装配置', '下载安装包、上传至服务器、解压安装、配置、启动和停止', 'linux', '## 下载[redis3.2](https://redis.io/)到本地

## 上传本地redis到Ubuntu服务器
```
$ scp redis-3.2.0.tar.gz root@121.40.66.176:/root/soft/
```

## 解压redis到指定目录
```
$ tar -zxvf redis-3.2.0.tar.gz -C /root/install/
```

## 安装
```
make & make install
```

<!-- more -->

## 配置
在`/root/install/redis-3.2.0/redis.conf`后面追加下面的配置:

```
requirepass 123456
```

## 启动
```
$ redis-server redis.conf &
```

## 测试

```
$ redis-cli -a 123456
> ping
```

输出:`PONG`

## 停止
```
$ redis-cli -a 123456 shutdown
```

## 清空所有缓存
```
$ redis-cli -a 123456 KEYS "*" | xargs redis-cli -a 123456 DEL
```


', 0, 0, '2018-03-24 23:22:27', '2018-03-24 23:22:27');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu16.0.4启动zookeeper报错', '在使用zookeeper做一个分布式服务的时候，悲剧的发现zookeeper在启动过程中竟然报错了，报错是好了，起码我又能学到东西了，只要时间上不急便好', 'linux', '
## 报错信息
```
bin/zkServer.sh: 81: /home/kyg/install/server1/zookeeper-3.4.9/bin/zkEnv.sh: Syntax error: "(" unexpected (expecting "fi")
```

## 解决方案
```
ls -l /bin/sh
lrwxrwxrwx 1 root root 4 12月 24 17:22 /bin/sh -> dash
ls -l /bin/sh
lrwxrwxrwx 1 root root 4 12月 24 20:01 /bin/sh -> bash
```


', 0, 0, '2018-03-24 23:24:49', '2018-03-24 23:24:49');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu下mysql数据库恢复', ' 前端时间我在玩主从库的时候， 一不小心把mysql数据库玩坏了， 连服务都启动不了了， 经过一番修复后还是不行， 可怜我的博客都在库里, 不过我却在庆幸， 因为这叫置之死地而后生，我又能学到牛逼技术了', 'db', '## 备份数据
mysql数据是放在/var/lib/mysql下面的，需要备份的内容有：

- ibdata1
- performance_schema
- blog文件夹 （对应数据库blog）
- 其他你需要恢复的数据库

<!-- more -->

## 重装mysql
重装教程网上一堆， 这里就不再赘述。

## 恢复
把备份的几个文件， 替换回去， 然后重启mysql， 这时候会报错， 查看mysql日志后发现是权限不足导致。

原因是：备份与恢复数据的用户一般都需要比较高的权限才能操作， 比如root，所以替换后的文件的所有者是root， 而不再是mysql， 因此需要改变文件拥有者和赋权：

```
cd /var/lib/mysql
chown mysql *

chmod 700 blog;
chmod 700 ibdata1;
chmod 700 performance_schema;
```

必要时还需要删除这两个日志文件`ib_logfile0`和`ib_logfile1`：

```
rm ib_logfile*
```

重启， 不出意外应该是可以登录mysql了， `show databases`能看到已经恢复的blog数据库了， `use blog;show tables`能看见article表了。

但是，在查询article表的时候，又会报权限不足的错， 道理是相同的， 我们去`/var/lib/mysql/blog`目录下，重新改变拥有者:

```
cd /var/lib/mysql/blog
chown mysql *
```

重启，验证， 成功！', 1, 0, '2018-03-24 23:25:42', '2018-03-24 23:25:42');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu下方向键不好使的解决方案', '刚刚安装的ubuntu，在vi模式下，发现方向键不好使，按如下方法操作即可', 'linux', '## 先卸载vim-tiny

```
$ sudo apt-get remove vim-common
```

## 再安装vim full：

```
$ sudo apt-get install vim
```

', 0, 0, '2018-03-24 23:26:40', '2018-03-24 23:26:40');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu下防火墙的一些简单使用', '公司的很多项目都是放在Linux机器上的，因此安装防火墙还是很有必要的...', 'linux', '## 安装防火墙
```
apt-get install firewalld
```

<!-- more -->

## 查看开放的端口
```
firewall-cmd --list-all
```

## 把一个端口开放
```
firewall-cmd --permanent --add-port=8080/tcp
```

## 端口开放之后要重新加载
```
firewall-cmd --reload
```

## 移除一个开放的端口
```
firewall-cmd --permanent --remove-port=8080/tcp
```

', 0, 0, '2018-03-24 23:27:15', '2018-03-24 23:27:15');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Ubuntu配置DNS服务器', '在ubuntu 14.04上搭建一个自己的dns服务器，并实现重新解析baidu.com到自定义服务器', 'linux', '## 安装并配置

```
kyg@kyg-Latitude-5450:~$ sudo apt-get bind9
```

<!-- more -->

检查是否安装成功

```
kyg@kyg-Latitude-5450:~$ cd /etc/bind/
kyg@kyg-Latitude-5450:/etc/bind$ ll
total 68
drwxr-sr-x   2 root bind  4096  2月 19 12:25 ./
drwxr-xr-x 129 root root 12288  2月 19 12:25 ../
-rw-r--r--   1 root root  2389  2月 16 00:33 bind.keys
-rw-r--r--   1 root root   237  2月 16 00:33 db.0
-rw-r--r--   1 root root   271  2月 16 00:33 db.127
-rw-r--r--   1 root root   237  2月 16 00:33 db.255
-rw-r--r--   1 root root   353  2月 16 00:33 db.empty
-rw-r--r--   1 root root   270  2月 16 00:33 db.local
-rw-r--r--   1 root root  3048  2月 16 00:33 db.root
-rw-r--r--   1 root bind   463  2月 16 00:33 named.conf
-rw-r--r--   1 root bind   490  2月 16 00:33 named.conf.default-zones
-rw-r--r--   1 root bind   165  2月 16 00:33 named.conf.local
-rw-r--r--   1 root bind   890  2月 19 12:25 named.conf.options
-rw-r-----   1 bind bind    77  2月 19 12:25 rndc.key
-rw-r--r--   1 root root  1317  2月 16 00:33 zones.rfc1918
```

在实验之前先ping一下百度，好做个对比

```
kyg@kyg-Latitude-5450:~$ ping baidu.com
PING baidu.com (123.125.114.144) 56(84) bytes of data.
64 bytes from 123.125.114.144: icmp_seq=1 ttl=54 time=33.4 ms
64 bytes from 123.125.114.144: icmp_seq=2 ttl=54 time=42.4 ms
64 bytes from 123.125.114.144: icmp_seq=3 ttl=54 time=37.3 ms
```

可以看到dns把baidu.com解析成的ip是123.125.114.144
现在我就搭建一个简单的dns，让自己的dns把baidu.com解析成192.168.2.112
这是自己的服务器，然后就可以把xxx展现给用户了。

配置dns：

```
kyg@kyg-Latitude-5450:~$ sudo vim /etc/bind/named.conf.local
添加如下内容:

zone "baidu.com" { type master; file "/etc/bind/db.baidu.com"; };
```

修改db的配置文件:

```
kyg@kyg-Latitude-5450:~$ cd /etc/bind/
kyg@kyg-Latitude-5450:/etc/bind# sudo cp db.local db.baidu.com
kyg@kyg-Latitude-5450:/etc/bind# vi db.baidu.com

内容如下：

;
; BIND data file for local loopback interface
;
$TTL604800
@INSOAlocalhost. root.localhost. (
o      2; Serial
o 604800; Refresh
o  86400; Retry
o2419200; Expire
o 604800 ); Negative Cache TTL
;
@INNSlocalhost.
@INA192.168.2.112
@INAAAA::1
```

最后重启服务！

```
kyg@kyg-Latitude-5450:/etc/bind# sudo /etc/init.d/bind9 restart
 * Stopping domain name service... bind9                                                waiting for pid 5141 to die
                                                                                 [ OK ]
 * Starting domain name service... bind9
```

如果启动失败，可以运行`named -g`查看错误原因.

## 测试
```
kyg@kyg-Latitude-5450:/etc/bind$ ping baidu.com
PING baidu.com (192.168.2.112) 56(84) bytes of data.
64 bytes from 192.168.2.112: icmp_seq=1 ttl=63 time=4.73 ms
64 bytes from 192.168.2.112: icmp_seq=2 ttl=63 time=2.12 ms
64 bytes from 192.168.2.112: icmp_seq=3 ttl=63 time=2.22 ms
64 bytes from 192.168.2.112: icmp_seq=4 ttl=63 time=5.15 ms
64 bytes from 192.168.2.112: icmp_seq=5 ttl=63 time=18.8 ms
64 bytes from 192.168.2.112: icmp_seq=6 ttl=63 time=2.11 ms
64 bytes from 192.168.2.112: icmp_seq=7 ttl=63 time=2.81 ms
64 bytes from 192.168.2.112: icmp_seq=8 ttl=63 time=2.79 ms
```

## 感悟
其实在我们没有安装DNS服务之前，可以将/etc/hosts文件比作一个DNS服务配置文件，因为它实现和DNS类似。

之所以会独立出DNS服务，是因为因特网主机多，如果每个主机都靠/etc/hosts文件来维护主机名到ip的映射，那么工作量非常大，对本地更新、网络资源占用都很浪费，所以出现了DNS。




', 0, 0, '2018-03-24 23:28:44', '2018-03-24 23:28:44');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('用jdk自带的keytool导入查看删除证书', '因为需要调用某某银行的接口，应某某银行的要求，需要用jdk自动的工具导入证书，下面是具体操作', 'server', '
## 导入证书
```
sudo keytool -import -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home/jre/lib/security/cacerts -storepass changeit -alias sh2_test -file /Users/kyg/Downloads/sh2_test.cer
```

## 删除证书
```
sudo keytool -delete -alias sh2_test -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home/jre/lib/security/cacerts -storepass changeit
```

## 查看证书
```
keytool -list -alias sh2_test -keystore /Library/Java/JavaVirtualMachines/jdk1.8.0_101.jdk/Contents/Home/jre/lib/security/cacerts -storepass changeit
```

## 提示
- 使用时，jdk路径请自行替换
- 一般cacerts的密码默认为changit
- keytool命令在bin目录下


', 0, 0, '2018-03-24 23:32:13', '2018-03-24 23:32:13');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('给自己的博客生成rss订阅源', '市面上有很多rss阅读器，无广告，让人更专注于阅读，经过研究发现他是经过一定的约定的，你按照一定的格式给我个xml文件，我就能读取出对应的内容', 'server', '## 目的
1. 把我的所有博客全部变成rss订阅源，以便别人订阅。
2. 当我有博客更新时，会自定更新订阅源，或者省事一点每隔30分钟自动更新一次。

## 大致步骤
1. 查询所有博客。
2. 遍历所有博客，按`rss规范`组装成xml。
3. 把组装好的xml写入服务器某个位置，比如放在:`/rss/blog.xml`
4. 在rss阅读器中添加订阅源，url为:`https://kangyonggan.com/upload/rss/blog.xml`
5. 订阅成功，阅读器会把所有博客缓存到本地，离线也可阅读。

<!-- more -->

## 按照rss规范组装xml
使用第三方jar包`rsslibj`，它依赖`exml`,如下:

```
<rsslibj.version>1.0RC2</rsslibj.version>
<exml.version>7.0</exml.version>

<dependency>
    <groupId>rsslibj</groupId>
    <artifactId>rsslibj</artifactId>
    <version>${rsslibj.version}</version>
</dependency>
<dependency>
    <groupId>exml</groupId>
    <artifactId>exml</artifactId>
    <version>${exml.version}</version>
</dependency>
```

代码如下:

```
Channel channel = new Channel();
channel.setTitle("朕的博客");
channel.setLink("http://kangyonggan.com");

String baseUrl = "http://kangyonggan.com/#article/";
String rssName = "blog.xml";

try {
    List<Article> list = articleService.findAllArticles();
    log.info("一共{}篇文章", list.size());

    for (int i = 0; i < list.size(); i++) {
        Article article = list.get(i);
        Item item = new Item();
        item.setTitle(article.getTitle());
        item.setLink(baseUrl + article.getId());
        item.setDcDate(article.getUpdatedTime());
        item.setDescription(MarkdownUtil.markdownToHtml(article.getContent()));

        channel.addItem(i, item);
    }

    File file = new File(PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + rssName);

    if (!file.exists()) {
        file.createNewFile();
    }

    PrintWriter writer = new PrintWriter(new FileWriter(file));
    writer.write(channel.getFeed("rss"));
    writer.flush();
    writer.close();

    FtpUtil.upload(rssName, "rss/");

    log.info("rss刷新成功");
    return "success";
} catch (Exception e) {
    log.error("查询所有文章失败", e);
}
```

但是有个问题，那就是`Item`不能设置发布时间，订阅后在阅读器里看不到文章的发布时间或者更新时间，所以我就从网上重新找了一个，它不去用任何jar包。

## 解决发布时间问题
### Feed.java

```
package com.kangyonggan.blog.model.rss;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @author kangyonggan
 * @date 2017/1/24
 */
@Data
public class Feed {
    String title;
    String link;
    String description;
    String language;
    String copyright;
    String pubDate;
    List<FeedMessage> feedMessages = new ArrayList();

}
```

### FeedMessage.java

```
package com.kangyonggan.blog.model.rss;

import lombok.Data;

/**
 * @author kangyonggan
 * @date 2017/1/24
 */
@Data
public class FeedMessage {

    String title;

    String description;

    String link;

    String author;

    String guid;

    String pubDate;

}
```

### RSSFeedWriter.java

```
package com.kangyonggan.blog.biz.util;


import com.kangyonggan.blog.model.rss.Feed;
import com.kangyonggan.blog.model.rss.FeedMessage;

import javax.xml.stream.XMLEventFactory;
import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.*;
import java.io.FileOutputStream;

/**
 * @author kangyonggan
 * @date 2017/1/24
 */
public class RSSFeedWriter {

    private String outputFile;
    private Feed feed;

    public RSSFeedWriter(Feed feed, String outputFile) {
        this.feed = feed;
        this.outputFile = outputFile;
    }

    public void write() throws Exception {
        XMLOutputFactory outputFactory = XMLOutputFactory.newInstance();

        XMLEventWriter eventWriter = outputFactory.createXMLEventWriter(new FileOutputStream(outputFile));

        XMLEventFactory eventFactory = XMLEventFactory.newInstance();
        XMLEvent end = eventFactory.createDTD("
");

        // Create and write Start Tag

        StartDocument startDocument = eventFactory.createStartDocument();

        eventWriter.add(startDocument);

        // Create open tag
        eventWriter.add(end);

        StartElement rssStart = eventFactory.createStartElement("", "", "rss");
        eventWriter.add(rssStart);
        eventWriter.add(eventFactory.createAttribute("version", "2.0"));
        eventWriter.add(end);

        eventWriter.add(eventFactory.createStartElement("", "", "channel"));
        eventWriter.add(end);

        // Write the different nodes

        createNode(eventWriter, "title", feed.getTitle());

        createNode(eventWriter, "link", feed.getLink());

        createNode(eventWriter, "description", feed.getDescription());

        createNode(eventWriter, "language", feed.getLanguage());

        createNode(eventWriter, "copyright", feed.getCopyright());

        createNode(eventWriter, "pubdate", feed.getPubDate());

        for (FeedMessage entry : feed.getFeedMessages()) {
            eventWriter.add(eventFactory.createStartElement("", "", "item"));
            eventWriter.add(end);
            createNode(eventWriter, "title", entry.getTitle());
            createNode(eventWriter, "description", entry.getDescription());
            createNode(eventWriter, "link", entry.getLink());
            createNode(eventWriter, "author", entry.getAuthor());
            createNode(eventWriter, "guid", entry.getGuid());
            createNode(eventWriter, "pubDate", entry.getPubDate());
            eventWriter.add(end);
            eventWriter.add(eventFactory.createEndElement("", "", "item"));
            eventWriter.add(end);

        }

        eventWriter.add(end);
        eventWriter.add(eventFactory.createEndElement("", "", "channel"));
        eventWriter.add(end);
        eventWriter.add(eventFactory.createEndElement("", "", "rss"));

        eventWriter.add(end);

        eventWriter.add(eventFactory.createEndDocument());

        eventWriter.close();
    }

    private void createNode(XMLEventWriter eventWriter, String name,

                            String value) throws XMLStreamException {
        XMLEventFactory eventFactory = XMLEventFactory.newInstance();
        XMLEvent end = eventFactory.createDTD("
");
        XMLEvent tab = eventFactory.createDTD(" ");
        // Create Start node
        StartElement sElement = eventFactory.createStartElement("", "", name);
        eventWriter.add(tab);
        eventWriter.add(sElement);
        // Create Content
        Characters characters = eventFactory.createCharacters(value);
        eventWriter.add(characters);
        // Create End node
        EndElement eElement = eventFactory.createEndElement("", "", name);
        eventWriter.add(eElement);
        eventWriter.add(end);
    }
}
```

使用如下：

```
Feed feed = new Feed();
feed.setDescription("记录生活、工作和学习时的笔记心得等");
feed.setLink("http://kangyonggan.com");
feed.setTitle("朕的博客");
List<FeedMessage> feedMessages = feed.getFeedMessages();

String baseUrl = "http://kangyonggan.com/#article/";
String rssName = "blog.xml";

try {
    List<Article> list = articleService.findAllArticles();
    log.info("一共{}篇文章", list.size());

    for (int i = 0; i < list.size(); i++) {
        Article article = list.get(i);
        FeedMessage feedMessage = new FeedMessage();

        feedMessage.setTitle(article.getTitle());
        feedMessage.setLink(baseUrl + article.getId());
        feedMessage.setDescription(MarkdownUtil.markdownToHtml(article.getContent()));
        Date date = article.getUpdatedTime();
        date.setTime(date.getTime() - 8 * 60 * 60 * 1000);
        feedMessage.setPubDate(format.format(date));
        feedMessages.add(feedMessage);
    }

    File file = new File(PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + rssName);

    if (!file.exists()) {
        file.createNewFile();
    }

    new RSSFeedWriter(feed, file.getPath()).write();

    FtpUtil.upload(rssName, "rss/");

    log.info("rss刷新成功");
    return "success";
} catch (Exception e) {
    log.error("查询所有文章失败", e);
}
```

## 附rss订阅源和订阅效果

![rss](https://kangyonggan.com/upload/20170125103534094.png)

![reeder](https://kangyonggan.com/upload/20170125103943826.png)


', 0, 0, '2018-03-24 23:34:15', '2018-03-24 23:34:15');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('查询引擎优化方案', '闲来无事便思考了一下查询引擎的问题，总感觉哪里不对劲，故相处如下优化方案', 'server', '## 现状
- 每分钟去查N次数据库，每一次都会扫描几千行，其中N=通道的数量。
- 查的非常频繁，但线上状态为I或E的交易很少很少，有一种杀鸡用牛刀的感觉。
- 第一次查询时间区间太大（30s~90s之间）。
- 查询高峰堆在一个时间点上，不均衡。
- 每分钟启动一个线程，但一此只能启动一个线程。

<!-- more -->

## 优化后
- 不用查数据库。
- 只处理状态为I或E的交易。
- 每次查询时间的区间可以精确到秒, 粒度可自由调控。
- 均衡分布。
- 可以使用线程池，可以N个线程协同处理。

## 具体步骤
创建一个数组`task[List]`，一个时钟线程Thread-timer，长度为12，每5秒走一步，如下图：

![task-arr.png](https://kangyonggan.com/upload/20170315215531865.png)

如果有状态为I或E的交易，就把BankCommand放入task[current_index + 6]的list中【此处有并发问题，加锁即可解决，后面讨论】，并把他的`loop_count`标记为0。

6 * 5s=30s之后，时钟走到刚刚上面那个交易存放的位置，另起线程取出List中loop\\_count等于0的交易之后去查询，再更新beCommand表，并把此list中所有交易的loop\\_count减1，然后清除list中loop\\_count小于0的交易。【另起线程时可以使用线程池】

如果某银行通道的查询需要延迟3分钟后才查询，只需要在放入task中的时候，让loop\\_count等于3。


', 0, 0, '2018-03-24 23:36:02', '2018-03-24 23:36:02');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('手动安装本地jar包到仓库', '有时候jar包不在中央仓库中，这时候就可以用一行命令把jar包安装到本地仓库以供使用了', 'code', '
```
mvn install:install-file -DgroupId=com.kangyonggan.app -DartifactId=simclient -Dversion=1.0-SNAPSHOT -Dpackaging=jar -Dfile=/home/kyg/data/jar/simclient-1.0-SNAPSHOT.jar
```

', 0, 0, '2018-03-24 23:37:25', '2018-03-24 23:37:25');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('手写前端单页面路由SimPage', '前端我一直在用ace admin，在16年底把ace admin ajax（单页面）用在了我的博客中。 现在我想把博客重构一遍，不准备用ace了，可是又想用它的单页面，所以就动手自己写了一个。', 'web', '## simpage.js

```
/**
 * 单页面路由
 *
 * @author kangyonggan
 * @date 2017/3/21
 */
(function ($) {
    /**
     * 获取内容的url
     *
     * @param hash
     * @returns {string}
     */
    function getContentUrl(hash) {
        return window.location.origin + window.location.pathname + hash
    }

    /**
     * 加载成功
     */
    function onSuccess() {
    }

    /**
     * 加载失败
     */
    function onError() {
    }

    /**
     * 总入口
     *
     * @param contentArea
     * @param settings
     */
    function simPage(contentArea, settings) {
        var $contentArea = $(contentArea);
        var $overlay = $();//empty set
        var loadingTimer;
        // 把settings的属性合并到defaults，并且不改变defaults
        settings = $.extend(true, $.fn.simPage.defaults, settings);
        /**
         * 开始加载
         */
        function startLoading() {
            // 清除定时器
            clearInterval(loadingTimer);
            $overlay.remove();
            $overlay = $(''<div>'' + settings.loadingText + ''</div>'').css({
                position: "absolute",
                left: 0,
                top: 0,
                bottom: 0,
                right: 0,
                zIndex: 9999,
                textAlign: "center",
                marginTop: "100px"
            }).addClass("sim-page-loading");
            $contentArea.append($overlay);
            var text = $overlay.html();
            var count = 0;
            // 定时输出正在加载...
            loadingTimer = setInterval(function () {
                var temp = ".";
                for (var i = 0; i < count; i++) {
                    temp += ".";
                }
                $overlay.html(text + temp);
                count++;
                count %= 3;
            }, 1000);
        }

        /**
         * 停止加载
         *
         * @param isSuccess
         */
        function stopLoading(isSuccess) {
            // 清除定时器
            clearInterval(loadingTimer);
            $overlay.remove();
            if (isSuccess) {
                onSuccess();
            } else {
                onError();
            }
        }

        /**
         * 加载url
         *
         * @param url
         * @param method
         * @param data
         */
        function getUrl(url, method, data) {
            if (!method) {
                method = "get";
            }

            // 开始加载
            startLoading();
            $.ajax({
                ''url'': url,
                ''cache'': false,
                "method": method,
                "data": data
            }).error(function () {
                // 停止加载
                stopLoading(false);
                getUrl(getContentUrl("404"));
            }).done(function (result) {
                // 停止加载
                stopLoading(true);
                // 内容替换
                $contentArea.empty().html(result);
            });
        }

        /**
         * 异步加载url
         *
         * @param hash
         * @param cache
         */
        function loadUrl(hash) {
            hash = hash.replace(/^(#!)?#/, '''');
            var url = settings.contentUrl(hash);
            if (typeof url === ''string'') {
                getUrl(url);
            }
        };
        // 监听hash改变
        $(window).off(''hashchange'').on(''hashchange'', function (e, manual_trigger) {
            var hash = $.trim(window.location.hash);
            if (!hash || hash.length == 0) {
                return;
            }

            // 异步加载url
            loadUrl(hash);
        });
        // 是否使用默认URL
        var hash = $.trim(window.location.hash);
        if (!hash && settings.defaultUrl) {
            window.location.hash = settings.defaultUrl;
        }
        loadUrl(hash);
        // 相对定位，给【加载中...】使用
        $contentArea.css("position", "relative");

        // 监听表单提交
        $(document).on("submit", "form", function (e) {
            var $form = $(this);

            var hash = $form.attr("action");
            var method = $form.attr("method");

            if (hash.substring(0, 1) == "#") {
                e.preventDefault();
            } else {
                return true;
            }

            // 处理get方法
            if (method.toLowerCase() == "get") {
                var params = $form.serialize();
                var url = window.location.origin + window.location.pathname + hash + "?" + params;

                window.location.href = url;
            } else if (method.toLowerCase() == "post") {
                var url = window.location.origin + window.location.pathname + hash.substring(1);

                getUrl(url, "post", $form.serialize());
            }

            return false;
        });
    }

    /**
     * 单页面路由
     *
     * @param option
     * @returns {*}
     */
    $.fn.simPage = function (option) {
        return this.each(function () {
            $(this).data(''simPage'', new simPage(this, option));
        });
    };
    /**
     * 默认配置
     *
     * @type {{defaultUrl: string, contentUrl: getContentUrl, loadingText: string, success: onSuccess, error: onError}}
     */
    $.fn.simPage.defaults = {
        // 默认URL（默认index）
        defaultUrl: ''#index'',
        // 内容URL（一般默认即可）
        contentUrl: getContentUrl,
        // 加载中的文字
        loadingText: ''正在加载'',
        // success回调方法
        success: onSuccess,
        // error回调方法
        error: onError
    }
})(window.jQuery);
```

## 用法
```
html
<div class="sim-page"></div>

js
$(".sim-page").simPage();
```

', 1, 0, '2018-03-24 23:38:16', '2018-03-24 23:38:16');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('实现前端markdown编辑器', '在做网站的时候， 一般都有后台管理可以发布一些文章或者公告之类的，一般情况下我们使用的是富文本编辑器（类似word），但我并不喜欢它， 我更喜欢markdown编辑器...', 'web', '## 准备工作
- 下载bootstrap [http://v3.bootcss.com](http://v3.bootcss.com)
- 下载jquery [http://jquery.com/download](http://jquery.com/download)
- 下载marked [https://github.com/chjj/marked](https://github.com/chjj/marked)
- 下载bootstrap-markdown [http://www.codingdrama.com/bootstrap-markdown](http://www.codingdrama.com/bootstrap-markdown/)

<!-- more -->

## 使用方法
### 引入css
```
<div class="hidden ajax-append-link" rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<div class="hidden ajax-append-link" rel="stylesheet" type="text/css" href="css/bootstrap-markdown.min.css">
```

### 引入js

```
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/marked.min.js"></script>
<script type="text/javascript" src="js/bootstrap-markdown.min.js"></script>
```

### 文本域
```
<textarea name="content" id="content" rows="10"><textarea>
```

### 把文本域变为markdown编辑器
```
$("#content").markdown({resize: ''vertical''});
```

## 更多用法请参考
[http://www.codingdrama.com/bootstrap-markdown](http://www.codingdrama.com/bootstrap-markdown/)


', 1, 0, '2018-03-24 23:38:56', '2018-03-24 23:38:56');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('实现全文检索-基于MySQL', '我们经常在网站上能看到搜索框， 可以用空格分割关键词、可以用拼音搜索等...', 'db', '## 把关键字拆分为一组词
例子：搜索`懒人快乐`， 后台程序就会把`懒人快乐`拆分成两个词`懒人,快乐`。

说明：可以使用`jieba-analysis`结巴分词， 用法如下：

```
<dependency>
    <groupId>com.huaban</groupId>
    <artifactId>jieba-analysis</artifactId>
    <version>1.0.2</version>
</dependency>
```

<!-- more -->

```
package com.kangyonggan.blog.util;


import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.SegToken;
import org.apache.commons.lang3.StringUtils;

import java.util.List;

/**
 * @author kangyonggan
 * @date 16/7/22
 */
public class FenCi {

    /**
     * 分词器
     */
    private static final JiebaSegmenter segmenter = new JiebaSegmenter();

    /**
     * 中文分词, 并转成拼音
     *
     * @param data
     * @return
     */
    public static String process(String data) {
        if (StringUtils.isEmpty(data)) {
            return "";
        }

        data = data.replaceAll("\\s", " ");
        data = data.replaceAll("''", " ");

        List<SegToken> list = segmenter.process(data, JiebaSegmenter.SegMode.INDEX);

        StringBuilder sb = new StringBuilder();
        list.forEach(segToken -> sb.append(PinYin.converterToSpellWithMuti(segToken.word)).append(","));
        sb.deleteCharAt(sb.lastIndexOf(","));

        return sb.toString();
    }

}
```

## 把词转化为拼音
例子：`懒人,快乐`会被后台程序转化为`lanren,kuaile,kuaiyue`，之所以不是`lanren,kuaile`而是`lanren,kuaile,kuaiyue`， 是因为`乐`是多音字。

说明：可以使用`pinyin4j`把汉字转化为拼音， 用法如下：

```
<dependency>
     <groupId>com.belerweb</groupId>
     <artifactId>pinyin4j</artifactId>
     <version>2.5.1</version>
</dependency>
```

```
package com.kangyonggan.blog.util;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @date 16/7/22
 */
public class PinYin {

    /**
     * 汉字转换位汉语拼音首字母，英文字符不变，特殊字符丢失 支持多音字，生成方式如（长沙市长:cssc,zssz,zssc,cssz）
     *
     * @param chines 汉字
     * @return 拼音
     */
    public static String converterToFirstSpell(String chines) {
        StringBuffer pinyinName = new StringBuffer();
        char[] nameChar = chines.toCharArray();
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        for (int i = 0; i < nameChar.length; i++) {
            if (nameChar[i] > 128) {
                try {
                    // 取得当前汉字的所有全拼
                    String[] strs = PinyinHelper.toHanyuPinyinStringArray(
                            nameChar[i], defaultFormat);
                    if (strs != null) {
                        for (int j = 0; j < strs.length; j++) {
                            // 取首字母
                            pinyinName.append(strs[j].charAt(0));
                            if (j != strs.length - 1) {
                                pinyinName.append(",");
                            }
                        }
                    }
                    // else {
                    // pinyinName.append(nameChar[i]);
                    // }
                } catch (BadHanyuPinyinOutputFormatCombination e) {
                    e.printStackTrace();
                }
            } else {
                pinyinName.append(nameChar[i]);
            }
            pinyinName.append(" ");
        }
        // return pinyinName.toString();
        return parseTheChineseByObject(discountTheChinese(pinyinName.toString()));
    }

    /**
     * 汉字转换位汉语全拼，英文字符不变，特殊字符丢失
     * 不支持多音字，生成方式如（重当参:zhongdangcen）
     *
     * @param chines 汉字
     * @return 拼音
     */
    public static String converterToSpell(String chines) {
        StringBuffer pinyinName = new StringBuffer();
        char[] nameChar = chines.toCharArray();
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        for (int i = 0; i < nameChar.length; i++) {
            if (nameChar[i] > 128) {
                try {
                    // 取得当前汉字的所有全拼
                    String[] strs = PinyinHelper.toHanyuPinyinStringArray(
                            nameChar[i], defaultFormat);
                    if (strs != null && strs.length > 0) {
                        pinyinName.append(strs[0]);
                    }
                } catch (BadHanyuPinyinOutputFormatCombination e) {
                    e.printStackTrace();
                }
            } else {
                pinyinName.append(nameChar[i]);
            }
            pinyinName.append(" ");
        }
        // return pinyinName.toString();
        return parseTheChineseByObject(discountTheChinese(pinyinName.toString()));
    }

    /**
     * 汉字转换位汉语全拼，英文字符不变，特殊字符丢失
     * 支持多音字，生成方式如（重当参:zhongdangcen,zhongdangcan,chongdangcen
     * ,chongdangshen,zhongdangshen,chongdangcan）
     *
     * @param chines 汉字
     * @return 拼音
     */
    public static String converterToSpellWithMuti(String chines) {
        StringBuffer pinyinName = new StringBuffer();
        char[] nameChar = chines.toCharArray();
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
        for (int i = 0; i < nameChar.length; i++) {
            if (nameChar[i] > 128) {
                try {
                    // 取得当前汉字的所有全拼
                    String[] strs = PinyinHelper.toHanyuPinyinStringArray(
                            nameChar[i], defaultFormat);
                    if (strs != null) {
                        for (int j = 0; j < strs.length; j++) {
                            pinyinName.append(strs[j]);
                            if (j != strs.length - 1) {
                                pinyinName.append(",");
                            }
                        }
                    }
                } catch (BadHanyuPinyinOutputFormatCombination e) {
                    e.printStackTrace();
                }
            } else {
                pinyinName.append(nameChar[i]);
            }
            pinyinName.append(" ");
        }
        // return pinyinName.toString();
        return parseTheChineseByObject(discountTheChinese(pinyinName.toString()));
    }

    /**
     * 去除多音字重复数据
     *
     * @param theStr
     * @return
     */
    private static List<Map<String, Integer>> discountTheChinese(String theStr) {
        // 去除重复拼音后的拼音列表
        List<Map<String, Integer>> mapList = new ArrayList<Map<String, Integer>>();
        // 用于处理每个字的多音字，去掉重复
        Map<String, Integer> onlyOne = null;
        String[] firsts = theStr.split(" ");
        // 读出每个汉字的拼音
        for (String str : firsts) {
            onlyOne = new Hashtable();
            String[] china = str.split(",");
            // 多音字处理
            for (String s : china) {
                Integer count = onlyOne.get(s);
                if (count == null) {
                    onlyOne.put(s, new Integer(1));
                } else {
                    onlyOne.remove(s);
                    count++;
                    onlyOne.put(s, count);
                }
            }
            mapList.add(onlyOne);
        }
        return mapList;
    }

    /**
     * 解析并组合拼音，对象合并方案(推荐使用)
     *
     * @return
     */
    private static String parseTheChineseByObject(
            List<Map<String, Integer>> list) {
        Map<String, Integer> first = null; // 用于统计每一次,集合组合数据
        // 遍历每一组集合
        for (int i = 0; i < list.size(); i++) {
            // 每一组集合与上一次组合的Map
            Map<String, Integer> temp = new Hashtable<String, Integer>();
            // 第一次循环，first为空
            if (first != null) {
                // 取出上次组合与此次集合的字符，并保存
                for (String s : first.keySet()) {
                    for (String s1 : list.get(i).keySet()) {
                        String str = s + s1;
                        temp.put(str, 1);
                    }
                }
                // 清理上一次组合数据
                if (temp != null && temp.size() > 0) {
                    first.clear();
                }
            } else {
                for (String s : list.get(i).keySet()) {
                    String str = s;
                    temp.put(str, 1);
                }
            }
            // 保存组合数据以便下次循环使用
            if (temp != null && temp.size() > 0) {
                first = temp;
            }
        }
        String returnStr = "";
        if (first != null) {
            // 遍历取出组合字符串
            for (String str : first.keySet()) {
                returnStr += (str + ",");
            }
        }
        if (returnStr.length() > 0) {
            returnStr = returnStr.substring(0, returnStr.length() - 1);
        }
        return returnStr;
    }
}
```

## 单独创建一个表用于全文检索
例子：现在有一个文章表`article`, 它有`title`和`body`等字段，我们想要实现的效果是~如果我们检索的关键字在title或body中， 那么我们就把这条文章记录检索出来。

- 创建一个用于检索的表`article_index`， 它有`article_id`，`title`，`body`等字段， 其中title和body字段要给的大一点， 因为这两个字段将要存储文章表的title和body所对应的拼音，具体给多大请自行分析。
- ALTER TABLE article_index ENGINE = MyISAM; 默认是InnoDB。MyISAM：支持全文索引， 但不支持事务。InnoDB：支持事务， 但不支持全文索引。
- ALTER TABLE `article_index` ADD FULLTEXT INDEX (`title`, `body`); 给title和body字段添加全文索引。
- 在发表一篇新的文章时， 把文章的`title`用`结巴分词`分成多个词， 再用`pinyin4j`转化为拼音， `body`字段也做相同处理，最后把转化后的article_id、title和body存储到`article_index`表中，用于全文检索。

说明：关于全文索引的一些常用知识`SHOW VARIABLES LIKE ''ft_min_word_len'';
`， ` REPAIR TABLE article_index QUICK;
` 作用以及用法请自行学习。

## 全文检索
例子：检索的关键字为`懒人快乐`

- 先把分词， 变为`懒人,快乐`。
- 再把汉字变拼音`lanren,kuaile,kuaiyue`。
- 检索：`SELECT * FROM article_index WHERE match(title, body) against(''lanren,kuaile,kuaiyue'' IN BOOLEAN MODE)`
- 根据检索到article_id去文章表查询对应的文章

说明：此检索是基于MySQL的， 其他数据库的检索请自行学习， 检索语句还有很多模式， 请自行学习。

> 结巴分词的时候会返回偏移量，所以你可以根据偏移量定位到文章中的关键词， 然后变成红色。



', 1, 0, '2018-03-24 23:39:53', '2018-03-24 23:39:53');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('学习java8中java.time包下的几个类-LocalDate', '在我之前的一篇文章中提到SimpleDateFormat日期格式化线程安全问题，尽管有了解决方案，但依然不是很爽，接下来我就来学习一下java8中提供的新的日期时间类`java.time`，重新写一个合手的日期时间工具类，不！这些类本身就可以作为工具类了。', 'server', '
> 官方文档:[http://docs.oracle.com/javase/8/docs/api/index.html](http://docs.oracle.com/javase/8/docs/api/index.html)

<!-- more -->

## LocalDate类
### 类的定义
```
public final class LocalDate extends Object implements
    Temporal, TemporalAdjuster, ChronoLocalDate, Serializable
```

### 类的描述
这是一个`不可变`、`线程安全`的日期类，它可以存储年月日，但是不能存储时分秒。

> 常用术语: 日期-年月日，时间-时分秒，日期时间-年月日时分秒

## 获取当前日期
### 方法定义
```
public static LocalDate now();
```

### 方法描述
获取系统当前日期。

### 例子1：

在`pom.xml`中指定使用jdk1.8编译：

```
<!--compiler plugin -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.2</version>
    <configuration>
        <source>1.8</source>
        <target>1.8</target>
        <encoding>UTF-8</encoding>
    </configuration>
</plugin>
```

`LocalDateNowDemo.java`:

```
package com.kangyonggan.demo.time;

import java.time.LocalDate;

/**
 * @author kangyonggan
 * @date 2017/3/22
 */
public class LocalDateNowDemo {

    public static void main(String[] args) {
        LocalDate today = LocalDate.now();
        System.out.println(today);
    }

}
```

输出：

```
2017-03-22
Process finished with exit code 0
```

可以看出它不像java.util.Date那样输出一串乱七八糟的时间，如果我们仅仅使用日期，那会非常爽。
但是，有时候我们需要`yyyyMMdd`格式的日期。

## 日期格式化
### 方法定义
```
public String format(DateTimeFormatter formatter);
```

### 方法描述
把日期格式化指定的格式。

### 抛异常
可能会抛运行时异常`DateTimeException`

### 例子2：

```
public static void main(String[] args) {
    LocalDate today = LocalDate.now();
    System.out.println(today);
    System.out.println(today.format(DateTimeFormatter.ofPattern("yyyyMMdd")));
}
```

输出：

```
2017-03-22
20170322

Process finished with exit code 0
```

每次都写`yyyyMMdd`感觉很麻烦，而且容易错容易忘，再看下面的写法：

### 例子3：

```
public static void main(String[] args) {
    LocalDate today = LocalDate.now();
    System.out.println(today);
    System.out.println(today.format(DateTimeFormatter.BASIC_ISO_DATE));
}
```

输出：

```
2017-03-22
20170322

Process finished with exit code 0
```

输出结果是一样的，这是使用了DateTimeFormatter类中预定义的一些格式器，更多预定义格式器如下：

Formatter | Description  | Example
--------- | ----------- | ---------
ofLocalizedDate(dateStyle) | Formatter with date style from the locale | ''2011-12-03''
ofLocalizedTime(timeStyle) | Formatter with time style from the locale | ''10:15:30''
ofLocalizedDateTime(dateTimeStyle) | Formatter with a style for date and time from the locale | ''3 Jun 2008 11:05:30''
ofLocalizedDateTime(dateStyle,timeStyle) | Formatter with date and time styles from the locale | ''3 Jun 2008 11:05''
BASIC_ISO_DATE | Basic ISO date | ''20111203''
ISO_LOCAL_DATE | ISO Local Date | ''2011-12-03''
ISO_OFFSET_DATE | ISO Date with offset | ''2011-12-03+01:00''
ISO_DATE | ISO Date with or without offset | ''2011-12-03+01:00''; ''2011-12-03''
ISO_LOCAL_TIME | Time without offset | ''10:15:30''
ISO_OFFSET_TIME | Time with offset | ''10:15:30+01:00''
ISO_TIME | Time with or without offset | ''10:15:30+01:00''; ''10:15:30''
ISO_LOCAL_DATE_TIME | ISO Local Date and Time | ''2011-12-03T10:15:30''
ISO_OFFSET_DATE_TIME | Date Time with Offset | ''2011-12-03T10:15:30+01:00''
ISO_ZONED_DATE_TIME | Zoned Date Time | ''2011-12-03T10:15:30+01:00[Europe/Paris]''
ISO_DATE_TIME | Date and time with ZoneId | ''2011-12-03T10:15:30+01:00[Europe/Paris]''
ISO_ORDINAL_DATE | Year and day of year | ''2012-337''
ISO_WEEK_DATE | Year and Week | 2012-W48-6''
ISO_INSTANT | Date and Time of an Instant | ''2011-12-03T10:15:30Z''
RFC_1123_DATE_TIME | RFC 1123 / RFC 822 | ''Tue, 3 Jun 2008 11:05:30 GMT''

刚刚是把日期格式化，下面方法是相反的操作，即把指定格式的字符串解析成日期。

## 日期解析
### 方法定义
```
public static LocalDate parse(CharSequence text);
```

### 方法描述
把`固定格式`的字符串解析成日期，字符串格式必须为:`yyyy-MM-dd`

### 抛异常
如果字符串不能被解析就会抛异常`DateTimeParseException`

### 例子4：

```
public static void main(String[] args) {
    String dateStr = "2017-03-22";
    LocalDate localDate = LocalDate.parse(dateStr);
    System.out.println(localDate);
}
```

输出：

```
2017-03-22

Process finished with exit code 0
```

### 例子5：

```
public static void main(String[] args) {
    String dateStr = "2017-3-22";
    LocalDate localDate = LocalDate.parse(dateStr);
    System.out.println(localDate);
}
```

输出：

```
Exception in thread "main" java.time.format.DateTimeParseException: Text ''2017-3-22'' could not be parsed at index 5
  at java.time.format.DateTimeFormatter.parseResolved0(DateTimeFormatter.java:1949)
  at java.time.format.DateTimeFormatter.parse(DateTimeFormatter.java:1851)
  at java.time.LocalDate.parse(LocalDate.java:400)
  at java.time.LocalDate.parse(LocalDate.java:385)
  at com.kangyonggan.demo.time.LocalDateParseDemo.main(LocalDateParseDemo.java:14)

Process finished with exit code 1
```

比较例4和例5，发现parse方法对字符串的要求还是比较严格的，一旦解析不了就会抛异常。
在实际开发中，我们的字符串不可能都是yyyy-MM-dd型的，LocalDate还提供了另外一个同名方法。

## 日期解析（指定格式）
### 方法定义
```
public static LocalDate parse(CharSequence text, DateTimeFormatter formatter);
```

### 方法描述
把指定格式的字符串解析成日期。

### 抛异常
如果字符串不能被解析就会抛异常`DateTimeParseException`

### 例子6：

```
public static void main(String[] args) {
    String dateStr = "20170322";
    LocalDate localDate = LocalDate.parse(dateStr, DateTimeFormatter.BASIC_ISO_DATE);
    System.out.println(localDate);
}
```

输出：

```
2017-03-22

Process finished with exit code 0
```

这个例子中我使用的是预定义的格式器，当然你也可以自己定义格式。
相比SimpleDateFormat，这个方法是线程安全的，且提供了一大批预定义的格式器。

## 其他常用方法
LocalDate类中还提供了一些其他方法，比如：

方法定义 | 描述
------- | ------
public int getYear() | 获取年
public int getMonthValue() | 获取月
public int getDayOfMonth() | 获取日
public boolean isAfter(ChronoLocalDate other) | 判断是否在other日期之后
public boolean isBefore(ChronoLocalDate other) | 判断是否在other日期之前
public boolean isEqual(ChronoLocalDate other) | 判断和other日期是否相等
public boolean isLeapYear() | 判断是否是闰年
public int lengthOfMonth() | 返回一个月有多少天
public int lengthOfYear() | 返回一年有多少天
public static LocalDate of(int year, int month, int dayOfMonth) | 返回一个日期
public LocalDate minusDays(long daysToSubtract) | 减去n天，返回一个新的LocalDate
public LocalDate minusWeeks(long weeksToSubtract) | 减去n周，返回一个新的LocalDate
public LocalDate minusMonths(long monthsToSubtract) | 减去n月，返回一个新的LocalDate
public LocalDate minusYears(long yearsToSubtract) | 减去n年，返回一个新的LocalDate
public LocalDate plusDays(long daysToSubtract) | 加上n天，返回一个新的LocalDate
public LocalDate plusWeeks(long weeksToSubtract) | 加上n周，返回一个新的LocalDate
public LocalDate plusMonths(long monthsToSubtract) | 加上n月，返回一个新的LocalDate
public LocalDate plusYears(long yearsToSubtract) | 加上n年，返回一个新的LocalDate

> LocalDate类中远不止这些方法，具体请查看官方文档。


', 0, 0, '2018-03-24 23:40:31', '2018-03-24 23:40:31');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('学习java8中java.time包下的几个类-LocalTime', ' 上一篇文章中学习了`LocalDate`类，学到了一些关于日期的一些用法，这一章中学习一下`LocalTime`的用法。', 'server', '
> 官方文档：[http://docs.oracle.com/javase/8/docs/api/index.html](http://docs.oracle.com/javase/8/docs/api/index.html)

<!-- more -->

## LocalTime类
### 类的定义
```
public final class LocalTime extends Object implements
      Temporal, TemporalAdjuster, Comparable<LocalTime>, Serializable
```

### 类的描述
这是一个`不可变`、`线程安全`的时间类，它可以存储时分秒（毫秒），但是不能存储年月日。

## 获取当前时间
### 方法定义
```
public static LocalTime now();
```

### 方法描述
获取系统当前时间。

### 例子1：

```
public static void main(String[] args) {
    LocalDate today = LocalDate.now();
    System.out.println(today);
}
```

输出：

```
15:44:38.220

Process finished with exit code 0
```

## 时间格式化
### 方法定义
```
public String format(DateTimeFormatter formatter);
```

### 方法描述
把时间格式化指定的格式。

### 抛异常
可能会抛运行时异常DateTimeException

### 例子2：
```
public static void main(String[] args) {
    LocalTime today = LocalTime.now();
    System.out.println(today);
    System.out.println(today.format(DateTimeFormatter.ofPattern("HHmmss")));
    System.out.println(today.format(DateTimeFormatter.ISO_LOCAL_TIME));
}
```

输出：

```
15:51:29.885
155129
15:51:29.885

Process finished with exit code 0
```

其中，`DateTimeFormatter`类中一些预定义的格式器，请参考上一篇文章:
[学习java8中java.time包下的几个类-LocalDate](http://kangyonggan.com/2017/03/25/学习java8中java-time包下的几个类-LocalDate/)

## 时间解析
### 方法定义
```
public static LocalTime parse(CharSequence text);
```

### 方法描述
把固定格式的字符串解析成时间，字符串格式必须为一下几种之一（亲测）:

- HH:mm
- HH:mm:ss
- HH:mm:ss.S
- HH:mm:ss.SS
- HH:mm:ss.SSS

不能为：

- HH
- HH:m:ss

### 抛异常
如果字符串不能被解析就会抛异常DateTimeParseException

### 例子4：
```
public static void main(String[] args) {
    String dateStr = "15:57:04";
    LocalTime localTime = LocalTime.parse(dateStr);
    System.out.println(localTime);
}
```

输出：

```
15:57:04

Process finished with exit code 0
```

### 例子5：
```
public static void main(String[] args) {
    String dateStr = "155704";
    LocalTime localTime = LocalTime.parse(dateStr, DateTimeFormatter.ofPattern("HHmmss"));
    System.out.println(localTime);
}
```

输出：

```
15:57:04

Process finished with exit code 0
```

## 其他常用方法
请参考上一篇文章或者官方文档。
', 0, 0, '2018-03-24 23:40:59', '2018-03-24 23:40:59');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('学习java8中java.time包下的几个类-LocalDateTime', '前两篇文章中学习了`LocalDate`和`LocalTime`类，学到了一些关于日期和时间的一些用法，这一章中学习一下`LocalDateTime`的用法。', 'server', '
> 官方文档：[http://docs.oracle.com/javase/8/docs/api/index.html](http://docs.oracle.com/javase/8/docs/api/index.html)



<!-- more -->

## LocalDateTime类
### 类的定义
```
public final class LocalDateTime extends Object implements
    Temporal, TemporalAdjuster, ChronoLocalDateTime<LocalDate>, Serializable
```

### 类的描述
这是一个`不可变`、`线程安全`的时间类，它可以存储年月日时分秒（毫秒）。

## 获取当前日期时间
### 方法定义
```
public static LocalDateTime now();
```

### 方法描述
获取系统当前日期时间。

### 例子1：

```
public static void main(String[] args) {
    LocalDateTime today = LocalDateTime.now();
    System.out.println(today);
}
```

输出：

```
2017-03-22T16:10:02.586

Process finished with exit code 0
```

## 日期时间格式化
### 方法定义
```
public String format(DateTimeFormatter formatter);
```

### 方法描述
把日期时间格式化指定的格式。

### 抛异常
可能会抛运行时异常DateTimeException

### 例子2：
```
public static void main(String[] args) {
    LocalDateTime today = LocalDateTime.now();
    System.out.println(today);
    System.out.println(today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS")));
    System.out.println(today.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
}
```

输出：

```
2017-03-22T16:12:51.661
2017-03-22 16:12:51.661
2017-03-22T16:12:51.661

Process finished with exit code 0
```

其中，`DateTimeFormatter`类中一些预定义的格式器，请参考之前的一篇文章:
[学习java8中java.time包下的几个类 - LocalDate](http://kangyonggan.com/#article/91)

## 日期时间解析
### 方法定义
```
public static LocalDateTime parse(CharSequence text);
```

### 方法描述
把固定格式的字符串解析成日期时间，字符串格式必须为`2017-03-22T15:57:04`。

### 抛异常
如果字符串不能被解析就会抛异常DateTimeParseException

### 例子4：
```
public static void main(String[] args) {
    String dateStr = "2017-03-22T15:57:04";
    LocalDateTime localDateTime = LocalDateTime.parse(dateStr);
    System.out.println(localDateTime);
}
```

输出：

```
2017-03-22T15:57:04

Process finished with exit code 0
```

### 例子5：
```
public static void main(String[] args) {
    String dateStr = "2017-03-22 15:57:04";
    LocalDateTime localDateTime = LocalDateTime.parse(dateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    System.out.println(localDateTime);
}
```

输出：

```
2017-03-22T15:57:04

Process finished with exit code 0
```

## 其他常用方法
请参考`学习java8中java.time包下的几个类-LocalDate`或者官方文档。




', 0, 0, '2018-03-24 23:41:25', '2018-03-24 23:41:25');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('如何把内网机器变成外网可以访问的服务器', '我之前买了阿里云服务器，但是内存只有1个G，随便安装一点东西就满了，所以就需要把内网机器变成外网可以访问的服务器', 'linux', '
## 环境准备
1. 需要一台内网机器（性能越强越好）【192.168.1.100】
2. 一个有公网IP的路由器，或者移动内网或者电信内网IP都可以【101.245.198.155】
3. 一个公网服务器（不需要内存太大，1G足够）【121.40.66.176】

> 路由器和公网服务器要能互通，如果不通，可以尝试重启路由器，重启的作用是换一个新的ip，也许就通了

<!-- more -->

## 步骤
1. 把服务器部署在内网机器上，比如我的博客在内网可以访问:192.168.1.100:8088
2. 登录路由器，配置“端口转发”，把请求路由器8088端口的请求，转发到请求192.168.1.100:8088
3. 登录公网服务器，执行远程端口转发命令：

```
ssh -C -f -N -g -L 80:101.245.198.155:8088 kyg@101.245.198.155
```

表示，请求公网80端口的请求，会被转发到路由器（101.245.198.155）的8088端口

## 保持转发链接不中断（自动重连）
查看任务
`crontab -l`

创建任务
`crontab -e`

每小时重连一次
`0 * * * * sh conn.sh`
', 1, 0, '2018-03-24 23:42:54', '2018-03-24 23:42:54');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('多环境下autoconfig使用的小例子', '在java开发中，我们使用最多的项目管理工具就是maven，它能给我们按环境打包，但是有时候我们不想把环境相关的配置文件跟随代码一起提交，这时候就可以使用autoconfig了', 'server', '
## 为什么使用Autoconfig
在一个应用中，我们总是会遇到一些参数，例如：

- 数据库服务器IP地址、端口、用户名；
- 用来保存上传资料的目录。
- 一些参数，诸如是否打开cache、加密所用的密钥名称等等。

这些参数有一个共性，那就是：它们和应用的逻辑无关，只和当前环境、当前系统用户相关。以下场景很常见：

- 在开发、测试、发布阶段，使用不同的数据库服务器；
- 在开发阶段，使用Windows的A开发者将用户上传的文件存放在d:my_upload目录中，而使用Linux的B开发者将同样的文件存放在/home/myname/my_upload目录中。
- 在开发阶段设置cache=off，在生产环境中设置cache=on。
- 很明显，这些参数不适合被“硬编码”在配置文件或代码中。因为每一个从源码库中取得它们的人，都有可能需要修改它们，使之与自己的环境相匹配, autoconfig就是很好的选择。

<!-- more -->

## 引入插件
在`pom.xml`中引入插件，下面为多环境配置

```
<plugin.autoconfig.version>1.2</plugin.autoconfig.version>

...

<!-- autoconfig -->
<plugin>
    <groupId>com.alibaba.citrus.tool</groupId>
    <artifactId>autoconfig-maven-plugin</artifactId>
    <version>${plugin.autoconfig.version}</version>
    <executions>
        <execution>
            <id>compile</id>
            <phase>compile</phase>
            <goals>
                <goal>autoconfig</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <userProperties>${antx.path}</userProperties>
    </configuration>
</plugin>

...

<profiles>
    <profile>
        <id>dev</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <antx.path>${user.home}/antx-dev.properties</antx.path>
        </properties>
    </profile>
    <profile>
        <id>prod</id>
        <properties>
            <antx.path>${user.home}/antx-prod.properties</antx.path>
        </properties>
    </profile>
</profiles>
```

## 配置
在`src/main/resources`下创建目录`Meta-INF/autoconfig`，在目录下创建文件`auto-config.xml`, 下面是我的配置（依个人而定）:

```
<?xml version="1.0" encoding="UTF-8"?>
<config>
    <group>
        <!-- dubbo -->
        <property name="api.dubbo.name" description="项目名字" defaultValue="api"></property>
        <property name="api.dubbo.registry.address" description="dubbo注册地址"
                  defaultValue="zookeeper://127.0.0.1:2181?backup=127.0.0.1:2182,127.0.0.1:2183"></property>
        <property name="api.dubbo.protocol.port" description="dubbo注册端口" defaultValue="-1"></property>
        <property name="api.dubbo.timeout" description="dubbo超时时间" defaultValue="10000"></property>
        <property name="api.dubbo.api.version" description="api提供接口的版本" defaultValue="1.0.0"></property>

        <!-- redis -->
        <property name="api.redis.maxTotal" description="redis最大连接数" defaultValue="1000"></property>
        <property name="api.redis.minIdle" description="redis最小等待数" defaultValue="50"></property>
        <property name="api.redis.maxIdle" description="redis最大等待数" defaultValue="100"></property>
        <property name="api.redis.testOnBorrow" description="redis测试支持" defaultValue="true"></property>
        <property name="api.redis.host" description="redis主机ip" defaultValue="127.0.0.1"></property>
        <property name="api.redis.port" description="redis主机端口" defaultValue="6379"></property>
        <property name="api.redis.password" description="redis密码" defaultValue="123456"></property>

        <!--jdbc-->
        <property name="api.jdbc.driver" description="jdbc驱动" defaultValue="com.mysql.jdbc.Driver"></property>
        <property name="api.jdbc.url" description="jdbc地址" defaultValue="jdbc:mysql://127.0.0.1:3306/api"></property>
        <property name="api.jdbc.username" description="jdbc用户名" defaultValue="root"></property>
        <property name="api.jdbc.password" description="jdbc密码" defaultValue="123456"></property>

        <!-- log4j2 -->
        <property name="api.log4j2.home" description="log4j2日志的文件主目录" defaultValue="/root/logs/api"></property>

        <property name="api.slow.method.time" description="慢方法时间(秒)" defaultValue="10"></property>
        <property name="api.slow.interface.time" description="慢接口时间(秒)" defaultValue="10"></property>
        <property name="api.redis.prefix.key" description="redis键的前缀" defaultValue="api"></property>
        <property name="api.cache.open" description="是否开启缓存,Y:开启,N:不开启" defaultValue="Y"></property>
    </group>
    <script>
        <generate template="app.properties"></generate>
        <generate template="applicationContext-datasource.xml"></generate>
        <generate template="applicationContext-provider.xml"></generate>
        <generate template="applicationContext-redis.xml"></generate>
        <generate template="log4j2.xml"></generate>
    </script>
</config>
```

## 使用
在上一步中可以看到antx将会替换五个文件，下面是其中一个文件的配置`applicationContext-redis.xml`:

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:p="http://www.springframework.org/schema/p"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
ohttp://www.springframework.org/schema/beans/spring-beans-4.0.xsd">

    <bean id="poolConfig" class="redis.clients.jedis.JedisPoolConfig">
        <property name="maxTotal" value="${api.redis.maxTotal}"></property>
        <property name="minIdle" value="${api.redis.minIdle}"></property>
        <property name="maxIdle" value="${api.redis.maxIdle}"></property>
        <property name="testOnBorrow" value="${api.redis.testOnBorrow}"></property>
    </bean>

    <bean id="jedisConnectionFactory" class="org.springframework.data.redis.connection.jedis.JedisConnectionFactory"
          p:hostName="${api.redis.host}" p:port="${api.redis.port}" p:password="${api.redis.password}" p:poolConfig-ref="poolConfig"></bean>

    <bean id="redisTemplate" class="org.springframework.data.redis.core.RedisTemplate">
        <property name="connectionFactory" ref="jedisConnectionFactory"></property>
        <property name="keySerializer">
            <bean class="org.springframework.data.redis.serializer.StringRedisSerializer" ></bean>
        </property>
        <property name="valueSerializer">
            <bean class="org.springframework.data.redis.serializer.JdkSerializationRedisSerializer"></bean>
        </property>
    </bean>
</beans>
```

> 在项目`mvn clean install`的时候，antx会自动替换它所包含的文件，可以再`target`目录下查看指定的文件是否被替换成功

', 0, 0, '2018-03-24 23:45:27', '2018-03-24 23:45:27');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('在ubuntu14.04下安装nginx服务器', '因为我的服务器是内网机器，外网机器内存太小，所以我就使用了nginx做请求转发，下面是nginx的简单安装、配置和使用', 'linux', '
## 下载安装
```
sudo apt-get install nginx
```

安装完成后打开浏览器输入`http://localhost`, 看到下图代表安装成功:

<!-- more -->

![nginx](https://kangyonggan.com/upload/20170101125316443.png)

### 常用命令
1. 启动: `nginx -c /etc/nginx/nginx.conf`
2. 停止: `nginx -s stop`
3. 重新加载（配置）: `nginx -s reload`
4. 重新打开日志文件: `nginx -s reopen`

## 动静分离反向代理配置
修改`/etc/nginx/sites-available/default`配置:

```
server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.html index.htm;

        # Make site accessible from http://localhost/
        server_name localhost;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                # try_files $uri $uri/ =404;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
                proxy_pass http://localhost:8088;
        }

        # 设定访问静态文件直接读取不经过tomcat
        location ^~ /static/ {
                proxy_pass http://localhost:8088;
                root /WEB-INF/static/;
        }
}
```

', 0, 0, '2018-03-24 23:46:55', '2018-03-24 23:46:55');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用配置中心代替properties', '为了公司内部的统一配置，很多公司都有自己的一套统一配置中心，下面是一个简单的统一配置中心', 'server', '## 生成一个项目`configcenter`
用`cms-archetype`生成一个项目，然后在此基础上开发一个模块，用于管理配置信息（CRUD）

我写的配置中心在github上: [https://github.com/kangyonggan/configcenter.git](https://github.com/kangyonggan/configcenter.git)

<!-- more -->

## 原理
在spring把占位符替换之前，发送http get请求到配置中心读取配置，拿到此项目的所有配置信息后（json），把json数据解析成一对对的名值对，最后把所有的名值对全部放入系统配置中，即:`System.setProperty(name, value);`。

## 具体实现

在`applicationContext.xml`的最上方（也不一定最上，但一定要在所有占位符的上面）添加自定义的`bean`:

```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
       xsi:schemaLocation="http://www.springframework.org/schema/aop
ohttp://www.springframework.org/schema/aop/spring-aop-4.0.xsd
ohttp://www.springframework.org/schema/beans
ohttp://www.springframework.org/schema/beans/spring-beans-4.0.xsd
ohttp://www.springframework.org/schema/tx
ohttp://www.springframework.org/schema/tx/spring-tx-4.0.xsd
ohttp://www.springframework.org/schema/context
ohttp://www.springframework.org/schema/context/spring-context-4.0.xsd">

    <!-- Activates annotation-based bean configuration -->
    <context:annotation-config></context:annotation>

    <!-- 读取属性文件，否则 java 类无法直接读取属性 -->
    <context:property-placeholder location="classpath:app.properties"></context:property>

    <!-- 读取配置中心 -->
    <bean class="com.kangyonggan.archetype.cmscc.biz.core.MyPropertyPlaceholderConfigurer" ></bean>

    ...
</beans>
```

`MyPropertyPlaceholderConfigurer.java`的实现:

```
package com.kangyonggan.archetype.cmscc.biz.core;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.kangyonggan.archetype.cmscc.biz.util.HttpUtil;
import com.kangyonggan.archetype.cmscc.biz.util.PropertiesUtil;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

/**
 * @author kangyonggan
 * @date 2017/1/25
 */
@Log4j2
public class MyPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {

    public MyPropertyPlaceholderConfigurer() {
        loadConfigs();
    }

    /**
     * 加载配置
     */
    private void loadConfigs() {
        String server = PropertiesUtil.getProperties("config.center.server");
        log.info("配置中心服务地址:{}", server);

        String data = HttpUtil.sendGet(server);

        if (StringUtils.isEmpty(data)) {
            throw new RuntimeException("读取配置中心异常");
        }

        log.info("已成功获取配置中心的配置");

        JSONObject jsonObject = JSON.parseObject(data);
        String errCode = (String) jsonObject.get("errCode");
        String errMsg = (String) jsonObject.get("errMsg");

        log.info("errCode:{}", errCode);
        log.info("errMsg:{}", errMsg);

        if (!"success".equals(errCode)) {
            throw new RuntimeException("读取配置中心失败");
        }

        JSONArray jsonArray = jsonObject.getJSONArray("configs");
        log.info("共有{}项配置!", jsonArray.size());

        load(jsonArray);
    }

    /**
     * 加载配置
     *
     * @param jsonArray
     */
    public static void load(JSONArray jsonArray) {
        for (int i = 0; i < jsonArray.size(); i++) {
            JSONObject object = jsonArray.getJSONObject(i);
            log.info("正在存储配置:{}", object);

            String name = object.getString("name");
            String value = object.getString("value");

            System.setProperty(name, value);
            PropertiesUtil.putProperties(name, value);
        }

        log.info("从配置中心加载配置完毕！！！");
    }

}
```

其中`public static void load(JSONArray jsonArray) `之所以写成了`static`是因为我其他地方也想使用, 比如：我发现ftp的ip配置错了，然后修改了ftp的ip，但是又不想重启服务器，这时候我就会在配置中心的控制台上点一下`推送配置`,然后客户端项目就能接收到配置了，然后就需要调用load方法刷新一下内存中的配置，但有些配置刷了也没用，比如jdbc的url等。

接收配置的代码`ConfigcenterController.java`:

```
package com.kangyonggan.archetype.cmscc.web.controller.web;

import com.alibaba.fastjson.JSONArray;
import com.kangyonggan.archetype.cmscc.biz.core.MyPropertyPlaceholderConfigurer;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.net.URLDecoder;

/**
 * @author kangyonggan
 * @date 2017/1/27
 */
@Controller
@RequestMapping("configcenter")
@Log4j2
public class ConfigcenterController {

    /**
     * 接收配置中心推送过来的配置
     *
     * @param data
     */
    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public boolean receiver(@RequestParam("data") String data) {
        try {
            data = URLDecoder.decode(data, "UTF-8");
            MyPropertyPlaceholderConfigurer.load(JSONArray.parseArray(data));
        } catch (Exception e) {
            log.error("接收配置失败", e);
            return false;
        }
        return true;
    }

}
```

## 注意
#### 日志的目录不能配置在配置中心，因为在读取配置中心的配置之前就使用到了日志，我的解决方案是写入了`pom.xml`, 如：`<log4j2.home>/Users/kyg/logs/cmscc</log4j2.home>`
#### 配置中心服务器的地址配置在了`app.properties`，因为配置中心的地址是可能变的，所以不能硬编码，如：`app.proerperties`的内容:

```
config.center.server=http://localhost:7777/configuration?proj=${project.parent.artifactId}&env=${env}
```

其中`${project.parent.artifactId}`会取自`pom.xml`中父模块的artifactId,
`${env}`指的是环境，比如开发环境，联调环境，生产环境等。我写在了pom.xml中:

```
<profiles>
    <profile>
        <id>local</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <env>local</env>
        </properties>
    </profile>
    <profile>
        <id>dev</id>
        <properties>
            <env>local</env>
        </properties>
    </profile>
    <profile>
        <id>uat</id>
        <properties>
            <env>local</env>
        </properties>
    </profile>
    <profile>
        <id>hd</id>
        <properties>
            <env>local</env>
        </properties>
    </profile>
    <profile>
        <id>prod</id>
        <properties>
            <env>local</env>
        </properties>
    </profile>
</profiles>
```

我把使用配置中心的项目也写了一个项目原型,地址在:[https://github.com/kangyonggan/cmscc-archetype.git](https://github.com/kangyonggan/cmscc-archetype.git)

## 附配置中心推送配置的代码
```
/**
 * 推送配置
 *
 * @param id
 * @param env
 * @return
 */
@RequestMapping(value = "push", method = RequestMethod.POST)
@RequiresPermissions("CORE_PROJECT")
@ResponseBody
public Map<String, Object> push(@RequestParam("id") Long id, @RequestParam("env") String env) {
    Map<String, Object> resultMap = getResultMap();
    Project project = projectService.findProjectById(id);

    if (project != null && StringUtils.isNotEmpty(project.getPushUrl())) {
        List<Configuration> configurations = configurationService.findProjectConfigurations(project.getCode(), env);
        String json = JSON.toJSONString(configurations);
        try {
            String data = URLEncoder.encode(json, "UTF-8");
            String result = HttpUtil.sendPost(project.getPushUrl(), "data=" + data);
            if (!"true".equals(result)) {
                setResultMapFailure(resultMap, "推送失败，请稍后再试！");
            }
        } catch (Exception e) {
            log.error("推送配置失败", e);
            setResultMapFailure(resultMap);
        }
    } else {
        setResultMapFailure(resultMap);
    }

    return resultMap;
}
```




', 0, 0, '2018-03-24 23:49:00', '2018-03-24 23:49:00');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用U盘安装CentOS7最小安装版', '公司一直使用的是CentOS7, 而我个人一直使用的是ubuntu，所以最近想安装一个CentOS7试一下', 'linux', '
## 下载镜像文件和刻录工具
1. CentOS7最小安装版镜像文件下载地址：[http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1611.iso)

2. 刻录工具下载地址：[https://cn.ultraiso.net/uiso9_cn.exe](https://cn.ultraiso.net/uiso9_cn.exe)

<!-- more -->

## 把系统镜像刻录到U盘
打开刻录工具`UltraISO`，【文件】-->【打开】-->【选择下载好的镜像CentOS-7-x86_64-Minimal-1611.iso】

![打开镜像](https://kangyonggan.com/upload/centos-001.png)

【启动】-->【写入硬盘映像...】

![写入硬盘映像](https://kangyonggan.com/upload/centos-002.png)

这个过程会格式化U盘，请先备份U盘内的数据，然后点击【写入】，写入过程需要一些时间。

![写入](https://kangyonggan.com/upload/centos-003.png)

一会之后，写入完成！至此，你就完成了准备工作“把系统镜像刻录到U盘”，接下来就是要用U盘安装系统了。

![写入成功](https://kangyonggan.com/upload/centos-004.png)

## 使用U盘启动
在按开机按钮后，点按F12（大多数品牌的电脑都是按F12进入一次性启动项），进入启动项后，选择带USB字样的那一项进入

![bios-usb](https://kangyonggan.com/upload/centos-005.jpg)

进入CentOS7的安装界面，选择第一行`Install CentOS Linux 7`

![安装CentOS7](https://kangyonggan.com/upload/centos-006.jpg)

## 安装系统
选择系统语言，这里我选择的是英语（推荐使用英语）。

![选择语言](https://kangyonggan.com/upload/centos-015.jpg)

选择磁盘，点击【SYSTEM】-->【INSTALLION DESTINATION】

![选择磁盘](https://kangyonggan.com/upload/centos-007.jpg)

选中自己电脑的硬盘，点击【Done】

![选中自己电脑的硬盘](https://kangyonggan.com/upload/centos-008.jpg)

释放磁盘空间，点击【Reclaim space】

![释放磁盘空间](https://kangyonggan.com/upload/centos-009.jpg)

删除老系统占用的空间，点击【Delete】

![删除老系统占用的空间](https://kangyonggan.com/upload/centos-010.jpg)

删除后点击【Reclaim space】完成。

![删除老系统占用的空间完成](https://kangyonggan.com/upload/centos-011.jpg)

开始安装，点击【Begin Installation】

![开始安装](https://kangyonggan.com/upload/centos-012.jpg)

此时会进入漫长的安装过程（机器配置好的话会很快），点击【ROOT PASSWORD】设置root的密码。

![设置root的密码](https://kangyonggan.com/upload/centos-013.jpg)

root密码设置完成后点击【DONE】

![设置root的密码完成](https://kangyonggan.com/upload/centos-014.jpg)

然后就等吧，直到右下角出现【Reboot】，说明安装完毕！

![安装完毕](https://kangyonggan.com/upload/centos-016.jpg)



', 0, 0, '2018-03-24 23:50:19', '2018-03-24 23:50:19');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用openssl生成RSA密钥对', '如果在通讯中需要对数据进行加密解密，下面就是一个加密方案', 'server', '
## 生成秘钥对
### 生成RSA私钥，以X509编码，指定生成的密钥的位数为2048位，该步生成的私钥只是临时文件，以便第二步将私钥转为PKCS#8编码。

```
openssl genrsa -out rsa_private_key_2048.pem 2048
```

<!-- more -->

### 将上一步生成的RSA私钥转换成PKCS#8编码，作为最终使用的私钥。

```
openssl pkcs8 -topk8 -in rsa_private_key_2048.pem -out pkcs8_rsa_private_key_2048.pem -nocrypt
```

### 导出RSA公钥，以X509编码，作为最终交换的公钥。

```
openssl rsa -in rsa_private_key_2048.pem -out rsa_public_key_2048.pem -pubout
```

> 注：一般Linux系统都装有openssl工具，在windows下可以安装OpenSSL工具包。

## 用法
### 加密工具
`CryptoUtil.java`:

```
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import lombok.extern.log4j.Log4j2;
import java.io.*;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

/**
 * @author kangyonggan
 * @date 2016/12/27
 */
@Log4j2
public class CryptoUtil {

    /**
     * 获取公钥对象
     *
     * @param inputStream  公钥输入流
     * @param keyAlgorithm 密钥算法
     * @return 公钥对象
     * @throws Exception
     */
    public static PublicKey getPublicKey(InputStream inputStream, String keyAlgorithm) throws Exception {
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
            StringBuilder sb = new StringBuilder();
            String readLine;
            while ((readLine = br.readLine()) != null) {
                if (readLine.charAt(0) == ''-'') {
                    continue;
                } else {
                    sb.append(readLine);
                    sb.append(''
'');
                }
            }
            X509EncodedKeySpec pubX509 = new X509EncodedKeySpec(Base64.decodeBase64(sb.toString()));
            KeyFactory keyFactory = KeyFactory.getInstance(keyAlgorithm);
            PublicKey publicKey = keyFactory.generatePublic(pubX509);

            return publicKey;
        } catch (FileNotFoundException e) {
            throw new Exception("公钥路径文件不存在");
        } catch (IOException e) {
            throw new Exception("读取公钥异常");
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(String.format("生成密钥工厂时没有[%s]此类算法", keyAlgorithm));
        } catch (InvalidKeySpecException e) {
            throw new Exception("生成公钥对象异常");
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (IOException e) {
                log.error(e);
            }
        }
    }

    /**
     * 获取私钥对象
     *
     * @param inputStream  私钥输入流
     * @param keyAlgorithm 密钥算法
     * @return 私钥对象
     * @throws Exception
     */
    public static PrivateKey getPrivateKey(InputStream inputStream, String keyAlgorithm) throws Exception {
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
            StringBuilder sb = new StringBuilder();
            String readLine;
            while ((readLine = br.readLine()) != null) {
                if (readLine.charAt(0) == ''-'') {
                    continue;
                } else {
                    sb.append(readLine);
                    sb.append(''
'');
                }
            }
            PKCS8EncodedKeySpec priPKCS8 = new PKCS8EncodedKeySpec(Base64.decodeBase64(sb.toString()));
            KeyFactory keyFactory = KeyFactory.getInstance(keyAlgorithm);
            PrivateKey privateKey = keyFactory.generatePrivate(priPKCS8);

            return privateKey;
        } catch (FileNotFoundException e) {
            throw new Exception("私钥路径文件不存在");
        } catch (IOException e) {
            throw new Exception("读取私钥异常");
        } catch (NoSuchAlgorithmException e) {
            throw new Exception("生成私钥对象异常");
        } catch (InvalidKeySpecException e) {
            throw new Exception("生成私钥对象异常");
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (IOException e) {
                log.error(e);
            }
        }
    }

    /**
     * 数字签名函数入口
     *
     * @param plainBytes    待签名明文字节数组
     * @param privateKey    签名使用私钥
     * @param signAlgorithm 签名算法
     * @return 签名后的字节数组
     * @throws Exception
     */
    public static byte[] digitalSign(byte[] plainBytes, PrivateKey privateKey, String signAlgorithm) throws Exception {
        try {
            Signature signature = Signature.getInstance(signAlgorithm);
            signature.initSign(privateKey);
            signature.update(plainBytes);
            byte[] signBytes = signature.sign();

            return signBytes;
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(String.format("数字签名时没有[%s]此类算法", signAlgorithm));
        } catch (InvalidKeyException e) {
            throw new Exception("数字签名时私钥无效");
        } catch (SignatureException e) {
            throw new Exception("数字签名时出现异常");
        }
    }

    /**
     * 验证数字签名函数入口
     *
     * @param plainBytes    待验签明文字节数组
     * @param signBytes     待验签签名后字节数组
     * @param publicKey     验签使用公钥
     * @param signAlgorithm 签名算法
     * @return 验签是否通过
     * @throws Exception
     */
    public static boolean verifyDigitalSign(byte[] plainBytes, byte[] signBytes, PublicKey publicKey, String signAlgorithm) throws Exception {
        boolean isValid;
        try {
            Signature signature = Signature.getInstance(signAlgorithm);
            signature.initVerify(publicKey);
            signature.update(plainBytes);
            isValid = signature.verify(signBytes);
            return isValid;
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(String.format("验证数字签名时没有[%s]此类算法", signAlgorithm));
        } catch (InvalidKeyException e) {
            throw new Exception("验证数字签名时公钥无效");
        } catch (SignatureException e) {
            throw new Exception("验证数字签名时出现异常");
        }
    }

    /**
     * 加密
     *
     * @param plainBytes      明文字节数组
     * @param publicKey       公钥
     * @param keyLength       密钥bit长度
     * @param reserveSize     padding填充字节数，预留11字节
     * @param cipherAlgorithm 加解密算法，一般为RSA/ECB/PKCS1Padding
     * @return 加密后字节数组，不经base64编码
     * @throws Exception
     */
    public static byte[] encrypt(byte[] plainBytes, PublicKey publicKey, int keyLength, int reserveSize, String cipherAlgorithm) throws Exception {
        int keyByteSize = keyLength / 8; // 密钥字节数
        int encryptBlockSize = keyByteSize - reserveSize; // 加密块大小=密钥字节数-padding填充字节数
        int nBlock = plainBytes.length / encryptBlockSize;// 计算分段加密的block数，向上取整
        if ((plainBytes.length % encryptBlockSize) != 0) { // 余数非0，block数再加1
            nBlock += 1;
        }

        try {
            Cipher cipher = Cipher.getInstance(cipherAlgorithm);
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);

            // 输出buffer，大小为nBlock个keyByteSize
            ByteArrayOutputStream outbuf = new ByteArrayOutputStream(nBlock * keyByteSize);
            // 分段加密
            for (int offset = 0; offset < plainBytes.length; offset += encryptBlockSize) {
                int inputLen = plainBytes.length - offset;
                if (inputLen > encryptBlockSize) {
                    inputLen = encryptBlockSize;
                }

                // 得到分段加密结果
                byte[] encryptedBlock = cipher.doFinal(plainBytes, offset, inputLen);
                // 追加结果到输出buffer中
                outbuf.write(encryptedBlock);
            }

            outbuf.flush();
            outbuf.close();
            return outbuf.toByteArray();
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(String.format("没有[%s]此类加密算法", cipherAlgorithm));
        } catch (NoSuchPaddingException e) {
            throw new Exception(String.format("没有[%s]此类填充模式", cipherAlgorithm));
        } catch (InvalidKeyException e) {
            throw new Exception("无效密钥");
        } catch (IllegalBlockSizeException e) {
            throw new Exception("加密块大小不合法");
        } catch (BadPaddingException e) {
            throw new Exception("错误填充模式");
        } catch (IOException e) {
            throw new Exception("字节输出流异常");
        }
    }

    /**
     * RSA解密
     *
     * @param encryptedBytes  加密后字节数组
     * @param privateKey      私钥
     * @param keyLength       密钥bit长度
     * @param reserveSize     padding填充字节数，预留11字节
     * @param cipherAlgorithm 加解密算法，一般为RSA/ECB/PKCS1Padding
     * @return 解密后字节数组，不经base64编码
     * @throws Exception
     */
    public static byte[] decrypt(byte[] encryptedBytes, PrivateKey privateKey, int keyLength, int reserveSize, String cipherAlgorithm) throws Exception {
        int keyByteSize = keyLength / 8; // 密钥字节数
        int decryptBlockSize = keyByteSize - reserveSize; // 解密块大小=密钥字节数-padding填充字节数
        int nBlock = encryptedBytes.length / keyByteSize;// 计算分段解密的block数，理论上能整除

        try {
            Cipher cipher = Cipher.getInstance(cipherAlgorithm);
            cipher.init(Cipher.DECRYPT_MODE, privateKey);

            // 输出buffer，大小为nBlock个decryptBlockSize
            ByteArrayOutputStream outbuf = new ByteArrayOutputStream(nBlock * decryptBlockSize);
            // 分段解密
            for (int offset = 0; offset < encryptedBytes.length; offset += keyByteSize) {
                // block大小: decryptBlock 或 剩余字节数
                int inputLen = encryptedBytes.length - offset;
                if (inputLen > keyByteSize) {
                    inputLen = keyByteSize;
                }

                // 得到分段解密结果
                byte[] decryptedBlock = cipher.doFinal(encryptedBytes, offset, inputLen);
                // 追加结果到输出buffer中
                outbuf.write(decryptedBlock);
            }

            outbuf.flush();
            outbuf.close();
            return outbuf.toByteArray();
        } catch (NoSuchAlgorithmException e) {
            throw new Exception(String.format("没有[%s]此类解密算法", cipherAlgorithm));
        } catch (NoSuchPaddingException e) {
            throw new Exception(String.format("没有[%s]此类填充模式", cipherAlgorithm));
        } catch (InvalidKeyException e) {
            throw new Exception("无效密钥");
        } catch (IllegalBlockSizeException e) {
            throw new Exception("解密块大小不合法");
        } catch (BadPaddingException e) {
            throw new Exception("错误填充模式");
        } catch (IOException e) {
            throw new Exception("字节输出流异常");
        }
    }

    /**
     * 字符数组转16进制字符串
     *
     * @param bytes
     * @return
     */
    public static String bytes2string(byte[] bytes, int radix) {
        // 2个16进制字符占用1个字节，8个二进制字符占用1个字节
        int size = 2;
        if (radix == 2) {
            size = 8;
        }
        StringBuilder sb = new StringBuilder(bytes.length * size);
        for (int i = 0; i < bytes.length; i++) {
            int integer = bytes[i];
            while (integer < 0) {
                integer = integer + 256;
            }
            String str = Integer.toString(integer, radix);
            sb.append(StringUtils.leftPad(str.toUpperCase(), size, "0"));
        }
        return sb.toString();
    }
}
```

### 签名
```
byte[] signBytes = CryptoUtil.digitalSign(xml.getBytes("UTF-8"), privateKey, "SHA1WithRSA");
```

### 加密
```
byte[] encryptedBytes = CryptoUtil.encrypt(xmlBytes, publicKey, 2048, 11, "RSA/ECB/PKCS1Padding");
```

### 解密
```
byte[] xmlBytes = CryptoUtil.decrypt(encryptedBytes, privateKey, 2048, 11, "RSA/ECB/PKCS1Padding");
```

### 验签
```
boolean isValid = CryptoUtil.verifyDigitalSign(xmlBytes, signBytes, publicKey, "SHA1WithRSA");
```

### 加载私钥
```
/**
 * 加载私钥
 */
private void loadPrivateKey() {
    String privateKeyPath = null;
    InputStream inputStream = null;
    try {
        // TODO
        privateKeyPath = "私钥路径";
        inputStream = new FileInputStream(privateKeyPath);
        privateKey = CryptoUtil.getPrivateKey(inputStream, "RSA");
    } catch (Exception e) {
        log.error("无法加载己方私钥[{}]", privateKeyPath);
        log.error(e.getMessage(), e);
    } finally {
        try {
            if (inputStream != null) {
                inputStream.close();
            }
        } catch (Exception e) {
            log.error(e);
        }
    }
}
```

### 加载公钥
```
/**
 * 加载公钥
 */
private void loadPublicKey() {
    String publicKeyPath = null;
    InputStream inputStream = null;
    try {
        // TODO
        publicKeyPath = "公钥路径";
        inputStream = new FileInputStream(publicKeyPath);
        publicKey = CryptoUtil.getPublicKey(inputStream, "RSA");
    } catch (Exception e) {
        log.error("无法加载对方公钥[{}]", publicKeyPath);
        log.error(e.getMessage(), e);
    } finally {
        try {
            if (inputStream != null) {
                inputStream.close();
            }
        } catch (Exception e) {
            log.error(e);
        }
    }
}
```
', 0, 0, '2018-03-24 23:51:37', '2018-03-24 23:51:37');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用Log4j正则替换功能隐藏敏感信息', '今天工作中遇到一个问题，需要把一些Log4j日志中的敏感信息给隐藏了，比如：手机号，身份证号等。', 'server', '## pom.xml
```
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.16</version>
</dependency>
```

<!-- more -->

## log4j.xml
```
<?xml version="1.0" encoding="GBK" ?>
<!DOCTYPE log4j:configuration SYSTEM "log4j.dtd">
<log4j:configuration>

    <appender name="console" class="org.apache.log4j.ConsoleAppender">
        <!--<layout class="org.apache.log4j.PatternLayout">-->
        <!--<param name="ConversionPattern" value="%d %t [%F:%L] %-5p : %m%n" />-->
        <!--</layout>-->
        <layout class="com.kangyonggan.demo.MyPatternLayout">
            <param name="ConversionPattern" value="%d %t [%F:%L] %-5p : %m%n"/>
        </layout>
    </appender>

    <root>
        <level value="debug"></level>
        <appender-ref ref="console"></appender>
    </root>
</log4j:configuration>
```

## MyPatternLayout.java
```
package com.kangyonggan.demo;

import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.spi.LoggingEvent;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author kangyonggan
 * @date 2017/3/20
 */
public class MyPatternLayout extends PatternLayout {

    private static final String HIDDEN = "$1$2$3****$5$6";
    private static final Pattern MOBILE_PATTERN = Pattern.compile("(\\D|^)(1)(3\\d|4[57]|5[^4]|7[0137]|8\\d)(\\d{4})(\\d{4})(\\D|$)");

    @Override
    public String format(LoggingEvent event) {
        if (event.getMessage() instanceof String) {
            String message = event.getRenderedMessage();

            Matcher matcher = MOBILE_PATTERN.matcher(message);

            if (matcher.find()) {
                String maskedMessage = matcher.replaceAll(HIDDEN);

                Throwable throwable = event.getThrowableInformation() != null ? event.getThrowableInformation().getThrowable() : null;

                LoggingEvent maskedEvent = new LoggingEvent(
                        event.fqnOfCategoryClass,
                        Logger.getLogger(event.getLoggerName()),
                        event.timeStamp,
                        event.getLevel(),
                        maskedMessage,
                        throwable);

                return super.format(maskedEvent);
            }
        }

        return super.format(event);
    }
}
```

## Test.java
```
package com.kangyonggan.demo;

import org.apache.log4j.Logger;

/**
 * @author kangyonggan
 * @date 2017/3/20
 */
public class Test {

    private static final Logger logger = Logger.getLogger(Test.class);

    public static void main(String[] args) {
        logger.info("手机号1: 13911119999，姓名：qweqe");
        logger.info("手机号2: asd13911119999asd");
        logger.info("假手机号1: 139a11119999");
        logger.info("假手机号2: 139111199991");
        logger.info("假手机号3: 139111199991");
        logger.info("假手机号4: 444139111199991");
        logger.info("假手机号5: 44413911119999");

        try {
            int a = 1 / 0;
        } catch (Exception e) {
            logger.error("13911110000", e);
        }
    }

}
```

## 输出
```
2017-03-21 15:32:50,163 main [Test.java:14] INFO  : 手机号1: 139****9999，姓名：qweqe
2017-03-21 15:32:50,166 main [Test.java:15] INFO  : 手机号2: asd139****9999asd
2017-03-21 15:32:50,166 main [Test.java:16] INFO  : 假手机号1: 139a11119999
2017-03-21 15:32:50,166 main [Test.java:17] INFO  : 假手机号2: 139111199991
2017-03-21 15:32:50,166 main [Test.java:18] INFO  : 假手机号3: 139111199991
2017-03-21 15:32:50,167 main [Test.java:19] INFO  : 假手机号4: 444139111199991
2017-03-21 15:32:50,167 main [Test.java:20] INFO  : 假手机号5: 44413911119999
2017-03-21 15:32:50,167 main [Test.java:25] ERROR : 13911110000
java.lang.ArithmeticException: / by zero
  at com.kangyonggan.demo.Test.main(Test.java:23)

Process finished with exit code 0
```

> 例子中的正则表达式写的比较弱，请根据实际情况自己写。

', 0, 0, '2018-03-24 23:52:06', '2018-03-24 23:52:06');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用Log4j2让项目输出info级别的日志和debug级别的sql', '在生产环境中，我们并不关注debug级别的日志，一般只关心info级别之上的，但是有个例外，那就是debug级别的sql语句，我们也是需要关注的', 'server', '
> log4j2的使用方法请参考我之前的一篇文章

让项目输出info级别的日志，让项目输出debug级别的日志，`log4j2.xml`的配置如下:

<!-- more -->

```
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN" monitorInterval="300">
    <properties>
        <property name="LOG_HOME">/Users/kyg/logs/simconf</property>
    </properties>

    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
        </Console>
        <RollingRandomAccessFile name="AllFile" fileName="${LOG_HOME}/all.log"
                                 filePattern="${LOG_HOME}/all-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="debug" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <RollingRandomAccessFile name="ErrorFile" fileName="${LOG_HOME}/error.log"
                                 filePattern="${LOG_HOME}/error-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="error" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <Async name="AsyncAll">
            <AppenderRef ref="AllFile"></AppenderRef>
        </Async>
        <Async name="AsyncError">
            <AppenderRef ref="ErrorFile"></AppenderRef>
        </Async>
    </Appenders>
    <Loggers>
        <Logger name="com.kangyonggan.app.simconf.mapper" level="debug" additivity="false">
            <AppenderRef ref="AsyncAll"></AppenderRef>
            <AppenderRef ref="AsyncError"></AppenderRef>
        </Logger>

        <Root level="info" additivity="true">
            <AppenderRef ref="Console"></AppenderRef>
            <AppenderRef ref="AsyncAll"></AppenderRef>
            <AppenderRef ref="AsyncError"></AppenderRef>
        </Root>
    </Loggers>
</Configuration>
```

只配置log4j2.xml是不够的，因为Mybatis默认使用的不是log4j2，默认使用的顺序如下:

> SLF4J > Apache Commons Logging > Log4j2 > Log4j > JDK logging

所有我们还需要让Mybatis使用log4j2来输出日志:

```
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    ...
    <property name="configLocation" value="classpath:mybatis.xml"></property>
    ...
</bean>
```

`mybatis.xml`的内容:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <!--使用log4j2输出日志-->
        <setting name="logImpl" value="LOG4J2"></setting>
    </settings>
</configuration>
```

小记：本人单线程测试log4j和log4j2的性能，结果如下:
输出10000个debug+10000个info+10000个error到日志文件，log4j2是log4j速度的1.8倍左右。
输出100000个debug+100000个info+100000个error到日志文件，log4j2是log4j速度的2.6倍左右。


', 0, 0, '2018-03-24 23:53:42', '2018-03-24 23:53:42');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用log4j2的SMTPAppender发送邮件报警', '当程序运行当中有报错日志，我们最好能第一时间发现并解决，下面就配置当有错误日志时就发送邮件给指定的人', 'server', '
## 目的
1. 当项目中有`报错时`，要能`自动的`、`及时的`发邮件通知`指定人员`。
2. 邮件中的错误日志要全面，最好能把当前线程的全部日志输出，不论日志级别。
3. 仅当日志为error级别时，才发邮件通知。
4. 可以配置邮件抄送给其他人。

<!-- more -->

## 引入依赖
```
<log4j2.api.version>2.5</log4j2.api.version>

<!--Log4j2-->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>${log4j2.api.version}</version>
</dependency>
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>${log4j2.api.version}</version>
</dependency>
```

## 配置`log4j2.xml`
```
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN" monitorInterval="300">
    <properties>
        <property name="LOG_HOME">/Users/kyg/logs/cms</property>
    </properties>

    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
        </Console>
        <RollingRandomAccessFile name="AllFile" fileName="${LOG_HOME}/all.log"
                                 filePattern="${LOG_HOME}/all-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="debug" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <RollingRandomAccessFile name="ErrorFile" fileName="${LOG_HOME}/error.log"
                                 filePattern="${LOG_HOME}/error-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="error" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <SMTP name="Mail" subject="内容管理系统 - 报警通知" to="kangyonggan@gmail.com" from="kangyg2017@163.com"
              smtpHost="smtp.163.com" smtpUsername="kangyg2017@163.com" smtpPassword="xxxxxxxx" bufferSize="50" >
        </SMTP>
        <Async name="AsyncAll">
            <AppenderRef ref="AllFile"></AppenderRef>
        </Async>
        <Async name="AsyncError">
            <AppenderRef ref="ErrorFile"></AppenderRef>
            <AppenderRef ref="Mail" ></AppenderRef>
        </Async>
    </Appenders>
    <Loggers>
        <Root level="debug" additivity="true">
            <AppenderRef ref="Console"></AppenderRef>
            <AppenderRef ref="AsyncAll"></AppenderRef>
            <AppenderRef ref="AsyncError"></AppenderRef>
        </Root>
    </Loggers>
</Configuration>
```

上面的配置中，关于报警的配置有两点:

```
<AppenderRef ref="Mail" ></AppenderRef>
```

```
<SMTP name="Mail" subject="内容管理系统 - 报警通知" to="kangyonggan@gmail.com" from="kangyg2017@163.com"
      smtpHost="smtp.163.com" smtpUsername="kangyg2017@163.com" smtpPassword="xxxxxxxx" bufferSize="50" >
</SMTP>
```

## 附加说明
- 异步输出日志，不会影响主线程性能
- error日志单独输出到error.log文件
- all.log包含所有级别的日志
- 每天会备份旧的日志文件，产生新的日志文件
- 如果一天之中有日志文件超出大小限制(上面配的500M)，会存档当前文件，另外再创建一个新的文件
- 日志文件只保存近期的（上面配置的30天）

> 温馨提示：由于是个人项目，所以没配置多个邮件接收者，如有需要，请参考[官方文档](http://logging.apache.org/log4j/2.x/manual/appenders.html#SMTPAppender)

## 收到的邮件截图
![mail](https://kangyonggan.com/upload/20170123163536603.png)
![mail](https://kangyonggan.com/upload/20170123163703359.png)
![mail](https://kangyonggan.com/upload/20170123163703945.png)
![mail](https://kangyonggan.com/upload/20170123163704569.png)


', 0, 0, '2018-03-24 23:55:25', '2018-03-24 23:55:25');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用aop和自定义注解打印出参入参日志和方法执行时间', 'spring的aop具有横切性质，如果再结合自定义注解，就可以做到在方法上加个注解来打印方法的入参和出参了', 'server', '
## 自定义注解
`LogTime.java`:

```
package com.kangyonggan.api.common.annotation;

import java.lang.annotation.*;

/**
 * 在方法上加此注解会打印入参和出参，会计算方法消耗的时间
 *
 * @author kangyonggan
 * @date 2016/12/8
 */
@Documented
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface LogTime {
}
```

<!-- more -->

## 主要逻辑：

```
package com.kangyonggan.api.common.aop;

import com.kangyonggan.api.common.annotation.LogTime;
import com.kangyonggan.api.common.util.AopUtil;
import com.kangyonggan.api.common.util.DateUtils;
import com.kangyonggan.api.common.util.PropertiesUtil;
import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;

/**
 * 切于内部service的实现方法上， 需要在方法上手动加上@LogTime注解， 打印入参和出参，打印方法执行时间, 慢方法打印error日志
 *
 * @author kangyonggan
 * @date 2016/11/30
 */
@Log4j2
public class LogAop {

    /**
     * 设定的方法最大执行时间
     */
    private Long slowMethodTime;

    public LogAop() {
        String val = PropertiesUtil.getPropertiesOrDefault("slow.method.time", "10");
        slowMethodTime = Long.parseLong(val);
    }

    /**
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
        Object args[] = joinPoint.getArgs();
        Class clazz = joinPoint.getTarget().getClass();

        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Method method = clazz.getMethod(methodSignature.getName(), methodSignature.getParameterTypes());
        String targetName = "[" + clazz.getName() + "." + method.getName() + "]";

        LogTime logTime = method.getAnnotation(LogTime.class);
        Object result;
        if (logTime != null) {
            log.info("进入方法:" + targetName + " - args:" + AopUtil.getStringFromRequest(args));

            long beginTime = DateUtils.getNow().getTime();
            result = joinPoint.proceed(args);
            long endTime = DateUtils.getNow().getTime();
            long time = endTime - beginTime;

            log.info("离开方法:" + targetName + " - return:" + AopUtil.getStringFromResponse(result));
            log.info("方法耗时:" + time + "ms - " + targetName);

            if (time > slowMethodTime * 1000) {
                log.error("方法执行超过设定时间" + slowMethodTime + "s," + targetName);
            }
        } else {
            result = joinPoint.proceed(args);
        }

        return result;
    }
}
```


其中用到的`AopUtil.java`:

```
package com.kangyonggan.api.common.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.apache.commons.lang3.StringUtils;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author kangyonggan
 * @date 2016/11/30
 */
public class AopUtil {
    public static String getStringFromRequest(Object[] args) {
        String req = "";
        for (Object arg : args) {
            if (arg == null) {
                req = req + "null,";
                continue;
            } else if (arg instanceof List == true) {
                req = req + JSON.toJSONString(arg);
            } else if (arg.getClass().isArray()) {
                req = req + JSONArray.toJSONString(arg);
            } else if (arg instanceof Enum) {
                req = req + JSON.toJSONString(arg) + ",";
            } else if (!(arg instanceof String)
                    && !(arg instanceof BigDecimal)
                    && !(arg instanceof Boolean)
                    && !(arg instanceof Integer)
                    && (arg instanceof Object)) {
                req = req + JSON.toJSONString(arg) + ",";
            } else {
                req = req + arg.toString() + ",";
            }
        }

        if (StringUtils.isNotEmpty(req) && req.length() > 100) {
            return req.hashCode() + "";
        } else {
            return req;
        }
    }

    public static String getStringFromResponse(Object arg) {
        String rsp = "";
        if (arg == null) {
            rsp = rsp + "null,";
            return rsp;
        } else if (arg instanceof List) {
            rsp = rsp + JSON.toJSONString(arg);
            return rsp;
        } else if (arg instanceof Enum) {
            rsp = rsp + JSON.toJSONString(arg);
            return rsp;
        } else if (!(arg instanceof String)
                && !(arg instanceof BigDecimal)
                && !(arg instanceof Boolean)
                && !(arg instanceof Integer)
                && (arg instanceof Object)) {
            rsp = rsp + JSON.toJSONString(arg) + ",";
        } else {
            rsp = rsp + arg.toString() + ",";
        }
        return rsp;
    }
}
```


', 0, 0, '2018-03-24 23:57:03', '2018-03-24 23:57:03');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用ace admin搭建单页面网站', '做后台管理系统，我只用ace，但是目前市面上的单页面前端框架越来越猖，但是...ace也不赖，她也可以搭建单页面网站', 'web', '
## 资料
- Ace Admin [ace.zip](https://kangyonggan.com/upload/ace.zip)
- 在线实例（已经没了） [http://kangyonggan.com](http://kangyonggan.com)
- Github代码（已经没了） [https://github.com/kangyonggan/blog.git](https://github.com/kangyonggan/blog.git)

> 网上很少有ace admin相关的资料，如需使用和学习，只能去看源代码...

<!-- more -->

## 目的
做出一个类似cms后台管理系统的单页面网站，效果如下:

![加载中](https://kangyonggan.com/upload/20170109223706060.png)

![地址](https://kangyonggan.com/upload/20170109223708522.png)

## 步骤
由于关于ace admin的文档很少，尤其是ace admin ajax的！所以这就要我们自己来读源代码，看实例来学习了。

### 搭建本地demo
下载ace.zip并解压
![下载](https://kangyonggan.com/upload/20170109223701593.png)

拷贝到tomcat webapps目录下

![拷贝到tomcat](https://kangyonggan.com/upload/20170109223709211.png)

启动tomcat后，打开浏览器即可查看demo

![查看demo](https://kangyonggan.com/upload/20170109223706510.png)

可以先进入`Ajax Demo Pages`提前感受一下单页面的好处。

### 拷贝源码+修改
查看源码：右键-->查看源代码

![源码](https://kangyonggan.com/upload/20170109223707758.png)

把ace的一些核心css和js拷贝到你的html中，由于我们是要做单页面，从`Ajax Demo Pages`中可以看出，关键词是`ajax`
所以你需要格外的关注源码中出现的`ajax`,经过搜索后发现有用的是下面两点

![ajax](https://kangyonggan.com/upload/20170109223702751.png)
![ajax](https://kangyonggan.com/upload/20170109223704068.png)

点开`ace.ajax-content.js`, 如下：

![ajax-content](https://kangyonggan.com/upload/20170109223702338.png)

发现他是一个典型的jquery插件（不会jquery插件的看着会比较难，最好先去恶补一下），大致看一下这个插件，会发现它实现单页面的核心代码是:

![geturl](https://kangyonggan.com/upload/20170109223704715.png)

当用户点击超链接或者按钮时，插件代替你发起异步请求，服务器返回一个“页面”，插件拿到页面后，用下面红框框的核心代码把内容局部清空并替换，实现类似iframe的效果，给人一种我是单页面的错觉

![replace](https://kangyonggan.com/upload/20170109223707144.png)

对源码有个大致的了解就行，下面就可以动手搭建了。

## 解读源码
基础web环境搭建过程不再演示，我使用的freemarker模板，下面是我的html布局：

```html
<#assign ctx="${(rca.contextPath)!''''}">

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

    <div class="hidden ajax-append-link" rel="shortcut icon" href="${ctx}/static/app/images/favicon.ico" type="image/x-icon">
    <!-- bootstrap & fontawesome -->
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/bootstrap.min.css"></div>
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/font-awesome.min.css"></div>
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/jquery.gritter.min.css"></div>

    <!-- page specific plugin styles -->

    <!-- text fonts -->
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-fonts.min.css"></div>

    <#--skin-->
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-skins.min.css"></div>

    <!-- ace styles -->
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/ace.min.css" class="ace-main-stylesheet"
          id="main-ace-style"></div>

    <!--[if lte IE 9]>
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-part2.min.css" class="ace-main-stylesheet"></div>
    <![endif]-->

    <!--[if lte IE 9]>
    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/ace/dist/css/ace-ie.min.css"></div>
    <![endif]-->

    <div class="hidden ajax-append-link" rel="stylesheet" href="${ctx}/static/app/css/app.css"></div>

    <script src="${ctx}/static/ace/dist/js/jquery.min.js"></script>

    <!--[if lte IE 8]>
    <script src="${ctx}/static/ace/dist/js/html5shiv.js"></script>
    <script src="${ctx}/static/ace/dist/js/respond.min.js"></script>
    <![endif]-->
<@block name="app-style"/>
</head>
<body class="skin-3">
<#include "navbar.ftl"/>

<div class="main-container" id="main-container">

<#if hasSidebar?? && hasSidebar==true>
    <#include "sidebar.ftl"/>
</#if>

    <div class="main-content">
        <div class="main-content-inner">
        <#if home_name?? && home_name!=''''>
            <div class="breadcrumbs" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-tachometer home-icon"></i>
                        <a data-url="index" href="#index">${home_name}</a>
                    </li>
                </ul>
            </div>
        </#if>

            <div class="page-content">
                <div class="page-content-area"></div>
            </div>
        </div>
    </div>

<#include "footer.ftl"/>

<#include "modal.ftl"/>

    <a href="javascript:" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div>

<script>var ctx = ''${ctx}'';</script>
<script src="${ctx}/static/ace/dist/js/bootstrap.min.js"></script>
<script src="${ctx}/static/libs/jquery/jquery.bootstrap.min.js"></script>
<script src="${ctx}/static/ace/dist/js/jquery.gritter.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-extra.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace-elements.min.js"></script>
<script src="${ctx}/static/ace/dist/js/ace.min.js"></script>
<script src="${ctx}/static/app/js/app.js"></script>
<@block name="app-script"/>
</body>
</html>
```

其中，`navbar.flt` `sidebar.ftl` `footer.ftl` 都是demo中的。
如果之前使用的就是freemarker+ace admin，那么你要重点关注下面两处代码:

```html
<div class="page-content">
   <div class="page-content-area"></div>
</div>
```

核心js`app.js`

```js
$(function () {
    // 异步加载界面
    var $ajaxContent = $(".page-content-area");
    $ajaxContent.ace_ajax({
        ''default_url'': ''#index'',
        ''content_url'': function (hash) {
            return window.location.origin + window.location.pathname + "/" + hash;
        },
        ''update_active'': updateMenuActive,
        ''update_breadcrumbs'': updateBreadcrumbs,
        ''update_title'': updateTitle,
        ''loading_text'': ''<span class="loading">正在加载, 请稍等...</span>''
    });

    // 监听异步加载失败事件
    $ajaxContent.on("ajaxloaderror", function (e, data) {
        window.location.href = ctx + ''/#500'';
    });
});


/**
 * 更新菜单激活状态
 *
 * @param hash
 */
function updateMenuActive(hash) {
    //  当前菜单
    var $menu = $($(''a[data-url="'' + hash + ''"]'')[0]).parent("li");

    // 所有菜单
    var $all_menus = $menu.parents("ul.nav-list").find("li");

    // 清除所有菜单状态
    $all_menus.removeClass("open");
    $all_menus.removeClass("active");

    // 父菜单
    var $parent = $menu.parents("li");
    if ($parent.length > 0) {
        $parent.addClass("open");
    }
    $menu.addClass("active");
}

/**
 * 更新面包屑
 *
 * @param hash
 */
function updateBreadcrumbs(hash) {
    var $menu = $(''a[data-url="'' + hash + ''"]'');

    // 下面这坨代码摘自ace.ajax-content.js
    var $breadcrumbs = $(''.breadcrumb'');
    if ($breadcrumbs.length > 0 && $breadcrumbs.is('':visible'')) {
        $breadcrumbs.find(''> li:not(:first-child)'').remove();

        var i = 0;
        $menu.parents(''.nav li'').each(function () {
            var $link = $(this).find(''> a'');

            var $link_clone = $link.clone();
            $link_clone.find(''i,.fa,.glyphicon,.ace-icon,.menu-icon,.badge,.label'').remove();
            var text = $link_clone.text();
            $link_clone.remove();

            var href = $link.attr(''href'');

            if (i == 0) {
                var li = $(''<li class="active"></li>'').appendTo($breadcrumbs);
                li.text(text);
            } else {
                var li = $(''<li><a ></a></li>'').insertAfter($breadcrumbs.find(''> li:first-child''));
                li.find(''a'').attr(''href'', href).text(text);
            }
            i++;
        })
    }
}

/**
 * 更新标题
 *
 * @param hash
 */
function updateTitle(hash) {
    var $menu = $($(''a[data-url="'' + hash + ''"]'')[0]);
    var title = $.trim($menu.text());

    if (title != '''') {
        document.title = title;
    }
}

/**
 * 更新状态
 *
 * @param hash
 */
function updateState(hash) {
    updateBreadcrumbs(hash);
    updateMenuActive(hash);
    updateTitle(hash);
}
```

如果你对jquery插件了解的不多，估计很难去使用`ace_ajax`，因为网上和demo中都没有使用教程，我这是根据`ace.ajax-content.js`源代码中的jquery插件反推出来的插件使用方法。

在插件源代码的最后暴露出插件有哪些公共属性和方法可被你覆写和调用

```js
$.fn.aceAjax = $.fn.ace_ajax = function (option, value, value2, value3) {
 var method_call;

 var $set = this.each(function () {
 var $this = $(this);
 var data = $this.data(''ace_ajax'');
 var options = typeof option === ''object'' && option;

 if (!data) $this.data(''ace_ajax'', (data = new AceAjax(this, options)));
 if (typeof option === ''string'' && typeof data[option] === ''function'') {
 if(value3 != undefined) method_call = data[option](value, value2, value3);
 else if(value2 != undefined) method_call = data[option](value, value2);
 else method_call = data[option](value);
 }
 });

 return (method_call === undefined) ? $set : method_call;
}

$.fn.aceAjax.defaults = $.fn.ace_ajax.defaults = {
 content_url: false,
 default_url: false,
 loading_icon: ''fa fa-spin fa-spinner fa-2x orange'',
 loading_text: '''',
 loading_overlay: null,
 update_breadcrumbs: true,
 update_title: true,
 update_active: true,
 close_active: false,
 max_load_wait: false
}
```

比如`loading_text`,看名称就大概猜出是在异步加载界面时，给用户的提示信息，例如`正在加载, 请稍等...`， 当然这只是大概的猜测，我们要真想使用它，肯定要读相应的源代码并且动手去验证一下。

过程中难免会遇到各种问题，只要耐心解读源码，一定会攻破的，我也遇到了好多坑，昨天花了一整天的时间才把我原本的博客给变成了单页面的，这主要是因为我的聪明才智和之前就使用的ace admin。

> 温馨提示: `ace.ajax-content.js`文件被包含在了`ace.min.js`中，因此只需要引入`ace.min.js`即可




', 0, 0, '2018-03-24 23:59:49', '2018-03-24 23:59:49');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('windows防火墙导致ftp文件上传异常', '在win7系统下运行web项目，发现ftp文件上传异常，但是在linux下是好的，win7下报错信息如下', 'other', '```
[INFO ] 2017-01-21 21:24:03.388 [com.kangyonggan.archetype.cms.biz.util.Ftp.http-bio-8080-exec-10:53] - 连接文件服务器成功, 上传路径path:upload/
[ERROR] 2017-01-21 21:24:22.899 [com.kangyonggan.archetype.cms.biz.util.Ftp.http-bio-8080-exec-10:75] - 文件上传异常
java.net.SocketException: Software caused connection abort: socket write error
oat java.net.SocketOutputStream.socketWrite0(Native Method) ~[?:1.8.0_111]
oat java.net.SocketOutputStream.socketWrite(SocketOutputStream.java:109) ~[?:1.8.0_111]
oat java.net.SocketOutputStream.write(SocketOutputStream.java:153) ~[?:1.8.0_111]

...
```

<!-- more -->

原因是win7防火墙的问题，关闭防火墙后一切就正常了。

![关闭防火墙](https://kangyonggan.com/upload/20170121214431475.png)


', 0, 0, '2018-03-25 00:00:36', '2018-03-25 00:00:36');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('.gitignore的内容', '忽略maven产生的target目录、忽略idea和eclipse下面的配置文件', 'code', '
```
# Maven #
target/

# IDEA #
.idea/
*.iml

# Eclipse #
.settings/
.metadata/
.classpath
.project
Servers/
```
', 0, 0, '2018-03-25 00:01:27', '2018-03-25 00:01:27');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('HashMap实现原理分析', '这个是面试必问的，其实懂的深不深在开发汇总并没有什么卵用', 'server', '
> 参考：[http://blog.csdn.net/vking_wang/article/details/14166593](http://blog.csdn.net/vking_wang/article/details/14166593)

## HashMap的数据结构
在数据结构中，有`数组`和`链表`来实现对数据的存储，但这两者是两个极端。

### 数组
数组的存储区间是连续的，空间复杂度大，时间复杂度小。特点是：`查找容易，插入和删除困难`。

### 链表
链表的存储区间是离散的，空间复杂度小，时间复杂度大。特点是：`查找困难，插入和删除容易`。

### 哈希表
哈希表是综合了数组和链表的优点，既满足了查找方便，同时也不占用太多空间，使用也很方便。

<!-- more -->

哈希表有很多实现方式，下面讲解最常用的拉链发，可以理解为链表的数组：

![la](https://kangyonggan.com/upload/20170309210540154.jpeg)

从上图中总可以看出，哈希表是由`数组+链表`组成的，HashMap里面实现了一个静态内部类`Entity`,其重要属性有`key`、`value`和`next`，从属性可以看出Entity是HashMap键值对实现的一个基础Bean，上面我们说到HashMap的基础就是一个线性数组，即Entity[],Map里面的内容都保存在数组Entity[]中, 下面是个demo：

![lan](https://kangyonggan.com/upload/20170309210548825.png)

这个链表是一个长度为16的数组，左边数字是数组的下标，右边的数字是key的hash值，数组中的每一个元素都是一个链表的头节点，那么这些元素是按照什么规则存储的呢？又是按照什么规则查找的呢？

### 存取规则`hash(key)%len`
比如上图中，key的hash值为31的元素，模上数组长度16，结果是15，那么它就存储在arr[15]所在的链表中。查找时就是先计算hash(key)%len，找出元素所在的链表位于数组的位置，然后遍历链表即可。

### 几个注意点
1. 不同的Hash可能有相同的index，相同的index不一定有相同的Hash。
2. 对于`hash(key)%len`计算得到相同index的元素，采用`头插法`，即后来的插到链表的头部，也就是说数组中存储的那个头元素是最后插进来的。
3. HashMap允许key为null的元素存入，key为null的元素永远存储在链表头部，即数组中。
4. Entity[]的长度固定后，随着元素的增加，链表会越来越长，这时候HashMap中的一个因子就会起到作用，随着map的size越来越大，Entity[]的length会以一定的规则增加。



', 0, 0, '2018-03-25 00:02:28', '2018-03-25 00:02:28');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('jdk1.8发送http请求报SSLv3的解决方案', '从 JDK 8u31 发行版开始，已停用 SSLv3 协议（安全套接字层），该协议在正常情况下不可用。如果确实需要 SSLv3，可以重新激活该协议...', 'server', 'SSLv3激活步骤:

切到${java_home}/jre/lib/security目录

```
cd /Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home/jre/lib/security
```

<!-- more -->

修改`java.security`文件

```
vi java.security
```

找到`jdk.tls.disabledAlgorithms`属性， 删除`SSLv3`并保存

查找:`/jdk.tls.disabledAlgorithms`

', 0, 0, '2018-03-25 00:03:16', '2018-03-25 00:03:16');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('linux下杀死一个进程的常用手段', '有时候不能优雅的停止的时候，就可以强制杀死进程', 'linux', '```
ps -ef | grep redis-server | cut -c 9-15 | xargs kill -9
```
', 0, 0, '2018-03-25 00:04:16', '2018-03-25 00:04:16');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('log4j2的使用和配置', 'log4j2是目前最最强大的一款日志工具，性能比log4j和logback都快', 'server', '
## 引入依赖
在`pom.xml`中添加依赖:

```
<log4j2.api.version>2.5</log4j2.api.version>

...

<!--Log4j2-->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>${log4j2.api.version}</version>
</dependency>
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>${log4j2.api.version}</version>
</dependency>
```

<!-- more -->

## 配置
`log4j2.xml`:

1. 异步输出日志，不会影响主线程性能
2. error日志单独输出到error.log文件
3. all.log包含所有级别的日志
4. 每天会备份旧的日志文件，产生新的日志文件
5. 如果一天之中有日志文件超出大小限制(下面配的500M)，会存档当前文件，另外再创建一个新的文件
6. 日志文件只保存近期的（下面配置的30天）

这已经可以满足大部分需求了，如果还不满足，那就再改造吧

```
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN" monitorInterval="300">
    <properties>
        <property name="LOG_HOME">/Users/kyg/logs/test</property>
    </properties>

    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
        </Console>
        <RollingRandomAccessFile name="AllFile" fileName="${LOG_HOME}/all.log"
                                 filePattern="${LOG_HOME}/all-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="debug" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <RollingRandomAccessFile name="ErrorFile" fileName="${LOG_HOME}/error.log"
                                 filePattern="${LOG_HOME}/error-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="error" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <Async name="AsyncAll">
            <AppenderRef ref="AllFile"></AppenderRef>
        </Async>
        <Async name="AsyncError">
            <AppenderRef ref="ErrorFile"></AppenderRef>
        </Async>
    </Appenders>

    <Loggers>
        <Root level="debug" additivity="true">
            <AppenderRef ref="Console"></AppenderRef>
            <AppenderRef ref="AsyncAll"></AppenderRef>
            <AppenderRef ref="AsyncError"></AppenderRef>
        </Root>
    </Loggers>
</Configuration>
```

', 0, 0, '2018-03-25 00:05:18', '2018-03-25 00:05:18');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Log4j2省略输出SQL语句SELECT和FROM中间的字段', '在项目中，起初我们是不打印SQL语句的，后来为了查问题更方便，就打印了SQL。 但是也带来了一些问题，比如查询的字段太多，造成满屏SQL，给查日志造成了一定的影响。 所以我就在想，能不能把`SELECT`和`FROM`中间的字段省略输出呢？', 'server', '
## 线上日志中的SQL
```
DEBUG : ==>  Preparing: SELECT serial_no as serialNo,bnk_no as bnkNo ,mer_org_serial_no as merOrgSerialNo,bnk_org_serial_no as bnkOrgSerialNo, mer_date as merDate,mer_time as merTime, mer_org_date as merOrgDate,mer_org_time as merOrgTime ,bnk_org_date as bnkOrgDate,bnk_org_time as bnkOrgTime, last_try_date as lastTryDate,last_try_time as lastTryTime ,last_snd_date as lastSndDate,last_snd_time as lastSndTime, last_qry_serial_no as lastQrySerialNo,last_qry_date as lastQryDate,last_qry_time as lastQryTime, input_date as inputDate,input_time as inputTime,mer_tran_co as merTranCo,bnk_tran_co as bnkTranCo, mer_org_tran_co as merOrgTranCo,bnk_org_tran_co as bankOrgTranCo ,tran_tp as tranTy,syn_flg as synFlg,bat_flg as batFlg, acount as acount,retry_flg as retryFlg,retry_max_time as retryMaxTime ,retry_interval as retryInterval, retry_counter as retryCounter,resnd_flg as resndFlg ,resnd_max_time as resndMaxTime,resnd_interval as resndInterval,resnd_counter as resndCounter, qry_flg as qryFlg,qry_tran_co as qryTranCo,qry_max_time as qryMaxTime,qry_interval as qryInterval, qry_counter as qryCounter,priority as priority,model as model ,product_id as productId,product_tp as productTp,cur_co as currencyCode, amount as amount,fee_amt as feeAmt,tran_purpose as tranPurpose ,tran_remark as tranRemark,ref_app_no as refAppNo, ref_app_kind as refAppKind,rcvr_bnk_no as rcvrBnkNo ,rcvr_acct_no as rcvrAcctNo,rcvr_acct_nm as rcvrAcctNm,rcvr_id_tp as rcvrIdTp,rcvr_id_no as rcvrIdNo, rcvr_province as rcvrProvince,rcvr_city as rcvrCity,rcvr_area_co as rcvrAreaCo,rcvr_area_nm as rcvrAreaNm, rcvr_mer_id as rcvrMerId,rcvr_mer_cert_id as rcvrMerCertId,rcvr_post_id as rcvrPostId ,rcvr_contract_no as rcvrContractNo,rcvr_contract_dt as rcvrContractDt, rcvr_proto_no as rcvrProtoNo,rcvr_mer_user_tp as rcvrMerUserTp,rcvr_mer_user_id as rcvrMerUserId, rcvr_bnk_user_tp as rcvrBnkUserTp,rcvr_bnk_user_id as rcvrBnkUserId,rcvr_resv1 as rcvrResv1, rcvr_resv2 as rcvrResv2,sndr_bnk_no as sndrBankNo,sndr_name as sndrName, sndr_acct_no as sndrAcctNo,sndr_acct_nm as sndrAcctName, sndr_id_tp as sndrIdType,sndr_id_no as sndrIdNo,sndr_province as sndrProvince,sndr_city as sndrCity, sndr_area_co as sndrAreaCode,sndr_area_nm as sndrAreaName,sndr_mer_id as sndrMerId ,sndr_mer_cert_id as sndrMerCertId,sndr_post_id as sndrPostId, sndr_contract_no as sndrContractNo,sndr_contract_dt as sndrContractDate,sndr_proto_no as sndrProtoNo, sndr_mer_user_tp as sndrMerUserType,sndr_mer_user_id as sndrMerUserId ,sndr_bnk_user_tp as sndrBnkUserType,sndr_bnk_user_id as sndrBankUserId, sndr_resv1 as sndrResv1,sndr_resv2 as sndrResv2,lock_st as lockSt,tran_st as tranSt,business_type as businessType, rvrs_st as rvrsSt,product_nm as productName, APP_VERSION as appVersion,APP_SOURCE as appSource, RCVR_BNK_BRANCH_NAME as rcvrBnkBranchName,SNDR_BNK_BRANCH_NAME as sndrBnkBranchName, created_at as insertTimestamp, updated_at as updateTimestamp FROM be_command T WHERE T.REF_APP_NO = ?
```

一大坨SQL占满了整个屏幕，并且日志文件也会变得很大，其实这句SQL有用信息很少:

```
DEBUG : ==>  Preparing: SELECT xxx FROM be_command T WHERE T.REF_APP_NO = ?
```

所以我就想能不能像上面这样输出呢？看下面的demo

## 使用Log4j2的Replace功能
### pom.xml
```
<log4j2.api.version>2.5</log4j2.api.version>

...

<!--Log4j2-->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>${log4j2.api.version}</version>
</dependency>
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>${log4j2.api.version}</version>
</dependency>
```

### log4j2.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN" monitorInterval="300">
    <properties>
        <property name="LOG_HOME">/Users/kyg/logs/book</property>
    </properties>

    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%replace{%msg}{Preparing: SELECT [w ,]+ FROM be_command}{Preparing: SELECT xxx FROM be_command}%n"></PatternLayout>
        </Console>
    </Appenders>

    <Loggers>
        <Root level="debug" additivity="true">
            <AppenderRef ref="Console"></AppenderRef>
        </Root>
    </Loggers>
</Configuration>
```

### Test.java
```
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @author kangyonggan
 * @date 2017/3/28
 */
public class Test {

    private static Logger log = LogManager.getLogger(Test.class);

    public static void main(String[] args) {
        log.info("DEBUG : ==>  Preparing: SELECT serial_no as serialNo,bnk_no as bnkNo ,mer_org_serial_no as merOrgSerialNo,bnk_org_serial_no as bnkOrgSerialNo, mer_date as merDate,mer_time as merTime, mer_org_date as merOrgDate,mer_org_time as merOrgTime ,bnk_org_date as bnkOrgDate,bnk_org_time as bnkOrgTime, last_try_date as lastTryDate,last_try_time as lastTryTime ,last_snd_date as lastSndDate,last_snd_time as lastSndTime, last_qry_serial_no as lastQrySerialNo,last_qry_date as lastQryDate,last_qry_time as lastQryTime, input_date as inputDate,input_time as inputTime,mer_tran_co as merTranCo,bnk_tran_co as bnkTranCo, mer_org_tran_co as merOrgTranCo,bnk_org_tran_co as bankOrgTranCo ,tran_tp as tranTy,syn_flg as synFlg,bat_flg as batFlg, acount as acount,retry_flg as retryFlg,retry_max_time as retryMaxTime ,retry_interval as retryInterval, retry_counter as retryCounter,resnd_flg as resndFlg ,resnd_max_time as resndMaxTime,resnd_interval as resndInterval,resnd_counter as resndCounter, qry_flg as qryFlg,qry_tran_co as qryTranCo,qry_max_time as qryMaxTime,qry_interval as qryInterval, qry_counter as qryCounter,priority as priority,model as model ,product_id as productId,product_tp as productTp,cur_co as currencyCode, amount as amount,fee_amt as feeAmt,tran_purpose as tranPurpose ,tran_remark as tranRemark,ref_app_no as refAppNo, ref_app_kind as refAppKind,rcvr_bnk_no as rcvrBnkNo ,rcvr_acct_no as rcvrAcctNo,rcvr_acct_nm as rcvrAcctNm,rcvr_id_tp as rcvrIdTp,rcvr_id_no as rcvrIdNo, rcvr_province as rcvrProvince,rcvr_city as rcvrCity,rcvr_area_co as rcvrAreaCo,rcvr_area_nm as rcvrAreaNm, rcvr_mer_id as rcvrMerId,rcvr_mer_cert_id as rcvrMerCertId,rcvr_post_id as rcvrPostId ,rcvr_contract_no as rcvrContractNo,rcvr_contract_dt as rcvrContractDt, rcvr_proto_no as rcvrProtoNo,rcvr_mer_user_tp as rcvrMerUserTp,rcvr_mer_user_id as rcvrMerUserId, rcvr_bnk_user_tp as rcvrBnkUserTp,rcvr_bnk_user_id as rcvrBnkUserId,rcvr_resv1 as rcvrResv1, rcvr_resv2 as rcvrResv2,sndr_bnk_no as sndrBankNo,sndr_name as sndrName, sndr_acct_no as sndrAcctNo,sndr_acct_nm as sndrAcctName, sndr_id_tp as sndrIdType,sndr_id_no as sndrIdNo,sndr_province as sndrProvince,sndr_city as sndrCity, sndr_area_co as sndrAreaCode,sndr_area_nm as sndrAreaName,sndr_mer_id as sndrMerId ,sndr_mer_cert_id as sndrMerCertId,sndr_post_id as sndrPostId, sndr_contract_no as sndrContractNo,sndr_contract_dt as sndrContractDate,sndr_proto_no as sndrProtoNo, sndr_mer_user_tp as sndrMerUserType,sndr_mer_user_id as sndrMerUserId ,sndr_bnk_user_tp as sndrBnkUserType,sndr_bnk_user_id as sndrBankUserId, sndr_resv1 as sndrResv1,sndr_resv2 as sndrResv2,lock_st as lockSt,tran_st as tranSt,business_type as businessType, rvrs_st as rvrsSt,product_nm as productName, APP_VERSION as appVersion,APP_SOURCE as appSource, RCVR_BNK_BRANCH_NAME as rcvrBnkBranchName,SNDR_BNK_BRANCH_NAME as sndrBnkBranchName, created_at as insertTimestamp, updated_at as updateTimestamp FROM be_command T WHERE T.REF_APP_NO = ?");
    }

}
```

### 输出
```
DEBUG : ==>  Preparing: SELECT xxx FROM be_command T WHERE T.REF_APP_NO = ?

Process finished with exit code 0
```


', 0, 0, '2018-03-25 00:05:44', '2018-03-25 00:05:44');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Tomcat8访问软连接目录下的文件', '文件上传后一般是存于项目之外磁盘谋处，这个地方一般来说项目是无法访问的，这时候就可以利用软连接来实现了', 'other', '
### Tomcat7修改context.xml
```
<Context allowLinking="true" ></Context>
```

## Tomcat8修改context.xml
```
<Context>
  <Resources allowLinking="true" ></Resources>
</Context>
```

## 使用软链接

```
ln -s /home/kyg/data/blog/upload/ /home/kyg/install/apache-tomcat-8.5.6-blog/webapps/ROOT/WEB-INF/
```

', 0, 0, '2018-03-25 00:07:16', '2018-03-25 00:07:16');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('maven一键生成cms项目', '由于经常需要搭建一些类似cms这样的系统，如果每次都是手动创建项目，创建模块，拷贝改，无疑是蛋疼的。 所以我需要做一个项目原型，每次需要搭建类似cms系统的时候，只需要一键即可生成！', 'other', '
## 系统简介
系统结构如下:

![系统结构](https://kangyonggan.com/upload/cms_1.png)

### 各个模块之间的依赖关系
- `web模块` 依赖 `biz模块`
- `biz模块` 依赖 `service模块`和`dao模块`
- `service模块` 依赖 `model模块`
- `dao模块` 依赖 `model模块`

### 主要技术和框架
- Spring
- SpringMVC
- Mybatis
- autoconfig
- mbg
- shiro
- redis
- dubbo
- mysql
- freemarker
- ace admin ajax
- ftp
- log4j2
- fastjson
- lombok

## 基本功能
由于这只是一个项目原型，以后可能会用于各大场景，所以下面的功能只是一些最基础的。

### 网站
1. 登录
2. 注册
3. 找回密码

### 工作台
1. 系统
    - 用户管理
    - 角色管理
    - 菜单管理
2. 内容
    - 数据字典
    - 缓存管理
    - 内容管理
3. 我的
    - 个人资料

## 原型截图

![登录界面](https://kangyonggan.com/upload/cms_login.png)

![注册界面](https://kangyonggan.com/upload/cms_register.png)

![找回密码界面](https://kangyonggan.com/upload/cms_reset.png)

![个人资料界面](https://kangyonggan.com/upload/cms_profile.png)

![菜单管理界面](https://kangyonggan.com/upload/cms_menu.png)

## 使用方法
1. 拉取项目到本地 `git clone https://github.com/kangyonggan/cms-archetype.git`
2. 编译并安装 `mvn clean install`
3. 一键生成项目 `mvn archetype:generate -DarchetypeGroupId=com.kangyonggan.archetype -DarchetypeArtifactId=cms-archetype -DarchetypeVersion=1.0-SNAPSHOT -DarchetypeCatalog=local`


', 1, 0, '2018-03-25 00:07:42', '2018-03-25 00:07:42');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Mybatis Generator集成MapperPlugin、LombokPlugin和SerializablePlugin', '利用Mybatis的逆向生成，可以定制化的生成model、mapper等代码，并结合lombok插件，实现免去写Getter和Setter的烦恼', 'architect', '
## MBG集成MapperPlugin、LombokPlugin和SerializablePlugin
可以生成的持久层代码:

- 生成BeanMapper.java
- 生成BeanMapper.xml
- 生成Bean.java

### 特点
- 生成的Mapper.java继承了MyMapper.java(所有单表的crud全部不用写SQL)
- 实体bean拥有@Data注解（免去写getter、setter和toString的烦恼）
- 实体bean实现Serializable接口，可以放心的放入Redis缓存或传输如分布式系统间（如:dubbo）

<!-- more -->

> 坑：生成的Mapper.java，默认不带注解`@Repository`，如果你又没用spring扫描mapper包， 在运行时会报错，是运行时而不是启动时。

### 引入依赖和插件
`pom.xml`中的配置:

```
<plugin.mybatis-generator.version>1.3.2</plugin.mybatis-generator.version>
<mybatis-generator.version>1.3.2</mybatis-generator.version>
<mybatis-mapper.version>3.3.8</mybatis-mapper.version>
<lombok.version>1.16.8</lombok.version>

...

<!--MBG plugin-->
<plugin>
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-maven-plugin</artifactId>
    <version>${plugin.mybatis-generator.version}</version>
    <configuration>
        <verbose>true</verbose>
        <overwrite>true</overwrite>
    </configuration>
    <dependencies>
        <dependency>
            <groupId>${project.groupId}</groupId>
            <artifactId>api-dao</artifactId>
            <version>${project.version}</version>
        </dependency>
    </dependencies>
</plugin>

<dependency>
    <groupId>org.mybatis.generator</groupId>
    <artifactId>mybatis-generator-core</artifactId>
    <version>${mybatis-generator.version}</version>
    <scope>compile</scope>
    <optional>true</optional>
</dependency>
<dependency>
    <groupId>tk.mybatis</groupId>
    <artifactId>mapper</artifactId>
    <version>${mybatis-mapper.version}</version>
</dependency>

<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>${lombok.version}</version>
    <scope>provided</scope>
</dependency>
```

> 提示：MBG插件之所以依赖dao, 是因为我在插件中使用了dao中的两个类,下面有。

### 代码和插件配置

`MyMapper.java`

```
package com.kangyonggan.api.mapper;

import org.springframework.stereotype.Component;
import tk.mybatis.mapper.common.ConditionMapper;
import tk.mybatis.mapper.common.ExampleMapper;
import tk.mybatis.mapper.common.SqlServerMapper;
import tk.mybatis.mapper.common.base.BaseDeleteMapper;
import tk.mybatis.mapper.common.base.BaseSelectMapper;
import tk.mybatis.mapper.common.base.BaseUpdateMapper;

/**
 * @author kangyonggan
 * @date 16/5/12
 */
@Component
public interface MyMapper<T> extends
        BaseSelectMapper<T>,
        BaseUpdateMapper<T>,
        BaseDeleteMapper<T>,
        ExampleMapper<T>,
        ConditionMapper<T>,
        SqlServerMapper<T> {
}
```

`LombokPlugin.java`

```
package com.kangyonggan.api.mapper.util;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.PluginAdapter;
import org.mybatis.generator.api.dom.java.FullyQualifiedJavaType;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.java.TopLevelClass;

import java.util.List;

/**
 * @author kangyonggan
 * @date 16/5/12
 */
public class LombokPlugin extends PluginAdapter {
    private FullyQualifiedJavaType dataAnnotation = new FullyQualifiedJavaType("lombok.Data");

    public boolean validate(List<String> warnings) {
        return true;
    }

    public boolean modelBaseRecordClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        this.addDataAnnotation(topLevelClass);
        return true;
    }

    public boolean modelPrimaryKeyClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        this.addDataAnnotation(topLevelClass);
        return true;
    }

    public boolean modelRecordWithBLOBsClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
        this.addDataAnnotation(topLevelClass);
        return true;
    }

    public boolean modelGetterMethodGenerated(Method method, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        return false;
    }

    public boolean modelSetterMethodGenerated(Method method, TopLevelClass topLevelClass, IntrospectedColumn introspectedColumn, IntrospectedTable introspectedTable, ModelClassType modelClassType) {
        return false;
    }

    protected void addDataAnnotation(TopLevelClass topLevelClass) {
        topLevelClass.addImportedType(this.dataAnnotation);
        topLevelClass.addAnnotation("@Data");
    }
}
```

配置插件`generatorConfig.xml`, 插件放在dao模块的`src/main/resources`目录下即可

```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE generatorConfiguration PUBLIC
        "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <context id="sqlContext" targetRuntime="MyBatis3Simple" defaultModelType="flat">

        <property name="beginningDelimiter" value="`"></property>
        <property name="endingDelimiter" value="`"></property>

        <!--base mapper-->
        <plugin type="tk.mybatis.mapper.generator.MapperPlugin">
            <property name="mappers" value="com.kangyonggan.api.mapper.MyMapper"></property>
        </plugin>

        <!--serialize plugin-->
        <plugin type="org.mybatis.generator.plugins.SerializablePlugin"></plugin>

        <!--lombok plugin-->
        <plugin type="com.kangyonggan.api.mapper.util.LombokPlugin"></plugin>

        <!--jdbc driver-->
        <jdbcConnection driverClass="com.mysql.jdbc.Driver"
                        connectionURL="jdbc:mysql://127.0.0.1:3306/api"
                        userId="root" password="123456"></jdbcConnection>

        <!--Xxx.java-->
        <javaModelGenerator targetPackage="com.kangyonggan.api.model.vo"
                            targetProject="../api-model/src/main/java">
            <property name="enableSubPackages" value="true"></property>
            <property name="trimStrings" value="true"></property>
        </javaModelGenerator>

        <!--XxxMapper.xml-->
        <sqlMapGenerator targetPackage="mapper" targetProject="src/main/resources">
            <property name="enableSubPackages" value="true"></property>
        </sqlMapGenerator>

        <!--XxxMapper.java-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.kangyonggan.api.mapper"
                             targetProject="src/main/java">
            <property name="enableSubPackages" value="true"></property>
        </javaClientGenerator>

        <!--table name-->
        <table tableName="table_name">
            <generatedKey column="id" sqlStatement="Mysql" identity="true"></generatedKey>
        </table>
    </context>
</generatorConfiguration>
```

### 使用
1. 在项目跟目录下`mvn clean install`, 目的是打包`xxx-dao.jar`，好让插件去依赖
2. 使用 IntelliJ IDEA的，请参考下图(两步), 其他工具我不用，请自行摸索

![使用说明](https://kangyonggan.com/upload/20170105191303945.png)

> 温馨提示：以上配置是我个人配置，请勿直接使用，使用前请自行改造。






', 1, 0, '2018-03-25 00:10:34', '2018-03-25 00:10:34');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('MySQL5.6主从复制的配置', '下面是MySQL一主多从的配置，也是一些中小企业常用的方案', 'db', '
## 实验环境
1. 主库机器IP: `10.10.10.248`
2. 从库机器IP: `10.10.10.166`
3. 数据库版本: `Mysql 5.6`
4. 操作系统: `Ubuntu 14.04`

<!-- more -->

## 配置主库
### 修改`/etc/mysql/my.cfg`配置，在`[mysqld]`下面添加：

```
log-bin=mysql-bin

server-id=1

```

保存后重启mysql:

```
sudo /etc/init.d/mysql restart
```

### 创建一个用户，并授权给从服务器
登录mysql

```
mysql -uroot -p
```

创建用户`kyg`并授权给从服务器:

```
grant replication slave on *.* to ''kyg''@''10.10.10.166'' identified by ''kyg'';
```

![master](https://kangyonggan.com/upload/20170101145536544.png)

最后别忘了刷新权限:

```
flush privileges;
```

### 查看主库状态
```
show master status;
```

记录下`File`和`Position`的值，后面配置从库时会用到

![master-status](https://kangyonggan.com/upload/20170101145208095.png)

## 配置从库
### 修改`/etc/mysql/my.cfg`配置，在`[mysqld]`下面添加：
```
server-id=2
```

保存后重启mysql:

```
sudo /etc/init.d/mysql restart
```

## 登录mysql，并配置相关参数:

```
change master to
master_host = ''10.10.10.248'',
master_user = ''kyg'',
master_password = ''kyg'',
master_log_file = ''mysql-bin.000004'',
master_log_pos = 120;
```

查看从库状态

```
show slave status G;
```

会发现从库还没开启复制

![slave-status1](https://kangyonggan.com/upload/20170101145456162.png)

这时候就需要开启从库的复制功能`start slave;`

![slave-status2](https://kangyonggan.com/upload/20170101145208097.png)

上面的截图再往下滚动， 可能会看见报错:

```
error connecting to master ''kyg@10.10.10.248:3306'' - retry-time: 60  retries: 7
```

这是由于主库配置了`bind-address:127.0.0.1`, 为了简单，我直接把这一行配置注释了(有安全隐患)

停止从库的复制功能:

```
stop slave
```

## 测试
### 在主库创建一个数据库`blog`
然后在从库中查看所有数据库

```
show databases;
```

![show-db](https://kangyonggan.com/upload/20170101145208096.png)

会发现从库从主库中复制了一个数据库, 实验已经成功，其他CRUD请自行实验





', 1, 0, '2018-03-25 00:11:51', '2018-03-25 00:11:51');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('MySQL报错：数据库结构错误', '开开心心的打开电脑进行开发，却发现数据库报错了，还是一个看起来一脸懵逼的报错', 'db', '
> ERROR 1682 (HY000): Native table ''performance_schema''.''session_variables'' has the wrong structure

## 重启MySQL
重启MySQL后还是报同样的错。

## 重启电脑
重启电脑后还是报同样的错。

## 谷歌搜一下
需要更新MySQL：

```
mysql_upgrade -u root -p
```

<!-- more -->

输出信息如下:

```
kangyonggandeMacBook-Pro:~ kyg$ mysql_upgrade -u root -p
Enter password:
Checking if update is needed.
Checking server version.
Running queries to upgrade MySQL server.
Checking system database.
mysql.columns_priv                                 OK
mysql.db                                           OK
mysql.engine_cost                                  OK
mysql.event                                        OK
mysql.func                                         OK
mysql.general_log                                  OK
mysql.gtid_executed                                OK
mysql.help_category                                OK
mysql.help_keyword                                 OK
mysql.help_relation                                OK
mysql.help_topic                                   OK
mysql.innodb_index_stats                           OK
mysql.innodb_table_stats                           OK
mysql.ndb_binlog_index                             OK
mysql.plugin                                       OK
mysql.proc                                         OK
mysql.procs_priv                                   OK
mysql.proxies_priv                                 OK
mysql.server_cost                                  OK
mysql.servers                                      OK
mysql.slave_master_info                            OK
mysql.slave_relay_log_info                         OK
mysql.slave_worker_info                            OK
mysql.slow_log                                     OK
mysql.tables_priv                                  OK
mysql.time_zone                                    OK
mysql.time_zone_leap_second                        OK
mysql.time_zone_name                               OK
mysql.time_zone_transition                         OK
mysql.time_zone_transition_type                    OK
mysql.user                                         OK
The sys schema is already up to date (version 1.5.1).
Checking databases.
simconf.user_role                                  OK
simulator.bank_channel                             OK
simulator.bank_command                             OK
simulator.bank_command_log                         OK
simulator.bank_resp                                OK
simulator.bank_tran                                OK
simulator.dz_file                                  OK
simulator.menu                                     OK
simulator.role                                     OK
simulator.role_menu                                OK
simulator.sim_order                                OK
simulator.user                                     OK
simulator.user_role                                OK
sys.sys_config                                     OK
Upgrade process completed successfully.
Could not create the upgrade info file ''/usr/local/mysql/data/mysql_upgrade_info'' in the MySQL Servers datadir, errno: 13
kangyonggandeMacBook-Pro:~ kyg$
```

报错说是不能创建文件，可能是权限不足吧，于是

```
sudo mysql_upgrade -u root -p
```

输出:

```
...省略...
Upgrade process completed successfully.
Checking if update is needed.
```

这次没报错以为成功了，然后就测试了一把，发现还是报同样的错。

## 再次重启MySQL
测试后发现不报错了。

> 问题是小问题，如果之前遇到过此类问题可以一步解决，但是如果没遇到过，就需要按部就班的去解决了。



', 0, 0, '2018-03-25 00:12:59', '2018-03-25 00:12:59');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('MySQL数据库定时备份', '写了那么多的博客，那么多的内容，万一数据库挂了，或者电脑坏了，怎么办？当然是定时备份了', 'db', '
## 创建备份脚本
创建`.bak.sh`, 内容为:

```

today=`date +%Y%m%d`

mysqldump -uroot -p123456 blog > /home/kyg/bak/blog-bak-$today.sql

scp /home/kyg/bak/blog-bak-$today.sql root@121.40.66.176:/root/bak/
```

<!-- more -->

> 其中，备份到远程时，用到了免密登录，请参考我的另一篇博客

## 定时执行
定时执行用的是linux下自带的`crontab`命令

`crontab -l` 查看任务

`crontab -e` 编辑任务

我设置的是，每天凌晨3点执行备份:

```
0 3 * * * sh /home/kyg/.bak.sh
```



', 0, 0, '2018-03-25 00:14:11', '2018-03-25 00:14:11');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('MySQL读写分离的实现', '为了减轻主库的压力，可以让查询走从库，主库只用来写操作', 'db', '
## 实验环境
1. 主库:192.168.2.108:3306/kyg
2. 从库1:192.168.2.113:3306/kyg
3. 从库2:192.168.2.103:3306/kyg

<!-- more -->

## 实验目的
1. 写数据时使用主库
2. 读数据时使用从库

## 实现方案
使用MySQL自身提供的一个驱动`com.mysql.jdbc.ReplicationDriver`来实现读写分离。
如果一个方法是只读的，那么ReplicationDriver就会为你选择从库读取数据，反之就会选择主库进行读写。
可以结合SpringAop配置事物的读写：

```
<tx:advice id="transactionAdvice" transaction-manager="transactionManager">
    <tx:attributes>
        <tx:method name="delete*" propagation="REQUIRED"></tx:method>
        <tx:method name="update*" propagation="REQUIRED"></tx:method>
        <tx:method name="save*" propagation="REQUIRED"></tx:method>
        <tx:method name="remove*" propagation="REQUIRED"></tx:method>

        <tx:method name="search*" read-only="true" propagation="REQUIRED"></tx:method>
        <tx:method name="find*" read-only="true" propagation="REQUIRED"></tx:method>
        <tx:method name="get*" read-only="true" propagation="REQUIRED"></tx:method>
        <tx:method name="*" read-only="true" propagation="REQUIRED"></tx:method>
    </tx:attributes>
</tx:advice>
```

jdbc的配置:

```
blog.jdbc.driver     = com.mysql.jdbc.Driver
blog.jdbc.password   = abc
blog.jdbc.url        = jdbc:mysql:replication://192.168.2.108:3306,192.168.2.113:3306,192.168.2.103:3306/kyg
blog.jdbc.username   = abc
```

## 观察日志

![走主库](https://kangyonggan.com/upload/20170107152930664.png)

![走从库](https://kangyonggan.com/upload/20170107152931258.png)



', 1, 0, '2018-03-25 00:15:29', '2018-03-25 00:15:29');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('nginx做负载均衡遇到session共享的问题', '这是集群中常见的session共享的问题，大多数公司一般都是把session放在缓存中', 'other', '
## 常见的解决方案有:
### 不使用session，换用cookie
- 简单方便对服务器无压力
- 如果客户端把cookie禁掉了的话，那么session就无法同步了
- cookie的安全性不高，虽然它已经加了密，但是还是可以伪造的

### session存在数据库
- 会加大数据库的IO，增加数据库的负担
- 数据库读写速度较慢，不利于session的适时同步

<!-- more -->

### session存在memcache或者Redis中
- 不会加大数据库的负担
- 并且安全性比用cookie大大的提高
- 把session放到内存里面，比从文件中读取要快很多
- 但偶尔会因网络较慢而出现掉线

### 使用nginx中的ip_hash技术
- 能够将某个ip的请求定向到同一台后端
- nginx不是最前端的服务器的时候，就跪了，因为转发到nginx的ip是不变的
- nginx不是最后端的服务器的时候，也得跪

> 我个人的情况比较适合选择方案3+4

## 配置如下
```
upstream kyg.com {
        server  42.196.156.22:8088;
        server  42.196.156.22:18088;
        server  42.196.156.22:28088;
        ip_hash;
}

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.html index.htm;

        # Make site accessible from http://localhost/
        server_name localhost;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                # try_files $uri $uri/ =404;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
                proxy_pass http://kyg.com;
        }

        # 设定访问静态文件直接读取不经过tomcat
        location ^~ /static/ {
                proxy_pass http://kyg.com;
                root /WEB-INF/static/;
        }
}
```

就是在`upstream`下面加了`ip_hash;`配置

> 集群在设计之初最好设计成无状态的

', 0, 0, '2018-03-25 00:17:06', '2018-03-25 00:17:06');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Nginx报错：413 Request Entity Too Large', 'nginx转发报错，因为上传的附件太大，所以需要在nginx中配置一下所允许的最大请求', 'other', '在http模块下添加配置:

```
http {
    ...
    client_max_body_size 10m;
    ...
}

```
', 0, 0, '2018-03-25 00:18:40', '2018-03-25 00:18:40');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('nginx负载均衡的配置', '一般公司都用的集群，那么久必然会遇到负载均衡的问题', 'other', '

## 实验环境
1. 机器1的ip:10.10.10.248, tomcat端口:8088
2. 机器2的ip:10.10.10.166, tomcat端口:8088
3. nginx所在机器ip:10.10.10.248, 监听端口80

<!-- more -->

## 启动两个tomcat，配置nginx
我使用的是jenkins启动的tomcat，一键部署成功, 效果如下:

![tomcat-166.png](https://kangyonggan.com/upload/20170101200131662.png)

![tomcat-248.png](https://kangyonggan.com/upload/20170101200131669.png)

我的nginx是部署在248服务器上，监听的是80端口， 现在想做的就是:
在访问http://10.10.10.248:80的时候，nginx把所有的请求均等转发到10.10.10.248:8088和10.10.10.166:8088

nginx配置`/etc/nginx/sites-available/default`如下:

```
upstream kyg.com {
       server  10.10.10.248:8088;
       server  10.10.10.166:8088;
}

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.html index.htm;

        # Make site accessible from http://localhost/
        server_name localhost;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                # try_files $uri $uri/ =404;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
                proxy_pass http://kyg.com;
        }

        # 设定访问静态文件直接读取不经过tomcat
        location ^~ /static/ {
                proxy_pass http://kyg.com;
                root /WEB-INF/static/;
        }
}
```

修改nginx配置后需要重新加载配置`sudo nginx -s reload`

### 查看日志，分析结果
1. 分别在两台服务器上`tail -f /home/kyg/logs/blog/all.log`
2. 然后访问http://10.10.10.248
3. 观察哪台服务器会刷日志
4. 再次访问http://10.10.10.248
5. 观察哪台服务器会刷日志
6. 重复访问观察...

![log](https://kangyonggan.com/upload/20170101205501760.png)

发现nginx会把所有的请求均等的（发给你一次发给我一次）转发到两台服务器, 当然你也可以配置权重，让某台服务分担的压力小一点，或者动态负载均衡等。

## kill其中一个tomcat
我现在把166服务器kill了，在访问并观察日志, 结果：

1. 网站仍然可以正常访问
2. 所有的访问全部转发到248服务器

## 分布式服务需要解决的几个问题
1. 会话共享，请参考我的另一篇博客`shiro集成redis实现session集群共享`
2. 文件共享, 请参考我的另一篇博客`ubuntu下配置ftp服务器`




', 0, 0, '2018-03-25 00:19:58', '2018-03-25 00:19:58');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('shiro集成redis实现session集群共享', '在集群中，一般来说session都是放在缓存中的', 'server', '
## 好处
1. session在tomcat集群中共享（单点登录）
2. tomcat重启后会话不丢失

## 实现
覆写`EnterpriseCacheSessionDAO`

```
package com.kangyonggan.blog.web.shiro;

import com.kangyonggan.api.common.service.RedisService;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.EnterpriseCacheSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;

/**
 * @author kangyonggan
 * @date 2016/12/31
 */
public class MyEnterpriseCacheSessionDAO extends EnterpriseCacheSessionDAO {

    @Autowired
    private RedisService redisService;

    /**
     * 创建session，保存到redis数据库
     *
     * @param session
     * @return
     */
    @Override
    protected Serializable doCreate(Session session) {
        Serializable sessionId = super.doCreate(session);
        redisService.set(sessionId.toString(), session);

        return sessionId;
    }

    /**
     * 获取session
     *
     * @param sessionId
     * @return
     */
    @Override
    protected Session doReadSession(Serializable sessionId) {
        // 先从缓存中获取session，如果没有再去数据库中获取
        Session session = super.doReadSession(sessionId);
        if (session == null) {
            session = (Session) redisService.get(sessionId.toString());
        }
        return session;
    }

    /**
     * 更新session的最后一次访问时间
     *
     * @param session
     */
    @Override
    protected void doUpdate(Session session) {
        super.doUpdate(session);
        redisService.set(session.getId().toString(), session);
    }

    /**
     * 删除session
     *
     * @param session
     */
    @Override
    protected void doDelete(Session session) {
        super.doDelete(session);
        redisService.delete(session.getId().toString());
    }

}
```

> 但是一般还是别在集群中使用session。

', 0, 0, '2018-03-25 00:21:15', '2018-03-25 00:21:15');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('ssh端口转发', '可以结合nginx将内网机器变成外面机器', 'linux', '## 转发本地到远端
```
ssh -C -f -N -g -L 本地端口:远端IP:远端端口 远端用户名@远端IP
```

### 例子
```
ssh -C -f -N -g -L 2222:42.196.156.22:22 kyg@42.196.156.22
```

所有请求本地2222端口的请求，都会转发给42.196.156的22端口

> 网络前提：远端机器一定要能访问本地机器，不要求本地机器能访问远端机器

<!-- more -->

## 转发远端到本地
```
ssh -C -f -N -g –R 远端端口:本地IP:本地端口 远端用户名@远端IP
```

### 例子
```
ssh -C -f -N -g -R 2323:127.0.0.1:22 root@121.40.66.176
```

所有请求121.40.66.176:2323的请求，都会转发给本地的22端口

> 网络前提：本地机器一定要能访问远端机器，不要求远端机器能访问本地机器


', 0, 0, '2018-03-25 00:22:11', '2018-03-25 00:22:11');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('ssh免密登录', '在使用一些脚本从某机器向另外一个机器拷贝文件时，脚本不方便输入密码，这时候就可以使用免密登录了', 'linux', '
现在有两台机器A和B， 想要用ssh从A登录到B， 并且不使用密码

## 在A机器上生成密钥对
```
ssh-keygen -t rsa
```

然后会有三次提示用户输入， 什么也不要输入， 直接回车， 就会在用户根目录生成`.ssh`文件夹, 文件夹里会有`id_rsa`私钥和`id_rsa.pub`公钥

## 把公钥导入B机器
```
ssh-copy-id -i .ssh/id_rsa.pub root@192.168.20.212
```

<!-- more -->

执行这个命令会要求输入一次密码， 不过以后就不用再输密码了。
如果A机器没安装ssh-copy-id命令， 可以先运行下面的命令去下载`ssh-copy-id`

```
curl -L https://raw.githubusercontent.com/beautifulcode/ssh-copy-id-for-OSX/master/install.sh | sh
```

也可以手动导入， 先把公钥scp到B机器（也要输入一次密码），
然后输出到.ssh/authorized_keys文件中即可

```
cat id_rsa.pub > .ssh/authorized_keys
```

## 免密登录测试

```
ssh root@192.168.20.212
```


', 0, 0, '2018-03-25 00:23:19', '2018-03-25 00:23:19');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('ssh登录控制,登录失败5次禁IP', '如何防止自己的服务器被攻击呢，下面是一个防止别人暴力登录服务器的方案', 'linux', '
今天在登录我服务器的时候，发现了下面这段话

```
kangyonggandeMacBook-Pro:~ kyg$ ./.login.sh
Last failed login: Sun Mar  5 13:27:21 EST 2017 from 42.196.186.61 on ssh:notty
There were 721 failed login attempts since the last successful login.
Last login: Sat Mar  4 07:33:47 2017 from 192.168.2.222
```

<!-- more -->

发现是有人尝试爆破我的服务器，我的服务器是CentOS7,于是我查看日志：

```
[root@localhost log]# pwd
/var/log
[root@localhost log]# ll
总用量 10044
drwxr-xr-x. 2 root   root       176 2月  26 08:37 anaconda
drwx------. 2 root   root        99 3月   5 07:30 audit
-rw-r--r--. 1 root   root      9671 3月   1 08:05 boot.log
-rw-------. 1 root   utmp    473856 3月   5 13:27 btmp
-rw-------. 1 root   utmp    462720 2月  28 12:15 btmp-20170301
drwxr-xr-x. 2 chrony chrony       6 12月  6 17:42 chrony
-rw-------. 1 root   root     51771 3月   6 02:01 cron
-rw-r--r--. 1 root   root     59619 3月   1 08:05 dmesg
-rw-r--r--. 1 root   root     59102 2月  28 06:39 dmesg.old
-rw-r--r--. 1 root   root      2873 2月  27 07:19 firewalld
-rw-------. 1 root   root      1280 2月  26 08:42 grubby
-rw-r--r--. 1 root   root    291708 3月   6 02:06 lastlog
-rw-------. 1 root   root      3805 3月   5 03:00 maillog
-rw-------. 1 root   root   3661588 3月   6 02:20 messages
-rw-r--r--. 1 mysql  mysql    65242 3月   2 02:48 mysqld.log
drwx------. 2 root   root         6 6月  10 2014 ppp
drwxr-xr-x. 2 root   root         6 2月  26 08:37 rhsm
-rw-------. 1 root   root   3081270 3月   6 02:20 secure
-rw-------. 1 root   root         0 2月  26 08:35 spooler
-rw-------. 1 root   root         0 2月  26 08:34 tallylog
drwxr-xr-x. 2 root   root        23 12月  6 17:26 tuned
-rw-------. 1 root   root     29494 3月   6 02:17 wpa_supplicant.log
-rw-r--r--. 1 root   root     51059 2月  27 06:32 wpa_supplicant.log-20170227
-rw-rw-r--. 1 root   utmp     44160 3月   6 02:06 wtmp
-rw-------. 1 root   root      7438 2月  27 07:03 yum.log

[root@localhost log]# grep "Failed password for" secure
...太多就不贴出来了
Mar  4 21:34:02 localhost sshd[24674]: Failed password for root from 42.196.186.61 port 56860 ssh2
Mar  4 21:34:05 localhost sshd[24674]: Failed password for root from 42.196.186.61 port 56860 ssh2
Mar  4 21:34:07 localhost sshd[24679]: Failed password for root from 42.196.186.61 port 56862 ssh2
Mar  4 21:34:09 localhost sshd[24679]: Failed password for root from 42.196.186.61 port 56862 ssh2
Mar  4 21:34:12 localhost sshd[24679]: Failed password for root from 42.196.186.61 port 56862 ssh2
Mar  4 21:34:14 localhost sshd[24684]: Failed password for root from 42.196.186.61 port 56962 ssh2
Mar  4 21:34:17 localhost sshd[24684]: Failed password for root from 42.196.186.61 port 56962 ssh2
Mar  5 04:37:23 localhost sshd[26486]: Failed password for root from 42.196.186.61 port 57172 ssh2
Mar  5 04:37:25 localhost sshd[26486]: Failed password for root from 42.196.186.61 port 57172 ssh2
Mar  5 04:37:26 localhost sshd[26486]: Failed password for root from 42.196.186.61 port 57172 ssh2
Mar  5 04:37:28 localhost sshd[26486]: Failed password for root from 42.196.186.61 port 57172 ssh2
Mar  5 04:37:30 localhost sshd[26486]: Failed password for root from 42.196.186.61 port 57172 ssh2
Mar  5 04:37:32 localhost sshd[26486]: Failed password for root from 42.196.186.61 port 57172 ssh2
Mar  5 05:06:04 localhost sshd[26627]: Failed password for root from 42.196.186.61 port 60976 ssh2
Mar  5 05:06:07 localhost sshd[26627]: Failed password for root from 42.196.186.61 port 60976 ssh2
Mar  5 05:06:09 localhost sshd[26627]: Failed password for root from 42.196.186.61 port 60976 ssh2
Mar  5 05:06:12 localhost sshd[26627]: Failed password for root from 42.196.186.61 port 60976 ssh2
Mar  5 05:06:14 localhost sshd[26627]: Failed password for root from 42.196.186.61 port 60976 ssh2
Mar  5 05:06:17 localhost sshd[26627]: Failed password for root from 42.196.186.61 port 60976 ssh2
Mar  5 10:05:12 localhost sshd[27881]: Failed password for root from 123.207.23.34 port 38482 ssh2
Mar  5 10:05:15 localhost sshd[27881]: Failed password for root from 123.207.23.34 port 38482 ssh2
Mar  5 10:05:17 localhost sshd[27881]: Failed password for root from 123.207.23.34 port 38482 ssh2
Mar  5 10:05:19 localhost sshd[27881]: Failed password for root from 123.207.23.34 port 38482 ssh2
Mar  5 10:05:21 localhost sshd[27881]: Failed password for root from 123.207.23.34 port 38482 ssh2
Mar  5 10:05:24 localhost sshd[27881]: Failed password for root from 123.207.23.34 port 38482 ssh2
Mar  5 13:27:07 localhost sshd[28721]: Failed password for root from 42.196.186.61 port 43224 ssh2
Mar  5 13:27:10 localhost sshd[28721]: Failed password for root from 42.196.186.61 port 43224 ssh2
Mar  5 13:27:13 localhost sshd[28721]: Failed password for root from 42.196.186.61 port 43224 ssh2
Mar  5 13:27:16 localhost sshd[28721]: Failed password for root from 42.196.186.61 port 43224 ssh2
Mar  5 13:27:18 localhost sshd[28721]: Failed password for root from 42.196.186.61 port 43224 ssh2
Mar  5 13:27:21 localhost sshd[28721]: Failed password for root from 42.196.186.61 port 43224 ssh2
```

看到这么多的登录失败，我觉得我需要做些什么才行，比如：禁止用户名密码登录，只允许秘钥登录，但是有时候用别人的电脑没秘钥会不方便，所以，我决定`登录失败超过5次禁IP`

下面是脚本`.ip-deny.sh`：

```
#! /bin/sh

cat /var/log/secure | awk ''/Failed/{print $(NF-3)}'' | sort | uniq -c | awk ''{print $2"="$1;}'' > /root/ip-black.txt

MAX=5

for i in `cat  /root/ip-black.txt`
do
  ip=`echo $i |awk -F= ''{print $1}''`
  cnt=`echo $i |awk -F= ''{print $2}''`
  if [ $cnt -gt $MAX ]
  then
    grep $ip /etc/hosts.deny > /dev/null
    if [ $? -gt 0 ]
    then
      echo "sshd:$ip:deny" >> /etc/hosts.deny
    fi
  fi

done

cat /etc/hosts.deny
```

最后在定时任务中，每隔1分钟执行一次脚本：

```
[root@localhost ~]# crontab -e
```

查看所有定时任务：

```
[root@localhost ~]# crontab -l
# m h  dom mon dow   command


# 每天凌晨三点备份数据
0 3 * * * sh /root/.back.sh

# 每隔1分钟执行一次，登录失败超过5次禁IP
*/1 * * * *  sh /root/.ip-deny.sh
```

经试验，登录失败五次，然后再经过1分钟之后（之内），试验生效！



', 0, 0, '2018-03-25 00:24:29', '2018-03-25 00:24:29');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('ssh登录时指定密码', '使用此宝可以在命令行中输入密码，以减少命令行和自己的交互，大大提高工作速度', 'linux', '
## 下载`sshpass`
[http://sourceforge.net/projects/sshpass/](http://sourceforge.net/projects/sshpass/)

## 安装
```
[root@localhost ~]# tar -zxvf sshpass-1.06.tar.gz -C /root/install/
[root@localhost ~]# cd /root/install/sshpass-1.06
[root@localhost sshpass-1.06]# ./configure
[root@localhost sshpass-1.06]# make
[root@localhost sshpass-1.06]# make install
```

## 使用
```
[root@localhost ~]# sshpass -p 123456 ssh root@121.40.66.176
```


', 0, 0, '2018-03-25 00:25:50', '2018-03-25 00:25:50');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('从零开始搭建NexT主题的Hexo博客', '如果没有个人服务器，那么久可以使用此种方案搭建一个免费博客，这是一个静态博客，看起来还挺炫酷的', 'other', '
> 参考文档: [http://theme-next.iissnan.com/getting-started.html](http://theme-next.iissnan.com/getting-started.html)

## 系统版本
```
root@iZ23ldh8kudZ:~# cat /etc/issue
Ubuntu 16.04.2 LTS
 l
```

其他系统搭建流程类似，这里不一一演示。

## 准备工作
关于hexo和next的基本概念这里不再介绍，只说怎么安装和使用。

<!-- more -->

### 安装Git
```
root@iZ23ldh8kudZ:~# apt-get update
root@iZ23ldh8kudZ:~# apt-get install git
```

### 安装Node.js
```
root@iZ23ldh8kudZ:~# apt-get install nodejs
root@iZ23ldh8kudZ:~# apt-get install npm
```

<!-- more -->

## 安装Hexo
```
root@iZ23ldh8kudZ:~# npm install -g hexo-cli
```

发现报错, 经谷歌后，在需要安装nodejs-legacy：

```
root@iZ23ldh8kudZ:~# apt-get install nodejs-legacy
```

再次安装hexo-cli后成功！

```
root@iZ23ldh8kudZ:~# hexo -version
hexo-cli: 1.0.2
os: Linux 4.4.0-63-generic linux x64
http_parser: 2.5.0
node: 4.2.6
v8: 4.5.103.35
uv: 1.8.0
zlib: 1.2.8
ares: 1.10.1-DEV
icu: 55.1
modules: 46
openssl: 1.0.2g-fips
```

## 建站
```
root@iZ23ldh8kudZ:~# hexo init blog
root@iZ23ldh8kudZ:~# cd blog/
root@iZ23ldh8kudZ:~/blog# npm install
```

### 启动
```
root@iZ23ldh8kudZ:~/blog# hexo s
```

### 查看
在浏览器中输入localhost:4000，查看效果如下：

![hexo-01](https://kangyonggan.com/upload/hexo-01.png)

至此，hexo博客就搭建好了，接下来就是安装NexT主题并且进行各种配置了。

## 安装NexT主题
```
root@iZ23ldh8kudZ:~/blog# pwd
/root/blog
root@iZ23ldh8kudZ:~/blog# git clone https://github.com/iissnan/hexo-theme-next themes/next
```

安装成功之后，会发现主题文件夹下面多了一个`next`文件夹

```
root@iZ23ldh8kudZ:~/blog# ll themes/
total 16
drwxr-xr-x 4 root root 4096 Mar 28 17:58 ./
drwxr-xr-x 6 root root 4096 Mar 28 17:48 ../
drwxr-xr-x 6 root root 4096 Mar 28 17:26 landscape/
drwxr-xr-x 9 root root 4096 Mar 28 17:59 next/
```

### 使用next主题
编辑`站点配置文件`, 修改theme配置的值：

```
theme: next
```

重启hexo，查看界面效果：

![hexo-02](https://kangyonggan.com/upload/hexo-02.png)

> 提示：修改站点配置需要重启，修改主题文件不需要重启，如果改了没生效，请运行`hexo clean`

个人感觉这个有点丑，所以我又换了一个风格，next提供了3中风格的主题：

- Muse - 默认 Scheme，这是 NexT 最初的版本，黑白主调，大量留白
- Mist - Muse 的紧凑版本，整洁有序的单栏外观
- Pisces - 双栏 Scheme，小家碧玉似的清新

修改`主题配置文件`, 修改scheme配置的值：

```
scheme: Mist
```

重启hexo，查看界面效果：

![hexo-03](https://kangyonggan.com/upload/hexo-03.png)

个人比较喜欢这种风格的主题。

## 个性化设置
### 网站相关设置
修改`站点配置文件`， Site相关配置默认如下：

```
title: Hexo
subtitle:
description:
author: John Doe
language:
timezone:
```

经过配置后：

```
title: 东方娇子
subtitle:
description: 二逼青年欢乐多
author: 康永敢
language: zh-Hans
timezone:
```

设置`favicon`： 把favicon.ico放在`source/`目录下即可。

设置作者头像：
修改`主题配置文件`：

```
avatar: /upload/avatar.png
```

然后把你的头像(avatar.png)放在`themes/next/source/upload/`目录下，没有uploads目录的话可以自己创建一个。


重启后查看效果如下：

![hexo-04](https://kangyonggan.com/upload/hexo-04.png)

> 头像可以设置成gif动态图！

### 菜单相关设置
修改`主题配置文件`，默认菜单相关配置如下：

```

menu:
  home: /
  #categories: /categories
  #about: /about
  archives: /archives
  tags: /tags
  #sitemap: /sitemap.xml
  #commonweal: /404.html


menu_icons:
  enable: true
  #KeyMapsToMenuItemKey: NameOfTheIconFromFontAwesome
  home: home
  about: user
  categories: th
  schedule: calendar
  tags: tags
  archives: archive
  sitemap: sitemap
  commonweal: heartbeat

```

本人配置后如下：

```
menu:
  home: /
  categories: /categories
  about: /about
  archives: /archives
  tags: /tags
  sitemap: /sitemap.xml
  commonweal: /404.html


menu_icons:
  enable: true
  #KeyMapsToMenuItemKey: NameOfTheIconFromFontAwesome
  home: home
  about: user
  categories: th
  schedule: calendar
  tags: tags
  archives: archive
  sitemap: sitemap
  commonweal: heartbeat
```

图标我没换变，用的默认的，只是多显示了几个菜单而已，当然，现在的菜单是不能正常使用的，还需要再做一些操作。

效果如下:

![hexo-05](https://kangyonggan.com/upload/hexo-05.png)

现在看起来好像该有的都有了，但是点击之后会报错，比如点击“关于”菜单：

![hexo-06](https://kangyonggan.com/upload/hexo-06.png)

### 关于

发现缺少“关于”页面，下面就来添加关于页面：

```
root@iZ23ldh8kudZ:~/blog# hexo new page about
INFO  Created: ~/blog/source/about/index.md
root@iZ23ldh8kudZ:~/blog# ll source/
total 36
drwxr-xr-x 4 root root  4096 Mar 28 21:18 ./
drwxr-xr-x 6 root root  4096 Mar 28 20:24 ../
drwxr-xr-x 2 root root  4096 Mar 28 21:18 about/
-rw-r--r-- 1 root root 16958 Mar 28 20:58 favicon.ico
drwxr-xr-x 2 root root  4096 Mar 28 17:26 _posts/
```

发现在source目录下了生成一个about文件夹，about里面是一个md文件， 内容为：

```
root@iZ23ldh8kudZ:~/blog# cat source/about/index.md
---
title: about
date: 2017-03-28 21:18:40
---
```

本人编辑后内容为：


    ---
    title: 关于作者
    date: 2017-03-25 14:15:25
    comments: false
    ---

    ###
    - 姓名：康永敢
    - 性别：男
    - 职业：Java开发

    ### 联系方式
    - 手机：18221372104
    - 邮箱：kangyonggan@gmail.com
    - QQ：2825176081
    - 现住址：上海市松江区九亭镇
    - 工作地址：上海市南京西路399号明天广场21楼（华信证券）


其中`comments`表示此页面不需要评论，关于评论的问题下面会讨论。
刷新后界面如下：

![hexo-07](https://kangyonggan.com/upload/hexo-07.png)

### 404
404页面我用的是公益404，在source目录下创建404.html, 内容如下：

```
<!DOCTYPE HTML>
<html>
<head>
  <meta http-equiv="content-type" content="text/html;charset=utf-8;"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="robots" content="all" />
  <meta name="robots" content="index,follow"/>
  <div class="hidden ajax-append-link" rel="stylesheet" type="text/css" href="https://qzone.qq.com/gy/404/style/404style.css">
</head>
<body>
  <script type="text/plain" src="http://www.qq.com/404/search_children.js"
          charset="utf-8" homePageUrl="/"
          homePageName="回到我的主页">
  </script>
  <script src="https://qzone.qq.com/gy/404/data.js" charset="utf-8"></script>
  <script src="https://qzone.qq.com/gy/404/page.js" charset="utf-8"></script>
</body>
</html>
```

刷新后效果如下：

![hexo-08](https://kangyonggan.com/upload/hexo-08.png)

### 标签
```
root@iZ23ldh8kudZ:~/blog# hexo new page tags
INFO  Created: ~/blog/source/tags/index.md
root@iZ23ldh8kudZ:~/blog# cat source/tags/index.md
---
title: tags
date: 2017-03-28 21:33:05
---
root@iZ23ldh8kudZ:~/blog#
```

经过我的修改后内容为：

```
---
title: 全部标签
date: 2017-03-25 14:13:35
type: tags
comments: false
---
```

刷新后看效果：

![hexo-09](https://kangyonggan.com/upload/hexo-09.png)

刷新后看不到什么效果，因为你还没有“标签”，怎么才能有标签呢？不急，下面会说的。

### 分类
```
root@iZ23ldh8kudZ:~/blog# hexo new page categories
INFO  Created: ~/blog/source/categories/index.md
root@iZ23ldh8kudZ:~/blog# cat source/categories/index.md
---
title: categories
date: 2017-03-28 21:37:42
---
root@iZ23ldh8kudZ:~/blog#
```

经过我的修改后内容为：

```
---
title: 全部分类
date: 2017-03-25 14:15:11
type: categories
comments: false
---
```

刷新后看效果：

![hexo-10](https://kangyonggan.com/upload/hexo-10.png)

刷新后看不到什么效果，原因同上。

## 文章
其他的配置现在不好说，因为没有文章！所以接下来我会先创建一些文章。

### 文章模板
在scaffolds目录下是创建新文章时的模板:

```
root@iZ23ldh8kudZ:~/blog# ll scaffolds/
total 20
drwxr-xr-x 2 root root 4096 Mar 28 17:26 ./
drwxr-xr-x 6 root root 4096 Mar 28 20:24 ../
-rw-r--r-- 1 root root   33 Mar 28 17:26 draft.md
-rw-r--r-- 1 root root   44 Mar 28 17:26 page.md
-rw-r--r-- 1 root root   50 Mar 28 17:26 post.md
```

默认使用的是post.md这个模板，你也可以在站点文件中配置其他模板：

```
default_layout: post
```

不过一般也不需要改，我是直接改的post.md，改后内容如下：

```
---
title: {{ title }}
date: {{ date }}
categories:
tags:
---
```

使用模板创建一篇文章：

```
root@iZ23ldh8kudZ:~/blog# hexo new SSH免密登录
INFO  Created: ~/blog/source/_posts/SSH免密登录.md
root@iZ23ldh8kudZ:~/blog#
```

`hexo new <div class="hidden ajax-append-title">`命令会使用默认模板创建一篇文章，文章在source/_post/文件夹下。

为了观察实际效果，我在这篇文章中添加一些真实的内容

刷新后效果如下：

![hexo-11](https://kangyonggan.com/upload/hexo-11.png)

这时候你再去查看“标签”页和“分类”页，应该就能看见有内容了。

### 分页
为了看出分页效果，我先把hexo例子中的Hello World干掉，另外把我的博客搬进_post中。
修改`站点配置文件`中的`per_page`配置，默认是10，我改为5:

```
per_page: 5
pagination_dir: page
```

效果如下：

![hexo-12](https://kangyonggan.com/upload/hexo-12.png)

## 其他
至此，博客就已经有型了，但是还得经典细琢。

### 分享
当我们看到一篇好文章时想分享给其他人看怎么办？复制url?太low了！

修改`主题配置文件`的`jiathis`:

```
jiathis: true
```

刷新文章详情页面,可以在底部看到分享按钮：

![hexo-13](https://kangyonggan.com/upload/hexo-13.png)

### 社交链接

修改`主题配置文件`的`Social`相关配置:

```
social:
  Github: https://github.com/kangyonggan/
  Book: http://kangyonggan.com:6666/

social_icons:
  enable: true
  # Icon Mappings.
  # KeyMapsToSocialItemKey: NameOfTheIconFromFontAwesome
  GitHub: github
  Twitter: twitter
  Weibo: weibo
  Book: book
```

刷新后效果如下：

![hexo-14](https://kangyonggan.com/upload/hexo-14.png)


发现进入详情界面后，自动弹出右边目录结构（如果文章有目录的时候），设置`主题配置文件`，让进入详情界面的时候不要自动弹目录结构：
修改sidebar:display的值：

```
sidebar:
  # Sidebar Position, available value: left | right
  position: left
  #position: right

  # Sidebar Display, available value:
  #  - post    expand on posts automatically. Default.
  #  - always  expand for all pages automatically
  #  - hide    expand only when click on the sidebar toggle icon.
  #  - remove  Totally remove sidebar including sidebar toggle.
  #display: post
  #display: always
  display: hide
  #display: remove

  # Sidebar offset from top menubar in pixels.
  offset: 12
  offset_float: 0

  # Back to top in sidebar
  b2t: false

  # Scroll percent label in b2t button
  scrollpercent: false

```

### 生成RSS

```
root@iZ23ldh8kudZ:~/blog# npm install hexo-generator-feed --save
```

修改`主题配置文件`的rss配置，如下：

```
rss:

feed:
  type: atom
  path: atom.xml
  limit: 20
  hub:
  content:
```

rss配置没变，feed相关的为新增的, 刷新后就可以在sidebar中看见rss链接了。

![hexo-15](https://kangyonggan.com/upload/hexo-15.png)

可以使用`rss阅读器`订阅这个rss地址的文章。

### 打赏
修改`主题配置文件`中的`alipay`的值(如果没有alipay就新增):

```
alipay: /upload/ipay.png
```

然后把支付宝的收款二维码放到`themes/next/source/upload/`目录下。

文章详情界面的效果如图：

![hexo-16](https://kangyonggan.com/upload/hexo-16.png)

### 代码高亮风格
修改`主题配置文件`的`highlight_theme`的值:

```
highlight_theme: night
```

### 站点地图
```
npm install hexo-generator-sitemap --save
npm install hexo-generator-baidu-sitemap --save
```

修改`站点配置文件`，在最后添加(可以不加，因为有缺省值)：

```
sitemap:
  path: sitemap.xml
baidusitemap:
  path: baidusitemap.xml
```

重启后访问`http://localhost:4000/sitemap.xml`，就可以看到内容了。

![hexo-18](https://kangyonggan.com/upload/hexo-18.png)

但是连接地址是错的，所以我们需要在`站点配置文件`中修改：


```
url: http://kangyonggan.com
root: /
permalink: :year/:month/:day/:title/
permalink_defaults:
```

下面是提交`站点地图`到百度站长工具中的过程, 不搞SEO的可以略过

![hexo-17](https://kangyonggan.com/upload/hexo-17.png)

### 百度统计
在[http://tongji.baidu.com/](http://tongji.baidu.com/)注册账号，并创建应用，然后在“代码获取”界面获取`baidu_analytics`，如下图：

![hexo-19](https://kangyonggan.com/upload/hexo-19.png)

修改`主题配置文件`的`baidu_analytics`的值：

```
baidu_analytics: 9a7a48ed52f9726****8a0955ae72adf
```

为了个人id不被盗用，我隐藏了四位。一段时间之后查看访问量：

![hexo-20](https://kangyonggan.com/upload/hexo-20.png)


### 评论
之前的hexo用户使用`多说`评论插件的比较多，但是现在多说即将关闭，新用户已经不能使用了，所有我使用`畅言`。

注册畅言[http://changyan.kuaizhan.com/](http://changyan.kuaizhan.com/)并创建站点，获取`APP ID`和`APP KEY`。

![hexo-21](https://kangyonggan.com/upload/hexo-21.png)

把这两个的值写入`主题配置文件`:

```
changyan:
  enable: true
  appid: cy****H1C
  appkey: 5bc9ff33a197******b38cc87994bf4f
  count: true
```

效果如下：

![hexo-22](https://kangyonggan.com/upload/hexo-22.png)

我这里的评论框是黑色的，你可以在“畅言”网站上修改评论框的样式。

### 站内搜索
这是个很好用的功能，就是反应有点慢。修改`主题配置文件`的`local_search`的值：

```
local_search:
  enable: true
```

修改这个配置可以在界面上看到“搜索”按钮。但点击无效。

修改`站点配置文件`，在最后新增：

```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
```

安装搜索插件：

```
npm install hexo-generator-search --save
```

重启后搜索效果如下：

![hexo-23](https://kangyonggan.com/upload/hexo-23.png)

## hexo常用命令
### 清除
```
hexo clean
```

### 生成站点
```
hexo gengrate
```

可以简写为`hexo g`

### 本地启动
```
hexo server
```

可以简写为`hexo s`

还可以带参数，比如`hexo s --debug`会在命令窗口打印日志以供调试。

### 发布
```
hexo deploy
```

简写为`hexo d`

需要在`站点配置文件`中配置`deploy`相关参数：

```
deploy:
  type: git
  repo: https://github.com/kangyonggan/kangyonggan.github.io.git
```

此外还需要安装deploy相关插件，并且配置git全局用户相关变量，不然没权限推送到github上。

如果没云空间的可以在deploy到github上托管，但github最近比较慢，所以我是放在云服务器上的。



', 1, 0, '2018-03-25 00:27:10', '2018-03-25 00:27:10');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('把网站从http免费升级到https', '把网站从http升级到https并没有什么实质性的作用，甚至还会遇到某些坑，但是逼格高啊', 'other', '## 申请免费SSL
打开[https://zerossl.com/](https://zerossl.com/), 点击【ONLINE TOOLS】

![https](https://kangyonggan.com/upload/https01.png)

点击【START】开始申请证书

<!-- more -->

![https](https://kangyonggan.com/upload/https02.png)

填写【邮箱】、【域名】、勾选【HTTP verification】、【Accept ZeroSSL TOS】和【Accept Let''s Encrypt SA (pdf)】, 填写完成后点击【NEXT】

![https](https://kangyonggan.com/upload/https03.png)

此时会询问你是否也包含www前缀的域名，建议第一次玩的时候选择No，因为这样后面的校验是相对容易一些，等玩会了之后再选择Yes，我这里选择的是【Yes】。

![https](https://kangyonggan.com/upload/https04.png)

点击【下载】，然后点击【NEXT】。

![https](https://kangyonggan.com/upload/https05.png)

点击【下载】，然后点击【NEXT】。

![https](https://kangyonggan.com/upload/https06.png)

然后进入域名校验界面。

![https](https://kangyonggan.com/upload/https07.png)

这时候你需要在你的项目中放置两个文件，以供校验：
1. 文件路径为：http://kangyonggan.com/.well-known/acme-challenge/WxvjNvXfff_DGNzHeGhi6rDqMVjJQlcatSvO_1SdemE
2. 文件内容为：WxvjNvXfff_DGNzHeGhi6rDqMVjJQlcatSvO_1SdemE.m4z6_KmV_JPWzx3GFVoB9p-ytleQL5vLVuNZItQ2dik

同理，再创建另外一个文件：
1. 文件路径为：http://www.kangyonggan.com/.well-known/acme-challenge/wpyYcbGItz-rmHKNFPrjrSnVy3vQ4cFC3fuRGvYF1l8
2. 文件内容为：wpyYcbGItz-rmHKNFPrjrSnVy3vQ4cFC3fuRGvYF1l8.m4z6_KmV_JPWzx3GFVoB9p-ytleQL5vLVuNZItQ2dik

需要注意的是：这两个文件的地址，一个有www，一个没有www，如果你前面没有包含www前缀的域名，你就只需要提供一个文件只可。

下面是我提供的文件：

![https](https://kangyonggan.com/upload/https08.png)

![https](https://kangyonggan.com/upload/https09.png)

把项目发布之后访问以下上面的两个地址，看看能不能访问通, 如果访问的通，点击【NEXT】

![https](https://kangyonggan.com/upload/https10.png)

如果校验没过，别放弃，多点几次，我就是在点了2次才通过的：

![https](https://kangyonggan.com/upload/https11.png)

在这一步一定一定不能忘了下载这两个文件，因为后面配置服务器的时候回用到这两个文件，最后点击【DONE NEXT】结束。

但是这个证书有效期是90天，90天之后需要再次申请，过程和这次一样。

## 使用Nginx配置SSL
把下载的两个文件重命名为domain.crt和domain.key,然后配置nginx：

```
server {
	server_name kangyonggan.com;
    listen 443;
    ssl on;
    ssl_certificate /root/ssl/domain.crt;
    ssl_certificate_key /root/ssl/domain.key;

	location / {
		proxy_pass http://localhost:8080;
	}

	# 设定访问静态文件直接读取不经过tomcat
	location ^~ /static/ {
			proxy_pass http://localhost:8080;
			root /WEB-INF/static/;
	}
}
```

重新加载nginx的配置：

```
nginx -s reload
```

访问https://kangyonggan.com和https://www.kangyonggan.com

![https](https://kangyonggan.com/upload/https12.png)

![https](https://kangyonggan.com/upload/https13.png)

虽然可以访问https了，但是原本的http仍然可以访问，所以还需要再配置。

## http重定向到https
把原本80端口的server配置：

```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        server_name _;

        location / {
                proxy_pass http://localhost:8080;
        }
}
```

改为：

```
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        server_name _;

        location / {
                # proxy_pass http://localhost:8080;
                return 301 https://kangyonggan.com$request_uri;
        }
}
```

再次访问http的网站，就会被重定向到https了。










', 1, 0, '2018-03-25 00:28:28', '2018-03-25 00:28:28');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用SSH内网穿透加Nginx反向代理之后获取真实IP', '因为某些原因，我的服务器不得不使用nginx做转发，但是转发后我获取不到请求ip了，对nginx进行下面的配置即可', 'other', '![nginx](https://kangyonggan.com/upload/nginx-ssh.png)

## 配置Nginx
```
location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to displaying a 404.
        # try_files $uri $uri/ =404;
        proxy_pass http://localhost:8080;

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
}
```

<!-- more -->

重新加载Nginx配置:

```
nginx -s reload
```

## JAVA获取IP
```
String ip = request.getHeader("X-Real-IP");
```

', 0, 0, '2018-03-25 00:29:57', '2018-03-25 00:29:57');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('修改Linux系统的系统时间', '最近我在一台PC电脑上装了Ubuntu系统，然后把项目跑了起来，一直没去关注系统时间，今天却发现系统时间比“现在”要快12个小时，所以我需要把系统时间改正过来', 'linux', '## 使用date命令
```
sudo date -s "2017-04-20 09:27:07"
```

改了之后再使用date命令查询时间，发现成功了，但是，大概几分钟之后又恢复成之前的错误时间了。

## 使用hwclock命令
```
sudo hwclock --set --date="04/20/17 09:24"
```

还是同样的问题，几分钟后就恢复了。

<!-- more -->

## 改时区

```
sudo cp /usr/share/zoneinfo/Asia/Shanghai ./localtime
```

亲测这个是ok的，即使重启也不会恢复成错的时间。', 0, 0, '2018-03-25 00:30:25', '2018-03-25 00:30:25');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用Log4j2的Rewrite过滤敏感信息', '最近由于种种原因需要把项目的Log4j升级到Log4j2,其中遇到一个问题：   怎么给日志脱敏？', 'server', '## 摸索过程
查看官方文档[https://logging.apache.org/log4j/2.0/manual/appenders.html#RewriteAppender](https://logging.apache.org/log4j/2.0/manual/appenders.html#RewriteAppender)，官方文档中虽然有所介绍，但是没给demo，百度谷歌都很难查到此类文章，所有配置起来有一定难度。

<!-- more -->

### pom.xml的配置
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.kangyonggan.demo</groupId>
    <artifactId>log4j2-rewrite</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <log4j2.api.version>2.8.2</log4j2.api.version>
    </properties>

    <dependencies>
        <!--Log4j2-->
        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-api</artifactId>
            <version>${log4j2.api.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-core</artifactId>
            <version>${log4j2.api.version}</version>
        </dependency>
    </dependencies>

</project>
```

### log4j2.xml的配置
```
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="warn">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
        </Console>

        <Rewrite name="Rewrite">
            <MyRewritePolicy></MyRewritePolicy>
            <AppenderRef ref="Console"></AppenderRef>
        </Rewrite>
    </Appenders>

    <Loggers>
        <Root level="info">
            <AppenderRef ref="Rewrite"></AppenderRef>
        </Root>
    </Loggers>
</Configuration>
```

其中MyRewritePolicy是我自定义的，它实现了RewritePolicy接口，同时需要实现一个方法public LogEvent rewrite(final LogEvent event)

### MyRewritePolicy.java的实现
```
package com.kangyonggan.demo;

import org.apache.logging.log4j.core.LogEvent;
import org.apache.logging.log4j.core.appender.rewrite.RewritePolicy;
import org.apache.logging.log4j.core.impl.Log4jLogEvent;
import org.apache.logging.log4j.message.SimpleMessage;

/**
 * @author kangyonggan
 * @date 2017/4/24 0024
 */
public final class MyRewritePolicy implements RewritePolicy {

    @Override
    public LogEvent rewrite(final LogEvent event) {
        String message = event.getMessage().getFormattedMessage();
        // 处理日志的逻辑
        message = "处理后的日志: " + message;

        SimpleMessage simpleMessage = new SimpleMessage(message);
        LogEvent result = new Log4jLogEvent(event.getLoggerName(), event.getMarker(),
                event.getLoggerFqcn(), event.getLevel(), simpleMessage,
                event.getThrown(), event.getContextMap(), event.getContextStack(),
                event.getThreadName(), event.getSource(), event.getTimeMillis());

        return result;
    }
}

```

### 小测一下
```
package com.kangyonggan.demo;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * @author kangyonggan
 * @date 2017/4/24 0024
 */
public class Test {

    private static Logger logger = LogManager.getLogger(Test.class);

    public static void main(String[] args) {
        logger.info("手机号:{}", "15121149571");
    }

}

```

运行后报错：

```
2017-04-24 23:35:04,827 main ERROR Unable to invoke factory method in class class com.kangyonggan.demo.MyRewritePolicy for element MyRewritePolicy. java.lang.IllegalStateException: No factory method found for class com.kangyonggan.demo.MyRewritePolicy
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.findFactoryMethod(PluginBuilder.java:224)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:130)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at com.kangyonggan.demo.Test.<clinit>(Test.java:12)

[INFO ] 2017-04-24 23:35:04.884 [com.kangyonggan.demo.Test.main:15] - 手机号:15121149571
```

从报错信息中可以看出：没有工厂方法（No factory method found）。
还提到了org.apache.logging.log4j.core.config.plugins这个包下面的插件。
所以去这个包下面看一下相关的插件：

![plugin](https://kangyonggan.com/upload/log4j2-rewrite-01.png)

果然看到了factory相关的plugin，并且PluginFactory是作用在method上的。

### 使用@PluginFactory注解

```
package com.kangyonggan.demo;

import org.apache.logging.log4j.core.LogEvent;
import org.apache.logging.log4j.core.appender.rewrite.RewritePolicy;
import org.apache.logging.log4j.core.config.plugins.PluginFactory;
import org.apache.logging.log4j.core.impl.Log4jLogEvent;
import org.apache.logging.log4j.message.SimpleMessage;

/**
 * @author kangyonggan
 * @date 2017/4/24 0024
 */
public final class MyRewritePolicy implements RewritePolicy {

    public LogEvent rewrite(final LogEvent event) {
        String message = event.getMessage().getFormattedMessage();
        // 处理日志的逻辑
        message = "处理后的日志: " + message;

        SimpleMessage simpleMessage = new SimpleMessage(message);
        LogEvent result = new Log4jLogEvent(event.getLoggerName(), event.getMarker(),
                event.getLoggerFqcn(), event.getLevel(), simpleMessage,
                event.getThrown(), event.getContextMap(), event.getContextStack(),
                event.getThreadName(), event.getSource(), event.getTimeMillis());

        return result;
    }

    @PluginFactory
    public static void factory() {
        System.out.println("factory");
    }
}

```

这次运行后没有报错了，也打印了“factory”，但是rewrite方法没被执行。

仔细一想，这既然是工厂方法，一定是为了创建对象的，所以再次修改如下。

### PluginFactory返回自定义的实例
```
package com.kangyonggan.demo;

import org.apache.logging.log4j.core.LogEvent;
import org.apache.logging.log4j.core.appender.rewrite.RewritePolicy;
import org.apache.logging.log4j.core.config.plugins.PluginFactory;
import org.apache.logging.log4j.core.impl.Log4jLogEvent;
import org.apache.logging.log4j.message.SimpleMessage;

/**
 * @author kangyonggan
 * @date 2017/4/24 0024
 */
public final class MyRewritePolicy implements RewritePolicy {

    public LogEvent rewrite(final LogEvent event) {
        String message = event.getMessage().getFormattedMessage();
        // 处理日志的逻辑
        message = "处理后的日志: " + message;

        SimpleMessage simpleMessage = new SimpleMessage(message);
        LogEvent result = new Log4jLogEvent(event.getLoggerName(), event.getMarker(),
                event.getLoggerFqcn(), event.getLevel(), simpleMessage,
                event.getThrown(), event.getContextMap(), event.getContextStack(),
                event.getThreadName(), event.getSource(), event.getTimeMillis());

        return result;
    }

    @PluginFactory
    public static MyRewritePolicy factory() {
        System.out.println("factory");
        return new MyRewritePolicy();
    }
}
```

在此运行后发现成功了！

### 完整log4j2.xml的配置
```
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN" monitorInterval="300">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
        </Console>
        <RollingRandomAccessFile name="AllFile" fileName="${dfjz.log4j2.home}/all.log"
                                 filePattern="${dfjz.log4j2.home}/all-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="debug" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>
        <RollingRandomAccessFile name="ErrorFile" fileName="${dfjz.log4j2.home}/error.log"
                                 filePattern="${dfjz.log4j2.home}/error-%d{yyyy-MM-dd}-%i.log">
            <PatternLayout pattern="[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%logger{36}.%t:%L] - %msg%n"></PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1"></TimeBasedTriggeringPolicy>
                <SizeBasedTriggeringPolicy size="500 MB"></SizeBasedTriggeringPolicy>
            </Policies>
            <DefaultRolloverStrategy max="30"></DefaultRolloverStrategy>
            <Filters>
                <ThresholdFilter level="fatal" onMatch="DENY" onMismatch="NEUTRAL"></ThresholdFilter>
                <ThresholdFilter level="error" onMatch="ACCEPT" onMismatch="DENY"></ThresholdFilter>
            </Filters>
        </RollingRandomAccessFile>

        <SMTP name="Mail" subject="${dfjz.app.name} - 报警通知" to="${dfjz.mail.receiver}" from="${dfjz.mail.username}"
              smtpHost="${dfjz.mail.host}" smtpUsername="${dfjz.mail.username}" smtpPassword="${dfjz.mail.password}" bufferSize="${dfjz.mail.bufferSize}" >
        </SMTP>
        <Async name="AsyncAll">
            <AppenderRef ref="AllFile"></AppenderRef>
        </Async>
        <Async name="AsyncError">
            <AppenderRef ref="ErrorFile"></AppenderRef>
            <AppenderRef ref="Mail" ></AppenderRef>
        </Async>

        <Rewrite name="Rewrite">
            <MyRewritePolicy></MyRewritePolicy>
            <AppenderRef ref="Console"></AppenderRef>
            <AppenderRef ref="AsyncAll"></AppenderRef>
            <AppenderRef ref="AsyncError"></AppenderRef>
        </Rewrite>
    </Appenders>
    <Loggers>
        <Root level="debug" additivity="true">
            <AppenderRef ref="Rewrite"></AppenderRef>
        </Root>
    </Loggers>
</Configuration>
```

用以上配置就已经可以解决我们项目中的所有需求了，不对，还漏了一个，就是普通日志只打印info级别的，sql需要打印debug级别的。

### 打印debug级别的SQL
请参考我的另一篇文章[使用Log4j2让项目输出info级别的日志和debug级别的sql](https://kangyonggan.com/#article/41)
> 觉得不错就赏点吧，你的支持是我进步的动力！








', 0, 0, '2018-03-25 00:30:58', '2018-03-25 00:30:58');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('JDBC连接MySQL数据库的代码片段', '虽然现在都是使用框架来连接数据库了，但是偶尔还是需要用到一下下面这坨代码的', 'code', '```
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * @author kangyonggan
 * @date 4/25/17
 */
public class ExcelParse605 {

    private static String url = "jdbc:mysql://127.0.0.1:3306/dfjz?useUnicode=true&characterEncoding=UTF-8";
    private static String username = "root";
    private static String password = "123456";

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            ps = conn.prepareStatement("SELECT bnk_resp_co FROM be_resp WHERE bnk_no = ''605''");
            rs = ps.executeQuery();
            while (rs.next()) {
                String bnkRespCo = rs.getString("bnk_resp_co");
                System.out.println(bnkRespCo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
```', 0, 0, '2018-03-25 00:32:07', '2018-03-25 00:32:07');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('配置dubbo多注册中心', '在使用dubbo的时候，一个项目想要同时访问开发环境和测试环境的接口怎么办？那么久可以配置多注册中心了', 'other', '参考dubbo官方文档[http://dubbo.io/User+Guide-zh.htm#UserGuide-zh-%E5%A4%9A%E6%B3%A8%E5%86%8C%E4%B8%AD%E5%BF%83](http://dubbo.io/User+Guide-zh.htm#UserGuide-zh-%E5%A4%9A%E6%B3%A8%E5%86%8C%E4%B8%AD%E5%BF%83)

## consumer.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
       xsi:schemaLocation="http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd
       http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd">

    <context:annotation-config></context:annotation>
    <dubbo:application name="ENGINE_HELPER"></dubbo:application>

    <dubbo:registry id="dev_address" address="zookeeper://10.199.101.211:8080?backup=10.199.101.212:2181,10.199.101.213:2181"></dubbo:registry>
    <dubbo:registry id="uat_address" address="zookeeper://10.199.105.204:2181?backup=10.199.105.203:2181,10.199.105.202:2181" default="false"></dubbo:registry>

    <dubbo:reference id="bankEngineServiceDev" cluster="failfast"
                     interface="com.shhxzq.fin.bankengine.service.BankEngineService"
                     lazy="true" version="1.2.0" check="false" timeout="100000" registry="dev_address"></dubbo:reference>

    <dubbo:reference id="bankEngineServiceUat" cluster="failfast"
                     interface="com.shhxzq.fin.bankengine.service.BankEngineService"
                     lazy="true" version="1.2.0" check="false" timeout="100000" registry="uat_address"></dubbo:reference>

</beans>
```



', 0, 0, '2018-03-25 00:33:59', '2018-03-25 00:33:59');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用Spring配置多数据源', '今天在做一个小功能的时候，遇到了这样一个问题，根据交易流水号查询dev环境的交易记录或uat环境的交易记录。那么久需要配置多数据源了，所以就捣鼓了一下，记录一下', 'server', '
## 两个dataSources
```
    <!-- 配置dbcp数据源 - dev -->
    <bean id="dataSourceDev" class="com.alibaba.druid.pool.DruidDataSource"
          destroy-method="close">
        <property name="driverClassName" value="${ehelper.jdbc.driver}"></property>
        <property name="url" value="${ehelper.jdbc.url.dev}"></property>
        <property name="username" value="${ehelper.jdbc.username.dev}"></property>
        <property name="password" value="${ehelper.jdbc.password.dev}"></property>

        <!-- 配置初始化大小、最小、最大 -->
        <property name="initialSize" value="5"></property>
        <property name="minIdle" value="5"></property>
        <property name="maxActive" value="100"></property>

        <!-- 配置获取连接等待超时的时间 -->
        <property name="maxWait" value="60000" ></property>

        <!-- 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 -->
        <property name="timeBetweenEvictionRunsMillis" value="60000" ></property>

        <!-- 配置一个连接在池中最小生存的时间，单位是毫秒 -->
        <property name="minEvictableIdleTimeMillis" value="300000" ></property>

        <property name="validationQuery" value="SELECT ''x''" ></property>
        <property name="testWhileIdle" value="true" ></property>
        <property name="testOnBorrow" value="false" ></property>
        <property name="testOnReturn" value="false" ></property>

        <!-- 打开PSCache，并且指定每个连接上PSCache的大小 -->
        <property name="poolPreparedStatements" value="true" ></property>
        <property name="maxPoolPreparedStatementPerConnectionSize" value="20" ></property>

        <!-- 关闭长时间不使用的连接 -->
        <property name="removeAbandoned" value="true" ></property> <!-- 打开removeAbandoned功能 -->
        <property name="removeAbandonedTimeout" value="1200" ></property> <!-- 1200秒，也就是20分钟 -->
        <property name="logAbandoned" value="true" ></property> <!-- 关闭abanded连接时输出错误日志 -->
    </bean>

    <!-- 配置dbcp数据源 - uat -->
    <bean id="dataSourceUat" class="com.alibaba.druid.pool.DruidDataSource"
          destroy-method="close">
        <property name="driverClassName" value="${ehelper.jdbc.driver}"></property>
        <property name="url" value="${ehelper.jdbc.url.uat}"></property>
        <property name="username" value="${ehelper.jdbc.username.uat}"></property>
        <property name="password" value="${ehelper.jdbc.password.uat}"></property>

        <!-- 配置初始化大小、最小、最大 -->
        <property name="initialSize" value="5"></property>
        <property name="minIdle" value="5"></property>
        <property name="maxActive" value="100"></property>

        <!-- 配置获取连接等待超时的时间 -->
        <property name="maxWait" value="60000" ></property>

        <!-- 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒 -->
        <property name="timeBetweenEvictionRunsMillis" value="60000" ></property>

        <!-- 配置一个连接在池中最小生存的时间，单位是毫秒 -->
        <property name="minEvictableIdleTimeMillis" value="300000" ></property>

        <property name="validationQuery" value="SELECT ''x''" ></property>
        <property name="testWhileIdle" value="true" ></property>
        <property name="testOnBorrow" value="false" ></property>
        <property name="testOnReturn" value="false" ></property>

        <!-- 打开PSCache，并且指定每个连接上PSCache的大小 -->
        <property name="poolPreparedStatements" value="true" ></property>
        <property name="maxPoolPreparedStatementPerConnectionSize" value="20" ></property>

        <!-- 关闭长时间不使用的连接 -->
        <property name="removeAbandoned" value="true" ></property> <!-- 打开removeAbandoned功能 -->
        <property name="removeAbandonedTimeout" value="1200" ></property> <!-- 1200秒，也就是20分钟 -->
        <property name="logAbandoned" value="true" ></property> <!-- 关闭abanded连接时输出错误日志 -->
    </bean>
```

## MultiDataSource
需要自己实现数据源路由， 继承AbstractRoutingDataSource，覆写determineCurrentLookupKey方法即可。

```
package com.shhxzq.fin.ehelper.biz.util;

import com.shhxzq.fin.ehelper.model.constants.DataSource;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * 多数据源
 *
 * @author kangyonggan
 * @date 4/28/17
 */
public class MultiDataSource extends AbstractRoutingDataSource {

    private static final ThreadLocal<String> dataSourceKey = new InheritableThreadLocal();

    public static void setDataSource(DataSource dataSource) {
        dataSourceKey.set(dataSource.name());
    }

    @Override
    protected Object determineCurrentLookupKey() {
        return dataSourceKey.get();
    }
}
```

其中DataSource是个枚举：

```
package com.shhxzq.fin.ehelper.model.constants;

/**
 * @author kangyonggan
 * @date 4/28/17
 */
public enum DataSource {
    DEV, UAT;

    public static DataSource getDataSource(String name) {
        for (DataSource dataSource : DataSource.values()) {
            if (dataSource.name().equalsIgnoreCase(name)) {
                return dataSource;
            }
        }

        return DataSource.DEV;
    }
}

```

## sqlSessionFactory
```
<!-- 创建SqlSessionFactory，同时指定数据源 -->
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <property name="dataSource" ref="multiDataSource"></property>
    <property name="configLocation" value="classpath:mybatis.xml"></property>
    <property name="mapperLocations" value="classpath:mapper/*.xml"></property>
    <property name="typeAliasesPackage" value="com.shhxzq.fin.ehelper.model.vo"></property>
    <property name="plugins">
        <array>
            <bean class="com.github.pagehelper.PageHelper">
                <property name="properties">
                    <value>
                        dialect=mysql
                    </value>
                </property>
            </bean>
        </array>
    </property>
</bean>
```

## sqlSession
```
<!-- 配置SQLSession模板 -->
<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate" scope="prototype">
    <constructor-arg index="0" ref="sqlSessionFactory"></constructor>
</bean>
```

## transactionManager
```
<!-- 使用JDBC事务 -->
<bean id="transactionManager"
      class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
    <property name="dataSource" ref="multiDataSource"></property>
</bean>
```

## transactionAdvice
```
<!-- AOP配置事物 -->
<tx:advice id="transactionAdvice" transaction-manager="transactionManager">
    <tx:attributes>
        <tx:method name="delete*" propagation="REQUIRED"></tx:method>
        <tx:method name="update*" propagation="REQUIRED"></tx:method>
        <tx:method name="save*" propagation="REQUIRED"></tx:method>
        <tx:method name="remove*" propagation="REQUIRED"></tx:method>
        <tx:method name="send*" propagation="REQUIRED"></tx:method>

        <tx:method name="search*" read-only="true" propagation="REQUIRED"></tx:method>
        <tx:method name="find*" read-only="true" propagation="REQUIRED"></tx:method>
        <tx:method name="get*" read-only="true" propagation="REQUIRED"></tx:method>
        <tx:method name="*" read-only="true" propagation="REQUIRED"></tx:method>
    </tx:attributes>
</tx:advice>
```

## transactionPointcut
```
<!-- 配置AOP切面 -->
<aop:config>
    <!--切点，用于事务-->
    <aop:pointcut id="transactionPointcut"
                  expression="execution(* com.shhxzq.fin.ehelper.biz.service.impl.transaction..*.*(..))"></aop:pointcut>

    <!--事物切面-->
    <aop:advisor pointcut-ref="transactionPointcut" advice-ref="transactionAdvice"></aop:advisor>
</aop:config>
```

## 方案一
原本我是想在spring初始化bean的时候就指定数据源，这样的话事务就不会和数据源打架，我想到的方案是，给不同的包指定不同的数据源，但是这样会带来一个问题，就是会冗余代码。

比如dev环境和uat环境的service分别放在dev和uat包下，再分别给dev包河uat包指定dev的数据源和uat的数据源。

引发的问题：dev和uat业务逻辑一样，仅数据源不一样，但是却有两份代码！冗余还是小事，以后维护才是大事，所以此方案果断排除。

## 方案二
在调用方法的时候传入一个参数，指定调用哪个数据源，这样代码就没冗余的地方了，但是会带来一个问题。

就是需要修改老代码，在参数中增加一个参数，然后在方法中指定数据源，在方法中指定数据源可以使用注解和切面完成，但不可避面的还是要增加一个参数。

如果不增加一个参数，而是在注解中加参数呢？我也这么想过，但是这样的话，这个方法就只能使用固定的数据源了，达不到动态的效果。

进一步分析，如果在注解中加参数，另外再多写一个方法指定为另一个数据源呢？显然是不可取的，方法冗余，维护困难，如果再次增加数据源还得再加一个方法。

所以，最后我还是选择了使用【传参+注解】的方案，没办法，要想动态切换数据源，你总的告诉方法你要用哪个数据源吧，怎么告诉他？传参是最好途径了，并且扩展性强。下面是我具体实现代码。

## DataSourceSwitch
```
package com.shhxzq.fin.ehelper.model.annotation;

import java.lang.annotation.*;

/**
 * 在方法上加此注解，会使用第一个参数即DataSource枚举切换数据源
 *
 * @author kangyonggan
 * @date 2016/12/8
 */
@Documented
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DataSourceSwitch {

}
```

## DataSourceAop
```
package com.shhxzq.fin.ehelper.biz.aop;

import com.shhxzq.fin.ehelper.biz.util.MultiDataSource;
import com.shhxzq.fin.ehelper.model.annotation.DataSourceSwitch;
import com.shhxzq.fin.ehelper.model.constants.DataSource;
import lombok.extern.log4j.Log4j2;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * @author kangyonggan
 * @date 4/28/17
 */
@Log4j2
@Component
@Aspect
public class DataSourceAop {

    @Pointcut("execution(* com.shhxzq.fin.ehelper.biz.service.impl..*.*(..))")
    public void pointcut() {
    }

    /**
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("pointcut()")
    public Object around(ProceedingJoinPoint joinPoint) throws Throwable {
        Object args[] = joinPoint.getArgs();
        Class clazz = joinPoint.getTarget().getClass();

        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Method method = clazz.getMethod(methodSignature.getName(), methodSignature.getParameterTypes());

        DataSourceSwitch dataSourceSwitch = method.getAnnotation(DataSourceSwitch.class);
        if (dataSourceSwitch != null) {
            log.info("使用指定的数据源.");
            if (args.length > 0) {
                Object obj = args[0];
                if (obj instanceof DataSource) {
                    DataSource dataSource = (DataSource) obj;
                    MultiDataSource.setDataSource(dataSource);
                    log.info("数据源：{}", dataSource.name());
                } else {
                    log.info("第一个参数不是DataSource枚举，所以仍然使用默认数据源.");
                }
            } else {
                log.info("第一个参数不是DataSource枚举，所以仍然使用默认数据源.");
            }
        } else {
            log.info("使用默认数据源.");
        }


        return joinPoint.proceed(args);
    }
}
```

## BeCommandServiceImpl
```
package com.shhxzq.fin.ehelper.biz.service.impl;

import com.shhxzq.fin.ehelper.biz.service.BeCommandService;
import com.shhxzq.fin.ehelper.model.annotation.DataSourceSwitch;
import com.shhxzq.fin.ehelper.model.annotation.LogTime;
import com.shhxzq.fin.ehelper.model.constants.DataSource;
import com.shhxzq.fin.ehelper.model.vo.BeCommand;
import org.springframework.stereotype.Service;

/**
 * @author kangyonggan
 * @date 4/28/17
 */
@Service
public class BeCommandServiceImpl extends BaseService<BeCommand> implements BeCommandService {

    @Override
    @LogTime
    @DataSourceSwitch
    public BeCommand findBeCommandBySerialNo(DataSource dataSource, String serialNo) {
        BeCommand beCommand = new BeCommand();
        beCommand.setSerialNo(serialNo);

        return super.selectOne(beCommand);
    }
}
```

## 问题
另外我还遇到了一个问题，那就是事务和多数据源打架了，我的解决方案是把它们两个分开。但也不是太好，先这样吧，以后再研究。



', 0, 0, '2018-03-25 00:34:30', '2018-03-25 00:34:30');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用jdbc向MySQL中插入时间丢失毫秒', '最近遇到一个问题，项目中使用Mybatis向MySQL中插入一条记录，结果发现时间的毫秒会丢失，MySQL版本5.6及以上，建表语句如下', 'other', '```
create table la_trans_monitor
(
	begin_time timestamp(3) default CURRENT_TIMESTAMP(3) not null
)
```

其他和本题无关字段已省略。

<!-- more -->

生成的Model：

```
package com.kangyonggan.app.dfjz.model.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import lombok.Data;

@Table(name = "la_trans_monitor")
@Data
public class LaTransMonitor implements Serializable {

    @Column(name = "begin_time")
    private Date beginTime;

    private static final long serialVersionUID = 1L;
}
```

## 问题分析
从debug日志中可以看出参数是有毫秒的，但是数据库中就是没有落入毫秒

```
[DEBUG] 2017-06-16 10:59:11.039 [com.kangyonggan.app.dfjz.mapper.LaTransMonitorMapper.insertSelective.main:145] - ==>  Preparing: INSERT INTO la_trans_monitor ( sys_date,sys_time,method_type,method_route,method_name,begin_time,end_time,used_time ) VALUES ( ?,?,?,?,?,?,?,? )
[DEBUG] 2017-06-16 10:59:11.065 [com.kangyonggan.app.dfjz.mapper.LaTransMonitorMapper.insertSelective.main:145] - ==> Parameters: 20170615(String), 112233(String), XX(String), XX(String), XXX(String), 2017-06-16 10:59:10.342(Timestamp), 2017-06-16 10:59:10.342(Timestamp), 12345(Long)
[DEBUG] 2017-06-16 10:59:11.188 [com.kangyonggan.app.dfjz.mapper.LaTransMonitorMapper.insertSelective.main:145] - <==    Updates: 1
```

解决这个问题的过程中有想到：
1. 会不会是MySQL版本问题？
2. 会不会是Mybatis版本问题？
3. 会不会是建表脚本问题？
4. 会不会是配置问题？

通过控制变量法，经过一一验证，都没发现问题。

我曾经手写过简版Mybatis，所以清楚以下几点：
1. 日志不等于它实际执行的SQL，所以看到日志中有毫秒是没多大意义的。
2. PreparedStatement有两个主要步骤，一个是准备带有占位符的SQL，另一个就是给占位符填数据。

所以我猜测PreparedStatement在填数据的时候，对java.util.date的处理过程中丢掉了毫秒，接下来就是debug跟踪源代码，最后发现PreparedStatement填数据的类是在mysql-connector-java这个jar包下的。
源代码如下：

```
private void setTimestampInternal(int parameterIndex, Timestamp x, Calendar targetCalendar, TimeZone tz, boolean rollForward) throws SQLException {
    if(x == null) {
        this.setNull(parameterIndex, 93);
    } else {
        this.checkClosed();
        if(!this.useLegacyDatetimeCode) {
            this.newSetTimestampInternal(parameterIndex, x, targetCalendar);
        } else {
            String timestampString = null;
            Calendar sessionCalendar = this.connection.getUseJDBCCompliantTimezoneShift()?this.connection.getUtcCalendar():this.getCalendarInstanceForSessionOrNew();
            synchronized(sessionCalendar) {
                x = TimeUtil.changeTimezone(this.connection, sessionCalendar, targetCalendar, x, tz, this.connection.getServerTimezoneTZ(), rollForward);
            }

            if(this.connection.getUseSSPSCompatibleTimezoneShift()) {
                this.doSSPSCompatibleTimezoneShift(parameterIndex, x, sessionCalendar);
            } else {
                synchronized(this) {
                    if(this.tsdf == null) {
                        this.tsdf = new SimpleDateFormat("\\''\\''yyyy-MM-dd HH:mm:ss", Locale.US);
                    }

                    timestampString = this.tsdf.format(x);
                    StringBuffer buf = new StringBuffer();
                    buf.append(timestampString);
                    buf.append(''.'');
                    buf.append(this.formatNanos(x.getNanos()));
                    buf.append(''\\'''');
                    this.setInternal(parameterIndex, buf.toString());
                }
            }
        }

        this.parameterTypes[parameterIndex - 1 + this.getParameterIndexOffset()] = 93;
    }

}
```

从上面代码中可以看出，它在处理时间的时候，使用SimpleDateFormat进行格式化的，格式化中没保留毫秒，紧接着后面又去拼接纳秒formatNanos，但是继续跟踪此方法后发现它返回的是0，因此最后PreparedStatement填的值形如"yyyy-MM-dd HH:MM:ss.0"。

问题已经定位到，所以就想着能不能升级jar包版本解决问题呢？

去[中央仓库](https://mvnrepository.com/)搜一把, 发现我现在的版本5.1.9实在是太古老了，用的人也不多，于是换了新版的用的人较多的5.1.34, 果然成功解决问题。新版jar包核心代码如下：

```
private void setTimestampInternal(int parameterIndex, Timestamp x, Calendar targetCalendar, TimeZone tz, boolean rollForward) throws SQLException {
    synchronized(this.checkClosed().getConnectionMutex()) {
        if(x == null) {
            this.setNull(parameterIndex, 93);
        } else {
            this.checkClosed();
            if(!this.useLegacyDatetimeCode) {
                this.newSetTimestampInternal(parameterIndex, x, targetCalendar);
            } else {
                Calendar sessionCalendar = this.connection.getUseJDBCCompliantTimezoneShift()?this.connection.getUtcCalendar():this.getCalendarInstanceForSessionOrNew();
                synchronized(sessionCalendar) {
                    x = TimeUtil.changeTimezone(this.connection, sessionCalendar, targetCalendar, x, tz, this.connection.getServerTimezoneTZ(), rollForward);
                }

                if(this.connection.getUseSSPSCompatibleTimezoneShift()) {
                    this.doSSPSCompatibleTimezoneShift(parameterIndex, x, sessionCalendar);
                } else {
                    synchronized(this) {
                        if(this.tsdf == null) {
                            this.tsdf = new SimpleDateFormat("\\''\\''yyyy-MM-dd HH:mm:ss", Locale.US);
                        }

                        StringBuffer buf = new StringBuffer();
                        buf.append(this.tsdf.format(x));
                        if(this.serverSupportsFracSecs) {
                            int nanos = x.getNanos();
                            if(nanos != 0) {
                                buf.append(''.'');
                                buf.append(TimeUtil.formatNanos(nanos, this.serverSupportsFracSecs, true));
                            }
                        }

                        buf.append(''\\'''');
                        this.setInternal(parameterIndex, buf.toString());
                    }
                }
            }

            this.parameterTypes[parameterIndex - 1 + this.getParameterIndexOffset()] = 93;
        }

    }
}
```









', 0, 0, '2018-03-25 00:35:58', '2018-03-25 00:35:58');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用jaudiotagger解析mp3文件', '最近在做音乐播放器，所以需要解析mp3文件，我使用的是一个第三方jar包来解析的，但是没能解析出tag信息', 'server', '#### 依赖
```
<jaudiotagger.version>2.0.3</jaudiotagger.version>

...

<dependency>
    <groupId>org</groupId>
    <artifactId>jaudiotagger</artifactId>
    <version>${jaudiotagger.version}</version>
</dependency>
```

<!-- more -->

#### Mp3Util.java
```
package com.kangyonggan.app.future.common.util;

import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;
import org.jaudiotagger.tag.id3.AbstractID3v2Frame;
import org.jaudiotagger.tag.id3.AbstractID3v2Tag;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * mp3工具类
 *
 * @author kangyonggan
 * @date 9/4/17
 */
@Log4j2
public class Mp3Util {

    public static void main(String[] args) throws Exception {
        Map<String, Object> resultMap = parse("/Users/kyg/Music/网易云音乐/demo.mp3", "/Users/kyg/Desktop");
        log.info(resultMap);
    }

    /**
     * 解析mp3
     *
     * @param mp3Path  mp3路径
     * @param albumDir 解析出的专辑图片存放目录
     * @return
     */
    public static Map<String, Object> parse(String mp3Path, String albumDir) {
        Map<String, Object> resultMap = new HashMap();

        FileOutputStream out = null;
        try {
            MP3File mp3File = new MP3File(mp3Path);
            MP3AudioHeader header = mp3File.getMP3AudioHeader();
            AbstractID3v2Tag id3v2Tag = mp3File.getID3v2Tag();

            // 时长(秒)
            int duration = header.getTrackLength();
            // 文件大小
            long size = mp3File.getFile().length();
            // 歌曲名
            String name = getInfo(id3v2Tag, "TIT2");
            // 歌手
            String singer = getInfo(id3v2Tag, "TPE1");
            // 专辑
            String album = getInfo(id3v2Tag, "TALB");
            // 专辑图片
            AbstractID3v2Frame frame = (AbstractID3v2Frame) id3v2Tag.frameMap.get("APIC");
            String mimeTpe = (String) frame.getBody().getObjectValue("MIMEType");
            byte data[] = (byte[]) frame.getBody().getObjectValue("PictureData");

            // 根据MIMEType获取对应的后缀，如：image/jpeg -> .jpg
            String extension = FileUtil.getExtension(mimeTpe);
            if (StringUtils.isEmpty(extension)) {
                extension = ".jpg";
            }
            // 把专辑图片写入指定文件夹
            out = new FileOutputStream(albumDir + File.separator + album + extension);
            out.write(data);
            out.flush();

            // 写响应
            resultMap.put("duration", duration);
            resultMap.put("size", size);
            resultMap.put("name", name);
            resultMap.put("singer", singer);
            resultMap.put("album", album);
            resultMap.put("mimeTpe", mimeTpe);
            resultMap.put("albumName", album + extension);

            resultMap.put("respCo", 0);
            resultMap.put("respMsg", "解析mp3成功");
        } catch (Exception e) {
            log.warn("解析mp3信息异常", e);
            resultMap.put("respCo", -1);
            resultMap.put("respMsg", e.getLocalizedMessage());
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    log.warn("关闭流异常", e);
                }
            }
        }

        return resultMap;
    }

    /**
     * 获取歌曲信息
     *
     * @param id3v2Tag
     * @param identifier
     * @return
     */
    private static String getInfo(AbstractID3v2Tag id3v2Tag, String identifier) {
        AbstractID3v2Frame frame = (AbstractID3v2Frame) id3v2Tag.frameMap.get(identifier);
        return (String) frame.getBody().getObjectValue("Text");
    }

}
```

其中依赖了apache下的一个jar包，用于获取MIMEType对应的文件后缀名

```
<tika.version>1.16</tika.version>

...

<dependency>
    <groupId>org.apache.tika</groupId>
    <artifactId>tika-core</artifactId>
    <version>${tika.version}</version>
</dependency>
```

#### FileUtil.java
```
/**
 * 根据MIMEType获取后缀
 *
 * @param mimeType
 * @return
 * @throws Exception
 */
public static String getExtension(String mimeType) throws Exception {
    MimeTypes allTypes = MimeTypes.getDefaultMimeTypes();
    MimeType type = allTypes.forName(mimeType);
    return type.getExtension();
}
```', 0, 0, '2018-03-25 00:36:38', '2018-03-25 00:36:38');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('回到顶部功能的实现', '回到顶部是网站中最常见的一个小功能了，下面是我的实现方式', 'web', '#### html代码
```
<a href="javascript:scrollTo(0, 0)" class="scroll-top">
	<img src="${ctx}/static/app/images/top.png" width="40" height="40"/>
</a>
```

#### css样式
```
.scroll-top {
    position: fixed;
    bottom: 10px;
    right: 10px;
    z-index: 99999;
    display: none;
}
```

<!-- more -->

#### js控制
```
$(function () {
    $(window).scroll(function () {
        if ($(window).scrollTop() >= 300) { //向下滚动像素大于这个值时，即出现浮窗~
            $(''.scroll-top'').fadeIn(1000);
        } else {
            $(''.scroll-top'').fadeOut(1000);
        }
    });
});
```', 0, 0, '2018-03-25 00:37:28', '2018-03-25 00:37:28');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('IntelliJ IDEA自动生成setter方法丢失is', '无意中发现了一些不为人知的一些东西，下面我就来分享一下', 'other', '### 实体类
有一个实体类Demo，他有一个boolean类型的属性isUpdate。

### idea
如果使用idea自动生成setter方法如下：

```
public void setUpdate(boolean update) {
    isUpdate = update;
}
```

### 前端请求
```
$.post("xxxxx/update", {
    isUpdate: true
}, function(data,status){
    alert("数据: \\n" + data + "\\n状态: " + status);
});
```

<!-- more -->

### spring注入
我们在前端请求后台controller时，controller方法的参数是实体类Demo，如下：

```
@RequestMapping(value = "update", method = RequestMethod.POST)
public String update(Demo demo) {
    // ...
    System.out.println("isUpdate is " + demo.getIsUpdate());
    return null;
}
```

### 输出
```
isUpdate is false
```

说明spring在注入时找不到isUpdate对应的setter方法。


### eclipse
如果使用eclipse自动生成setter方法如下：

```
public void setIsUpdate(boolean isUpdate) {
    this.isUpdate = isUpdate;
}
```

换成eclipse之后，生成的setter就是好的了, 如果使用lombok插件自动生成setter也是好的

> 说明：只有属性是boolean或者Boolean时，并且以is开头的字段，使用idea自动生成setter时才会丢失is。


', 0, 0, '2018-03-25 00:38:27', '2018-03-25 00:38:27');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('CSS3实现加载中的动画效果', '这是不依赖于js，而是使用css3的动画来实现的加载中...', 'web', '### 实现原理
主要使用transform的rotate属性，将线条组合成Loading图形 (也就是菊花图形)。

animation实现将线条颜色由浅到深，再由深到浅来回变换的动画，通过animation-delay属性来使颜色的变换产生过渡的效果，从而达到类似于Loading动画的效果。

### html代码
```
<div class="loading">
    <span class="line1"></span>
    <span class="line2"></span>
    <span class="line3"></span>
    <span class="line4"></span>
    <span class="line5"></span>
    <span class="line6"></span>
    <span class="line7"></span>
    <span class="line8"></span>
</div>
```

<!-- more -->

### css代码
```
.loading {
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    width: 80px;
    height: 80px;
    margin: auto;
    z-index: 9999;
}

.loading span {
    width: 4px;
    height: 20px;
    background-color: #ccc;
    position: absolute;
    left: 38px;
    -webkit-animation: loading 1s infinite;
}

.loading .line1 {
    background-color: #000;
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
    -webkit-animation-delay: .3s;
}

.loading .line2 {
    top: 5px;
    left: 52px;
    -webkit-transform: rotate(45deg);
    transform: rotate(45deg);
    -webkit-animation-delay: .4s;
}

.loading .line3 {
    top: 18px;
    left: 57px;
    -webkit-transform: rotate(90deg);
    transform: rotate(90deg);
    -webkit-animation-delay: .5s;
}

.loading .line4 {
    top: 31px;
    left: 52px;
    -webkit-transform: rotate(135deg);
    transform: rotate(135deg);
    -webkit-animation-delay: .6s;
}

.loading .line5 {
    top: 37px;
    -webkit-animation-delay: .7s;
}

.loading .line6 {
    top: 32px;
    left: 24px;
    -webkit-transform: rotate(-135deg);
    transform: rotate(-135deg);
    -webkit-animation-delay: .8s;
}

.loading .line7 {
    top: 18px;
    left: 19px;
    -webkit-transform: rotate(-90deg);
    transform: rotate(-90deg);
    -webkit-animation-delay: .9s;
}

.loading .line8 {
    top: 5px;
    left: 24px;
    -webkit-transform: rotate(-45deg);
    transform: rotate(-45deg);
    -webkit-animation-delay: 1s;
}

@-webkit-keyframes loading {
    0% {
        background-color: #ccc;
    }
    50% {
        background-color: #000;
    }
    100% {
        background-color: #ccc;
    }
}
```

### 效果图

![loading-demo.gif](https://kangyonggan.com/upload/loading-demo.gif)', 0, 0, '2018-03-25 00:39:29', '2018-03-25 00:39:29');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('让百度分享支持https的网站', '我的网站中使用的是百度分享，但是它不支持https的网站，二我的网站正好是https的，下面就是解决方案', 'other', '### 百度分享
百度分享地址：[http://share.baidu.com](http://share.baidu.com)
由于我的网站的https的，而百度分享代码中是http的，所以不能按照百度分享提供的代码直接使用。
我的做法是将百度分享所使用的js、css、image全部下载下来，放在我自己的服务器。

### 下载
[baidu-share.zip](https://kangyonggan.com/upload/baidu-share.zip)

### 使用方法
下面的代码是使用百度分享自动生成的，首先是把zip文件解压到服务器根目录下，然后需要把域名改为自己域名的就ok了。
比如我是将“http://bdimg.share.baidu.com/static/api/js/share.js”改为“${ctx}/static/api/js/share.js”

<!-- more -->

```
<script> window._bd_share_config = {
    "common": {
        "bdSnsKey": {},
        "bdText": "",
        "bdMini": "2",
        "bdMiniList": false,
        "bdPic": "",
        "bdStyle": "0",
        "bdSize": "16"
    }, "slide": {"type": "slide", "bdImg": "1", "bdPos": "right", "bdTop": "100"}
};
with (document)0[(getElementsByTagName(''head'')[0] || body).appendChild(createElement(''script'')).src = ''http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='' + ~(-new Date() / 36e5)];</script>
</script>
```

### 效果图
![效果图](https://kangyonggan.com/upload/https-share.png)


', 0, 0, '2018-03-25 00:40:29', '2018-03-25 00:40:29');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('一键生成通用增删改查从前端到后台的所有代码', '我发现在做类似cms内容管理系统的时候，其实很多都是对于表的维护。   说白了就是一些增删改查，因此我开发了一个模块，可以一键生成增删改查所有代码', 'other', '### 使用方法
```
# 拉取项目到本地
git clone https://github.com/kangyonggan/codegen.git
# 编译并安装
mvn clean install
# 一键生成项目
mvn archetype:generate -DarchetypeGroupId=com.kangyonggan.archetype -DarchetypeArtifactId=codegen -DarchetypeVersion=1.0-SNAPSHOT -DarchetypeCatalog=local
```

', 0, 0, '2018-03-25 00:41:06', '2018-03-25 00:41:06');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('利用编译时注解增强方法', '我之前打印方法的出参、入参以及耗时，都是在方法上加上运行时注解，然后通过aop切面去实现。觉得有些地方可以再优化一下', 'server', '### 想法
1. 在任何一个方法上加上注解，都要能打印出参、入参信息，而不局限于spring管理的类方法。
2. 不要每次调用方法都要经过各种反射，而是编译时就把增强代码注入到方法第一行。这样性能更好。
3. 可以自定义使用什么日志框架输出日志。

### 实验环境
- 开发工具：idea或eclipse
- 项目管理工具：maven3.3.9
- jdk版本：1.8.0_144

<!-- more -->

### 实现

#### 创建maven项目
使用idea创建一个普通的maven项目hello。并创建两个子模块hello-core和hello-test。整体项目结构如下图：

![method-logger](https://kangyonggan.com/upload/method-logger.png)

#### 父模块pom.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.kangyonggan.demo</groupId>
    <artifactId>hello</artifactId>
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>

    <modules>
        <module>hello-core</module>
        <module>hello-test</module>
    </modules>

    <properties>
        <!--Project-->
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.build.version>1.0-SNAPSHOT</project.build.version>

        <!--Plugins-->
        <plugin.compiler.version>3.5.1</plugin.compiler.version>
        <plugin.compiler.level>1.8</plugin.compiler.level>
    </properties>

    <build>
        <pluginManagement>
            <plugins>
                <!--compiler plugin -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>${plugin.compiler.version}</version>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
</project>
```

### hello-core模块pom.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>hello</artifactId>
        <groupId>com.kangyonggan.demo</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>hello-core</artifactId>

    <build>
        <plugins>
            <!--compiler plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>${plugin.compiler.level}</source>
                    <target>${plugin.compiler.level}</target>
                    <encoding>${project.build.sourceEncoding}</encoding>
                    <compilerArgument>-proc:none</compilerArgument>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <dependencies>
        <dependency>
            <groupId>sun.jdk</groupId>
            <artifactId>tools</artifactId>
            <version>1.5.0</version>
            <scope>system</scope>
            <systemPath>${java.home}/../lib/tools.jar</systemPath>
        </dependency>
    </dependencies>
</project>
```

> 注意：编译插件一定要配置：`<compilerArgument>-proc:none</compilerArgument>`, 否则编译时报错：

```
Bad service configuration file, or exception thrown while constructing Processor object: javax.annotation.processing.Processor: Provider com.kangyonggan.demo.hello.core.MethodLoggerProcessor not found
```

> 注意：一定要依赖`tools.jar`，否则编译时报错：

```
com.sun.tools.javac.processing does not exist
```

### 编译时注解
`MethodLogger.java`

```
package com.kangyonggan.demo.hello.core;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author kangyonggan
 * @date 9/28/17
 */
@Retention(RetentionPolicy.SOURCE)
@Target(ElementType.METHOD)
public @interface MethodLogger {

}
```

### 注解处理器
`MethodLoggerProcessor.java`

```
package com.kangyonggan.demo.hello.core;

import com.sun.source.util.Trees;
import com.sun.tools.javac.processing.JavacProcessingEnvironment;
import com.sun.tools.javac.tree.JCTree;
import com.sun.tools.javac.tree.TreeMaker;
import com.sun.tools.javac.tree.TreeTranslator;
import com.sun.tools.javac.util.*;

import javax.annotation.processing.*;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.Element;
import javax.lang.model.element.ElementKind;
import javax.lang.model.element.TypeElement;
import java.util.Set;


/**
 * 注解处理器
 *
 * @author kangyonggan
 * @date 9/28/17
 */
@SupportedAnnotationTypes("com.kangyonggan.demo.hello.core.MethodLogger")
@SupportedSourceVersion(SourceVersion.RELEASE_8)
public class MethodLoggerProcessor extends AbstractProcessor {

    private Trees trees;
    private TreeMaker treeMaker;
    private Name.Table names;

    /**
     * 初始化，获取编译环境
     *
     * @param env
     */
    @Override
    public synchronized void init(ProcessingEnvironment env) {
        super.init(env);

        trees = Trees.instance(env);
        Context context = ((JavacProcessingEnvironment) env).getContext();
        treeMaker = TreeMaker.instance(context);
        names = Names.instance(context).table;
    }

    /**
     * 处理注解
     *
     * @param annotations
     * @param env
     * @return
     */
    @Override
    public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment env) {
        // 处理有@MethodLogger注解的元素
        for (Element element : env.getElementsAnnotatedWith(MethodLogger.class)) {
            // 只处理作用在方法上的注解
            if (element.getKind() == ElementKind.METHOD) {
                JCTree tree = (JCTree) trees.getTree(element);
                tree.accept(new TreeTranslator() {
                    /**
                     * 方法的代码块，在代码块的第一行添加代码：System.out.println("Hello World!!!");
                     *
                     * @param tree
                     */
                    @Override
                    public void visitBlock(JCTree.JCBlock tree) {
                        ListBuffer<JCTree.JCStatement> statements = new ListBuffer();

                        // 创建代码: System.out.println("Hello World!!!");
                        JCTree.JCFieldAccess fieldAccess = treeMaker.Select(treeMaker.Select(treeMaker.Ident(names.fromString("System")), names.fromString("out")), names.fromString("println"));
                        JCTree.JCExpression argsExpr = treeMaker.Literal("Hello world!!!");
                        JCTree.JCMethodInvocation methodInvocation = treeMaker.Apply(List.nil(), fieldAccess, List.of(argsExpr));
                        JCTree.JCExpressionStatement code = treeMaker.Exec(methodInvocation);

                        // 把代码加到方法体之前
                        statements.append(code);

                        // 把原来的方法体写回去
                        for (int i = 0; i < tree.getStatements().size(); i++) {
                            statements.append(tree.getStatements().get(i));
                        }

                        result = treeMaker.Block(0, statements.toList());
                    }
                });

            }
        }
        return true;
    }

}
```

### 注册注解处理器
在`resources/META-INF/services`目录下创建文件`javax.annotation.processing.Processor`， 文件内容如下：

```
com.kangyonggan.demo.hello.core.MethodLoggerProcessor
```

### hello-test模块pom.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>hello</artifactId>
        <groupId>com.kangyonggan.demo</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>hello-test</artifactId>

    <build>
        <plugins>
            <!--compiler plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>${plugin.compiler.level}</source>
                    <target>${plugin.compiler.level}</target>
                    <encoding>${project.build.sourceEncoding}</encoding>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <dependencies>
        <dependency>
            <groupId>com.kangyonggan.demo</groupId>
            <artifactId>hello-core</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
    </dependencies>
</project>
```

### 测试
`MethodLoggerTest.java`

```
package com.kangyonggan.demo.hello.test;

import com.kangyonggan.demo.hello.core.MethodLogger;

/**
 * @author kangyonggan
 * @date 10/17/17
 */
public class MethodLoggerTest {

    @MethodLogger
    public void test() {
        System.out.println("test");
    }

    public static void main(String[] args) {
        new MethodLoggerTest().test();
    }

}
```

运行main方法输出如下：

```
Hello world!!!
test
```

### 反编译MethodLoggerTest.class
```
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.kangyonggan.demo.hello.test;

public class MethodLoggerTest {
    public MethodLoggerTest() {
    }

    public void test() {
        System.out.println("Hello world!!!");
        System.out.println("test");
    }

    public static void main(String[] args) {
        (new MethodLoggerTest()).test();
    }
}
```

### 源代码
Hello World的源代码托管在github上：[https://github.com/kangyonggan/method-logger-hello.git](https://github.com/kangyonggan/method-logger-hello.git)

最终实现的代码：[https://github.com/kangyonggan/method-logger.git](https://github.com/kangyonggan/method-logger.git)

此jar包已经发布到中央仓库，联网即可依赖。

### 使用方法
#### 添加依赖
```
<dependency>
    <groupId>com.kangyonggan</groupId>
    <artifactId>method-logger</artifactId>
    <version>1.6</version>
</dependency>
```

#### 使用注解
```
package com.kangyonggan.app.future.web;

import com.kangyonggan.methodlogger.MethodLogger;

/**
 * @author kangyonggan
 * @date 10/18/17
 */
public class Hello {

    @MethodLogger
    public static int add(int a, int b) {
        return a + b;
    }

    public static void main(String[] args) {
        add(1, 2);
    }

}
```

输出：

```
[INFO ] 2017-10-18 09:20:42.025 [com.kangyonggan.app.future.web.Hello] - <add> method args：[1,2]
[INFO ] 2017-10-18 09:20:42.026 [com.kangyonggan.app.future.web.Hello] - <add> method return：3
[INFO ] 2017-10-18 09:20:42.026 [com.kangyonggan.app.future.web.Hello] - <add> method used time：0ms
```







', 1, 0, '2018-03-25 00:41:56', '2018-03-25 00:41:56');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('在mac上发布jar包到中央仓库', '通常我们都是依赖别人的jar包，感觉别人的jar包无所不能，有时候自己也有好的想法，也想打成jar包给别人使用，下面是我在mac系统上发布jar包到中央仓库的记录', 'other', '### 注册sonatype账号
地址：[https://issues.sonatype.org/secure/Signup!default.jspa](https://issues.sonatype.org/secure/Signup!default.jspa)

> * 记住用户名和密码，后面会频繁使用。

### 创建一个issue
地址：[https://issues.sonatype.org/secure/Dashboard.jspa](https://issues.sonatype.org/secure/Dashboard.jspa)
使用上面注册的用户名和密码登录。

<!-- more -->

![sona](https://kangyonggan.com/upload/sona-01.png)

> * 不要修改`Project`和`Issue Type`，使用默认值即可。

![sona](https://kangyonggan.com/upload/sona-02.png)

> * 其他的值请参考例子。

创建完成后，1个工作日以内工作人员会回复你的Issue，如果通过的话，内容如下，如果不通过，那你就检查后再试试吧。

![sona](https://kangyonggan.com/upload/sona-03.png)

### 使用 GPG 生成密钥对
如果mac上没有gpg命令，可以使用下面的命令进行安装:

```
brew install gpg
```

如果mac上没有brew命令，需要先安装brew命令：

```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

> * 安brew命令需要先打开Xcode并同意条款。

安装成功gpg命令后，生成密钥：

```
gpg --gen-key
```

输出信息：

```
gpg (GnuPG) 2.2.1; Copyright (C) 2017 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

gpg: directory ''/Users/kyg/.gnupg'' created
gpg: keybox ''/Users/kyg/.gnupg/pubring.kbx'' created
Note: Use "gpg --full-generate-key" for a full featured key generation dialog.

GnuPG needs to construct a user ID to identify your key.

Real name:
```

提示输入名字， 如：`kangyonggan`

```
Email address:
```

又提示输入邮箱, 如：`java@kangyonggan.com`

```
You selected this USER-ID:
    "kangyonggan <java@kangyonggan.com>"

Change (N)ame, (E)mail, or (O)kay/(Q)uit?
```

选择okay, 输入：`o`

然后弹框要求输入密码， 这个密码后面会用到，别忘记了。

![sona](https://kangyonggan.com/upload/sona-06.png)

之后会让你再次输入密码，到此密钥就生成成功了，输出信息如下：

```
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: /Users/kyg/.gnupg/trustdb.gpg: trustdb created
gpg: key C38B01CFC194AE3C marked as ultimately trusted
gpg: directory ''/Users/kyg/.gnupg/openpgp-revocs.d'' created
gpg: revocation certificate stored as ''/Users/kyg/.gnupg/openpgp-revocs.d/7A98F7517B453D562425F564C38B01CFC194AE3C.rev''
public and secret key created and signed.

pub   rsa2048 2017-10-18 [SC] [expires: 2019-10-18]
      7A98F7517B453D562425F564C38B01CFC194AE3C
uid                      kangyonggan <java@kangyonggan.com>
sub   rsa2048 2017-10-18 [E] [expires: 2019-10-18]
```

需要记住`7A98F7517B453D562425F564C38B01CFC194AE3C`，会面会有用，记不住也没关系，可以使用下面的命令查看。

```
gpg --list-keys
```

输出：

```
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2019-10-18
/Users/kyg/.gnupg/pubring.kbx
-----------------------------
pub   rsa2048 2017-10-18 [SC] [expires: 2019-10-18]
      7A98F7517B453D562425F564C38B01CFC194AE3C
uid           [ultimate] kangyonggan <java@kangyonggan.com>
sub   rsa2048 2017-10-18 [E] [expires: 2019-10-18]
```

### 将公钥发布到 PGP 密钥服务器
```
gpg --keyserver hkp://keyserver.ubuntu.com:11371 --send-keys 7A98F7517B453D562425F564C38B01CFC194AE3C
```

输出信息如下：

```
gpg: sending key C38B01CFC194AE3C to hkp://keyserver.ubuntu.com:11371
You have new mail in /var/mail/kyg
```

说明密钥已经发布成功了，也可以使用命令查看有没有发布成功。

```
gpg --keyserver hkp://keyserver.ubuntu.com:11371 --recv-keys 7A98F7517B453D562425F564C38B01CFC194AE3C
```

输出：

```
gpg: key C38B01CFC194AE3C: "kangyonggan <java@kangyonggan.com>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
```

### 配置setting.xml
```
<servers>
    <server>
        <id>oss</id>
        <username>sonatype用户名</username>
        <password>sonatype密码</password>
    </server>
</servers>

...

<profiles>
    <profile>
        <id>ossrh</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>

        <properties>
            <gpg.executable>gpg2</gpg.executable>
            <gpg.passphrase>密钥的密码</gpg.passphrase>
        </properties>
    </profile>
</profiles>
```

server的id随意填写，只要和pom.xml里面对应就行了。

### 配置pom.xml
```
<name>Method Logger</name>
<description>使用编译时注解打印方法入参出参和耗时</description>

<url>http://www.dexcoder.com/</url>
<licenses>
    <license>
        <name>The Apache Software License, Version 2.0</name>
        <url>http://www.apache.org/licenses/LICENSE-2.0.txt</url>
    </license>
</licenses>
<developers>
    <developer>
        <name>kangyonggan</name>
        <email>java@kangyonggan.com</email>
    </developer>
</developers>
<scm>
    <connection>scm:git:git@github.com/kangyonggan/method-logger.git</connection>
    <developerConnection>scm:git:git@github.com/kangyonggan/method-logger.git</developerConnection>
    <url>git@github.com/kangyonggan/method-logger.git</url>
</scm>

<profiles>
    <profile>
        <id>release</id>
        <build>
            <plugins>
                <!-- Source -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-source-plugin</artifactId>
                    <version>2.2.1</version>
                    <executions>
                        <execution>
                            <phase>package</phase>
                            <goals>
                                <goal>jar-no-fork</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                <!-- Javadoc -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-javadoc-plugin</artifactId>
                    <version>2.9.1</version>
                    <executions>
                        <execution>
                            <phase>package</phase>
                            <goals>
                                <goal>jar</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                <!-- GPG -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-gpg-plugin</artifactId>
                    <version>1.5</version>
                    <executions>
                        <execution>
                            <phase>verify</phase>
                            <goals>
                                <goal>sign</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
        </build>
        <distributionManagement>
            <snapshotRepository>
                <id>oss</id>
                <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
            </snapshotRepository>
            <repository>
                <id>oss</id>
                <url>https://oss.sonatype.org/service/local/staging/deploy/maven2/</url>
            </repository>
        </distributionManagement>
    </profile>
</profiles>
```

如果你的英文很六，description标签最好用英文来写，逼格更高。其他值你看着填写就好。

> repository->id 要和 setting.xml 中的保持一致。

### 上传构件到 OSS 中
```
mvn clean deploy -P release
```

当执行以上 Maven 命令后，如果顺利，就会看见一堆upload信息，部分输出如下：

```
[DEBUG] Using transporter WagonTransporter with priority -1.0 for https://oss.sonatype.org/service/local/staging/deploy/maven2/
[DEBUG] Using connector BasicRepositoryConnector with priority 0.0 for https://oss.sonatype.org/service/local/staging/deploy/maven2/ with username=java@kangyonggan.com, password=***
Uploading: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/1.0/method-logger-1.0.jar
Uploaded: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/1.0/method-logger-1.0.jar (14 KB at 3.6 KB/sec)
Uploading: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/1.0/method-logger-1.0.pom
Uploaded: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/1.0/method-logger-1.0.pom (6 KB at 1.2 KB/sec)
Downloading: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/maven-metadata.xml
[DEBUG] Could not find metadata com.kangyonggan:method-logger/maven-metadata.xml in oss (https://oss.sonatype.org/service/local/staging/deploy/maven2/)
[DEBUG] Writing tracking file /Users/kyg/data/repository/com/kangyonggan/method-logger/resolver-status.properties
Uploading: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/maven-metadata.xml
Uploaded: https://oss.sonatype.org/service/local/staging/deploy/maven2/com/kangyonggan/method-logger/maven-metadata.xml (304 B at 0.2 KB/sec)
```

> * 注意：此时上传的构件并未正式发布到中央仓库中，只是部署到 OSS 中了，下面才是真正的发布

### 发布构建
地址：[https://oss.sonatype.org/#stagingRepositories](https://oss.sonatype.org/#stagingRepositories)
需要使用之前注册的sonatype账号登录。

点击`Staging Repositories`菜单，并拉至最下方，会看见自己刚刚deploy的jar包

![sona](https://kangyonggan.com/upload/sona-07.png)

选择此构建后，点击`Close`，如下图：

![sona](https://kangyonggan.com/upload/sona-08.png)

系统会自动验证该构件是否满足指定要求，当验证完毕后，状态会变为 Closed。然后点击`Release`。

### 通知 Sonatype 构件已成功发布
找到之前创建的Issue，并回复：`构建已发布`

![sona](https://kangyonggan.com/upload/sona-04.png)

### 等待构件审批通过
等待大概一个工作日内，如果审核通过，Issue会有回复：

![sona](https://kangyonggan.com/upload/sona-05.png)

> * 大概需要2个小时才能把jar同步到中央仓库。

### 从中央仓库搜索自己发布的jar
地址：[http://mvnrepository.com/](http://mvnrepository.com/)
搜索,如：`com.kangyonggan`, 结果如下：

![sona](https://kangyonggan.com/upload/sona-09.png)

据我实际测试发现，大概release之后不超过20分钟，就可以在[https://repo.maven.apache.org/maven2/](https://repo.maven.apache.org/maven2/)这里查看到了，只要这里有了，别人就可以依赖这个jar了。

> * 二次发布同一个构建（只要groupId不变）的过程就不用这么麻烦，后面就不用再Issue中操作了。


', 1, 0, '2018-03-25 00:42:25', '2018-03-25 00:42:25');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('Java Compile Expression Language', '这是一个小项目，用于解析编译时的源代码，有点类似el表达式的感觉，不过这是基于编译时的', 'server', '## Quick Start

### Dependency

```
<dependency>
    <groupId>com.kangyonggan</groupId>
    <artifactId>jcel</artifactId>
    <version>1.0</version>
</dependency>
```

### Code
```
// treeMaker and names is JCTree''s environment
JCExpressionParser parser = new JCExpressionParser(treeMaker, names);
JCTree.JCExpression expression = parser.parse(
    "Hello ${user.info.name}, welcome use my ${project[0](1).name}, thanks!");
System.out.println(expression);
```

Output:

```
"Hello " + user.getInfo().getName() + ", welcome use my " + project[0].get(1).getName();
```
', 0, 0, '2018-03-25 00:43:40', '2018-03-25 00:43:40');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('使用netstat查看端口占用情况', 'netstat 命令用于显示各种网络相关信息，如网络连接，路由表，接口状态 (Interface Statistics)，masquerade 连接，多播成员 (Multicast Memberships) 等等', 'linux', '
## 参数
参数   |     全拼    |       说明
----- | ------------ | -------------
-a   | –all  | 显示所有连线中的Socket
-c   | –continuous  | 持续列出网络状态
-C   | –cache  | 显示路由器配置的快取信息
-e   | –extend  | 显示网络其他相关信息
-F   | –fib  | 显示FIB
-g   | –groups  | 显示多重广播功能群组组员名单
-i   | –interfaces  | 显示网络界面信息表单
-l   | –listening  | 显示监控中的服务器的Socket
-M   | –masquerade  | 显示伪装的网络连线
-n   | –numeric  | 直接使用IP地址，而不通过域名服务器
-N   | ––netlink或–symbolic  | 显示网络硬件外围设备的符号连接名称
-o   | –timers  |  显示计时器
-p   | –programs  | 显示正在使用Socket的程序识别码和程序名称
-r   | –route  | 显示Routing Table
-s   | –statistice  | 显示网络工作信息统计表
-t   | –tcp  | 显示TCP传输协议的连线状况
-u   | –udp  | 显示UDP传输协议的连线状况
-v   | –verbose  | 显示指令执行过程
-V   | –version  | 显示版本信息
-w   | –raw  | 显示RAW传输协议的连线状况
-x   | –unix  | 此参数的效果和指定”-A unix”参数相同
-ip   | –inet  | 此参数的效果和指定”-A inet”参数相同

## 实例
### 查看端口占用情况
```
sudo netstat -tunlp | grep 6379
```

输出：

```
tcp        0      0 0.0.0.0:6379            0.0.0.0:*               LISTEN      1962/redis-server *
tcp6       0      0 :::6379                 :::*                    LISTEN      1962/redis-server *
```', 0, 0, '2018-03-25 00:44:06', '2018-03-25 00:44:06');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('在jboss上配置jndi', 'SN这边使用的是jboss服务器，还使用的jndi，所以就需要在jboss上配置jbdi了，下面是具体配置过程', 'other', '## 准备工作
以配置MySQL的jndi为例。
1. jdk环境
2. jboss安装包
3. MySQL驱动包

## 修改配置
${JBOSS_HOME}/standalone/configuration/`standalone.xml`

<!-- more -->

```
<datasources>
    <datasource jndi-name="java:jboss/datasources/DemoDS" pool-name="DemoDS" enabled="true" use-java-context="true">
        <connection-url>jdbc:mysql://127.0.0.1:3306/demodb</connection-url>
        <driver>mysql</driver>
        <security>
            <user-name>root</user-name>
            <password>123456</password>
        </security>
    </datasource>
    <drivers>
        <driver name="mysql" module="com.kangyonggan.mysql">
            <xa-datasource-class>com.mysql.jdbc.Driver</xa-datasource-class>
        </driver>
    </drivers>
</datasources>
```

## 添加驱动
在${JBOSS_HOME}/modules/com/kangyonggan/mysql/main/目录下添加mysql驱动包，如：`mysql-connector-java-5.1.38.jar`, 这个jar包可以从本地maven仓库中找到，也可以从中央仓库下载。



在此目录下添加驱动包的配置文件：`module.xml`， 内容如下：

```
<?xml version="1.0" encoding="UTF-8"?>

<module xmlns="urn:jboss:module:1.1" name="com.kangyonggan.mysql">

    <resources>
        <resource-root path="mysql-connector-java-5.1.38.jar"></resource>
    </resources>
    <dependencies>
        <module name="javax.api"></module>
        <module name="javax.transaction.api"></module>
        <module name="javax.servlet.api" optional="true"></module>
    </dependencies>
</module>
```



', 0, 0, '2018-03-25 00:45:19', '2018-03-25 00:45:19');
INSERT INTO blog.tb_article (title, summary, category_code, content, is_top, is_deleted, created_time, updated_time) VALUES ('持续集成工具TeamCity的安装和使用', '之前使用的持续集成工具是jenkins，现在发现一枚类似的产品，关键是她和idea是同一个公司开发的，那么是不是可以无缝集成到idea中呢？', 'other', '## 概述
TeamCity是一款功能强大的持续集成（Continue Integration）工具。

和IntelliJ IDEA同属于JetBrains公司，因此，TeamCity可以和IDEA无缝集成，通俗一点说，就是可以在IDEA上一键发布。

官方地址：[https://www.jetbrains.com/teamcity/](https://www.jetbrains.com/teamcity/)
官方文档：[https://confluence.jetbrains.com/display/TCD9/TeamCity+Documentation](https://confluence.jetbrains.com/display/TCD9/TeamCity+Documentation)

<!-- more -->

## 准备工作
1、windows 或 Mac 或 Linux
2、配置`JAVA_HOME`环境变量
3、下载安装包[https://www.jetbrains.com/teamcity/download/](https://www.jetbrains.com/teamcity/download/)

## 安装说明
以mac系统为例, 我下载的安装包为`TeamCity-2017.2.1.tar.gz`。

### 解压到指定目录
```
tar -zxvf /Users/kyg/Downloads/TeamCity-2017.2.1.tar.gz -C /Users/kyg/install/
```

### 启动和停止
启动

```
sh /Users/kyg/install/TeamCity/bin/runAll.sh start
```

停止

```
sh /Users/kyg/install/TeamCity/bin/runAll.sh stop
```

## 访问
[http://127.0.0.1:8111](http://127.0.0.1:8111)

TeamCity内置了一个tomcat容器，默认端口为8111，可以在
`/Users/kyg/install/TeamCity/conf/server.xml`修改端口。

```
<Connector port="8111" ...
```

首次访问，会让你选择存放配置的目录， 如下图：

![](https://kangyonggan.com/upload/tc-01.png)

默认即可，点击`Proceed`， 接下来是选择数据库，如下图：

![](https://kangyonggan.com/upload/tc-02.png)

这里我选择的是mysql，选择mysql后，需要把mysql的驱动包(可以从本地maven仓库中找到)拷贝到
`/Users/kyg/.BuildServer/lib/jdbc`目录下，然后点击`Refresh JDBC Drivers`, 如果jar包没问题，会出现下面的界面：

![](https://kangyonggan.com/upload/tc-03.png)

最后填写jdbc连接的相关信息后点击`Proceed`，需要先自己创建一个数据库`teamcity`
下一步就是接受条款，不多说。

然后就是让我们创建一个管理员, 如下图：

![](https://kangyonggan.com/upload/tc-04.png)

创建完成后会直接登录，并让我们补全个人信息，如下图：

![](https://kangyonggan.com/upload/tc-05.png)

到此，TeamCity就算安装完毕了，接下来就是配置一个项目，用于持续集成。

## 创建项目
![](https://kangyonggan.com/upload/tc-06.png)

此处我使用的是github上的项目。
![](https://kangyonggan.com/upload/tc-07.png)

![](https://kangyonggan.com/upload/tc-08.png)

如果是maven项目，它会自动识别出，并推荐你使用它的构建步骤，这里选不选都行，因为回头可以修改，基本上必须修改。
![](https://kangyonggan.com/upload/tc-09.png)

![](https://kangyonggan.com/upload/tc-10.png)

勾选后，跳转到构建步骤界面，这里你可以自由配置自己的构建步骤，比如
第一步：更新代码并打包
第二步：把war包拷贝到服务器
第三步：执行几个shell命令，停止服务+替换war包+启动服务

下面是我的配置，可供参考：
![](https://kangyonggan.com/upload/tc-11.png)

以及三个步骤的具体配置：
![](https://kangyonggan.com/upload/tc-12.png)

![](https://kangyonggan.com/upload/tc-13.png)

![](https://kangyonggan.com/upload/tc-14.png)

接下来就可以尝试启动了，点击右上角的`run`， 如果运气好，就会发布成功。

这个过程会很慢甚至会失败，因为你没有配置maven的`settings.xml`
它可能找不到你的仓库，如果你用的全部都是中央仓库的jar那就没问题

为了保证一个服务器只有一个本地仓库，最好指定一下settings.xml
如下图：
![](https://kangyonggan.com/upload/tc-15.png)

到此，算是搞定了，但是它还有另外一种操作，那就是集成在IDEA中。

## 集成到IDEA
在idea中搜索插件`teamcity`，安装后重启。
![](https://kangyonggan.com/upload/tc-16.png)

重启后，会发现下面3点变化，右下角的那个图标表示暂未登录到TeamView。
![](https://kangyonggan.com/upload/tc-17.png)

点击右下角的图标登录TeamView：
![](https://kangyonggan.com/upload/tc-18.png)

登录成功后，即可在IDEA中一键发布项目了。
![](https://kangyonggan.com/upload/tc-19.png)

这样的话，一个IDEA就可以开发代码，运行项目，控制版本，操作数据库，一键发布，强大的不要不要的。
', 0, 0, '2018-03-25 00:46:38', '2018-03-25 00:46:38');

INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 1, 'upload/ARTICLE20180324ac8bcd400d99c4fbc7d0f93f7b031fa65e82994f.war', 'dubbo-admin.war', 0, '2018-03-24 23:00:58', '2018-03-24 23:00:58');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 2, 'upload/ARTICLE20180324d487c7ffaf5ac4b454095a1949e278ad7a2b036b.gz', 'dubbo-monitor-simple-2.5.3-assembly.tar.gz', 0, '2018-03-24 23:01:58', '2018-03-24 23:01:58');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 5, 'upload/ARTICLE2018032477e23840b483e00440e899bd846e97df69a24c72.war', 'jenkins.war', 0, '2018-03-24 23:07:06', '2018-03-24 23:07:06');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 6, 'upload/ARTICLE201803243deadce38048a78788bf8cf5098c9b371811a00d.gz', 'apache-maven-3.3.9-bin.tar.gz', 0, '2018-03-24 23:08:36', '2018-03-24 23:08:36');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 8, 'upload/ARTICLE20180324d4462ef9f9afcf74d11de81017a7d8e39075ed6e.gz', 'nexus-3.1.0-04-unix.tar.gz', 0, '2018-03-24 23:12:42', '2018-03-24 23:12:42');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 9, 'upload/ARTICLE201803240feee7bc54442f768701a3598fdc0f820ef2e76e.gz', 'apache-tomcat-8.5.6.tar.gz', 0, '2018-03-24 23:13:56', '2018-03-24 23:13:56');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 10, 'upload/ARTICLE20180324d62a7f7e421edcf0b418d8d9c49c9933c05a0faa.gz', 'zookeeper-3.4.9.tar.gz', 0, '2018-03-24 23:15:53', '2018-03-24 23:15:53');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 14, 'upload/ARTICLE20180324291fad7c757427b2c924133de52908d69e222d75.gz', 'redis-3.2.0.tar.gz', 0, '2018-03-24 23:22:27', '2018-03-24 23:22:27');
INSERT INTO blog.tb_attachment (type, source_id, url, original_filename, is_deleted, created_time, updated_time) VALUES ('ARTICLE', 24, 'upload/ARTICLE2018032416299104d798932d8764251cacf5ab91ef47e4db.zip', 'ace.zip', 0, '2018-03-24 23:38:16', '2018-03-24 23:38:16');

