package valueme

import grails.gorm.DetachedCriteria
import groovy.transform.ToString
import org.codehaus.groovy.util.HashCodeHelper
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@ToString(cache=true, includeNames=true, includePackage=false)
class UserAccountRoleGroup implements Serializable {

	private static final long serialVersionUID = 1

	UserAccount userAccount
	RoleGroup roleGroup

	@Override
	boolean equals(other) {
		if (other instanceof UserAccountRoleGroup) {
			other.userAccountId == userAccount?.id && other.roleGroupId == roleGroup?.id
		}
	}

    @Override
	int hashCode() {
	    int hashCode = HashCodeHelper.initHash()
        if (userAccount) {
            hashCode = HashCodeHelper.updateHash(hashCode, userAccount.id)
		}
		if (roleGroup) {
		    hashCode = HashCodeHelper.updateHash(hashCode, roleGroup.id)
		}
		hashCode
	}
	
	static UserAccountRoleGroup get(long userAccountId, long roleGroupId) {
		criteriaFor(userAccountId, roleGroupId).get()
	}

	static boolean exists(long userAccountId, long roleGroupId) {
		criteriaFor(userAccountId, roleGroupId).count()
	}

	private static DetachedCriteria criteriaFor(long userAccountId, long roleGroupId) {
		UserAccountRoleGroup.where {
			userAccount == UserAccount.load(userAccountId) &&
			roleGroup == RoleGroup.load(roleGroupId)
		}
	}

	static UserAccountRoleGroup create(UserAccount userAccount, RoleGroup roleGroup, boolean flush = false) {
		def instance = new UserAccountRoleGroup(userAccount: userAccount, roleGroup: roleGroup)
		instance.save(flush: flush)
		instance
	}

	static boolean remove(UserAccount u, RoleGroup rg) {
		if (u != null && rg != null) {
			UserAccountRoleGroup.where { userAccount == u && roleGroup == rg }.deleteAll()
		}
	}

	static int removeAll(UserAccount u) {
		u == null ? 0 : UserAccountRoleGroup.where { userAccount == u }.deleteAll() as int
	}

	static int removeAll(RoleGroup rg) {
		rg == null ? 0 : UserAccountRoleGroup.where { roleGroup == rg }.deleteAll() as int
	}

	static constraints = {
	    roleGroup nullable: false
		userAccount nullable: false, validator: { UserAccount u, UserAccountRoleGroup ug ->
			if (ug.roleGroup?.id) {
				if (UserAccountRoleGroup.exists(u.id, ug.roleGroup.id)) {
					return ['userGroup.exists']
				}
			}
		}
	}

	static mapping = {
		id composite: ['roleGroup', 'userAccount']
		version false
	}
}
