package valueme

class CategoryType {

	String id
	String categoryType

    static constraints = {
    	categoryType unique: true
    	categoryType index: true
    }
}
