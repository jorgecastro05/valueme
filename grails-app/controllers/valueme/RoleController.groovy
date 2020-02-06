package valueme

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar parámetros')
@Transactional(readOnly = true)
class RoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Role.list(params), model:[roleCount: Role.count()]
    }

    def show(Role role) {
        respond role
    }

    def create() {
        [role:new Role(params),permissions:Permission.list()]
    }

    @Transactional
    def save(Role role) {
        if (role == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (role.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond role.errors, view:'create'
            return
        }
        
        role.permissions = [params.selPermissions].flatten()
        role.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), role.role])
                redirect role
            }
            '*' { respond role, [status: CREATED] }
        }
    }

    def edit(Role role) {
        [role:role, permissions:Permission.list()]
    }

    @Transactional
    def update(Role role) {
        if (role == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (role.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond role.errors, view:'edit'
            return
        }

        role.permissions = [params.selPermissions].flatten()
        role.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'role.label', default: 'Role'), role.role])
                redirect role
            }
            '*'{ respond role, [status: OK] }
        }
    }

    @Transactional
    def delete(Role role) {

        if (role == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        role.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'role.label', default: 'Role'), role.role])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'role.label', default: 'Role'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
