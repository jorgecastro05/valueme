package valueme
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityUtils

@Secured('ROLE_realizar evaluación')
class MeciController {

    def springSecurityService

    def index() { }
}
