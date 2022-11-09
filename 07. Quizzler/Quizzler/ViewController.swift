//
//  ViewController.swift
//  Quizzler
//
//  Recreated by Mutlu Calkan on 21/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = true
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[questionNumber]
        questionLabel.text = firstQuestion.questionText
        progressLabel.text = "\(questionNumber + 1) / 13"
        scoreLabel.text = "Score: \(score)"
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            
            pickedAnswer = true
            
        }
        else if sender.tag == 2 {
            
            pickedAnswer = false
        }
        
        checkAnswer()
        questionNumber += 1
        updateUI()
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        
        
    }
    

    func nextQuestion() {
        if questionNumber >= 12 {
            
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { UIAlertAction in
                self.startOver()
            }
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
        else {
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
        }
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            // Correct
            score += 10
        }
        else {
            // Wrong
            score -= 5
        }
    }
    
    
    func startOver() {
        
        questionNumber = 0
        
        nextQuestion()
        
        score = 0
        questionNumber = 0
        
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
       
    }
    

    
}
