package valueme

import grails.testing.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class UserAccountServiceSpec extends Specification {

    UserAccountService userAccountService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new UserAccount(...).save(flush: true, failOnError: true)
        //new UserAccount(...).save(flush: true, failOnError: true)
        //UserAccount userAccount = new UserAccount(...).save(flush: true, failOnError: true)
        //new UserAccount(...).save(flush: true, failOnError: true)
        //new UserAccount(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //userAccount.id
    }

    void "test get"() {
        setupData()

        expect:
        userAccountService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<UserAccount> userAccountList = userAccountService.list(max: 2, offset: 2)

        then:
        userAccountList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        userAccountService.count() == 5
    }

    void "test delete"() {
        Long userAccountId = setupData()

        expect:
        userAccountService.count() == 5

        when:
        userAccountService.delete(userAccountId)
        sessionFactory.currentSession.flush()

        then:
        userAccountService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        UserAccount userAccount = new UserAccount()
        userAccountService.save(userAccount)

        then:
        userAccount.id != null
    }
}
