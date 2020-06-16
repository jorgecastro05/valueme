package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.gorm.*

@Secured('ROLE_gestionar evaluación')
@Transactional(readOnly = true)
class SurveyController {

    def surveyService
    def categoryService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Survey.list(params), model:[surveyCount: Survey.count()]
    }

    /*
    Realiza la busqueda de encuestas por vigencia
    Realiza paginacion y ordenación de los elementos.
     */
    def search(Integer max){

        DetachedCriteria<Survey> query = Survey.where {
            vigency == params.vigency as int
        }
        params.max = Math.min(max ?: 10, 100)
        def surveyList = query.list(params)
        render view: 'index', model: [surveyList: surveyList,
            vigency: params.vigency,
            surveyCount: surveyList.getTotalCount()]
    }

    def show(Survey survey) {
        respond survey, 
            model:[categoriesQuestions: categoryService.listRootMeciCategories(), categoriesSurveys: categoryService.listChildProccessCategories()]
    }

    def create() {
        respond new Survey(params), 
            model: [categories: categoryService.listRootMeciCategories(), categoryTypes: categoryService.listChildProccessCategories()]
    }

    @Transactional
    def save(Question question, int vigency){

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

        if(!(params.categorySurvey instanceof List)){ // convert in list in case of a single input
            params.categorySurvey = params.list('categorySurvey')
        }
        surveyService.updateSurveys(question, vigency, params.categorySurvey)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), question.question])
                redirect action:"index", method:"GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    @Transactional
    def saveFromQuestions(Survey survey) {
        if (survey == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        if (survey.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond survey.errors, view:'create'
            return
        }

        log.info Survey.findByCategoryAndVigency(survey.category, survey.vigency)
        if(Survey.findByCategoryAndVigency(survey.category, survey.vigency) != null){
            log.warn "WARNING: Category ALREADY FOUND"
            transactionStatus.setRollbackOnly()
            respond survey.errors, view:'index'
        }


        survey.save flush:true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
                redirect survey
            }
            '*' { respond survey, [status: CREATED] }
        }
    }

    def edit(Survey survey) {
        def categoryTypeQuestions = Param.findByName('question.categoryType')?.value
        def categoryTypeSurveys = Param.findByName('survey.categoryType')?.value
        respond survey, model:[categoriesQuestions: categoryService.listRootMeciCategories(), 
                               categoriesSurveys: categoryService.listChildProccessCategories() ]
    }

    @Transactional
    def update(Survey survey) {
        if (survey == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (survey.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond survey.errors, view:'edit'
            return
        }

        // reload questions
        survey.questions = []
        for(key in params.survey['questions']){
            survey.questions.add(Question.get(key))
        }

        survey.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
                redirect survey
            }
            '*'{ respond survey, [status: OK] }
        }
    }

    @Transactional
    def delete(Survey survey) {

        if (survey == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        survey.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def copysurvey(){

        surveyService.copySurveys(params.int('beforeVigency'), params.int('afterVigency'))
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.action.success.label')
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
