package org.ziro;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/Controller")
public class ControllerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        double x = Double.parseDouble(req.getParameter("Ychange"));
        resp.setContentType("text/html; charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.println("<html><head><title>Привет</title></head>");
        out.println("<body>");
        out.println("<p>значение Y: "+x+"</p>");
        out.println("</body></html>");
        out.flush();


    }


}
