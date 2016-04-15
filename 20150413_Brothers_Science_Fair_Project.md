---
author: codyalantaylor
comments: true
date: 2015-04-13 00:45:48+00:00
layout: post
slug: brothers-science-fair-project
title: 'Brother''s Science Fair Project: Tic-Tac-Toe'
wordpress_id: 424
categories:
- Education
- Programming
---

For the past month or so I have been helping my brother with a middle school science fair project. He chose to enter the math and computers category. Other choices included; consumer product comparison, engineering, biology, and a few others. He said that he chose the math and computers category because his teacher informed the class that historically few people compete in that category. He asked me to help him with his project and I couldn't be more proud of that. Together, we spent a couple weeks trying to come up with a good project idea. In the end, my brother insisted on taking a look at how computers might play Tic-Tac-Toe. Specifically, he wanted to compare the win statistics of a computer to those of people.

Some algorithms that play Tic-Tac-Toe are well documented, but none are straight-forward enough for a twelve year old to understand. Honestly, most are so complex that I did not care to spend much time trying to understand them. Considering this, my brother and I set out to build an algorithm to play Tic-Tac-Toe ourselves. From research we knew that the player who makes the first move has a better chance of winning. Considering this, we decided that our algorithm would be forked into two parts, one where the computer algorithm has the first turn, and the other where the player makes the first move. Because I thought it would be most difficult we built the computer-first aspect of the game first. My brother, prior to this project, had no programming experience. For this reason we built our algorithm using [Scratch](https://scratch.mit.edu/). Full disclosure: I think that the visual nature of Scratch helped me keep track of the intricate logic involved too.

We chose what we believed to be the most simple way of analyzing the Tic-Tac-Toe grid. That is, to assign a number to each cell such that the cells in each column, row, and diagonal add up to 15. Using this method, it is easy to analytically decide where the next move should be. The [Wikipedia article on Tic-Tac-Toe](http://en.wikipedia.org/wiki/Tic-tac-toe) is excellent and outlines a number of strategies including the one we chose to use, the [magic square method](http://en.wikipedia.org/wiki/Magic_square).

[![Magicsquareexample (3)](http://codyalantaylor.com/wp-content/uploads/2015/03/Magicsquareexample-3-1024x796.png)](http://codyalantaylor.com/wp-content/uploads/2015/03/Magicsquareexample-3.png)



A magic square is divided into a grid where each cell has been assigned a number such that the sum of each column, row, and diagonal all equal the same number.  In this case, that number is 15 as shown above.  By creating variables that keep track of the sum of each column, row, and diagonal and then subtracting the value of each occupied cell from the columns, rows, or diagonals that that cell belongs to we're able to know which cells remain unoccupied.  Here is an example to clear that up.
<table >
<tbody >
<tr >
 X - Totals
 O - Totals
</tr>
<tr >

<td > [![MagicSquare-Demo5](http://codyalantaylor.com/wp-content/uploads/2015/03/MagicSquare-Demo5-300x260.png)](http://codyalantaylor.com/wp-content/uploads/2015/03/MagicSquare-Demo5.png)
</td>

<td >[![MagicSquare-Demo4](http://codyalantaylor.com/wp-content/uploads/2015/03/MagicSquare-Demo4-300x260.png)](http://codyalantaylor.com/wp-content/uploads/2015/03/MagicSquare-Demo4.png)
</td>
</tr>
<tr >

<td >[latex]D1 = 15 - 2 - 8 = 5 \\ \\
D2 = 15 - 4 = 11 \\ \\
H1 = 15 - 2 = 13 \\ \\
H2 = 15 \\\\
H3 = 15 - 4 -8 = 3 \\ \\
V1 = 15 - 2 - 4 = 9 \\ \\
V2 = 15 \\ \\
V3 = 15 - 8 = 7
[/latex]
</td>

<td >[latex]D1 = 15 - 5 = 10 \\ \\D2 = 15 - 6 - 5 = 4 \\ \\H1 = 15 - 6 = 9 \\ \\H2 = 15 - 5 = 10 \\ \\H3 = 15 \\ \\V1 = 15 \\ \\V2 = 15 - 5 = 10 \\ \\V3 = 15 - 6 = 9[/latex]
</td>
</tr>
</tbody>
</table>
Notice that there are two separate totals kept for each row, column, and diagonal.  -one for Xs and another for Os.  Separately keeping track of these totals makes determining the winning cell easy as well as determining which cell to choose in order to block an opponent from winning.

In the case that the algorithm is allowed to make the first move, it follows a well documented pattern of moves in order to allow itself two winning moves to chose from at once. That is, during the opponent's final turn they are only able to block one of the two winning cells. This pattern begins by randomly choosing a corner cell on the first turn of the game.  During the algorithm's second turn it should choose the corner cell that is directly opposite that of the first move. By this point in the game, the opponent has most usually chosen the center cell and one of the corner cells.  If so, the algorithm's third move should be to occupy the only remaining cell.  If this is possible, the algorithm is set to win the game on its next turn as it has two possible winning moves that it can make during its next turn; however, the opponent may only block one. There are scenarios in which the magic square algorithm does not directly point to where the next move should be made.  In those cases the algorithm, narrows down its possible moves as much as it can then makes moves at random until it chooses an un occupied place to move. Sometimes when this happens, you might notice that the game seems to be glitching, though in fact it is searching for a place to move. In not so many words the sequence below explains the strategy implemented in our algorithm.

[caption id="attachment_476" align="alignnone" width="1000"][![CC: BY-SA Wikipedia user: Kilom691](http://codyalantaylor.com/wp-content/uploads/2015/03/1000px-Tic-tac-toe-game-1.png)](http://codyalantaylor.com/wp-content/uploads/2015/03/1000px-Tic-tac-toe-game-1.png) CC: BY-SA Wikipedia user: Kilom691[/caption]

Of course, this strategy does not guarantee a win. In fact it is most certainly possible for the game to end in a tie with neither player able to place three of their marks in a row.  The version of the game that my brother used in his science fair project is embedded below.  We only finished the portion of the game where the computer has the first turn.  We found another game that played the portion of the game where the player has the first turn and gathered statistics using it.  We would still like to finish our player-first algorithm, but figured that what we have built thus far deserves to be documented.


The data that my brother collected is in the tables below.  The first table contains the control data for this experiment.  That is, it acted as a baseline from which to compare how well computer algorithms are able to play Tic-Tac-Toe.  It contains data collected over 50 games of Tic-Tac-Toe played between several different people. The number of times the player who made the first move and won the game is compared to that of first turn losses as well as ties.

The second table contains data from a set of games played against the computer algorithm.  During this test the computer algorithm always made the first move.  As you can see a novice player (one that is unfamiliar with Tic-Tac-Toe strategies) loses to the computer algorithm most of the time; however, ties were found to also be common though the algorithm never lost a game to the human opponent during this test.

The data in the third table was collected over a trial where the human opponent always made the first move.  During this test the computer algorithm never lost a game, but the data does seem to indicate that the player who makes the first move is still at an advantage even if that player never did win a game.  -Though even with an apparent advantage, the human did still sometimes lose.


### Person v. Person


<table >
<tbody >
<tr >
 First Turn Win

 First Turn Lose
</tr>
<tr >

<td > Win
</td>

<td > Tie
</td>

<td > Lose
</td>
</tr>
<tr >

<td > ||||  ||||  ||||  |||
</td>

<td > |||| |||| |||| |||
</td>

<td > ||||  |||| ||||
</td>
</tr>
</tbody>
</table>


### Person v. Computer: Computer First


<table >
<tbody >
<tr >
Computer Win
 Tie
 Computer Lose
</tr>
<tr >

<td > ||||  ||||  ||||  ||||
</td>

<td > |||| |||| ||||
</td>

<td >
</td>
</tr>
</tbody>
</table>


### Person v. Computer: Player First


<table >
<tbody >
<tr >
 Player Win
 Tie
 Player Lose
</tr>
<tr >

<td >
</td>

<td > |||| |||| |||| ||||
</td>

<td > |||| ||||
</td>
</tr>
</tbody>
</table>
What my brother concluded of this data was that computer algorithms can be made to never lose a game of Tic-Tac-Toe though they can still be tied.  Comparing this to the Human v. Human trials, computer algorithms are much, much better at playing Tic-Tac-Toe than the average player.

[![Jett-Science-Fair](http://codyalantaylor.com/wp-content/uploads/2015/04/Jett-Science-Fair.jpg)](http://codyalantaylor.com/wp-content/uploads/2015/04/Jett-Science-Fair.jpg)

In his school-wide science fair, my brother placed second in his category.  The top three projects from each category were entered into a regional science fair that took place at a local community college.  There my brother placed first in his category.  I was unable to be there for the awards ceremony, but here he is FaceTiming me the evening of the fair proudly showing me his trophy and telling me about the event.  I also understand that In the coming week he is going to be recognized by the local school board for doing so well at a regional competition.  This big brother couldn't be more proud.
