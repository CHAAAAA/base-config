package base.config

import grails.transaction.Transactional

@Transactional
class BaseConfigService {

    def loadValues(String key, def value) {
        try {
            if (value?.toString() && !((value instanceof List) || (value instanceof Closure))) {
                BaseConfigProperty configProperty = BaseConfigProperty.findByCustomKey(key)
                if (!configProperty) {
                    new BaseConfigProperty(customKey: key, customValue: value.toString(), description: "").save(flush: true)
                }
            }
        } catch (Exception e) {
            log.warn "Exception ${e.message} for " + value + " key : ${key}"
        }
    }

}
