var source, filter, delay, feedbackGain, oscVolume, volume, compressor;
var delaytime, filterFreq, filterRes, sourceFreq;

function setup() {
    createCanvas(600, 600);
    background(0);

    source = new p5.Oscillator('square');
    source.disconnect();
    filter = new p5.LowPass();
    filter.disconnect();
    delay = new p5.Delay();
    delay.disconnect();
    delaytime = 0.5;
    delay.delayTime(delaytime);
    delay.feedback(0.4);

    volume = new p5.Gain();
    volume.disconnect();
    volume.amp(0.8);
    oscVolume = new p5.Gain();
    oscVolume.disconnect();
    oscVolume.amp(0);
    feedbackGain = new p5.Gain();
    feedbackGain.amp(1);

    compressor = getAudioContext().createDynamicsCompressor();
    compressor.disconnect();

    routeSound();

    source.start();
}

function draw() {
    source.freq(mouseX);
    filter.freq(getFilterFreq(mouseY))
}

function getFilterFreq(y) {
    var min = 40;
    var max = getAudioContext().sampleRate / 2;
    var numberOfOctaves = Math.log(max / min) / Math.LN2;
    // Compute a multiplier from 0 to 1 based on an exponential scale.
    var multiplier = Math.pow(2, numberOfOctaves * (((2 / height) * (height - y)) - 1.0));
    // Get back to the frequency value between min and max.
    return max * multiplier;
}

function startOsc() {
    oscVolume.amp(1.0);
    // volume.connect();
    // volume.amp(0.5, 1);
}

function stopOsc() {
    oscVolume.amp(0);
    // volume.disconnect();
    // feedbackGain.amp(0, 0.4);
    // delay.disconnect();
    // volume.amp(0, 0.4);
    // volume.disconnect();
}

function routeSound() {
    source.connect(oscVolume);
    oscVolume.connect(filter);
    filter.connect(compressor);
    filter.connect(delay);
    delay.connect(feedbackGain);
    delay.connect(compressor);
    feedbackGain.connect(delay);
    compressor.connect(volume);
    volume.connect(getAudioContext().destination);
    // volume.connect(getAudioContext().destination); //destination
    // source.connect(filter);
    // filter.connect(volume);
    // filter.connect(delay);
    // delay.connect(feedbackGain);
    // feedbackGain.connect(delay);
    // feedbackGain.connect(volume);
    // volume.connect();
}

function mousePressed() {
    startOsc();
}

function mouseReleased() {
    stopOsc();
}
