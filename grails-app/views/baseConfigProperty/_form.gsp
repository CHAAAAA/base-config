<%@ page import="base.config.BaseConfigProperty" %>



<div class="fieldcontain ${hasErrors(bean: baseConfigProperty, field: 'configHolder', 'error')} ">
	<label for="configHolder">
		<g:message code="baseConfigProperty.configHolder.label" default="Config Holder" />
		
	</label>
	<g:select id="configHolder" name="configHolder.id" from="${base.config.BaseConfigHolder.list()}" optionKey="id" required="" value="${baseConfigProperty?.configHolder?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: baseConfigProperty, field: 'configType', 'error')} ">
	<label for="configType">
		<g:message code="baseConfigProperty.configType.label" default="Config Type" />
		
	</label>
	<g:select name="configType" from="${base.config.ConfigType?.values()}" keys="${base.config.ConfigType.values()*.name()}" required="" value="${baseConfigProperty?.configType?.name()}" />

</div>

<div class="fieldcontain ${hasErrors(bean: baseConfigProperty, field: 'customKey', 'error')} ">
	<label for="customKey">
		<g:message code="baseConfigProperty.customKey.label" default="Custom Key" />
		
	</label>
	<g:textField name="customKey" value="${baseConfigProperty?.customKey}" />

</div>

<div class="fieldcontain ${hasErrors(bean: baseConfigProperty, field: 'customValue', 'error')} ">
	<label for="customValue">
		<g:message code="baseConfigProperty.customValue.label" default="Custom Value" />
		
	</label>
	<g:textField name="customValue" value="${baseConfigProperty?.customValue}" />

</div>

<div class="fieldcontain ${hasErrors(bean: baseConfigProperty, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="baseConfigProperty.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${baseConfigProperty?.description}" />

</div>

