//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by mustafa tezcan on 18.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var score = 0
    var highscore = 0
    var timer = Timer()
    var timeCounter = 10
    var sleepTime = 0.5
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //checks the stored value .
        let storedHighcore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighcore == nil {
            highscore = 0
            highscoreLabel.text = ("Highscore: \(highscore)")
        }
        if let newScore = storedHighcore as? Int {
            highscore = newScore
            highscoreLabel.text = ("Highscore: \(highscore)")

        }
        
        //time label
        timeLabel.text = String(timeCounter)
        self.timer = Timer.scheduledTimer(timeInterval: sleepTime, target: self, selector: #selector(self.play), userInfo: nil, repeats: true)
        
    }

    
    //play function , alert , kenny's place , count down , highscore check
    @objc func play(){
        
        //NOTIFICATION FUNCTION ,WORKS WHEN THE GAME IS OVER
        func alert () {
            let alert = UIAlertController(title: "Time's Up", message: "Wanna play again?", preferredStyle: UIAlertController.Style.alert)
            let playButton = UIAlertAction(title: "play", style: UIAlertAction.Style.default ){ (UIAlertAction) in
                self.score = 0
                self.timeCounter = 10
                self.timer = Timer.scheduledTimer(timeInterval: self.sleepTime, target: self, selector: #selector(self.play), userInfo: nil, repeats: true)
                self.scoreLabel.text = "Score: \(self.score)"
            }
            alert.addAction(playButton)
            let cancelButton = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel , handler: nil)
            alert.addAction(cancelButton)
            self.present(alert, animated: true , completion: nil)
           
         
        }
       
  
        //get the size of the screen
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        //generate random number depends on screen size.
        let randX = Int.random(in: 1..<Int(width-80))
        let randY = Int.random(in: 1..<Int(height-100))
        
        //set the place of the button depends on the random number you genrated
        button.frame = CGRect(x: randX, y: randY, width: 93, height: 122)
        
        //count down .
        timeLabel.text = String(timeCounter)
        timeCounter -= 1
        

        //if time is up , give alert , check the score and stop the timer.
        if timeCounter == 0 {
            alert()
            if score > highscore {
                highscore = score
                highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            timer.invalidate()
            timeLabel.font = UIFont.systemFont(ofSize: 20)
            timeLabel.text = "Game's Over"
   
        }
        
   
        
    }
    // kenny is made of button , if you click kenny button will perceive the click and score will increase by one
    
    @IBAction func kennyButton(_ sender: Any) {
        if timeCounter > 0 {
            score+=1
            scoreLabel.text = "Score: \(score)"
        }
    }
    
}

