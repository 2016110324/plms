package yuping.liu.plms.controller.ic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import yuping.liu.plms.model.RespBean;
import yuping.liu.plms.model.Tax;
import yuping.liu.plms.service.EmployeeService;
import yuping.liu.plms.service.TaxService;

@RestController
@RequestMapping("/ic/collection")
public class incomeCollection {
    @Autowired
    TaxService taxService;

    @Autowired
    EmployeeService employeeService;
    @PostMapping("/")
    public RespBean addTax(@RequestBody Tax tax){
        if (taxService.addTax(tax) == 1) {

            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }



}
