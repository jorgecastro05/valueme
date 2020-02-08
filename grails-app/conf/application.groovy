

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
[pattern: '/',               					access: ['permitAll']],
[pattern: '/error',          					access: ['permitAll']],
[pattern: '/dbconsole/**',          			        access: ['permitAll']],
[pattern: '/index',          					access: ['permitAll']],
[pattern: '/index.gsp',      					access: ['permitAll']],
[pattern: '/userAccount/forgetPassword.gsp',    access: ['permitAll']],
[pattern: '/coming',         					access: ['permitAll']],
[pattern: '/shutdown',       					access: ['permitAll']],
[pattern: '/assets/**',      					access: ['permitAll']],
[pattern: '/**/js/**',       					access: ['permitAll']],
[pattern: '/**/css/**',      					access: ['permitAll']],
[pattern: '/**/images/**',   					access: ['permitAll']],
[pattern: '/**/favicon.ico', 					access: ['permitAll']],
[pattern: '/login/**',       					access: ['permitAll']],
[pattern: '/logout/**',      					access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
[pattern: '/assets/**',      filters: 'none'],
[pattern: '/**/js/**',       filters: 'none'],
[pattern: '/**/css/**',      filters: 'none'],
[pattern: '/**/images/**',   filters: 'none'],
[pattern: '/**/favicon.ico', filters: 'none'],
[pattern: '/**',             filters: 'JOINED_FILTERS']
]

grails.plugin.springsecurity.interceptUrlMap = [
[pattern: '/',               					access: ['permitAll']],
[pattern: '/error',          					access: ['permitAll']],
[pattern: '/index',          					access: ['permitAll']],
[pattern: '/index.gsp',      					access: ['permitAll']],
[pattern: '/userAccount/forgetPassword.gsp',    access: ['permitAll']],
[pattern: '/coming',         					access: ['permitAll']],
[pattern: '/shutdown',       					access: ['permitAll']],
[pattern: '/assets/**',      					access: ['permitAll']],
[pattern: '/**/js/**',       					access: ['permitAll']],
[pattern: '/**/css/**',      					access: ['permitAll']],
[pattern: '/**/images/**',   					access: ['permitAll']],
[pattern: '/**/favicon.ico', 					access: ['permitAll']],
[pattern: '/login/**',       					access: ['permitAll']],
[pattern: '/logout/**',      					access: ['permitAll']]
]

//grails.plugin.springsecurity.logout.postOnly = false
grails.app.context = '/valueme'
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/meci/index'

grails.gorm.default.mapping = {
        cache true
        id generator:'uuid'
}
