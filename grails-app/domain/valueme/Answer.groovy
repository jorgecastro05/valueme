package valueme

class Answer {

	String id
	Question question
	Integer valueScale
	List<CustomField> customFields

	static embedded = ['question','customFields']

	static constraints = {
		// value indicates current value entered, object is current object
		// return null indicates the message to render
		// bypass first validation to force use custom
		valueScale nullable:true, validator: {val, obj -> if(val == null) return ['null',obj.question?.question] }
	}
}
