<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry" />
		<g:set var="entityName" value="${message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty')}" />
		<theme:title><g:message code="default.create.label" args="[entityName]" /></theme:title>
	</head>
	<body>
		<theme:zone name="content-header">
			<h2>${entityName}</h2>
		</theme:zone>
		<theme:zone name="breadcrumb">
			<ol class="breadcrumb">
				<li>
					<a href="${createLink(uri: '/')}"><g:message code="default.home.label" default="Home"/></a>
				</li>
				<li>
					<g:link action="index">${entityName}</g:link>
				</li>
				<li class="active">
					<strong><g:message code="default.create.label" args="[entityName]" /></strong>
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
				<ui:block title="${message(code: 'default.create.label', args: [entityName])}">
					<ui:form action="save" >
						<fieldset>
							<f:all bean="baseConfigPropertyInstance"/>
						</fieldset>
						<div class="hr-line-dashed"></div>
						<ui:actions>
							<ui:button kind="button" mode="primary">
								<i class="fa fa-check-circle"></i>
								<g:message code="default.button.create.label" default="Create" />
							</ui:button>
						</ui:actions>
					</ui:form>
				</ui:block>
			</div>
		</theme:zone>
	</body>
</html>
