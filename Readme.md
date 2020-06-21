## Roadmap to Grails 4.0.X
## To do
- Remove logic from views
- Remove special logic for controllers and delegate it into services
- Put params result as global variables - done
- create views and controllers for permissions and roles
- save user account through multiple requests in individual results.

## Testing Result

- Principal [FIXED]
- Gestion de Usuarios
  - search not working [FIXED]
  - Edit throws errors [FIXED]
  - Change password reset roles.
- Parametros de Evaluación
  - Reasign parent category in edition not working [FIXED]
  - Root categories dont apear in creation [FIXED]
  - Parent caregory must be required in creation [FIXED]
  - Remove configuration params unused [FIXED]
- Evaluación
  - Survey show not showing questions. [FIXED]
  - Cant create asessment new bug
  - Survey edit not showing questions [FIXED]
  - if new survey is created and fail for validation, the redirect error not populates the category and questions.
  - Copiar encuestas para nueva vigencia not working. [FIXED]
  - Encuestas realizadas throw errors [FIXED]
- Cronograma [FIXED]
- Resultados [FIXED]
  


## Configuration for Read Only fields
- User Accounts
- Campos personalizados
  - Tipo, seccion [DONE]
- Parametros [DONE]
  - nombre [DONE]
- Cronograma
  - vigencia [DONE]