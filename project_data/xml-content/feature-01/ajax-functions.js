function loadPlant() {
var xmlHttp = new XMLHttpRequest();
xmlHttp.onreadystatechange = function () {
    if(this.readyState == 4 && this.status == 200);
    console.log("Button working")
};
xmlHttp.open("GET", "../database/database.xml", true);
xmlHttp.send();
}

 if (this.readyState == 4 && this.status == 200) {
                                document.getElementById('plant-input').addEventListener('change', function () {

                                })
