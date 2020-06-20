package valueme

import grails.gorm.transactions.Transactional

@Transactional
class SurveyService {

    /*
    Copia todas las encuestas creadas dada una vigencia inicial y una vigencia a la cual copiar las encuestas
     */
    def copySurveys(int beforeVigency, int afterVigency) {
        def surveys = Survey.findAllByVigency(beforeVigency)
        for(survey in surveys) {
            Survey newSurvey = new Survey(survey.properties)
            newSurvey.vigency = afterVigency
            newSurvey.save flush:true, failOnError: true
        }
    }

    /*
    Creación y/o actualización de encuestas:
    Dada una pregunta, una vigencia y un conjunto de categorias de encuesta
    crea o actualiza las encuestas de la vigencia para agregar la nueva pregunta
     */
    def updateSurveys(Question question, int vigency, List categorySurveys){		
        //crear o actualizar la pregunta en la base de datos, la actualiza si question tiene un id
        question.save flush: true, failOnError: true

        // Agregar la pregunta a cada encuesta
        // por cada categoria de encuesta crear la encuesta con la vigencia
        // en caso de que exista no se debe hacer nada
        for(categoryId in categorySurveys){
            Category category = Category.get(categoryId)
            Survey survey = Survey.findByCategoryAndVigency(category, vigency)
            if(!survey){
                survey = new Survey(category: category, vigency: vigency, questions: [])
                survey.save flush:true, failOnError: true
            }

            // buscar si la pregunta existe en la encuesta, 
            //si existe no se debe agregar ni modificar
            // si no existe se debe agregar a la lista de preguntas
            if(!survey.questions.find{ it.id == question.id}){
		        //agregar la pregunta a las encuestas	
                survey.questions.add(question)
		        // guardar la encuesta
                survey.save flush: true, failOnError: true
            }
        }
    }
}
