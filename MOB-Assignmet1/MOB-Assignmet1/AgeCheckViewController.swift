//
//  AgeCheckViewController.swift
//  MOB-Assignmet1
//
//  Created by MT1701 on 12/6/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import UIKit

class AgeCheckViewController: UIViewController {
    
    @IBOutlet weak var CheckLab: UILabel!
    @IBOutlet weak var CheckLab2: UILabel!
    @IBOutlet weak var CheckLab3: UILabel!
    
    
    var PassName: String!
    var PassAge: String!
    var PassCheckAge: String!
    var PassComment: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CheckLab.text = "Hello " + PassName + ", you are " + PassAge + " years old"
        CheckLab2.text = PassCheckAge
        CheckLab3.text = PassComment
        CheckLab3.lineBreakMode = .ByWordWrapping
        CheckLab3.numberOfLines = 2
        
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
