package valueme

class Question {

	String id
	String question
	Category category
	boolean active

    static constraints = {
    	question unique : true
    }
}
