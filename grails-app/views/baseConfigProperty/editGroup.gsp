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
                                    </a>
                                </li>
                            </g:if>
                            <g:else>
                                <li>
                                    <a data-toggle="tab" href="${'#' + config.key}" aria-expanded="true">
                                        <i class="fa fa-gear"></i>
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
                <g:each in="${groupConfigList}" var="config">
                    <g:if test="${config.key != 'defaultValue'}">
                        <g:if test="${config.key == defaultValue}">
                            <div id="${config.key}" class="tab-pane active">
                        </g:if>
                        <g:else>
                            <div id="${config.key}" class="tab-pane">
                        </g:else>
                        <strong>One morning, when Gregor Samsa.</strong>

                        <p>
                            <g:each in="${config.value}" var="set">
                                ${set.key}
                                <g:each in="${set.value}" var="configItem">
                                    ${configItem.key}
                                </g:each>
                            </g:each>
                        </p>

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
