package valueme

class CategoryService {

    def listRootMeciCategories(){
        def query = Category.where {
            (parent.name == Constants.MECI_ROOT)
        }
        return query.list()
    }

    def listMeciCategories(){
        def query = Category.where {
            (type.applyTo == Constants.MECI_APPLY_TO)
        }
        return query.list()
    }

    def listProcessCategories(){
        def query = Category.where {
            (type.applyTo == Constants.PROCESS_APPLY_TO)
        }
        return query.list()
    }

    def listRootProccessCategories(){
        def query = Category.where {
            (parent.name == Constants.PROCESS_ROOT)
        }
        return query.list()
    }

    def listChildProccessCategories(){
        def query = Category.where {
            (type.applyTo == Constants.PROCESS_APPLY_TO
             && parent.name != Constants.PROCESS_ROOT
             && childs.size() == 0 )
        }
        return query.list()
    }
    

    /*def listCategoriesByType(String categoryType) {
        def query = Category.where {
            (type.name == categoryType)
        }
        return query.list()
    }*/

    def saveCategory(Category category) {
    	if(category.parent){
            Category parent = category.parent
            parent.addToChilds(category)
            parent.save flush:true
    	}
    	category.save flush:true
    }

    def deleteCategory(Category category) {
    	if(category.parent){
            Category parent = category.parent
            parent.removeFromChilds(category)
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
            Category parent = category.parent    
            parent.addToChilds(category)
            parent.save flush:true
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