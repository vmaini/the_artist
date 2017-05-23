import ddf.minim.analysis.*;
import ddf.minim.*;

PFont font;
Minim minim;
AudioPlayer player;
AudioInput input;
FFT fft; //fast Fourier transform - splits soundwave into selection of bands (spectrum analysis)

String[] talk = {
  "Hello, human! My name is Zoot. :-)", 
  "So nice of you to visit! This stairwell does get so lonely... ", 
  "I was just about to make some coffee. Perhaps you'll join me?", 
  "Yes, you must! That would be lovely. Please, have a seat.", 
  "Nothing like coffee with a good friend to start the day :-D", 
  "I'm an artist, you see. Come now, sit! and I shall paint for you!", 

  "I love painting sounds. I can see them, you see.", 
  "Here's a voice-mirror for you. Won't you sing for me?", 

  "It's quite fun, isn't it? Come now, human!", 
  "Let's paint that lovely voice of yours.", 
  "Oh dear..  Lovely. Beautiful. I've gotten tears in my logic board again...", 
  "Might I now perform for you, my own little binary ballad?", 

  "Ah. It's tough work, it is, painting all day long.", 
  "You must be tired, too, from running through my RAM all day ;-)", 
  "Mmm. I could render your pixels for hours. Such a delightful human, you are.", 
  "What do you say to a night out with me? Come on, it'll be fun!", 
  "OK! Let's go party!!!", 

  "Whew! Too much! Too much fun! I'm gonna blow a circuit!", 
  "*YAWN* Ahh. This stairwell is quite comfortable.. why don't you spend the night?", 
  "Yes, that would be wonderful! A lullaby now, and coffee in the morning!", 
  "Oh, I'm so excited! Goodnight! Sweet dreams! Wake me anytime!"
};

int start;
int m;
int lastHue;
boolean newSong = false;
boolean paused = false;
boolean clearBackground = true;
float angle = 0.0;
int q = 10;
int r = 380;
int iterate = 0;
int cycle = 0;
int cycle2 = 0;
boolean cycleBool = true;

void setup()
{
  size(800, 600);

  minim = new Minim(this);
  player = minim.loadFile("Falling Awake.mp3", 512);
  player.play();
  input = minim.getLineIn(Minim.STEREO, 1024);
  fft = new FFT(input.bufferSize(), input.sampleRate());  //creates fft w/ buffersize and samplerate of linein

  font = loadFont("Monospaced-48.vlw");
  textFont(font);

  frameRate(60);
  background(150);
  lastHue = 0;

  //set start time
  start = millis();
}

void draw()

{
  m = millis() - start;
  if (m > 430000) { 
    if (cycle > 0 && ((cycle - cycle2) == 1))
    {
      player.pause();
      player = minim.loadFile("Falling Awake.mp3", 512);
      player.play();
      background(150);
      cycle2++;
    }
    start = millis();
    m = millis()-start;
  }



  println(m);

  if (m < 21000) { //0-21 seconds 
    textSize(20);
    if (m < 3000) {  //3 sec
      text(talk[0], 30, 30);
    }
    else if (m < 7000) { //7 sec
      text(talk[1], 50, 50);
    }
    else if (m < 11000) {  //11 sec
      text(talk[2], 60, 90);
    }
    else if (m < 15000) {  //15 sec
      text(talk[3], 70, 130);
    }
    else if (m < 17000) { // 18 sec
      text(talk[4], 30, 160);
    }
    else { //21 sec
      textSize(18);
      text(talk[5], 40, 200);
    }
  }

  else if (m >= 21000 && m < 80000) { //21 - 80 sec

    background(100);
    if (m < 26000) { //26 sec
      textSize(20); 
      text(talk[6], 20, height/2 - 10);
    }
    else if (m < 31000) { // 31 sec
      text(talk[7], 10, height/2 + 15);
    }
    else { //80 sec
      voiceMirror();
    }
  }

  else if (m >= 80000 && m < 120000) //80-120 sec
  {
    if (m < 86000) { 
      text(talk[8], 60, height - 100);
      text(talk[9], 65, height - 70);
    }


    else if (player.isPlaying())
    {
      player.pause();
      background(240);
    }
    //    
    //     else if (clearBackground)
    //    {
    //      background(240);
    //      clearBackground = false;
    //    }
    //    else if (paused == false)
    //    {
    //      player.pause();
    //      paused = true;
    //    }

    else
    {
      paintInput();
    }
  }

  else if (m >= 120000 && m < 228000) //120-228 sec

  { 
    if (m < 125000) { 
      background(220);
      textSize(16);
      fill(40);
      text(talk[10], q, r);
      if (m > 123000) {
        text(talk[11], q, r + 60);
      }
      r = r - 1;
    }

    else if (!player.isPlaying())
    {
      player = minim.loadFile("Mr Lonely.mp3", 512);
      player.play();
      background(220);
    }
    //    
    //    else if (clearBackground == false)
    //    {
    //      background(220);
    //      clearBackground = true;
    //    }
    //    else if (paused)
    //    {
    //      player = minim.loadFile("Mr Lonely.mp3", 512);
    //      player.play();
    //      paused = false;
    //    }
    else
    {
      paintPlayer();
    }
  }

  else if (m >= 228000 && m < 248000) //228 - 247 sec
  {
    fill(40);
    if (m < 233000) { 
      text(talk[12], 30, 40);
    }
    else if (m < 237000) { 
      textSize(14);
      text(talk[13], 35, 65);
    }
    else if (m < 240000) { 
      textSize(16);
      text(talk[14], 20, 90);
    }
    else if (m < 245000) { 
      text(talk[15], 15, 110);
    }
    else {
      if (newSong == false)
      { 
        player.pause();
        player = minim.loadFile("Sexy and I Know It.mp3");
        player.play();
        newSong = true;
      } 
      text(talk[16], random(0, width-50), random(10, height));
    }
  }

  else if (m >= 248000 && m < 287000) //247 - 287 sec
  {
    iterate++;
    if (iterate % 4 == 0)
    {
      strobe();

      //      if (newSong = true)
      //      {
      //        if (cycle > 0)
      //        {
      //          cycle2++; // boolean for setting up player at beginning after whole program repeats
      //        }
      //      }
      newSong = false; //resets newSong to false for previous section to loop properly in future iterations
      cycleBool = true;
    }
  }

  else if (m >= 287000 && m < 305000) //287 - 305 sec
  {

    if (m < 290000)
    {
      if (player.isPlaying())
      { 
        player.pause();
      }
      fill(0);
      textSize(16);
      text(talk[17], 80, 200);
    }  
    else if (m < 295000)
    {
      textSize(14);
      text(talk[18], 20, 260);
    }
    else if (m < 300000)
    {

      if (!player.isPlaying())
      {
        player = minim.loadFile("A Bicycle Built for Two.mp3");
        player.play();
      }

      fill(0);
      textSize(16);
      text(talk[19], 50, 340);
    }
    else if (m < 305000)
    {

      textSize(22);
      text(talk[20], 60, 450);
    }
  }
  else if (m >= 305000)
  {
    background(0);
    if (cycleBool)
    {
      cycle++; //prepares for next iteration of program to know it's a loop
      cycleBool = false;
    }

    int waveformSize = player.bufferSize() - 1;
    for (int i = 0; i < waveformSize/128; ++i)
    { 
      fill(200);
      text("Zoot is sleeping...", height/2 - 20, width/2 - 20);
      if (input.mix.get(i) > .3) //zoot wakes up if you make noise
      {
        start = millis();
        m = millis() - start; 
        if (cycle > 0 && ((cycle - cycle2) == 1))
        {
          player.pause();
          player = minim.loadFile("Falling Awake.mp3", 512);
          player.play();
          background(150);
          cycle2++;
        }
      }
    }
  }
}

void voiceMirror()
{ 
  background(0);
  fft.forward(input.mix);
  stroke(255, 0, 255, 128);

  for (int i = 0; i < fft.specSize(); i++)
  {
    line(i*3, height, i*3, height - fft.getBand(i)*10);
  }

  stroke(255);
  //buffer values normalized btwn -1 & 1, multiply for magnitude

  for (int i = 0; i < input.left.size() - 1; i++)
  {
    for (int l = 50; l < height; l += 50)
    {
      line(i, l + input.left.get(i)*60, i+1, l + input.left.get(i+1)*60);
    }
  }
}

void strobe()
{
  noStroke();


  fill(m % 255);
  rect(0, 0, 400, 300);
  fill((m + 20) % 255);
  rect(400, 0, 400, 300);
  fill((m + 40) % 255);
  rect (0, 300, 400, 300);
  fill((m + 60) % 255);
  rect (400, 300, 400, 300);
  //  }

  //  scale(2); 
  //  
  //  fill((s + 10) % 255);
  //  rect(0, 0, 100, 75);
  //  
  //  fill((s + 20) % 255);
  //  rect(100, 0, 100, 75);
  //  
  //  fill((s + 30) % 255);
  //  rect(200, 0, 100, 75);
  //  
  //  fill((s + 40) % 255);
  //  rect(300, 0, 100, 75);
  //  
  //  fill((s + 50) % 255);
  //  rect(0, 75, 100, 75);
  //  
  //  fill((s + 60)  % 255);
  //  rect(100, 75, 100, 75);
  //  
  //  fill((s + 70)  % 255);
  //  rect(200, 75, 100, 75);
  //  
  //  fill((s + 80) % 255);
  //  rect(300, 75, 100, 75);
  //  
  //  fill((s + 90) % 255);
  //  rect(0, 150, 100, 75);
  //  
  //  fill((s + 100) % 255);
  //  rect(100, 150, 100, 75);
  //  
  //  fill((s + 110) % 255);
  //  rect(200, 150, 100, 75);
  //  
  //  fill((s + 120)  % 255);
  //  rect(300, 150, 100, 75);
  //  
  //  fill((s + 130)  % 255);
  //  rect(0, 225, 100, 75);
  //  
  //  fill((s + 140) % 255);
  //  rect(100, 225, 100, 75);
  //  
  //  fill((s + 150) % 255);
  //  rect(200, 225, 100, 75);
  //  
  //  fill((s + 160) % 255);
  //  rect(300, 225, 100, 75);
  //  
  //  scale(1);
}
void paintInput()
{
  int waveformSize = player.bufferSize() - 1;
  for (int i = 0; i < waveformSize/128; ++i)
  {
    float x = input.left.get(i) * 900; //*128+128; //left channel
    float y = input.right.get(i)* 1000; //*120+120; //right channel 
    float d = (sqrt(sq(x) + sq(y)))/300;
    float size = d*40;
    float alpha = random(input.mix.get(i)*500 - 20, input.mix.get(i)*500); //mix, parsed from L/R channels

    fill (random(20, 200), input.left.get(i)*120+32+size, input.right.get(i)*128+32+size, constrain(alpha, alpha, 245));

    noStroke();

    translate(400, 300); 
    rotate(angle);

    ellipse(x, y, size, random(size - 10, size + 10)); //creates ellipses in all 4 quadrants
    ellipse(-x, -y, size, random(size - 10, size + 10));
    fill (random(0, 255), input.left.get(i)*200+size+30, input.right.get(i)*200+size+30, 1);
    ellipse(x, y, size*10, size*10);
    angle += .005;

    // ellipse(x - (480/4), y + (512/4), size, size);
    // ellipse(x + (480/4), y - (512/4), size, size);
    // ellipse(x, 480-y, size, size); //mirrors above vertically
    // ellipse(512-x, 480-y, size, size);
    // ellipse(512-x, y, size, size);
    lastHue +=1;
    if (lastHue >= 255)
    {
      lastHue = 0;
    }
  }
}



void paintPlayer()
{
  int waveformSize = player.bufferSize() - 1;
  for (int i = 0; i < waveformSize/128; ++i)
  {
    float x = player.left.get(i) * random(500, 1500) ; //*128+128; //left channel
    float y = player.right.get(i) * random(400, 800); //*120+120; //right channel 
    float d = (sqrt(sq(x) + sq(y)))/300;
    float size = d*40;
    float alpha = random(player.mix.get(i)*255 - 20, player.mix.get(i)*random(255, 1500)); //mix, parsed from L/R channels

    noStroke();

    translate(400, 300); 
    rotate(angle);

    fill (random(20, 255), player.left.get(i)*300+size+50, player.right.get(i)*300+size+50, int(random(-1, 1) + 1));
    ellipse(x, y, size*10, size*10);

    fill (random(50, 210)-50, player.left.get(i)*120+size, player.right.get(i)*128+32+size, constrain(alpha, alpha, 245));


    ellipse(x, y, size, random(size - 10, size + 10)); //creates ellipses symmetrically
    ellipse(-x, -y, size, random(size - 10, size + 10));

    angle += .01;

    lastHue +=1;
    if (lastHue >= 255)
    {
      lastHue = 0;
    }
  }
}

void mousePressed() {

  if (mousePressed && player.isPlaying()) {
    player.pause();
  }
  else if (mousePressed && !player.isPlaying()) {
    player.play();
  }
}

void keyPressed()
{
  if (key == ' ') {
    start = millis(); //resets sequence if space bar pressed
  }
  else if (key == 'f')
  {
    start -= 5000;
  }
  else if (key == 's')
  {
    start -= 60000;
  }
  else if (key == 'd')
  {
    start += 5000;
  }
}

void stop()
{
  // the AudioPlayer from Minim.loadFile()
  player.close();
  // the AudioInput from Minim.getLineIn()
  input.close();
  minim.stop();

  super.stop(); //cleanup
}

