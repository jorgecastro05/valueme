package valueme

class CategoryService {

    public final String meciRoot = 'MECI_ROOT';
    public final String processRoot = 'PROCESS_ROOT';


    def listRootMeciCategories(){
        def query = Category.where {
            (parent.name == meciRoot)
        }
        return query.list()
    }

    def listRootProccessCategories(){
        def query = Category.where {
            (parent.name == processRoot)
        }
        return query.list()
    }

    /*
    TODO: remove anotation
    def listChildCategoriesByType(String categoryType) {
        def query = Category.where {
            (parent != null && type.name == categoryType)
        }
        return query.list()
    }
    */

    def listCategoriesByType(String categoryType) {
        def query = Category.where {
            (type.name == categoryType)
        }
        return query.list()
    }

    def saveCategory(Category category) {
    	if(category.parent){
            category.parent.addToChilds(category)
            category.parent.save flush:true
    	}
    	category.save flush:true
    }

    def deleteCategory(Category category){
    	if(category.parent){
            category.parent.removeFromChilds(category)
            parent.save flush:true
    	}
    	category.childs?.each {
            it.parent = null
            it.save flush:true
    	}
    	category.delete flush:true
    }

    def updateCategory(Category category){
    	if(category.isDirty('parent')){ //Checks to see if a domain class instance has been modified.
            if(category.parent){
            category.parent.addToChilds(category)
            category.parent.save flush:true
            }
            // delete old child of original parent
            Category originalParent = category.getPersistentValue('parent')
            if(originalParent){
            originalParent.removeFromChilds(category)
    		originalParent.save flush:true
            }
        }
        category.save flush:true
    }
}