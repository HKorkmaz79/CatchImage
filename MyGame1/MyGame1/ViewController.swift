//
//  ViewController.swift
//  MyGame1
//
//  Created by Hakan Korkmaz on 26.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeleftLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
   
    var x = 0
    var y = 0
    var skor = 0
    let imageView = UIImageView(image: UIImage(named: "hulder"))
    var timer = 10
    var timer1 = Timer()
    var timer2 = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = false
        
    }

    @IBAction func startClicked(_ sender: Any) {
        skor = 0
        timer = 10
        scoreLabel.text = "Skor:"
        timer1 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(rasgeleGoster), userInfo: nil, repeats: true)
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLeft), userInfo: nil, repeats: true)
        let imageCatched = UITapGestureRecognizer(target: self, action: #selector(getScore))
        imageView.addGestureRecognizer(imageCatched)
        imageView.isUserInteractionEnabled = true
    }
    @IBAction func yerDegistir(_ sender: Any) {
        
    }
    
    @objc func rasgeleGoster(){
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        x = Int.random(in: 0...Int(screenWidth - 100))
        y = Int.random(in: 0...Int(screenHeight - 200))
        
        imageView.frame = CGRect(x: x, y: y, width: 200, height: 200)
   
        self.view.addSubview(imageView)
    }
    @objc func getScore() {
        skor += 1
        scoreLabel.text = "Skor \(skor)"
    }
    @objc func timeLeft() {
        timeleftLabel.text = "Kalan süre \(timer)"
        if timer == 0 {
            //timeleftLabel.text = "Süre doldu!"
            let alert = UIAlertController(title: "Uyarı", message: "Zaman doldu!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true)
            timer2.invalidate()
            timer1.invalidate()
            imageView.isUserInteractionEnabled = false
            UserDefaults.standard.set(skor, forKey: "highscore")
        }
        timer -= 1
    }
    
}

