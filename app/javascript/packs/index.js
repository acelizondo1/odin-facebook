//Page JS Functions
const fileInput = document.querySelector('.file-input');
if(fileInput) {
    fileInput.addEventListener('change', (e) => {
        const fileName = document.querySelector('.file-name');
        fileName.style.display = 'block';
        fileName.textContent = fileInput.files[0].name;
    });
}