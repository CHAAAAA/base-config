package base.config

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BaseConfigPropertyController {

    def grailsUiExtensions
    static navigationScope = "app/wappSetting"

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    def index() {
        int max = Math.min(params.getInt('max') ?: 10, 100)
        int offset = params.getInt('offset', 0)
        def baseConfigHolderInstanceList = BaseConfigHolder.createCriteria().list(max: max, offset: offset) {
            if (params.get('holderName')) {
                or {
                    ilike('holderName', '%' + params.get('holderName') + '%')
                    ilike('holderBeanName', '%' + params.get('holderName') + '%')
                }
            }
        }

        [baseConfigHolderInstanceList : baseConfigHolderInstanceList,
         baseConfigHolderInstanceCount: baseConfigHolderInstanceList.totalCount]
    }

    def propertyList(Long id) {
        int max = Math.min(params.getInt('max') ?: 10, 100)
        int offset = params.getInt('offset', 0)

        BaseConfigHolder holder = BaseConfigHolder.get(id)
        if (!holder) {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: '没有找到该应用')
            redirect(action: 'index', params: params)
        }

        def baseConfigPropertyList = BaseConfigProperty.createCriteria().list(max: max, offset: offset) {
            configHolder {
                eq('id', id)
            }

            if (params.get('customValue')) {
                ilike('customValue', '%' + params.get('customValue') + '%')
            }

            if (params.get('customKey')) {
                ilike('customKey', '%' + params.get('customKey') + '%')
            }
        }

        [baseConfigPropertyInstanceList: baseConfigPropertyList, baseConfigPropertyCount: baseConfigPropertyList.totalCount,
         baseConfigHolderId            : id]
    }

    def show(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        respond baseConfigPropertyInstance
    }


    def edit(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        respond baseConfigPropertyInstance
    }

    @Transactional
    def update(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        if (baseConfigPropertyInstance.hasErrors()) {
            respond baseConfigPropertyInstance.errors, view: 'edit'
            return
        }

        baseConfigPropertyInstance.save flush: true
        baseConfigPropertyInstance.updateConfigMap()
        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.updated.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), baseConfigPropertyInstance.id])
                redirect baseConfigPropertyInstance
            }
            '*' { respond baseConfigPropertyInstance, [status: OK] }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'error', text: 'default.not.found.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
