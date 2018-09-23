<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>发起任务</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		top.$.jBox.tip.mess = null;
	});
	function page(n, s) {
		location = '${ctx}/act/task/process/?pageNo=' + n + '&pageSize=' + s;
	}
</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>任务列表</h5>
				<div class="ibox-tools">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="dropdown-toggle" data-toggle="dropdown"
						href="form_basic.html#"> <i class="fa fa-wrench"></i>
					</a>
					<ul class="dropdown-menu dropdown-user">
						<li><a href="#">选项1</a></li>
						<li><a href="#">选项2</a></li>
					</ul>
					<a class="close-link"> <i class="fa fa-times"></i>
					</a>
				</div>

			</div>
			<div class="ibox-content">
				<sys:message content="${message}" />

				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12">

						<form id="searchForm" action="${ctx}/act/task/process/"
							method="post" class="breadcrumb form-search">
							<div class="form-group">
								<table class="table-condensed">
									<tr>
										<td><span>流程分类：</span></td>
										<td><select id="category" cssStyle="width: 166px;"
											name="category" class="form-control m-b">
												<option value="">全部分类</option>
												<c:forEach items="${fns:getDictList('act_category')}"
													var="dict">
													<option value="${dict.value}"
														${dict.value==category?'selected':''}>${dict.label}</option>
												</c:forEach>
										</select></td>
									</tr>
								</table>
							</div>
						</form>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							
							
							<button class="btn btn-white btn-sm " data-toggle="tooltip"
								data-placement="left" onclick="sortOrRefresh()" title="刷新">
								<i class="glyphicon glyphicon-repeat"></i> 刷新
							</button>
						</div>
						<div class="pull-right">
							<button class="btn btn-primary btn-rounded btn-outline btn-sm "
								onclick="search()">
								<i class="fa fa-search"></i> 查询
							</button>
							<button class="btn btn-primary btn-rounded btn-outline btn-sm "
								onclick="reset()">
								<i class="fa fa-refresh"></i> 重置
							</button>
						</div>
					</div>
				</div>

				<table id="contentTable"
					class="table table-striped table-bordered  table-hover table-condensed  dataTables-example dataTable no-footer">
					<thead>
						<tr>
							<th><input type="checkbox" class="i-checks"></th>
							<th>流程分类</th>
							<th>流程标识</th>
							<th>流程名称</th>
							<th>流程图</th>
							<th>流程版本</th>
							<th>更新时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.list}" var="object">
							<c:set var="process" value="${object[0]}" />
							<c:set var="deployment" value="${object[1]}" />
							<tr>
								<td><input type="checkbox" id="${process.id}"
									class="i-checks"></td>
								<td>${fns:getDictLabel(process.category,'act_category','无分类')}</td>
								<td>${process.key}</td>
								<td>${process.name}</td>
								<td>
									<%--<a target="_blank" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${process.id}">${process.diagramResourceName}</a>--%>
									<a target="_blank"
									href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=image">${process.diagramResourceName}</a>
								</td>
								<td><b title='流程版本号'>V: ${process.version}</b></td>
								<td><fmt:formatDate value="${deployment.deploymentTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><a href="#"
									onclick="openDialogView('流程表单', '${ctx}/act/task/form?procDefId=${process.id}','80%', '70%')"
									class="btn btn-success btn-xs">启动流程</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- 分页代码 -->
				<table:page page="${page}"></table:page>
				<br /> <br />
			</div>
		</div>
	</div>
</body>
</html>
