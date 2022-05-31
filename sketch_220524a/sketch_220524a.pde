import processing.sound.*;

PImage img;

SoundFile  Shit;
SoundFile  Sgoal;
SoundFile Swinner;

String s;
String t;
String u;

String description;
String jug1;
String jug2;
String winner;

int jugAx;
int jugAy;
int golA;

int jugBx;
int jugBy;
int golB;

int ball_x;
int ball_y;

int move_x;
int move_y;


boolean home;
boolean play;
boolean help;
boolean end;

void setup(){
  size(600, 600);
  
  home = true;
  play = false;
  help = false;
  end = false;
  
  img = loadImage("pong.png");
  
  Shit = new SoundFile(this, "hit.wav");
  Sgoal = new SoundFile(this, "goal.wav");
  Swinner = new SoundFile(this, "winner.wav");
  
  ball_x = width/2;
  ball_y = height/2;
  
  move_x = -2;
  move_y = 2;
  
  jugAx = 50;
  jugAy = (600/2)-50;
  golA = 0;
  
  jugBx = 550;
  jugBy = (600/2-50);
  golB = 0;
  
  s = "Ping Pong Game";
  t = "- Para comenzar el juego pulse la tecla 'P'. Esto te transportará a la sala de juego";
  u = "- Para obtener ayuda sobre el juego y la jugabilidad pulse la tecla 'H'. Accederá a una guía de juego";
  
  description = "El juego representa un partido de ping pong, debes golpear la pelota e intentar que choque en la pared del fondo del contrario, cada choque otorgará un punto. Cuando se llegue a los 5 puntos el partido acaba";
  jug1 = "- Para controlar al jugador 1(situado a la izquierda) se usarán las teclas 'w' para subir la raqueta y 's' para bajarla";
  jug2 = "- Para controlar al jugador 2(situado a la derecha) se usarán las teclas 'UP' para subir la raqueta y 'DOWN' para bajarla";
  winner = "";
}


void draw(){
  
  if(home == true){
    
    jugAx = 50;
    jugAy = (600/2)-50;
    
    jugBx = 550;
    jugBy = (600/2-50);
    
    ball_x = width/2;
    ball_y = height/2;
    
    golA = 0;
    golB = 0;
    
    play = false;
    
    background(54,232,232);
    image(img, (width/2)-100, 10, 200, 200);
    textSize(25);
    fill(0);
    text(s, (width/2)-80, 220); 
  

    fill(0);
    stroke(255);
    rect((width/2)-250, (height/2)-50, 500, 300);
  
    fill(255);
    textSize(15);
  
    fill(200);
    text(t, width/5, height/2, 350, 320);  
    text(u, width/5, (height/2)+80, 350, 320);  
  
    if (key == 'p'){
      home = false;
      play = true;    
     }
   
     if (key == 'h'){
       home = false;
       help = true;    
     }
    }
  
   
  
  if(play == true){
    
    endGame();
    
    
    
    background(0);
    fill(255);
    ellipse(ball_x, ball_y, 15, 15);
  
    fill(255);
    textSize(50);
    text(golA, width/4, 100);
    text(golB, width/1.45, 100);
    rect(jugAx, jugAy, 20, 100);
    rect(jugBx, jugBy, 20, 100);
  
    for(int i = 0; i <= 600; i += 10){
      stroke(255);
      line(300, i, 300, i+=5);
    }
    
    ball_x = ball_x + move_x;
    ball_y = ball_y + move_y;
    
    if(ball_x > width) {
      Sgoal.play();
      ball_x = width;
      move_x = -move_x;
      golA += 1;
    }
  
    if(ball_y > height) {
      ball_y = height;
      move_y = -move_y;    
    }
  
    if(ball_x < 0) {
      Sgoal.play();
      ball_x = 0;
      move_x = -move_x;
      golB += 1;
    }
  
    if(ball_y < 0) {
      ball_y = 0;
      move_y = -move_y;
    }
    
     if (move_x > 0 && jugBy <= ball_y + 15/2 && ball_y -15/2 <= jugBy + 100 && jugBx <= ball_x + 15/2 && ball_x - 15/2 <= jugBx + 20){
       Shit.play();
       move_x = -move_x;
      }
  
  
      if (move_x < 0 && jugAy <= ball_y + 15/2 && ball_y - 15/2 <= jugAy + 100 && jugAx + 20 >= ball_x - 15/2 && ball_x - 15/2 <= jugAx + 20){
        Shit.play();
        move_x = -move_x;
      }
    
    if(jugAy+100 > 600){
      jugAy = 600 - 100;
    }
    
    if(jugAy < 0){
      jugAy = 0;
    }
    
    if(jugBy + 100 > 600){
      jugBy = 600 - 100;
    }
    
    if(jugBy < 0){
      jugBy = 0;
    }
    
    
    if(keyPressed){
      
      if (key == CODED){
        switch(keyCode){
          case UP:
            jugBy -= 2;
            break;
          
          case DOWN:
            jugBy += 2; 
            break;  
      }
    }
    if(key == 'w'){
        jugAy -=2;
    } else if(key == 's'){
        jugAy +=2;
    }
   }
  }
  
  if(help == true){
    
    background(54,232,232);
    textSize(25);
    fill(0);
    text("Menú de Ayuda", (width/2)-80, 50);
  
    fill(0);
    stroke(255);
    rect((width/2)-250, height/9, 500, 500);
  
    textSize(15);
    fill(255);
    text(description, width/8, height/5, 400, 320);  
    text(jug1, width/8, (height/5) + 150, 400, 320);  
    text(jug2, width/8, (height/5) + 230, 400, 320);  
    text("Si desea volver atras pulse 'a'", width/8, (height/5) + 310, 400, 320);
    
    if (key == 'a'){
        help = false;    
        home = true;
   }
   
  }
  
  if(end == true){
    fill(54,232,232);
    stroke(255);
    rect(width/2-150, height/2-150, 300, 300);
    textSize(30);
    fill(0);
    text("El ganador es el jugador " + winner, width/3, height/3.5, 250, 300);  
    textSize(15);
    text("Pulse 'a' para volver al inicio", width/3, (height/3.5) + 150, 250, 300);  
    
    
    
    if (key == 'a'){
      end = false;
      home = true;    
   }
  }
  
  
  
  
}

void endGame(){
    
    if(golA == 5){
      Swinner.play();
      winner = "1";
      play = false;
      end = true;      
    }

    if(golB == 5){
      Swinner.play();
      winner = "2";
      play = false;
      end = true;      
    }
    
}
  
