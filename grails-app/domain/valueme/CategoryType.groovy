package valueme

class CategoryType {

	String id
	String name

    static constraints = {
    	name unique: true, index: true
    }

	static hasMany = [ categories: Category ]
}
