package valueme

import grails.transaction.Transactional

@Transactional
class ScoreService {

    /*
    Obtener el resultado consolidado de todas las encuestas
    Se emplea para obtener el resultado total.
     */
  def getScore(String categoryType, int vigency) {
	    //obtener todas las evaluaciones realizadas deacuerdo a la vigencia y enviadas
	    def assessments = Assessment.findAllByVigencyAndFinished(vigency,true)
	    def scoresByCategory = this.getScoreByAssessmentsAndCategoryType(assessments,categoryType)

	    def result = [:]
	    result.assesments = assessments.size()
	    result.responsibles = UserAccount.findAllByActiveAndCategoryIsNotNull(true).size()
	    result.questions = scoresByCategory.scores
	    result.scoreColumns = [['string', 'categoria'], ['number', 'Puntaje']]
	    result.scoreData = this.googleAPIprocess(scoresByCategory.scoresByCategory)
	    result.categoryType = categoryType
	    result.vigency = vigency
	    return result
  }

    /*
    obtener el puntaje de una encuesta y adicionalmente de un conjunto agrupado de otras
    encuestas, se realiza la busqueda de encuestas por la categoria a la que pertenece el usuario
    Se emplea para la comparación de resultados.
     */
    def getScore(String categoryA, List categoryB, int vigency, String categoryType){

	// procesar resultados de la encuesta A
        def categoriesA = getAllCategories([categoryA])
	def assessmentsA = Assessment.findAllByCategoryInListAndVigencyAndFinished(categoriesA,vigency,true)
	def scoreAByCategory = getScoreByAssessmentsAndCategoryType(assessmentsA,categoryType)


	// procesar los resultados de la encuesta(s) B
	def categoriesB = getAllCategories(categoryB as List)
	def assessmentsB = Assessment.findAllByCategoryInListAndVigencyAndFinished(categoriesB,vigency,true)
	def scoreBByCategory = getScoreByAssessmentsAndCategoryType(assessmentsB,categoryType)

	def result = [:]
	result.scoreA = this.googleAPIprocess(scoreAByCategory.scoresByCategory)
	result.scoreB = this.googleAPIprocess(scoreBByCategory.scoresByCategory)
	result.categoryA = categoryA
	result.categoryB = categoryB
	result.vigency = vigency
	result.categoryType = categoryType

	return result

    }

    /*
    Obtener el puntaje de una encuesta para un usuario particular
     */
    def getScore(UserAccount userAccount, int vigency, String categoryType){
        List<Assessment> assessments = Assessment.findAllByUserAccountAndVigencyAndFinished(userAccount,vigency,true)
        def scoresByCategory = this.getScoreByAssessmentsAndCategoryType(assessments,categoryType)

        def result = [:]
        result.scoreData = this.googleAPIprocess(scoresByCategory.scoresByCategory)
        result.categoryType = categoryType
        result.vigency = vigency
        result.userAccount = userAccount.id
        result.questions = scoresByCategory.scores

        return result
    }

    /*
    Retorna a partir de una categoria padre, los resultados de las categorias hijas
    category pertenece a una categoria de MECI.
     */
    def getScoreByAssessmentsAndCategory(String categoryId, int vigency){

        def categoryType = ''
        def scoresByCategory = null
        def scores = null

        // obtener el objeto categoria y el tipo de categoria
        def category = Category.get(categoryId)

        if(category.childs){
            categoryType = category.childs[0].type
        }

        // si la categoria tiene hijos mostrar los resultados de los hijos
        if(categoryType){
            //obtener todas las evaluaciones realizadas deacuerdo a la vigencia y enviadas
            def assessments = Assessment.findAllByVigencyAndFinished(vigency,true)
            //obtener los resultados por el tipo de categoria

            def scoreByAssessments = getScoreByAssessmentsAndCategoryType(assessments, categoryType)

            //scoresByCategory representa las categorias y su puntaje [(Object) categoria: (int) puntaje]
            scoresByCategory = scoreByAssessments.scoresByCategory

            // filtrar unicamente los resultados cuyo padre sea el requerido y eliminar los otros resultados
            def iterator = scoresByCategory.keySet().iterator()
            while (iterator.hasNext()) {
                if (iterator.next().parent != category) {
                    iterator.remove()
                }
            }

            //scores representan las preguntas y puntaje [(Object) Question: (int) puntaje]
            scores = scoreByAssessments.scores
        }

        def result = [:]
        result.scoreData = this.googleAPIprocess(scoresByCategory)
        result.category = category
        result.categoryName = category.category
        result.vigency = vigency
        result.categoryId = categoryId
        return result
    }


    /*
    Realiza una busqueda de todas las categorias y subcategorias de una lista
    Retorna un listado de todas las categorias y las categorias hijas (de profundidad 1)
     */
    def getAllCategories(List cat){
        List<Category> categories = Category.findAllByIdInList(cat)
        // consolidar la lista de categorias con las categorias hijas
        for(category in categories) {
            List childs = category.childs
            if(childs){
                categories = categories + childs
            }
        }
        return categories
    }


    /*
    Retorna los resultados dado un conjunto de encuestas agrupadas por tipo de categoria
    la categoria corresponde a la jerarquia de la encuesta ej: Modulo, componente, elemento
     */
    def getScoreByAssessmentsAndCategoryType(List<Assessment> assessments, String categoryType){

        def scoreByAssessments = getBasicScores(assessments)
        def scoresByCategory =  scoreByAssessments.scoresByCategory
        def scores = scoreByAssessments.scores

	// iterar sobre las categorias padre hasta que encuentre un nivel con el TIPO de categoria ingresado
	if(scoresByCategory)
        while(scoresByCategory.keySet().iterator().next().type != categoryType) {
            // agrupar las categorias por categoria padre
            scoresByCategory = scoresByCategory.groupBy {key, value ->
                // si no se presenta la categoria padre agrupar por la actual
                // ocurre cuando no todas las categorias agrupadas tienen el mismo padre
                if(key.parent){
                    key.parent.id
                }else {
                    key.id
                }
            }
            // calcular el promedio de los resultados por categoria
            scoresByCategory = scoresByCategory.collectEntries {key, value ->
	    	[Category.get(key),  value.values().sum()/value.size() ]}
        }
        //scoresByCategory representa las categorias y su puntaje [(Object) categoria: (int) puntaje]
        //scores representan las preguntas y puntaje [(Object) Question: (int) puntaje]
        return [scoresByCategory: scoresByCategory, scores: scores]
    }



    /*implementación concreta MECI - Tabulación de encuestas
    Retorna la puntuacion de las categorias de nivel mas bajo en las encuestas ingresadas
    Retorna todas las preguntas evaluadas y su puntaje individual
     */
    def getBasicScores(List<Assessment> assessments){
        def scores = [:].withDefault {[]}
    	// obtener todos los puntajes por pregunta
    	for(assesment in assessments) {
            for(answer in assesment?.answers) {
                scores[answer.question.id].add(answer.valueScale)
            }
    	}
    	// scores representa las todas las respuestas de cada pregunta [id de pregunta:[2,2,1,4]]

    	//obtener el resultado final por pregunta evaluada sobre las evaluaciones ingresadas
    	for(score in scores) {
            //obtener el numero de respuestas por pregunta [2,2,1,4] = 4
            def total = score.getValue().size()

            // obtener la tabla de frecuencias freqs = [valor: frecuencia] -> [2:2,1:1,4:1]
            def freqs = score.getValue().countBy {it}

            // obtener el valor parcial de cada valor
            def p = []
            freqs.each { key, value -> p.add((value/total)*key) }
            // obtener el puntaje de la pregunta
            def pp = p.sum()
            // atualizar el score de la pregunta con su puntaje
            score.value = pp
    	}

    	// transformar la clave de la pregunta con el objeto pregunta
    	// scores representa el puntaje de la pregunta [pregunta: 2.5]
    	scores = scores.collectEntries {key, value -> [Question.get(key), value]}


    	// obtener las preguntas agrupadas por su categoria inicial [id de categoria:[pregunta:puntaje]]
    	def scoresByCategory = scores.groupBy {key,value -> key.category.id}


    	// calcular el promedio de los resultados por categoria y
    	// transformar la clave de la categoria con el objeto categoria
    	// se obtiene la categoria relacionada con la pregunta
    	scoresByCategory = scoresByCategory.collectEntries {key, value ->
            [Category.get(key), //se transfoma en objeto categoria
    		value.values().sum()/value.size()
            ]}
    	//scoresByCategory representa la categoria de nivel mas bajo y su puntaje promedio [categoria:puntaje]
        //scores representan todas las preguntas y su puntaje
        return [scoresByCategory: scoresByCategory, scores: scores]
    }


    /*
    procesamiento de resultados para mostrar en las graficas de google visualization api
     */
    def googleAPIprocess(def scoresByCategory){
        def scoreFinal = []
        for(result in scoresByCategory){
            def criteria = ''
            def color = ''
            if(result.value < 3){
                criteria = 'Bajo'
                color = '#FF0000'
            }else if(result.value < 4){
                criteria = 'Medio'
                color = '#FCFF00'
            }else if(result.value <= 5){
                criteria = 'Alto'
                color = '#0AB200'
            }
            scoreFinal.add([result.key.category, result.value, color, criteria])
        }
        return scoreFinal
    }
}
