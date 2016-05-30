<!DOCTYPE html>
<html>
<head>
    <theme:layout name="dataentry"/>
    <g:set var="entityName" value="${message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty')}"/>
    <theme:title><g:message code="default.create.label" args="[entityName]"/></theme:title>
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
            <strong><g:message code="default.create.label" args="[entityName]"/></strong>
        </li>
    </ol>
</theme:zone>
<theme:zone name="header-actions">
    <ui:button kind="anchor" mode="default" action="index">
        <i class="fa fa-arrow-circle-o-left"></i>
        <g:message code="default.button.return.label" default="Return"/>
    </ui:button>
</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
        <ui:displayMessage/>
        <ui:block title="${message(code: 'default.create.label', args: [entityName])}">
            <ui:form action="save">
                <fieldset>
                    <f:all bean="baseConfigPropertyInstance" except="configHolder"/>
                </fieldset>

                <g:if test="${holderList && holderList.size() > 0}">
                    <div class="form-group ">

                        <label class="col-sm-2 control-label">
                            <g:message code="baseConfigProperty.configHolder.label" default="ConfigHolder"/>
                        </label>

                        <div class="col-sm-5">
                            <select class="form-control m-b" name="holder">
                                <g:if test="${params?.holder}">
                                    <option value="${-1}">
                                        <g:message code="baseConfigProperty.select.label" default="SELECT"/>
                                    </option>
                                </g:if>
                                <g:else>
                                    <option value="${-1}" selected>
                                        <g:message code="baseConfigProperty.select.label" default="SELECT"/>
                                    </option>
                                </g:else>

                                <g:each in="${holderList}" var="bch">
                                    <g:if test="${params?.holder == bch?.id}">
                                        <option value="${bch?.id}" selected>${bch?.holderName}</option>
                                    </g:if>
                                    <g:else>
                                        <option value="${bch?.id}">${bch?.holderName}</option>
                                    </g:else>
                                </g:each>
                            </select>
                        </div>

                    </div>
                </g:if>

                <div class="hr-line-dashed"></div>
                <ui:actions>
                    <ui:button kind="button" mode="primary">
                        <i class="fa fa-check-circle"></i>
                        <g:message code="default.button.create.label" default="Create"/>
                    </ui:button>
                </ui:actions>
            </ui:form>
        </ui:block>
    </div>
</theme:zone>
</body>
</html>
