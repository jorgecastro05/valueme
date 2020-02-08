package valueme

class Category {

	String id
	String category
	String color
	String type
	List<Category> childs
	Category parent
	boolean active
	int order
	String description

	static hasOne = [parent:Category]
	static hasMany = [childs: Category]

	static constraints = {
		parent nullable: true
		category unique: 'type'
		category index: true
		type index: true
		description nullable: true
	}

	static mapping = {
		sort order: "asc"
		order column: "order_number"
	}

}
