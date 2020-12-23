class MyListener implements AudioListener { 
  private FFT fft;
  private FFT fft_2;

  private float[] spectrum;
  private float[] cepstrum;

  MyListener() {
    spectrum = new float[HALF_FRAME_LEN];
    cepstrum = new float[QUATER_FRAME_LEN];
    fft = new FFT(FRAME_LEN, SR); 
    fft.window(FFT.HANN);
    fft_2 = new FFT(HALF_FRAME_LEN, SR); 
    fft_2.window(FFT.HANN);
  }

  synchronized void samples(float[] l, float[] r) {
    samples(l);
  }

  synchronized void samples(float[] y) {
    int i;
    fft.forward(y);
    for (i = HALF_FRAME_LEN - 1; i >= 0; i --) {
      spectrum[i] = fft.getBand(i);
    }
    fft_2.forward(spectrum);
    for (i = QUATER_FRAME_LEN - 1; i >= 0; i --) {
      cepstrum[i] = fft_2.getBand(i);
    }
  }
  
  synchronized float[] get() {
    return cepstrum;
  }
};
