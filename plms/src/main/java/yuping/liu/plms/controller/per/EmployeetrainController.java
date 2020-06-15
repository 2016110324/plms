package yuping.liu.plms.controller.per;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import yuping.liu.plms.model.Employeetrain;
import yuping.liu.plms.model.RespBean;
import yuping.liu.plms.model.RespPageBean;
import yuping.liu.plms.service.EmployeetrainService;

import java.util.List;

@RestController
@RequestMapping("/personnel/train")
public class EmployeetrainController {
    @Autowired
    EmployeetrainService employeetrainService;


    @GetMapping("/")
    public RespPageBean getAllTrainByPage(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer size) {

        return  employeetrainService.getAllTrainByPage(page, size);
    }

    @PostMapping("/")
    public RespBean addSalary(@RequestBody Employeetrain employeetrain) {
        if (employeetrainService.addEmpTrain(employeetrain) == 1) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @DeleteMapping("/{id}")
    public RespBean deleteSalaryById(@PathVariable Integer id) {
        if (employeetrainService.deleteEmpTrainById(id) == 1) {
            return RespBean.ok("删除成功！");
        }
        return RespBean.error("删除失败！");
    }

    @PutMapping("/")
    public RespBean updateSalaryById(@RequestBody Employeetrain employeetrain) {
        if (employeetrainService.updateEmpTrainById(employeetrain) == 1) {
            return RespBean.ok("更新成功!");
        }
        return RespBean.error("更新失败!");
    }
}
