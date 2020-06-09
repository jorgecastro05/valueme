package valueme

class Answer {

	Question question
	Integer valueScale
	List<CustomField> customFields

	static hasMany = [customFields: CustomField]
	static belongsTo = [question: Question]

	static constraints = {
		// value indicates current value entered, object is current object
		// return null indicates the message to render
		// bypass first validation to force use custom
		valueScale nullable:true, validator: {val, obj -> if(val == null) return ['null',obj.question?.question] }
	}
}
