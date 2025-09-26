<%@ page import="org.ziro.beans.ResultBean" %>
<%@ page import="org.ziro.beans.StorageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
<head>
    <title>Ответики</title>
    <meta charset="UTF-8">
    <style>
        body {
            background-color: yellowgreen;
            margin: 0;
        }
        #results {
            max-width: 1000px;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            padding: 25px;
            overflow: hidden;
        }

        #results h3 {
            color: #2c3e50;
            margin-top: 0;
            font-size: 24px;
            padding-bottom: 15px;
            border-bottom: 2px solid #000000;
            margin-bottom: 25px;
        }

        .table-wrapper {
            overflow-x: auto;
            margin: 0 -5px;
            border-radius: 8px;
            border: 1px solid rgba(225, 229, 235, 0.7);
            background: rgba(255, 255, 255, 0.7);
        }

        #results-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 14px;
            min-width: 700px;
            background: rgba(255, 255, 255, 0.7);
        }

        #results-table th {
            background: linear-gradient(to bottom, #800080, #0c1b33);
            color: #fbfbfb;
            font-weight: 600;
            text-align: center;
            padding: 16px 12px;
            position: relative;
            border-right: 1px solid #2c3e50;
        }

        #results-table th:last-child {
            border-right: none;
        }

        #results-table td {
            padding: 14px 12px;
            text-align: center;
            border-bottom: 1px solid rgba(225, 229, 235, 0.7);
            vertical-align: middle;
            background: rgba(255, 255, 255, 0.7);
        }

        #results-table td:nth-child(4) {
            font-weight: 600;
        }


        #results-table td:nth-child(n+5) {
            font-family: 'Times New Roman', monospace;
            font-size: 20px;
            color: #555;
        }

        #results-table td:last-child {
            color: #2980b9;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="container" style="background-color: yellowgreen">
    <p style="text-align: center;font-size: 30px; margin-top: 0">И че ты тут натыкал</p>


    <div id="results">
        <h3>Результаты:</h3>
        <div class="table-wrapper">
            <table id="results-table">
                <thead>
                <tr>
                    <th rowspan="2">X</th>
                    <th rowspan="2">Y</th>
                    <th rowspan="2">R</th>
                    <th rowspan="2">Результат</th>
                    <th colspan="1">Время начала</th>
                    <th rowspan="2">Время выполнения (Сек)</th>
                </tr>
                </thead>
                <tbody>
                <%
                    @SuppressWarnings("unchecked")
                    StorageBean storage = (StorageBean) session.getAttribute("results");
                    List<ResultBean> results = (storage != null) ? storage.getResultList() : Collections.EMPTY_LIST;
                    if (results != null && !results.isEmpty()) {
                        for (ResultBean res: results) {
                %>
                <tr>
                    <td><%= res.getX() %></td>
                    <td><%= res.getY() %></td>
                    <td><%= res.getR() %></td>
                    <td><%= res.getHit() ? "Попал" : "Мимо" %></td>
                    <td><%= res.getStartTime() != null ? res.getStartTime() : "" %></td>
                    <td><%= String.format("%.4f",(res.getExecutionTime()/1_000_000.0)) %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center;">Нет результатов</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
 <a href="index.jsp" style="display: flex;justify-content: center;align-items: center; text-decoration: none;">
    <button> Вернуться назад</button>
 </a>
</div>
</body>
    </html>
