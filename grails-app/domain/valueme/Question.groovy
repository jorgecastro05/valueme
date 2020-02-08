package valueme

class Question {

	String id
	String question
	Category category
	boolean active

	static belongsTo = [category: Category]

    static constraints = {
    	question unique : true
    }
}
