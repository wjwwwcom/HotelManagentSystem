<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://shiro.apache.org/tags"  prefix="shiro"%>
    <!DOCTYPE html>
    <html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <meta name="renderer" content="webkit">
        <title>酒店管理中心</title>
        <link rel="stylesheet" href="/static/css/pintuer.css">
        <link rel="stylesheet" href="/static/css/admin.css">
        <script src="/static/js/jquery.js"></script>
    </head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
    <div class="logo margin-big-left fadein-top">
        <h1><img src="/static/images/y.jpg" class="radius-circle rotate-hover" height="50" alt="" />酒店服务中心</h1>
    </div>
    <div class="head-l"><a class="button button-little bg-green" href="" target="_blank"><span class="icon-home"></span> 前台首页</a> &nbsp;&nbsp;
        <a href="##" class="button button-little bg-blue"><span class="icon-wrench"></span> 清除缓存</a> &nbsp;&nbsp;
        <a class="button button-little bg-red" href="/tc/logout"><span class="icon-power-off"></span> 退出登录</a> </div>
</div>

<div class="leftnav">
    <div class="leftnav-title"><strong><span class="icon-list"></span>操作</strong></div>
    <shiro:hasRole name="customer">
    <div id="leftnav1">
    <h2><span class="icon-user"></span>客户操作</h2>
    <ul style="display:block">
        <li><a href="/tc/roomSelectPage.do" target="right"><span class="icon-caret-right"></span>客房查询</a></li>

        <li><a href="orderPage.html" target="right"><span class="icon-caret-right"></span>我的订单</a></li>
        <li><a href="customerPersonalPage.html" target="right"><span class="icon-caret-right"></span>个人信息</a></li>

    </ul>
    </div>
    </shiro:hasRole>
    <shiro:hasRole name="hotel">
    <div id="leftnav2">
    <h2><span class="icon-pencil-square-o"></span>工作人员</h2>
    <ul>
        <li><a href="roomManagerPage.html" target="right"><span class="icon-caret-right"></span>客房管理</a></li>
        <li><a href="enterPage.html" target="right"><span class="icon-caret-right"></span>入住</a></li>
        <li><a href="checkOutPage.html" target="right"><span class="icon-caret-right"></span>退房</a></li>
    </ul>
    </div>
    </shiro:hasRole>
</div>
<div class="admin">
    <iframe scrolling="auto" rameborder="0" src="info.html" name="right" width="100%" height="100%"></iframe>
</div>
</body>
</html>
<script type="text/javascript">
    $(function(){
        $("#leftnav1 h2").click(function(){
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        })
        $("#leftnav1 ul li a").click(function(){
            $("#a_leader_txt").text($(this).text());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");
        })
    });

    $(function(){
        $("#leftnav2 h2").click(function(){
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        })
        $("#leftnav2 ul li a").click(function(){
            $("#a_leader_txt").text($(this).text());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");
        })
    });
</script>

