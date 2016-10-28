//You should implement your assign2 here.
PImage bg1, bg2, bg3, bg4, enemy, fighter, hp, treasure, start1, start2, end1, end2;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2; 

int gameState;
int x;
int blood;
int treasureX, treasureY;
int speedEnemyX, speedEnemyY, enemyX, enemyY;
int fighterX, fighterY;
int speedFighter = 5;
int spacing = 60;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
String ENEMY_STYLE = "c" ;

void setup () {
  size(640, 480);
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  bg3 = loadImage("img/bg1.png");
  bg4 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  //background
  image(bg2,0,0,640,480);
  
  //blood
  blood = (200/100)*20;
  
  //random treasure position  
  treasureX = floor(random(50,590));
  treasureY = floor(random(50,430));
  
  //random enemy height
  enemyY = floor(random(50,420));
  speedEnemyX = 5;
  
  //fighter position
  fighterX = width-50;
  fighterY = floor(random(50,430));
  
  gameState = GAME_START;
}

void draw() {
  switch(gameState){
    case GAME_START:
      image(start2,0,0,640,480);
      if(mouseX>=150 && mouseX<=450 && mouseY>=350 && mouseY<=430){
        image(start1,0,0,640,480);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }
      break;
    case GAME_RUN:
      //background roll
      if(640+x%1280>640){
        image(bg1,-1280,0,640,480);
      }
      if(0+x%1280>640){
        image(bg2,-1280,0,640,480);
      }
      if(1280+x%1280>640){
        image(bg3,-1280,0,640,480);
      }
      if(-1280+x%1280>640){
        image(bg4,-1280,0,640,480);
      }
      image(bg1,640+x%1280,0,640,480);
      image(bg2,0+x%1280,0,640,480);
      image(bg3,-640+x%1280,0,640,480);
      image(bg4,-1280+x%1280,0,640,480);
      x+=4;     
      
      
      //blood
      noStroke();
      fill(255,0,0);
      rect(10,5,blood,20);
      
      //hp
      image(hp,1,0);
      
      //treausre
      if(((treasureX-30<=fighterX) && (fighterX<=treasureX+30))&&(treasureY-30<=fighterY)&&(fighterY<=treasureY+30)){
        blood +=(200/100)*10;
        if(blood>(200/100)*100){
           blood = (200/100)*100;
         }
        treasureX = floor(random(50,590));
        treasureY = floor(random(50,430));
      }
      image(treasure,treasureX,treasureY);
      
      //enemy 
      /* if(enemyY>fighterY){
          enemyY-=speedEnemyY;
       }else if(enemyY<fighterY){
          enemyY+=speedEnemyY;
       }else{
          speedEnemyY = 0;
       }
      if((enemyX%640-30<=fighterX) && (fighterX<=enemyX%640+30) && (enemyY-30<=fighterY) && (fighterY<=enemyY+30)){
        blood -=(200/100)*20;
        if(blood<=0){
             gameState = GAME_LOSE;
           }
        enemyY = floor(random(50,420));
        speedEnemyX = 0;
      }
      speedEnemyY=3;
      speedEnemyX+=5;
      enemyX = 0+speedEnemyX;
      image(enemy,enemyX%640,enemyY);*/
      
      //enemy assign 3
      switch (ENEMY_STYLE){
        case "c":
          if(enemyX-4*spacing>=640){
              enemyX=0;
              enemyY = floor(random(50,420-4*spacing));
              ENEMY_STYLE = "b";
            }else{
              enemyX +=speedEnemyX;
              for(int i=0;i<5;i++){                   
                image(enemy,(enemyX-i*spacing),enemyY);  
              }
           }
           break;
         case "b":
           if(enemyX-4*spacing>=640){
              enemyX=0;
              enemyY = floor(random(50+2*spacing,420-2*spacing));
              ENEMY_STYLE = "a";
            }else{
              enemyX +=speedEnemyX;
              for(int i=0;i<5;i++){                   
                image(enemy,(enemyX-i*spacing),enemyY+i*spacing);  
              }
           }
           break;
         case "a":
           if(enemyX-4*spacing>=640){
              enemyX=0;
              enemyY = floor(random(50,420));
              ENEMY_STYLE = "c";
            }else{
              enemyX +=speedEnemyX;
              for(int i=0;i<5;i++){                   
                if(i==3){
                  image(enemy,(enemyX-i*spacing),enemyY+spacing);  
                  image(enemy,(enemyX-i*spacing),enemyY-spacing);
                }else if(i==4){
                  image(enemy,(enemyX-i*spacing),enemyY);
                }else{
                  image(enemy,(enemyX-i*spacing),enemyY+i*spacing);  
                  image(enemy,(enemyX-i*spacing),enemyY-i*spacing);
                }
              }
           }
           break;
       } 
      //fighter
      if(upPressed){
        fighterY -= speedFighter;
        while(fighterY<0){
          fighterY = 0;
          break;
        }
      }
      if(downPressed){
        fighterY += speedFighter;
        while(fighterY>height-50){
          fighterY = height-50;
          break;
        }
      }
      if(leftPressed){
        fighterX -= speedFighter;
        while(fighterX<0){
          fighterX = 0;
          break;
        }
      }
      if(rightPressed){
        fighterX += speedFighter;
        while(fighterX>width-50){
          fighterX = width-50;
          break;
        }
      }
      image(fighter,fighterX,fighterY);
      break;
    case GAME_LOSE:
      image(end2,0,0,640,480);
      if(mouseX>=180 && mouseX<=450 && mouseY>=280 && mouseY<=360){
        image(end1,0,0,640,480);
        if(mousePressed){
          gameState = GAME_START;
          setup();
        }
       }
     break;
  }
}
void keyPressed(){
  if(key== CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
   if(key== CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
