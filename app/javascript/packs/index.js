//Page JS Functions
const fileInput = document.querySelector('.file-input');
if(fileInput) {
    fileInput.addEventListener('change', (e) => {
        const fileName = document.querySelector('.file-name');
        fileName.style.display = 'block';
        fileName.textContent = fileInput.files[0].name;
    });
}

window.addEventListener('load', () => {
    let notice = document.querySelectorAll(".notice");
    if (notice.length > 0){
        setTimeout(function(){
            notice[0].remove();
        }, 3000);
    }
});