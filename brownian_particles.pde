/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/6270*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
int numparticles =10;
particle[] particles;
//make a new HTML5 audio object named audio
Audio audio = new Audio();
// make string that will house the audio extension
String fileExt;
//make a variable for volume and set it to 0
//(volume runs between 0 and 1)
float vol=0;
//make a boolean to keep track when we are fading
bool fadeOut=false;
int col=0;


void setup()
{
  size(500, 500);
  background(255);
  noStroke();
  smooth();
  rectMode(CENTER);
  particles = new particle[numparticles];
  for(int i=0; i<numparticles; i++)
  {
    particles[i] = new particle(random(450, width-20), random(450, height-20), 10, 10, 5, 0.9,
                             color(0, 0, 0, 255));
  }
  
  //this checks to see what type of audio the browser can play
//then assigns that file extension to our string
if (audio.canPlayType && audio.canPlayType("audio/ogg")) {
    fileExt = ".ogg";
  } 
  else {
    fileExt = ".mp3";
  }

  //loads the audio file and appends the file extension
audio.setAttribute("src","s1"+fileExt);
//play the audio
audio.play();



  
}

//our own function we wrote and named repeat()
void repeat(){
  audio.play();
}

void draw()
{
  background(255);
  for(int i=0; i<numparticles; i++)
  {
    particles[i].collide();
    particles[i].move();
    particles[i].render();
    
    if (particles[i].x >= 0 && particles[i].x < width/2){
     if (particles[i].y >=0 && particles[i].y < height/2){
      audio.play();
     } 
    }
  
    particles[i].xspeed*=particles[i].dampfactor;
    particles[i].yspeed*=particles[i].dampfactor;
  }
}

class particle
{
  float xpos, ypos;
  float xspeed, yspeed;
  int ewidth;
  int eheight;
  float speedfactor;
  float dampfactor;
  color col;
  
  particle(float x, float y,int ew, int eh, float sf, float df,color c)
  {
    xpos=x;
    ypos=y;
    xspeed=0;
    yspeed=0;
    ewidth=ew;
    eheight=eh;
    speedfactor=sf;
    dampfactor=df;
    col=c;
  }
  
  void collide()
  {
  int leftcols = (int)random(0, eheight+1);
  int rightcols=(int)random(0, eheight+1);
  int topcols= (int)random(0, ewidth+1);
  int botcols= (int)random(0, ewidth+1);
  
  xspeed+= (leftcols-rightcols)/speedfactor;
  yspeed+= (topcols-botcols)/speedfactor;
 }
 
 void move()
 {
   xpos+=xspeed;
   ypos+=yspeed;
   if (xpos+ewidth> width || xpos-ewidth<0) xspeed*=-1;
   if (ypos+eheight> height || ypos-eheight<0) yspeed*=-1;
 }
 
 void render()
 {
   fill(col);
   ellipse(xpos, ypos, ewidth, eheight);
 }
 
}

