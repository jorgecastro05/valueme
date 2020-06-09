package valueme

class CategoryService {

    def listRootCategoriesByType(String categoryType) {
        def query = Category.where {
            (parent == null && type.name == categoryType)
        }
        return query.list()
    }

    def listChildCategoriesByType(String categoryType) {
        def query = Category.where {
            (parent != null && type.name == categoryType)
        }
        return query.list()
    }

    def listCategoriesByType(String categoryType) {
        def query = Category.where {
            (type.name == categoryType)
        }
        return query.list()
    }

}