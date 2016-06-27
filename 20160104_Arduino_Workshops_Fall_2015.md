I'm living the dream.  During the fall semester of 2015 OU Libraries soft-launched a makerspace called the EDGE.  The EDGE is equipped with several 3D printers, Oculus Rift headsets, and 10 Sparkfun Inventor's Kits.  As part of the EDGE programming, two emerging tech librarians and myself each led weekly workshops on our respective areas of expertise.  These workshops covered the fundamentals of 3D printing, virtual reality development, and electronics.  In the spring we plan to offer more advanced workshops.  Throughout their duration, hosting the electronics workshop was consistently the highlight of my week.  I can't wait to start again once classes start.  Over the winter break I spent time developing more advanced lessons and cannot wait to give them a shot.

**LEDestroyer**

The first thing I discussed in these workshops was the definition of voltage, current, and resistance.  I probably could do this in a more engaging, meaningful way in the future.  In doing this I spent about 30 seconds drawing a simple circuit on a whiteboard to help explain Ohm's law.  Before losing everyone's attention, I wrapped up the first phase of the workshop by purposefully burning out a few LEDs.  To do this, I threw together a simple circuit that is nothing but a potentiometer in series with an LED powered by a 5v power supply.  This allowed me to demonstrate the role of resistance in a circuit.  When the knob is turned in one direction there is far too much resistance in the circuit to light the LED.  In the other direction there is too little resistance and too much current passes through the LED.  In between it is demonstrated that the amount of light emitted from the LED is inversely proportional to the resistance in the circuit.  This is a handy thing, but the most important lesson that I hope the demonstration conveyed was to not be afraid of making mistakes while working with these electronics.   I wanted this demonstration to be an ice-breaker and to set the tone for the rest of the workshop.  That is, by making the most severe mistake straight away (no matter how anticlimactic it might have been), I hope I broke any apprehension that the participants might have had.  I explained to them that by burning out an LED I just threw away at most several cents, but hopefully taught what I think is a priceless lesson.

![LEDestroyer](http://codytaylor.cc/legacy-images/LEDestroyer.gif)

**Hello World**

It's customary when learning a new programming language to write a "Hello World" program.  I think this is fun and it provided a good chance to introduce the CodeBender IDE and the most basic components of an Arduino program.  Upon registering for these workshops I asked that participants visit [CodeBender.cc](https://codebender.cc/) and follow their instructions for installing any necessary browser plugins in order to minimize the amount of time spent doing this during the workshop.  I like using CodeBender because it provides a lower barrier to entry than does installing the Arduino IDE.  It is perfectly functional and it allows participants to save their code in a public way.  Explaining this segued nicely into my soapbox about the open-source ethos that is the basis of the Arduino community.


    void setup() {
    Serial.begin(9600);
    Serial.println("Hello World!");
    }

    void loop() {

    }



Once they had completed the Hello World, I encouraged them to experiment with their code a bit.  "Do some math," I told them.  Most had no trouble doing this.  Some of the more advanced people even asked questions that led me to explain loops.  -exciting stuff!

**Breadboard**

Most of the people who attended workshops in the fall had zero experience working with electronics.  They could have probably assumed that wires would be involved but had doubtfully considered how components would be interconnected.   Understanding this, I explained how breadboards work.  I like to use breadboards in the "landscape" orientation and in doing so I explained that all holes in a column are electrically connected and each column is electrically insulated from all other columns.  Furthermore, I would say that the trough in the middle of the breadboard electrically bisects the board, and that the two top-most rows and two bottom-most rows are each electrically connected and are usually used as power rails.  The guide ([PDF](https://cdn.sparkfun.com/datasheets/Kits/RedBoard_SIK_3.2.pdf)) that is provided with the [Sparkfun Inventor's Kits](https://www.sparkfun.com/products/12060) that we use is crammed full of outstanding illustrations.  One of my favorites is the cut-away depiction of a breadboard.  I had everyone remove the guide from their kits to have a look.  While they were turning pages I would point out how excellent the book is and explain that most everything we would be doing in the workshop, and much more, could be done independently by following the examples in the book.  At this point I often would take a second to explain how useful Sparkfun.com is and why I might come off as a fanboy.  On more than one occasion, I had participants already familiar with Arduino and Electronics back me up this point.  That was nice.  -had to be careful to avoid another tangent here.

![Breadboard](http://codytaylor.cc/legacy-images/Breadboard.png)


###### Breadboard image from Sparkfun Inventor's Kit Guide licensed under Creative Commons Attribution Share-Alike License.




**Blink**

The first time you log into CodeBender.cc it presents you with the physical computing equivalent of Hello World, the Blink example.  By this point I've already instructed the participants to delete these lines and replace them with the Hello World mentioned earlier.  With a blank IDE, I live coded the Blink example and explained each line as I typed them while the participants copied.  While they copied, I would often get questions such as "does capitalization matter?" "Do spaces matter?" "What about line breaks, do they matter?" This was usually a good opportunity to explain that they were writing C/C++ code.  By waiting to tell them they had written C code until after they had written it, I hope,  I prevented them from ever feeling the intimidation that might come by providing a name to the programming language.  I would, of course, at this point explain the layer of abstraction that makes Arduino such an attractive platform for those writing code for the first time.  Once we were all on the same page, I instructed them to connect an LED through a resistor to pin 13 of the [RedBoard](https://www.sparkfun.com/products/12757).  I was careful to bring their attention to resistor color bands, and to relate the circuit they just built to the circuit that I drew at the beginning of the workshop.  Again, once we were all on the same page, I'd tell them to run their code.  Most peoples' circuits would work on the first attempt!

Once everyone had a blinking LED I'd instruct them to play with the code again.  One example that I proposed was to reduce the amount of time in the delay() functions until the LED was blinking so fast that they could no longer perceive that it was blinking.  I'd allow several minutes for this.  The ease with which participants at this point were able to make meaningful changes to the code by themselves is a testament to the power of the Arduino platform.  I was thrilled to find that people didn't usually stop at modifying the code, but that they also made modifications to the circuit!  They would add more LEDs experimenting with series and parallel configurations.  Some even tried using different pins of the RedBoard and made a circuit that would blink two LEDs.  -one on, the other off.   I found that encouraging participants at this point and walking them through any necessary troubleshooting improved their confidence to try things later in the workshop.


    void setup() {
    // initialize digital pin 13 as an output.
    pinMode(13, OUTPUT);
    }

    void loop() {
    digitalWrite(13, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(1000);              // wait for a second
    digitalWrite(13, LOW);    // turn the LED off by making the voltage LOW
    delay(1000);              // wait for a second
    }




**Buttons**

Once the excitement of building their first circuit and writing their first few lines of code died down we'd start to build the second circuit of the workshop.  I instructed them to leave their LED circuit in tact and walked them through building an active-high push button that would be wired to a pin of their choice (except for pins 0 or 1 to avoid serial communication problems).  I don't think it is necessary that they understand the physics of a pull-down resistor or any other part of the circuit as long as they understand that this is a common button configuration ubiquitous to electronics.  I would then live code and explain the required lines to light the LED by the push of a button.

Once we were all, again, on the same page, I asked that they add at least one more LED to their circuit and at least one more push button and then adapt the code that I provided to make their circuit do something unique using all three elements that we had discussed thus far; serial communication, LEDs and buttons.  In between helping everyone troubleshoot their own circuits, I would add one more LED and one more button to my circuit.  I'd usually pick a yellow LED, a yellow button, a blue LED, and a blue button.  My implementation would light the yellow LED when the yellow button was pressed, and likewise would light the blue LED when the blue button was pressed.  In the code I would make sure that the color corresponding to each button would be printed in the serial monitor when pressed.  In the case that both yellow and blue buttons were pressed it would show "green" in the serial monitor.  Novel, I know, but a good example for what I'd hope they might do.

I did have one person ask about my use of the integer datatype for the variables that hold the state of the buttons, blueState, and yellState.  He asked why I chose to use int instead of bool given that the result would always take a binary form.  I noted that he was correct and that he was welcome to pursue that avenue, but that [for simplicity](http://cybergibbons.com/arduino/arduino-misconceptions-7-boolean-variables-are-a-native-cavr-type/), having said very little at this point about datatypes, I would stick to using integer type variables.  -a good opportunity to plug future, more advanced, workshops!


    int blueButton = 2;
    int yellButton = 3;

    int blueLED = 6;
    int yellLED = 7;

    int blueState = 0;
    int yellState = 0;

    void setup()
    {
    Serial.begin(9600);

    pinMode(blueButton, INPUT);
    pinMode(yellButton, INPUT);

    pinMode(blueLED, OUTPUT);
    pinMode(yellLED, OUTPUT);
    }

    void loop(){
    blueState = digitalRead(blueButton);
    yellState = digitalRead(yellButton);

    if( (blueState == HIGH) && (yellState == HIGH) ){
    Serial.println("green");
    digitalWrite(blueLED, HIGH);
    digitalWrite(yellLED, HIGH);
    }
    else{
    if(blueState == HIGH){
      Serial.println("blue");
      digitalWrite(blueLED, HIGH);
    }
    else{
      digitalWrite(yellLED, LOW);
    }
    if(yellState == HIGH){
      Serial.println("yellow");
      digitalWrite(yellLED, HIGH);
    }
    else{
      digitalWrite(blueLED, LOW);
    }
    }
    }


**Conclusion**






<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">It&#39;s 1:30am. My desk is a wreck. Just finished preparing for tomorrow&#39;s Intro to <a href="https://twitter.com/hashtag/Arduino?src=hash">#Arduino</a> workshop. So excited!! <a href="http://t.co/RSVKFTqlJa">pic.twitter.com/RSVKFTqlJa</a></p>&mdash; Cody Taylor (@OKCody_) <a href="https://twitter.com/OKCody_/status/653821588555460608">October 13, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>




During the first workshop, I learned that I had prepared several hours worth of material more than I could have covered in a two-hour workshop.  I decided then that this material was just enough for a two-hour workshop whose participants were university students, staff, and faculty.  -adults.  One workshop happened to be full of IT staff people who caught onto these concepts rather quickly.  Their pace allowed them about 30 minutes to do more exploration on their own.  Most stayed and experimented, or chatted with each other about what they had built or with me about possible applications.  I had a blast leading these workshops!  I can only hope that everyone who participated learned half as much from me as I learned from them.
