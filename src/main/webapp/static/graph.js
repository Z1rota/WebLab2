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

    // Подписи и засечки
    ctx.fillStyle = "#333";
    ctx.font = "12px Arial";
    for (let i = -5; i <= 5; i++) {
        if (i === 0) continue;

        // Засечки по X
        let x = centerX + i * scale;
        ctx.fillText(i, x - 5, centerY + 15);
        ctx.beginPath();
        ctx.moveTo(x, centerY - 3);
        ctx.lineTo(x, centerY + 3);
        ctx.stroke();

        // Засечки по Y
        let y = centerY - i * scale;
        ctx.fillText(i, centerX + 5, y + 5);
        ctx.beginPath();
        ctx.moveTo(centerX - 3, y);
        ctx.lineTo(centerX + 3, y);
        ctx.stroke();
    }

    // Подпись нуля
    ctx.fillText("0", centerX + 5, centerY + 15);
}

// Обработчик клика
canvas.addEventListener("click", function(e) {
    let rect = canvas.getBoundingClientRect();
    let x_cord = e.clientX - rect.left;
    let y_cord = e.clientY - rect.top;
    let r_cord = document.querySelector("input[name='Rchange']:checked").value;
    if (!r_cord) showNotification("cords: "+x_cord+" "+ y_cord+ " "+r_cord,true)

    // Преобразуем в координаты системы (инвертируем Y)
    let x = ((x_cord - centerX) / scale).toFixed(3);
    let y = ((centerY - y_cord) / scale).toFixed(3);


    // Выводим в консоль и на экран
    showNotification("cords: "+x+" "+ y+ " "+r_cord,false);

    // Если нужно отправить куда-то — раскомментируй:
    // request({ x: x, y: y });
});

// Заглушка (на случай, если понадобится)
function request(data) {
    console.log("Отправка:", data);
}

// Стартуем
initCanvas();