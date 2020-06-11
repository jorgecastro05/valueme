package valueme
import grails.plugin.springsecurity.annotation.Secured

@Secured('ROLE_ver resultados')
class ScoreController {

    def scoreService
    def springSecurityService
    def categoryService
    def categoryTypeService

    def indexScore() {
        render view: 'getScore', model: [categoryTypes: categoryTypeService.listMeciCategoyTypes()]
    }

    def indexCompareScore() {
        render view: 'compareScore', model: [categoryTypes: categoryTypeService.listMeciCategoyTypes()]
    }

    def indexIndividualScore() {
        render view: 'individualScore', model: [categoryTypes: categoryTypeService.listMeciCategoyTypes()]
    }


    def getScore(String categoryType, int vigency){
        if(vigency!=0){
            respond scoreService.getScore(categoryType,vigency), 
                model:[categories: categoryService.listRootMeciCategories(), 
                categoryTypes: categoryTypeService.listMeciCategoyTypes()]
        }
    }


    def compareScore(String categoryA, int vigency, String categoryType ){
        if(vigency!=0){
            if(!(params.categoryB instanceof List)){ // convert in list in case of a single input
                params.categoryB = params.list('categoryB')
            }
        def categoryTypeSearch = Param.findByName('survey.categoryType')?.value    
        respond scoreService.getScore(categoryA, params.categoryB, vigency, categoryType), 
                model:[categories: categoryService.listRootMeciCategories(), 
                categoryTypes: categoryTypeService.listMeciCategoyTypes()]
        }
    }

    @Secured('ROLE_gestionar evaluación')
    def individualScore(String username, int vigency, String categoryType){
        if(vigency!=0){
            UserAccount user = UserAccount.findById(username)
            def categoryTypeSearch = Param.findByName('question.categoryType')?.value
            respond scoreService.getScore(user,vigency,categoryType), 
            model:[categories: categoryService.listRootMeciCategories(),
            categoryTypes: categoryTypeService.listMeciCategoyTypes()]
        }
    }

    def scoreFiltered(String category, int vigency){
        if(vigency!=0){
            respond scoreService.getScoreByAssessmentsAndCategory(category, vigency)
        }
    }


}
