package valueme

class Assessment {

	UserAccount userAccount
	List<CustomField> customFields
	List<Answer> answers
	Survey survey
	int vigency
	boolean finished
	Category category

	static belongsTo = [userAccount: UserAccount, category: Category, survey: Survey]
	static hasMany = [customFields: CustomField, answers: Answer]

	static constraints = {
		answers cascade: "all-delete-orphan"
		finished defaultValue: false
	}
}
