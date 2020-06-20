package valueme

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class UserAccount implements Serializable {

    private static final long serialVersionUID = 1

    String username
    String password
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    Category category
    String fullName

    Set<RoleGroup> getAuthorities() {
        (UserAccountRoleGroup.findAllByUserAccount(this) as List<UserAccountRoleGroup>)*.roleGroup as Set<RoleGroup>
    }

    static constraints = {
        password nullable: false, blank: false, password: true, display: false
        username nullable: false, blank: false, unique: true, email: true
        category nullable: true // for administrators accounts
    }

    static mapping = {
	    password column: '`password`'
    }

    static belongsTo = [category: Category]
}
