# Overview

This project is a numpad driven typing test on the FPGA board. The user can to provide input to the typing test through a PmodKYPD numpad attachment. During a test, 4-digit “words” (only numbers will be provided, not letters) are displayed on the Basys3 7-segment display, which is refreshed whenever the user completes a 4-digit word. A real-time accuracy display is also provided during a test and once a test is completed the user can view their final accuracy on the PmodSSD display and their words per minute on the Basys3 7-segment display. The user can to restart the test as many times as they would like and may adjust the number of words in a given test before starting.

## Selection Mode

Before a test begins, the player will be able to input a number on the keyboard, which corresponds to the number of words that they will go through over the course of the game. They can press A to start the game, or B to retype the number.

## Game Mode

As the game begins, random 4-digit numbers will begin appearing on the 7-segment Basys3 display. On the side display, an accuracy score will appear as 00. As the user types digits of the displayed number, the number will disappear on the display to show that they have correctly typed it. When a number doesn’t disappear, that signals that it was mistyped and the accuracy score will drop depending on the number of digits that have already been typed. The game ends when the user types in all of the words that they set in the settings. The goal of the game is to type words as quickly and accurately as possible. After the user successfully types their word, the screen will display the next word. The user can press C at any time to restart the game.

## Score Mode

Following the completion of a single test, the 7-segment display will temporarily be turned off and then the player’s words per minute and final accuracy will be shown on the 7-segment display and the PmodSSD display respectively. The user can then press C to restart the game.

# Building this Project

This project was synthesized utilizing Vivado software on an FPGA board.
