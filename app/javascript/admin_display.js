document.addEventListener("DOMContentLoaded", () => {
    const konamiCode = ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a', 'Enter'];

    let currentSequence = [];

    document.addEventListener("keyup", event => {
    currentSequence.push(event.key);

    let match = true;
    for (let i = 0; i < konamiCode.length; i++) {
        if (currentSequence[i] !== konamiCode[i]) {
        match = false;
        break;
        }
    }

    if (match) {
        const adminContainer = document.getElementById("admin_display");
        adminContainer.classList.remove("d-none");

        currentSequence = [];
    } else if (currentSequence.length >= konamiCode.length) {

        currentSequence = [];
    }
    });
});