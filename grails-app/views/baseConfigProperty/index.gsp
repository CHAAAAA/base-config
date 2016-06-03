<%@ page import="base.config.BaseConfigHolder" %>
<!DOCTYPE html>
<html>
<head>
    <theme:layout name="dataentry"/>
    <g:set var="entityName" value="${message(code: 'baseConfigHolder.label', default: 'BaseConfigHolder')}"/>
    <theme:title><g:message code="default.list.label" args="[entityName]" default="List"/></theme:title>
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
            <strong><g:message code="default.list.label" args="[entityName]"/></strong>
        </li>
    </ol>
</theme:zone>
<theme:zone name="header-actions">

</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
        <ui:displayMessage/>
        <g:render template="searchHolder"/>
        <ui:table class="table-bordered table-hover data-box">
            <thead>
            <ui:tr>
                <ui:th class="col-xs-3">
                    <g:message code="baseConfigHolder.holderName.label" default="Holder Name"/>
                </ui:th>

                <ui:th class="col-xs-7">
                    <g:message code="baseConfigHolder.holderBeanName.label" default="Holder BeanName"/>
                </ui:th>

                <ui:th class="col-xs-2">
                    <g:message code="default.operation.label" default="Operation"/>
                </ui:th>
            </ui:tr>
            </thead>
            <tbody>
            <g:each in="${baseConfigHolderInstanceList}" status="i" var="baseConfigHolderInstance">
                <ui:tr>
                    <td>
                        ${baseConfigHolderInstance?.holderName}
                    </td>
                    <td>
                        ${baseConfigHolderInstance?.holderBeanName}
                    </td>

                    <td>
                        <ui:button kind="anchor" mode="success" class="btn-xs" action="propertyList"
                                   id="${baseConfigHolderInstance.id}">
                            <i class="fa fa-gears"></i>
                            <g:message code="default.button.manage.label" default="Manage"/>
                        </ui:button>
                    </td>
                </ui:tr>
            </g:each>
            </tbody>
        </ui:table>
        <div class="pull-right">
            <ui:paginate total="${baseConfigHolderInstanceCount ?: 0}" params="${params}"/>
        </div>
    </div>
</theme:zone>
</body>
</html>
