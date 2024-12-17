1. 创建新项目
2. 取消自动导入gradle
3. 项目结构中自己选择java版本和本地gradle location
4. 换源：更改settings.gradle文件里的设置（换源），注意不要删除include和root.projectname
```xml
pluginManagement {
    repositories {
//        maven { url 'https://plugins.gradle.org/m2/' }
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/google' }
        maven { url 'https://maven.aliyun.com/nexus/content/groups/public' }
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/jcenter'}
        gradlePluginPortal()
        google()
        mavenCentral()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
//        maven { url 'https://plugins.gradle.org/m2/' }
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/google' }
        maven { url 'https://maven.aliyun.com/nexus/content/groups/public' }
        maven { url 'https://maven.aliyun.com/nexus/content/repositories/jcenter'}
        google()
        mavenCentral()
    }
}
```
5. 恢复之前取消的导入，等待sync完成
6. 打开手机
7. 运行代码
