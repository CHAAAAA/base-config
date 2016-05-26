<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry" />
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<theme:title><g:message code="default.show.label" args="[entityName]" /></theme:title>
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
					<strong><g:message code="default.show.label" args="[entityName]" /></strong>
				</li>
			</ol>
		</theme:zone>
		<theme:zone name="header-actions">
			<ui:button kind="anchor" mode="primary" action="edit" id="\${${propertyName}Instance?.id}">
				<i class="fa fa-edit"></i>
				<g:message code="default.button.edit.label" default="Edit" />
			</ui:button>

			<ui:button kind="button" mode="danger" id="delete-button">
				<i class="fa fa-trash"></i>
				<g:message code="default.button.delete.label" default="Delete" />
			</ui:button>

			<ui:button kind="anchor" mode="default" action="index">
				<i class="fa fa-arrow-circle-o-left"></i>
				<g:message code="default.button.return.label" default="Return" />
			</ui:button>
		</theme:zone>

		<theme:zone name="content">
			<div class="col-lg-12">
				<ui:displayMessage />
				<ui:block title="\${message(code: 'default.show.label', args: [entityName])}">
					<dl class="dl-horizontal"> <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'; allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'; props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }; Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[])); props.each { p -> if (p.type == Boolean) {%>
						<dt><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></dt>
						<dd><f:display bean="\${${propertyName}Instance}" property="${p.name}" /></dd>
						<div class="hr-line-dashed"></div> <% } else {%>
						<g:if test="\${${propertyName}Instance?.${p.name}}">
							<dt><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></dt> <%  if (p.isEnum()) { %>
							<dd><g:fieldValue bean="\${${propertyName}}Instance" field="${p.name}"/></dd> <%  } else if (p.oneToMany || p.manyToMany) { %>
							<g:each in="\${${propertyName}Instance.${p.name}}" var="${p.name[0]}">
								<dd><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></dd>
							</g:each> <%  } else if (p.manyToOne || p.oneToOne) { %>
							<dd><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}Instance?.${p.name}?.id}"><f:display bean="\${${propertyName}}Instance" property="${p.name}" /></g:link></dd> <%  } else if (p.type == Boolean || p.type == boolean) { %>
							<dd><f:display bean="\${${propertyName}Instance}" property="${p.name}" /></dd> <%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
							<dd><g:formatDate date="\${${propertyName}Instance?.${p.name}}" format="yyyy-MM-dd HH:mm:ss"/></dd> <%  } else if (!p.type.isArray()) { %>
							<dd><f:display bean="\${${propertyName}Instance}" property="${p.name}" /></dd> <%  } %>
							<div class="hr-line-dashed"></div>
						</g:if> <% } } %>
					</dl>
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