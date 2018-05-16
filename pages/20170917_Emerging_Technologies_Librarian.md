Often I'm asked what it means to be an Emerging Technologies Librarian.  In an effort to be brief, I stick to saying that, "I introduce technology to the OU campus. Specifically, I manage a makerspace that is home to 3D printers, virtual reality workstations, electronics equipment, and students of various interests." My perception of what people glean, from this explanation is, "you're the 3D printer guy?!" To which I say, "yes, I'm the 3D printer guy."

![[3D printed](https://www.thingiverse.com/thing:182089) [capybara](https://en.wikipedia.org/wiki/Capybara)](http://codytaylor.cc/opti/capybara.jpg)

When I started this position about a year ago I welcomed the chance to learn 3D printing and how to apply it, but never did I seek to be *the 3D printer guy*. Though I do spend a large portion of my time, ensuring that our constantly-running 3D printers are running and churning out anything and everything the campus asks of them, I often have the pleasure of doing far more interesting work. What follows is an example of that work.

Lauren is a student who regularly visits the Edge. Some students spend large portions of their free time in the Edge. -not Lauren.  She drops in occasionally to say, "hello" only staying for longer periods when she's up to something.  Though she isn't studying any of these directly, she and I have done circuit analysis together, we've written code, and we've 3D printed.  On her most recent visit to the Edge, Lauren told me that she's trying to learn Python and asked if I knew of any resources to help her with that. I encouraged her to take a look at the [Software Carpentry lesson on Python](http://swcarpentry.github.io/python-novice-inflammation/) and to consider a relatively easy problem as an exercise while trying to learn the basics of the language. She told me that she is working on an undergraduate research project involving Monte Carlo simulations.

Serendipitous it was that she was working on a [Monte Carlo simulation](https://en.wikipedia.org/wiki/Monte_Carlo_method), because [I have implemented Monte Carlo simulations as exercises to learn new programming languages myself!](http://codytaylor.cc/pages/20141010_Pi_Calculation_Via_Monte_Carlo_Simulation.html) After a discussion, I encouraged her to attempt to calculate pi using the Monte Carlo method. I stressed to her that this is one of the least efficient methods for calculating pi and that it is purely an exercise in learning the language itself as the math involved was well within her understanding as was the expected result. Several weeks passed between when I suggested this to Lauren and when I heard from her again.

> Hey Cody!
> I did it! (Or at least, I think I did) And it calculates roughly 3.14 but probably more if I use more points, but that might take awhile if I wanted more digits.
> How does this look?

That excitement is one of the things I enjoy most about my job. She included the code she had written and I followed up with a question that I hoped would prompt her to consider faults or biases that might be present in her code. I wanted her to discover why this method of calculating pi is not the most efficient or fastest to converge to the known value of pi.

```python
import random, math

points = int(input(" How many points do you want to calculate? Hint: more points = more pie:" + "\n> " ))

inCount = 0
i = 0

while i < points:
    x = random.random()
    y = random.random()

    if math.sqrt((x**2)+(y**2)) <= 1:
        inCount += 1

    i += 1

print(4*(inCount/i))
```

> That looks excellent, Lauren!!  This made my day!
>
> My results:
>
> 3.124           - 1,000 points
>
> 3.1232         - 10,000 points
>
> 3.14168       - 100,000 points
>
> 3.142084     - 1,000,000 points
>
> 3.1415316   - 10,000,000 points
>
> 3.14194152 - 100,000,000 points
>
> **Question!  Why does the difference in the results and the known value of pi not decrease at a rate proportional to the number of points used in the calculation?**
>
> Cody

Lauren and I exchanged emails until she tracked me down at my office after I had taken far too long to respond to our chain of emails. -an occurrence I find true pleasure in. (How many librarians have students track them down to discuss code?!) During that discussion I realized that Lauren's Python skills had grown to match my own and I was of little help to her. It could be that I enjoyed this exercise more than she did; though, if that were the case she definitely humored me by asking evermore interesting questions.  

Though much of my time is consumed by maintaining 3D printers, I have made it my job to help students discover and polish interests such as this in hopes that these will be the highlights of their academic careers -the interests that turn into their own careers, much like being a serial hobbyist turned into mine.
