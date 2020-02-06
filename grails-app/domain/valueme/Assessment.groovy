package valueme

class Assessment {

	String id
	UserAccount userAccount
	List<CustomField> customFields
	List<Answer> answers
	Survey survey
	int vigency
	boolean finished
	Category category

	static embedded = ['customFields','answers']

	static constraints = {
		answers cascade: true
		finished defaultValue: false
	}
}
