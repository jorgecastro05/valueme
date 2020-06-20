import valueme.UserAccountPasswordEncoderListener
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
// Place your Spring DSL code here
beans = {
    userAccountPasswordEncoderListener(UserAccountPasswordEncoderListener)
    localeResolver(SessionLocaleResolver) {
        defaultLocale= new java.util.Locale('es');
    }
}
