//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var hangmanPhrases: HangmanPhrases?
    var word: Word?
    var phrase: String?
    @IBOutlet weak var StringToGuess: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        
    }
    
    //start fresh
    func reload(){
        hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        phrase = hangmanPhrases!.getRandomPhrase()
        word = Word(input: phrase!)
        StringToGuess.text = word!.progressSoFar
        IncorrectGuesses.text = "Incorrect Guesses:"
        hangManImage.image = #imageLiteral(resourceName: "hangman1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBOutlet weak var IncorrectGuesses: UILabel!

    @IBOutlet weak var Input: UITextField!
    
    @IBAction func EditingChanged(_ sender: UITextField) {
        if(Input.text!.characters.count>1){
            let i = Input.text!.index(Input.text!.startIndex, offsetBy: 1)
            Input.text = String(Input.text![i])
        }
        Input.text = Input.text!.uppercased()

        
    }
    @IBOutlet weak var hangManImage: UIImageView!
    @IBAction func Guess(_ sender: UIButton) {
        
        //call guess function
        if(Input.text!.characters.count == 1){
            word!.guess(input: Input.text!)
        }
        
        //update UIlabels and clear input
        IncorrectGuesses.text = word!.wrongGuesses
        StringToGuess.text = word!.progressSoFar
        Input.text = ""
        
        //update image
        if(word!.numWrongGuesses == 1){
            hangManImage.image = #imageLiteral(resourceName: "hangman2")
        } else  if(word!.numWrongGuesses == 2){
            hangManImage.image = #imageLiteral(resourceName: "hangman3")
        } else  if(word!.numWrongGuesses == 3){
            hangManImage.image = #imageLiteral(resourceName: "hangman4")
        } else  if(word!.numWrongGuesses == 4){
            hangManImage.image = #imageLiteral(resourceName: "hangman5")
        } else  if(word!.numWrongGuesses == 5){
            hangManImage.image = #imageLiteral(resourceName: "hangman6")
        } else  if(word!.numWrongGuesses == 6){
            hangManImage.image = #imageLiteral(resourceName: "hangman7")
        }
        
        //check win
        if(word!.win==1){
            win()
        }
        if(word!.win == 0){
            lose()
        }
    }
    
    func lose(){
        let alert = UIAlertController(title: "You Lost!", message: "Try Again? You have no choice.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler:  { action in
            self.reload()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func win(){
        let alert = UIAlertController(title: "You Won!", message: "Try Again? You have no choice.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.default, handler: { action in
            self.reload()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
