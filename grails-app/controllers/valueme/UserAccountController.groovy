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
    def categoryType = Param.findByName('account.categoryType')?.value

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond UserAccount.list(params), model:[userAccountCount: UserAccount.count()]
    }

    /*
    Realiza la busqueda de cuentas de usuario bajo los filtros de consulta
    Realiza paginacion y ordenación de los elementos.
     */
    def search(Integer max){
        DetachedCriteria<UserAccount> query = UserAccount.where {
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
        params.password = RandomStringUtils.randomAlphanumeric(12)
        [userAccount: new UserAccount(params), roles:RoleGroup.list(), categories: categoryService.listRootCategoriesByType(categoryType)]
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

        userAccount.roles = [params.selRoles].flatten()
        def pw = userAccount.passwordHash
        userAccount.save flush:true

        // secure that email is send after successfully save userAccount
        //userAccountService.sendMail([email: userAccount.email, password: pw],'create')

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.userAccount])
                redirect userAccount
            }
                    '*' { respond userAccount, [status: CREATED] }
        }
    }

    def edit(UserAccount userAccount) {
        [userAccount:userAccount, roles:RoleGroup.list(), categories: categoryService.listRootCategoriesByType(categoryType)]
    }


    @Secured(['ROLE_realizar evaluación','ROLE_gestion usuarios'])
    @Transactional
    def update(UserAccount userAccount) {
        def pw = null
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
            if(userAccount.passwordHash != params.passwordHash2){
                userAccount.errors.rejectValue('passwordHash','userAccount.passwordHash.notMatch')
                respond userAccount.errors, view:'changePassword'
                return
            }
            pw = userAccount.passwordHash
        }

        userAccount.roles = [params.selRoles].flatten()
        userAccount.save flush:true

        // enviar correo unicamente si se editó la contraseña
        if(params.editPassword){
            userAccountService.sendMail([email: userAccount.userAccount, password: pw],'details')
        }


        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.userAccount])
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
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.userAccount])
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
            def pw = RandomStringUtils.randomAlphanumeric(12)
            user.passwordHash = pw
            user.save flush: true
            userAccountService.sendMail([email: user.userAccount, password: pw],'pwChanged')
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
    def activate(String user, String passwordHash, String passwordHash2){
        UserAccount userAccount = UserAccount.get(user)
        userAccount.passwordHash = passwordHash
        userAccount.active = true
        def pw = null
        if(userAccount.passwordHash != params.passwordHash2){
            flash.error = message(code: 'userAccount.passwordHash.notMatch')
            redirect action: "index" , method:"GET"
            return
        }
        pw = userAccount.passwordHash

        userAccount.save flush:true
        // enviar correo
        userAccountService.sendMail([email: userAccount.userAccount, password: pw],'details')

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userAccount.label', default: 'UserAccount'), userAccount.userAccount])
                redirect action:"index", method:"GET"
            }
                    '*'{ respond userAccount, [status: OK] }
        }
    }

    /* Permite obtener las categorias dado el id del padre
     */
    def getCategories(String parent){
        def categories = Category.findAllByParent(parent)
        categories.size() // force mapping of all objects
        respond categories, formats: ['json']
    }
}
