package valueme

import grails.transaction.Transactional

@Transactional
class CategoryService {

    def saveCategory(Category category) {

    	// add as child to new parent
    	if(category.parent){
            Category parent = category.parent
            // force GORM for MongoDB to issue an update for the given property name.
            parent.markDirty('childs')
            if(!parent.childs){
                parent.childs = []
            }
            parent.childs.add category
            parent.save flush:true
    	}
    	category.save flush:true
    }


    def deleteCategory(Category category){
    	if(category.parent){
            Category parent = category.parent
            parent.childs.remove category
            parent.save flush:true
    	}
    	category.childs?.each {
            it.parent = null
            it.save flush:true
    	}


    	category.delete flush:true
    }

    def updateCategory(Category category){
    	if(category.isDirty('parent')){
            // add as child to new parent
            if(category.parent){
    		Category parent = category.parent
    		// force GORM for MongoDB to issue an update for the given property name.
    		parent.markDirty('childs')
    		if(!parent.childs){
                    parent.childs = []
    		}
    		parent.childs.add category
    		parent.save flush:true
            }
            // delete old child of original parent
            Category originalParent = category.getPersistentValue('parent')
            if(originalParent){
    		originalParent.childs?.remove category
    		originalParent.save flush:true
            }
        }
        category.save flush:true
    }
}
