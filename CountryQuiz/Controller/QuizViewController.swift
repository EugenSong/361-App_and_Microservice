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
    
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
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
    
    
    @IBAction func morePressed(_ sender: Any) {
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
    
    // call Firebase-activate function and update any UI accordingly
    @objc func updateUI () {
        
        activateDatabase()
        
        // get question from Question class
        questionLabel.text = brain.getQuestionText()
        
        // change both numerator and denominator to floats() before performing arithmetic
        progressBar.progress = brain.getProgress()
        scoreLabel.text = "Score: \(brain.getScore() )"
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
    }
    
    
    func activateDatabase () {
        
        // init the Realtime Database reference
        ref = Database.database().reference()
        
        // set values in Realtime Database
        self.ref.child("question").setValue(brain.getQuestionText())
        self.ref.child("keyword").setValue(brain.getQuestionKeyword())
        
        // use FirDatabaseReference.observe() to listen for changes in Realtime Database
        ref.child("image_link").observe(.value) { snapshot in
            
            // cast the DataSnapshot children as objects
            if let snap_child = snapshot.children.allObjects as? [DataSnapshot] {
                print(snap_child[0])
                let img_links = snap_child[0].value as! String
                print(img_links)
                
                // generates image; input: string
                self.generateImage(url: img_links)
            }
            else {
                print("Failed")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ScoreViewController {
            let sv = segue.destination as? ScoreViewController
            
            print(brain.getScore())
            sv!.score = brain.getScore()
            print(sv!.score)
        }
    }
    
    // allows external imgs to be used in images
    func generateImage(url: String) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { /// execute on main thread
                    self.backgroundImage.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    
}

