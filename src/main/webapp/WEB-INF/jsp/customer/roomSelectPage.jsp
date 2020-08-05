<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/pintuer.css">
    <link rel="stylesheet" href="/static/css/admin.css">
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <script src="/static/js/bootstrap.js"></script>
    <script src="/static/js/pintuer.js"></script>
</head>

<body>
<div class="panel-head"><strong class="icon-reorder">挑房间</strong></div>
<div class="padding border-bottom">
    <ul class="search ">
        <li>
            <select id="factor" style="padding: 12px 15px; border: 1px solid rgb(221, 221, 221); border-image: none;">
                <option value="">请选择查询条件：</option>
                <option value="hAmount">房间类型</option>
                <option value="hPrice">价格</option>
            </select>
            <input id="keywords" class="input" style="width: 250px;
                    line-height: 17px; display: inline-block;" type="text" value="${keywords}" placeholder="请输入搜索关键字">
            <a class="button border-main icon-search" onclick="factorQuery()" href="javascript:void(0)"> 搜索</a>
        </li>
    </ul>
</div>
<table class="table table-striped table-condensed table-hover">
    <thead>
    <th>房号</th>
    <th>房间样图</th>
    <th>类型</th>
    <th>价格</th>
    <th>状态</th>
    <th>操作</th>
    </thead>
    <tbody>
    <c:forEach items="${data.list}" var="x">
        <tr>
            <td >${x.hName}</td>
            <td ><c:if test="${x.hAmount ==1}">
                <img src="/static/images/1.jpg" width="120" height="80">
            </c:if>
                <c:if test="${x.hAmount ==2}">
                    <img src="/static/images/2.jpg" width="120" height="80">
                </c:if></td>
            <td ><c:if test="${x.hAmount ==1}">
                <b>大床房</b>
            </c:if>
                <c:if test="${x.hAmount ==2}">
                    <b>双床房</b>
                </c:if></td>
            <td>${x.hPrice}</td>
            <td><c:if test="${x.hState ==1}">
                <b>空闲中</b>
            </c:if>
                <c:if test="${x.hState ==2}">
                    <b>已预订</b>
                </c:if>
                <c:if test="${x.hState ==3}">
                    <b>已入住</b>
                </c:if>
            </td>
            <td>
                <button type="button" class="btn btn-success btn-sm" onclick="roomdetails(${x.hName},${x.hAmount},${x.hPrice},${x.floorId},${x.hState},${x.hInfo})">详情</button>
                <button type="button" class="btn btn-primary btn-sm " onclick="roomReserve()">预定</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="text-center">
    <a href="javascript:void(0)" onclick="Indexpage(0)" class="btn btn-info btn-sm">首页</a>
    <a href="javascript:void(0)" onclick="prePage(0)" class="btn btn-info btn-sm">上一页</a>
    <a href="javascript:void(0)" onclick="prePage(1)" class="btn btn-info btn-sm">下一页</a>
    <a href="javascript:void(0)" onclick="Indexpage(1)" class="btn btn-info btn-sm">尾页</a>
    <b>第${data.pageNum}页</b>
    <b>总页数：共${data.allPage}页</b>
    <b>总记录数：共${data.count}条记录</b>
</div>
<%--模态框--%>
<div class="modal fade" id="one" style="top:200px">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--头部-->
            <div class="modal-header" style="background-color: green; height: 20px;">
            </div>
            <div class="modal-body">

                <table class="table" border="0">
                    <tr>
                        <td>房间号：<span id="hName"></span></td>
                    </tr>
                    <tr>
                        <td>房间类型：<span id="hAmount"></span></td>
                    </tr>
                    <tr>
                        <td>单价：<span id="hPrice"></span></td>
                    </tr>
                    <tr>
                        <td>楼层：<span id="floorId" ></span></td>
                    </tr>
                    <tr>
                        <td>状态：<span id="hState"></span></td>
                    </tr>
                    <tr>
                        <td>房内设施：<span id="hInfo"></span></td>
                    </tr>

                    <tr>
                        <td><span style="color:red" id="info"></span></td>
                        <td colspan="2">
                            <button type="button" class="btn btn-success btn-sm" onclick="save()">OK</button>
                            <button type="button" class="btn btn-warning btn-sm" onclick="down()">取消</button>
                        </td>

                    </tr>
                </table>
                <input type="hidden" id="roleId">
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    //居中
    $("td,th").addClass("text-center");
    //选中下拉框
    $("#factor option[value='${factor}']").attr("selected", "selected");

    //条件查询
    function factorQuery() {
        window.location.href = "/tc/roomSelectPage.do?factor=" + $("#factor").val() + "&keywords=" + $("#keywords").val();
    }

    // 鼠标进入
    // $('td').mouseenter(function(){ $(this).css('background-color','blue'); })
    // // 鼠标离开
    // $('td').mouseleave(function(){ $(this).css('background-color',''); })
    //上下页
    function prePage(p) {
        var page;
        if (p == 0) {
            //js方式获取request对象的值
            if (${data.ispro}) {
                page = '${data.prePage}'
            } else {
                page = '${data.indexPage}'
            }
            ;
        } else {
            if (${data.isNextPage}) {
                page = '${data.nextPage}'
            } else {
                page = '${data.endPage}'
            }
            ;
        }
        //发送请求
        window.location.href = "/tc/roomSelectPage.do?page=" + page + "&factor=" + $("#factor").val() + "&keywords=" + $("#keywords").val() + "";
    }

    //首尾页
    function Indexpage(p) {
        var page;
        if (p == 0) {
            page = '${data.indexPage}';
        } else {
            page = '${data.endPage}';
        }
        window.location.href = "/tc/roomSelectPage.do?page=" + page + "&factor=" + $("#factor").val() + "&keywords=" + $("#keywords").val() + "";
    }

    //详情
    //打开模态框
    function roomdetails(hName,hAmount,hPrice,floorId,hState,hInfo) {
        //显示模态框
        $("#one").modal("show");
        $("#Id").text(floorId)

    }

    //保存
    function save() {
        //获取文本框中的值
        //构建js对象
        var userupdate = {
            "uId": $("#uId").val(),
            "userName": $("#userName").val(),
            "roleId": $("#dept").val(),
            "userTime": $("#userTime").val(),
        };

        var uId = $("#uId").val();
        var url;
        if ($("#uId").val() != "") {
            url = "${pageContext.request.contextPath}/ajax/updateAjax.do"
        } else {
            url = "${pageContext.request.contextPath}/ajax/addAjax.do"
        }

        //发送ajax请求
        $.ajax({
            url: url,
            type: "get",
            data: userupdate,
            dataType: "json",
            success: function (data) {
                if (data != 0 && data != null) {
                    confirm("Congratulations, successful operation！(恭喜，成功了！)");
                    $("#one").modal("hide");
                    showing();
                } else {
                    confirm("Unfortunately, it failed！(很遗憾，失败了！)")
                    save();
                }
            }
        })
    }

    //取消
    function down() {
        $("#one").modal("hide");
    }

</script>
