package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.gorm.*

@Secured('ROLE_gestionar evaluación')
@Transactional(readOnly = true)
class QuestionController {

    def categoryService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Question.list(params), model:[questionCount: Question.count()]
    }

    /*
    Realiza la busqueda de preguntas
    Realiza paginacion y ordenación de los elementos.
     */
    def search(Integer max){
        DetachedCriteria<Question> query = Question.where {
            text =~ '%'+ params.text +'%'
        }
        params.max = Math.min(max ?: 10, 100)
        def questionList = query.list(params)
        render view: 'index', model: [questionList: questionList,
            question: params.text,
            questionCount: questionList.getTotalCount()]
    }

    def show(Question question) {
        respond question, model:[categories: categoryService.listRootMeciCategories()]
    }

    def create() {
        respond new Question(params), model:[categories: categoryService.listRootMeciCategories()]
    }

    @Transactional
    def save(Question question) {
        
        if (question == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (question.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond question.errors, view:'create'
            return
        }

        question.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'question'), question.id])
                redirect question
            }
            '*' { respond question, [status: CREATED] }
        }
    }

    def edit(Question question) {
        def categoryType = Param.findByName('question.categoryType')?.value
        respond question, model:[categories: categoryService.listRootMeciCategories()]
    }

    @Transactional
    def update(Question question) {
        if (question == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (question.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond question.errors, view:'edit'
            return
        }
        // actualiza la pregunta desde que question ya tiene asignado un id
        question.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), question.question])
                redirect question
            }
            '*'{ respond question, [status: OK] }
        }
    }

    @Transactional
    def delete(Question question) {

        if (question == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        question.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), question.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
