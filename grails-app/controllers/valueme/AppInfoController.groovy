package valueme
import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityUtils

@Secured('ROLE_gestionar parámetros')
@Transactional(readOnly = true)
class AppInfoController {

    def index() {
    }
}
