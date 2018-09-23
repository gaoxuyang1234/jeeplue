<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>流程管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		top.$.jBox.tip.mess = null;
	});
	function page(n, s) {
		location = '${ctx}/act/process/?pageNo=' + n + '&pageSize=' + s;
	}
	function updateCategory(id, category) {
		$.jBox($("#categoryBox").html(), {
			title : "设置分类",
			buttons : {
				"关闭" : true
			},
			submit : function() {
			}
		});
		$("#categoryBoxId").val(id);
		$("#categoryBoxCategory").val(category);
	}
</script>
<script type="text/template" id="categoryBox">
		<form id="categoryForm" action="${ctx}/act/process/updateCategory" method="post" enctype="multipart/form-data"
			style="text-align:center;" class="form-search" onsubmit="loading('正在设置，请稍等...');"><br/>
			<input id="categoryBoxId" type="hidden" name="procDefId" value="" />
			<select id="categoryBoxCategory" name="category">
				<c:forEach items="${fns:getDictList('act_category')}" var="dict">
					<option value="${dict.value}">${dict.label}</option>
				</c:forEach>
			</select>
			<br/><br/>　　
			<input id="categorySubmit" class="btn btn-primary" type="submit" value="   保    存   "/>　　
		</form>
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>流程管理列表</h5>
				<div class="ibox-tools">
					<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
					</a> <a class="dropdown-toggle" data-toggle="dropdown" href="#"> <i
						class="fa fa-wrench"></i>
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

				<div class="row">
					<div class="col-sm-12">
						<form id="searchForm" action="${ctx}/act/process/"
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

				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12">
						<div class="pull-left">
							<shiro:hasPermission name="act:process:add">
								<button href="#"
									onclick="openDialog('流程部署','${ctx}/act/process/deploy/','50%','50%')"
									class="btn btn-white btn-sm " data-toggle="tooltip"
									data-placement="left">
									<i class="fa fa-plus"></i>部署流程
								</button>
							</shiro:hasPermission>
							<%-- <shiro:hasPermission name="oa:process:del"> --%>
							<table:delRow url="${ctx}/oa/process/deleteAll" id="contentTable"></table:delRow>
							<!-- 删除按钮 -->
							<%-- </shiro:hasPermission> --%>
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
							<th>流程ID</th>
							<th>流程标识</th>
							<th>流程名称</th>
							<th>流程版本</th>
							<th>流程XML</th>
							<th>流程图片</th>
							<th>部署时间</th>
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
								<td><a
									href="javascript:updateCategory('${process.id}', '${process.category}')">${fns:getDictLabel(process.category,'act_category','无分类')}</a></td>
								<td>${process.id}</td>
								<td>${process.key}</td>
								<td>${process.name}</td>
								<td><b title='流程版本号'>V: ${process.version}</b></td>
								<td><a target="_blank"
									href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=xml">${process.resourceName}</a></td>
								<td><a target="_blank"
									href="${ctx}/act/process/resource/read?procDefId=${process.id}&resType=image">${process.diagramResourceName}</a></td>
								<td><fmt:formatDate value="${deployment.deploymentTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><c:if test="${process.suspended}">
										<a
											href="${ctx}/act/process/update/active?procDefId=${process.id}"
											onclick="return confirmx('确认要挂起吗？', this.href)"
											class="btn btn-info btn-xs"><i class="fa fa-search-plus"></i>
											激活</a>

									</c:if> <c:if test="${!process.suspended}">
										<a
											href="${ctx}/act/process/update/suspend?procDefId=${process.id}"
											onclick="return confirmx('确认要挂起吗？', this.href)"
											class="btn btn-success btn-xs"><i class="fa fa-edit"></i>
											挂起</a>

									</c:if> <%-- <shiro:hasPermission name="oa:oaNotify:del"> --%> <a
									href="${ctx}/act/process/delete?deploymentId=${process.deploymentId}"
									onclick="return confirmx('确认要删除该通知吗？', this.href)"
									class="btn btn-danger btn-xs"><i class="fa fa-trash"></i>删除</a>
									<%-- </shiro:hasPermission> --%></td>
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
