package base.config

import groovy.json.JsonOutput
import groovy.json.JsonSlurper

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional
class BaseConfigPropertyController {

    def grailsUiExtensions
    static navigationScope = "app/wappSetting"

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def grailsApplication

    def test() {
//        def config11 = grailsApplication.config.plugin.demo.int
//        println(config11)
//        def config21 = grailsApplication.config.plugin.demo.str
//        println(config21)
//
//        def config1 = grailsApplication.config.plugin.group.set1
//        println(config1)
//        def config2 = grailsApplication.config.plugin.group.set2
//        println(config2)
//
//        println(grailsApplication.config.plugin.wappSchoolCardDatalook.serviceUrl)
//        println(grailsApplication.config.plugin.wappSchoolCardDatalook.ChargeServiceUrl)
//        println(grailsApplication.config.plugin.wappSchoolCardDatalook.clientType)
//        println(grailsApplication.config.plugin.wappSchoolCardDatalook.systemVersion)

    }

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
            grailsUiExtensions.displayFlashMessage(type: 'error', code: 'baseConfigProperty.notfound.app.label')
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
         baseConfigHolder              : holder]
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

    def editGroup(Long id) {
        BaseConfigProperty baseConfigProperty = BaseConfigProperty.get(id)
        if (baseConfigProperty == null) {
            notFound()
            return
        }

        def groupConfig = new JsonSlurper().parseText(baseConfigProperty.customValue)
        [groupConfigList: groupConfig, baseConfigPropertyInstance: baseConfigProperty]
    }

    @Transactional
    def updateGroup(Long id) {
        BaseConfigProperty baseConfigProperty = BaseConfigProperty.get(id)
        if (baseConfigProperty == null) {
            notFound()
            return
        }

        try {
            def groupValue = new JsonSlurper().parseText(baseConfigProperty.customValue)
            groupValue[params.groupname][params.setname]['value'] = params.configvalue
            baseConfigProperty.customValue = JsonOutput.toJson(groupValue)
            baseConfigProperty.save(flush: true, failOnError: true)
            baseConfigProperty.updateConfigMap()
        } catch (Exception e) {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: 'baseConfigProperty.error.format.label')
        }

        redirect(action: 'editGroup', id: id)
    }

    @Transactional
    def update(Long id) {
        if (!params?.name || !params?.configType) {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: 'baseConfigProperty.lackOfInfo.label')
            respond BaseConfigProperty.get(id), view: 'edit'
            return
        }

        if (!params?.groupValue && !params?.customValue) {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: 'baseConfigProperty.lackOfInfo.label')
            respond BaseConfigProperty.get(id), view: 'edit'
            return
        }

        if (params?.configType == 'BOOLEAN' && !(params?.customValue in ['true', 'false'])) {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: 'baseConfigProperty.error.format.label')
            respond BaseConfigProperty.get(id), view: 'edit'
            return
        }

        BaseConfigProperty baseConfigPropertyInstance = BaseConfigProperty.get(id)

        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        def customValue = baseConfigPropertyInstance?.customValue

        baseConfigPropertyInstance.name = params?.name
        baseConfigPropertyInstance.configType = ConfigType[params?.configType]


        if (params?.configType != 'GROUP') {
            baseConfigPropertyInstance.customValue = params?.customValue
        } else {
            def groupValue = new JsonSlurper().parseText(customValue)
            groupValue['defaultValue'] = params?.groupValue
            baseConfigPropertyInstance.customValue = JsonOutput.toJson(groupValue)
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

    @Transactional
    def deleteHolder(BaseConfigHolder baseConfigHolderInstance) {
        if (baseConfigHolderInstance == null) {
            notFound()
            return
        }
        BaseConfigProperty.findAllByConfigHolder(baseConfigHolderInstance).each {
            it.deleteConfigMap()
            it.delete(flush: true)
        }

        baseConfigHolderInstance.delete flush: true
        grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.deleted.message', args: [message(code: 'baseConfigProperty.configHolder.label'), baseConfigHolderInstance.id])
        redirect(action: 'index')
    }

    @Transactional
    def deleteProperty(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }
        baseConfigPropertyInstance.deleteConfigMap()

        baseConfigPropertyInstance.delete flush: true
        grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.deleted.message', args: [message(code: 'baseConfigProperty.label'), baseConfigPropertyInstance.id])
        redirect(action: 'propertyList', id: baseConfigPropertyInstance?.configHolder?.id)
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
