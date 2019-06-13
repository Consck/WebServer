<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<c:set var="loc" value="zh_CN"/>
	<c:forEach items="${pageContext.request.cookies}" var="c">
		<c:if test="${fn:contains(c.name,'language')}">
			<c:set var="loc" value="${c.value}"/>
		</c:if>
	</c:forEach>
	<fmt:setLocale value="${loc}" />
	<fmt:bundle basename="mgdblanguage">
	<base href="<%=basePath%>">
	<meta charset="utf-8">
	<link href="${pageContext.request.contextPath}/resource/css/ace/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/resource/css/ace/font-awesome.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/resource/css/ace/ace-fonts.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/resource/css/ace/ace.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/resource/css/ace/bootstrap-dialog.min.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/resource/css/common/smartMenu.css" rel="stylesheet" type="text/css" />
	<title>光源数据库</title>
	<%@ include file="/page/include/header.jsp"%>
	<style type="text/css">
		/*left*/

		.leftsidebar_box {
			height: auto !important;

			height: 100% !important;
			background-color: #438EB9;
		}

		.line {
			height: 2px;
			width: 100%;
			background-image: url(line);
			background-repeat: repeat-x;
		}

		.leftsidebar_box dt {
			padding-left: 40px;
			padding-right: 10px;
			background-repeat: no-repeat;
			background-position: 10px center;
			color: #f5f5f5;
			font-size: 14px;
			position: relative;
			line-height: 48px;
			cursor: pointer;
		}

		.leftsidebar_box dd {
			background-color: #317eb4;
			padding-left: 40px;
		}

		.leftsidebar_box dd a {
			color: #f5f5f5;
			line-height: 20px;
		}

		.leftsidebar_box dt img {
			position: absolute;
			right: 10px;
			top: 20px;
		}

		.system_log dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/system.png)
		}

		.custom dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/custom.png)
		}

		.channel dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/channel.png)
		}

		.app dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/app.png)
		}

		.cloud dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/cloud.png)
		}

		.syetem_management dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/syetem_management.png)
		}

		.source dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/source.png)
		}

		.statistics dt {
			background-image: url(${pageContext.request.contextPath}/resource/images/nav_left_images/left/statistics.png)
		}

		.leftsidebar_box dl dd:last-child {
			padding-bottom: 10px;
		}
	</style>
</head>

<body>

<div class="container"style="padding-right: 0px;" >
	<div  >
		<img id="top_banner"  src="${pageContext.request.contextPath}/resource/img/banner4.jpg" width="1164"  />
	</div>
	<div class="row" style="margin-left: 0px;">
		<div  id="sidebar" class="col-lg-2 " style="border: 1px solid green;padding: 0px;height: 600px;" >
			<div id="sidebar2" class="leftsidebar_box">
				<div class="line"></div>
				<dl class="system_log">
					<dt >光源数据库<img src="${pageContext.request.contextPath}/resource/images/nav_left_images/left/select_xl01.png"></dt>
					<dd ><a href="page/lightSourceDatabase/battery_structure.jsp" target="lightSourceDatabaseIframe">原位电池结构研究</a></dd>
					<dd ><a href="page/lightSourceDatabase/battery_structure.jsp" target="lightSourceDatabaseIframe">原位电池结构研究</a></dd>
				</dl>

			</div>
			<script type="text/javascript">
				$(".leftsidebar_box dt").css({
					"background-color": "#438EB9"
				});
				$(".leftsidebar_box dt img").attr("src", "${pageContext.request.contextPath}/resource/images/nav_left_images/left/select_xl01.png");
				$(function() {
					$(".leftsidebar_box dd").hide();
					$(".leftsidebar_box dt").click(function() {
						$(".leftsidebar_box dt").css({
							"background-color": "#438EB9"
						});
						$(this).css({
							"background-color": "#317eb4"
						});
						$(this).parent().find('dd').removeClass("menu_chioce");
						$(".leftsidebar_box dt img").attr("src", "${pageContext.request.contextPath}/resource/images/nav_left_images/left/select_xl01.png");
						$(this).parent().find('img').attr("src", "${pageContext.request.contextPath}/resource/images/nav_left_images/left/select_xl.png");
						$(".menu_chioce").slideUp();
						$(this).parent().find('dd').slideToggle();
						$(this).parent().find('dd').addClass("menu_chioce");
					});
				})
			</script>
		</div>
		<div class="col-lg-10"  style="border: 1px solid green;" >
			<iframe src="page/lightSourceDatabase/battery_structure.jsp" id="lightSourceDatabaseIframe"
					name="lightSourceDatabaseIframe" scrolling="no" height="600" width="100%"> </iframe>
		</div>
	</div>
	<%@ include  file="/page/include/footer.jsp"%>
</div>



<script type="text/javascript">
	function iFrameHeight() {
		var iframe = document.getElementById("lightSourceDatabaseIframe");
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.height = height;
		var sidebar = document.getElementById("sidebar");
		sidebar.style.height=height;
		var sidebar2 = document.getElementById("sidebar2");
		sidebar2.height=height;
	}
	window.onload=iFrameHeight();
	function changeBanner1() {
		var top_banner=     document.getElementById("top_banner");
		top_banner.setAttribute("src","${pageContext.request.contextPath}/resource/img/banner_gtk.jpg");
	}
	function changeBanner2() {
		var top_banner=     document.getElementById("top_banner");
		top_banner.setAttribute("src","${pageContext.request.contextPath}/resource/img/banner_gtfw.jpg");
	}
	var str=location.href;
	var num = str.indexOf("?");
	str = str.substr(num + 1);
	var num = str.indexOf("=");
	str = str.substr(num + 1);
	var index=parseInt(str);
	switch(index){
		case 0:
			document.getElementById("lightSourceDatabaseIframe").src="page/lightSourceDatabase/battery_structure.jsp";
			break;
		case 1:
			document.getElementById("lightSourceDatabaseIframe").src="page/lightSourceDatabase/battery_structure.jsp";
			break;
		default:
			document.getElementById("lightSourceDatabaseIframe").src="page/lightSourceDatabase/battery_structure.jsp";
	}
</script>

</body>
</fmt:bundle>
</html>