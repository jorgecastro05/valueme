package valueme
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_gestionar evaluación')
class ProgressController {

    def index(int vigency) {
        List<UserAccount> userAccountList = null
        if(vigency != 0){
            userAccountList = UserAccount.list()
            for(userAccount in userAccountList){
                if(userAccount.vigencyStart <= vigency && (userAccount.vigencyEnd == 0 || vigency <= userAccount.vigencyEnd)) {
                    if(Assessment.findByUserAccountAndFinishedAndVigency(userAccount,true,vigency)){
                        userAccount.metaClass.finished = true
                    }else{
                        userAccount.metaClass.finished = false
                    }
                }else{
                    userAccountList -= userAccount
                }
            }
            userAccountList = userAccountList.sort {
                it.finished
            }
        }

        respond userAccountList: userAccountList, vigency: vigency
    }
}
