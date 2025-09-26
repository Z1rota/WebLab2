const canvas = document.getElementById('board');
const ctx = canvas.getContext('2d');
const scale = 45; // 1 единица координат = 45 пикселей
const originX = canvas.width / 2;
const originY = canvas.height / 2;

function getCurrentR() {
    const selectedRadio = document.querySelector("input[name='Rchange']:checked");
    return selectedRadio ? parseFloat(selectedRadio.value) : null;
}

function convertCanvasToSystem(xPixel, yPixel) {
    const x = (xPixel - originX) / scale;
    const y = (originY - yPixel) / scale; // инвертируем Y
    return { x, y };
}


function redrawCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    const r = getCurrentR();
    if (r !== null && !isNaN(r)) {
        drawBatman(r);
    }

    drawAxes();
}

function drawBatman(r) {
    const scaleFactor = r / 7; // исходная формула рассчитана на R = 7
    ctx.beginPath();
    ctx.fillStyle = 'rgba(25, 118, 210, 0.5)';

    for (let localX = -7; localX <= 7; localX += 0.05) {
        const absX = Math.abs(localX);
        let localY;

        if (absX >= 3 && absX <= 7) {
            // Крылья (эллипс)
            localY = 3 * Math.sqrt(1 - (localX / 7) ** 2);
        } else if (absX >= 1.5 && absX < 3) {
            // Щёки (нижняя часть окружности)
            const dx = absX - 2.25;
            localY = 2.0 - Math.sqrt(Math.max(0, 1 - dx * dx / (0.75 ** 2)));
        } else if (absX >= 0.6 && absX < 1.5) {
            // Уши
            if (absX <= 0.9) {
                // Верх уха (полуокружность)
                const dx = absX - 0.75;
                localY = 3 + 0.4 * Math.sqrt(Math.max(0, 1 - dx * dx / (0.15 ** 2)));
            } else {
                // Скос уха
                localY = 2.0 + (1.5 - absX) * 0.3;
            }
        } else {
            // Плоская голова
            localY = 2.8;
        }

        const worldX = localX * scaleFactor;
        const worldY = localY * scaleFactor;
        const pixelX = originX + worldX * scale;
        const pixelY = originY - worldY * scale; // Y инвертируется
        ctx.lineTo(pixelX, pixelY);
    }

    // --- Нижняя часть: тело ---
    for (let localX = 7; localX >= -7; localX -= 0.05) {
        const absX = Math.abs(localX);
        let localY;

        if (absX >= 4 && absX <= 7) {
            // Нижние крылья
            localY = -3 * Math.sqrt(1 - (localX / 7) ** 2);
        } else {
            // Тело (сложная формула)
            const term1 = Math.abs(localX / 2);
            const term2 = ((3 * Math.sqrt(33) - 7) / 112) * localX ** 2;
            const term3 = Math.sqrt(Math.max(0, 1 - (Math.abs(absX - 2) - 1) ** 2));
            localY = term1 - term2 - 3 + term3;
        }

        const worldX = localX * scaleFactor;
        const worldY = localY * scaleFactor;
        const pixelX = originX + worldX * scale;
        const pixelY = originY - worldY * scale;
        ctx.lineTo(pixelX, pixelY);
    }

    ctx.closePath();
    ctx.fill();
}


function drawAxes() {
    ctx.beginPath();
    ctx.strokeStyle = '#aaa';
    ctx.lineWidth = 1;

    // Ось X
    ctx.moveTo(0, originY);
    ctx.lineTo(canvas.width, originY);
    // Ось Y
    ctx.moveTo(originX, 0);
    ctx.lineTo(originX, canvas.height);
    ctx.stroke();

    // Деления и подписи
    ctx.fillStyle = '#333';
    ctx.font = '12px Arial';
    const MAX_LABEL = 5;

    for (let i = -MAX_LABEL; i <= MAX_LABEL; i++) {
        if (i === 0) continue;

        // Подписи по X
        const xPixel = originX + i * scale;
        ctx.fillText(i.toString(), xPixel - 5, originY + 15);
        ctx.beginPath();
        ctx.moveTo(xPixel, originY - 3);
        ctx.lineTo(xPixel, originY + 3);
        ctx.stroke();

        // Подписи по Y
        const yPixel = originY - i * scale;
        ctx.fillText(i.toString(), originX + 5, yPixel + 5);
        ctx.beginPath();
        ctx.moveTo(originX - 3, yPixel);
        ctx.lineTo(originX + 3, yPixel);
        ctx.stroke();
    }

    // Ноль
    ctx.fillText('0', originX + 5, originY + 15);
}


canvas.addEventListener('click', function (e) {
    const rect = canvas.getBoundingClientRect();
    const xPixel = e.clientX - rect.left;
    const yPixel = e.clientY - rect.top;

    const r = getCurrentR();
    if (r === null) {
        showNotification('Выберите значение R', true);
        return;
    }

    const { x, y } = convertCanvasToSystem(xPixel, yPixel);

    // Валидация
    if (isNaN(x) || isNaN(y)) {
        showNotification('Некорректные координаты', true);
        return;
    }

    // Заполняем форму и отправляем
    document.getElementById('Xchange').value = x.toFixed(3);
    document.getElementById('Ychange').value = y.toFixed(3);
    document.getElementById('graphForm').submit();
});

// === Слушатели на изменение R ===
document.querySelectorAll("input[name='Rchange']").forEach(button => {
    button.addEventListener('change', redrawCanvas);
});

// === Инициализация ===
redrawCanvas();