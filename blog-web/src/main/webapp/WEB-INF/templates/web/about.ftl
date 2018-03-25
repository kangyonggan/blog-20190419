<#assign title="关于我"/>
<#assign active_about="active"/>

<@override name="breadcrumbs">
<a href="${ctx}/">首页</a>
&gt;
<a href="javascript:" class="active">${title}</a>
</@override>

<@override name="main">
<div id="main">
    <div class="space-20"></div>
    <div>
        <div class="me-img">
            <img src="${ctx}/static/app/images/me.jpg"/>
        </div>
        <div class="me-desc">
            <div>
                <div><span>姓名：</span>康永敢</div>
                <div><span>性别：</span>男</div>
            </div>
            <div>
                <div><span>年龄：</span>27</div>
                <div><span>籍贯：</span>安徽</div>
            </div>
            <div>
                <div><span>爱好：</span>看小说</div>
                <div><span>现住址：</span>上海市嘉定区江桥镇</div>
            </div>
            <div>
                <div><span>QQ号：</span>2825176081</div>
                <div><span>手机号：</span>18521311137</div>
            </div>
            <div>
                <div><span>微信号：</span>18521311137</div>
                <div><span>电子邮箱：</span>java@kangyonggan.com</div>
            </div>
        </div>
    </div>
    <div class="space-20"></div>
    <div class="about">
        <p>
            康永敢，男，全日制本科毕业生，家在安徽省蚌埠市怀远县，现在在上海漂泊，职业是java程序猿，主要从事互联网金融行业。爱好：走路吃饭时看小说，有空就敲敲代码做些小玩意，比如iOS版的小说APP，比如博客网站等。
        </p>
        <p>
            励志做一个全栈攻城狮，奈何学海无涯啊。目前手上主要会：Java、MySQL、Maven、Git、Idea、Html、Css、jQuery、Freemarker、Markdown、Spring、SpringMVC、Mybatis、Redis、Dubbo、RabbitMQ、Jenkins、Nginx等。
        </p>
        <div style="clear: both; height: 1px;"></div>
        <p>
            只是一个人敲代码太孤单，侯逼逼那娃又去了合肥，连个交流技术和想法的人都没有了。有太多想法，只是时间真的不够用，不说了，写完关于我，我还得做其他模块，博客重构完了我还要去做一个大事，那就是结合编译时、maven和idea插件，让model从此消失吧。
        </p>
        <div class="space-20"></div>
    </div>
</div>
</@override>


<@extends name="layout.ftl"/>