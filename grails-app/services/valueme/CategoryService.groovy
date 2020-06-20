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
            (type.applyTo == Constants.MECI_APPLY_TO || name == Constants.MECI_ROOT)
        }
        return query.list()
    }

    def listProcessCategories(){
        def query = Category.where {
            (type.applyTo == Constants.PROCESS_APPLY_TO || name == Constants.PROCESS_ROOT)
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
    	if(category.isDirty('parent')){ //if parent has changed
            log.info 'parent has changed for category ' + category
            Category initialParent = category.getPersistentValue('parent')
            Category newParent = category.parent
            log.info 'the initialParent is ' + initialParent
            log.info 'the newParent is ' + newParent
            if(initialParent){
                initialParent.removeFromChilds(category)
            }
            if(newParent){
            newParent.addToChilds(category)
            }
        }
        category.save flush:true
    }
}