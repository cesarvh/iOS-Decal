
//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    var game:Hangman!
    var gameOver = false
    var count = 1
    var won = false
    var wordLen = 0
    var dynamicWordLen = 0
    
    @IBOutlet weak var knownLettersBox: UILabel!

    @IBOutlet weak var varvar: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lettersGuessedField: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    
    // Is the "make a guess" key pressed?
    @IBAction func makeGuessedPressed(sender: AnyObject) {
        let guess = guessTextField.text
        var validLetter = false
        
        if (guess?.characters.count > 1) {
            popNotify("Invalid", m: "Please Enter 1 Character at a time", e: "Understood")
            return
        }
        
        if (guess == nil) {
            popNotify("Invalid", m: "Please enter a character!", e: "Sorry :(")
            return
        }
        
        if (guess < "A" || guess > "Z") {
            if ( guess != " ") {
                popNotify("Invalid", m: "This is not a valid character", e: "Ok")
                return
            }

        }
        
        if game.guesses().rangeOfString(guess!) != nil {
            popNotify("Woah there", m: "You already guessed this!", e: "ok")
            return
        }
        
        
        validLetter = game.guessLetter(guess!)
        
        // if the letter is not correct, then
        if (validLetter == false) {
            count += 1
            image.image = UIImage(named: "hangman\(count).gif")
            lettersGuessedField.text = lettersGuessedField.text! + guess!
        }
        
        if (validLetter) {
            dynamicWordLen -= 1
            knownLettersBox.text = game.knownString
            
        }
        
        won = wonGame()
        gameOver = isGameOver()
        
        if (gameOver == true) {
            popNotify("Game Over", m: "Sorry, you lost...", e: "Start New Game")
            startNewGame(varvar)
            return
        } else if (won == true) {
            popNotify("Congrats!", m: "You Won!", e: "Start Another Game")
            startNewGame(varvar)
            return
        }
        guessTextField.text = ""
    }
    
    
    // Sends a notification informing if the game was won or lost
    func popNotify(t:String, m:String, e:String) -> Void {
        let lostAlert = UIAlertController(title: "\(t)", message:
            "\(m)", preferredStyle: UIAlertControllerStyle.Alert)
        lostAlert.addAction(UIAlertAction(title: "\(e)", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(lostAlert, animated: true, completion: nil)
        
    }
    

    func wonGame() -> Bool {
        let ans = game.knownString
        if (ans?.characters.contains("_") == false) {
            return true
        }
        return false
        
    }
    
    func isGameOver() -> Bool {
        return count == 7
    }
    
    
    @IBAction func startNewGame(sender: AnyObject) {
        game = Hangman()
        gameOver = false
        won = false
        count = 1
        image.image = UIImage(named: "hangman\(count).gif")
        lettersGuessedField.text = ""
        knownLettersBox.text = ""
        game.start()
        wordLen = (game.answer?.characters.count)!
        dynamicWordLen = wordLen
        popNotify("Attention: ", m: "The phrase you must guess is \(wordLen) letters", e: "Got it!")
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame(varvar)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

