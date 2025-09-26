package org.ziro;

import java.io.Serializable;
import java.util.List;

public class ResultBean implements Serializable {
    private double x;
    private double y;
    private double r;
    private boolean hit;
    private String startTime;
    private long executionTime;
    private List<ResultBean> results;


    public ResultBean() {}


    public void setX(double x) {
        this.x = x;
    }
    public double getX() {
        return x;
    }

    public void setY(double y) {
        this.y = y;
    }
    public double getY() {
        return y;
    }
    public void setR(double r) {
        this.r = r;
    }
    public double getR() {
        return r;
    }

    public void setHit(boolean hit) {
        this.hit = hit;
    }
    public boolean getHit() {
        return hit;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    public String getStartTime() {
        return startTime;
    }
    public void setExecutionTime(long executionTime) {
        this.executionTime = executionTime;
    }
    public long getExecutionTime() {
        return executionTime;
    }
    public void addResult(ResultBean result) {
        this.results.add(result);
    }

    public void setResults(List<ResultBean> results) {
        this.results = results;
    }
    public List<ResultBean> getResults() {
        return results;
    }
}
