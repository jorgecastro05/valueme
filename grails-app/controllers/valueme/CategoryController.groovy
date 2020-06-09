package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar evaluación')
@Transactional(readOnly = true)
class CategoryController {

    def categoryService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        def categoryType = Param.findByName(params.categoryType + '.categoryType')?.value
        respond categoryService.listRootCategoriesByType(categoryType), model:[categoryType: params.categoryType]
    }

    def show(Category category) {
        def categoryList = Category.findAllByParent(category)
        flash.categoryType = params.categoryType
        respond category, model:[categoryList: categoryList]
    }

    def filterByParent(Category category){
        def categoryList = Category.findAllByParent(category)
        respond categoryList, view:'index'
    }

    def create() {
        flash.categoryType = params.categoryType
        [category: new Category(params) , categories: Category.list()]
    }

    @Transactional
    def save(Category category) {
        if (category == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (category.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond category.errors, view:'create'
            return
        }
        
        //TODO: convert logic into service
        Category parent = Category.get(category.parent?.id)
        if(parent){
            parent.addToChilds(category)
            parent.save flush:true
        }
        category.save flush:true
        
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'category.label', default: 'Category'), category.name])
                flash.categoryType = params.categoryType
                redirect category
            }
        '*' { respond category, [status: CREATED] } // respond with format all xml, json
        }
    }

    def edit(Category category) {
        respond category
    }

    @Transactional
    def update(Category category) {
        if (category == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (category.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond category.errors, view:'edit'
            return
        }

        category.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'category.label', default: 'Category'), category.name])
                flash.categoryType = params.categoryType
                redirect category
            }
        '*'{ respond category, [status: OK] }
        }
    }

    @Transactional
    def delete(Category category) {

        if (category == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        category.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'category.label', default: 'Category'), category.category])
                redirect action:"index", method:"GET", params:[categoryType: params.categoryType]
            }
        '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'category.label', default: 'Category'), params.id])
                redirect action: "index", method: "GET"
            }
        '*'{ render status: NOT_FOUND }
        }
    }
}
