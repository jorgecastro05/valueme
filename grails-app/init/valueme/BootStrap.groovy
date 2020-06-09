package valueme
import grails.gorm.transactions.Transactional

class BootStrap {

    def init = { servletContext ->
    populate()
    }
    def destroy = {
    }

    @Transactional
    void populate() {
        log.info "Init bootstraping application"
        Role role1 = new Role(authority : "ROLE_gestionar evaluación").save(failOnError: true)
        Role role2 = new Role(authority : "ROLE_realizar evaluación").save(failOnError: true)
        Role role3 = new Role(authority : "ROLE_gestion usuarios").save(failOnError: true)
        Role role4 = new Role(authority : "ROLE_ver resultados").save(failOnError: true)
        Role role5 = new Role(authority : "ROLE_gestionar parámetros").save(failOnError: true)

        RoleGroup administrador = new RoleGroup(name: 'Administrador').save(failOnError: true)
        RoleGroup analista = new RoleGroup(name: 'Analista').save(failOnError: true)
        RoleGroup evaluador = new RoleGroup(name: 'Evaluador').save(failOnError: true)
        
        UserAccount userAdmin = new UserAccount(username: 'admin@valueme.com', password: '1', fullName: 'administrador').save(failOnError: true)

        // create roleGroups
        RoleGroupRole.create administrador, role1
        RoleGroupRole.create administrador, role2
        RoleGroupRole.create administrador, role3
        RoleGroupRole.create administrador, role4
        RoleGroupRole.create administrador, role5
        
        RoleGroupRole.create analista, role1
        RoleGroupRole.create analista, role3
        RoleGroupRole.create analista, role4

        RoleGroupRole.create evaluador, role2

        UserAccountRoleGroup.create userAdmin, administrador

        //create parameters
        new Param(name: 'account.categoryType', description: 'tipo de categoria asociada a una cuenta', value: 'Proceso', label: 'Procesos').save(failOnError: true)
        new Param(name: 'survey.categoryType', description: 'tipo de categoria asociada a una encuesta', value: 'Proceso', label: 'Procesos').save(failOnError: true)
        new Param(name: 'question.categoryType', description: 'tipo de categoria raiz del conjunto de preguntas', value: 'Módulo', label: 'Módulos').save(failOnError: true)
        new Param(name: 'mail.username', description: 'nombre de correo electronico de envio').save(failOnError: true)
        new Param(name: 'mail.password', description: 'contraseña de correo electronico de envio').save(failOnError: true)
        new Param(name: 'mail.active', description: 'habilitar envio de correo electronico en la creación o modificación de cuentas de usuario', value: false).save(failOnError: true)
        new Param(name: 'html.meci', description: 'Texto acerca del meci en la pagina principal en HTML' , value: '').save(failOnError: true)
        new Param(name: 'survey.maxAssessments', description: 'Número maximo de encuestas que un usuario puede completar', value: '1').save(failOnError: true)


        //Create MECI Structure 2014 Type Categories

        CategoryType modulo = new CategoryType(name: 'Módulo').save(failOnError: true)
        CategoryType componente = new CategoryType(name: 'Componente').save(failOnError: true)
        CategoryType elemento = new CategoryType(name: 'Elemento').save(failOnError: true)
        //Structure for users
        CategoryType proceso = new CategoryType(name: 'Proceso').save(failOnError: true)

        //Company process or Areas
        Category estrategico = new Category(name: 'Estratégicos', color: 'FFFFFF', type: proceso, active: true, order: 0).save(failOnError: true)
        Category misionales = new Category(name: 'Misionales', color: 'FFFFFF', type: proceso, active: true, order: 0).save(failOnError: true)
        Category servicios = new Category(name: 'Área de Servicios', color: 'FFFFFF', type: proceso, active: true, order: 0).save(flush: true)
        Category apoyo = new Category(name: 'Apoyo', color: 'FFFFFF', type: proceso, active: true, order: 0)
        .addToChilds(servicios).save(flush: true)


        //create MECI 2014 Categories

        Category eje_transversal_informacion_y_comunicacion = new Category(name: 'Eje Transversal: Información y Comunicación', color: 'FFFFFF', type: modulo, active: true, order: 2)

        Category talento_humano = new Category(name: 'Talento Humano', color: 'FFFFFF', type: componente, active: true, order: 0)
        Category talento_humano_1 = new Category(name: 'Acuerdos, Compromisos y Protocolos éticos', color: 'FFFFFF', type: elemento, active: true, order: 0)
        Category talento_humano_2 = new Category(name: ' Desarrollo del Talento Humano', color: 'FFFFFF', type: elemento, active: true, order: 1)
        
        talento_humano
        .addToChilds(talento_humano_1)
        .addToChilds(talento_humano_2).save(flush: true)

        Category direcionamiento_estrategico = new Category(name: 'Direccionamiento Estratégico', color: 'FFFFFF', type: componente, active: true, order: 1)
        Category direcionamiento_estrategico_1 = new Category(name: 'Planes, Programas y Proyectos', color: 'FFFFFF', type: elemento, active: true, order: 0)
        Category direcionamiento_estrategico_2 = new Category(name: 'Modelo de Operación por Procesos', color: 'FFFFFF', type: elemento, active: true, order: 1)
        Category direcionamiento_estrategico_3 = new Category(name: 'Estructura Organizacional', color: 'FFFFFF', type: elemento, active: true, order: 2)
        Category direcionamiento_estrategico_4 = new Category(name: 'Indicadores de Gestión', color: 'FFFFFF', type: elemento, active: true, order: 3)
        Category direcionamiento_estrategico_5 = new Category(name: 'Políticas de Operación', color: 'FFFFFF', type: elemento, active: true, order: 4)
        
        direcionamiento_estrategico
        .addToChilds(direcionamiento_estrategico_1)
        .addToChilds(direcionamiento_estrategico_2)
        .addToChilds(direcionamiento_estrategico_3)
        .addToChilds(direcionamiento_estrategico_4)
        .addToChilds(direcionamiento_estrategico_5).save(flush: true)

        Category administracion_del_riesgo = new Category(name: 'Administración del Riesgo', color: 'FFFFFF', type: componente, active: true, order: 2)
        Category administracion_del_riesgo_1 = new Category(name: 'Políticas de Administración del Riesgo', color: 'FFFFFF', type: elemento, active: true, order: 0)
        Category administracion_del_riesgo_2 = new Category(name: 'Identificación del Riesgo', color: 'FFFFFF', type: elemento, active: true, order: 1)
        Category administracion_del_riesgo_3 = new Category(name: 'Análisis y Valoración del Riesgo', color: 'FFFFFF', type: elemento, active: true, order: 2)
    
        administracion_del_riesgo
        .addToChilds(administracion_del_riesgo_1)
        .addToChilds(administracion_del_riesgo_2)
        .addToChilds(administracion_del_riesgo_3).save(flush: true)

        Category modulo_de_control_de_planeacion_y_gestion = new Category(name: 'Módulo de Control de Planeación y Gestión', color: 'FFFFFF', type: modulo, active: true, order: 0)
        .addToChilds(administracion_del_riesgo)
        .addToChilds(direcionamiento_estrategico)
        .addToChilds(talento_humano).save(flush: true)
    
            
        Category autoevaluacion_institucional = new Category(name: 'Autoevaluación Institucional', color: 'FFFFFF', type: componente, active: true, order: 0)
        Category autoevaluacion_del_control_y_gestion = new Category(name: 'Autoevaluación del Control y Gestión', color: 'FFFFFF', type: elemento, active: true, order: 0)
        
        autoevaluacion_institucional.addToChilds(autoevaluacion_del_control_y_gestion).save(flush: true)

        Category auditoria_interna = new Category(name: 'Auditoría Interna', color: 'FFFFFF', type: componente, active: true, order: 1)
        Category auditoria_interna_1 = new Category(name: 'Auditoría Interna', color: 'FFFFFF', type: elemento, active: true, order: 0)

        auditoria_interna.addToChilds(auditoria_interna_1).save(flush: true)

        Category planes_de_mejoramiento = new Category(name: 'Planes de Mejoramiento', color: 'FFFFFF', type: componente, active: true, order: 2)
        Category plan_de_mejoramiento = new Category(name: 'Plan de Mejoramiento', color: 'FFFFFF', type: elemento, active: true, order: 0)
        
        planes_de_mejoramiento.addToChilds(plan_de_mejoramiento).save(flush: true)

        Category modulo_de_control_de_evaluacion_y_seguimiento = new Category(name: 'Módulo de Control de Evaluación y Seguimiento', color: 'FFFFFF', type: modulo, active: true, order: 1)
        .addToChilds(planes_de_mejoramiento)
        .addToChilds(auditoria_interna)
        .addToChilds(autoevaluacion_institucional).save(flush: true)


        //Create a example Survey

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
            questions.add(new Question(text: questionsText[0], category: Category.findByName("Talento Humano").childs[0], active: true))
            questions.add(new Question(text: questionsText[1], category: Category.findByName("Talento Humano").childs[1], active: true))
            questions.add(new Question(text: questionsText[2], category: Category.findByName("Talento Humano").childs[1], active: true))
            questions.add(new Question(text: questionsText[3], category: Category.findByName("Direccionamiento Estratégico").childs[0], active: true))
            questions.add(new Question(text: questionsText[4], category: Category.findByName("Direccionamiento Estratégico").childs[1], active: true))
            questions.add(new Question(text: questionsText[5], category: Category.findByName("Direccionamiento Estratégico").childs[2], active: true))
            questions.add(new Question(text: questionsText[6], category: Category.findByName("Direccionamiento Estratégico").childs[3], active: true))
            questions.add(new Question(text: questionsText[7], category: Category.findByName("Direccionamiento Estratégico").childs[4], active: true))
            questions.add(new Question(text: questionsText[8], category: Category.findByName("Administración del Riesgo").childs[0], active: true))
            questions.add(new Question(text: questionsText[9], category: Category.findByName("Administración del Riesgo").childs[1], active: true))
            questions.add(new Question(text: questionsText[10], category: Category.findByName("Administración del Riesgo").childs[2], active: true))
            questions.add(new Question(text: questionsText[11], category: Category.findByName("Administración del Riesgo").childs[2], active: true))
            questions.add(new Question(text: questionsText[12], category: Category.findByName("Autoevaluación del Control y Gestión"), active: true))
            questions.add(new Question(text: questionsText[13], category: Category.findByName("Plan de Mejoramiento"), active: true))
                
        Survey survey = new Survey(questions: questions, vigency: 2020, category: Category.findByName("Área de Servicios")).save(failOnError: true)
        Schedule schedule = new Schedule(startDate: '01/01/2020', endDate: '31/12/2020', vigency: 2020, active: true).save(failOnError: true)

        UserAccount user = new UserAccount( fullName : "user", password : "1", username : "user@valueme.com", category: Category.findByName("Área de Servicios")).save(failOnError: true)
        UserAccountRoleGroup.create user, evaluador

        //Create test assessment
        

        log.info "Finished bootstraping application"
    }

}
