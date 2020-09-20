//
//  ViewController.swift
//  CatchPikachu
//
//  Created by Ali Köse on 20.09.2020.
//  Copyright © 2020 Ali Kose. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var pik1: UIImageView!
    @IBOutlet weak var pik2: UIImageView!
    @IBOutlet weak var pik3: UIImageView!
    @IBOutlet weak var pik4: UIImageView!
    @IBOutlet weak var pik5: UIImageView!
    @IBOutlet weak var pik6: UIImageView!
    @IBOutlet weak var pik7: UIImageView!
    @IBOutlet weak var pik8: UIImageView!
    @IBOutlet weak var pik9: UIImageView!
    
    var score : Int = 0
    
    var highScore : Int = 0
    
    var timer = Timer()
    var counter : Int = 0
    
    var pikachuArray = [UIImageView]()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        let storedScore = UserDefaults.standard.object(forKey: "bestScore")
        if storedScore == nil {
            highScore = 0
            highScoreLabel.text = "High Score:\(highScore)"
        }
        if let newScore = storedScore as? Int{
            // highScore = newScore
             highScoreLabel.text = "High Score : \(newScore) "
        }
        
       
        
        pik1.isUserInteractionEnabled = true
        pik2.isUserInteractionEnabled = true
        pik3.isUserInteractionEnabled = true
        pik4.isUserInteractionEnabled = true
        pik5.isUserInteractionEnabled = true
        pik6.isUserInteractionEnabled = true
        pik7.isUserInteractionEnabled = true
        pik8.isUserInteractionEnabled = true
        pik9.isUserInteractionEnabled = true
        
        let  recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        let  recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ncraseScore))
        
        
        pik1.addGestureRecognizer(recognizer1)
        pik2.addGestureRecognizer(recognizer2)
        pik3.addGestureRecognizer(recognizer3)
        pik4.addGestureRecognizer(recognizer4)
        pik5.addGestureRecognizer(recognizer5)
        pik6.addGestureRecognizer(recognizer6)
        pik7.addGestureRecognizer(recognizer7)
        pik8.addGestureRecognizer(recognizer8)
        pik9.addGestureRecognizer(recognizer9)
        
        
        counter = 10
        timeLabel.text = "Timer: \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        pikachuArray = [pik1,pik2,pik3,pik4,pik5,pik6,pik7,pik8,pik9]
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hidePikachu), userInfo: nil, repeats: true)
        
        
        
        }
    @objc func ncraseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
        
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Timer: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for pikachu in pikachuArray{pikachu.isHidden = true}
            // High score saklama
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "High Score : \(self.highScore) "
                UserDefaults.standard.set(self.highScore, forKey: "bestScore")
            }
            
            makeAlert(titleInput: "Time's Up", MessageInput: " Do you want a play again")
        }
        
        }
    
    
     @objc func hidePikachu(){
        for pikachu in pikachuArray{pikachu.isHidden = true}
        //for pikachu in pikachuArray{pikachu.isHidden = true} / for i in 0...8 {pikachuArray[i].isHidden = true}
        
        let random =  Int ( arc4random_uniform(UInt32(pikachuArray.count - 1)))
        pikachuArray[random].isHidden = false
        }
    
    
    
    func makeAlert(titleInput : String , MessageInput : String) {
    
             let alert = UIAlertController(title: titleInput, message: MessageInput, preferredStyle: UIAlertController.Style.alert)
             let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
             let buttontry = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //karışmasın diye self koymak gerekiyor.
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Timer: \(self.counter)"
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.hidePikachu), userInfo: nil, repeats: true)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
        }
             alert.addAction(button)
             alert.addAction(buttontry)
             self.present(alert,animated: true,completion: nil)    }
    
    
}

