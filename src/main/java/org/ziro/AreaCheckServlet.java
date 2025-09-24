package org.ziro;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Area")
public class AreaCheckServlet extends HttpServlet {
    Double x;
    Double y;
    Double r;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        y=Double.parseDouble(req.getParameter("Ychange"));
        x=Double.parseDouble(req.getParameter("Xchange"));
        r=Double.parseDouble(req.getParameter("Rchange"));
        PrintWriter out = resp.getWriter();
        boolean result = isHit(x,y,r);
        
        req.setAttribute("result",result);
        req.getRequestDispatcher("result.jsp").forward(req,resp);


    }


    public boolean isHit(double x, double y, double r) {
        if (x > r) return true;
        return false;
    }

}
