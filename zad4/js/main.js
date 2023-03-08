
/* Variables */

var height = 800;
var width = 800;
var szerok = +prompt("Podaj rozmiar węża względem planszy:");

var player = {
	x: 0,
	y: 0,
	w: szerok,
	h: szerok,
	length: 1,
	kierunek: "prawo",
	color: "green",
	sladx: [],
	slady: [],
	moveLeft: function (){
		this.x -= this.w; 
	},
	moveRight: function (){
		this.x += this.w;
	},
	moveUp: function (){
		this.y -= this.h; 
	},
	moveDown: function (){
		this.y += this.h;
	}
}

var apple = {
	x: 0,
	y: 0,
	w: szerok,
	h: szerok,
	color: "red",
	losuj: function(){
		do {
			this.x = Math.floor((Math.random() * width / this.w) + 0) * this.w;
			this.y = Math.floor((Math.random() * height / this.h) + 0) * this.h;
			} while (this.sprawdz());
        },
		sprawdz: function(){ // Funkcja, która spradza czy wylosowana pozycja jabłka nie koliduje z głową i ogonem węża.
			if (this.y == player.y && this.x == player.x) return true;
			for (i = 0; i < player.length; i++){
				if (this.x == player.sladx[i] && this.y == player.slady[i]) return true;
			}
        return false;
    }
}
	
var okno = {
	draw: function (obiekt) { 											// Rysuje dany obiekt w canvasie.
		this.canvas =  document.getElementById("window"); 				// Pobiera element canvasu.
		this.obraz = this.canvas.getContext("2d");  					// Pobiera środek canvasu.
		this.canvas.style = "border: solid 2px #fff;"; 					// Określa styl canvasu.
		this.obraz.fillStyle = obiekt.color;    						// Określa styl wypełnienia.
		this.obraz.fillRect(obiekt.x , obiekt.y, obiekt.w, obiekt.h); 	// Wypełnia konkretne pole w środku canvasu kwadratem.
	},
	rysujSlad: function(x,y){
		this.obraz.fillStyle = player.color;
		this.obraz.fillRect(x , y, player.w, player.h); 
	},
	czysc: function(obiekt){ // Miało czyścić ślad, ale jednak bezużyteczne, ale niech se tu leży może się przyda.
		this.obraz.clearRect(obiekt.x ,obiekt.y ,obiekt.w ,obiekt.h);
	},
	czyscCale: function (){ // Czyści całą plansze.
		this.obraz.clearRect(0, 0, width, height);
	}
}

var tlo = {
	x:0,
	y:0,
	w:width,
	h:height,
	color:"lightgreen"
}

var wynik = 0;


/* Functions */

function drawApple1(posX, poxY, width, height) {
  var img = new Image();
  img.onload = function() {
    document.getElementById("window").getContext('2d').drawImage(this, posX, poxY, width, height);
  };
  img.src = "svg/apple1.svg";
}

function drawApple2() {
  var img = new Image();
  img.onload = function() {
    document.getElementById("window").getContext('2d').drawImage(this, 0 , 0 , 150, 150);
  };
  img.src = "svg/apple2.svg";
}

function drawApple3() {
  var img = new Image();
  img.onload = function() {
    document.getElementById("window").getContext('2d').drawImage(this, 0 , 0 , 150, 150);
  };
  img.src = "svg/apple3.svg";
}

function keyPush(evt) { // Zmiana kierunku ruchu węża na podstawie eventu z klawiatury.
	switch(evt.keyCode) {
		case 37:
			player.kierunek = "lewo";
			break;
		case 38:
			player.kierunek = "gora";
			break;
		case 39:
			player.kierunek = "prawo";
			break;
		case 40:
			player.kierunek = "dol";
			break;
		case 65:
			player.kierunek = "lewo";
			break;
		case 87:
			player.kierunek = "gora";
			break;
		case 68:
			player.kierunek = "prawo";
			break;
		case 83:
			player.kierunek = "dol";
			break;
	}
}

function start(){
	document.addEventListener("keydown",keyPush);
	timer = setInterval(game, 1000 / 5);
	document.getElementById("start").style.display = 'none';
	document.getElementById("score").style.display = 'block';
}

function game(){ // Główna funkcja gry.
	okno.draw(tlo);
	document.getElementById("score").innerHTML = "Wynik: " + wynik;
	
	switch(player.kierunek) {
		case 'lewo':
			player.moveLeft();
			break;
		case 'gora':
			player.moveUp();
			break;
		case 'prawo':
			player.moveRight();
			break;
		case 'dol':
			player.moveDown();
			break;
    }
		
	if (player.length > 1) { // Jeśli wąż jest dłuższy na więcej niż 1 kratke to zapisuje aktualną pozycję.
	
		player.sladx.unshift(player.x);
		player.slady.unshift(player.y);
		
		if (player.sladx.length > player.length - 1)
			player.sladx.pop(); // Wyrzuca ostatnie, niepotrzebne już pozycje.
		if (player.slady.length > player.length - 1)
			player.slady.pop();
		
		for (i = 0; i < player.length; i++){ // Sprawdza, czy aktualna pozycja węża nie koliduje z jego ogonem w przeciwnym razie restartuje grę.
			if(player.x == player.sladx[i + 1] && player.y == player.slady[i + 1]) 
				gameOver();
		}
		
		for (i = 0; i < player.length; i++){ // Rysuje ślad.
			okno.rysujSlad(player.sladx[i],player.slady[i]);
			if (i == 0) {
				document.getElementById("window").getContext("2d").fillStyle = "darkgreen";    // Określa styl wypełnienia.
				document.getElementById("window").getContext("2d").fillRect(player.x , player.y, player.w, player.h);
			}
		}
	}
	
	// Restartuje grę jeśli gracz wyjedzie poza planszę.
	if (player.x < 0 || player.y < 0 || player.x + player.w > width || player.y + player.h > height)
		gameOver(); 
	
	if (player.x == apple.x && player.y == apple.y) {
		var audio = new Audio("mp3/bite.mp3");
		audio.loop = false;
		audio.play();
	}
	
	// Losuje pozycje jabłka na początku gry i gdy gracz zdobywa punkt, zwiększa długosć węża.
	if (player.x == apple.x && player.y == apple.y || wynik == 0) { 
		apple.losuj();
		wynik++;
		player.length++;
	}
	
	drawApple1(apple.x, apple.y, szerok, szerok);
	//okno.draw(apple);
}
    
function gameOver() { // Czysci plansze, ustawia defaultowe wartości.
	okno.czyscCale();
	player.x = 0;
	player.y = 0;
	player.kierunek = "prawo";
	wynik = 0;
	player.length = 1;
	player.sladx = [];
	player.slady = [];
}