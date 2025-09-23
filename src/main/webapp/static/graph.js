import {showNotification} from './utils.js';

let canvas = document.getElementById("board");
let ctx = canvas.getContext("2d");
let scale = 45; // 1 единица = 60 пикселей
let centerX = canvas.width / 2;
let centerY = canvas.height / 2;

// Инициализация — рисуем только оси
function initCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    drawAxes();
}

function drawAxes() {
    ctx.beginPath();
    ctx.strokeStyle = "#aaa";
    ctx.lineWidth = 1;

    // Ось X
    ctx.moveTo(0, centerY);
    ctx.lineTo(canvas.width, centerY);
    // Ось Y
    ctx.moveTo(centerX, 0);
    ctx.lineTo(centerX, canvas.height);
    ctx.stroke();


    ctx.fillStyle = "#333";
    ctx.font = "12px Arial";
    for (let i = -5; i <= 5; i++) {
        if (i === 0) continue;


        let x = centerX + i * scale;
        ctx.fillText(i, x - 5, centerY + 15);
        ctx.beginPath();
        ctx.moveTo(x, centerY - 3);
        ctx.lineTo(x, centerY + 3);
        ctx.stroke();


        let y = centerY - i * scale;
        ctx.fillText(i, centerX + 5, y + 5);
        ctx.beginPath();
        ctx.moveTo(centerX - 3, y);
        ctx.lineTo(centerX + 3, y);
        ctx.stroke();
    }


    ctx.fillText("0", centerX + 5, centerY + 15);
}

// Обработчик клика
canvas.addEventListener("click", function(e) {
    let rect = canvas.getBoundingClientRect();
    let x_cord = e.clientX - rect.left;
    let y_cord = e.clientY - rect.top;
    let r_cord= NaN;

    if (document.querySelector("input[name='Rchange']:checked") == null)  {
        showNotification("Выберите R",true)
    } else {
        r_cord = document.querySelector("input[name='Rchange']:checked").value;

    }

    // Преобразуем в координаты системы (инвертируем Y)
    let x = ((x_cord - centerX) / scale).toFixed(3);
    let y = ((centerY - y_cord) / scale).toFixed(3);
    request({ x: x, y: y, r: r_cord});
});


function request(data) {
    document.getElementById("Xchange").value=data.x;
    document.getElementById("Ychange").value=data.y;
    if ((isNaN(data.x))||(isNaN(data.y))||isNaN(data.r)) {
        if ((data.x == null) || (data.y == null) || (data.r == null)) {
            showNotification("Проверьте, что все значения указаны", true)
        }
    } else {
        document.getElementById('graphForm').submit();
    }
}

// Стартуем
initCanvas();