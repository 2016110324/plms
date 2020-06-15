package yuping.liu.plms;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/*
*11111@SpringBootApplication = (默认属性)@Configuration + @EnableAutoConfiguration + @ComponentScan。
*22222提到@Configuration就要提到他的搭档@Bean。使用这两个注解就可以创建一个简单的spring配置类，可以用来替代相应的xml配置文件。
* @Configuration的注解类标识这个类可以使用Spring IoC容器作为bean定义的来源。@Bean注解告诉Spring，一个带有@Bean的注解方法将返回一个对象，该对象应该被注册为在Spring应用程序上下文中的bean。
*33333@EnableAutoConfiguration：能够自动配置spring的上下文，试图猜测和配置你想要的bean类，通常会自动根据你的类路径和你的bean定义自动配置。
*44444@ComponentScan：会自动扫描指定包下的全部标有@Component的类，并注册成bean，当然包括@Component下的子注解@Service,@Repository,@Controller。
*  */
@SpringBootApplication
@MapperScan(basePackages="yuping.liu.plms.mapper")
    public class PlmsApplication {

    public static void main(String[] args) {
        SpringApplication.run(PlmsApplication.class, args);
    }

}
