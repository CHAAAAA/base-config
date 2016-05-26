package base.config

/**
 * 配置项的所有者
 *
 */
class BaseConfigHolder {

    String holderName
    String holderAlias
    String description

    static constraints = {
        holderName nullable: false, unique: true
        holderAlias nullable: true
        description nullable: true
    }
}
