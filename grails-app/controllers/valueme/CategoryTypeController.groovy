package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar parámetros')
@Transactional(readOnly = true)
class CategoryTypeController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CategoryType.list(params), model:[categoryTypeCount: CategoryType.count()]
    }

    def show(CategoryType categoryType) {
        respond categoryType
    }

    def create() {
        respond new CategoryType(params)
    }

    @Transactional
    def save(CategoryType categoryType) {
        if (categoryType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (categoryType.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond categoryType.errors, view:'create'
            return
        }

        categoryType.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'categoryType.label', default: 'CategoryType'), categoryType.categoryType])
                redirect categoryType
            }
            '*' { respond categoryType, [status: CREATED] }
        }
    }

    def edit(CategoryType categoryType) {
        respond categoryType
    }

    @Transactional
    def update(CategoryType categoryType) {
        if (categoryType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (categoryType.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond categoryType.errors, view:'edit'
            return
        }

        categoryType.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'categoryType.label', default: 'CategoryType'), categoryType.categoryType])
                redirect categoryType
            }
            '*'{ respond categoryType, [status: OK] }
        }
    }

    @Transactional
    def delete(CategoryType categoryType) {

        if (categoryType == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        categoryType.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'categoryType.label', default: 'CategoryType'), categoryType.categoryType])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoryType.label', default: 'CategoryType'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
