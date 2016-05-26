<%=packageName ? "package ${packageName}" : ''%>

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ${className}Controller {

    def grailsUiExtensions

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ${className}.list(params), model:[${propertyName}Count: ${className}.count()]
    }

    def show(${className} ${propertyName}Instance) {
        if (${propertyName}Instance == null) {
            notFound()
            return
        }

        respond ${propertyName}Instance
    }

    def create() {
        respond new ${className}(params)
    }

    @Transactional
    def save(${className} ${propertyName}Instance) {
        if (${propertyName}Instance == null) {
            notFound()
            return
        }

        if (${propertyName}Instance.hasErrors()) {
            respond ${propertyName}Instance.errors, view:'create'
            return
        }

        ${propertyName}Instance.save flush:true

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}Instance.id])
                redirect ${propertyName}Instance
            }
            '*' { respond ${propertyName}Instance, [status: CREATED] }
        }
    }

    def edit(${className} ${propertyName}Instance) {
        if (${propertyName}Instance == null) {
            notFound()
            return
        }

        respond ${propertyName}Instance
    }

    @Transactional
    def update(${className} ${propertyName}Instance) {
        if (${propertyName}Instance == null) {
            notFound()
            return
        }

        if (${propertyName}Instance.hasErrors()) {
            respond ${propertyName}Instance.errors, view:'edit'
            return
        }

        ${propertyName}Instance.save flush:true

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}Instance.id])
                redirect ${propertyName}Instance
            }
            '*'{ respond ${propertyName}Instance, [status: OK] }
        }
    }

    @Transactional
    def delete(${className} ${propertyName}Instance) {
        if (${propertyName}Instance == null) {
            notFound()
            return
        }

        ${propertyName}Instance.delete flush:true

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}Instance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'error', text: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
