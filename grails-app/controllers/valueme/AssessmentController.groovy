package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.gorm.*

@Secured('ROLE_realizar evaluación')
@Transactional(readOnly = true)
class AssessmentController {

    def springSecurityService
    def categoryTypeSurvey = Param.findByName("survey.categoryType").value
    def categoryTypeQuestion = Param.findByName("question.categoryType").value
    def categoryService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured('ROLE_gestionar evaluación')
    def index() {
        render view: 'index', model: [categories: categoryService.listChildCategoriesByType(categoryTypeSurvey)]
    }

    /*
    Realiza la busqueda de evaluaciones por vigencia
    Realiza paginacion y ordenación de los elementos.
     */
    @Secured('ROLE_gestionar evaluación')
    def search(Integer max){
        DetachedCriteria<Assessment> query = Assessment.where {
            vigency == params.vigency as int
            if(params.category){
                category == Category.get(params.category)
            }
        }
        params.max = Math.min(max ?: 10, 100)
        def assessmentList = query.list(params)
        render view: 'index', model: [assessmentList: assessmentList,
            vigency: params.vigency,
            categories: Category.findAll(),
            category: Category.get(params.category),
            assessmentCount: assessmentList.getTotalCount()]
    }

    def show(Assessment assessment) {
        respond assessment, model: [categories: categoryService.listCategoriesByType(categoryTypeQuestion)]
    }

    def create() {
        // verify schedule
        Schedule schedule = Schedule.findByActive(true)
        Date now = Calendar.getInstance().getTime()
        if (schedule.startDate.before(now) && schedule.endDate.after(now)) {
            Assessment assessment = new Assessment(params)
            assessment.userAccount = UserAccount.findById(springSecurityService.principal.id)
            assessment.category = assessment.userAccount.category
            // load questions from survey asociated
            Survey survey = Survey.findByCategoryAndVigency(assessment.userAccount.category, schedule.vigency)
            if(survey == null){
                flash.error =  message(code: 'assessment.nosurvey.message')
                redirect controller: 'meci', action: 'index'
                return
            }
            assessment.survey = survey
            assessment.vigency = survey.vigency
            respond assessment, model: [categories: categoryService.listCategoriesByType(categoryTypeQuestion)]

        } else {
            flash.error =  message(code: 'assessment.noschedule.message')
            redirect controller: 'meci', action: 'index'
        }
    }

    @Transactional
    def save(Assessment assessment) {

        if (assessment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (assessment.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond assessment, view:'create'
            return
        }

        // validate number of assesments
        int number = Param.findByName('survey.maxAssessments')?.value?.toInteger()
        int vigency = Schedule.findByActive(true).vigency
        UserAccount user = UserAccount.findById(springSecurityService.principal.id)
        if(Assessment.findAllByUserAccountAndVigency(user,vigency).size() > number){
            transactionStatus.setRollbackOnly()
            flash.error =  message(code: 'assessment.maxAssessments.message')
            respond assessment, view:'create'
            return
        }


        assessment.finished = true
        assessment.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'assessment.label', default: 'Assessment')])
                render view:'thankyou'
            }
            '*' { respond assessment, [status: CREATED] }
        }
    }

    def thankyou(){

    }

    def edit(Assessment assessment) {
        respond assessment, model: [categories: categoryService.listCategoriesByType(categoryTypeQuestion)]
    }

    /*
    ommits validations for saving temporarily
     */
    @Transactional
    def saveTemporarily(Assessment assessment){
        if (assessment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        assessment.save flush:true, validate: false

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'assessment.label', default: 'Assessment')])
                redirect assessment
            }
            '*'{ respond assessment, [status: OK] }
        }
    }

    @Transactional
    def update(Assessment assessment) {
        if (assessment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (assessment.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond assessment.errors, view:'edit'
            return
        }
        assessment.finished = true
        assessment.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'assessment.label', default: 'Assessment')])
                redirect assessment
            }
            '*'{ respond assessment, [status: OK] }
        }
    }

    @Secured('ROLE_gestionar evaluación')
    @Transactional
    def delete(Assessment assessment) {

        if (assessment == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        assessment.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'assessment.label', default: 'Assessment')])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'assessment.label', default: 'Assessment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
