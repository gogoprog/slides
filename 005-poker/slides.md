# Behind the Screen : Poker game
---
# Behind the Screen : Poker game

## Summary

  * Poker hand matching
  * 7 cards
  * Faking the hands

---
# Behind the Screen : Poker game

## Poker hand matching

### Basics

  * Sort cards per value
  * Count cards per value
    * Will be used for pairs, three and four of a kind
  * Count cards per color
    * For flush
  * Check for flush
  * Check for straight
  * Check for four of a kind
  * Check for full house
  * Check for three of a kind
  * Check for double pair
  * Check for pair

Just follow the order and return the match

---
# Behind the Screen : Poker game

## Poker hand matching

### Ace value issue

First handled as 1

<img style='display:inline-block;' src='images/5_of_clubs.png'/>
<img style='display:inline-block;' src='images/4_of_diamonds.png'/>
<img style='display:inline-block;' src='images/3_of_clubs.png'/>
<img style='display:inline-block;' src='images/2_of_spades.png'/>
<img style='display:inline-block;' src='images/ace_of_hearts.png'/>

Special case for value 14

<img style='display:inline-block;' src='images/king_of_diamonds.png'/>
<img style='display:inline-block;' src='images/queen_of_diamonds.png'/>
<img style='display:inline-block;' src='images/jack_of_hearts.png'/>
<img style='display:inline-block;' src='images/10_of_clubs.png'/>
<img style='display:inline-block;' src='images/ace_of_hearts.png'/>

If 4 consecutive cards from K to 10 and Ace is found followed by Ace then :
Straight has been found.

Then all Aces handled as 14. Ace is always higher in pairs, three of a kind, etc...

This looked fine until... 7 cards!

---
# Behind the Screen : Poker game

## 7 cards

### New issues

<img style='display:inline-block;' src='images/10_of_clubs.png'/>
<img style='display:inline-block;' src='images/9_of_diamonds.png'/>
<img style='display:inline-block;' src='images/8_of_clubs.png'/>
<img style='display:inline-block;' src='images/8_of_spades.png'/>
<img style='display:inline-block;' src='images/7_of_hearts.png'/>
<img style='display:inline-block;' src='images/6_of_hearts.png'/>
<img style='display:inline-block;' src='images/3_of_clubs.png'/>

There is a straight but no 4 consecutive cards.

<img style='display:inline-block;' src='images/king_of_diamonds.png'/>
<img style='display:inline-block;' src='images/queen_of_diamonds.png'/>
<img style='display:inline-block;' src='images/jack_of_hearts.png'/>
<img style='display:inline-block;' src='images/10_of_clubs.png'/>
<img style='display:inline-block;' src='images/9_of_clubs.png'/>
<img style='display:inline-block;' src='images/2_of_hearts.png'/>
<img style='display:inline-block;' src='images/ace_of_hearts.png'/>

5 consecutive cards + Aces that could complete the straight

<img style='display:inline-block;' src='images/7_of_clubs.png'/>
<img style='display:inline-block;' src='images/6_of_clubs.png'/>
<img style='display:inline-block;' src='images/5_of_clubs.png'/>
<img style='display:inline-block;' src='images/4_of_clubs.png'/>
<img style='display:inline-block;' src='images/3_of_hearts.png'/>
<img style='display:inline-block;' src='images/2_of_hearts.png'/>
<img style='display:inline-block;' src='images/2_of_clubs.png'/>

There is a straight but maybe also a flush!

Need something to help...

---
# Behind the Screen : Poker game

## 7 cards

### Tags


---
# Behind the Screen : Poker game

## Faking the hands

Goal : Win X points in Y hands.

Is previous code useless?

No, use random as :

    while(totalPoints != pointsToWin)
    {
        totalPoints = 0;
        cards = getRandomCards();
        totalPoints = findHand(cards).value;
    }
