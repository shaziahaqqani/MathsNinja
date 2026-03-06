<html>

<head>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<h2>Select Game Mode</h2>

<div class="box" onclick="start('add')">+ Addition</div>

<div class="box" onclick="start('sub')">- Subtraction</div>

<div class="box" onclick="start('mul')">X Multiplication</div>

<div class="box" onclick="start('div')">÷ Division</div>

<script>

function start(mode){

window.location="game?mode="+mode;

}

</script>

</body>

</html>