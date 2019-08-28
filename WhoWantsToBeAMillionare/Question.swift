//
//  Question.swift
//  WhoWantsToBeAMillionare
//
//  Created by user on 8/8/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation

class Question: UIViewController
{
    var questionon=5
    var correctanswer=""
    var selectedanswer=""
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer4: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var MoneyLabel: UILabel!
    var backgroundmusic=AVAudioPlayer()
    
    let moneyamounts=["$100","$200","$300","$500","$1,000","$2,000","$4,000","$8,000","$16,000","$32,000","$64,000","$125,000","$250,000","$500,000","$1,000,000"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    QuestionNumberLabel.text="Question"+String(questionon+1)
        MoneyLabel.text=(moneyamounts[questionon])
        let questionfile="questions"
        let questiontext=getLineFromFile(filename: questionfile, foldername: "MillionareQuestions",linenumber:questionon)
        let answerfile="answers"+String(questionon)
        QuestionLabel.text=questiontext
        for i in 0..<5
        {
            let curanswertext=getLineFromFile(filename: answerfile, foldername: "MillionareQuestions", linenumber: i)
            if(i==0)
            {
                Answer1.setTitle(curanswertext, for: [])
            }
            else if(i==1)
            {
                Answer2.setTitle(curanswertext, for: [])

            }
            else if(i==2)
            {
                Answer3.setTitle(curanswertext, for: [])
            }
            else if(i==3)
            {
                Answer4.setTitle(curanswertext, for: [])
            }
            else
            {
                correctanswer=curanswertext
            }
        }
        var sound=""
        if(questionon<5)
        {
            sound = Bundle.main.path(forResource: "question100_1000", ofType:"mp3")!
        }
        else if(questionon<10)
        {
            sound = Bundle.main.path(forResource: "question2000_32000", ofType:"mp3")!
        }
        else if(questionon<14)
        {
            sound = Bundle.main.path(forResource: "question64000_500000", ofType:"mp3")!
        }
        else
        {
            sound = Bundle.main.path(forResource: "question1000000", ofType:"mp3")!
        }
        do
        {
            backgroundmusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            backgroundmusic.play()
        }
        catch
        {
            // couldn't load file :(
        }
        // Do any additional setup after loading the view.
    }
    func loadOrCreateFile(filename:String,foldername:String)->String
    {
        /*let writtenfilename=filename+".txt"
        let DocumentDirURL=try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:true)
        let fileURL=DocumentDirURL.appendingPathComponent(foldername).appendingPathComponent(filename).appendingPathExtension("txt")
        */
        let filepath = Bundle.main.path(forResource: filename, ofType:"txt")!
        let writtenfilename=filename+".txt"
        do
        {
            let contents = try String(contentsOfFile: filepath)
            print(writtenfilename+" loaded")
            return String(contents)
        }
        catch
        {
            /*
            print("Creating "+writtenfilename)
            let contents:String = ""
            do
            {
                // Write contents to file
                try contents.write(to: fileURL!, atomically: false, encoding: String.Encoding.utf8)
            }
            catch let error as NSError
            {
                print("Ooops! Something went wrong: \(error)")
            }
            */
            return ""
        }
    }
    func getLineFromFile(filename:String,foldername:String,linenumber:Int)->String
    {
        /*let writtenfilename=filename+".txt"
        let DocumentDirURL=try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create:true)
        let fileURL=DocumentDirURL.appendingPathComponent(foldername).appendingPathComponent(filename).appendingPathExtension("txt")*/
        
        let filepath = Bundle.main.path(forResource: filename, ofType:"txt")!
        let writtenfilename=filename+".txt"
        do
        {
            let contents = try String(contentsOfFile: filepath)
            let lines = contents.components(separatedBy: .newlines)
            print(writtenfilename+" loaded")
            return String(lines[linenumber])
        }
        catch
        {
            /*print("Creating "+writtenfilename)
            let contents:String = ""
            do
            {
                // Write contents to file
                try contents.write(to: fileURL!, atomically: false, encoding: String.Encoding.utf8)
            }
            catch let error as NSError
            {
                print("Ooops! Something went wrong: \(error)")
            }*/
            return ""
        }
    }
    
    @IBAction func SubmitAnswer(_ sender: UIButton)
    {
        backgroundmusic.stop()
        selectedanswer=sender.title(for: [])!
        performSegue(withIdentifier: "SegueToResults", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("prepare triggered")
        if segue.identifier == "SegueToResults"
        {
            let controller = segue.destination as! Results
            controller.correctanswer=correctanswer
            controller.selectedanswer=selectedanswer
            controller.questionon=questionon
        }
    }
}
