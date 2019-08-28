//
//  ViewController.swift
//  WhoWantsToBeAMillionare
//
//  Created by user on 8/8/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation
class Results: UIViewController
{
    var correctanswer=""
    var selectedanswer=""
    var iscorrect=true
    var questionon=0
    var winner=false
    var backgroundmusic=AVAudioPlayer()
    @IBOutlet weak var AnswerLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        AnswerLabel.isHidden=true
        // Do any additional setup after loading the view.
        var sound=""
        var waittime=0.0
        if(questionon<5)
        {
           waittime=1.0
        }
        else if(questionon<10)
        {
            waittime=3.0
            sound = Bundle.main.path(forResource: "finalanswer2000_32000", ofType:"mp3")!
        }
        else if(questionon<14)
        {
            waittime=5.0
            sound = Bundle.main.path(forResource: "finalanswer64000_500000", ofType:"mp3")!
        }
        else
        {
            waittime=8.0
            sound = Bundle.main.path(forResource: "finalanswer1000000", ofType:"mp3")!
        }
        do
        {
            if(questionon>=5)
            {
                backgroundmusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                backgroundmusic.play()
            }
        }
        catch
        {
            // couldn't load file :(
        }
        let timer = Timer.scheduledTimer(timeInterval: waittime, target: self, selector: #selector(showAnswer), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    @objc func showAnswer()
    {
        AnswerLabel.isHidden=false
        AnswerLabel.text=correctanswer
        if(correctanswer==selectedanswer)
        {
            AnswerLabel.backgroundColor=UIColor.green
            iscorrect=true
        }
        else
        {
            iscorrect=false
            AnswerLabel.backgroundColor=UIColor.red
        }

        var sound=""
        var transitiontime=0.0
        if(iscorrect)
        {
            if(questionon<5)
            {
                transitiontime=2.0
            }
            else if(questionon<10)
            {
                sound = Bundle.main.path(forResource: "correct2000_32000", ofType:"mp3")!
                transitiontime=3.0
            }
            else if(questionon<14)
            {
                sound = Bundle.main.path(forResource: "correct64000_500000", ofType:"mp3")!
                transitiontime=3.0
            }
            else
            {
                sound = Bundle.main.path(forResource: "win", ofType:"mp3")!
                transitiontime=5.0
            }
        }
        else
        {
            if(questionon<5)
            {
                transitiontime=2.0
            }
            else if(questionon<10)
            {
                sound = Bundle.main.path(forResource: "lose2000_32000", ofType:"mp3")!
                transitiontime=3.0
            }
            else if(questionon<14)
            {
                sound = Bundle.main.path(forResource: "lose64000_500000", ofType:"mp3")!
                transitiontime=3.0
            }
            else
            {
                sound = Bundle.main.path(forResource: "lose1000000", ofType:"mp3")!
                transitiontime=5.0
            }
        }
        do
        {
            if(questionon>4)
            {
                backgroundmusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                backgroundmusic.play()
            }
        }
        catch
        {
            // couldn't load file :(
        }
        // Do any additional setup after loading the view.
        let timer = Timer.scheduledTimer(timeInterval: transitiontime, target: self, selector: #selector(handleAnswer), userInfo: nil, repeats: false)
        print("Timer fired!")
    }
    @objc func handleAnswer()
    {
        if(iscorrect&&questionon<14)
        {
            performSegue(withIdentifier: "SegueToQuestion", sender: self)
        }
        else if(iscorrect)
        {
            winner=true
            performSegue(withIdentifier: "SegueToGameOver", sender: self)
        }
        else
        {
            performSegue(withIdentifier: "SegueToGameOver", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(questionon>4)
        {
            backgroundmusic.stop()
        }
        print("prepare triggered")
        if segue.identifier == "SegueToQuestion"
        {
            let controller = segue.destination as! Question
            controller.questionon=questionon+1
        }
        else if segue.identifier=="SegueToGameOver"
        {
            let controller = segue.destination as! GameOver
            controller.questionon=questionon
            controller.winner=winner
        }
    }
}

