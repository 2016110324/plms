package yuping.liu.plms.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import yuping.liu.plms.model.Menu;
import yuping.liu.plms.model.Role;
import yuping.liu.plms.service.MenuService;

import java.util.Collection;
import java.util.List;
/*
* FilterInvocationSecurityMetadataSource有一个默认的实现类DefaultFilterInvocationSecurityMetadataSource，
* 该类的主要功能就是通过当前的请求地址，获取该地址需要的用户角色，在这里自定义这个类
*/

/*getAttributes(Object o)方法返回的集合最终会来到AccessDecisionManager类中，接下来去AccessDecisionManager类*/
@Component/*注册成组件*/
public class CustomFilterInvocationSecurityMetadataSource implements FilterInvocationSecurityMetadataSource {
    @Autowired
    MenuService menuService;//注入MenuService
    AntPathMatcher antPathMatcher = new AntPathMatcher();/*比对的一个工具*/

    /*请求需要的角色*/
    /*
    * 从getAttributes(Object o)方法的参数o中提取出当前的请求url，然后将这个请求url和数据库中查询出来的所有url pattern一一对照，看符合哪一个url pattern，
    * 然后就获取到该url pattern所对应的角色，当然这个角色可能有多个，所以遍历角色，最后利用SecurityConfig.createList方法来创建一个角色集合。
    * */
    @Override
    public Collection<ConfigAttribute> getAttributes(Object o) throws IllegalArgumentException {
        String requestUrl = ((FilterInvocation) o).getRequestUrl();/*拿到当前请求的地址*/
        List<Menu> menus = menuService.getAllMenusWithRole();//相当于每次请求都要调用，
        for (Menu menu : menus) {/*比较request的url和menu的Url是否一致*/
            if (antPathMatcher.match(menu.getUrl(), requestUrl)) {
                List<Role> roles = menu.getRoles();
                String[] str = new String[roles.size()];
                for (int i = 0; i < roles.size(); i++) {
                    str[i] = roles.get(i).getName();
                }
                return SecurityConfig.createList(str);
            }

        }
/*如果getAttributes(Object o)方法返回null的话，意味着当前这个请求不需要任何角色就能访问，甚至不需要登录。
但是在我的整个业务中，并不存在这样的请求，我这里的要求是，所有未匹配到的路径，都是认证(登录)后可访问，因此我在这里返回一个ROLE_LOGIN的角色，
这种角色在我的角色数据库中并不存在，因此我将在下一步的角色比对过程中特殊处理这种角色。
*/
        return SecurityConfig.createList("ROLE_LOGIN");/*凡是没匹配上的登陆之后才访问。这只是一个标记*/

    }

    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return null;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return true;
    }
}
