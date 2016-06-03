[TOC]

# base-config

动态管理 `grails` 配置

## 如何设置配置项

本插件只负责管理自定义的配置项，这些配置项需写在一个以 `BaseConfig` 结尾的文件中，该文件的具体目录结构为 `./grails-app/mconfig/*BaseConfig.groovy` . 对于写在 `Config.groovy` 中的配置项本插件不予管理，当 `Config.groovy` 和 `*BaseConfig.groovy` 两者中的配置冲突时，系统以 `*BaseConfig.groovy` 中的配置为准。

## `*BaseConfig.groovy` 文件格式

该文件需要包含3个**静态**变量 `name`、`description`、`config`， 其中 `config` 为 `Closure` 的形式. 格式如下：

```
package base.config
import base.config.ConfigType

/*
 * 配置文件示例
 */
class TestBaseConfig {
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
```

其中 `ConfigType` 为枚举类型，其内容如下：

```
package base.config

enum ConfigType {
    STRING,
    INTEGER,
    LONG,
    BOOLEAN,
    MAP,
    LIST,
    GROUP
}
```

需要注意的是，`GROUP` 下每组配置项里不支持再加 `GROUP` 格式的配置项,也就是 `GROUP` 只支持一层.

## 配置项动态管理

* 所有 `*BaseConfig.groovy` 文件中的配置都会被持久化到数据库中，每次重启都会遍历一次来更新数据库和注册配置。在更新数据库的过程中，只要配置的 `key` 不变，就会以数据库中存储的值来注册配置，也就是无法通过 `*BaseConfig.groovy` 文件的更新来更新配置值。
* 该插件只用于动态修改配置，不提供新建、删除配置的操作。
* 对于 `GROUP` 类型的配置，系统只提供对于不同组的选择，也就是当用户选择某一组配置时该组下的配置生效。当前支持修改组内的具体配置项的值。


