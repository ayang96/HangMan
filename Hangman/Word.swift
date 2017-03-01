//
//  Word.swift
//  Hangman
//
//  Created by Alex Yang on 2/28/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class Word {
    let stringToGuess:String
    var progressSoFar:String
    var usedCharacters: Array<Character>
    var wrongGuesses = "Incorrect Guesses:"
    var numWrongGuesses = 0
    var win = 2
    init(input:String) {
        self.stringToGuess = input
        self.progressSoFar = ""
        self.usedCharacters = []
        for c in input.characters{
            if(c == " "){
                self.progressSoFar = self.progressSoFar+" "
            } else {
                self.progressSoFar = self.progressSoFar+"-"

            }
            
        }
    }
    func guess(input:String){
        var index = 0
        var guessflag = 0
        let guess = input.uppercased()[input.startIndex]
        
        //quit early if the letter has been guessed already
        if(usedCharacters.contains(guess)){
            return
        } else {
            usedCharacters.append(guess)
        }
        
        //check if the guess is right and update results
        var characters = Array(progressSoFar.characters)
        for c in stringToGuess.characters{
            if(c == guess){
                guessflag = 1
                characters[index] = guess
            }
            index += 1
        }
        progressSoFar = String(characters)
        
        //if guess is wrong
        if(guessflag == 0){
            wrongGuesses = wrongGuesses+" "+input
            numWrongGuesses += 1
        }
        
        //check win
        if(progressSoFar == stringToGuess){
            win = 1
        }
        //check loss
        if(numWrongGuesses == 6){
            win = 0
        }

        
    }

}
