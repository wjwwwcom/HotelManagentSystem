<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/css/bootstrap.css">
    <script src="/static/js/jquery-3.5.0.min.js"></script>
    <script src="/static/js/bootstrap.js"></script>
</head>

<body>
<table class="table table-striped table-condensed table-hover">
    <thead>
    <th>编号</th>
    <th>图片</th>
    <th>类型</th>
    <th>价格</th>
    <th>操作</th>
    </thead>
    <tbody>
    <c:forEach items="${data.list}" var="x">
        <tr>
            <td>${x.hId}</td>
            <td><c:if test="${x.hAmount ==1}">
                <img src="/static/images/1.jpg" width="70" height="50">
            </c:if>
                <c:if test="${x.hAmount ==2}">
                    <img src="/static/images/2.jpg" width="70" height="50">
                </c:if></td>
            <td>${x.hAmount}</td>
            <td>${x.hPrice}</td>
            <td><button type="button" class="btn btn-success btn-sm" onclick="roomdetails()">详情</button>
               <button type="button" class="btn btn-danger btn-sm " onclick="roomReserve()"></button>
                <b style="color: red">${info}</b>
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
<div class="modal fade" id="one" style="top:200px">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--头部-->
            <div class="modal-header" style="background-color: green; height: 20px;">
            </div>
            <div class="modal-body">

                <table class="table" border="0">
                    <tr>
                        <td>房间号：<span></span></td>
                    </tr>
                    <tr>
                        <td>房间类型：<span></span></td>
                    </tr>
                    <tr>
                        <td>单价：<span></span></td>
                    </tr>
                    <tr>
                        <td>楼层：<span></span></td>
                    </tr>
                    <tr>
                        <td>状态：<span></span></td>
                    </tr>

                    <tr>
                        <td><span style="color:red" id="info"></span></td>
                        <td colspan="2">
                            <button type="button" class="btn btn-success btn-sm" onclick="save()" >OK</button>
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

    //详情
    //打开模态框
    function roomdetails() {
        //显示模态框
        $("#one").modal("show");

    }
    //保存
    function save(){
        //获取文本框中的值
        //构建js对象
        var userupdate = {
            "uId":$("#uId").val(),
            "userName":$("#userName").val(),
            "roleId":$("#dept").val(),
            "userTime":$("#userTime").val(),
        };

        var uId=$("#uId").val();
        var url;
        if($("#uId").val()!=""){
            url ="${pageContext.request.contextPath}/ajax/updateAjax.do"
        }else{
            url ="${pageContext.request.contextPath}/ajax/addAjax.do"
        }

        //发送ajax请求
        $.ajax({
            url:url,
            type: "get",
            data:userupdate,
            dataType: "json",
            success:function (data) {
                if (data!=0 && data!=null){
                    confirm("Congratulations, successful operation！(恭喜，成功了！)");
                    $("#one").modal("hide");
                    showing();
                }else {
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
