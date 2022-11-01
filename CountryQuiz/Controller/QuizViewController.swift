//
//  QuizViewController.swift
//  CountryQuiz
//
//  Created by Eugene Song on 10/17/22.
//

import UIKit
import Firebase

class QuizViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // instance of Brain
    var brain = Brain()
    // Brain talks to our 'Model'

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func exitPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
        

    @IBAction func nextPressed(_ sender: Any) {
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle! //true, false
    
        let answ = brain.checkAnswer(userAnswer: userAnswer)
        
        // UI colors are prebuilt colors
        if answ == true {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
            }
        
        if brain.getQuestionNumber() == 6 {
            
            self.performSegue(withIdentifier: "SegueToScoreController", sender: self)
        }

        
        brain.nextQuestion()
        
        // repeats is false b/c we only need it to run once
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI () {
        
        ref = Database.database().reference()
        self.ref.child("question").setValue(brain.getQuestionText())
        self.ref.child("keyword").setValue(brain.getQuestionKeyword())
        
        questionLabel.text = brain.getQuestionText()
        
        // change both numerator and denominator to floats() before performing arithmetic
        progressBar.progress = brain.getProgress()
        scoreLabel.text = "Score: \(brain.getScore() )"
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ScoreViewController {
            let sv = segue.destination as? ScoreViewController
                
            print(brain.getScore())
            sv!.score = brain.getScore()
            print(sv!.score)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
