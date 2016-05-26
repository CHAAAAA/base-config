package base.config

import org.codehaus.groovy.runtime.DefaultGroovyMethods

class BaseConfigProperty {

    String customKey
    String customValue
    String description

    BaseConfigHolder configHolder

    static constraints = {

        customKey nullable: false
        customValue nullable: false
        description nullable: true
        configHolder nullable: true
    }


    @Override
    String toString() {
        return "${customKey}:${customValue}"
    }

    def beforeDelete = {
        deleteConfigMap()
        //CH.config.remove(key)
    }

    def beforeInsert = {
        updateConfigMap()
    }

    def beforeUpdate = {
        updateConfigMap()
    }

    def grailsApplication

    def updateConfigMap() {
        Boolean isBasic = DefaultGroovyMethods.isNumber(customValue) || DefaultGroovyMethods.isFloat(customValue) || customValue in ['true', 'false']

        String objectString
        if (customValue ==~ /\[.*\]/) {
            objectString = "${customKey}=${customValue}"
        } else {
            objectString = isBasic ? "${customKey}=${customValue}" : "${customKey}='${customValue}'"
        }

        ConfigObject configObject = new ConfigSlurper().parse(objectString)
        grailsApplication.config.merge(configObject)
    }

    def deleteConfigMap() {
        def previousValue = grailsApplication.flatConfig[customKey]?.toString()
        if (previousValue) {
            Boolean isBasic = DefaultGroovyMethods.isNumber(previousValue) || DefaultGroovyMethods.isFloat(previousValue) || previousValue in ['true', 'false']
            String objectString
            if (customValue ==~ /\[.*\]/) {
                objectString = "${customKey}=${previousValue}"
            } else {
                objectString = isBasic ? "${customKey}=${customValue}" : "${customKey}='${customValue}'"
            }

            ConfigObject configObject = new ConfigSlurper().parse(objectString)
            grailsApplication.config.merge(configObject)
        } else {
            grailsApplication.config.remove(customKey)
        }

    }
}
