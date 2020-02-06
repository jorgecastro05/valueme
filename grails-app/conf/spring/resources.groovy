// Place your Spring DSL code here
import valueme.MyUserDetailsService
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

beans = {
	userDetailsService(MyUserDetailsService)
	passwordEncoder(BCryptPasswordEncoder)
}
