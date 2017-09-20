<%@ page language="java" import="java.util.*,bean.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head> 
    <title>Remind me-查询页面.html</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css "> 
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js "></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/paramap.js"></script>

    <style>
    tr{
    border-radius:10px;
    }
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

    <%--#reminder{--%>
    <%--dispaly:inline-block;--%>
    <%--width:66px;--%>
    <%--text-align:center;--%>
    <%--}--%>
    <%--#remindper{--%>
    <%--dispaly:inline-block;--%>
    <%--width:66px;--%>
    <%--text-align:center;--%>
    <%--}--%>
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
    .better>li{
    background-color: #ddd;
    font-size: 18px;
    text-align: center;
    margin-top:1px;
    }
    .better>li:hover{
    background-color: #999;
    cursor:pointer;
    }
    .remeder>li{
    background-color: #ddd;
    font-size: 18px;
    text-align: center;
    margin-top:1px;
    }
    .remeder>li:hover{
    background-color: #999;
    cursor:pointer;

    }
    .tdContent{
    margin-left:-30px;
    }
    .Contenthead{
     margin-left:-20px;
    }
    .Contenthead>li{
    background-color:#fcf8e3;
    display: inline-block;
    margin-left: -5px;
    width: 11%;
    height: 40px;
    overflow: hidden;
    text-align: center;
    line-height: 40px;
    }
.reminderThing{
    display: inline-block;
    text-overflow: ellipsis;
    border-radius: 4px;
    margin-left: 2px;
    white-space: nowrap;
    width: 100%;
    height: 25px;
    text-align: center;
    line-height: 25px;
    overflow: hidden;
    }
    .tdContent>li{
    background-color: #dff0d8;
    display: inline-block;
    text-overflow: ellipsis;
    border-radius: 4px;
    margin-left: 8px;
    white-space: nowrap;
    width: 10%;
    height: 25px;
    text-align: center;
    line-height: 25px;
    overflow: hidden;
    word-wrap: break-word;
    }
    </style>
</head>
<body>
<div class="bimg"></div>
    <div class="container content">

    <h1 id="show" style="margin:30px;display:none;color:#A5B1A0; text-align:center;" >REMIND ME</h1>

    <div class="container headerbgc">

    <table  class="table table-condensed">

    <tr class="success">
    <td>
    <span style="display:inline-block;width:48px;"></span><span class="text-info">好&nbsp;心&nbsp;人&nbsp;:</span>
    <select style="border:none;outline:none;" class="btn btn-primary" name="reminder" id="reminder">
    <option value="99" selected="selected">请选择</option>
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
    <td style="text-align:center;"><input style="width:90px;border:none;outline:none;" type="button" class="function-button btn btn-large btn-primary" value="查 询" onclick="submit()"/></td></td>
    </tr>
    <tr class="success">
    <td >
    <span style="display:inline-block;width:48px;"></span><span class="text-info">被提醒人:</span>
    <select style="border:none;outline:none;" class="btn btn-primary" name="remindper" id="remindper">
    <option value="99" selected="selected">请选择</option>
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
    <td style="text-align:center;"> <form action= "RemindInsert.jsp"  style="margin-bottom: 0em;">
    <input style="width:90px;border:none;outline:none;" type="submit" class="function-button btn btn-primary btn-large" value="新 增" />
    </form> </td>
    </tr>


    </table>








</div>





    <div class="container">
    <ul  class="Contenthead">
    <li  style="width:6%;border-top-left-radius:6px;border-bottom-left-radius:6px;">序号</li>
    <li style='width:10%;' >好心人</li>
    <li style='width:8%;'>被提醒人</li>
    <li style='width:29%;'>提醒事宜</li>
    <li style='width:17%;'>下次提醒时间</li>
    <li style='width:9%;'>提醒频率</li>
    <li style='width:8%;'>提醒方式</li>
    <li style='width:7%;text-align:left;'>是否有效</li>
    <li  style="text-align:left;width:5%;border-top-right-radius:6px;border-bottom-right-radius:6px;">详情</li>
    </ul>

    </div>

<div class="container" id="content" ></div>
<div class="container" id="content2" ></div>
    </div>








    <div class="container  bgc center"></div>

    <ul id="clpage" style="position:relative;top:65px;display:none;" class="pager">
    <li ><a id="ffpage" style="background-color:#dff0d8;" href="#">首页</a></li>
    <li ><a id="prev" style="background-color:#dff0d8;" href="#">上一页</a></li>
    <li><span  id="crepage" style="color:black;" class="badge">1</span></li>
    <li ><a id="next" style="background-color:#dff0d8;" href="#">下一页</a></li>
    <li ><a id="llpage" style="background-color:#dff0d8;" href="#">尾页</a></li>
    <li ><a style="background-color:#dff0d8;" href="#">共 <span id="total">15</span> 页</a></li>
    </ul>

    <!-- Modal -->
    <div  id="myModal"  class="modal  fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

    <div style="margin-top: 100px;margin-left: 25%;width: 47%;background-color:white;border-top-right-radius: 10px;border-top-left-radius: 10px;"class="modal-header">
    <br>
    <button type="button" style="outline:none;margin-top:-22px;" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    </div>
    <div style="margin-left: 25%;width: 47%;background-color:white;" class="modal-body">
    <p style="font-size: 21px;text-align: center;margin-top: 10px;">查询暂无相关数据！</p>
    </div>
    <div style="border-bottom-right-radius: 10px;border-bottom-left-radius: 10px;margin-left: 25%;width: 47%;background-color:#f5f5f5;" class="modal-footer">
    <button style="width:90px;outline:none;" class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <%--<button style="outline:none;" class="btn btn-primary" >确定</button>--%>
    </div>
    </div>



</body>




<script>


    $("#show").show('slow');

    $('.better li').click(function(){

    $("#reminder").text($(this).text());
    $("#reminder").attr('value',$(this).attr('value'));
    });
    $('.remeder li').click(function(){

    $("#remindper").text($(this).text());
    $("#remindper").attr('value',$(this).attr('value'));
    });

        var otd = 1,total=1,crepage=1,fPage=0;
	    $(document).ready(function() {
        $.ajax({
            url : "${pageContext.request.contextPath}/query",
            type : "get",
            dataType : "json",
            data : {
            },
            success : function (ret) {

    if(ret.length > 10 ){
    total=Math.ceil(parseInt(ret.length)/10);
     $('#clpage').css({display:'block'});
    };
                var contentContainer = $('#content');
                for (var index in ret)
                    if (ret.hasOwnProperty(index)) {
    if(index>9){break;};
                        var api = ret[index];       
                               tt = encodeURI(encodeURI(api.REMTHING));

    if((index%2) ==0){
       otd=2;
    }else{
       otd=1;
    };

    contentContainer.append(
    "<ul class='tdContent' odd='"+otd+"'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</li></div>"
    +"<li style='width:15%;' class='reminderTime'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
 );




                    };

    $('#crepage').text(crepage);
    $('#total').text(total);
    $('#prev').css({cursor:'pointer'});
    $('#next').css({cursor:'pointer'});


    $('#ffpage').off('click');
    $('#ffpage').click(function(){

    contentContainer.html('');
    crepage=1;
    $('#crepage').text(crepage);
    fPage = (crepage-1)*10;
    for (fPage, cc=0;fPage<ret.length;fPage++,cc++){
    if (ret.hasOwnProperty(fPage)) {
    if(cc>9)break;
    var api = ret[fPage];

    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
    );
    }
    };


    });

    $('#llpage').off('click');
    $('#llpage').click(function(){


    contentContainer.html('');
    crepage=total;
    $('#crepage').text(crepage);
    fPage = (crepage-1)*10;
    for (fPage, cc=0;fPage<ret.length;fPage++,cc++){
    if (ret.hasOwnProperty(fPage)) {
    if(cc>9)break;
    var api = ret[fPage];

    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
    );
    }
    };


    });

    $('#prev').off('click');
    $('#prev').click(function(){

    if(parseInt($("#crepage").text()) <=1){console.log("yi")}else{
    contentContainer.html('');
    crepage--;
    $('#crepage').text(crepage);
    fPage = (crepage-1)*10;
    for (fPage,cc=0;fPage<ret.length;fPage++,cc++){
    if (ret.hasOwnProperty(fPage)) {

    if(cc>9)break;
    var api = ret[fPage];

    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
    );
    }
    };

    };




    });

    $('#next').off('click');
    $('#next').click(function(){

    if(parseInt($("#crepage").text()) >=total){console.log("gong")}else{
    contentContainer.html('');
    crepage++;
    $('#crepage').text(crepage);
    fPage = (crepage-1)*10;
    for (fPage, cc=0;fPage<ret.length;fPage++,cc++){
    if (ret.hasOwnProperty(fPage)) {
    if(cc>9)break;
    var api = ret[fPage];

    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
    );
    }
    };

    };
    });

    $('.reminderThing').mouseover( function() {
    $(this).css({cursor:'pointer'});
    $(this).attr('title',$(this).text());
    });

  $('.tdContent[odd=2] >li').css({backgroundColor:'#dffod8'});
  $('.tdContent[odd=1] >li').css({backgroundColor:'#fcf8e3'});


            }
        });
})


function submit(){
    $("#clpage").css({display:'none'});
 $.ajax({
            url : "${pageContext.request.contextPath}/conquery",
            type : "get",
            dataType : "json",
            data : {  
               "reminder" : $("#reminder").val(),
               "remindper" : $("#remindper").val()
            },
            success : function (ret) {
    if(ret.length > 10 ){
    total=Math.ceil(parseInt(ret.length)/10);
    $('#clpage').css({display:'block'});
    };
                var content = $('#content');
                content.empty();             
                var contentContainer = $('#content2');
                contentContainer.empty();
                if (ret.length != 0){

                for (var index in ret){
                    if (ret.hasOwnProperty(index)) {
    if(index>9){break;};
                        var api = ret[index];
    if((index%2) ==0){
    otd=2;
    }else{
    otd=1;
    };
    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
    );
                    }
                };

    <%--<ul style="position:relative;top:25px;" class="pager">--%>
    <%--<li ><a id="prev" style="background-color:#dff0d8;" href="#">上一页</a></li>--%>
    <%--<li><span  id="crepage" style="color:black;" class="badge">1</span></li>--%>
    <%--<li ><a id="next" style="background-color:#dff0d8;" href="#">下一页</a></li>--%>
    <%--<li ><a style="background-color:#dff0d8;" href="#">共 <span id="total">15</span> 页</a></li>--%>
    <%--</ul>--%>
  //分页项
    $('#crepage').text(crepage);
    $('#total').text(total);
    $('#prev').css({cursor:'pointer'});
    $('#next').css({cursor:'pointer'});

    $('#prev').off('click');
    $('#prev').click(function(){

    if(parseInt($("#crepage").text()) <=1){console.log("yi")}else{
    contentContainer.html('');
    crepage--;
    $('#crepage').text(crepage);
    fPage = (crepage-1)*10;
    for (fPage,cc=0;fPage<ret.length;fPage++,cc++){
    if (ret.hasOwnProperty(fPage)) {

    if(cc>9)break;
    var api = ret[fPage];

    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"'>详情</a></li>"
    +"</ul>"
    );
    }
    };

    };

    });

    $('#next').off('click');

    $('#next').click(function(){

    if(parseInt($("#crepage").text()) >=total){console.log("gong")}else{
    contentContainer.html('');
    crepage++;
    $('#crepage').text(crepage);
    fPage = (crepage-1)*10;
    for (fPage, cc=0;fPage<ret.length;fPage++,cc++){
    if (ret.hasOwnProperty(fPage)) {
    if(cc>9)break;
    var api = ret[fPage];

    contentContainer.append(
    "<ul class='tdContent'>"
    +"<li style='width:5%;'>" + api.SEQNO + "</li>"
    +"<li style='width:8%;'>" + tranReminder[api.REMINDER] + "</li>"
    +"<li style='width:8%;'>" + tranRemindper[api.REMPER] + "</li>"
    +"<li style='width:31%;' ><div class='reminderThing'>" + api.REMTHING + "</div></li>"
    +"<li style='width:15%;'>" + api.NEXTREMTIME + "</li>"
    +"<li style='width:8%;'>" + tranRemindfreq[api.REMFREQ] + "</li>"
    +"<li style='width:5%;'>" + tranRemindway[api.REMWAY] + "</li>"
    +"<li style='width:5%;'>" + tranValflag[api.VALFLAG] + "</li>"
    +"<li style='width:5%;'><a href='${pageContext.request.contextPath}/update?a="+
    +api.SEQNO+"&b="+tt+"&c="+api.NEXTREMTIME+"&d="+api.REMINDER+"&e="
    +api.REMPER+"&f="+api.REMFREQ+"&g="+api.REMWAY+"' >详情</a></li>"
    +"</ul>"
    );
    }
    };
    };
    });
    $('.reminderThing').mouseover( function() {
    $(this).css({cursor:'pointer'});
    $(this).attr('title',$(this).text());
    });
            }else{
                   $('#myModal').modal('show');
                    }
            },
            error: function(){
           	alert("system error!");
           }
        });
}
</script>
</html>







