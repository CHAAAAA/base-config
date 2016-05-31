<%@ page import="base.config.BaseConfigProperty" %>
<!DOCTYPE html>
<html>
<head>
    <theme:layout name="dataentry"/>
    <g:set var="entityName" value="${message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty')}"/>
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
            <g:link action="index">${message(code: 'baseConfigHolder.label')}</g:link>
        </li>
        <li class="active">
            <strong><g:message code="default.list.label" args="[entityName]"/></strong>
        </li>
    </ol>
</theme:zone>
<theme:zone name="header-actions">
    <ui:button kind="anchor" mode="primary" action="create">
        <i class="fa fa-plus-circle"></i>
        <g:message code="default.button.create.label" default="Create"/>
    </ui:button>
</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
        <ui:displayMessage/>
        <g:render template="searchProperty"/>
        <ui:table class="table-bordered table-hover data-box">
            <thead>
            <ui:tr>
                <ui:th><g:message code="baseConfigProperty.configHolder.label" default="Config Holder"/></ui:th>
                <g:sortableColumn property="customKey"
                                  title="${message(code: 'baseConfigProperty.customKey.label', default: 'Custom Key')}"/>
                <g:sortableColumn property="customValue"
                                  title="${message(code: 'baseConfigProperty.customValue.label', default: 'Custom Value')}"/>
                <ui:th>
                    <g:message code="baseConfigProperty.configType.label" default="Config Type"/>
                </ui:th>
                <ui:th><g:message code="default.operation.label" default="Operation"/></ui:th>
            </ui:tr>
            </thead>
            <tbody>
            <g:each in="${baseConfigPropertyInstanceList}" status="i" var="baseConfigPropertyInstance">
                <ui:tr>
                    <td><f:display bean="${baseConfigPropertyInstance}" property="configHolder"/></td>
                    <td><f:display bean="${baseConfigPropertyInstance}" property="customKey"/></td>
                    <td>
                        <f:display bean="${baseConfigPropertyInstance}" property="customValue"/>
                    </td>
                    <td>
                        <span class="badge badge-info">
                            ${baseConfigPropertyInstance?.configType}
                        </span>
                    </td>
                    <td>
                        <ui:button kind="anchor" mode="info" class="btn-xs" action="show"
                                   id="${baseConfigPropertyInstance.id}">
                            <i class="fa fa-info-circle"></i>
                            <g:message code="default.button.show.label" default="Show"/>
                        </ui:button>
                        <ui:button kind="anchor" mode="success" class="btn-xs" action="edit"
                                   id="${baseConfigPropertyInstance.id}">
                            <i class="fa fa-edit"></i>
                            <g:message code="default.button.edit.label" default="Edit"/>
                        </ui:button>
                    </td>
                </ui:tr>
            </g:each>
            </tbody>
        </ui:table>
        <div class="pull-right">
            <ui:paginate total="${baseConfigPropertyCount ?: 0}" params="${params}"/>
        </div>
    </div>
</theme:zone>
</body>
</html>
