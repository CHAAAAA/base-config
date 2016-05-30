package base.config

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class BaseConfigPropertyController {

    def grailsUiExtensions

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BaseConfigProperty.list(params), model:[baseConfigPropertyCount: BaseConfigProperty.count()]
    }

    def show(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        respond baseConfigPropertyInstance
    }

    def create() {
        respond new BaseConfigProperty(params)
    }

    @Transactional
    def save(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        if (baseConfigPropertyInstance.hasErrors()) {
            respond baseConfigPropertyInstance.errors, view:'create'
            return
        }

        baseConfigPropertyInstance.save flush:true

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.created.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), baseConfigPropertyInstance.id])
                redirect baseConfigPropertyInstance
            }
            '*' { respond baseConfigPropertyInstance, [status: CREATED] }
        }
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
            respond baseConfigPropertyInstance.errors, view:'edit'
            return
        }

        baseConfigPropertyInstance.save flush:true

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.updated.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), baseConfigPropertyInstance.id])
                redirect baseConfigPropertyInstance
            }
            '*'{ respond baseConfigPropertyInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        baseConfigPropertyInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.deleted.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), baseConfigPropertyInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'error', text: 'default.not.found.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
