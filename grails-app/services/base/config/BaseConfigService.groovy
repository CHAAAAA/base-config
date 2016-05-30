package base.config

import grails.transaction.Transactional
import org.codehaus.groovy.grails.commons.GrailsClassUtils

@Transactional
class BaseConfigService {
    def grailsApplication

    def init() {
        log.info("自动注册baseConfig")
        def allHandler = grailsApplication.getArtefacts(BaseConfigArtefactHandler.TYPE)
        allHandler.each { artefact ->
            log.info("${artefact.name} - ${artefact.fullName}")

            def clazz = Class.forName(artefact.fullName, true, getClass().classLoader)

            String beanName = artefact.fullName.replace('.', '_')
            BaseConfigHolder holder = updateHolder(beanName, clazz)
            def configs = GrailsClassUtils.getStaticFieldValue(clazz, 'config') as HashMap
            configs.each { k, v ->
                handleProperty(holder, k, v)
            }
        }
    }

    BaseConfigHolder updateHolder(String beanName, def clazz) {
        BaseConfigHolder holder = BaseConfigHolder.findByHolderBeanName(beanName)
        if (!holder) {
            holder = new BaseConfigHolder()
        }
        holder.holderName = GrailsClassUtils.getStaticFieldValue(clazz, 'name')
        holder.holderBeanName = beanName
        holder.description = GrailsClassUtils.getStaticFieldValue(clazz, 'description')
        holder.save(flush: true, failOnError: true)
        return holder
    }

    //如果配置项已经存在数据库中且 值的类型相同,以数据库中值为准!!!
    def handleProperty(BaseConfigHolder holder, def k, def v) {
        if (v?.value && v?.type) {
            BaseConfigProperty baseConfigProperty = BaseConfigProperty.findByCustomKey(k)
            if (!baseConfigProperty) {
                baseConfigProperty = new BaseConfigProperty()
                baseConfigProperty.customKey = k
                baseConfigProperty.customValue = v?.value
                baseConfigProperty.configType = v?.type
                baseConfigProperty.configHolder = holder
                baseConfigProperty.save(flush: true, failOnError: true)
            } else if (baseConfigProperty.configType != v?.type) {
                baseConfigProperty.customValue = v?.value
                baseConfigProperty.configType = v?.type
                baseConfigProperty.configHolder = holder
                baseConfigProperty.save(flush: true, failOnError: true)
            }

            String objectString = ''

            switch (v.type) {
                case ConfigType.BOOLEAN:

                case ConfigType.INTEGER:
                case ConfigType.LONG:
                case ConfigType.MAP:
                case ConfigType.LIST:
                    objectString = "${k}=${baseConfigProperty.customValue}"
                    break
                case ConfigType.STRING:
                    objectString = "${k}='${baseConfigProperty.customValue}'"
                    break
                default: objectString = "${k}=${baseConfigProperty.customValue}"
            }

            ConfigObject configObject = new ConfigSlurper().parse(objectString)
            grailsApplication.config.merge(configObject)
        } else {
            log.debug("${holder?.holderBeanName} 配置文件 config值 格式有误, 缺少 'value' 或者 'type' 字段")
        }
    }


}
