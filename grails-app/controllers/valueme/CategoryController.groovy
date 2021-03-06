package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar evaluación')
@Transactional(readOnly = true)
class CategoryController {

    def categoryService
    def categoryTypeService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        respond Category.list()
    }

    def indexProcess(){
        flash.categoryType = "process"
        respond categoryService.listRootProccessCategories(), view:'index'
    }

    def indexMeci(){
        flash.categoryType = "meci"
        respond categoryService.listRootMeciCategories(), view:'index'
    }

    def show(Category category) {
        def categoryList = Category.findAllByParent(category)
        flash.categoryType = params.categoryType
        respond category, model:[categoryList: categoryList]
    }

    def filterByParent(Category category){
        def categoryList = Category.findAllByParent(category)
        flash.categoryType = params.categoryType
        respond categoryList, view:'index'
    }

    def create() {
        def categoryList
        def categoryTypeList
        switch(params.categoryType) {
            case 'meci':
                categoryList = categoryService.listMeciCategories()
                categoryTypeList = categoryTypeService.listMeciCategoyTypes()
            break
            case 'process':
                categoryList = categoryService.listProcessCategories()
                categoryTypeList = categoryTypeService.listProcessCategoryTypes()
            break
        }

        [category: new Category(params) , categories: categoryList, categoryTypes: categoryTypeList]
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
        
        categoryService.saveCategory category 
        
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
        def categoryList
        def categoryTypeList
        switch(params.categoryType) {
            case 'meci':
                categoryList = categoryService.listMeciCategories()
                categoryTypeList = categoryTypeService.listMeciCategoyTypes()
            break
            case 'process':
                categoryList = categoryService.listProcessCategories()
                categoryTypeList = categoryTypeService.listProcessCategoryTypes()
            break
        }
        respond category, model: [categories: categoryList, categoryTypes: categoryTypeList]
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

        categoryService.updateCategory category

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

        categoryService.deleteCategory category

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
