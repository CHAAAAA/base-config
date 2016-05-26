<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry" />
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<theme:title><g:message code="default.edit.label" args="[entityName]" /></theme:title>
	</head>
	<body>
		<theme:zone name="content-header">
			<h2>\${entityName}</h2>
		</theme:zone>
		<theme:zone name="breadcrumb">
			<ol class="breadcrumb">
				<li>
					<a href="\${createLink(uri: '/')}"><g:message code="default.home.label" default="Home"/></a>
				</li>
				<li>
					<g:link action="index">\${entityName}</g:link>
				</li>
				<li class="active">
					<strong><g:message code="default.edit.label" args="[entityName]" /></strong>
				</li>
			</ol>
		</theme:zone>
		<theme:zone name="header-actions">
			<ui:button kind="anchor" mode="default" action="index">
				<i class="fa fa-arrow-circle-o-left"></i>
				<g:message code="default.button.return.label" default="Return" />
			</ui:button>
		</theme:zone>

		<theme:zone name="content">
			<div class="col-lg-12">
				<ui:displayMessage />
				<ui:block title="\${message(code: 'default.edit.label', args: [entityName])}">
					<ui:form action="update" id="\${${propertyName}Instance?.id}" method="PUT" <%= multiPart ? ' enctype="multipart/form-data"' : '' %>>
						<g:hiddenField name="version" value="\${${propertyName}Instance?.version}" />
						<fieldset>
							<f:all bean="${propertyName}Instance"/>
						</fieldset>
						<ui:actions>
							<ui:button kind="button" mode="primary">
								<i class="fa fa-arrow-circle-o-up"></i>
								<g:message code="default.button.update.label" default="Update" />
							</ui:button>

							<ui:button kind="button" mode="danger" id="delete-button">
								<i class="fa fa-trash"></i>
								<g:message code="default.button.delete.label" default="Delete" />
							</ui:button>
						</ui:actions>
					</ui:form>
				</ui:block>
			</div>
		</theme:zone>
		<theme:zone name="modal">
			<div class="modal inmodal fade" id="deleteModal" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<ui:button kind="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</ui:button>
							<i class="fa fa-warning fa-5x"></i>
							<h4 class="modal-title"><g:message code="default.button.delete.confirm.message" default="Are you sure?"/></h4>
						</div>
						<div class="modal-body">
							<p><strong><g:message code="modal.body.delete.message"/></strong></p>
						</div>
						<div class="modal-footer">
							<ui:form action="delete" id="\${${propertyName}Instance?.id}" method="DELETE" >
								<ui:button kind="button" mode="default" data-dismiss="modal"><g:message code="default.button.cancle.label" default="Cancle"/></ui:button>
								<ui:button kind="button" mode="primary"><g:message code="default.button.delete.label" default="Delete"/></ui:button>
							</ui:form>
						</div>
					</div>
				</div>
			</div>
		</theme:zone>
	</body>
</html>
