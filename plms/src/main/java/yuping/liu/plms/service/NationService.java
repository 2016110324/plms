package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuping.liu.plms.mapper.NationMapper;
import yuping.liu.plms.model.Nation;

import java.util.List;

@Service
public class NationService {
    @Autowired
    NationMapper nationMapper;
    public List<Nation> getAllNations() {
        return nationMapper.getAllNations();
    }
}

