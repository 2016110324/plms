package yuping.liu.plms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import yuping.liu.plms.mapper.TaxMapper;
import yuping.liu.plms.model.Tax;

@Service
public class TaxService {
    @Autowired
    TaxMapper taxMapper;

    public int  addTax(Tax tax) {
        tax.setAfterTax();
        return taxMapper. insertSelective(tax);
    }

    public int updateTaxById(Tax tax) {

        return taxMapper.updateByPrimaryKeySelective(tax);
    }
}
