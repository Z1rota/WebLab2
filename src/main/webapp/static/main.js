function setupInputValidation() {
    const yInput = document.getElementById('Ychange');

    const validateInput = (input) => {
        input.addEventListener('input', function () {

            if (this.value.length > 5) {
                this.value = this.value.substring(0, 5);
                return;
            }

            this.value = this.value.replace(/[^0-9.,-]/g, '');
            this.value = this.value.replace(/,/g, '.');

            if ((this.value.match(/\./g) || []).length > 1) {
                this.value = this.value.substring(0, this.value.lastIndexOf('.'));
            }

            if (this.value.indexOf('-') > 0) {
                this.value = this.value.replace(/-/g, '');
            }

            if (this.value.length > 1 && this.value.includes('-')) {
                this.value = this.value.replace(/-/g, '');
                this.value = '-' + this.value;
            }
        });
    };
    validateInput(yInput);
}
setupInputValidation();





function validateNums() {
    const y = parseFloat(document.getElementById("Ychange").value);
    const x = parseFloat(document.getElementById("Xchange").value);
    const r = parseFloat(document.querySelector("input[type=radio]:checked").value);
    if (isNaN(x) || isNaN(y) || isNaN(r) || (x == null) || (y == null) || (r == null)) {
        showNotification("Введите валидные значения!", true);
        return false;
    } else {
        if (y > 5 || y < 3) {
            showNotification("Y не в допустимом радиусе!", true);
            return false
        }
        return true;

    }
}

    function setXValue(button, x) {
        document.querySelectorAll('.x-btn').forEach(btn => {
            btn.classList.remove('active');
        });
        button.classList.add('active');
        document.getElementById('Xchange').value = x;
    }

const graphForm = document.getElementById("graphForm");
graphForm.addEventListener("submit", function(event)  {
    event.preventDefault();
     if (validateNums()) {
         graphForm.submit();

     }

})