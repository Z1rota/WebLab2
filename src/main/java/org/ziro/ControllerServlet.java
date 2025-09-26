package org.ziro;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/Controller")
public class ControllerServlet extends HttpServlet {
    public ControllerServlet() {}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Double x;
        Double y;
        Double r;
        try {
            y = Double.parseDouble(req.getParameter("Ychange"));
            x = Double.parseDouble(req.getParameter("Xchange"));
            r = Double.parseDouble(req.getParameter("Rchange"));
            RequestDispatcher dispatcher = req.getRequestDispatcher("/Area");
            dispatcher.forward(req,resp);

        } catch (NumberFormatException | NullPointerException | ServletException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST,"Вы Ввели недопустимые данные!");
            System.out.println(e.getMessage());
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED,"Еще раз ты отправишь POST метод и я взорву тебя");
    }


}
