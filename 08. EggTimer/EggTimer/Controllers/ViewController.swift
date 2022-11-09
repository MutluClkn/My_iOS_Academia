//
//  ViewController.swift
//  EggTimer
//
//  Recreated by Mutlu Çalkan on 28/02/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var counter = 0
    var timer = Timer()
    var progressCounter: Float = 0.0
    var alarm: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            doneLabel.text = "\(counter) seconds left."
            counter -= 1
            progressBar.progress += progressCounter

        }else if counter == 0 {
            timer.invalidate()
            doneLabel.text = "Done!"
            playAlarm()
        }
    }
    
    let eggsCookingSeconds = ["Soft" : 3, "Medium" : 420, "Hard" : 720]

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0.0
        counter = eggsCookingSeconds[sender.currentTitle!]!
        progressCounter = 1.0 / Float(counter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }

    func playAlarm() {
            
            let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                    
                    do {
                        alarm = try AVAudioPlayer(contentsOf: soundURL!)
                    }catch{
                        print(error)
                    }
                    alarm.play()
            
        }
    

}
