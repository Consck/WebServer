<%@ page language="java" pageEncoding="UTF-8" %>
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
	<base href="<%=basePath%>">
	<title>原位电池结构研究</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">

	<%@ include file="/page/include/js/basic_js.jsp" %>
	<%@ include file="/page/include/js/jqGrid_js.jsp" %>
	<%@ include file="/page/include/css/basic_css.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/ace/chosen.jquery.js"></script>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/ace/ace-fonts.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/ace/chosen.css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/ace/ace.css" rel="stylesheet" type="text/css"/>
	<link href="${pageContext.request.contextPath}/resource/css/common/jqgrid.css" rel="stylesheet" type="text/css"/>
	<!-- layer -->
	<script src="${pageContext.request.contextPath}/resource/js/layer/layer.js"></script>
	<!-- 表单输入验证 -->
	<link href="//cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.css" rel="stylesheet">
	<script src="//cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.js"></script>
</head>

<body>
<fmt:bundle basename="mgdblanguage">
	<div class="panel-body" style="background-color:#E4E6E9;">
		<form id="searchform">
			<button type="button" class="btn btn-success btn-sm  pull-right glyphicon  glyphicon-add"
					id="btn_uploadData"><fmt:message key="Auto.Upload"/>
			</button>
			<div class="row" >
				<div class="col-xs-6">
					<label for="material_name" class="control-label col-xs-3" style="margin-top: 4px;text-align: right;">材料名称:</label>
					<div class="input-group col-xs-9">
						<input id="material_name" class="form-control col-xs-12" placeholder="可输入材料名称" type="text"/>
					</div>
				</div>

				<!-- <div class="col-xs-6">
                <label for="original_patent" class="control-label col-xs-3" style="margin-top: 4px;text-align: right;">检索:</label>
            <div class="input-group col-xs-9">
                <input id="original_patent" class="form-control col-xs-12" placeholder="可输入专利原文" type="text"/>
                </div>
                </div>
                -->
				<button id="search" class="btn btn-default btn-sm col-sm-1" style=""><fmt:message
						key="search"/></button>
			</div>
		</form>
		<div class="col-lg-12" style="margin-top: 20px">
			<div style="margin:0 auto; width:1050px;">
				<table id="tablepatent" Style="margin-left: auto;margin-right: auto;cursor:pointer;"></table>
				<div id="patentpage" class="ui-state-default ui-jqgrid-pager ui-corner-bottom"></div>
			</div>
		</div>
	</div>
	<script type="text/javascript">


		<!-- 上传按钮 -->
		$("#btn_uploadData").click(function () {
			jQuery.post('${pageContext.request.contextPath}/lsd/structure!checkUploadPermission',
					function (json) {
						if (!json.success) {
							layer.msg('<fmt:message key="Auto.NoPermission"/>', {icon: 2, offset: 100});
						} else {
							location.href = "${pageContext.request.contextPath}/page/lightSourceDatabase/lsdExcelUpload.jsp";
						}
					}, 'json');
		});


		$(document).ready(function () {
			$('#searchform').bootstrapValidator();
			if (window.innerWidth > 1400) {
				$("#container").css("width", "70%");
				$(".navbar").css("width", "70%");
			}
			else {
				$("#container").css("width", "90%");
				$(".navbar").css("width", "100%");
			}
			window.onresize = function () {
				if (window.innerWidth > 1400) {
					$("#container").css("width", "70%");
					$(".navbar").css("width", "70%");
				}
				else {
					$("#container").css("width", "90%");
					$(".navbar").css("width", "100%");
				}
			};
			//查询按钮
			$("#search").click(function () {
				var index = layer.load(1, {offset: 100, shade: [0.3, '#000']});
				var json = {};
				var material_name = $("#material_name").val();
				if (material_name != "" && material_name.length > 0) {
					json["material_name"] = material_name;
				}
				var js = "[" + JSON.stringify(json) + "]";
				js =  encodeURI(js);
				console.log(js);
				$("#tablepatent").jqGrid('setGridParam', {
					url: "${pageContext.request.contextPath}/lsd/structure!listAll?jsonString=" + js
				}).trigger("reloadGrid");
				layer.close(index);
			});

			sic.plug.grid($("#tablepatent"), {

				url: '${pageContext.request.contextPath}/lsd/structure!listAll',
				colNames: ["ID","文件名称","材料名称","实验时间","实验类型","数据条数"],
				colModel: [
					{name: 'id', index: 'id', hidden: true},
					{name: 'file_name', index: 'file_name', align: 'center',formatter:linkFormatter, editable: false, sortable: false, width: 200},
					{name: 'material_name', index: 'material_name', align: 'center', formatter:linkFormatter,editable: false, sortable: false, width: 200},
					{name: 'experimental_time', index: 'experimental_time', align: 'center', editable: false, sortable: false, width: 100},
					{name: 'experimental_type', index: 'experimental_type', align: 'center', formatter:linkFormatter,editable: false, sortable: false, width: 200},
					{name: 'data_article_number', index: 'data_article_number', align: 'center', formatter:linkFormatter,editable: false, sortable: false, width: 200},

				],
				cellLayout: 0,
				rowNum: 10,
				rowList: [10, 20, 30],
				multiboxonly: false,
				multiselect: false,
				autowidth: false,
				shrinkToFit: false,
				width: 901,
				height: 'auto',
				pager: '#patentpage',
				onSelectRow: function (rowid, status) {
					location.href = "${pageContext.request.contextPath}/page/lightSourceDatabase/lsdDetail.jsp?id=" + window.btoa(rowid);
				},
			});
			function linkFormatter(cellvalue,options,rowObject){
				return omitText(cellvalue,200);
			}
		});

	</script>
</fmt:bundle>
</body>
</html>
