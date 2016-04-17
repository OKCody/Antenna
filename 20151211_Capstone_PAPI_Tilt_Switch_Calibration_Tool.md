Precision Approach Path Indicators (PAPI) provide pilots a visual indication of their deviation from the glide slope while landing.  PAPIs operate by pointing lights in very precise, yet slightly different angles.  When a plane is above the glide slope the pilot is only able to see the white lights of the PAPI.  When the plane is below the correct glide slope the pilot is only able to see the red lights of the PAPI. When on the correct glide path she is able to see both the red and white lights indicating a proper approach. These lights are typically installed near the end of a runway near the spot a plane should touch down. Because the angle that these lights point could not be more critical there is an angle sensor inside their housing that actively monitors their angle.  If ever the housing of a PAPI system deviates from its correct angle, its lights turn off in order to not mislead pilots.  If ever this happens the sensor must be re-calibrated. Of the airports within the jurisdiction of the FAA many of their PAPI systems are maintained by the FAA in Oklahoma City.  The FAA maintains about 800 of these specific models.  Calibrating these sensors by hand is an incredibly tedious process involving an inclinometer, an oscilloscope, and technician with a steady hand and the patients of several people.

At OU one of the last classes that a student in the Electrical and Computer Engineering program takes is a Capstone class. In Capstone, students are grouped by their interest and self-identified ability to work on a project for the entire semester. Projects are provided by local companies, university professors, and in my case the Federal Aviation Administration. Given three project options, I chose to be on a team that would design a device that would automate or assist a technician whose job it is to calibrate PAPI tilt sensors. In a class of Electrical Engineering students and Computer Engineering students I self-identified as having above-average mechanical ability and was therefore assigned the role of designing the mechanics for this project. Other members of the group took on roles such as Group Leader and Hardware Designers. Most groups also had a Software Engineer. Ours did not.

During the first few weeks of class we went out to the FAA to meet the engineering mentors that we would be designing this for and who would also be giving us advice along the way. We met the technician who would be using our device and watched him calibrate a tilt sensor to get a feel of his current process. -the process we would hopefully be simplifying. As it was, the technician put a tilt sensor into a pivot and connected its wires to a signal generator and an oscilloscope. He would gently nudge the sensor and watch the RMS voltage of a square wave passing through the sensor be attenuated. Proportional to the RMS voltage of the signal is the angle of the sensor. During calibration, the technician is supposed to move the sensor to the extreme values of its tolerance. At each set point the technician is also supposed to measure and adjust the angle of the top plate of the sensor. All angle measurements are made in units of minutes, that is all measurements are made with sub-degree precision.

[![2015-09-10 11.27.25](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-09-10-11.27.25.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-09-10-11.27.25.jpg)

[![2015-09-10 11.52.33](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-09-10-11.52.33.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-09-10-11.52.33.jpg)

One of the first steps in the design process was to choose a microcontroller that would be the brains of our design.  Here at OU, National Instruments products are heavily used in the Electrical Engineering curriculum.  Because of this many of my classmates default to using LabView and DAQs when working on a project such as this.  Personally, I'm not a fan of LabView or DAQs.  I prefer text-based programming and hardware that is as open as possible.  This project was attempted last semester by several groups each of which chose to use NI DAQs.  None were successful.  During our first design discussions I was adamant that we would not be using a DAQ.  Because one of our design requirements was to display the output signal from the tilt sensor on a screen I suggested using a Raspberry Pi.  The Raspberry Pi offered more than enough GPIO pins and natively supports HDMI.  I was also aware of the abundance of Raspberry Pi hats that are available that would simplify our hardware designs.  At this point, I had a little bit of experience with Raspberry Pi, but none of my teammates had used one.  Only a couple new what a Raspberry Pi was at the time.  Because of this they were understandably reluctant to stray from what they were proposing; DAQs.  When I told them that I would like Python to be the language we used during this project they looked at me even more strangely.  None had ever used Python, but somehow I convinced them to trust me.  I'm realizing now how much faith they put into me at this early stage in the design process.

![](http://imgs.xkcd.com/comics/python.png)


###### XKCD: Python, This work is licensed under a [Creative Commons Attribution-NonCommercial 2.5 License](http://creativecommons.org/licenses/by-nc/2.5/).




We decided early on that we would be using a stepper motor to move the tilt sensor back and forth.  Plenty were available from hobby electronics suppliers such as Pololu, Adafruit, and Sparkfun.  The outlets also carried plenty of stepper motor drivers that would be easy to use with the Raspberry Pi.  We ultimately chose to use a stepper motor from Sparkfun and stepper motor driver from Adafruit because of the simplicity of its accompanying Python library.   I have no regrets.  These parts proved to be exactly what we needed and were perfectly easy to use with the provided documentation.

[![getCachedPicture](http://codyalantaylor.com/wp-content/uploads/2015/12/getCachedPicture.jpeg)](http://codyalantaylor.com/wp-content/uploads/2015/12/getCachedPicture.jpeg)


Image: Adafruit, [DC & Stepper Motor HAT for Raspberry Pi - Mini Kit](https://www.adafruit.com/products/2348)


[![10848-06](http://codyalantaylor.com/wp-content/uploads/2015/12/10848-06.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/10848-06.jpg)


Image: Sparkfun Electronics, [CC BY-NC-SA 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/)




Our first mechanical drawings were primitive, but they evolved nicely by the end of the project. [![FAA Design](http://codyalantaylor.com/wp-content/uploads/2015/12/FAA-Design.png)](http://codyalantaylor.com/wp-content/uploads/2015/12/FAA-Design.png)




At the top of the tilt sensor, there are two nuts that get tightened by the technician when adjusting the angle of the top plate.  Did I mention that this sensor is absurdly sensitive?!  Well, when these nuts get tightened using the by-hand calibration process, the sensor inevitably moves and the whole alignment is thrown off.  This is the struggle that causes this process to sometimes last six hours.  To eliminate the amount the tilt sensor moves during this phase of the process we designed our device to be as sturdy as the sensor is sensitive.  I ended up using 1/4" steel plate to make the platform out of and 1/4" walled square tubing for the motor perch.  I'd guess that the final product weighed somewhere in the neighborhood of 30 pounds, but it was just as sturdy as I had hoped it would be.




The part of the design that required the most thought on my part was figuring out how the motor shaft would attach to the tilt sensor.  I went through several design iterations during this phase of the project but ultimately settled on a genius solution suggested by my dad.  That was to use heim joints, rod ends, to allow the tilt sensor grip to swing as it moved through its range of motion.  I also chose to use rod ends to mount the motor cradle so that the motor could pivot as the tilt sensor moved through its range of motion.  I knew at the time that mounting the motor cradle on rod ends was not necessary given how little the sensor would be moving, but provided that the purpose of this class is to prove our engineering abilities, I chose to over-engineer the hell out of this thing.  Below is a photo of a prototype that I put together using acrylic, and a rod end that belongs on an R/C car.  I presented this to our mentors during our Critical Design Review.  They seemed happy with it, so this design made its way into our final product.




[![2015-10-25 20.16.40](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-10-25-20.16.40.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-10-25-20.16.40.jpg)




The next step was to begin working on building the platform for which all parts would be mounted.  We decided that we would build a box with 45 degree slant at the front where a 7" touchscreen would be mounted.  This would serve equal parts as a screen mount and as a housing for the bulk of electronics.  It turned out to be a really tight fit for all the electronics, but made for a clean-looking final product.  Its frame is made out of 1/2" angle iron, and is covered in clear acrylic of which the inside surface is painted black. [![2015-10-29 17.14.59](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-10-29-17.14.59.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-10-29-17.14.59.jpg)




For the control panel, we decided that having a "coarse" and "fine" (I did my best to correct any misspellings of "coarse" throughout this project.  I take full responsibility for using the spelling "course" at times. ...sad...) button to control the motor's motion in each direction would be appropriate.  This was a good call as it turned out.  Things would have been very slow if we had only used a fine adjustment and not nearly precise enough if we had only provided a coarse adjustment.  I designed a control panel with labels for all the buttons and had it laser cut by Ponoko out of black acrylic.  I was blown away by the results.  It turned out perfectly!  I'm even more excited by the possibilities of laser cutters now.




[![control pannel](http://codyalantaylor.com/wp-content/uploads/2015/12/control-pannel.png)](http://codyalantaylor.com/wp-content/uploads/2015/12/control-pannel.png)




One simple, albeit important, design consideration of this project were the levelers placed in each corner of the plate.  I drilled and tapped holes in the plate such that threaded knobs could be used to raise and lower each corner of the device.  Before I realized how incredibly sensitive the sensor is, I was skeptical of how necessary these leveling devices were.  -was I ever wrong to think that.




The mechanics of this project came together quite nicely.  There is little I would do differently with respect to the mechanics if I had this project to do again.  I can't quite say the same for the electronics.  As a team, we met a fair amount of resistance during the last phase of the project.  At an early stage, we demonstrated the most basic of motor control.  -that was never much of an issue.  I had made the necessary calculations that proved that the precision of the stepper motor we chose and the pitch of its shaft allowed use enough resolution to move the tilt sensor in a way that was forgiving of the technician using our device, but some of the other features gave us trouble.  The first electronics hurdle was communicating with the analog to digital converter.  We chose to use an MCP3008. -a 10 bit ADC that communicates over SPI.  Simple mistakes were made while hooking this up, but even once we got it working, I spent a lot of time coding sampling algorithms.  Two signals would need to be measured by the ADC.  The DC voltage output of the electronic inclinometer and the square wave output of the sensor itself would both need to be measured by the ADC.  The inclinometer was easy to work with.  We supplied it with a regulated 12v, DC signal and it output a voltage between 0v and 5v where 2.5v indicated that the sensor was perfectly level.  This output was easy enough to read with the ADC.  It was the square wave that gave me fits.  I needed to measure the root mean squared (RMS) voltage of the square wave.  To do this, I tried taking a bunch of samples as fast as possible using a for loop.  I appended each sample to a list then sorted all the values in the list.  I knew that it was possible that I was not measuring integer multiples of whole periods of the signal, nor was I only sampling the plateaus of the wave.  Sorting all samples and throwing out all but upper and lower 10% would leave me with peak voltage samples.  Because I took 1000 samples initially, I had 100 high samples and 100 low samples that I averaged and tried to find the difference of.  This method never yielded a value that matched what I was measuring on a trusted oscilloscope.  I know this sounds simple, but I was never able to make it work.  Because of this, the device would never know the position of the tilt sensor.  Because of this, programming an automatic feature, where the device would move the tilt sensor to its set points had to be ruled out.  Don't think that I gave up too easily on this though.  I lost quite a bit of sleep trying to figuring this out, but abandoned this problem in order to deliver a device that functioned with a user at the controls.



In this video it is imperceivable that the sensor is moving.  Proof is in the changing signal on the scope and in the noise of the motor.


 The second and final shortcoming of the product that we delivered was the Bitscope USB Oscilloscope.  Because one of the design requirements was that there be a visual display of the signal coming out of the tilt sensor for the technician to reference while using the device, we chose to use a USB oscilloscope that would display its signal on the 7" screen.  We received the Bitscope early during the project.  As a team we measured some signals with it.  Things seemed great, but we never paid super close attention to how accurate it was.  It was not until the final week of the project when we discovered that the Bitscope readings were significantly off what we were measuring with our bench-top oscilloscopes.  We searched the internet looking for answers. Bitscope is not all that well documented.  With only a few days before the deadline, we emailed Bitscope support but never received a response until after we presented the final product to the FAA.  I have forwarded their response to the FAA and offered my support to attempt a fix.  The "automatic" feature and displaying the signal would have been really nice to have delivered on.  As a team we spent many late nights, some sleepless, trying to work out these problems.




These are only the problems that we never were able to overcome, but there were several more that we did overcome.  During the final week of this project, someone on the other team (two separate teams built devices for the FAA) broke a bolt on the tilt sensor.  We improvised a fix, but after being completely taken apart to be fixed, the sensitive device will likely never be the same.  Another obstacle that came in the final hours of work done on this project was when we shorted some of the solder joints on the bottom of the Raspberry Pi.  During final assembly, a loose nut worked its way under where the Pi was mounted and when power was applied the Pi smoked.  What an intense moment that was.  We carefully disassembled the stack of electronics and determined that all was fine but the Raspberry Pi.  Without time to spare, I went home and got the Raspberry Pi that I was using as a [toy home server](http://codyalantaylor.com/archive/resistor-combination-app/) to use as a replacement.  Once replaced, things worked great but my nerves may never be the same.




[![2015-09-27 16.12.57](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-09-27-16.12.57.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-09-27-16.12.57.jpg) [![2015-12-04 02.34.26](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-02.34.26.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-02.34.26.jpg)




Before our final presentation to the FAA, we made a trip out there to meet with the technician who would be using our device to see about any last minute adjustments that he would like to be made.  He did use the device to calibrate a tilt sensor while we were there.  It was very fulfilling to see the device perform its intended purpose.  Our final presentation went well.  We spent about just as much time explaining our device as we did reflecting on design decisions.  The lead engineer of the group asked two questions before we left that summed up the morning quite well.  One question, he asked to the technician who would use our device. The other he asked each of us who worked on the project.  To the technician he asked what sort of time savings should be expected with a device such as ours.  He said that it is not unheard of for him to spend six hours calibrating a single tilt sensor.  He said that with our device, he thinks that he can do it in under a single hour.  Hearing that made all the long hours worth it.  The question that struck me the most; however, was the one he asked my group.  He asked each of us what our biggest take-away from this project was.  I should have expected that question, but I hadn't.  Other group members spoke up before I did which gave me time to come to a realization.  In my long career as an undergraduate engineering student, working on this project was the first time that I truly felt like an engineer.  We were given design goals at the beginning of the semester.  I spent a lot of time trying to understand the project from every possible viewpoint.  I spent a lot of time scouting out parts, reading about analog to digital converters, stepper motors, motor controllers, and Python.  I went through a handful of mechanical designs and a prototype before settling on the one that I ultimately built.  I made seemingly hundreds of trips to the hardware store in order to have the perfect parts on hand during assembly.  I spent nearly every moment of my spare time this semester thinking about this project.  I strove for perfection, but settled for something that turned out to be pretty good for the time allotted.  I could write for days about this project, but still would not begin to explain all that I learned.




[![2015-11-07 17.10.57](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-07-17.10.57.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-07-17.10.57.jpg)




Arranging parts




[![2015-11-07 19.38.23](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-07-19.38.23.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-07-19.38.23.jpg)




My first serious attempt at welding... Pretty proud of that bead. :)




[![2015-11-15 20.01.26](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-15-20.01.26.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-15-20.01.26.jpg)




Clear coat made the paint crack.  Put an embarrassing amount of time into that paint.  Watching it crack was difficult.  Still unsure of why that happened.




[![2015-11-08 23.31.09](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-08-23.31.09.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-08-23.31.09.jpg)




Mocked up in primer




[![2015-11-30 23.40.47](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-30-23.40.47.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-11-30-23.40.47.jpg)




Finally got to see the guts of the tilt sensor when it had to be taken apart to be repaired.




[![2015-12-01 23.51.54](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-01-23.51.54.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-01-23.51.54.jpg)




Prototype of virtual ground circuit with +/- 5v rails with an astable multivibrator op-amp circuit.




[![2015-12-04 06.18.07](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-06.18.07.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-06.18.07.jpg)




Final assembly.




[![2015-12-04 06.17.40](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-06.17.40.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-06.17.40.jpg) [![2015-12-04 06.17.49](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-06.17.49.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/12/2015-12-04-06.17.49.jpg)




[![PAPI SELF](http://codyalantaylor.com/wp-content/uploads/2015/12/PAPI-SELF.png)](http://codyalantaylor.com/wp-content/uploads/2015/12/PAPI-SELF.png)
