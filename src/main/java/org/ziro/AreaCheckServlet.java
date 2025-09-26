package org.ziro;

import org.ziro.beans.ResultBean;
import org.ziro.beans.StorageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

@WebServlet("/Area")
public class AreaCheckServlet extends HttpServlet {
    Double x_data;
    Double y_data;
    Double r_data;
    private static final double BATMAN_BASE_RADIUS = 7.0;
    private static final double CHEEK_CENTER_OFFSET = 2.25;
    private static final double CHEEK_RADIUS = 0.75;
    private static final double EAR_CENTER_OFFSET = 0.75;
    private static final double EAR_RADIUS = 0.15;
    private static final double BODY_CONSTANT = (3.0 * Math.sqrt(33.0) - 7.0) / 112.0;

    public AreaCheckServlet() {}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        ResultBean bean = new ResultBean();


        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        long time=System.nanoTime();
        bean.setStartTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));

        y_data=Double.parseDouble(req.getParameter("Ychange"));
        x_data=Double.parseDouble(req.getParameter("Xchange"));
        r_data=Double.parseDouble(req.getParameter("Rchange"));

        CheckBatman batman = new CheckBatman(x_data, y_data, r_data);

        boolean result = batman.getResult();
        bean.setExecutionTime((System.nanoTime() - time));
        bean.setHit(result);
        bean.setR(r_data);
        bean.setX(x_data);
        bean.setY(y_data);
        req.setAttribute("bean",bean);

        HttpSession session=req.getSession();
        StorageBean storage = (StorageBean) session.getAttribute("results");

        if  (storage==null) {
            storage=new StorageBean();
        }
        storage.addResult(bean);
        System.out.println(storage.getResultList().size());


        session.setAttribute("results",storage);
        resp.sendRedirect(req.getContextPath()+"/result.jsp");


    }
}
