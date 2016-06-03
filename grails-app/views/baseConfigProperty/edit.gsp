<%@ page import="base.config.BaseConfigProperty" %>
<!DOCTYPE html>
<html>
<head>
    <theme:layout name="dataentry"/>
    <g:set var="entityName" value="${message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty')}"/>
    <theme:title><g:message code="default.edit.label" args="[entityName]"/></theme:title>
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
            <strong><g:message code="default.edit.label" args="[entityName]"/></strong>
        </li>
    </ol>
</theme:zone>
<theme:zone name="header-actions">
    <g:link class="btn btn-default" action="propertyList" id="${baseConfigPropertyInstance?.configHolder?.id}">
        <i class="fa fa-arrow-circle-o-left"></i>
        <g:message code="default.button.return.label" default="Return"/>
    </g:link>
</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
        <ui:displayMessage/>
        <ui:block title="${baseConfigPropertyInstance?.configHolder?.holderName}">
            <ui:form action="update" id="${baseConfigPropertyInstance?.id}" method="PUT">
                <g:hiddenField name="version" value="${baseConfigPropertyInstance?.version}"/>
                <fieldset>
                    <f:all bean="baseConfigPropertyInstance" except="configHolder,configType,customValue"/>
                </fieldset>

                <div class="form-group ">
                    <label class="col-sm-2 control-label">
                        <g:message code="baseConfigProperty.customValue.label"/>
                    </label>

                    <div class="col-sm-5">

                        <baseConfig:editConfigValue configProperty="${baseConfigPropertyInstance}"/>
                    </div>
                </div>

                <div class="form-group ">
                    <label class="col-sm-2 control-label">
                        <g:message code="baseConfigProperty.configType.label"/>
                    </label>

                    <div class="col-sm-5">

                        <g:if test="${baseConfigPropertyInstance?.configType == base.config.ConfigType.GROUP}">
                            <span class="label">GROUP</span>
                            <input value="${baseConfigPropertyInstance?.configType}" name="configType"
                                   style="visibility: hidden">
                        </g:if>
                        <g:elseif test="${baseConfigPropertyInstance?.configType == base.config.ConfigType.BOOLEAN}">
                            <span class="label">BOOLEAN</span>
                            <input value="${baseConfigPropertyInstance?.configType}" name="configType"
                                   style="visibility: hidden">
                        </g:elseif>
                        <g:else>
                            <select class="form-control m-b" name="configType">
                                <g:each in="${base.config.ConfigType}" var="ct">
                                    <g:if test="${baseConfigPropertyInstance?.configType == ct}">
                                        <option selected value="${ct}">${ct}</option>
                                    </g:if>
                                    <g:elseif
                                            test="${ct != base.config.ConfigType.GROUP && ct != base.config.ConfigType.BOOLEAN}">
                                        <option value="${ct}">${ct}</option>
                                    </g:elseif>
                                </g:each>
                            </select>
                        </g:else>
                    </div>
                </div>

                <div class="hr-line-dashed"></div>

                <ui:actions>
                    <ui:button kind="button" mode="primary">
                        <i class="fa fa-arrow-circle-o-up"></i>
                        <g:message code="default.button.update.label" default="Update"/>
                    </ui:button>

                    <g:link action="editGroup" class="btn btn-default" id="${baseConfigPropertyInstance?.id}">
                        <i class="fa fa-edit"></i>
                        <g:message code="baseConfigProperty.button.editgroup.label" default="Edit Group"/>
                    </g:link>

                </ui:actions>
            </ui:form>
        </ui:block>
    </div>
</theme:zone>
</body>
</html>
