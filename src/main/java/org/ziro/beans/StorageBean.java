package org.ziro.beans;

import java.util.ArrayList;
import java.util.List;

public class StorageBean {
    private List<ResultBean> resultList = new ArrayList<>();


    public StorageBean() {};

    public void setResultList(List<ResultBean> resultList) {
        this.resultList = resultList;
    }
    public List<ResultBean> getResultList() {
        return resultList;
    }
    public void addResult(ResultBean resultBean) {
        this.resultList.add(resultBean);
    }
}
