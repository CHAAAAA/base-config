package base.config


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Transactional(readOnly = true)
/**
 * 配置系统默认的过滤项
 * base.config.defaultFilter = ['grails.*', 'log4j.*', 'dataSource.*', 'hibernate.*']
 *
 */
class BaseConfigPropertyController {

    def grailsUiExtensions
    def grailsApplication

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max, Integer offset) {
        max = Math.min(max ?: 10, 100)
        offset = offset ?: 0
        def filters = grailsApplication.config.base.config.defaultFilter

        def fileProperties = grailsApplication.flatConfig

        def normalConfigProperties = []
        fileProperties.each { key, value ->
            Boolean isIgnore = false
            //过滤配置
            filters.each {
                if (key ==~ it) {
                    isIgnore = true
                }
            }
            if (!isIgnore) {
                def dbProperty = BaseConfigProperty.findByCustomKey(key)
                Boolean isInDb = dbProperty ? true : false
                Long dbId = dbProperty ? dbProperty.id : null
                String currentPro = dbProperty ? dbProperty.customValue?.toString() : grailsApplication.flatConfig[key]?.toString()

                normalConfigProperties <<
                        new NormalConfigProperty(isInDb, dbId, dbProperty?.customValue, value.toString(), key, currentPro)
            }
        }

        BaseConfigProperty.list().each {
            if (!grailsApplication.flatConfig[it.customKey] && !"".equals(grailsApplication.flatConfig[it.customKey])) {
                grailsApplication.flatConfig[it.customKey] = ""
                def normalConfigProperty = new NormalConfigProperty(true, it.id, it.customValue, null, it.customKey, it.customValue)
                if (!normalConfigProperties.contains(normalConfigProperty)) {
                    normalConfigProperties.add(normalConfigProperty)
                }
            }
        }

        int total = normalConfigProperties.size()
        int upperLimit = findUpperIndex(offset, max, total)
        normalConfigProperties = normalConfigProperties.getAt(offset..upperLimit)

        [normalConfigProperties: normalConfigProperties, normalConfigPropertiesTotalSum: total]
    }

    public static int findUpperIndex(int offset, int max, int total) {
        max = offset + max - 1
        if (max >= total) {
            max -= max - total + 1
        }
        return max
    }

    def show(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        respond baseConfigPropertyInstance
    }

    def create() {
        BaseConfigProperty baseConfigProperty = new BaseConfigProperty(params)
        def holderList = BaseConfigHolder.list()
        [baseConfigPropertyInstance: baseConfigProperty, holderList: holderList]
    }

    @Transactional
    def save() {
        if (params?.customKey == '' || params?.customValue == '') {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: '缺少参数')
            redirect(action: 'create', params: params)
        }

        BaseConfigProperty baseConfigPropertyInstance =
                BaseConfigProperty.findByCustomKeyAndCustomValue(params.customKey, params.customValue)

        if (baseConfigPropertyInstance) {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: '已存在')
            redirect(action: 'create', params: params)
        }
        baseConfigPropertyInstance = new BaseConfigProperty()
        baseConfigPropertyInstance.customKey = params.customKey
        baseConfigPropertyInstance.customValue = params.customValue
        baseConfigPropertyInstance.description = params?.description ?: null

        if (params?.holder) {
            if (params.holder == -1) {
                baseConfigPropertyInstance.configHolder = null
            } else {
                BaseConfigHolder holder = BaseConfigHolder.get(params.getLong('holder'))
                if (holder) {
                    println(holder)
                    baseConfigPropertyInstance.configHolder = holder
                }
            }
        }

        baseConfigPropertyInstance.save flush: true

        baseConfigPropertyInstance.updateConfigMap()

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
        def holderList = BaseConfigHolder.list()

        [baseConfigPropertyInstance: baseConfigPropertyInstance, holderList: holderList]
    }

    @Transactional
    def update(Long id) {

        if (params.customKey == '' || params.customValue == '') {
            grailsUiExtensions.displayFlashMessage(type: 'error', text: '缺少参数')
            redirect(action: 'edit', id: id)
        }

        BaseConfigProperty baseConfigPropertyInstance =
                BaseConfigProperty.get(id)

        if (!baseConfigPropertyInstance) {
            grailsUiExtensions.displayMessage(type: 'error', text: '不存在')
            redirect(action: 'index')
        }
        baseConfigPropertyInstance.customKey = params.customKey
        baseConfigPropertyInstance.customValue = params.customValue
        baseConfigPropertyInstance.description = params?.description ?: null

        if (params?.holder) {
            if (params.holder == -1) {
                baseConfigPropertyInstance.configHolder = null
            } else {
                BaseConfigHolder holder = BaseConfigHolder.get(params.getLong('holder'))
                if (holder) {
                    println(holder)
                    baseConfigPropertyInstance.configHolder = holder
                }
            }
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
    def delete(BaseConfigProperty baseConfigPropertyInstance) {
        if (baseConfigPropertyInstance == null) {
            notFound()
            return
        }

        baseConfigPropertyInstance.delete flush: true
        baseConfigPropertyInstance.deleteConfigMap()

        request.withFormat {
            form multipartForm {
                grailsUiExtensions.displayFlashMessage(type: 'info', text: 'default.deleted.message', args: [message(code: 'baseConfigProperty.label', default: 'BaseConfigProperty'), baseConfigPropertyInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
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
