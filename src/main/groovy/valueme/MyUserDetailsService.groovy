package valueme

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService
import grails.plugin.springsecurity.userdetails.NoStackUsernameNotFoundException
import grails.transaction.Transactional
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException
import grails.plugin.springsecurity.userdetails.GrailsUser
import org.springframework.security.core.GrantedAuthority


class MyUserDetailsService implements GrailsUserDetailsService {

	static final List NO_ROLES = [new SimpleGrantedAuthority(SpringSecurityUtils.NO_ROLE)]

	UserDetails loadUserByUsername(String username, boolean loadRoles)
	throws UsernameNotFoundException {
		return loadUserByUsername(username)
	}

	@Transactional(readOnly=true, noRollbackFor=[IllegalArgumentException, UsernameNotFoundException])
	UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		UserAccount user = UserAccount.findByUserAccount(username)

		if (!user) throw new NoStackUsernameNotFoundException()

		def roles = Role.findAllByRoleInList(user.roles)

		def permissions = roles.collect { it.permissions }.flatten().unique()

		Collection<GrantedAuthority> authorities = permissions.collect {
			new SimpleGrantedAuthority(it)
		}
		
		return new GrailsUser(user.userAccount, user.passwordHash, user.active, true,
			true, true, authorities, user.id)
	}

}
