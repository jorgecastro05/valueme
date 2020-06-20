package valueme
import org.springframework.beans.factory.annotation.Value

class UserAccountService {

    def mailService
    
    @Value('${valueme.fromEmail}')
    String fromEmail

    @Value('${valueme.subjectEmail}')
    String subjectEmail

    /**
    Send message from email service
    param userAccount: map userAccount, password in case of change
    param type: type of email to send [indicated by url]
     **/
    def sendMail(Map userAccount, String type) {

        try {
            mailService.sendMail {
                to userAccount.email
                from fromEmail
                subject subjectEmail
                html view: '/emails/'+type+'UserAccount', model: [username: userAccount.email, password: userAccount.password]
            }
            log.debug("E-mail was sent successfully")
        } catch (Exception ex) {
            log.error("Error: ${ex.getMessage()}")
            throw ex
        }
    }

}