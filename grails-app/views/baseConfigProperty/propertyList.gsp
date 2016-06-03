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
    <ui:button kind="button" mode="danger" id="delete-button">
        <i class="fa fa-trash"></i>
        <g:message code="default.button.delete.label" default="Delete"/>
    </ui:button>
</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
        <ui:displayMessage/>
        <g:render template="searchProperty"/>
        <ui:table class="table-bordered table-hover data-box">
            <thead>
            <ui:tr>
                <ui:th class="col-xs-1">
                    <g:message code="baseConfigProperty.name.label" default="Name"/>
                </ui:th>
                <th class="col-xs-3">
                    <g:message code="baseConfigProperty.customKey.label"/>
                </th>

                <th class="col-xs-3">
                    <g:message code="baseConfigProperty.customValue.label"/>
                </th>
                <ui:th class="col-xs-1">
                    <g:message code="baseConfigProperty.configType.label" default="Config Type"/>
                </ui:th>
                <ui:th class="col-xs-2">
                    <g:message code="default.operation.label" default="Operation"/>
                </ui:th>
            </ui:tr>
            </thead>
            <tbody>
            <g:each in="${baseConfigPropertyInstanceList}" status="i" var="baseConfigPropertyInstance">
                <ui:tr>
                    <td><f:display bean="${baseConfigPropertyInstance}" property="name"/></td>
                    <td><f:display bean="${baseConfigPropertyInstance}" property="customKey"/></td>
                    <td>
                        <baseConfig:showConfigValue configProperty="${baseConfigPropertyInstance}"/>
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
<theme:zone name="modal">
    <div class="modal inmodal fade" id="deleteModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <ui:button kind="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </ui:button>
                    <i class="fa fa-warning fa-5x"></i>
                    <h4 class="modal-title"><g:message code="default.button.delete.confirm.message"
                                                       default="Are you sure?"/></h4>
                </div>

                <div class="modal-body">
                    <p><strong><g:message code="modal.body.delete.message"/></strong></p>
                </div>

                <div class="modal-footer">
                    <ui:form action="deleteHolder" id="${baseConfigHolder?.id}" method="DELETE">
                        <ui:button kind="button" mode="default" data-dismiss="modal"><g:message
                                code="default.button.cancle.label" default="Cancle"/></ui:button>

                        <ui:button kind="button" mode="primary"><g:message code="default.button.delete.label"
                                                                           default="Delete"/></ui:button>
                    </ui:form>
                </div>
            </div>
        </div>
    </div>
</theme:zone>
</body>
</html>
