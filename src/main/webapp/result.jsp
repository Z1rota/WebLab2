<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Результаты</title>
    <meta charset="UTF-8">
</head>
<body>
<div class="container" style="background-color: yellowgreen">
    <p style="text-align: center">Результаты</p>
    <div class=point-data>
        Ядерный пиздец
    </div>

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
                </tbody>
            </table>
        </div>

</div>


<script>var res= document.getAttribute("result")
console.log(res.valueOf());
</script>
<%=(boolean) request.getAttribute("result")%>


</body>
    </html>
