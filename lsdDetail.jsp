<%@ page language="java" pageEncoding="utf-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<c:set var="loc" value="zh_CN"/>
<c:forEach items="${pageContext.request.cookies}" var="c">
	<c:if test="${fn:contains(c.name,'language')}">
		<c:set var="loc" value="${c.value}"/>
	</c:if>
</c:forEach>
<fmt:setLocale value="${loc}"/>
<head>
	<fmt:bundle basename="mgdblanguage">
	<base href="<%=basePath%>">

	<title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<%@ include file="/page/include/css/basic_css.jsp" %>
	<%@ include file="/page/include/js/basic_js.jsp" %>
	<%@ include file="/page/include/js/jqGrid_js.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ace/chosen.jquery.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/ace/bootstrap-dialog.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/date-time/bootstrap-datepicker.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/common/jquery.form.js"></script>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/ace/chosen.css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/ace.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/bootstrap-dialog.css" rel="stylesheet"
		  type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/ace-fonts.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/datepicker.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/ace.css" rel="stylesheet" type="text/css"/>
	<link href="//cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resource/css/ace/colorbox.css" rel="stylesheet" type="text/css"/>
	<script src="//cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.js"></script>

	<script src="${pageContext.request.contextPath}/resource/js/layer/layer.js"></script>
	<!-- 缓冲提示 -->
	<script src="${pageContext.request.contextPath}/resource/js/common/d3.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/common/spin.min.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/common/c3.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/layer/layer.js"></script>
	<link href="${pageContext.request.contextPath}/resource/css/common/c3.css" rel="stylesheet" type="text/css"/>


	<style>
		.tab-content {
			border: 0px solid #C5D0DC;
			padding: 16px 12px;
			position: relative;
		}
	</style>
</head>

<body>
<div class="container" style="margin-bottom: 10px;width:100%">
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="tab1"
			 style="margin-bottom: 20px;">

			<div class="hr"></div>
			<h5 class="glyphicon glyphicon-list"><fmt:message key="pulse.Basic_Information"/></h5>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">文件名称:</div>
				<div class="col-xs-4" id="div_filename" style="text-align: left;font-size: 14px;"></div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">单位名称:</div>
				<div class="col-xs-10" id="div_entityname" style="text-align: left;font-size: 14px;"></div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">材料名称:</div>
				<div class="col-xs-6" id="div_materialname" style="text-align: left;font-size: 14px;"></div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">实验时间:</div>
				<div class="col-xs-4 " id="div_extime" style="text-align: left;font-size: 14px;"></div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">实验线站:</div>
				<div class="col-xs-4 " id="div_exlinestand" style="text-align: left;font-size: 14px;">
				</div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">实验类型:</div>
				<div class="col-xs-4 " id="div_extype" style="text-align: left;font-size: 14px;">
				</div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder" style="text-align: right;font-size: 14px;">实验条件:</div>
				<div class="col-xs-4 " id="div_excondition" style="text-align: left;font-size: 14px;">
				</div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder"  style="text-align: right;font-size: 14px;">数据格式:</div>
				<div class="col-xs-4 " id="div_dataformat" style="text-align: left;font-size: 14px;">
				</div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder"  style="text-align: right;font-size: 14px;">数据条数:</div>
				<div class="col-xs-4 " id="div_exdatanum" style="text-align: left;font-size: 14px;">
				</div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder"  style="text-align: right;font-size: 14px;">上传者:</div>
				<div class="col-xs-4 " id="div_uploader" style="text-align: left;font-size: 14px;">
				</div>
			</div>
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-2 bolder"  style="text-align: right;font-size: 14px;">上传时间:</div>
				<div class="col-xs-4 " id="div_uploaddata" style="text-align: left;font-size: 14px;">
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var id = window.atob("<%=request.getParameter("id")%>");
	var jsonUrl;
	$(document).ready(function () {
		jQuery.post('${pageContext.request.contextPath}/lsd/structure!listById?id=' + id,
				function (json) {
					if (!json.success) {
						layer.msg('<fmt:message key="pulse.Transmission_Failed"/>', {icon: 2, offset: 100});
					} else {
						document.getElementById('div_filename').innerHTML = json.root[0].file_name;
						document.getElementById('div_entityname').innerHTML = json.root[0].entity_name;
						document.getElementById('div_materialname').innerHTML = json.root[0].material_name;
						document.getElementById('div_extime').innerHTML = json.root[0].experimental_time;
						document.getElementById('div_exlinestand').innerHTML = json.root[0].experimental_line_stand;
						document.getElementById('div_extype').innerHTML = json.root[0].experimental_type;
						document.getElementById('div_excondition').innerHTML = json.root[0].experimental_conditions;
						document.getElementById('div_dataformat').innerHTML = json.root[0].data_format;
						document.getElementById('div_exdatanum').innerHTML = json.root[0].data_article_number;
						document.getElementById('div_uploader').innerHTML = json.root[0].uploader;
						document.getElementById('div_uploaddata').innerHTML = json.root[0].uploadDate;
					}
				}, 'json');
	});


</script>
</fmt:bundle>
</body>
</html>

