//
//  ViewController.swift
//  MOB-Assignmet1
//
//  Created by MT1701 on 12/6/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UserLab: UILabel!
    @IBOutlet weak var AgeLab: UILabel!
    @IBOutlet weak var CheckBut: UIButton!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var AgeTextField: UITextField!
    @IBOutlet weak var HelloLab: UILabel!
    @IBOutlet weak var SexSegOut: UISegmentedControl!
   
    var CheckAge: Int!
    var CheckSex: Int!
    var AgeMarker: String!
    var SexMarker: String!
    
    @IBAction func HelloButAct(sender: AnyObject) {
        HelloLab.text = "Hello World"
    }
    @IBAction func ChecButClick(sender: AnyObject) {
    }
    
    
    @IBAction func SexSegControl(sender: AnyObject) {
        switch SexSegOut.selectedSegmentIndex {
            case 0:
                CheckSex = 0
            case 1:
                CheckSex = 1
        default:
            break;
            
        }
        
    }
    
    func CheckFunction (){
//        let SexCheckString = CheckSex
        var CheckAge = AgeTextField.text.toInt()
        if CheckSex == 0 {
            if CheckAge < 16 {
                AgeMarker = "You are under Age"
                SexMarker = "You better be careful where you stick that thing"
            }
            else if CheckAge < 18 {
                AgeMarker = "You can drive"
                SexMarker = "Be careful some parts of the world still has issues"
            }
            else if CheckAge < 21 {
                AgeMarker = "You can vote and drive"
                SexMarker = "You are go to go in most parts of the world"
            }
            else if CheckAge >= 21 {
                AgeMarker = "You can drink, drive and vote. But not all at once"
                SexMarker = "You are good to go matie, just be careful in the middle east"
            }
        }
        else {
            if CheckAge < 16 {
                AgeMarker = "You are under Age"
                SexMarker = "You need keep your boyfriend's one eye snake in them pants"
            }
            else if CheckAge < 18 {
                AgeMarker = "You can drive"
                SexMarker = "Be careful your boyfriend can still be charged"
            }
            else if CheckAge < 21 {
                AgeMarker = "You can vote and drive"
                SexMarker = "Have fun! Though your man still may not know what he is doing"
            }
            else if CheckAge >= 21 {
                AgeMarker = "You can drink, drive and vote. But not all at once"
                SexMarker = "Nothing really more to say, pick wisely though!"
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "CheckSegue"){
            var Destination =  segue.destinationViewController as! AgeCheckViewController
            Destination.PassName = NameTextField.text
            Destination.PassAge = AgeTextField.text
            CheckFunction()
            Destination.PassCheckAge = AgeMarker
            Destination.PassComment = SexMarker
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserLab.text = "Username"
        AgeLab.text = "Age"
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }


}

