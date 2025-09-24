<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ПОДРЫВ МУРИНО</title>
    <style>
        body {
            background-color: #000;
            color: #ff3333;
            font-family: 'Courier New', monospace;
            font-size: 18px;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            overflow: hidden;
            position: relative;
        }
        .warning {
            max-width: 800px;
            margin: 0 auto;
            text-align: justify;
            animation: flicker 3s infinite alternate;
        }
        @keyframes flicker {
            0%, 19%, 21%, 23%, 25%, 54%, 56%, 100% { opacity: 1; }
            20%, 24%, 55% { opacity: 0.4; }
        }
        .button {
            display: block;
            margin: 40px auto 0;
            padding: 15px 40px;
            font-size: 24px;
            font-weight: bold;
            background: #800000;
            color: #fff;
            border: 3px solid #ff0000;
            cursor: pointer;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.3s;
            position: relative;
            z-index: 10;
        }
        .button:hover {
            background: #ff0000;
            transform: scale(1.05);
            box-shadow: 0 0 20px #ff3333;
        }

        /* РАКЕТА — теперь стартует НАД КНОПКОЙ */
        .missile {
            position: fixed;
            width: 14px;
            height: 50px;
            background: linear-gradient(to top, #222, #666, #bbb);
            border-radius: 3px;
            z-index: 9996;
            box-shadow: 0 0 8px #ff4400;
            transform: rotate(5deg); /* лёгкий наклон для динамики */
        }
        .missile::after {
            content: '';
            position: absolute;
            bottom: -18px;
            left: 3px;
            width: 8px;
            height: 18px;
            background: radial-gradient(circle, #ff7700, #ff1100, transparent);
            border-radius: 50%;
            animation: flame 0.15s infinite alternate;
        }
        @keyframes flame {
            from { height: 12px; opacity: 0.7; }
            to { height: 22px; opacity: 1; }
        }

        /* АПОКАЛИПСИС */
        #apocalypse-overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            pointer-events: none;
            z-index: 9999;
            opacity: 0;
        }
        .fire-layer {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: radial-gradient(circle at 50% 50%, rgba(255, 50, 0, 0.6) 0%, rgba(255, 0, 0, 0.4) 40%, transparent 70%);
            opacity: 0;
        }
        .crack-layer {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background:
                    repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(255, 0, 0, 0.15) 10px, rgba(255, 0, 0, 0.15) 11px),
                    repeating-linear-gradient(-45deg, transparent, transparent 10px, rgba(255, 0, 0, 0.1) 10px, rgba(255, 0, 0, 0.1) 11px);
            opacity: 0;
        }

        #final-text {
            position: fixed;
            top: 50%; left: 50%;
            transform: translate(-50%, -50%) scale(0.5);
            color: white;
            font-size: 60px;
            font-weight: bold;
            text-align: center;
            text-shadow: 0 0 20px #ff0000, 0 0 40px #ff0000;
            z-index: 10000;
            opacity: 0;
            font-family: 'Impact', sans-serif;
        }
    </style>
</head>
<body>
<audio id="murino-destroy" src="static/music.mp3" preload="auto"></audio>

<div class="warning">
    <p>Слушай сюда. Расписываю чётко и без прикрас — эту муриношную заразу надо стереть с лица земли до атомного стекла.</p>

    <p>Там уже никого нет. Ни старушек у подъездов, ни прохожих с колясками, ни даже тех, кто просто молча курил у ларька. Всё выжжено. Всё вырезано. Остались только они — бэдруки. Не бандиты, не хулиганы, а нечто иное: стая одержимых, что рвёт реальность на клочья. Они не грабят — они уничтожают. Не кричат — воют. Их "уруру!" — это последний звук перед тем, как мир рушится.</p>

    <p>И эта чума растёт. Как плесень на гнили. К ним стекаются все отбросы окрестных пустошей — бывшие, сломанные, сошедшие с ума. Они размножаются не плотью, а безумием. Каждый их взгляд заражает. Каждый шаг — шаг к коллапсу. Если не остановить сейчас — через неделю они доберутся до Питера и превратят его в адскую помойку с криками и пеплом.</p>

    <p>С ними невозможно договориться. Это не люди — это стихия. ОМОН? Росгвардия? Их уже нет. Их разнесли на атомы и втоптали в асфальт. Здесь не нужны переговоры. Здесь нужен огонь. Только огонь. И только пепел.</p>

    <p>Эвакуация? Точечные зачистки? Бесполезно. Единственный путь — полное, тотальное, абсолютное уничтожение. Пусть от Мурино останется лишь стеклянная пустыня под радиоактивным небом. Пусть даже название сгорит в пламени. Пусть никто и никогда не вспомнит, что там когда-то было что-то живое.</p>

    <p>Промедление — смерть для всех, кто ещё дышит за пределами этой зоны хаоса.</p>
</div>

<button class="button" id="detonate">ПОДОРВАТЬ</button>

<div id="missile" class="missile" style="display: none;"></div>

<div id="apocalypse-overlay">
    <div class="fire-layer" id="fire"></div>
    <div class="crack-layer" id="cracks"></div>
</div>

<div id="final-text">МУРИНО УНИЧТОЖЕНО</div>

<script>
    document.getElementById('detonate').addEventListener('click', function() {
        this.disabled = true;
        this.textContent = 'ЗАПУЩЕНО...';

        const sound = document.getElementById('murino-destroy');
        sound.play()

        const buttonRect = this.getBoundingClientRect();
        const missile = document.getElementById('missile');

        // Позиционируем ракету НАД кнопкой
        missile.style.left = (buttonRect.left + buttonRect.width / 2 - 7) + 'px'; // по центру кнопки
        missile.style.bottom = (window.innerHeight - buttonRect.top - buttonRect.height - 20) + 'px'; // чуть выше кнопки
        missile.style.display = 'block';

        // Полёт: медленно вверх, пока не улетит за экран
        let currentBottom = parseFloat(missile.style.bottom);
        const speed = 8; // медленно! (было 25)
        const flyInterval = setInterval(() => {
            currentBottom += speed;
            missile.style.bottom = currentBottom + 'px';

            // Как только улетела за верх — взрыв!
            if (currentBottom > window.innerHeight + 100) {
                clearInterval(flyInterval);
                missile.style.display = 'none';

                // === АПОКАЛИПСИС ===
                // Тряска
                let shakes = 0;
                const shake = setInterval(() => {
                    if (shakes++ > 18) {
                        clearInterval(shake);
                        document.body.style.transform = 'none';
                        return;
                    }
                    document.body.style.transform = `translate(${(Math.random() - 0.5) * 25}px, ${(Math.random() - 0.5) * 25}px)`;
                }, 40);

                // Огонь
                const fire = document.getElementById('fire');
                fire.style.opacity = '1';
                fire.style.transform = 'scale(3)';
                fire.style.transition = 'opacity 0.8s, transform 1.2s';

                // Трещины
                const cracks = document.getElementById('cracks');
                cracks.style.opacity = '1';
                cracks.style.animation = 'pulse-cracks 0.8s infinite alternate';

                if (!document.getElementById('crack-anim-style')) {
                    const style = document.createElement('style');
                    style.id = 'crack-anim-style';
                    style.textContent = `
                        @keyframes pulse-cracks {
                            0% { opacity: 0.3; transform: scale(1); }
                            100% { opacity: 0.8; transform: scale(1.05); }
                        }
                    `;
                    document.head.appendChild(style);
                }

                // Затемнение
                setTimeout(() => {
                    document.body.style.transition = 'filter 2s';
                    document.body.style.filter = 'brightness(0.2) contrast(1.3) saturate(0.1)';
                }, 900);

                // Финальный текст
                setTimeout(() => {
                    const text = document.getElementById('final-text');
                    text.style.opacity = '1';
                    text.style.transform = 'translate(-50%, -50%) scale(1)';
                    text.style.transition = 'opacity 1s, transform 1s';
                }, 1600);
            }
        }, 40); // кадр каждые 40мс — плавно
    });
</script>

</body>
</html>