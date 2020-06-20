package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import org.apache.commons.lang.RandomStringUtils
import grails.converters.*;
import grails.gorm.*

@Secured('ROLE_gestion usuarios')
@Transactional(readOnly = true)
class UserAccountController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def userAccountService
    def categoryService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond UserAccount.list(params), model:[userAccountCount: UserAccount.count()]
    }

    /*
    Realiza la busqueda de cuentas de usuario bajo los filtros de consulta
    Realiza paginacion y ordenación de los elementos.
     */
    def search(Integer max){
        def query = UserAccount.where {
            username =~ '%' + params.username + '%'
            fullName =~ '%' + params.fullName + '%'
        }
        params.max = Math.min(max ?: 10, 100)
        def userAccountList = query.list(params)
        render view: 'index', model: [userAccountList: userAccountList,
            userAccount: params.userAccount,
            fullName: params.fullName,
            userAccountCount: userAccountList.getTotalCount()]
    } 

    @Secured(['ROLE_realizar evaluación','ROLE_gestion usuarios'])
    def show(UserAccount userAccount) {
        if(!userAccount){
            userAccount = UserAccount.get(params.userAccount)
        }
        respond userAccount
    }

    def create() {
        [userAccount: new UserAccount(params), roles:RoleGroup.list(), categories: categoryService.listRootProccessCategories()]
    }

    @Transactional
    def save(UserAccount userAccount) {

        if (userAccount == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userAccount.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userAccount.errors, view:'create'
            return
        }

        userAccount.save flush:true
        for(String roleId: params.selectedRoles){
            RoleGroup roleGroup = RoleGroup.get(roleId.toInteger())
            UserAccountRoleGroup.create userAccount, roleGroup
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.username])
                redirect userAccount
            }
                    '*' { respond userAccount, [status: CREATED] }
        }
    }

    def edit(UserAccount userAccount) {
        [userAccount:userAccount, roles:RoleGroup.list(), categories: categoryService.listRootProccessCategories()]
    }


    @Secured(['ROLE_realizar evaluación','ROLE_gestion usuarios'])
    @Transactional
    def update(UserAccount userAccount) {
        if (userAccount == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userAccount.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userAccount.errors, view:'edit'
            return
        }

        if(params.editPassword){
            if(params.password != params.passwordRetype){
                userAccount.errors.rejectValue('password','userAccount.password.notMatch')
                flash.error = message(code: 'userAccount.password.notMatch')
                respond userAccount.errors, view:'changePassword'
                return
            }else {
                userAccount.password = params.password
            }
        }

        userAccount.save flush:true
        //Clean all prevous roles
        UserAccountRoleGroup.removeAll(userAccount)
        //Create new roles
        for(String roleId: params.selectedRoles) {
            if(!UserAccountRoleGroup.exists(userAccount.id, roleId.toInteger())) {
                RoleGroup roleGroup = RoleGroup.get(roleId.toInteger())
                UserAccountRoleGroup.create userAccount, roleGroup
            }
        }

        // enviar correo unicamente si se editó la contraseña
        if(params.editPassword){
            userAccountService.sendMail([email: userAccount.username, password: params.passwordRetype],'details')
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.username])
                redirect userAccount
            }
                    '*'{ respond userAccount, [status: OK] }
        }
    }

    @Transactional
    def delete(UserAccount userAccount) {

        if (userAccount == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        userAccount.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.username])
                redirect action:"index", method:"GET"
            }
                    '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), params.id])
                redirect action: "index", method: "GET"
            }
                    '*'{ render status: NOT_FOUND }
        }
    }

    @Secured(['ROLE_realizar evaluación','ROLE_gestion usuarios'])
    def changePassword(UserAccount userAccount){
        userAccount.password = null
        respond userAccount
    }

    @Secured('permitAll')
    def forgetPassword(){
    }

    @Secured('permitAll')
    @Transactional
    def resetPassword(String userAccount){
        UserAccount user = UserAccount.findByUserAccount(userAccount)
        if(user){
            def newPassword = RandomStringUtils.randomAlphanumeric(12)
            user.password = newPassword
            user.save flush: true
            userAccountService.sendMail([email: user.userAccount, password: newPassword],'pwChanged')
            request.withFormat {
                form multipartForm {
                    flash.success = message(code: 'userAccount.forgetPassword.success.message')
                    redirect action:"forgetPassword", method:"GET"
                }
                    '*'{ render status: NO_CONTENT }
            }

        }else{
            request.withFormat {
                form multipartForm {
                    flash.error = message(code: 'userAccount.forgetPassword.fail.message')
                    redirect action:"forgetPassword", method:"GET"
                }
                    '*'{ render status: NO_CONTENT }
            }

        }
    }

    /**
     *
     * @param  String user          user to change password
     * @param  String passwordHash  password
     * @param  String passwordHash2 confirm password
     * @return        url indicates success or fail operation
     */
    def activate(String user, String password, String passwordRetype){
        
        if(password != passwordRetype){
            flash.error = message(code: 'userAccount.password.notMatch')
            redirect action: "index" , method:"GET"
            return
        }

        UserAccount userAccount = UserAccount.get(user)
        userAccount.password = password
        userAccount.enabled = true
        userAccount.save flush:true
        
        // enviar correo
        userAccountService.sendMail([email: userAccount.username, password: password],'details')

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.username])
                redirect action:"index", method:"GET"
            }
                    '*'{ respond userAccount, [status: OK] }
        }
    }
}
