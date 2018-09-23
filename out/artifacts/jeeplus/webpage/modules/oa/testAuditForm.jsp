<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>审批管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	var validateForm;
	
	function yes(){
		if (validateForm.form()) {
			$('#flag').val('no');
			$("#inputForm").submit();
			layer.closeAll();
			return true;
		}

		return false;
		
	}

	/* function doSubmit() {//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		if (validateForm.form()) {
			$("#inputForm").submit();
			return true;
		}

		return false;
	} */

	$(document).ready(
			function() {
				validateForm = $("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
</script>
</head>
<body class="hideScroll">
	<form:form id="inputForm" modelAttribute="testAudit"
		action="${ctx}/oa/testAudit/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="act.taskId" />
		<form:hidden path="act.taskName" />
		<form:hidden path="act.taskDefKey" />
		<form:hidden path="act.procInsId" />
		<form:hidden path="act.procDefId" />
		<form:hidden id="flag" path="act.flag" />
		<sys:message content="${message}" />
		<legend>审批申请</legend>
		<table
			class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
			<tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font
							color="red">*</font>姓名：</label></td>
					<td class="width-15"><sys:treeselect id="user" name="user.id"
							cssClass="form-control required" value="${testAudit.user.id}"
							labelName="user.name" labelValue="${testAudit.user.name}"
							title="用户" url="/sys/office/treeData?type=3" allowClear="true"
							notAllowSelectParent="true" smallBtn="false" /></td>
					<td class="width-15 active"><label class="pull-right"><font
							color="red">*</font>部门：</label></td>
					<td class="width-15"><sys:treeselect id="office" name="office.id"
							value="${testAudit.office.id}" labelName="office.name"
							labelValue="${testAudit.office.name}" title="用户"
							url="/sys/office/treeData?type=2" allowClear="true"
							notAllowSelectParent="true" smallBtn="false"
							cssClass="form-control required" /></td>
					<td class="width-15 active"><label class="pull-right">岗位职级：</label></td>
					<td  class="width-15"><form:input path="post" htmlEscape="false" maxlength="50" class="form-control" />
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>调整原因：</label></td>
					<td class="width-15" colspan="5"><form:textarea path="content" class="form-control required"
							rows="5" maxlength="200" /></td>
							
				</tr>
				<tr>
					<td class="width-15 active" rowspan="3"><label class="pull-right">调整原因：</label></td>
					<td class="width-15 active" ><label class="pull-right">薪酬档级：</label></td>
					<td class="width-15"><form:input path="olda" htmlEscape="false" maxlength="50" cssClass="form-control"/></td>
					<td class="width-15 active" rowspan="3"><label class="pull-right">拟调整标准：</label></td>
					<td class="width-15 active"><label class="pull-right">薪酬档级：</label></td>
					<td class="width-15"><form:input path="newa" htmlEscape="false" maxlength="50" cssClass="form-control" /></td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">月工资额：</label></td>
					<td class="width-15"><form:input path="oldb" htmlEscape="false" maxlength="50" cssClass="form-control"/></td>
					<td class="width-15 active"><label class="pull-right">月工资额：</label></td>
					<td class="width-15"><form:input path="newb" htmlEscape="false" maxlength="50" cssClass="form-control"/></td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">年薪金额：</label></td>
					<td><form:input path="oldc" htmlEscape="false" maxlength="50" cssClass="form-control"/></td>
					<td class="width-15 active"><label class="pull-right">年薪金额：</label></td>
					<td><form:input path="newc" htmlEscape="false" maxlength="50" cssClass="form-control"/></td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">月增资：</label></td>
					<td class="width-15" colspan="2"><form:input path="addNum" htmlEscape="false"
							maxlength="50" cssClass="form-control"/></td>
					<td class="width-15 active"><label class="pull-right">执行时间：</label></td>
					<td class="width-15" colspan="2"><form:input path="exeDate" htmlEscape="false"
							maxlength="50" cssClass="form-control"/></td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">人力资源部意见：</label></td>
					<td class="width-15" colspan="5">${testAudit.hrText}</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">分管领导意见：</label></td>
					<td colspan="5">${testAudit.leadText}</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">集团主要领导意见：</label></td>
					<td colspan="5">${testAudit.mainLeadText}</td>
				</tr>
			</tbody>
		</table>
		<div class="form-actions">
			<shiro:hasPermission name="oa:testAudit:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="提交申请" onclick="yes()" />&nbsp;
				<c:if test="${not empty testAudit.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit"
						value="销毁申请" onclick="$('#flag').val('no')" />&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
		<c:if test="${not empty testAudit.id}">
			<act:histoicFlow procInsId="${testAudit.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>
