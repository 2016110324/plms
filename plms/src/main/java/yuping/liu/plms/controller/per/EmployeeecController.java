package yuping.liu.plms.controller.per;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import yuping.liu.plms.model.Employeeec;
import yuping.liu.plms.model.RespBean;
import yuping.liu.plms.model.RespPageBean;
import yuping.liu.plms.service.EmployeeecService;

@RestController
@RequestMapping("/personnel/ec")
public class EmployeeecController {
    @Autowired
    EmployeeecService employeeecService;

    @GetMapping("/")
    public RespPageBean getAllEcByPage( @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size) {

        return  employeeecService.getAllEcByPage(page, size);
    }


    @PostMapping("/")
    public RespBean addEc(@RequestBody Employeeec employeeec) {
        if (employeeecService.addEc(employeeec) == 1) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @DeleteMapping("/{id}")
    public RespBean deleteEcById(@PathVariable Integer id) {
        if (employeeecService.deleteEcById(id) == 1) {
            return RespBean.ok("删除成功！");
        }
        return RespBean.error("删除失败！");
    }

    @PutMapping("/")
    public RespBean updateEcById(@RequestBody Employeeec employeeec) {
        if (employeeecService.updateEmpEcById(employeeec) == 1) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }
}
