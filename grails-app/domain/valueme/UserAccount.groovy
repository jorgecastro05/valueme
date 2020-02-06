package valueme
import org.springframework.security.crypto.password.PasswordEncoder

class UserAccount {

	String id
	boolean active
	List<String> roles
	String userAccount
	String passwordHash
	String passwordHashAlgorithm = "bcrypt"
	String fullName
	Category category
	int vigencyStart
	int vigencyEnd

	PasswordEncoder passwordEncoder

	// transient indicates that this object will not saved in database
	static transients = ['passwordEncoder']

	static constraints = {

		userAccount unique: true
		userAccount index: true
		userAccount email: true
		category nullable: true // for administrators accounts
		roles widget: 'select'
		//passwordHash password: true
		passwordHashAlgorithm display: false
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		// method isDirty ask if passwordHash has changed
		if (isDirty('passwordHash')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		passwordHash = passwordEncoder.encode(passwordHash)
	}

}
