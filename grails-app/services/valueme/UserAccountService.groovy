package valueme

import grails.gorm.services.Service

@Service(UserAccount)
interface UserAccountService {

    UserAccount get(Serializable id)

    List<UserAccount> list(Map args)

    Long count()

    void delete(Serializable id)

    UserAccount save(UserAccount userAccount)

}