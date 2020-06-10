package valueme

class CategoryType {

	String name
	String applyTo

    static constraints = {
    	name unique: true, index: true
		applyTo inList: ["process","meci", "root"]
    }

	static hasMany = [ categories: Category ]
}
