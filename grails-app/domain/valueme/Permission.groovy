package valueme

class Permission {

	String id
	String permission

	static constraints = {
		permission matches: "^ROLE_.+"
		permission unique: true
		permission index: true
	}
}
