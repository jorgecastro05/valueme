package valueme

class Survey {

	String id
	Category category
	List<Question> questions
	int vigency

	static belongsTo = [category: Category]	
	static hasMany = [questions: Question]

    static constraints = {
    	category unique: 'vigency'
    }
}
