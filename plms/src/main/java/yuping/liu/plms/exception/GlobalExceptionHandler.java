package yuping.liu.plms.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import yuping.liu.plms.model.RespBean;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

/*
 * 全局异常处理，捕获所有Controller中抛出的异常。
 */
@RestControllerAdvice
/*
* 作为特化@Component，允许通过类路径扫描自动检测实现类。
它通常用于定义@ExceptionHandler， @InitBinder 和 @ModelAttribute 适用于所有@RequestMapping方法的方法。
* */
public class GlobalExceptionHandler {
    @ExceptionHandler(SQLException.class)//参数是异常类的class，代表这个方法专门处理该类异常，
    public RespBean sqlException(SQLException e) {
        if (e instanceof SQLIntegrityConstraintViolationException) {
            return RespBean.error("该数据有关联数据，操作失败!");
        }
        System.out.println(e);
        return RespBean.error("数据库异常，操作失败!");
    }
}