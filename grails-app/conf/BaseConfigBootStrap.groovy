import base.config.BaseConfigHolder
import base.config.BaseConfigProperty

class BaseConfigBootStrap {

    def init = { servletContext ->
        //创建本插件的配置持有人
        BaseConfigHolder baseConfigHolder = BaseConfigHolder.findByHolderName('配置管理')
        if (!baseConfigHolder) {
            baseConfigHolder = new BaseConfigHolder()
            baseConfigHolder.holderName = '配置管理'
            baseConfigHolder.holderAlias = 'base-config'
            baseConfigHolder.description = '该应用用于管理系统配置'
            baseConfigHolder.save(flush: true, failOnError: true)
        }

        BaseConfigProperty.list().each {
            it.updateConfigMap()
        }
    }

    def destroy = {
    }
}
