package valueme
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ver resultados')
class ScoreController {

    def scoreService
    def springSecurityService
    def categoryService

    def getScore(String categoryType, int vigency){
        if(vigency!=0){
            def categoryTypeSearch = Param.findByName('question.categoryType')?.value
            respond scoreService.getScore(categoryType,vigency), model:[categories: categoryService.listCategoriesByType(categoryTypeSearch)]
        }
    }


    def compareScore(String categoryA, int vigency, String categoryType ){
        if(vigency!=0){
            if(!(params.categoryB instanceof List)){ // convert in list in case of a single input
                params.categoryB = params.list('categoryB')
            }
        def categoryTypeSearch = Param.findByName('survey.categoryType')?.value    
        respond scoreService.getScore(categoryA, params.categoryB, vigency, categoryType), 
                model:[categories: categoryService.listCategoriesByType(categoryTypeSearch)]
        }
    }

    @Secured('ROLE_gestionar evaluación')
    def individualScore(String username, int vigency, String categoryType){
        if(vigency!=0){
            UserAccount user = UserAccount.findById(username)
            def categoryTypeSearch = Param.findByName('question.categoryType')?.value
            respond scoreService.getScore(user,vigency,categoryType), model:[categories: categoryService.listCategoriesByType(categoryTypeSearch)]
        }
    }

    def scoreFiltered(String category, int vigency){
        if(vigency!=0){
            respond scoreService.getScoreByAssessmentsAndCategory(category, vigency)
        }
    }


}
