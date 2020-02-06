package valueme
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ver resultados')
class ScoreController {

    def scoreService

    def getScore(String categoryType, int vigency){
        if(vigency!=0){
            respond scoreService.getScore(categoryType,vigency)
        }
    }


    def compareScore(String categoryA, int vigency, String categoryType ){
        if(vigency!=0){
            if(!(params.categoryB instanceof List)){ // convert in list in case of a single input
                params.categoryB = params.list('categoryB')
            }
            respond scoreService.getScore(categoryA, params.categoryB, vigency, categoryType)
        }
    }

    @Secured('ROLE_gestionar evaluación')
    def individualScore(String userAccount, int vigency, String categoryType){
        if(vigency!=0){
            respond scoreService.getScore(userAccount,vigency,categoryType)
        }
    }

    def scoreFiltered(String category, int vigency){
        if(vigency!=0){
            respond scoreService.getScoreByAssessmentsAndCategory(category, vigency)
        }
    }


}
