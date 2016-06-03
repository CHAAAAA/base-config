package base.config

import grails.transaction.Transactional
<<<<<<< HEAD
import groovy.json.JsonOutput
=======
>>>>>>> af514f94ef5b264abce1b25d2159395ad232520c
import org.codehaus.groovy.grails.commons.GrailsClassUtils

@Transactional
class BaseConfigService {
    def grailsApplication

    def init() {
        log.info("自动注册baseConfig")
        def allHandler = grailsApplication.getArtefacts(BaseConfigArtefactHandler.TYPE)
<<<<<<< HEAD
        def holderList = []
        def propertyKeyList = []
=======
>>>>>>> af514f94ef5b264abce1b25d2159395ad232520c
        allHandler.each { artefact ->
            log.info("${artefact.name} - ${artefact.fullName}")

            def clazz = Class.forName(artefact.fullName, true, getClass().classLoader)

            String beanName = artefact.fullName.replace('.', '_')
            BaseConfigHolder holder = updateHolder(beanName, clazz)
<<<<<<< HEAD
            holderList << holder

            def configScript = new ClosureScript(closure: GrailsClassUtils.getStaticFieldValue(clazz, 'config') as Closure)
            ConfigSlurper slurper = new ConfigSlurper()
            ConfigObject configs = slurper.parse(configScript)

            configs.keySet().each { String name ->
                propertyKeyList << configs[name]['key']
                handleProperty(holder, configs[name], name)
            }
        }

        BaseConfigHolder.list().each { BaseConfigHolder holder ->
            if (!holderList.contains(holder)) {
                BaseConfigProperty.findAllByConfigHolder(holder).each { BaseConfigProperty property ->
                    property.delete(flush: true)
                }
                holder.delete(flush: true)
            }
        }

        BaseConfigProperty.list().each { BaseConfigProperty property ->
            if (!propertyKeyList.contains(property.customKey)) {
                property.delete(flush: true)
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

    //如果配置项已经存在数据库中,以数据库中值为准!!!
    def handleProperty(BaseConfigHolder holder, def config, String name) {
        if (config['key'] && config['type'] && config['value']) {
            BaseConfigProperty baseConfigProperty = BaseConfigProperty.findByCustomKey(config['key'])
            if (!baseConfigProperty) {
                baseConfigProperty = new BaseConfigProperty()
                baseConfigProperty.customKey = config['key']
                if (config['description']) {
                    baseConfigProperty.description = config['description']
                }
                baseConfigProperty.name = name
                if (config?.type == ConfigType.GROUP) {
                    baseConfigProperty.customValue = JsonOutput.toJson((Map) config['value'])
                } else {
                    baseConfigProperty.customValue = config['value'].toString()
                }
                baseConfigProperty.configType = config['type']
                baseConfigProperty.configHolder = holder
                baseConfigProperty.save(flush: true)
            }
            baseConfigProperty.updateConfigMap()

        } else {
            log.debug("${holder?.holderBeanName} 配置文件格式有误, ${name}")
        }
    }

=======
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

    //如果配置项已经存在数据库中,以数据库中值为准!!!
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
            }

            baseConfigProperty.updateConfigMap()

        } else {
            log.debug("${holder?.holderBeanName} 配置文件 config值 格式有误, 缺少 'value' 或者 'type' 字段")
        }
    }

>>>>>>> af514f94ef5b264abce1b25d2159395ad232520c

}
