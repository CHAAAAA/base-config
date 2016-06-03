<%@ page import="base.config.BaseConfigProperty" %>
<!DOCTYPE html>
<html>
<head>
    <theme:layout name="dataentry"/>
    <g:set var="entityName" value="${message(code: 'baseConfigProperty.group.label', default: 'Group')}"/>
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
            <g:link action="edit" id="${baseConfigPropertyInstance?.id}">${entityName}</g:link>
        </li>
        <li class="active">
            <strong><g:message code="default.edit.label" args="[entityName]"/></strong>
        </li>
    </ol>
</theme:zone>
<theme:zone name="header-actions">
    <g:link class="btn btn-default" action="edit" id="${baseConfigPropertyInstance?.id}">
        <i class="fa fa-arrow-circle-o-left"></i>
        <g:message code="default.button.return.label" default="Return"/>
    </g:link>
</theme:zone>

<theme:zone name="content">
    <div class="col-lg-12">
    <ui:displayMessage/>

    <g:set var="defaultValue" value="${groupConfigList['defaultValue']}"/>
    <div class="panel blank-panel">

        <div class="panel-heading">
            <div class="panel-title m-b-md"><h4>${baseConfigPropertyInstance?.name}</h4></div>

            <div class="panel-options">

                <ul class="nav nav-tabs">
                    <g:each in="${groupConfigList}" var="config">

                        <g:if test="${config.key != 'defaultValue'}">
                            <g:if test="${config.key == defaultValue}">
                                <li class="active">
                                    <a data-toggle="tab" href="${'#' + config.key}" aria-expanded="true">
                                        <i class="fa fa-gear"></i>
                                        ${config.key}
                                    </a>
                                </li>
                            </g:if>
                            <g:else>
                                <li>
                                    <a data-toggle="tab" href="${'#' + config.key}" aria-expanded="true">
                                        <i class="fa fa-gear"></i>
                                        ${config.key}
                                    </a>
                                </li>
                            </g:else>
                        </g:if>
                    </g:each>

                </ul>
            </div>
        </div>

        <div class="panel-body">
            <div class="tab-content">
                <g:each in="${groupConfigList}" var="configSet">
                    <g:if test="${configSet.key != 'defaultValue'}">
                        <g:if test="${configSet.key == defaultValue}">
                            <div id="${configSet.key}" class="tab-pane active">
                        </g:if>
                        <g:else>
                            <div id="${configSet.key}" class="tab-pane">
                        </g:else>

                        <g:each in="${configSet.value}" var="config">

                            <ui:block>
                                <ui:form action="updateGroup" method="PUT" id="${baseConfigPropertyInstance?.id}">

                                    <input value="${configSet.key}" name="groupname" style="visibility: hidden">
                                    <input value="${config.key}" name="setname" style="visibility: hidden">

                                    <g:each in="${config.value}" var="configItem">

                                        <div class="form-group ">
                                            <label class="col-sm-2 control-label">
                                                ${configItem.key}
                                            </label>

                                            <div class="col-sm-5">
                                                <g:if test="${configItem.key == 'key'}">
                                                    <span class="label">${configItem.value}</span>
                                                    <input value="${configItem.value}" name="configkey"
                                                           style="visibility: hidden">
                                                </g:if>
                                                <g:elseif test="${configItem.key == 'type'}">
                                                    <span class="label">${configItem.value}</span>
                                                    <input value="${configItem.value}" name="configtype"
                                                           style="visibility: hidden">
                                                </g:elseif>
                                                <g:else>%{--配置值的显示--}%
                                                    <g:if test="${config.value['type'] == 'BOOLEAN'}">
                                                        <select class="form-control m-b" name="configvalue">
                                                            <g:if test="${configItem.value == 'true'}">
                                                                <option value="true" selected>TRUE</option>
                                                                <option value="false">FALSE</option>
                                                            </g:if>
                                                            <g:else>
                                                                <option value="true">TRUE</option>
                                                                <option value="false" selected>FALSE</option>
                                                            </g:else>
                                                        </select>
                                                    </g:if>
                                                    <g:else>
                                                        <input value="${configItem.value}" name="configvalue"
                                                               class="form-control">
                                                    </g:else>
                                                </g:else>
                                            </div>
                                        </div>

                                    </g:each>

                                    <div class="hr-line-dashed"></div>
                                    <ui:actions>
                                        <ui:button kind="button" mode="primary">
                                            <i class="fa fa-arrow-circle-o-up"></i>
                                            <g:message code="default.button.update.label" default="Update"/>
                                        </ui:button>

                                    </ui:actions>
                                </ui:form>
                            </ui:block>

                        </g:each>
                        </div>
                    </g:if>
                </g:each>
            </div>
            </div>
        </div>
    </div>
</theme:zone>
</body>
</html>
