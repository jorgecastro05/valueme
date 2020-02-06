package valueme


class Role {

	String id
	String role
	List<String> permissions

	static constraints = {
		role unique: true
		role index: true
	}
}
