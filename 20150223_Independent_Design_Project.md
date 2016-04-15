---
author: codyalantaylor
comments: true
date: 2015-02-23 16:33:39+00:00
layout: post
slug: independent-design-project
title: Independent Design Project
wordpress_id: 372
categories:
- Electronics
- Open
---

## Context


The past few posts, [Diodes Lab](http://codyalantaylor.com/archive/diodes-lab/), [MOSFET Lab](http://codyalantaylor.com/archive/mosfet-lab/), and [Timer Lab](http://codyalantaylor.com/archive/timer-comparator-lab/) have all been written in the form of reports for my Electronics Lab class. For this class we're tasked with building several circuits exploring each of these components, their applications, and their limitations.  For each, in addition to designing and building these circuits we're also required to write a lab report explaining our designs and their functionality. Instead of typing up these reports in Word, I decided to share them here and print them out to turn in.  I hope that these write-ups might help someone who is learning electronics, but more realistically I imagine that these will serve as references for myself.


## Assignment


For my individual design project, I chose to build an electronic tic-tac-toe game using MOSFETs, LEDs, and a couple 555 timers.  In this game Xs and Os are represented by single green and red LEDs. The original plan was to have one button for each of the nine squares that make up the playing area of the game. I tried several different configurations in attempt to make a single-button design work, but never was able to get it working correctly so in the interest of finishing the project before its deadline, I chose to use two buttons per square of the playing area. One button would control the red LED, and the other button would control the green LED. Although less elegant, this configuration worked on the first attempt. Another feature of the game I envisioned since the beginning, was an indicator that someone had won and where on the playing surface the win had taken place.  -that is, a win indicator for each row, column, or diagonal.  This was not difficult to design, but was difficult to build considering how cramped the breadboards had become by the time I built this part of the circuit.  To fulfill the requirements of the assignment, I included two 555 timers in the design.  One flashes a green LED at about 10Hz, the other a red LED at the same frequency.  These were primarily included only to fulfill the assignment requirements, but I suppose could be thought of as on-indicator lights as electronic games often feature.

[embed]https://www.youtube.com/watch?v=Mv5zdKkMaD8[/embed]




##  Latch Design


I tried my best to create two independent latch circuits, one controlling a green LED and the other a red LED.  In this configuration I imagined having one switch that would turn on either latching circuit depending on whose turn it was in the game.  I also planned on using a 555 timer in a flip-flop configuration to keep track of whose turn it was.  When the output of the 555 was high it would be one player's turn and when low, the other player's.  After each press of a button on the playing surface, the 555 would need to switch states.  The design that most closely performed as I intended it to is in the diagram below.  It does allow for selectively controlling each LED; however, when switching between states it unintendedly toggles the state of the LED who is being unselected.

[![latch-design-3](http://codyalantaylor.com/wp-content/uploads/2015/02/latch-design-3.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/latch-design-3.jpg)



The P-channel MOSFET was intended to be on, or make the red LED active when the 555 timer was in its low state.  Likewise, when the 555 was in its high state, the N-channel MOSFET was intended to be on, making the green LED active.  Again, I was not able to make this circuit work in practice and opted to build the following design.

[![latch-final-design](http://codyalantaylor.com/wp-content/uploads/2015/02/latch-final-design.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/latch-final-design.jpg)



The circuit above comprised only one cell of the playing area, that is to say, in the complete circuit this sub-circuit was repeated **nine** **times.  **

[![birdseye](http://codyalantaylor.com/wp-content/uploads/2015/02/birdseye.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/birdseye.jpg)


## Win Indicator


The win indicator circuitry is simple, yet in order to accommodate all 16 possible win configurations (8 for green, 8 for red), I build 16 three-way AND gates.  Because all I wanted to do was  turn on an LED when a row, column, or oblique had three green or three red LEDs lit, this meant cascading three BS170 MOSFETs together source-to-drain, source-to-drain, and connecting the unconnected drain to the +5v rail through a 1k ohm resistor and the unconnected source to the ground rail through a respectively colored LED, while each gate was connected to a respective latch circuit in a given row, column or oblique.

[![and-gates](http://codyalantaylor.com/wp-content/uploads/2015/02/and-gates.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/and-gates.jpg)



Above is one set of win indicators.  I repeated this circuit 8 times, once for each possible winning scenario.  Below is how the win indicators are connected to the latch circuitry.

[![win-indicators](http://codyalantaylor.com/wp-content/uploads/2015/02/win-indicators.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/win-indicators.jpg)



In all, the win indicators are comprised of 32 MOSFETS, bringing the total transistor count for the project to 68.


## Reliability Theory


Based on the Parts Count Failure Rate Data Excerpt from MIL-HDBK-217F, I have calculated the failure rate over one year of this design.

[latex]part failure rate = GF\times quantity \times quality factor [/latex]                       [latex]failures/10^6 hours[/latex] 
<table width="361" >
<tbody >
<tr >

<td width="101" >
</td>

<td width="65" >Quantity
</td>

<td width="65" >GF
</td>

<td width="65" >pi q
</td>

<td width="65" >Part Quantity Fail Rate
</td>
</tr>
<tr >

<td >MOSFETS
</td>

<td >68
</td>

<td >0.099
</td>

<td >8
</td>

<td >53.856
</td>
</tr>
<tr >

<td >Resistors
</td>

<td >94
</td>

<td >0.0022
</td>

<td >10
</td>

<td >2.068
</td>
</tr>
<tr >

<td >Ceramic capacitors
</td>

<td >18
</td>

<td >0.0074
</td>

<td >10
</td>

<td >1.332
</td>
</tr>
<tr >

<td >LEDs
</td>

<td >36
</td>

<td >0.0012
</td>

<td >8
</td>

<td >0.3456
</td>
</tr>
<tr >

<td >Pushbuttons
</td>

<td >18
</td>

<td >0.003
</td>

<td >20
</td>

<td >1.08
</td>
</tr>
<tr >

<td >Ics
</td>

<td >2
</td>

<td >0.024
</td>

<td >10
</td>

<td >0.48
</td>
</tr>
</tbody>
</table>
[latex]R = e^{-(53.856+2.068+1.332+.03456+1.08+.48 \times365.25 \times 24)}=.5953 \rightarrow 59.53\%[/latex]  [latex]chance of failure within 1 year[/latex] 

Such a high failure rate is due to the large number of parts in this design, 236 total parts.


## Conclusion


This circuit was difficult to build, not because of its complex design, but because of its sheer size and number of components.  To build it, I utilized three dense, yet very organized breadboards as well as one half breadboard.  I also, quickly used all of the pre-cut jumper wires that I own and ended up cutting and stripping about 75% of all the wires used by hand. I am glad that I spent a few minutes at the beginning of this project to think about how it would be laid out on breadboards, because without that, this project would have become a mess and would have been much more difficult to build.

[![2015-02-22-23.50.44](http://codyalantaylor.com/wp-content/uploads/2015/02/2015-02-22-23.50.44.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/02/2015-02-22-23.50.44.jpg)
