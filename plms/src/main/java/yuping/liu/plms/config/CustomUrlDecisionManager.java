package yuping.liu.plms.config;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.Collection;


/*判断当前用户是否具备MyFilter过滤匹配后的角色*/
@Component/*声明bean的注解，组件，没特别的角色*/
/*自定义类实现看AccessDecisionManager接口*/
public class CustomUrlDecisionManager implements AccessDecisionManager {

    /*decide方法接收三个参数，其中第一个参数中保存了当前登录用户的角色信息，第三个参数则是UrlFilterInvocationSecurityMetadataSource中的
    getAttributes方法传来的，表示当前请求需要的角色（可能有多个）。*/
    @Override
    public void decide(Authentication authentication, Object o, Collection<ConfigAttribute> collection) throws AccessDeniedException, InsufficientAuthenticationException {
        for (ConfigAttribute configAttribute :  collection) {
            //当前请求需要的权限
            String needRole = configAttribute.getAttribute();
            if ("ROLE_LOGIN".equals(needRole)) {/*值是ROLE_LOGIN这样处理*/
                if (authentication instanceof AnonymousAuthenticationToken) {//匿名用户的话就没登陆
                    throw new AccessDeniedException("尚未登录，请登录!");
                }else {
                    return;
                }
            }
            //当前用户所具有的权限
            Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();//获取当前登陆用户的角色（一个用户可能多个角色）
            for (GrantedAuthority authority : authorities) {
                if (authority.getAuthority().equals(needRole)) {   //我需要a,b两个角色，你只要有其中一个就可以访问

                    return;
                }
            }
        }
        throw new AccessDeniedException("权限不足，请联系管理员!");//前面两个都没满足

    }

    @Override
    public boolean supports(ConfigAttribute configAttribute) {
        return false;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return false;
    }
}
