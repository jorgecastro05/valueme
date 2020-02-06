package valueme

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar evaluación')
@Transactional(readOnly = true)
class CustomFieldController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CustomField.list(params), model:[customFieldCount: CustomField.count()]
    }

    def show(CustomField customField) {
        respond customField
    }

    def create() {
        respond new CustomField(params)
    }

    @Transactional
    def save(CustomField customField) {
        if (customField == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (customField.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond customField.errors, view:'create'
            return
        }

        customField.value = params.value.split('\\*').collect{it.replaceAll(/^,/, "")}     
        customField.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'customField.label', default: 'CustomField'), customField.id])
                redirect customField
            }
            '*' { respond customField, [status: CREATED] }
        }
    }

    def edit(CustomField customField) {
        respond customField
    }

    @Transactional
    def update(CustomField customField) {
        if (customField == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (customField.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond customField.errors, view:'edit'
            return
        }

        customField.value = params.value.split('\\*').collect{it.replaceAll(/^,/, "")}
        customField.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'customField.label', default: 'CustomField'), customField.id])
                redirect customField
            }
            '*'{ respond customField, [status: OK] }
        }
    }

    @Transactional
    def delete(CustomField customField) {

        if (customField == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        customField.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'customField.label', default: 'CustomField'), customField.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'customField.label', default: 'CustomField'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
