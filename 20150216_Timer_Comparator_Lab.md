---
author: codyalantaylor
comments: true
date: 2015-02-16 20:11:24+00:00
layout: post
slug: timer-comparator-lab
title: Timer / Comparator Lab
wordpress_id: 345
categories:
- Education
- Electronics
---

## Problem 1: One-Shot 555


Design a circuit that turns on an LED for 600 millisecond (+/- 100 milliseconds).


### Circuit Setup


[![1-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/1-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/1-circuit.jpg)

[![1](http://codyalantaylor.com/wp-content/uploads/2015/02/1.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/1.jpg)


## Problem 2: Inverten One-Shot 555 Motor Driver


Utilize a MOSFET inverter to flip the logic in part one. This time have a motor running and turn it off for 1 second (+/- 0.2 seconds) and then have it start up again. Comment on how much time you had to set for your delay pulse to make the motor turn off for one second. Also, please use a protection diode so your MOSFET doesn’t smoke. You might also consider having multiple MOSFETs in parallel for this problem.


### Circuit Setup


[![2-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/2-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/2-circuit.jpg)

Note: We used a 3 second off period because the motor took 2 seconds to spin down.

[![2](http://codyalantaylor.com/wp-content/uploads/2015/02/2.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/2.jpg)


[latex]t=RCLN(3)[/latex]




[latex]3sec.=(1M\Omega)(C)Ln(3)[/latex]




[latex]\frac{3sec}{(1M)(Ln(3))}=C=3\mu F[/latex]





## Problem 3: 555 Frequency Divider


Design a circuit that converts a 1.2 kHz 50% duty cycle square wave to a 400 Hz square wave.


### Circuit Setup


[![3-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/3-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/3-circuit.jpg)

[![3 555 Frequency Divider](http://codyalantaylor.com/wp-content/uploads/2015/02/3-555-Frequency-Divider.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/3-555-Frequency-Divider.jpg)


### Note:


Had a difficult time building this circuit.  -built is several times using diagram found on internet for frequency divider, but was never able to make it work.  We discovered that the LM555 datasheet had an example of a frequency divider in it.  That circuit worked very well.


## Problem 4: Bistable 555 LED Blinker


Design a bistable 555 timer circuit that toggles a Red LED on and off. Connect the output to a MOSFET inverter so that a green LED turns ON when the red LED turns OFF and vice versa.


### Circuit Setup


[![4-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/4-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/4-circuit.jpg)


## Problem 5: AC-In PWM-Out 555 Pulse Width Modulator


Design a 555 Timer Pulse Width Modulator circuit and adjust the control voltage with the DC supply up and down so it looks like a sinewave and produces an output similar to the datasheet.


### Circuit Setup


[![5-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/5-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/5-circuit.jpg)

[![5 AC to PWM](http://codyalantaylor.com/wp-content/uploads/2015/02/5-AC-to-PWM.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/5-AC-to-PWM.jpg)


## Problem 6: Thermistor Temperature Indicator with Comparator


Using a thermistor and a comparator IC (LM293) to turn on 2 LEDs sequentially as the temperature gets warmer. You can cover the thermistor with your fingers to heat it up.


### Circuit Setup


[![6-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/6-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/6-circuit.jpg)


## Problem 7: 38kHz Square Wave Generator


Design a 555 timer circuit that has a 50% duty cycle 0 to 5 Volt square wave in MultiSim. **Don’t use 1nF capacitors.** Use a potentiometer to vary the frequency between 36 and 40 kHz. When the potentiometer is turned all the way counter clockwise the frequency should be 36 kHz and when the potentiometer is turned all the way clockwise the frequency should be 40 kHz. Use the MultiSim scope to make measurements needed to calculate the frequency.


### Circuit Setup


[![7-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/7-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/7-circuit.jpg)

[![7 Variable Frequency 555 36kHz](http://codyalantaylor.com/wp-content/uploads/2015/02/7-Variable-Frequency-555-36kHz.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/7-Variable-Frequency-555-36kHz.jpg)

[![7 Variable Frequency 555 40kHz](http://codyalantaylor.com/wp-content/uploads/2015/02/7-Variable-Frequency-555-40kHz.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/7-Variable-Frequency-555-40kHz.jpg)


## Problem 8: 38kHz Infrared Signal Controlled Motor Driver


Design a circuit that will turn on a motor when it detects a TV remote control signal. You will use the 38 kHz IR detector sensor to accomplish this (see spec. sheet on D2L). Instead of using an actual TV remote connect the signal from the circuit in problem 7 to an IR LED via a resistor. You will likely need to include a MOSFET in your design.


### Circuit Setup


[![8-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/8-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/8-circuit.jpg)

[![8 38kHz](http://codyalantaylor.com/wp-content/uploads/2015/02/8-38kHz.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/8-38kHz.jpg)




### Note


Had a tough time getting the IR receiver to work properly because we were using a receiver whose part number we were unsure of so we looked a datasheets that seemed similar to the part we were using. -wasted hours.  Bought a new 38kHz receiver from Radio Shack (during weekend, didn't have access to parts closet) and looked at its datasheet for the correct pinout.  -had no problem making it work.  Lesson learned.


## Special Design Problem: PWM Motor Controller


Create a PWM (also commonly referred to as PDM) speed control circuit. Use a potentiometer to adjust the speed. Connect the output to a common drain amplifier (source follower) so that it can source more current.   Use the IRF620 or other Power MOSFET for the source follower (return the Power MOSFET after using it because they are expensive). Demonstrate the circuit by controlling the speed of a motor.


### Circuit Setup


[![special-circuit](http://codyalantaylor.com/wp-content/uploads/2015/02/special-circuit.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/special-circuit.jpg)



Compared to other independent design problems, this was not too bad.  Simply built a 555 PWM circuit and used it to drive the gate of a MOSFET.  It worked beautifully.
