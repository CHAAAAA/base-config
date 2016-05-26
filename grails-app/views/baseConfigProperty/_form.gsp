<%@ page import="base.config.BaseConfigProperty" %>



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

