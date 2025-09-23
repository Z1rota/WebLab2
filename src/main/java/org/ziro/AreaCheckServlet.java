package org.ziro;

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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        y=Double.parseDouble(req.getParameter("Ychange"));
        x=Double.parseDouble(req.getParameter("Xchange"));
        r=Double.parseDouble(req.getParameter("Rchange"));
        PrintWriter out = resp.getWriter();
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Area Check</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("X:"+x+" Y:"+y+" R:"+r);
        out.println("</body>");
        out.println("</html>");


    }

}
