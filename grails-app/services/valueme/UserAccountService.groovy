package valueme

import grails.transaction.Transactional

@Transactional
class UserAccountService {

    def mailService
    def grailsApplication

    /**
    Send message from email service
    param userAccount: map userAccount, password in case of change
    param type: type of email to send [indicated by url]
     **/
    def sendMail(Map userAccount, String type) {

        try {
            mailService.sendMail {
                to userAccount.email
                from "encuestasostenibilidad@idipron.gov.co"
                subject 'Encuesta sostenibilidad [Idipron]'
                html view: '/emails/'+type+'UserAccount', model: [username: userAccount.email, password: userAccount.password]
            }
            log.debug("E-mail is sent.")
        } catch (Exception ex) {
            log.error("Error: ${ex.getMessage()}")
            throw ex
        }
    }
}
