class BaseConfigBootStrap {

    def baseConfigService
    def init = { servletContext ->
        baseConfigService.init()
    }

    def destroy = {
    }
}
