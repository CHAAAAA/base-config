<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<theme:layout name="dataentry" />
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<theme:title><g:message code="default.list.label" args="[entityName]" default="List"/></theme:title>
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
					<strong><g:message code="default.list.label" args="[entityName]" /></strong>
				</li>
			</ol>
		</theme:zone>
		<theme:zone name="header-actions">
			<ui:button kind="anchor" mode="primary" action="create">
				<i class="fa fa-plus-circle"></i>
				<g:message code="default.button.create.label" default="Create" />
			</ui:button>
		</theme:zone>

		<theme:zone name="content">
			<div class="col-lg-12">
				<ui:displayMessage />
				<ui:table class="table-bordered table-hover data-box">
					<thead>
					<ui:tr> <% excludedProps = Event.allEvents.toList() << 'id' << 'version'; allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'; props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }; Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[])); props.eachWithIndex { p, i -> if (i < 100) {if (p.isAssociation()) { %>
						<ui:th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></ui:th> <% } else { %>
						<g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" /> <% } } } %>
						<ui:th><g:message code="default.operation.label" default="Operation" /></ui:th>
					</ui:tr>
					</thead>
					<tbody>
					<g:each in="\${${propertyName}InstanceList}" status="i" var="${propertyName}Instance">
						<ui:tr> <% props.eachWithIndex { p, i -> if (i < 100) { if (p.type == Boolean || p.type == boolean) { %>
							<td><f:display bean="\${${propertyName}Instance}" property="${p.name}"/></td> <% } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
							<td><g:formatDate date="\${${propertyName}Instance.${p.name}}" format="yyyy-MM-dd HH:mm:ss"/></td> <% } else { %>
							<td><f:display bean="\${${propertyName}Instance}" property="${p.name}" /></td> <% } } } %>
							<td>
								<ui:button kind="anchor" mode="info" class="btn-xs" action="show" id="\${${propertyName}Instance.id}">
									<i class="fa fa-info-circle"></i>
									<g:message code="default.button.show.label" default="Show" />
								</ui:button>
								<ui:button kind="anchor" mode="success" class="btn-xs" action="edit" id="\${${propertyName}Instance.id}">
									<i class="fa fa-edit"></i>
									<g:message code="default.button.edit.label" default="Edit" />
								</ui:button>
							</td>
						</ui:tr>
					</g:each>
					</tbody>
				</ui:table>
				<div class="pull-right">
					<ui:paginate total="\${${propertyName}Count ?: 0}" params="\${params}"/>
				</div>
			</div>
		</theme:zone>
	</body>
</html>
