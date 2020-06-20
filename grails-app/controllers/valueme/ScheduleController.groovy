package valueme

import static org.springframework.http.HttpStatus.*
import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar evaluación')
@Transactional(readOnly = true)
class ScheduleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Schedule.list(params), model:[scheduleCount: Schedule.count()]
    }

    def show(Schedule schedule) {
        respond schedule
    }

    def create() {
        respond new Schedule(params)
    }

    @Transactional
    def save(Schedule schedule) {
        
        if (schedule == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (schedule.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond schedule.errors, view:'create'
            return
        }

        schedule.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'schedule.label', default: 'Schedule'), schedule.id])
                redirect schedule
            }
            '*' { respond schedule, [status: CREATED] }
        }
    }

    def edit(Schedule schedule) {
        respond schedule
    }

    @Transactional
    def update(Schedule schedule) {
        if (schedule == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (schedule.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond schedule.errors, view:'edit'
            return
        }

        schedule.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'schedule.label', default: 'Schedule'), schedule.id])
                redirect schedule
            }
            '*'{ respond schedule, [status: OK] }
        }
    }

    @Transactional
    def delete(Schedule schedule) {

        if (schedule == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        schedule.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'schedule.label', default: 'Schedule'), schedule.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'schedule.label', default: 'Schedule'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
