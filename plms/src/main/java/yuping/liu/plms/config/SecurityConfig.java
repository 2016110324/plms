package yuping.liu.plms.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.*;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import yuping.liu.plms.model.Hr;
import yuping.liu.plms.model.RespBean;
import yuping.liu.plms.service.HrService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Configuration  /*声明当前类为配置类*/
/* WebSecurityConfigurerAdapter 配置安全策略*/
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired/*注入bean-->spring可以自动帮你把bean里面引用的对象的setter/getter方法省略，会帮你自动set/get，*/
    HrService hrService;
    @Autowired
    CustomFilterInvocationSecurityMetadataSource customFilterInvocationSecurityMetadataSource;
    @Autowired
    CustomUrlDecisionManager customUrlDecisionManager;

    @Bean/*声明当前类的返回值  @Bean注解告诉方法产生一个Bean对象，交给spring管理，产生这个对象的方法spring只会调用一次，随后这个spring将会将这个Bean对象放在子的IOC容器*/
    PasswordEncoder passwordEncoder(){//springboot中解决密码加密问题
        return new BCryptPasswordEncoder();//密码处理工具（不需要自己维护盐字段了）
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(hrService);//把hrService引进来
    }

    @Override
    public void configure(WebSecurity web) throws Exception {//如果要返回登陆页面不用经过springboot拦截
        web.ignoring().antMatchers("/login","/css/**","/js/**","/index.html","/img/**","/fonts/**","/favicon.ico","/doEmpLogin","/EmpSelect");
    }



    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                //authorizeRequests()返回一个url拦截注册器，可调用它的一些方法来匹配系统url并设置它的安全策略
                //withObjectPostProcessor后处理配置对象，可以用来修改或者替代通过Java方式配置创建的对象实例。
                .withObjectPostProcessor(new ObjectPostProcessor<FilterSecurityInterceptor>() {
                    @Override
                    /*在configure(HttpSecurity http)方法中，通过withObjectPostProcessor将刚刚创建的UrlFilterInvocationSecurityMetadataSource
                    和UrlAccessDecisionManager注入进来。到时候，请求都会经过刚才的过滤器（除了configure(WebSecurity web)方法忽略的请求）。
                     */
                    public <O extends FilterSecurityInterceptor> O postProcess(O object) {
                        object.setAccessDecisionManager(customUrlDecisionManager);
                        object.setSecurityMetadataSource(customFilterInvocationSecurityMetadataSource);
                        return object;
                    }
                })
               // .anyRequest().authenticated()
                .and()
                //and方法结束当前，上下文回到HttpSecurity
                .formLogin()
                .usernameParameter("username")
                .passwordParameter("password")
                .loginProcessingUrl("/doLogin")
                //loginProcessingUrl是处理登陆的接口
                .loginPage("/login")
                /*没有登陆就跳转到login页面*/
                /*
                前后端如果不分离，直接用successFowardUrl方法跳转到首页去
                前后端分离，所以要返回json告诉前端你登陆成功还是失败
                */
                .successHandler(new AuthenticationSuccessHandler() {//登陆成功处理器
                    @Override
                    /*Authentication 参数存的是用户的权限信息  即返回的UserDetail的实现类中的hr的权限信息
                     这个Authentication对象不需要我们自己去创建，在与系统交互的过程中，
                   Spring Security会自动为我们创建相应的Authentication对象，然后赋值给当前的SecurityContext。
                     */
                    public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
                        httpServletResponse.setContentType("application/json;charset=utf-8");
                        PrintWriter out= httpServletResponse.getWriter();//out对象用于输出字符流数据
                        Hr hr = (Hr) authentication.getPrincipal();//Authentication.getPrincipal()可以获取到代表当前用户的信息
                        hr.setPassword(null);//返回的密码设为null
                        RespBean ok =RespBean.ok("登陆成功",hr);
                        String s = new ObjectMapper().writeValueAsString(ok);
                        out.write(s);
                        out.flush();
                        out.close();//先调用flush()方法，就会强制把数据输出，缓存区就清空了，最后再关闭读写流调用close()。

                    }
                })
                .failureHandler(new AuthenticationFailureHandler() {
                    @Override
                    public void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
                        httpServletResponse.setContentType("application/json;charset=utf-8");
                        PrintWriter out= httpServletResponse.getWriter();
                        RespBean respBean = RespBean.error("登陆失败");
                        if( e instanceof LockedException){
                            respBean.setMsg("账户被锁定,请联系管理员");
                        } else if (e instanceof CredentialsExpiredException) {
                            respBean.setMsg("密码过期,请联系管理员");
                        }else if(e instanceof AccountExpiredException){
                            respBean.setMsg("账户过期,请联系管理员");
                        }else if (e instanceof DisabledException){
                            respBean.setMsg("账户被禁用,请联系管理员");
                        }else if(e instanceof  BadCredentialsException){
                            respBean.setMsg("用户名或密码输入错误，请重新输入");
                        }
                        out.write(new ObjectMapper().writeValueAsString(respBean));
                        out.flush();
                        out.close();
                    }
                })
                .permitAll()
                //登陆页面哪些人可访问（所有）
                .and()
                .logout()
                .logoutSuccessHandler(new LogoutSuccessHandler() {//注销成功的回调
                    @Override
                    public void onLogoutSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {
                        httpServletResponse.setContentType("application/json;charset=utf-8");
                        PrintWriter out = httpServletResponse.getWriter();
                        out.write(new ObjectMapper().writeValueAsString(RespBean.ok("注销成功")));
                        out.flush();
                        out.close();

                    }
                })
                .permitAll()
                .and()
                .csrf().disable().exceptionHandling()
                //没有登陆认证时，在这里处理结果，不要重定向
                .authenticationEntryPoint(new AuthenticationEntryPoint() {
                    @Override
                    public void commence(HttpServletRequest req, HttpServletResponse resp, AuthenticationException authException) throws IOException, ServletException {
                        resp.setContentType("application/json;charset=utf-8");
                        resp.setStatus(401);//401没有认证

                        PrintWriter out = resp.getWriter();

                        RespBean respBean = RespBean.error("访问失败!");
                        if (authException instanceof InsufficientAuthenticationException) {
                            respBean.setMsg("请求失败，请联系管理员!");
                        }
                        out.write(new ObjectMapper().writeValueAsString(respBean));
                        out.flush();
                        out.close();
                    }

                });
    }
}
