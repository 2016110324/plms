package yuping.liu.plms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import yuping.liu.plms.model.Menu;
import yuping.liu.plms.service.MenuService;

import java.util.List;





@RestController//处理页面http请求
@RequestMapping("/system/config") //指明该类响应哪个路劲下的请求
public class SystemConfigController {
    @Autowired
    MenuService menuService;
    @GetMapping("/menu")
    public List<Menu> getMenusByHrId(){/*根据用户id来显示菜单。但不能用前端传来的数据（前端的数据是不可信的）*/
        return menuService.getMenusByHrId();

    }

}
