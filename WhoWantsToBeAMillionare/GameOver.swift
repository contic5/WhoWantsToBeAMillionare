//
//  GameOver.swift
//  WhoWantsToBeAMillionare
//
//  Created by user on 8/12/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import AVFoundation
internal class GameOver : UIViewController
{
    var questionon=0
    var winner=false
    let moneyamounts=["$100","$200","$300","$500","$1,000","$2,000","$4,000","$8,000","$16,000","$32,000","$64,000","$125,000","$250,000","$500,000","$1,000,000"]
    @IBOutlet weak var MoneyLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        MoneyLabel.text=(moneyamounts[questionon])
    }
    @IBAction func SelectPlayAgain(_ sender: UIButton)
    {
         performSegue(withIdentifier: "PlayAgainSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("prepare triggered")
        if segue.identifier == "PlayAgainSegue"
        {
            let controller = segue.destination as! Question
            controller.questionon=0
        }
    }
}
