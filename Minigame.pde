import processing.serial.*;
import cc.arduino.*;
import java.util.Random;
Arduino arduino;
int movement = 100;
boolean ball = false;
boolean badball = false;
boolean lose = false;
boolean win = false;
int ballx;
int bally = 0;
int badballx = 0;
int num;

int score = 0;
int level = 1;
int random;
int rand;

public void setup() {
  size(400, 300);
  arduino = new Arduino(this, Arduino.list()[0], 57600);
}

public void draw() {
  noStroke();
  background(192);
  if(lose == false && win == false){
  //analogRead 6 = left button
  //analogRead 1 = right button
    boolean leftb = (arduino.analogRead(6) != 0);
    boolean rightb = (arduino.analogRead(1) != 0);
    //boolean middleb = (arduino.analogRead() != 0);
    
    if(ball == false){
      random = (int)(Math.random() * 2 + 1);
      ball = true;
    }
    if(ball == true){
      if(random == 1){
        ballx = 100;
      }
      if(random == 2){
        ballx = 300;
      }
    }
    if(bally >= 400){
      bally = 0;
      ball = false;
    }
    if(bally >= 180 && bally <= 220 && ballx == movement){
      score += 100;
      bally = 0;
      ball = false;
    }
    fill(220);
    bally += 2+(level/1.5);
    ellipse(ballx, bally, 20, 20);

    if(badballx >= 400){
      num = -1;
    } else if(badballx <= 0){
      num = 1;
    }

    fill(215, 72, 72);
    badballx += num;
    ellipse(badballx, 200, 20, 20);
    //win
    if(level == 10){
      win = true;
    }
    
    //lose
    if((badballx + 20 == movement)||(badballx - 20 == movement)){
      lose = true;
    }
    
    /*
    -------------print tests--------------
    System.out.print(random + " ");
    System.out.print(score + " ");
    */
  
    if(score >= 1000*level){
      level += 1;
    }
  
    //tracker
    fill(20);
    text("score", 25, 35);
    text((score), 25, 50);
    text("level", 25, 66);
    text((level), 25, 81);
  
    //movement
    if(rightb == true){
      movement = 300;
    } 
    if(leftb == true){
      movement = 100;
    }
    fill(139);
    ellipse(movement,200,20,20);
  }
  if(lose == true){
    textAlign(CENTER);
    text("congratulations you lost", 200, 150);
  }
  if(win == true){
    textAlign(CENTER);
    text("congratulations you won", 200, 150);
  }
}
