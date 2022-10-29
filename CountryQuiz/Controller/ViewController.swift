//
//  ViewController.swift
//  CountryQuiz
//
//  Created by Eugene Song on 10/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var showStatsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.

            
            // code to round buttons
            startButton.layer.cornerRadius = 25
            startButton.clipsToBounds = true
            
            showStatsButton.layer.cornerRadius = 25
            showStatsButton.clipsToBounds = true
            
            settingsButton.layer.cornerRadius = 25
            settingsButton.clipsToBounds = true
            
            
            
        }
        
        @IBAction func startButtonPressed(_ sender: Any) {
            guard let start = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController else {
                return }
            
            self.navigationController?.pushViewController(start, animated: true)
        }
        
        @IBAction func showStatsButtonPressed(_ sender: Any) {
        }
        
        @IBAction func settingsButtonPressed(_ sender: Any) {
            guard let start = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
                return }
            
            self.navigationController?.pushViewController(start, animated: true)
            
            
        }
        
        
        
    }
    
