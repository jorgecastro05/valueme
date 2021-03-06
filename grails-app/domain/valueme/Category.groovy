package valueme

class Category {

	String name
	String color
	CategoryType type
	List<Category> childs
	Category parent
	boolean active
	int order
	String description

	static hasOne = [type: CategoryType]
	static belongsTo = [parent: Category]
	static hasMany = [childs: Category]

	static constraints = {
		parent validator: { Category val, Category obj -> 
		if ( val == null && obj.type.name != Constants.ROOT_CATEGORY ) {
			return ['parent.required']
			}
		}

		name index: true, unique: 'type'
		type index: true
		description nullable: true
	}

	static mapping = {
		sort order: "asc"
		order column: "order_number"
	}
}
