import valueme.*

class BootStrap {
    
    def init = { servletContext ->

    	// create initial roles, permissions and userAccount admin if not exists

    	if (!Permission.count()) {
            new Permission(permission : "ROLE_gestionar evaluación").save(failOnError: true)
            new Permission(permission : "ROLE_realizar evaluación").save(failOnError: true)
            new Permission(permission : "ROLE_gestion usuarios").save(failOnError: true)
            new Permission(permission : "ROLE_ver resultados").save(failOnError: true)
            new Permission(permission : "ROLE_gestionar parámetros").save(failOnError: true)
    	}

    	if (!Role.count()) {
            new Role(permissions:["ROLE_realizar evaluación"], role: "Evaluador").save(failOnError: true)
            new Role(permissions:["ROLE_gestionar evaluación", "ROLE_gestion usuarios", "ROLE_ver resultados"], role: "Analista").save(failOnError: true)
            new Role(permissions:["ROLE_realizar evaluación", "ROLE_ver resultados","ROLE_gestionar evaluación","ROLE_gestion usuarios","ROLE_gestionar parámetros"], role: "Administrador").save(failOnError: true)
    	}

        //create sample administrator
    	if(!UserAccount.findByUserAccount("admin@valueme.com")){
            new UserAccount(
                active : true,
                fullName : "administrator",
                passwordHash : "1",
                passwordHashAlgorithm : "bcrypt",
                userAccount : "admin@valueme.com",
                roles : [ "Evaluador","Analista","Administrador"]
            ).save(failOnError: true)
    	}

	    //String id
	    //String name
	    //String value
	    //String description
	    //String label

        if(!Param.count()){
            new Param(name: 'question.categoryType', description: 'tipo de categoria raiz del conjunto de preguntas', value: 'Módulo', label: 'Módulos').save(failOnError: true)
            new Param(name: 'mail.username', description: 'nombre de correo electronico de envio').save(failOnError: true)
            new Param(name: 'mail.password', description: 'contraseña de correo electronico de envio').save(failOnError: true)
            new Param(name: 'survey.categoryType', description: 'tipo de categoria asociada a una encuesta', value: 'Proceso', label: 'Procesos').save(failOnError: true)
            new Param(name: 'mail.active', description: 'habilitar envio de correo electronico en la creación o modificación de cuentas de usuario', value: false).save(failOnError: true)
            new Param(name: 'html.meci', description: 'Texto acerca del meci en la pagina principal en HTML' , value: '<h4 style="text-align: center;">El Modelo Est&aacute;ndar de Control Interno para el Estado Colombiano &ndash; MECI proporciona la estructura b&aacute;sica para evaluar la estrategia, la gesti&oacute;n y los propios mecanismos de evaluaci&oacute;n del proceso administrativo, y aunque promueve una estructura uniforme, puede ser adaptada a las necesidades espec&iacute;ficas de cada entidad, a sus objetivos, estructura, tama&ntilde;o, procesos y servicios que suministran. El MECI concibe el Control Interno como un conjunto de elementos interrelacionados, donde intervienen todos los servidores de la entidad, como responsables del control en el ejercicio de sus actividades; busca garantizar razonablemente el cumplimiento de los objetivos institucionales y la contribuci&oacute;n de &eacute;stos a los fines esenciales del Estado; a su vez, persigue la coordinaci&oacute;n de las acciones, la fluidez de la informaci&oacute;n y comunicaci&oacute;n, anticipando y corrigiendo, de manera oportuna, las debilidades que se presentan en el quehacer institucional.</h4>').save(failOnError: true)
            new Param(name: 'survey.maxAssessments', description: 'Número maximo de encuestas que un usuario puede completar', value: '1').save(failOnError: true)
        }

        
        if(!CategoryType.count()){
            //Create MECI Structure 2014 Type Categories  
            CategoryType modulo = new CategoryType(categoryType: 'Módulo').save(failOnError: true)
            CategoryType componente = new CategoryType(categoryType: 'Componente').save(failOnError: true)
            CategoryType elemento = new CategoryType(categoryType: 'Elemento').save(failOnError: true)
            //Structure for users
            CategoryType proceso = new CategoryType(categoryType: 'Proceso').save(failOnError: true)
            CategoryType area = new CategoryType(categoryType: 'Área').save(failOnError: true)

            
        //create MECI 2014 Categories
                //String category
	            //String color
	            //String type
	            //List<Category> childs
	            //Category parent
	            //boolean active
	            //int order
	            //String description
            Category modulo_de_control_de_planeacion_y_gestion = new Category(category: 'Módulo de Control de Planeación y Gestión', color: 'FFFFFF', type: 'Módulo', active: true, order: 0).save(failOnError: true)
            Category modulo_de_control_de_evaluacion_y_seguimiento = new Category(category: 'Módulo de Control de Evaluación y Seguimiento', color: 'FFFFFF', type: 'Módulo', active: true, order: 1).save(failOnError: true)
            Category eje_transversal_informacion_y_comunicacion = new Category(category: 'Eje Transversal: Información y Comunicación', color: 'FFFFFF', type: 'Módulo', active: true, order: 2).save(failOnError: true)

            
            Category talento_humano = new Category(category: 'Talento Humano', color: 'FFFFFF', type: 'Componente', active: true, parent: modulo_de_control_de_planeacion_y_gestion, order: 0).save(failOnError: true)
            Category talento_humano_1 = new Category(category: 'Acuerdos, Compromisos y Protocolos éticos', color: 'FFFFFF', type: 'Elemento', active: true, parent: talento_humano, order: 0).save(failOnError: true)
            Category talento_humano_2 = new Category(category: ' Desarrollo del Talento Humano', color: 'FFFFFF', type: 'Elemento', active: true, parent: talento_humano, order: 1).save(failOnError: true)
            
            Category direcionamiento_estrategico = new Category(category: ' Direccionamiento Estratégico', color: 'FFFFFF', type: 'Componente', active: true, parent: modulo_de_control_de_planeacion_y_gestion, order: 1).save(failOnError: true)
            Category direcionamiento_estrategico_1 = new Category(category: 'Planes, Programas y Proyectos', color: 'FFFFFF', type: 'Elemento', active: true, parent: direcionamiento_estrategico, order: 0).save(failOnError: true)
            Category direcionamiento_estrategico_2 = new Category(category: 'Modelo de Operación por Procesos', color: 'FFFFFF', type: 'Elemento', active: true, parent: direcionamiento_estrategico, order: 1).save(failOnError: true)
            Category direcionamiento_estrategico_3 = new Category(category: 'Estructura Organizacional', color: 'FFFFFF', type: 'Elemento', active: true, parent: direcionamiento_estrategico, order: 2).save(failOnError: true)
            Category direcionamiento_estrategico_4 = new Category(category: 'Indicadores de Gestión', color: 'FFFFFF', type: 'Elemento', active: true, parent: direcionamiento_estrategico, order: 3).save(failOnError: true)
            Category direcionamiento_estrategico_5 = new Category(category: 'Políticas de Operación', color: 'FFFFFF', type: 'Elemento', active: true, parent: direcionamiento_estrategico, order: 4).save(failOnError: true)

            Category administracion_del_riesgo = new Category(category: ' Administración del Riesgo', color: 'FFFFFF', type: 'Componente', active: true, parent: modulo_de_control_de_planeacion_y_gestion, order: 2).save(failOnError: true)
            Category administracion_del_riesgo_1 = new Category(category: 'Políticas de Administración del Riesgo', color: 'FFFFFF', type: 'Elemento', active: true, parent: administracion_del_riesgo, order: 0).save(failOnError: true)
            Category administracion_del_riesgo_2 = new Category(category: 'Identificación del Riesgo', color: 'FFFFFF', type: 'Elemento', active: true, parent: administracion_del_riesgo, order: 1).save(failOnError: true)
            Category administracion_del_riesgo_3 = new Category(category: 'Análisis y Valoración del Riesgo', color: 'FFFFFF', type: 'Elemento', active: true, parent: administracion_del_riesgo, order: 2).save(failOnError: true)


            Category autoevaluacion_institucional = new Category(category: 'Autoevaluación Institucional', color: 'FFFFFF', type: 'Componente', active: true, parent: modulo_de_control_de_evaluacion_y_seguimiento, order: 0).save(failOnError: true)
            Category autoevaluacion_del_control_y_gestion = new Category(category: 'Autoevaluación del Control y Gestión', color: 'FFFFFF', type: 'Elemento', active: true, parent: autoevaluacion_institucional, order: 0).save(failOnError: true)
            

            Category auditoria_interna = new Category(category: 'Auditoría Interna', color: 'FFFFFF', type: 'Componente', active: true, parent: modulo_de_control_de_evaluacion_y_seguimiento, order: 1).save(failOnError: true)
            Category auditoria_interna_1 = new Category(category: 'Auditoría Interna', color: 'FFFFFF', type: 'Elemento', active: true, parent: auditoria_interna, order: 0).save(failOnError: true)

            Category planes_de_mejoramiento = new Category(category: 'Planes de Mejoramiento', color: 'FFFFFF', type: 'Componente', active: true, parent: modulo_de_control_de_evaluacion_y_seguimiento, order: 2).save(failOnError: true)
            Category plan_de_mejoramiento = new Category(category: 'Plan de Mejoramiento', color: 'FFFFFF', type: 'Elemento', active: true, parent: planes_de_mejoramiento, order: 0).save(failOnError: true)

            //Company process or Areas
            Category estrategico = new Category(category: 'Estratégicos', color: 'FFFFFF', type: 'Proceso', active: true, order: 0).save(failOnError: true)
            
            Category misionales = new Category(category: 'Misionales', color: 'FFFFFF', type: 'Proceso', active: true, order: 0).save(failOnError: true)
            
            Category apoyo = new Category(category: 'Apoyo', color: 'FFFFFF', type: 'Proceso', active: true, order: 0).save(failOnError: true)
            Category sistemas = new Category(category: 'Área de Sistemas', color: 'FFFFFF', type: 'Área', parent: apoyo, active: true, order: 0).save(failOnError: true)
            
            Category evaluacion = new Category(category: 'Evaluación', color: 'FFFFFF', type: 'Proceso', active: true, order: 0).save(failOnError: true)


            //Create a example Survey
            //First we need to create a Question
            //String question
	        //Category category
	        //boolean active
            String[] questionsText = [
            "¿Existe un documento o código de ética que contenga los Acuerdos, Compromisos o Protocolos Éticos?",
            "¿Se difunden los Acuerdos, Compromisos o Protocolos Éticos a todos los servidores de la Entidad.?",
            "¿El documento o código de ética se adoptó con la participación de los representantes de las dependencias de la entidad.?",
            "¿Se han puesto en marcha políticas y estrategias de gestión para aplicar el documento o código de ética en todas las dependencias.?",
            "¿Se difunden los Acuerdos, Compromisos o Protocolos Éticos a la ciudadanía o las personas u organizaciones interesadas en gestión de la entidad.?",
            "¿Los procesos de reinducción permiten la actualización de todos los servidores en las nuevas orientaciones técnicas y normativas que afectan el quehacer institucional de la entidad.?",
            "¿La entidad adopta anualmente un plan institucional de formación y Capacitación.?",
            "¿Son consultados los servidores sobre sus necesidades de capacitación, a través de encuestas o reuniones de trabajo.?",
            "¿La capacitación recibida contribuye al desarrollo de conocimientos y capacidades para un mejor desempeño en el puesto de trabajo.?",
            "¿La entidad adopta y ejecuta programas de bienestar social laboral.?",
            "¿Existe compromiso de la alta dirección con la asignación y uso transparente y racional de los recursos.?",
            "¿El estilo de dirección facilita la resolución de conflictos internos y externos.?",
            "¿Existe compromiso de la alta dirección con las políticas y objetivos del Control Interno.?",
            "¿La alta dirección asume la responsabilidad de las acciones del mejoramiento y compromisos adquiridos con los entes de control del Estado.?"    
            ]

            def questions = []
            questions.add(new Question(question: questionsText[0], category: talento_humano_1, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[1], category: talento_humano_2, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[2], category: talento_humano_2, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[3], category: direcionamiento_estrategico_1, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[4], category: direcionamiento_estrategico_2, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[5], category: direcionamiento_estrategico_3, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[6], category: direcionamiento_estrategico_4, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[7], category: direcionamiento_estrategico_5, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[8], category: administracion_del_riesgo_1, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[9], category: administracion_del_riesgo_2, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[10], category: administracion_del_riesgo_2, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[11], category: administracion_del_riesgo_3, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[12], category: autoevaluacion_del_control_y_gestion, active: true).save(failOnError: true))
            questions.add(new Question(question: questionsText[13], category: plan_de_mejoramiento, active: true).save(failOnError: true))
            

	        //Category category
	        //List<Question> questions
	        //int vigency
            Survey survey = new Survey(questions: questions, vigency: 2020, category: sistemas).save(failOnError: true)

            //Set the vingecy Active:

            //@BindingFormat('dd/MM/yyyy')
	        //Date startDate
	        //@BindingFormat('dd/MM/yyyy')
	        //Date endDate
	        //int vigency
	        //boolean active
            Schedule schedule = new Schedule(startDate: '01/01/2020', endDate: '31/12/2020', vigency: 2020, active: true).save(failOnError: true)

            //Create a test user:

            new UserAccount(
                active : true,
                fullName : "user",
                passwordHash : "1",
                passwordHashAlgorithm : "bcrypt",
                userAccount : "user@valueme.com",
                roles : ["Evaluador"],
                category: sistemas
            ).save(failOnError: true)
        }


    }
    def destroy = {
    }
}
