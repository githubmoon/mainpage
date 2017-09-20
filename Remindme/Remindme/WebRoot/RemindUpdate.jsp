<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
     
    <title>My JSP 'RemindInsert.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css "> 
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/paramap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js "></script>
    <style>
    body{
    font-family:Microsoft YaHei;
    }
    .bimg{
    position:fixed;
    width:100%;
    height:100%;
    background-image:url(images/backpic.png);
    background-size:100% 100%;
    }
    .bgc{
    border-radius:10px;
    position: fixed;
    background: black;
    opacity: 0.4;
    width: 88%;
    height: 88%;
    z-index: 0;
    left: 6%;
    top: 68px;
    }
    .content{
    position:relative;
    z-index:999;
    top:57px;
    }
    </style>
  </head>
  
 <body>
    <div class="bimg"></div>
    <div class="container content">
    <h1 id="show" style="margin:30px;display:none;color:#A5B1A0; text-align:center;" >REMIND ME</h1>

<form action="save" method="post">
<table class="table table-condensed center">
<tr class="success">
<input type="hidden" size="5" name="seqno" value="${seqno}" readonly="true" />

<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
    <span class="text-success">好&nbsp;心&nbsp;人 : </span>
<select style="border:none;outline:none;" class="btn btn-primary" name="reminder" id="reminder">
  <option value ="yangr">杨睿</option>
  <option value ="gaoy">高勇</option>
  <option value="zhanglch">张立超</option>
  <option value="zengj">曾菁</option>
  <option value ="xiongshj">熊圣杰</option>
  <option value ="liaotl">廖腾龙</option>
  <option value ="lik">李科</option>
  <option value="yangj">杨进</option>
  <option value="longch">龙超</option>
  <option value ="liw">李文</option>
  <option value="zhujg">朱加贵</option>
  <option value="linchb">林长波</option>
  <option value ="liqs">李清松</option>
  <option value="chenyq">陈云强</option>
  <option value="zhangq">张强</option>
</select>
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

<td>
    <span class="text-success">被提醒人 : </span>
<select style="border:none;outline:none;" class="btn btn-primary" name="remindper" id="remindper">
  <option value ="yangr">杨睿</option>
  <option value ="gaoy">高勇</option>
  <option value="zhanglch">张立超</option>
  <option value="zengj">曾菁</option>
  <option value ="xiongshj">熊圣杰</option>
  <option value ="liaotl">廖腾龙</option>
  <option value ="lik">李科</option>
  <option value="yangj">杨进</option>
  <option value="longch">龙超</option>
  <option value ="liw">李文</option>
  <option value="zhujg">朱加贵</option>
  <option value="linchb">林长波</option>
  <option value ="liqs">李清松</option>
  <option value="chenyq">陈云强</option>
  <option value="zhangq">张强</option>
</select>
</td>
</tr>
</table>

<table class="table table-condensed">
<tr class="warning">
<td style="text-align:center;line-height:143px;">
    <span class="text-info">提醒事宜 : </span></td><td colspan=3>
<textarea placeholder="请输入..." cols ="48" rows = "3" style="padding-left:3px;border-radius:6px;width: 80%;height:149px;border:1px solid #B1D0EA;outline:none;" name="remindthing"  id="remthing" />
</textarea>
</td>
</tr>

</table>
<table class="table table-condensed">

<tr class="success">
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
    <span class="text-success">提醒日期 : </span><input placeholder="YY-MM-DD" style="padding-left:3px;border-radius:5px;border:1px solid #B1D0EA;outline:none;" type="date" name="reminddate"  size="12" id="remdate" value="${remdate}"  />
</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
    <span class="text-success">提醒时间 : </span><input placeholder="hh:mm" style="padding-left:3px;border-radius:5px;border:1px solid #B1D0EA;outline:none;" type="time" name="remindtime"  size="12" id="remtime" value="${remtime}"  />

</td>
</tr>
    </table>

    <table class="table table-condensed">
<tr class="warning">
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
   <span class="text-info">提醒频率 : </span>
<select style="border:none;outline:none;text-align:center;" class="btn btn-primary" name="remindfreq" id="remindfreq">
  <option value ="O">O 仅此一次</option>
  <option value ="D">D 每天一次</option>
  <option value="W">W 每周一次</option>
  <option value="M">M 每月一次</option>
</select>
</td>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>
    &nbsp;<span class="text-info">提醒方式 : </span>
<select style="border:none;outline:none;text-align:center;" class="btn btn-primary" name="remindway" id="remindway">
  <option value ="MSG">MSG 短信</option>
  <option value ="MAIL">MAIL 邮件</option>
  <option value="WX">WX 微信</option>
</select>
</td>
</tr>
    </table>

    <table class="table table-condensed">


    <tr class="success">
    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td style="text-align:left;line-height:45px;">
<input type="hidden" name="h"/>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<input style="width:100px;border:none;outline:none;" class="function-button btn btn-primary" type="submit" value="修改"  onclick="h.value='xiugai'" />
</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
</form>
<td style="text-align:left;">
<form action= "RemindInfo.jsp">
   <input style="width:100px;position:relative;top:8px;border:none;outline:none;" class="function-button btn btn-primary" type="submit" value="返回" onclick="h.value='fanhui'"/>
</form>
</td>
</tr>

</table>
          </div>


    <div class="container  bgc center"></div>

</body>
<script>
    $("#show").show('slow');
	$(document).ready(function() {
		 $('select[id=reminder]').val('${reminder}');
		 $('select[id=remindper]').val('${remindper}');
		 $('select[id=remindfreq]').val('${remindfreq}');
		 $('select[id=remindway]').val('${remindway}');
		 
		 document.getElementById("remthing").value="${remthing}";
	});
	
	
</script>

</html>
