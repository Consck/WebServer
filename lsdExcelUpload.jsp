<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>

<html>
<c:set var="loc" value="zh_CN"/>
<c:forEach items="${pageContext.request.cookies}" var="c">
	<c:if test="${fn:contains(c.name,'language')}">
		<c:set var="loc" value="${c.value}"/>
	</c:if>
</c:forEach>
<fmt:setLocale value="${loc}" />
<head>
	<title><fmt:message key="Auto.PatentUploadHead"/></title>
	<%@ include file="/page/include/css/basic_css.jsp" %>
	<%@ include file="/page/include/js/basic_js.jsp" %>
	<%@ include file="/page/include/excelUpload.jsp" %>
</head>

<body class="no-skin">
<fmt:bundle basename="mgdblanguage">
	<div class="main-container" id="main-container">
		<div class="widget-main">
			<div class="form-group" id = "div_excel">
				<div class="col-xs-12">
					<div class="uploader white col-xs-4" >
						<input type="text" class="filename" readonly/>
						<input type="button" name="file" class="button" value="Browse..."/>
						<input id="file" type="file" name="file" size="30"/>
					</div>
					<div class="col-xs-4">
						<input id="file-submit" type="button" class="btn btn-info btn-sm popover-info" value="<fmt:message key="Auto.Submit"/>">
					</div>
					<div class="col-xs-2 pull-right" >
						<button id="btn_templateDownload" class="btn btn-default btn-sm btn-success col-xs-12" style="text-align: center;"><fmt:message key="Auto.TemplateDownload"/></button>
					</div>
				</div>
			</div>

			</div>

		</div>
	</div>
	<script type="text/javascript">
		//上传EXCEL文件
		$('#file-submit').on('click', function () {
			var loadIndex = layer.load(1, {offset: 300, shade: [0.3, '#000']});
			$.ajaxFileUpload({
				//将url的值改为自己写的方法路径信息
				url: '${pageContext.request.contextPath}/lsd/structure-excel!excelOperate', //用于文件上传的服务器端请求地址
				secureuri: false, //一般设置为false
				fileElementId: 'file',
				dataType: 'json', //返回值类型 一般设置为json

				success: function (data,result, status) //服务器成功响应处理函数
				{
					if(data.success){
						layer.close(loadIndex);
						layer.msg('<fmt:message key="Auto.ExcelUploaded"/>', {icon: 1, offset: 100});
						$("#file-upload").show();
						$("#div_excel").hide();
						info_id = data.info_id; //接收从excelOperate方法传递的info_id
					}else{
						layer.close(loadIndex);
						layer.msg(data.msg, {icon: 2, offset: 100});
					}
				},
				error: function (data, status, e)//服务器响应失败处理函数
				{
					layer.close(loadIndex);
					layer.msg(data.msg, {icon: 2, offset: 100});
				}
			});
		});

	</script>
</fmt:bundle>
</body>
</html>