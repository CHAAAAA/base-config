package base.config
/**
 * Created by wyc on 16/5/26.
 * 用于表示一个配置项 包含 Config.groovy 与 BaseConfigProperty
 *
 */

class NormalConfigProperty {
    String configKey
    String configValue

    Boolean isInDb = false
    Long dbId
    String dbValue

    String fileValue

    public NormalConfigProperty(Boolean isInDb, Long dbId, String dbValue, String fileValue, String configKey, String configValue) {

        this.isInDb = isInDb
        this.dbId = dbId
        this.dbValue = dbValue
        this.fileValue = fileValue

        this.configKey = configKey
        this.configValue = configValue
    }


}
