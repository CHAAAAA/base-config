package base.config

class BaseConfigProperty {

    String customKey
    String customValue
    String description
    ConfigType configType

    BaseConfigHolder configHolder

    static constraints = {

        customKey nullable: false, unique: true
        customValue nullable: false
        description nullable: true
        configHolder nullable: true
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
            default: objectString = "${customKey}=${customValue}"
        }

        ConfigObject configObject = new ConfigSlurper().parse(objectString)
        grailsApplication.config.merge(configObject)
    }

    def deleteConfigMap() {
        grailsApplication.config.remove(customKey)
    }
}
