---
author: codyalantaylor
comments: true
date: 2015-09-04 04:04:33+00:00
layout: post
slug: simple-lamp
title: Simple Lamp
wordpress_id: 900
categories:
- Electronics
- Open
- Woodworking
---

A couple weeks ago, I needed a lamp, and I also needed one last summer project. I had a little material left over from the entertainment cabinet that I made a few weeks prior. I looked at a ton of lamp designs before I sketched a design of my own. One thing I noticed about the lamps I looked at is that there is no shortage of wild designs. In fact, I had a hard time finding designs that were sufficiently simple to my taste. The secondary motivation for building a lamp of my own was my dissatisfaction with the switch typically used in lamps. I'm talking about the switch that is built into the socket, the one that you have to blindly reach inside of the lamp shade to turn. For a long time I have been frustrated by fumbling with these switches. To fix this I set out to design my lamp around this switch frustration.

[![latch](http://codyalantaylor.com/wp-content/uploads/2015/09/latch.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/latch.jpg)

To keep the design simple meant that I needed to find a switch that was both elegant and intuitive. To address the intuitive requirement, I wanted a button switch mounted front and center in the base of the lamp. I decided that the button should be copper as that would match the red mahogany stain I planned to use. Finding a copper button that was simple and an appropriate size proved difficult to do. Strangely enough I found a copper modification kit for a particular e-cigarette that is essentially a copper cylinder with a push button on the end. Who knew that people were so particular about their e-cigarettes that there is a market for dress-up kits?! Anyway, in order to get the button I had to buy the whole thing. When it came in the mail and I opened it and saw that it had a brand mark on the face of the button of all places. The mark was a cartoon hand with its middle finger triumphantly stuck into the air. Fantastic! It turns out that I was able to sand off the mark with some very fine sandpaper and then painted on a clear coat to prevent the copper from tarnishing. No harm done.

[![2015-08-23 10.27.56](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-23-10.27.56.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-23-10.27.56.jpg)

The button is a momentary-push button meaning that it does not latch and unlatch, but that it bounces right back after being pressed. This is problematic because it does not make much sense to have a lamp with a momentary switch. This meant that I needed to make a latch circuit that could be toggled by a momentary button and that could also pass the current required to light a light bulb. I used a bunch of latch circuits in a tic-tac-toe game that I built last semester, so I'm fairly familiar with the components involved, but those only passed 20mA at 9v. For this lamp I needed a latch circuit that could pass something like 500mA at 110v. There is one transistor in a latch circuit that passes the bulk of current to the load. I knew that a beefy power transistor could do this relatively easy. Even though I was confident that the limitations of the components I was using exceeded the requirements of the lamp I was still less than confident in my ability to design a circuit that would be plugged into the wall. With only a handful of credit hours to go before I complete an electrical engineering degree, I have never designed a circuit that involved more than a couple dozen volts and never more than a few hundred milliamps!! -a major shortcoming in our curriculum, if you ask me. Perhaps asking us build things that get plugged into the wall is too much of a liability. Anyway to avoid having to worry that a circuit I designed might set my apartment on fire, I decided to use a 12v LED light bulb. I bought a 12v power supply, outsourcing the design I was uncomfortable with to a professional. A person would have to screw up pretty badly to burn down a house with a 12v power supply. This gave me peace of mind and I proceeded to design the latch circuit for 12v instead of 110v.

[![2015-08-02 20.55.21](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-02-20.55.21.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-02-20.55.21.jpg)

[![2015-08-02 20.07.11](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-02-20.07.11.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-02-20.07.11.jpg)

The base of the lamp is circular with a straight dowel through the center. The light bulb socket, is of course, attached to the top of the dowel. Originally the dowel was solid which meant that I somehow needed to cut a hole all the way through its center in order to run wires to the socket. The dowel was far too long to simply use a drill bit. I decided to cut a quarter-inch channel in the dowel and then glue in a quarter-inch square dowel into in order to make the surface of the dowel continuous again, but that also left a square hole that ran the length of the dowel. The square dowel didn't fit flush, but needed to be sanded into shape such that the dowel was round again. -This worked well. -I'd do it again if I needed to.

[![2015-08-22 19.35.35](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.35.35.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.35.35.jpg)

[![2015-08-22 19.53.53](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.53.53.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.53.53.jpg)

[![2015-08-22 20.41.52](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-20.41.52.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-20.41.52.jpg)

[![2015-08-22 20.42.08](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-20.42.08.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-20.42.08.jpg)

[![2015-08-23 14.39.55](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-23-14.39.55.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-23-14.39.55.jpg)

To cut the base I drew a 12" circle on a 5/8" thick board and drilled a 1.125" hole in its center to accept the dowel. I had planned on using a bandsaw to cut the circle by hand, but my dad suggested building a jig to do it. By his suggestion, I built a jig that sat in a slot in the bandsaw table. The jig is difficult to explain, but I'll try. It had a post in it that was 6" (half the desired diameter) from the bandsaw blade. The board that would become the based sat down on and accepted this post. When that piece of material to be cut was rotated into the blade it cut out a perfect 12" circle. Having been quite skeptical of this method when my dad suggested it, I was amazed to see that I cut out a perfect circle.

[![2015-08-22 19.35.35](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.35.35.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.35.35.jpg)

[![2015-08-22 19.53.53](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.53.53.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-22-19.53.53.jpg)

[![2015-08-30 11.41.45](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-30-11.41.45.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-30-11.41.45.jpg)

For the base to accept the electronics, I needed to route out two pockets and a channel on the bottom of the base. One would accept the circuit board that has the latch circuit on it. The other would accept the switch. What I am calling the button, does not actually perform the electrical switching function. Instead it is actually just a spring loaded plunger. The plunger of the button when pressed actuates a tiny self-contained push-button switch that I embedded in the base. The copper button, itself is inset in the top of the base of the lamp at such a depth that its plunger moves only enough to actuate the switch. I routed out a channel in the bottom of the base for which to run wires between the circuit board and the switch and up through the dowel to the socket. At the back of the lamp, I I drilled a hole just big enough for the wires from the power supply to fit through. I tied a knot in the wires just inside the base as strain relief. Once the switch, circuit board and all the wires were in place, I mixed up some epoxy resin and encased them all such that the base of the lamp was relatively flat again. After the resin had set up I cut out a circle from a thin sheet of cork and fixed it to the bottom of the base to keep from scratching any surface that it sits on.

[![2015-08-30 11.58.12](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-30-11.58.12.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-30-11.58.12.jpg)

[![2015-08-28 21.25.40](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-28-21.25.40.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/09/2015-08-28-21.25.40.jpg)

I added a cork lampshade and the lamp was done. Aside from some testing, that is. I was still feeling a small but non-zero amount of nervousness about plugging the thing in and leaving it on for a few hours, but after doing so under supervision I am now comfortable with it.
