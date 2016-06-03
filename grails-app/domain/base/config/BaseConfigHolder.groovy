package base.config

/**
 * 配置项的所有者
 *
 */
class BaseConfigHolder {

    String holderName
    String holderBeanName
    String description

    static constraints = {
        holderName nullable: false, unique: true
        holderBeanName nullable: false, unique: true
        description nullable: true
    }

    @Override
    String toString() {
        return this.holderName
    }
}
