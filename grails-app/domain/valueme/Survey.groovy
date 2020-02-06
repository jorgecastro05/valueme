package valueme

class Survey {

	String id
	Category category
	List<Question> questions
	int vigency

    static constraints = {
    	category unique: 'vigency'
    }
}
