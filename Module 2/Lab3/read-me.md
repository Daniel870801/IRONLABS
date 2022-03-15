Part1

Challenge1
[20,34, 34, 12, 56, 110, 49, a, b]
First, I have to sort ascendingly the 7 values.
[12,20,34,34,49,56,110,a,b]
The median value is for the moment 34. To make it 42, I need the 5th value to be 42. It is not in the dataset, so it will be either a or b.
Let it b! (^o^)
Then I have to find a so the sum divided by 9 is 50. The sum without a is 357.
9*50=450
450-357=93

a=93
b=42

Challenge2
avg=(v1+v2)/2=(60+110)/2=85kmph

Challenge3

Looking at the histogram (cf challenge3.jpg), it is about 250/400=63%

Challenge4
times=[0–19, 20–39, 40–59, 60–79, 80–99, 100–119, 120–139, 140–159, 160–179]
freq=[16, 13, 17, 4, 4, 3, 1, 1, 1]

times=[(0,19), (20,39), (40,59), (60,79), (80,99), (100,119), (120,139), (140,159), (160,179)]
means=[np.mean(i) for i in times]
sums=[means[i]*freq[i] for i in range(len(freq))]
print('the mean is',sum(sums)/sum(freq)) ===> 46.5

MEDIAN
median group: 80-99
L=80
n=60
B=44
G=4
W=19

median= 80+(60/2-40)/4*19 =32.5

STDEV
√Σni(mi-μ)2 / (N-1)
sqroot(16*(9.5-46.5)^2+13*(29.5-46.5)^2+17*(49.5-46.5)^2+4*(69.5-46.5)^2+4*(89.5-46.5)^2+3*(109.5-46.5)^2+(129.5-46.5)^2+(149.5-46.5)^2+(169.5-46.5)^2)/(60-1)
stdev=36.8

Part3 

Challenge 1
One player rolls two dices. Describe the measurable space (MS) and the random variable (RV) for:

    A. The values that the player obtains.
MS is the number of double-dice outcomes possible such as (1,1), (1,2),...,(6,6)
RV is the sum of the 2 outcomes in the tupple (any value between 2 and 12)

    B. The sum of the values obtained.
sum of 2 dices (from 2 to 12)
    C. The maximum value obtained after rolling both dices.
12, since the max value of each dice is 6.


Describe the following events:

    Case A: Both values are greater than 5.
Both values are 6
    Case B: The sum of values is even.
The sum of values 5 or 3 (4+1,2+1,3+2)
    Case C: The maximum is the value of both rolls.
??

Challenge 2

One player picks two cards from a poker deck. Describe the measurable space and the random variable for:

    A. The number of figures he picks.
MS: 1 or 2
RV: p1=16/52 p2=16/51 or 15/51 if picked a figure the first time

    B. The sum of card values. Consider that the value of figures is 10 and the value of aces is 15.
Minimum non figure is 2. Max would be 2 aces
The sum goes from 4 to 30.

    C. The number of hearts or spades he picks.
26/52 as hearts+spades account for half of the deck.

Describe the following events:

    Case A: The number of figures in the cards the player picked is two.
The player's score is 20
    Case B: The sum of card values is 17.
The player picked either 1 figure +7,1 ace + 2, 10+7,9+8
    Case C: The value of both cards is less than 8.
(4,3),(2,1),(2,2),(4,2),(5,2),(3,3),(5,1)

Challenge 3

Two players roll a dice. Describe the measurable space and the random variable for:

    A. The score of player A.
any value from 1 to 6
    B. The greatest score.
From 1 to 6
    C. The earnings of player A if the game rules state that:
    "The player with the greatest score gets a coin from the other player.".
1 coin
    D. The earnings of player A if the game rules state that:
    "The player with the greatest score gets as many coins as the difference between the score of player A and player B.".
1 to 5 coins

Describe the following events:

    Case A: The score of player A is 2.
player A rolled a dice and the outcome was 2...

    Case B: The greatest score is lower or equal than 2.
The winner rolled 2 and the loser 1, or both rolled 1, or both rolled 2.

    Case C: Considering the case where the winner gets as many coins as the difference between scores (D), describe:
        Player A wins at least 4 coins.

Player A:5 Player B:1 or Player A: 6 Player B:2 or Player A:1 Player B:2

        Player A loses more than 2 coins.
Player B won by at least 4
        Player A neither wins nor loses coins.
Both rolled the same score.


Part 3:

CREATE DATABASE lab3;
USE lab3;
SELECT * FROM score;
-- Please find MEAN, SUM, STANDARD DEVIATION, VARIANCE, MIN and MAX.

SELECT AVG(score) AS mean FROM score;
SELECT SUM(score) AS sum FROM score;
SELECT stddev(score) AS stdev FROM score;
SELECT variance(score) AS var FROM score;
SELECT min(score) AS min FROM score;
SELECT max(score) AS max FROM score;
