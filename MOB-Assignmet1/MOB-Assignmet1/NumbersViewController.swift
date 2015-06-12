//
//  NumbersViewController.swift
//  MOB-Assignmet1
//
//  Created by MT1701 on 12/6/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import UIKit

class NumbersViewController: UIViewController {
    
    @IBOutlet weak var NumbersLab: UILabel!
    @IBOutlet weak var NumbersCheckLab: UILabel!
    @IBOutlet weak var NumbersLab2: UILabel!
    @IBOutlet weak var NumbersTextField: UITextField!
    
    var Number: Int!
    var AddNumber: Int = 0
    var CheckNumber: Int!
    
    
    @IBAction func NumbersCheckBut(sender: AnyObject) {
        Number = NumbersTextField.text.toInt()
        CheckNumber = Number%2
        println(CheckNumber)
        if (CheckNumber == 0) {
            Labeling()
            NumbersCheckLab.text = "Even"
        }
        else {
            Labeling()
            NumbersCheckLab.text = "Not Even"
        }
    }
    
    func Labeling (){
        AddNumber = AddNumber + Number
        NumbersLab2.text = String(Number)
        NumbersLab.text = String(AddNumber)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NumbersLab2.text = "Value to be add"
        NumbersLab.text = "Cumulative Value"
        NumbersCheckLab.text = "Check if Value is Even"
        NumbersLab.lineBreakMode = .ByWordWrapping
        NumbersLab.numberOfLines = 2
        NumbersCheckLab.lineBreakMode = .ByWordWrapping
        NumbersCheckLab.numberOfLines = 2
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
