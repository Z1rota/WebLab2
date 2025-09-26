package org.ziro;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

        double x=x_data*7/r_data;
        double y=y_data*7/r_data;
        PrintWriter out = resp.getWriter();

        boolean result = isHit(x,y,r_data);
        bean.setExecutionTime((System.nanoTime() - time) / 10000000);
        bean.setHit(result);
        bean.setR(r_data);
        bean.setX(x_data);
        bean.setY(y_data);


        req.setAttribute("result",result);
        req.getRequestDispatcher("result.jsp").forward(req,resp);


    }


    public boolean isHit(double x, double y, double r) {
        if (r <= 0) {
            return false; // Фигура не имеет смысла при R <= 0
        }

        // Масштабируем реальные координаты к базовой системе (где R=7),
        // чтобы использовать одни и те же формулы.
        final double scale = 7.0 / r;
        double localX = x * scale;
        double localY = y * scale;
        double absX = Math.abs(localX);

        // Фигура состоит из двух основных зон: "Голова/Уши" и "Плащ/Тело".
        // Точка засчитывается, если она попадает ИЛИ в одну, ИЛИ в другую зону.
        // Это решает проблему с "пустотой" между головой и крыльями.
        return isInHeadArea(localX, localY, absX) || isInCapeArea(localX, localY, absX);
    }

    /**
     * Проверяет попадание в центральную область: Голова и Уши.
     * Область определения: |x| < 1
     */
    private boolean isInHeadArea(double x, double y, double absX) {
        if (absX >= 1) {
            return false;
        }

        // --- Верхняя граница (уши и плоская часть головы) ---
        double topBoundary;
        if (absX >= 0.75) { // Скос уха
            topBoundary = 9 - 8 * absX;
        } else if (absX >= 0.5) { // Внутренняя часть уха
            topBoundary = 3 * absX + 0.75;
        } else { // Плоская макушка
            topBoundary = 2.25;
        }

        // --- Нижняя граница (тело) ---
        double bottomBoundary = getLowerBodyY(x, absX);

        return y <= topBoundary && y >= bottomBoundary;
    }

    /**
     * Проверяет попадание в боковые области: Плащ, крылья и туловище.
     * Область определения: 1 <= |x| <= 7
     */
    private boolean isInCapeArea(double x, double y, double absX) {
        if (absX < 1 || absX > 7) {
            return false;
        }

        // --- Верхняя граница (плечи и крылья) ---
        double topBoundary;
        if (absX >= 3) { // Внешняя часть крыльев (эллипс)
            topBoundary = 3 * Math.sqrt(1 - Math.pow(x / 7, 2));
        } else { // Плечи (моделируем как прямую линию, соединяющую ухо и крыло)
            // Это та самая линия, которую JS рисует неявно через lineTo()
            topBoundary = -1.5 * absX + 4.5;
        }

        // --- Нижняя граница (нижняя часть крыльев и тело) ---
        double bottomBoundary;
        if (absX >= 4) { // Нижние крылья
            bottomBoundary = -3 * Math.sqrt(1 - Math.pow(x / 7, 2));
        } else { // Нижнее тело
            bottomBoundary = getLowerBodyY(x, absX);
        }

        // --- Исключение для "щёк" (вогнутая область) ---
        // Точка не должна быть в этой вырезанной области.
        if (absX > 1 && absX < 3) {
            // Эта формула взята из вашего JS для "щёк", но используется как исключающая область
            double cheekCutout = 1.5 - 0.5 * Math.sqrt(Math.max(0, 1 - Math.pow(Math.abs(absX - 2) - 1, 2)));
            if(y < cheekCutout + 0.6) return false;
        }


        return y <= topBoundary && y >= bottomBoundary;
    }

    /**
     * Вспомогательный метод для вычисления Y-координаты нижней части тела.
     * Эта формула используется в обеих зонах.
     */
    private double getLowerBodyY(double x, double absX) {
        double term1 = Math.abs(x / 2);
        double term2 = ((3 * Math.sqrt(33) - 7) / 112) * x * x;
        double term3 = Math.sqrt(Math.max(0, 1 - Math.pow(Math.abs(absX - 2) - 1, 2)));
        return term1 - term2 - 3 + term3;
    }

}
