package yuping.liu.plms.utils;

import org.springframework.security.core.context.SecurityContextHolder;
import yuping.liu.plms.model.Hr;

public class HrUtils {
    public static Hr getCurrentHr() {
        //Spring Security在Authentication中的实现类中已经为我们做了相关实现，所以获取当前用户的用户名最简单的方式如下，
        // 可以获取到代表当前用户的信息，这个对象通常是UserDetails的实例。这里是实现了UserDetails的hr实例
        return ((Hr) SecurityContextHolder.getContext().getAuthentication().getPrincipal());//当前用户对象
    }
}
