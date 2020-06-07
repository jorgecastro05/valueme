package valueme

class Question {

	String id
	String text
	Category category
	boolean active

	static belongsTo = [category: Category]

    static constraints = {
    	text unique : true
    }
}
