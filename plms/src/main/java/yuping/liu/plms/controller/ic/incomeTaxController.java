package yuping.liu.plms.controller.ic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import yuping.liu.plms.model.RespPageBean;
import yuping.liu.plms.service.EmployeeService;
import yuping.liu.plms.service.TaxService;

@RestController
@RequestMapping("/ic/search")
public class incomeTaxController {
    @Autowired
    TaxService taxService;
    @Autowired
    EmployeeService employeeService;
    @GetMapping("/")
    public RespPageBean getEmployeeByPageWithTax( @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size) {

        return employeeService.getEmployeeByPageWithTax(page, size);
    }


}
