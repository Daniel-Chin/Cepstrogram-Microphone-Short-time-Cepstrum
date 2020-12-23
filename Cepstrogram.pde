import ddf.minim.*;
import ddf.minim.analysis.*;

static final float GAIN = 2.5;

static final int SR = 22050;
static final int FRAME_LEN = 2048;
int HALF_FRAME_LEN = FRAME_LEN / 2;
int QUATER_FRAME_LEN = HALF_FRAME_LEN / 2;

Minim minim;
AudioInput mic;
MyListener listener;

void setup() {
  // size(1000, 800);
  fullScreen();
  // frameRate(5);

  minim = new Minim(this);
  minim.debugOn();

  mic = minim.getLineIn(Minim.MONO, FRAME_LEN, SR);

  listener = new MyListener();
  mic.addListener(listener);

  strokeWeight(.001);
}

void draw() {
  background(0);
  float alpha = min(255, 256 * mic.mix.level() * GAIN);
  fill(0, 100, 100, alpha);
  stroke(0, 255, 255, alpha);
  float[] cepstrum = listener.get();
  pushMatrix();
  translate(0, height);
  scale(width, - height);
  beginShape();
  vertex(0, 0);
  float x; float y;
  for (int i = 0; i < QUATER_FRAME_LEN; i ++) {
    x = i / (float) QUATER_FRAME_LEN;
    y = cepstrum[i] * .005 * GAIN;
    vertex(x, y);
  }
  vertex(1, 0);
  endShape();
  popMatrix();
}

void stop() {
  mic.close();
  minim.stop();
  super.stop();
}
