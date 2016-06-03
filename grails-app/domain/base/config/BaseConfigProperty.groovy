package base.config

import groovy.json.JsonSlurper

class BaseConfigProperty {

    String name
    String customKey
    String customValue
    String description
    ConfigType configType

    BaseConfigHolder configHolder

    static constraints = {

        customKey nullable: false, unique: true
        customValue nullable: false, maxSize: 1024
        description nullable: true
        configHolder nullable: false
        name nullable: true
        configType nullable: false
    }


    @Override
    String toString() {
        return "${customKey}:${customValue}"
    }

    def grailsApplication

    def updateConfigMap() {
        String objectString = ''
        switch (configType) {
            case ConfigType.BOOLEAN:
            case ConfigType.INTEGER:
            case ConfigType.LONG:
            case ConfigType.MAP:
            case ConfigType.LIST:
                objectString = "${customKey}=${customValue}"
                break
            case ConfigType.STRING:
                objectString = "${customKey}='${customValue}'"
                break
            case ConfigType.GROUP:
                def configList = new JsonSlurper().parseText(customValue)
                String defaultValue = configList['defaultValue']
                def group = configList[defaultValue]
                group.each { k, v ->
                    if (ConfigType[v['type'].toString()] == ConfigType.STRING) {
                        objectString += "\n${v['key']}='${v['value']}'"
                    } else {
                        objectString += "\n${v['key']}=${v['value']}"
                    }
                }
                break
            default: objectString = "${customKey}=${customValue}"
        }

        ConfigObject configObject = new ConfigSlurper().parse(objectString)
        grailsApplication.config.merge(configObject)
    }

    def deleteConfigMap() {
        grailsApplication.config.remove(customKey)
    }
}
