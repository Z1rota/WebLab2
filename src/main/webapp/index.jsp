<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Rubik+Puddles&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/style.css">
    <title>Орешки биг боб</title>
    <meta charset="UTF-8">
</head>
<body>
<div class='container'>

    <div class="header">
        Смирнов Андрей Алексеевич P3123 <br>
        Вариант 1705
    </div>

    <div class="Lab-name" style="line-height: 0.8">
        Лабораторная работа №2 по ВЕБУ <br>
        <a href="index.jsp">
            <button> взорвать мурино </button> </a>
    </div>

    <div class="graph">
        <div class="graph-container" style="background: rgb(255,255,255); padding: 20px; display: inline-block; border-radius: 8px;">
            <canvas id="board" width="500" height="500" style="border: 1px solid #ccc; cursor: crosshair;"></canvas>
            <div id="controls">
                <form action="Controller" method="GET">
                <label><input type="radio" name="Rchange" value="1"> R=1</label>
                <label><input type="radio" name="Rchange" value="2"> R=2</label>
                <label><input type="radio" name="Rchange" value="3"> R=3</label> <br>
                <label><input type="text"  name="Ychange" id="Ychange" placeholder="Введите значение от -3 до 5"></label>
                </form>
            </div>
        </div>
    </div>
    <div> pizdec naxyu1!525347563465345634</div>


</div>
<script type=module src="static/utils.js"></script>
<script type=module src="static/graph.js"></script>
<script type="module" src="static/main.js"></script>
</body>
</html>
