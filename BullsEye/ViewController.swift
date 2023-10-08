//
//  ViewController.swift
//  BullsEye
//
//  Created by sepehr hajimohammadi on 12/21/22.
//

import UIKit

class ViewController: UIViewController {

    
    var currentValue: Float = 0.0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let roundedValue = slider.value.rounded()
        currentValue = roundedValue
        stratNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert()  {
        
        let difference = abs(Int(currentValue) - targetValue)
        var points = 100 - difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }
        else if difference < 5 {
            title = "You almost had it!"
        
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let massage = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default,  handler: {
            action in
            self.stratNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = roundedValue
        print(currentValue)
    }
    
    func stratNewRound() {
        
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = currentValue
        updateLabels()
    }
    
    func updateLabels() {
        
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
   @IBAction func stratNewGame() {
        score = 0
        round = 0
        stratNewRound()
    }
}


