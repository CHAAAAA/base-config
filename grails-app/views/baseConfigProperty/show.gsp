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
            <g:link action="propertyList" id="${baseConfigPropertyInstance?.configHolder?.id}">${entityName}</g:link>
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

    <ui:button kind="anchor" mode="default" action="propertyList" id="${baseConfigPropertyInstance?.configHolder?.id}">
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

</body>
</html>
