package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar parámetros')
@Transactional(readOnly = true)
class ParamController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Param.list(params), model:[paramCount: Param.count()]
    }

    def show(Param param) {
        respond param
    }

    def create() {
        respond new Param(params)
    }

    @Transactional
    def save(Param param) {
        if (param == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (param.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond param.errors, view:'create'
            return
        }

        param.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'param.label', default: 'Param'), param.id])
                redirect param
            }
            '*' { respond param, [status: CREATED] }
        }
    }

    def edit(Param param) {
        respond param
    }

    @Transactional
    def update(Param param) {
        if (param == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (param.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond param.errors, view:'edit'
            return
        }

        param.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'param.label', default: 'Param'), param.id])
                redirect param
            }
            '*'{ respond param, [status: OK] }
        }
    }

    @Transactional
    def delete(Param param) {

        if (param == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        param.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'param.label', default: 'Param'), param.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'param.label', default: 'Param'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
