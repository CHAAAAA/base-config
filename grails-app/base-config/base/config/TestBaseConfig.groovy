package base.config

class TestBaseConfig {
    static name = 'TestInFile' //required
    static description = 'description IN file' //required

    static config = [
            'plugin.test1': [type: ConfigType.INTEGER, value: 1],
            'plugin.test2': [type: ConfigType.BOOLEAN, value: true],
            'plugin.test3': [type: ConfigType.STRING, value: 'ssss'],
            'plugin.test4': [type: ConfigType.LIST, value: ['bbbbb', 'aaaa']]
    ]
}