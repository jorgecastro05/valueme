package valueme

class Survey {

	Category category
	List<Question> questions
	int vigency

	static belongsTo = [category: Category]	
	static hasMany = [questions: Question]

    static constraints = {
    	category unique: 'vigency'
    }
}
