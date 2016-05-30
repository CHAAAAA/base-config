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
            <g:link action="index">${entityName}</g:link>
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
        <ui:table class="table-bordered table-hover data-box">
            <thead>
            <ui:tr>
                <th>
                    <g:message code="baseConfigProperty.type.label" default="Type"/>
                </th>
                <th>
                    ${message(code: 'baseConfigProperty.customKey.label', default: 'Custom Key')}
                </th>
                <th>
                    ${message(code: 'baseConfigProperty.customValue.label', default: 'Custom Value')}
                </th>
                <th>
                    <g:message code="default.operation.label" default="Operation"/>
                </th>
            </ui:tr>
            </thead>
            <tbody>
            <g:each in="${normalConfigProperties}" status="i" var="normalConfigProperty">
                <ui:tr>
                    <td class="col-xs-1">
                        <g:if test="${normalConfigProperty?.isInDb}">
                            <i class="fa fa-database"></i>
                            <span class="label label-info">
                                DB
                            </span>
                        </g:if>
                        <g:else>
                            <i class="fa fa-file-text"></i>
                            <span class="label label-plain">
                                FILE
                            </span>
                        </g:else>
                    </td>
                    <td class="col-xs-4">${normalConfigProperty?.configKey}</td>
                    <td class="col-xs-4">${normalConfigProperty?.configValue}</td>
                    <td class="col-xs-3">
                        <g:if test="${normalConfigProperty?.isInDb}">
                            <g:link action="edit" id="${normalConfigProperty?.dbId}"
                                    class="btn btn-primary btn-xs">
                                <i class="fa fa-edit"></i>
                                <g:message code="default.button.edit.label" default="Edit"/>
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link class="btn btn-primary btn-xs" action="create"
                                    params="${[customKey: normalConfigProperty?.configKey]}">
                                <i class="fa fa-paste"></i>
                                <g:message code="default.button.overwrite.label" default="Overwrite"/>
                            </g:link>
                        </g:else>
                    </td>
                </ui:tr>
            </g:each>
            </tbody>
        </ui:table>
        <div class="pull-right">
            <ui:paginate total="${normalConfigPropertiesTotalSum ?: 0}" params="${params}"/>
        </div>
    </div>
</theme:zone>
</body>
</html>
