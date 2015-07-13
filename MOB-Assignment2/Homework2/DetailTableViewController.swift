//
//  DetailTableViewController.swift
//  Homework2
//
//  Created by MT1701 on 9/7/15.
//  Copyright (c) 2015 Kannan Chandrasegaran. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var student:Student = Student()
    
    @IBOutlet weak var LastNameLab: UILabel!
    @IBOutlet weak var FirstNameLab: UILabel!
    @IBOutlet weak var AgeLab: UILabel!
    @IBOutlet weak var Score1: UILabel!
    @IBOutlet weak var Score2: UILabel!
    @IBOutlet weak var Score3: UILabel!
    @IBOutlet weak var Score4: UILabel!
    @IBOutlet weak var Contact: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    
    var ContactVal:Int!
    var URLCheck: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        LastNameLab.text = self.student.lastName
        FirstNameLab.text = self.student.firstName
        AgeLab.text = String(self.student.age)
        Score1.text = String(self.student.scores[0])
        Score2.text = String(self.student.scores[1])
        Score3.text = String(self.student.scores[2])
        Score4.text = String(self.student.scores[3])
        CheckContact()
        DisplayPic()
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func checkscore() {
//        var score[] = self.student.scores
//        for n in 0.. {
//            
//        }
//    }
    
    func CheckContact() {
        if let ContactVal = self.student.phoneNumber {
            Contact.text = String(ContactVal)
        } else {
            Contact.text = "No Contact Available"
        }
    }
    
    func DisplayPic() {
        let URLCheck = self.student.profilePicURL
        let URL = NSURL(string: URLCheck)
        let data = NSData(contentsOfURL: URL!)
        ProfilePic.image = UIImage(data: data!)
        
    }
    
    
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 4
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
