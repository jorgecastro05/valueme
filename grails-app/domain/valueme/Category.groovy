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

	static constraints = {
		parent nullable: true
		category unique: true
		category index: true
		type index: true
		description nullable: true
	}

	static mapping = {
		sort order: "asc"
	}

}
