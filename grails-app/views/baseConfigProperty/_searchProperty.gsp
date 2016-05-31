<g:form method="GET" action="propertyList" id="${}">
    <g:if test="${params.get('sort')}"><g:hiddenField name="sort" value="${params.get('sort')}"/></g:if>
    <g:if test="${params.get('order')}"><g:hiddenField name="order" value="${params.get('order')}"/></g:if>

    <div class="ibox float-e-margins search-box">
        <div class="ibox-title">
            <h5><g:message code="default.criteria.label" default="Search Condition"/></h5>
            <label class="label label-primary"><g:message code="default.paginate.totalRecords.label"
                                                          default="{0} total records"
                                                          args="${[baseConfigPropertyCount]}"/></label>

            <div class="ibox-tools">
                <label for="max"><small class=""><g:message code="default.paginate.max.label"
                                                            default="Max Rows on Page"/></small></label>
                <g:select name="max" from="${[10, 25, 50, 100]}"
                          value="${params.get('max')}" class="form-control max"/>
                <ui:button name="search" mode="primary" class="btn-success btn-xs">
                    <g:message code="default.button.search.label" default="Search"/>
                    <i class="fa fa-search"></i>
                </ui:button>
                <a class="collapse-link ui-sortable">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>

        <div class="ibox-content">
            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label>
                            <g:message code="baseConfigHolder.holderName.label"/>
                        </label>
                        <g:textField name="holderName" value="${params.get('holderName') ?: ''}" class="form-control"
                                     placeholder="${message(code: 'baseConfigHolder.holderName.label')}"/>
                    </div>
                </div>

            </div>
        </div>
    </div>
</g:form>