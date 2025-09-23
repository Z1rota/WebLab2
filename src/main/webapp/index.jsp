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
        Смирнов Андрей Алексеевич P3213 <br>
        Вариант 1705
    </div>

    <div class="Lab-name" style="line-height: 0.8">
        Лабораторная работа №2 по ВЕБУ <br>
        <a href="murino.jsp">
            <button> взорвать мурино </button> </a>
    </div>

    <div class="graph">
        <div class="graph-container" style="background: rgb(255,255,255); padding: 20px; display: inline-block; border-radius: 8px;">
            <canvas id="board" width="500" height="500" style="border: 1px solid #ccc; cursor: crosshair;"></canvas>
            <div id="controls">
                <form action="Controller" method="GET" id="graphForm">
                    <label><input type="radio" name="Rchange" value="1"> R=1</label>
                    <label><input type="radio" name="Rchange" value="2"> R=2</label>
                    <label><input type="radio" name="Rchange" value="3"> R=3</label> <br><br>
                    <label>Y: <input type="text" name="Ychange" id="Ychange" placeholder="от -3 до 5"></label> <br><br>
                    <div>
                        X:
                        <input type="hidden" name="Xchange" id="Xchange" value="">
                        <button type="button" class="x-btn" onclick="setXValue(this, -5)">-5</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, -4)">-4</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, -3)">-3</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, -2)">-2</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, -1)">-1</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, 0)">0</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, 1)">1</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, 2)">2</button>
                        <button type="button" class="x-btn" onclick="setXValue(this, 3)">3</button>
                    </div>

                    <button type="submit">Применить</button>
                </form>
            </div>
        </div>
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


</div>
<script type=module src="static/utils.js"></script>
<script type=module src="static/graph.js"></script>
<script src="static/main.js"></script>
</body>
</html>
