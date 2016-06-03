package base.config

import groovy.json.JsonSlurper

class BaseConfigTagLib {
    static namespace = "baseConfig"

    def showConfigValue = { attrs, body ->
        BaseConfigProperty property = attrs.configProperty
        if (property.configType == ConfigType.GROUP) {
            out << (new JsonSlurper().parseText(property.customValue))['defaultValue']
        } else {
            out << property.customValue
        }
    }

    def editConfigValue = { attrs, body ->
        BaseConfigProperty property = attrs.configProperty
        if (property.configType == ConfigType.GROUP) {
            def groupValue = new JsonSlurper().parseText(property.customValue)
            def from = []
            groupValue.each { k, v ->
                if (k != 'defaultValue')
                    from << [k: k, v: k]
            }
            def kv = [:]
            kv['from'] = from
            kv['optionKey'] = 'k'
            kv['optionValue'] = 'v'
            kv['value'] = groupValue['defaultValue']
            kv['name'] = 'groupValue'
            kv['class'] = 'form-control m-b'
            out << g.select(kv)
        } else if (property.configType == ConfigType.BOOLEAN) {

            def from = [[k: 'true', v: true], [k: 'false', v: false]]
            def kv = [:]
            kv['from'] = from
            kv['optionKey'] = 'k'
            kv['optionValue'] = 'v'
            kv['value'] = property.customValue
            kv['name'] = 'customValue'
            kv['class'] = 'form-control m-b'
            out << g.select(kv)
        } else {
            out << "<input type='text' id='customValue' name='customValue' value='${property.customValue}' class='form-control'/>"
        }
    }

}
