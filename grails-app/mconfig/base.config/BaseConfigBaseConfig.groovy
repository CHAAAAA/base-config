package base.config

// This is an example
class BaseConfigBaseConfig {
    static name = '配置管理应用'                           //required
    static description = '该插件用于动态管理系统配置'        //required

    static config = {
        'int配置' {
            key = 'plugin.demo.int'
            type = ConfigType.INTEGER
            value = 1
        }
        'str配置' {
            key = 'plugin.demo.str'                   //required  系统全局唯一
            type = ConfigType.STRING                  //required
            value = 'string'                          //required
            description = 'description'               //not required
        }
        'group配置' {
            type = ConfigType.GROUP                   //required
            key = 'plugin.demo.group'                 //required  系统全局唯一  但这并不是配置名 只用于存储在数据库中 具体配置名为 '配置1'这些具体配置的 key
            value {                                   //required
                defaultValue = '我是设置组2'           //required
                '我是设置组1' {                        //required   该字段用于在页面显示
                    '配置1' {                         //required    该字段的名称只用于区别不同配置  同时不同组的对应配置名应相同 为了方便区分
                        key = 'plugin.group.set1'    //required
                        type = ConfigType.INTEGER    //required
                        value = 11                   //required
                    }
                    '配置2' {
                        key = 'plugin.group.set2'
                        type = ConfigType.LIST
                        value = [12, 23]
                    }
                }

                '我是设置组2' {
                    '配置1' {
                        key = 'plugin.group.set1'
                        type = ConfigType.INTEGER
                        value = 33
                    }
                    '配置2' {
                        key = 'plugin.group.set2'
                        type = ConfigType.LIST
                        value = [34, 56]
                    }
                }
            }
        }
    }
}