<%@ page import="base.config.BaseConfigProperty" %>
<!DOCTYPE html>
<html>
<head>
    <theme:layout name="dataentry"/>
    <g:set var="entityName" value="${message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty')}"/>
    <theme:title><g:message code="default.show.label" args="[entityName]"/></theme:title>
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
<<<<<<< HEAD
            <g:link action="propertyList" id="${baseConfigPropertyInstance?.configHolder?.id}">${entityName}</g:link>
=======
            <g:link action="index">${entityName}</g:link>
>>>>>>> af514f94ef5b264abce1b25d2159395ad232520c
        </li>
        <li class="active">
            <strong><g:message code="default.show.label" args="[entityName]"/></strong>
        </li>
    </ol>
</theme:zone>
<theme:zone name="header-actions">
    <ui:button kind="anchor" mode="primary" action="edit" id="${baseConfigPropertyInstance?.id}">
        <i class="fa fa-edit"></i>
        <g:message code="default.button.edit.label" default="Edit"/>
    </ui:button>

<<<<<<< HEAD
    <ui:button kind="anchor" mode="default" action="propertyList" id="${baseConfigPropertyInstance?.configHolder?.id}">
=======
    <ui:button kind="button" mode="danger" id="delete-button">
        <i class="fa fa-trash"></i>
        <g:message code="default.button.delete.label" default="Delete"/>
    </ui:button>

    <ui:button kind="anchor" mode="default" action="index">
>>>>>>> af514f94ef5b264abce1b25d2159395ad232520c
        <i class="fa fa-arrow-circle-o-left"></i>
        <g:message code="default.button.return.label" default="Return"/>
    </ui:button>
</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
        <ui:displayMessage/>
        <ui:block title="${message(code: 'default.show.label', args: [entityName])}">
            <dl class="dl-horizontal">
                <g:if test="${baseConfigPropertyInstance?.configHolder}">
                    <dt><g:message code="baseConfigProperty.configHolder.label" default="Config Holder"/></dt>
                    <dd>
                        ${baseConfigPropertyInstance?.configHolder}
                    </dd>

                    <div class="hr-line-dashed"></div>
                </g:if>
                <g:if test="${baseConfigPropertyInstance?.configType}">
                    <dt><g:message code="baseConfigProperty.configType.label" default="Config Type"/></dt>
                    <dd>${baseConfigPropertyInstance?.configType}</dd>

                    <div class="hr-line-dashed"></div>
                </g:if>
                <g:if test="${baseConfigPropertyInstance?.customKey}">
                    <dt><g:message code="baseConfigProperty.customKey.label" default="Custom Key"/></dt>
                    <dd><f:display bean="${baseConfigPropertyInstance}" property="customKey"/></dd>
<<<<<<< HEAD

                    <div class="hr-line-dashed"></div>
                </g:if>
                <g:if test="${baseConfigPropertyInstance?.customValue}">
                    <dt><g:message code="baseConfigProperty.customValue.label" default="Custom Value"/></dt>
                    <dd>
                        <baseConfig:showConfigValue configProperty="${baseConfigPropertyInstance}"/>
                    </dd>

                    <div class="hr-line-dashed"></div>
                </g:if>
                <g:if test="${baseConfigPropertyInstance?.description}">
                    <dt><g:message code="baseConfigProperty.description.label" default="Description"/></dt>
                    <dd><f:display bean="${baseConfigPropertyInstance}" property="description"/></dd>

                    <div class="hr-line-dashed"></div>
                </g:if>
            </dl>
        </ui:block>
    </div>
</theme:zone>

=======

                    <div class="hr-line-dashed"></div>
                </g:if>
                <g:if test="${baseConfigPropertyInstance?.customValue}">
                    <dt><g:message code="baseConfigProperty.customValue.label" default="Custom Value"/></dt>
                    <dd><f:display bean="${baseConfigPropertyInstance}" property="customValue"/></dd>

                    <div class="hr-line-dashed"></div>
                </g:if>
                <g:if test="${baseConfigPropertyInstance?.description}">
                    <dt><g:message code="baseConfigProperty.description.label" default="Description"/></dt>
                    <dd><f:display bean="${baseConfigPropertyInstance}" property="description"/></dd>

                    <div class="hr-line-dashed"></div>
                </g:if>
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
                    <h4 class="modal-title"><g:message code="default.button.delete.confirm.message"
                                                       default="Are you sure?"/></h4>
                </div>

                <div class="modal-body">
                    <p><strong><g:message code="modal.body.delete.message"/></strong></p>
                </div>

                <div class="modal-footer">
                    <ui:form action="delete" id="${baseConfigPropertyInstance?.id}" method="DELETE">
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
>>>>>>> af514f94ef5b264abce1b25d2159395ad232520c
</body>
</html>
