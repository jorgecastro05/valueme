package valueme

class CategoryTypeService {

    def listMeciCategoyTypes(){
        def query = CategoryType.where {
            (applyTo == Constants.MECI_APPLY_TO)
        }
        return query.list()
    }

    def listProcessCategoryTypes(){
        def query = CategoryType.where {
            (applyTo == Constants.PROCESS_APPLY_TO)
        }
        return query.list()
    }

    def listRootCategoryTypes(){
        def query = CategoryType.where {
            (applyTo == Constants.ROOT_APPLY_TO)
        }
        return query.list()
    }

}