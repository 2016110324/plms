package yuping.liu.plms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import yuping.liu.plms.model.Employee;
import yuping.liu.plms.service.EmployeeService;

import java.util.List;

@RestController

public class EmploginController {
    @Autowired
    EmployeeService employeeService;
   @GetMapping("/doEmpLogin")
    public List<Employee> checkLogin(@RequestParam String workID, @RequestParam String epwd){

        return employeeService.checkLogin(workID,epwd);
    }
}
