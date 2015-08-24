//
//  ViewController.swift
//  UICollectiontest
//
//  Created by MT1701 on 7/8/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    var query1loaded = false
    var query2loaded = false
    
    var active = UIActivityIndicatorView()
    
    //master data arrays
    var booking = [BookingObject]()
    var reference = [Reference]()
    var tables = [Table]()
    
    var addView = UIView()
    
    var status = ["pending","accepted","expired","seated"]
    
    var dataPrimeSetRef = []
    var dataPrimeLot = [[Any]]()
    
    var secondDataSetRef = [Reference]()
    var secondDataLot = [Any]()
    
    //replace with [Any] prior to testing 4D array
    var thirdDataLot = [Reference]()
    var noData:Bool!
    var dragged:Bool!
    var tempdrag: Int!
    
    var forthDataLot = [Reference]()
    var tempData = [Reference]()
    var tempDateTime = [NSDate]()
    
    
    var addLabel = UILabel()
    var addDate = UITextField()
    var addTime = UITextField()
    var addUser = UITextField()
    var addNumOfP = UITextField()
    var addTable = UITextField()
    var addBut = UIButton()
    var canBut = UIButton()
    
//    var data = Data()
    
//    var dictionary = dictionary<String, Any>()
    
    @IBOutlet weak var MainCollectionView: UICollectionView!
    
    @IBOutlet weak var ChooseCollectionView: UICollectionView!
    
    @IBOutlet weak var ListingTableView: UITableView!
    
    
    var MenuData = ["Pending","Accepted","Rejected","Tables"]
    
    var PendingData = ["123", "1234", "12345","123456"]
    var AcceptData = ["234","2345","23456"]
    var RejectedData = ["345","3456","34567","345678","3456789"]
    var TableNumber = ["1","2","3","4"]
    
    var TestTableData = ["Booking1","Booking2","Booking3"]
    var TestTableData2 = ["Booking4","Booking5","Booking6"]
    var TestTableData3 = ["Booking7","Booking8","Booking9"]
    var TestTableData4 = ["Booking10","Booking11"]
    
    var collectionViews = [UICollectionView]()
    var tableViews = [UITableView]()
    var SecondDataSet = [[]] // Forcing this to be an mutable array
    
    var tableDataSet = [[]]
    
    var testDataSet = []
    var testDataSet2 = []
    
//    var dataArray:[[String]] = [MenuData, PendingData]
   
    
    let tap = UITapGestureRecognizer()
    let drag = UIPanGestureRecognizer()
    let makeDrag = UILongPressGestureRecognizer()
    
    var selectedMainCell: Int! = 0
    var selectedMainCellPrior: Int!
    var selectedChooseCell: Int! = 0
    var selectedChooseCellPrior: Int!
    
    //drag and drop variables
    var Listing1SelectedCell: NSIndexPath?
    var Listing2SelectedCell: NSIndexPath?
    var dragData: AnyObject?
    var dragView = UIView()
    var dragViewImage = UIImage()
    
    
    var beginRect:UIView!
    
    var endRect:UIView!
    
    
    //number of section for conllection and table view
    
    
    
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        println("Selected");
//    }
    
//    func collectionView(collectionView: UICollectionView,
//        shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//            return true
//    }
    
    
    
    func tap(gesture: UITapGestureRecognizer){
        var point:CGPoint = gesture.locationInView(self.view)
        var pointInCollection:CGPoint = self.view.convertPoint(point, toView: MainCollectionView)
        var pointInChoose:CGPoint = self.view.convertPoint(point, toView: ChooseCollectionView)
//        println(point)
        
//        selectedChooseCellPrior = selectedChooseCell
        if CGRectContainsPoint(MainCollectionView.bounds, pointInCollection) {
//            selectedMainCellPrior = selectedMainCell
            if let path = MainCollectionView.indexPathForItemAtPoint(pointInCollection) {
//                println(path)
//                println(path.row)
                if path.row != selectedMainCell {
                    selectedMainCellPrior = selectedMainCell
                    println(selectedMainCellPrior)
                }
//                println(selectedMainCellPrior)
                selectedMainCell = path.row
                if selectedMainCell == 0 || selectedMainCell == 1 || selectedMainCell == 2 {
                    selectedChooseCell = 0
                    ChooseCollectionView.reloadData()
                    ListingTableView.reloadData()
                } else {
                    ChooseCollectionView.reloadData()
                }
//                println(selectedMainCell)
            } else {
                println("not called")
            }
            
        } else
        if CGRectContainsPoint(ChooseCollectionView.bounds, pointInChoose){
            if let path = ChooseCollectionView.indexPathForItemAtPoint(pointInChoose) {
//                println(path)
//                if path.row == selectedChooseCell {
//                    println("same cell")
//                } else {
//                    selectedChooseCellPrior = selectedChooseCell
//                    println(selectedChooseCellPrior)
//                }
                if selectedMainCell == 1 || selectedMainCell == 3 {
                    if selectedMainCell == 1 {
                        if path.row == dataPrimeLot[selectedMainCell].count {
                            
                            println("add pressed")
                            
                            self.addLabel.frame = CGRect(x: addLabel.frame.width, y: 0, width: addView.bounds.width/2, height: (addView.bounds.height/4 - 4))
                            
                            self.addDate.frame = CGRect(
                                x: 0,
                                y: 0,
                                width: (addView.bounds.width/2 - 4),
                                height: (addView.bounds.height/4 - 4))
                            self.addTime.frame = CGRect(
                                x: 0,
                                y: 0,
                                width: (addView.bounds.width/2 - 4),
                                height: (addView.bounds.height/4 - 4))
                            self.addUser.frame = CGRect(
                                x: 0,
                                y: 0,
                                width: (addView.bounds.width/2 - 4),
                                height: (addView.bounds.height/4 - 4))
                            self.addNumOfP.frame = CGRect(
                                x: 0,
                                y: 0,
                                width: (addView.bounds.width/2 - 4),
                                height: (addView.bounds.height/4 - 4))
                            
                            
                            addBut = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                            addBut.frame = CGRect(
                                x: 0,
                                y: 0,
                                width: (addView.bounds.width/2 - 4),
                                height: (addView.bounds.height/4 - 4))
                            addBut.backgroundColor = UIColor.blueColor()
                            addBut.setTitle("Add", forState: UIControlState.Normal)
                            addBut.addTarget(self, action: "add:", forControlEvents: UIControlEvents.TouchUpInside)
                            
                            canBut = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                            canBut.frame = CGRect(
                                x: 0,
                                y: 0,
                                width: (addView.bounds.width/2 - 4),
                                height: (addView.bounds.height/4 - 4))
                            canBut.backgroundColor = UIColor.blueColor()
                            canBut.setTitle("Add", forState: UIControlState.Normal)
                            canBut.addTarget(self, action: "can:", forControlEvents: UIControlEvents.TouchUpInside)
                            
                            self.addLabel.center = CGPoint(x: self.addView.bounds.midX, y: (self.addView.bounds.maxY/4 - self.addView.bounds.maxY/8))
                            
                            self.addDate.center = CGPoint(
                                //            CGPoint(x: self.addView.bounds.midX, y: (self.addView.bounds.maxY/4 - self.addView.bounds.maxY/8))
                                //            CGPoint(x: addView.center.x, y: addView.center.y)
                                x: self.addView.bounds.maxX/4,
                                y: ((self.addView.bounds.maxY/4 * 2) - self.addView.bounds.maxY/8))
                            self.addTime.center = CGPoint(
                                x: (self.addView.bounds.maxX/4 * 3),
                                y: ((self.addView.bounds.maxY/4 * 2) - self.addView.bounds.maxY/8))
                            
                            self.addUser.center = CGPoint(
                                x: self.addView.bounds.maxX/4,
                                y: ((self.addView.bounds.maxY/4 * 3) - self.addView.bounds.maxY/8))
                            self.addNumOfP.center = CGPoint(
                                x: (self.addView.bounds.maxX/4 * 3),
                                y: ((self.addView.bounds.maxY/4 * 3) - self.addView.bounds.maxY/8))
                            
                            self.addBut.center = CGPoint(
                                x: self.addView.bounds.maxX/4,
                                y: ((self.addView.bounds.maxY) - self.addView.bounds.maxY/8))
                            self.canBut.center = CGPoint(
                                x: self.addView.bounds.maxX/4 * 3,
                                y: ((self.addView.bounds.maxY) - self.addView.bounds.maxY/8))
                            
                            addLabel.text = "Add Booking"
                            addLabel.textAlignment = NSTextAlignment.Center
                            
                            addDate.backgroundColor = UIColor.whiteColor()
                            addDate.placeholder = "Add Date: YYYY-MM-DD"
                            
                            addTime.backgroundColor = UIColor.whiteColor()
                            addTime.placeholder = "Add Date: HH-mm-ss"
                            
                            addUser.backgroundColor = UIColor.whiteColor()
                            addUser.placeholder = "Add UserName"
                            
                            addNumOfP.backgroundColor = UIColor.whiteColor()
                            addNumOfP.placeholder = "Add Number of People"
                            
                            self.addView.addSubview(addLabel)
                            self.addView.addSubview(addDate)
                            self.addView.addSubview(addTime)
                            self.addView.addSubview(addUser)
                            self.addView.addSubview(addNumOfP)
                            self.addView.addSubview(addBut)
                            self.addView.addSubview(canBut)
                            
                            
                            view.bringSubviewToFront(addView)
                            addView.hidden = false
                            
                        } else {
                            selectedChooseCell = path.row
                            ListingTableView.reloadData()
                        }

                    } else {
                        
                        println("table add")
                        self.addLabel.frame = CGRect(x: addLabel.frame.width, y: 0, width: addView.bounds.width/2, height: (addView.bounds.height/4 - 4))
                        
                        self.addTable.frame = CGRect(
                            x: 0,
                            y: 0,
                            width: (addView.bounds.width/2 ),
                            height: (addView.bounds.height/4))
                        
                        self.addLabel.center = CGPoint(x: self.addView.bounds.midX, y: (self.addView.bounds.maxY/4 - self.addView.bounds.maxY/8))
                        
                        self.addTable.center = CGPoint(
                            x: addView.bounds.midX,
                            y: addView.bounds.midY)
                        
                        
                        addBut = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                        addBut.frame = CGRect(
                            x: 0,
                            y: 0,
                            width: (addView.bounds.width/2 - 4),
                            height: (addView.bounds.height/4 - 4))
                        addBut.backgroundColor = UIColor.blueColor()
                        addBut.setTitle("Add", forState: UIControlState.Normal)
                        addBut.addTarget(self, action: "add:", forControlEvents: UIControlEvents.TouchUpInside)
                        
                        canBut = UIButton.buttonWithType(UIButtonType.System) as! UIButton
                        canBut.frame = CGRect(
                            x: 0,
                            y: 0,
                            width: (addView.bounds.width/2 - 4),
                            height: (addView.bounds.height/4 - 4))
                        canBut.backgroundColor = UIColor.blueColor()
                        canBut.setTitle("Add", forState: UIControlState.Normal)
                        canBut.addTarget(self, action: "can:", forControlEvents: UIControlEvents.TouchUpInside)
                        
                        self.addBut.center = CGPoint(
                            x: self.addView.bounds.maxX/4,
                            y: ((self.addView.bounds.maxY) - self.addView.bounds.maxY/8))
                        self.canBut.center = CGPoint(
                            x: self.addView.bounds.maxX/4 * 3,
                            y: ((self.addView.bounds.maxY) - self.addView.bounds.maxY/8))
                        
                        addLabel.text = "Add Booking"
                        addLabel.textAlignment = NSTextAlignment.Center
                        
                        addTable.backgroundColor = UIColor.whiteColor()
                        addTable.placeholder = "Add Table Number"
                        
                        self.addView.addSubview(addLabel)
                        self.addView.addSubview(addTable)
                        self.addView.addSubview(addBut)
                        self.addView.addSubview(canBut)
                        
                        view.bringSubviewToFront(addView)
                        addView.hidden = false
                    }
                } else {
                    selectedChooseCell = path.row
                    ListingTableView.reloadData()
                }
                
                
//                println(selectedChooseCell)
//                println(selectedChooseCell)
                
            } else {
                println("does not contain")
            }
            
        }
    }
    
    func makeDrag(gesture:UILongPressGestureRecognizer){
        var point:CGPoint = gesture.locationInView(self.view)
        var pointInList = gesture.view?.convertPoint(point, toView: ListingTableView)
        var pointInMain = gesture.view?.convertPoint(point, toView: MainCollectionView)
        var pointInChoose = gesture.view?.convertPoint(point, toView: ChooseCollectionView)
//        println(point)
        if gesture.state == .Began {
            if CGRectContainsPoint(ListingTableView.bounds, pointInList!) {
                beginRect = ListingTableView
//                let localPoint = gesture.view?.convertPoint(point, toView: beginRect)
                Listing1SelectedCell = ListingTableView.indexPathForRowAtPoint(pointInList!)
                let row = Listing1SelectedCell!.row
                if let cell = ListingTableView.cellForRowAtIndexPath(Listing1SelectedCell!) { //as? TableViewCell {
//                println(row)
                    println("long press")
                    println(cell)
                    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, false, 0.0)
                    cell.layer.renderInContext(UIGraphicsGetCurrentContext())
                    dragViewImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    
                    //UIView view setting size/CGRect first prior to positioning
                    dragView.frame.size = cell.frame.size
                    dragView.backgroundColor = UIColor(patternImage: dragViewImage)
                    let cellcenter = gesture.view?.convertPoint(cell.center, fromView: ListingTableView)
                    dragView.center = cellcenter!
                    println(dragView.center)
                    dragView.alpha = 1
                    dragView.hidden = false
                    dragData = cell.textLabel?.text
                    println(dragData)
//                    dragData = 
//                    dragView.addGestureRecognizer(drag)
                    self.view.addSubview(dragView)
                    self.view.bringSubviewToFront(dragView)
                    
                    UIView.animateWithDuration(0.1, animations: {
                        self.dragView.frame.size = CGSizeMake(40, 40)
                        self.dragView.center = point
                        self.dragView.layer.cornerRadius = self.dragView.frame.width/2
                    }, completion: { finished in
//                        self.view.addGestureRecognizer(self.drag)
                    })
                }
                
            } else if CGRectContainsPoint(MainCollectionView.bounds, pointInMain!) {
                println("I am Collection View 1")
            } else if CGRectContainsPoint(ChooseCollectionView.bounds, pointInChoose!){
                println("I am Collection View 2")
            }
        } else if gesture.state == .Changed {
            
            
            
            
            var center = dragView.center
            center = point
            dragView.center = center
            if beginRect != nil && beginRect == ListingTableView {
            if CGRectContainsPoint(MainCollectionView.bounds, pointInMain!) {
                if beginRect == ListingTableView {
                    if let path = MainCollectionView.indexPathForItemAtPoint(pointInMain!) {
                        if let item = MainCollectionView.cellForItemAtIndexPath(path) {
                            if path.item == selectedMainCell {
                                dragView.backgroundColor = UIColor.yellowColor()
                            } else
                            if path.item == 3 {
                                dragView.backgroundColor = UIColor.redColor()
                            } else {
                                dragView.backgroundColor = UIColor.greenColor()
                            }
                        }
                    }
                }
            } else if CGRectContainsPoint(ChooseCollectionView.bounds, pointInChoose!) {
                if beginRect == ListingTableView {
                    if let path = MainCollectionView.indexPathForItemAtPoint(pointInChoose!) {
                        if let item = MainCollectionView.cellForItemAtIndexPath(path) {
                            if selectedMainCell == 3 && path.item != 0 {
                                dragView.backgroundColor = UIColor.greenColor()
                            } else {
                                dragView.backgroundColor = UIColor.redColor()
                            }
                        }
                    }
                }
            } else {
                dragView.backgroundColor = UIColor.whiteColor()
            }
            }
            
//            else if CGRectContainsPoint(ChooseCollectionView.bounds, pointInChoose!) {
//                if beginRect == ListingTableView {
//                    if let path = ChooseCollectionView.indexPathForItemAtPoint(pointInMain!) {
//                        if let item = ChooseCollectionView.cellForItemAtIndexPath(path) {
//                            if selectedMainCell == 3 {
//                                if item == 0 || item == 1 || item == 2 {
//                                    dragView.backgroundColor = UIColor.greenColor()
//                                }
//                            }
//                        }
//                    }
//                }
//            }
            
            
            
            
            
        } else if gesture.state == .Ended {
            dragView.hidden = true
//            endRect =
            self.dragView.removeFromSuperview()
            var point:CGPoint!
            if CGRectContainsPoint(MainCollectionView.bounds, pointInMain!) {
                endRect = MainCollectionView
                point = pointInMain
            } else if CGRectContainsPoint(ChooseCollectionView.bounds, pointInChoose!) {
                endRect = ChooseCollectionView
                point = pointInChoose
            }
            if beginRect != nil && beginRect == ListingTableView {
                if let endRect = endRect as? UICollectionView {
                    if let path = endRect.indexPathForItemAtPoint(point) {
                        if let row = endRect.cellForItemAtIndexPath(path) {
                            if endRect == MainCollectionView {
                                if path.item != 3 {
//                                if selectedMainCell != 3 {
                                    for n in 0...(booking.count - 1) {
                                        if booking[n].bookingID == dragData as! String {
                                            booking[n].status = status[path.item]
//                                            CreatingReference()
//                                            sortingArrays()
                                        }
                                    }
                                    CreatingReference()
                                    sortingArrays()
                                    if path.item != selectedMainCell {
                                        if selectedMainCellPrior == nil {
                                            ChooseCollectionView.reloadData()
                                            ListingTableView.reloadData()
                                        } else {
                                            let temp = selectedMainCell
                                            println(temp)
                                            selectedMainCell = selectedMainCellPrior
                                            ListingTableView.reloadData()
                                            selectedMainCell = temp
                                            ChooseCollectionView.reloadData()
                                        }
                                    }
                                }
                            } else
                            if endRect == ChooseCollectionView {
                                if selectedMainCell == 3 {
                                    if path.item != 0 {
                                        for n in 0...(booking.count - 1) {
                                            if booking[n].bookingID == dragData as! String {
                                                println(dataPrimeLot[selectedMainCell][path.item] as! Int)
                                                booking[n].tableID = dataPrimeLot[selectedMainCell][path.item] as! Int
                                                println(booking[n].tableID)
                                                booking[n].status = status[1]
                                                println(booking[n].status)
                                            }
                                        }
                                    }
                                    CreatingReference()
                                    sortingArrays()
                                    tempdrag = selectedMainCell
                                    dragged = true
//                                    ChooseCollectionView.reloadData()
                                    selectedMainCell = selectedMainCellPrior
                                    ChooseCollectionView.reloadData()
                                    ListingTableView.reloadData()
//                                    selectedMainCell = item
                                    
//                                    if path.item != selectedMainCell {
//                                        if selectedMainCellPrior == nil {
//                                            ChooseCollectionView.reloadData()
//                                            ListingTableView.reloadData()
//                                        } else {
//                                            let temp = selectedMainCell
//                                            println(temp)
//                                            selectedMainCell = selectedMainCellPrior
//                                            ListingTableView.reloadData()
//                                            selectedMainCell = temp
//                                            ChooseCollectionView.reloadData()
//                                        }
//                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                
            }
        }
    }
    
    
    
//    func drag(gesture: UIPanGestureRecognizer) {
//        var point = gesture.locationInView(self.view)
//        var pointChange = gesture.translationInView(self.view)
//        if gesture.state == .Changed {
//            gesture.view!.center = CGPointMake(
//                dragView.center.x + pointChange.x,
//                dragView.center.y + pointChange.y)
//            gesture.setTranslation(CGPointZero, inView: self.view)
//        }
//    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print("called")
//        if collectionView == MainCollectionView {
//            //            let cell = MainCollectionView.c
//            let index = indexPath.row
//            selectedCell = index
//            ChooseCollectionView.reloadData()
//        }
//    }
    
    
    
    //-----------------------------------
    //Test Data
    //-----------------------------------
    func dataSet() {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let timeStringFormatter = NSDateFormatter()
        timeStringFormatter.dateFormat = "HH-mm-ss"
        
        var Booking13:BookingObject = BookingObject()
        
        Booking13.bookingID = "013"
        Booking13.bookingDate = dateStringFormatter.dateFromString("2015-08-25")
        Booking13.bookingTime = timeStringFormatter.dateFromString("20-00-00")
        Booking13.userID = "User003"
//        Booking13.tableID = 12
        Booking13.numberOfPeople = 2
        Booking13.status = "accepted"
        
        var Booking1:BookingObject = BookingObject()
        
        Booking1.bookingID = "001"
        Booking1.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        Booking1.bookingTime = timeStringFormatter.dateFromString("20-15-00")
        Booking1.userID = "User001"
//        Booking1.tableID = 1
        Booking1.numberOfPeople = 2
        Booking1.status = "pending"
        
        var Booking2:BookingObject = BookingObject()
        
        Booking2.bookingID = "002"
        Booking2.bookingDate = dateStringFormatter.dateFromString("2015-09-02")
        Booking2.bookingTime = timeStringFormatter.dateFromString("20-30-00")
        Booking2.userID = "User001"
//        Booking2.tableID = 2
        Booking2.numberOfPeople = 3
        Booking2.status = "pending"
        
        var Booking3:BookingObject = BookingObject()
        
        Booking3.bookingID = "003"
        Booking3.bookingDate = dateStringFormatter.dateFromString("2015-09-03")
        Booking3.bookingTime = timeStringFormatter.dateFromString("21-00-00")
        Booking3.userID = "User001"
//        Booking3.tableID = 3
        Booking3.numberOfPeople = 4
        Booking3.status = "pending"
        
        var Booking4:BookingObject = BookingObject()
        
        Booking4.bookingID = "004"
        Booking4.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        Booking4.bookingTime = timeStringFormatter.dateFromString("22-30-00")
        Booking4.userID = "User002"
//        Booking4.tableID = 4
        Booking4.numberOfPeople = 2
        Booking4.status = "pending"
        
        var Booking5:BookingObject = BookingObject()
        
        Booking5.bookingID = "005"
        Booking5.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        Booking5.bookingTime = timeStringFormatter.dateFromString("19-00-00")
        Booking5.userID = "User002"
//        Booking5.tableID = 5
        Booking5.numberOfPeople = 2
        Booking5.status = "pending"
        
        var Booking6:BookingObject = BookingObject()
        
        Booking6.bookingID = "006"
        Booking6.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        Booking6.bookingTime = timeStringFormatter.dateFromString("18-30-00")
        Booking6.userID = "User002"
//        Booking6.tableID = 6
        Booking6.numberOfPeople = 2
        Booking6.status = "pending"
        
        var Booking7:BookingObject = BookingObject()
        
        Booking7.bookingID = "007"
        Booking7.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        Booking7.bookingTime = timeStringFormatter.dateFromString("20-00-00")
        Booking7.userID = "User003"
//        Booking7.tableID = 7
        Booking7.numberOfPeople = 2
        Booking7.status = "pending"
        
        var Booking8:BookingObject = BookingObject()
        
        Booking8.bookingID = "008"
        Booking8.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        Booking8.bookingTime = timeStringFormatter.dateFromString("20-30-00")
        Booking8.userID = "User003"
//        Booking8.tableID = 8
        Booking8.numberOfPeople = 2
        Booking8.status = "pending"
        
        var Booking9:BookingObject = BookingObject()
        
        Booking9.bookingID = "009"
        
        
        Booking9.bookingDate = dateStringFormatter.dateFromString("2015-09-01")
        
//        dateStringFormatter.stringFromDate(Booking10.bookingDate);
        
        Booking9.bookingTime = timeStringFormatter.dateFromString("21-30-00")
        Booking9.userID = "User003"
//        Booking9.tableID = 9
        Booking9.numberOfPeople = 2
        Booking9.status = "pending"
        
        var Booking10:BookingObject = BookingObject()
        
        Booking10.bookingID = "010"
//        Booking10.bookingDate = "2015-09-01"
        Booking10.bookingDate = dateStringFormatter.dateFromString("2015-09-01")

//        dateStringFormatter.stringFromDate(Booking10.bookingDate);
        
        Booking10.bookingTime = timeStringFormatter.dateFromString("20-15-00")
        Booking10.userID = "User004"
//        Booking10.tableID = 10
        Booking10.numberOfPeople = 2
        Booking10.status = "pending"
        
        
        var Booking11:BookingObject = BookingObject()
        
        Booking11.bookingID = "011"
        Booking11.bookingDate = dateStringFormatter.dateFromString("2015-09-04")
        Booking11.bookingTime = timeStringFormatter.dateFromString("22-00-00")
        Booking11.userID = "User003"
//        Booking11.tableID = 11
        Booking11.numberOfPeople = 2
        Booking11.status = "accepted"
        
        
        var Booking12:BookingObject = BookingObject()
        
        Booking12.bookingID = "012"
        Booking12.bookingDate = dateStringFormatter.dateFromString("2015-08-25")
        Booking12.bookingTime = timeStringFormatter.dateFromString("20-00-00")
        Booking12.userID = "User003"
//        Booking12.tableID = 8
        Booking12.numberOfPeople = 2
        Booking12.status = "expired"

        booking.append(Booking13)
        booking.append(Booking1)
        booking.append(Booking2)
        booking.append(Booking3)
        booking.append(Booking4)
        booking.append(Booking5)
        booking.append(Booking6)
        booking.append(Booking7)
        booking.append(Booking8)
        booking.append(Booking9)
        booking.append(Booking10)
        booking.append(Booking11)
        booking.append(Booking12)
        
//        println(booking)
    }
    
    func reloadData() {
        self.CreatingReference()
        self.sortingArrays()
        self.MainCollectionView.reloadData()
        self.ChooseCollectionView.reloadData()
        self.ListingTableView.reloadData()
    }
    
    func readFromParse() {
        var loadingBookings = false
        var loadedTable = false
        var bookings: BookingObject = BookingObject()
        
        var query = PFQuery(className: "Bookings")
        query.findObjectsInBackgroundWithBlock {
            ( books: [AnyObject]?, error: NSError? ) -> Void in
            if error == nil {
                self.query1loaded = true
                println("read")
                println(books?.count)
                if let b = books as? [PFObject] {
                    for n in 0...(b.count - 1) {
                        bookings.bookingID = b[n].objectId//n.objectId
                        bookings.bookingDate = b[n]["BookingDate"] as? NSDate//n["BookingDate"] as? NSDate
                        bookings.bookingTime = b[n]["BookingTime"] as? NSDate//n["BookingTime"] as? NSDate
                        bookings.status = b[n]["Status"] as? String
                        bookings.userID = b[n]["User"] as? String
                        bookings.tableID = b[n]["Table"] as? Int
                        bookings.numberOfPeople = b[n]["NumberOfPeople"] as? Int
//                        println(bookings.status)
//                        println(n.objectId)
//                        
//                        println(bookings.bookingDate)
                        self.booking.append(bookings)
//                        booking.bookingDate = n.
                        println(self.booking.count)
                    }
                    if self.query1loaded == true && self.query2loaded == true {
                        self.reloadData()
                    }
                }
            }
        }
        
        var table: Table = Table()
        
        var query2 = PFQuery(className: "Tables")
        //        query.findObjects()
        
        
        query2.findObjectsInBackgroundWithBlock {
            (tableFromParse: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.query2loaded = true
                println("read tables")
                if let tableFromParse = tableFromParse as? [PFObject] {
                    for n in tableFromParse {
                        table.tableNum = n["TableNumber"] as? Int
                        self.tables.append(table)
                        println(self.tables.count)
                    }
                if self.query1loaded == true && self.query2loaded == true {
                        self.reloadData()
                    }
                    
                }
            }
        }
        
        if loadedTable == true && loadingBookings == true {
            
        }
    }
    
    func readTables() {

        
    }
    
    func CreatingTables() {
        
        var Table1:Table = Table()
        Table1.tableNum = 1
        
        var Table2:Table = Table()
        Table2.tableNum = 2
        
        var Table3:Table = Table()
        Table3.tableNum = 3
        
        var Table4:Table = Table()
        Table4.tableNum = 4
        
        var Table5:Table = Table()
        Table5.tableNum = 5
        
        var Table6:Table = Table()
        Table6.tableNum = 6
        
        var Table7:Table = Table()
        Table7.tableNum = 7
        
        var Table8:Table = Table()
        Table8.tableNum = 8
        
        var Table9:Table = Table()
        Table9.tableNum = 9
        
        var Table10:Table = Table()
        Table10.tableNum = 10
        
        tables.append(Table1)
        tables.append(Table2)
        tables.append(Table3)
        tables.append(Table4)
        tables.append(Table5)
        tables.append(Table6)
        tables.append(Table7)
        tables.append(Table8)
        tables.append(Table9)
        tables.append(Table10)
    }
    
    
    
    func dataCheck() {
        for n in 0...(booking.count-1) {
            println(booking[n].bookingID)
        }
    }
    
    
    
    func CreatingReference() {
        reference.removeAll(keepCapacity: false)
        if booking.count == 0 {
            
        } else {
            for n in 0...(booking.count-1) {
                var referenceObject:Reference = Reference()
                referenceObject.id = booking[n].bookingID
                referenceObject.status = booking[n].status
                referenceObject.date = booking[n].bookingDate
                referenceObject.table = booking[n].tableID
                referenceObject.time = booking[n].bookingTime
                reference.append(referenceObject)
            }
        }
    }
    
    func sortingArrays() {
//        let dateSet = NSMutableSet()
//        for n in 0...(reference.count-1) {
//            dateSet.allObjects(reference[n].date)
//        }
        
        var testingArray = [Any]()
        var tempDataSet = NSMutableArray()
        var tempDataSetSorted = [Any]()
        var obj:AnyObject!
        
        
        /*
        
        //first stage sorting, into status category
        for x in 0...(status.count - 1) {
//            println(x)
            //second stage sorting the second layer with NSArray and parameter
            for y in 0...(reference.count - 1) {
//                println(status[x])
//                println(reference[y].status)
                if x == 0 || x == 1 || x == 2 {
                    if status[x] == reference[y].status {
                        if tempDataSet.containsObject(reference[y].date) {
                        } else {
                            tempDataSet.addObject(reference[y].date as NSDate)
                        }
                        forthDataLot.append(reference[y])
                    }
                } else {
                    if reference[y].status == status[1] {
                        if reference[y].table != nil {
                            if tempDataSet.containsObject(reference[y].table) {
                            } else {
                                tempDataSet.addObject(reference[y].table as Int)
                            }
                            forthDataLot.append(reference[y])
                        }
                        //Sorting function require refinement here for tables, as tables is optional
                    }
                }
            }
            if tempDataSet.count != 0 {
                if let check = tempDataSet as NSArray as? [NSDate] {
                    if x == 2 {
                        let tempDateSet = check.sorted({$0.compare($1) == NSComparisonResult.OrderedDescending})
                        for n in 0...(tempDataSet.count - 1) {
                            secondDataLot.append(tempDataSet[n])
                        }
                    } else {
                        let tempDateSet = check.sorted({$0.compare($1) == NSComparisonResult.OrderedAscending})
                        for n in 0...(tempDataSet.count - 1){
                            secondDataLot.append(tempDataSet[n])
                        }
                    }
                    //                println(secondDataLot)
                } else if let check = tempDataSet as NSArray as? [Int] {
                    let tempDataSet = check.sorted({ ($0 < $1) })
                    //                println(tempDataSetSorted)
                    for n in 0...(tempDataSet.count - 1) {
                        //                    println(tempDataSet[n])
                        secondDataLot.append(tempDataSet[n])
                    }
                }
            }
            if secondDataLot.count != 0 || forthDataLot.count != 0 {
                for n in 0...(secondDataLot.count - 1) {
                    for m in 0...(forthDataLot.count - 1) {
                        if (secondDataLot[n] as? NSDate) == forthDataLot[m].date {
                            tempData.append(forthDataLot[m])
                        } else if (secondDataLot[n] as? Int ) == forthDataLot[m].table {
                            tempData.append(forthDataLot[m])
                        }
                    }
                    var tempDataSorted = [Reference]()
                    if x == 0 || x == 1 || x == 2 {
                        tempDataSorted = tempData.sorted({$0.time.compare($1.time) == NSComparisonResult.OrderedAscending})
                        //                    println(tempDataSorted)
                    } else {
                        tempDataSorted = tempData.sorted({$0.date.compare($1.date) == NSComparisonResult.OrderedAscending})
                    }
                    thirdDataLot.append(tempDataSorted)
                    tempData.removeAll(keepCapacity: false)
            }
            
                
        
                
                
                
                
//                if let tempDataSorted = tempData as? [Reference] {
//                    println(tempDataSorted)
//                }
                
                
                /*
                println(tempData)
                if let TestingData = tempData as? [Reference] {
//                if let tempData = tempData as? [Reference] {
//                    var testingtesting = [Reference]()
//                    for q in 0...(tempData.count - 1){
//                        testingtesting.append(tempData[q])
////                        println(testingtesting)
//                    }
                    for data in TestingData {
                        println(data.id)
                    }
                    var dateTime: NSDate!
                    println(secondDataLot[n])
                    println(x)
                    println(tempData.count)
                    if x == 0 || x == 1 || x == 2 {
//                        for data in 0...(tempData.count - 1) {
//                            println(data)
//                            println(tempData[data])
//                            println(tempData[data].id)
//                            if let dateTime = tempData[data].time {
//                                tempDateTime.append(dateTime)
//                            }
//                        }
                        println(tempDateTime)
                        let tempDataSorted = TestingData.sorted({$0.time.compare($1.time) == NSComparisonResult.OrderedAscending})
//                        let tempDataSorted = tempData.sorted({$0.time.compare($1.time) == NSComparisonResult.OrderedAscending})
//                        let tempDataSorted = tempData.sorted({ (I1:Reference, I2:Reference) -> Bool in
//                            return I1.table < I2.table
//                        })
//                        let tempDataSorted = tempData.sorted({ $0.table < $1.table })
                        
                        thirdDataLot.append(tempDataSorted)
                        println(thirdDataLot)
                    } else {
                        let tempDataSorted = TestingData.sorted({$0.time.compare($1.time) == NSComparisonResult.OrderedAscending})
//                        let tempDataSorted = tempData.sorted({$0.date.compare($1.date) == NSComparisonResult.OrderedAscending})
                        thirdDataLot.append(tempDataSorted)
                    }
//                    if let check = secondDataLot[n] as? NSData  {
//                        let tempDataSorted = tempData.sorted({$0.table < $1.table})
//                        thirdDataLot.append(tempDataSorted)
//                    } else if let check = secondDataLot[n] as? Int {
//                        let tempDataSorted = tempData.sorted({$0.date.compare($1.date) == NSComparisonResult.OrderedAscending})
//                        thirdDataLot.append(tempDataSorted)
//                    }
                }
                tempData.removeAll(keepCapacity: false)
              */
                
            }
                
            
            secondDataLot.insert(thirdDataLot, atIndex: 0)
            dataPrimeLot.insert(secondDataLot, atIndex: x)
            
            println("break prior to data removal")
            
            tempData.removeAll(keepCapacity: false)
            tempDataSet.removeAllObjects()
            forthDataLot.removeAll(keepCapacity: false)
            thirdDataLot.removeAll(keepCapacity: false)
            secondDataLot.removeAll(keepCapacity: false)
            
            println(dataPrimeLot)
        }
        
    //    */
        
        
        
        if reference.count == 0 {
            
        } else {
       
        
        //for loop for initial/master count
        for x in 0...(status.count-1) {
            //for loop for secondary layer, sorting and setting data as reference
            for y in 0...(reference.count - 1) {
//                println(String(x) + String(reference.count))
                //
                if x == 0 || x == 1 || x == 2 {
//                    if x == 1 {
//                        if status[x] == reference[y].status {
//                            println(reference[y].status)
//                        }
//                    }
                    println(reference[y].status)
                    if status[x] == reference[y].status {
                        if tempDataSet.containsObject(reference[y].date){
                        } else {
                            tempDataSet.addObject(reference[y].date as NSDate)
//                            println("This is reference[y].date" + String(stringInterpolationSegment: reference[y].date))
                        }
                        thirdDataLot.append(reference[y])
                    }
                } else {
                    if reference[y].status == "expired" {
                    } else {
                        for table in tables {
                            if let refTable = reference[y].table {
                                if reference[y].table == table.tableNum {
                                    if noData == true {
                                        thirdDataLot.removeAll(keepCapacity: false)
                                    }
                                    thirdDataLot.append(reference[y])
                                    noData = false
                                }
                            }
                        }
                        if thirdDataLot.isEmpty == false {
                            println(thirdDataLot[0].id)
                        }
                        if thirdDataLot.count == 0 {
                            noData = true
                            thirdDataLot = Array(count: 1, repeatedValue: reference[y])
                            println(thirdDataLot)
                        }
//                        if noData == true {
//
//                        } else {
//                            
//                        }
//                        for table in tables {
//                            if let refTable = reference[y].table {
//                                if reference[y].table == table.tableNum {
//                                    thirdDataLot.append(reference[y])
//                                    noData = false
//                                }
//                            } else {
//                                if thirdDataLot.count == 0 {
//                                    noData = true
//                                    thirdDataLot = Array(count: 1, repeatedValue: reference[y])
//                                }
//                            }
//                        }
                        
//                        if reference[y].table != nil {
//                            
//                            if tempDataSet.containsObject(reference[y].table){
//                            } else {
//                                tempDataSet.addObject(reference[y].table)
//                                //                            println(tempDataSet)
//                            }
//                            thirdDataLot.append(reference[y])
//                        }
                    }
                }
            }
            if x == 3 {
                for table in 0...(tables.count - 1) {
                    tempDataSet.addObject(tables[table].tableNum)
                }
                println(tempDataSet)
            }
            println(x)
            if let check = tempDataSet as NSArray as? [NSDate] {
                if x == 2 {
//                    tempDataSet = tempDataSet.sortedArrayUsingSelector(compare) 
                    let tempDataSet = check.sorted({$0.compare($1) == NSComparisonResult.OrderedDescending})
                    for n in 0...(tempDataSet.count - 1) {
                        secondDataLot.append(tempDataSet[n])
                    }
                } else {
                    let tempDataSet = check.sorted({ $0.compare($1) == NSComparisonResult.OrderedAscending})
//                    if tempDataSet.count == 1 {
//                        secondDataLot.append(tempDataSet[0])
//                    } else {
                    for n in 0...(tempDataSet.count - 1) {
                        secondDataLot.append(tempDataSet[n])
                    }
//                      }
                }
//                tempDataSetSorted = check.sorted({ $0.compare($1) == NSComparisonResult.OrderedAscending})
                //                println(tempDataSet)
            } else if let check = tempDataSet as NSArray as? [Int] {
                let tempDataSet = check.sorted({ ($0 < $1) })
//                println(tempDataSetSorted)
                for n in 0...(tempDataSet.count - 1) {
//                    println(tempDataSet[n])
                    secondDataLot.append(tempDataSet[n])
                }
            }
            
            if x == 3 {
                
            }
            
            secondDataLot.insert(thirdDataLot, atIndex: 0)
//            println(secondDataLot)
            dataPrimeLot.insert(secondDataLot, atIndex: x)
            
            tempDataSet.removeAllObjects()
            tempDataSetSorted.removeAll(keepCapacity: false)
            secondDataLot.removeAll(keepCapacity: false)
            thirdDataLot.removeAll(keepCapacity: false)
        }
        
        }
//        println(dataPrimeLot)
        
        
        
        
        
        /*
        
        
//        var tableSet = NSMutableSet()
        for x in 0...(status.count-1){
//            println(x)
//            println(status.count-1)
            
            //will be done 4 times, remember to think in sets of 4
            //runs through the whole referenece table to idenify status of the booking
            for n in 0...(reference.count-1) {
//                println(status[x])
//                println(reference[n].status)
                
                //Checking status vs reference.status and write the matching reference's data 
                //into a temp array before writing into reference array
                if x == 0 || x == 1 || x == 2 {
                    if status[x] == reference[n].status {
                        if tempDataSet.containsObject(reference[n].date){
                        } else {
                            var d:NSDate = reference[n].date
                            tempDataSet.addObject(reference[n].date)
                            obj = [NSDate]()
                            println(tempDataSet)
                        }
                        thirdDataLot.append(reference[n])
                        if x == 2 {
//                            tempDataSetSorted = tempDataSet.sorted({$0.compare($1) == NSComparisonResult.OrderedAscending})
                        }
                    }
                } else {
                    if tempDataSet.containsObject(reference[n].table) {
                        //$$ (reference[n].status == "expired") 
                    } else {
                        tempDataSet.addObject(reference[n].table)
                        obj = [Int]()
                    }
                    thirdDataLot.append(reference[n])
                }
            }
//            if let tempDataSet = obj as? [NSDate] {
//                tempDataSetSorted = tempDataSet.sorted({ $0.compare($1) == NSComparisonResult.OrderedAscending})
//                println(tempDataSetSorted)
////                tempDataSet.sort({ $0.date.compare($1.date) == NSComparisonResult.OrderedAscending})
//            } else if let tempDataSet = obj as? [Int] {
//                tempDataSetSorted = tempDataSet.sorted({ $0 < $1 })
//            } else {
//                for y in 0...(tempDataSet.count - 1) {
//                    tempDataSetSorted.append(tempDataSet[y])
//                }
//            }
            //this is the end of a set for the prim for loop, implement per set codes here after second for loop
            for y in 0...(tempDataSet.count-1) {
                secondDataLot.append(tempDataSet[y])
            }
//            println(secondDataLot.count)
//            println(secondDataLot)
            secondDataLot.insert(thirdDataLot, atIndex: 0)
            dataPrimeLot.insert(secondDataLot, atIndex: x)
            
            tempDataSet.removeAllObjects()
            secondDataLot.removeAll(keepCapacity: false)
            thirdDataLot.removeAll(keepCapacity: false)
            obj = nil
        }
        
//        println(dataPrimeLot)
        
        
//        var tempArray = []
//        var tempArray = tableSet.allObjects.sorted {
//            (Item1:Int, Item2:Int) -> Bool in
//            return Item1 > Item2
//        };
        
//        var tableSetSort:[Int] = tableSet.sort { (Item1, Item2) -> Bool in
//            return Item1 > Item2
//        }
//        println(tableSet)
        
        
//        println(reference.count)
        
//        var bookingsSortedByTableID:[BookingObject] = booking.sorted { (firstItem:BookingObject , secondItem:BookingObject) -> Bool in
//            return firstItem.tableID > secondItem.tableID;
//        };
        
//        var bookingsSortedByDate:[BookingObject] = booking.sorted { (firstItem:BookingObject , secondItem:BookingObject) -> Bool in
//            return firstItem.bookingDate.compare(secondItem.bookingDate);
//        };
        
        var bookingsSortedByPoplarity:[BookingObject] = booking.sorted { (firstItem:BookingObject , secondItem:BookingObject) -> Bool in
            return firstItem.tableID > secondItem.tableID;
        };
*/
    }
    
    
    
    func add(sender:UIButton) {
        var temp123: Int!
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let timeStringFormatter = NSDateFormatter()
        timeStringFormatter.dateFormat = "HH-mm-ss"
        if selectedMainCell == 1 {
            println("button clicked")
            println(booking.count)
            var bookingtemp: BookingObject = BookingObject()
            bookingtemp.bookingID = String(booking.count)
            bookingtemp.bookingDate = dateStringFormatter.dateFromString(self.addDate.text)
            bookingtemp.bookingTime = timeStringFormatter.dateFromString(self.addTime.text)
            bookingtemp.userID = self.addUser.text
            bookingtemp.numberOfPeople = self.addNumOfP.text.toInt()
            bookingtemp.status = "accepted"
            booking.append(bookingtemp)
            println(booking.count)
            self.addView.removeFromSuperview()
            ChooseCollectionView.reloadData()
            ListingTableView.reloadData()
        } else if selectedMainCell == 3 {
            var tabletemp: Table = Table()
            tabletemp.tableNum = self.addTable.text.toInt()
            tables.append(tabletemp)
            self.addView.removeFromSuperview()
        }
        
    }
    
    func can(sender:UIButton) {
        self.addView.removeFromSuperview()
        println("can button clicked")
    }
    
    
    
    //-----------------------------------
    //viewDidLoad
    //-----------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


//        readFromParse()
//        readTables()
    //    /*

        MainCollectionView.delegate = self
        ChooseCollectionView.delegate = self
        MainCollectionView.dataSource = self
        ChooseCollectionView.dataSource = self
        ListingTableView.delegate = self
        ListingTableView.dataSource = self
//        MainCollectionView.allowsSelection = true
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 5
        )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.MainCollectionView.collectionViewLayout = layout
        
        let layout2:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 5
        )
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 10
        layout2.scrollDirection = UICollectionViewScrollDirection.Horizontal
        self.ChooseCollectionView.collectionViewLayout = layout2
        
        
        
        
        self.addView.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        
        self.addView.center = self.view.center
        
//        self.addLabel.frame = CGRect(x: addLabel.frame.width, y: 0, width: addView.bounds.width/2, height: (addView.bounds.height/4 - 4))
//        
//        self.addDate.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: (addView.bounds.width/2 - 4),
//            height: (addView.bounds.height/4 - 4))
//        self.addTime.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: (addView.bounds.width/2 - 4),
//            height: (addView.bounds.height/4 - 4))
//        self.addUser.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: (addView.bounds.width/2 - 4),
//            height: (addView.bounds.height/4 - 4))
//        self.addNumOfP.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: (addView.bounds.width/2 - 4),
//            height: (addView.bounds.height/4 - 4))
//        
//        
//        addBut = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//        addBut.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: (addView.bounds.width/2 - 4),
//            height: (addView.bounds.height/4 - 4))
//        addBut.backgroundColor = UIColor.blueColor()
//        addBut.setTitle("Add", forState: UIControlState.Normal)
//        addBut.addTarget(self, action: "add:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        canBut = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//        canBut.frame = CGRect(
//            x: 0,
//            y: 0,
//            width: (addView.bounds.width/2 - 4),
//            height: (addView.bounds.height/4 - 4))
//        canBut.backgroundColor = UIColor.blueColor()
//        canBut.setTitle("Add", forState: UIControlState.Normal)
//        canBut.addTarget(self, action: "add:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        self.addLabel.center = CGPoint(x: self.addView.bounds.midX, y: (self.addView.bounds.maxY/4 - self.addView.bounds.maxY/8))
//        
//        self.addDate.center = CGPoint(
////            CGPoint(x: self.addView.bounds.midX, y: (self.addView.bounds.maxY/4 - self.addView.bounds.maxY/8))
////            CGPoint(x: addView.center.x, y: addView.center.y)
//            x: self.addView.bounds.maxX/4,
//            y: ((self.addView.bounds.maxY/4 * 2) - self.addView.bounds.maxY/8))
//        self.addTime.center = CGPoint(
//            x: (self.addView.bounds.maxX/4 * 3),
//            y: ((self.addView.bounds.maxY/4 * 2) - self.addView.bounds.maxY/8))
//        
//        self.addUser.center = CGPoint(
//            x: self.addView.bounds.maxX/4,
//            y: ((self.addView.bounds.maxY/4 * 3) - self.addView.bounds.maxY/8))
//        self.addNumOfP.center = CGPoint(
//            x: (self.addView.bounds.maxX/4 * 3),
//            y: ((self.addView.bounds.maxY/4 * 3) - self.addView.bounds.maxY/8))
//        
//        self.addBut.center = CGPoint(
//            x: self.addView.bounds.maxX/4,
//            y: ((self.addView.bounds.maxY) - self.addView.bounds.maxY/8))
//        self.canBut.center = CGPoint(
//            x: self.addView.bounds.maxX/4 * 3,
//            y: ((self.addView.bounds.maxY) - self.addView.bounds.maxY/8))
//        
//        addLabel.text = "123"
//        addLabel.textAlignment = NSTextAlignment.Center
//        
//        addDate.backgroundColor = UIColor.whiteColor()
//        addDate.placeholder = "Add Date: YYYY-MM-DD"
//        
//        addTime.backgroundColor = UIColor.whiteColor()
//        addTime.placeholder = "Add Date: HH-mm-ss"
//        
//        addUser.backgroundColor = UIColor.whiteColor()
//        addUser.placeholder = "Add UserName"
//        
//        addNumOfP.backgroundColor = UIColor.whiteColor()
//        addNumOfP.placeholder = "Add Number of People"
//
//        
//        
        self.view.addSubview(addView)
//        self.addView.addSubview(addLabel)
//        self.addView.addSubview(addDate)
//        self.addView.addSubview(addTime)
//        self.addView.addSubview(addUser)
//        self.addView.addSubview(addNumOfP)
//        self.addView.addSubview(addBut)
//        self.addView.addSubview(canBut)
        
        addView.backgroundColor = UIColor.redColor()
        addView.hidden = true
        
        var tap = UITapGestureRecognizer(target: self, action: "tap:")
        tap.numberOfTapsRequired = 1
//        self.MainCollectionView.addGestureRecognizer(tap)
        self.MainCollectionView.userInteractionEnabled = true
        
        self.view.addGestureRecognizer(tap)
        self.ChooseCollectionView.userInteractionEnabled = true
        
        
        
//        var drag = UIPanGestureRecognizer(target: self, action: "drag:")
//        self.view.addGestureRecognizer(drag)
        
        var makeDrag = UILongPressGestureRecognizer(target: self, action: "makeDrag:")
        makeDrag.minimumPressDuration = 0.2
        makeDrag.allowableMovement = 5
        self.view.addGestureRecognizer(makeDrag)
        
        
        
        
//        dataArray.append(MenuData)
//        var dataArray:[[String]] = [MenuData, PendingData]
//        
//        var test = dataArray[0]
        
//        println(test[0])
        
//        readFromParse()
        dataSet()
        CreatingReference()
        CreatingTables()
        sortingArrays()
//        dataCheck()
     //   /*
        //tables array
    
//        testDataSet = [TestTableData,TestTableData2,TestTableData3,TestTableData4]
//        loadTableData()
        
        
        //Main Index + Reference Array
        
//        testDataSet2 = [PendingData,AcceptData,RejectedData,tableDataSet]
//        loadInitialData()
    //    */
 //   */
    }
    
//    override func viewDidAppear(animated: Bool) {
//        CreatingReference()
//        sortingArrays()
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    func loadTableData(){
        for n in 0...(TableNumber.count-1) {
//            println(n)
//            println(testDataSet[n])
            var testDataSetArray = testDataSet[n] as! NSArray
            tableDataSet.append(testDataSetArray)
//            SecondDataSet = [TestTableData,TestTableData2,TestTableData3,TestTableData4]
        }
        tableDataSet.removeAtIndex(0)
//        println(tableDataSet.count)
//        println(SecondDataSet[0])
//        println(tableDataSet)
    }
    
    
    func loadInitialData() {
        for n in 0...(MenuData.count-1){
            var testDateSetArray = testDataSet2[n] as! NSArray
            SecondDataSet.append(testDateSetArray)
//            println(SecondDataSet.count)
//            println("This is " + String(n))
        }
//        println(SecondDataSet.count)
        SecondDataSet.removeAtIndex(0)
    }
    
//    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
//        
//        println(touch)
//        return true
//    }
    
    
//    func sortingDataForListing {
//        
//    }
    
    
}







extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == MainCollectionView {
            if reference.count == 0 {
                return status.count
            } else {
            return dataPrimeLot.count
            }
        } else {
            if let cell = selectedMainCell {
                if cell == 0 || cell == 1 || cell == 2 {
                    if reference.count == 0 {
                        return 1
                    } else {
                    if cell == 1 {
                        return (dataPrimeLot[cell].count + 1)
                    }
                    return dataPrimeLot[cell].count
                    }
                } else {
                    if tables.count == 0 {
                        return 1
                    } else {
                    return (tables.count + 2)
                    }
                }
            } else {
                return PendingData.count
            }
        }
        
        
        
        
        
        
        
        
//        if collectionView == MainCollectionView {
//            return MenuData.count
//        } else {
//            if let cell = selectedMainCell {
//                switch cell {
//                case 0:
//                    return PendingData.count
//                case 1:
//                    return AcceptData.count
//                case 2:
//                    return RejectedData.count
//                case 3:
//                    return TableNumber.count
//                default:
//                    return PendingData.count
//                }
//            } else {
//                return PendingData.count
//            }
//        }
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let timeStringFormatter = NSDateFormatter()
        timeStringFormatter.dateFormat = "HH-mm-ss"
        if collectionView == MainCollectionView {
            let cell = MainCollectionView.dequeueReusableCellWithReuseIdentifier("MainCollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
            let row = indexPath.row
            //            println(row)
            //            selectedCell = row
            cell.DisplayLabel.text = MenuData[row]
            return cell
        } else {
            let cell2 = ChooseCollectionView.dequeueReusableCellWithReuseIdentifier("ChooseCell", forIndexPath: indexPath) as! ChooseCollectionViewCell
            let row = indexPath.row
            //            println(PendingData)
            //            println(row)
            
            if let cell = selectedMainCell {
//                if selectedMainCell == 0 || selectedMainCell == 1 || selectedMainCell == 2 {
//                    
//                }
                if selectedMainCell == 0 || selectedMainCell == 1 || selectedMainCell == 2 {
                    println(selectedMainCell)
                    if reference.count == 0 {
                        cell2.DisplayLabel2.text = "No Data"
                        return cell2
                    } else {
                    if selectedMainCell == 1 {
                        println(row)
                        println(dataPrimeLot[cell].count)
                        if row == 0 {
                            cell2.DisplayLabel2.text = "All"
                            return cell2
//                            println(row)
                        } else if row == dataPrimeLot[cell].count {
                            cell2.DisplayLabel2.text = "Add"
                            return cell2
                        } else {
                            let display = dataPrimeLot[cell][row] as? NSDate
                            cell2.DisplayLabel2.text = dateStringFormatter.stringFromDate(display!)
                            return cell2
                        }
                    } else {
                        if let display = dataPrimeLot[cell][row] as? NSDate {
                            cell2.DisplayLabel2.text = dateStringFormatter.stringFromDate(display)
                            return cell2
                        } else {
                            cell2.DisplayLabel2.text = "All"
                            return cell2
                        }
                    }
                    }
                } else {
                    if tables.count == 0 {
                        cell2.DisplayLabel2.text = "Loading"
                        return cell2
                    } else {
                    if row == 0 {
                        cell2.DisplayLabel2.text = "All"
                        return cell2
                    } else if row == tables.count + 1 {
                        cell2.DisplayLabel2.text = "Add"
                        return cell2
                    } else {
                        let tablerow = row - 1
                        cell2.DisplayLabel2.text = String(tables[tablerow].tableNum)
                        return cell2
                    }
                    }
//                    cell2.DisplayLabel2.text
//                    
//                    if let display = dataPrimeLot[cell][row] as? Int {
//                        cell2.DisplayLabel2.text = String(stringInterpolationSegment: dataPrimeLot[cell][row])
//                        return cell2
//                    } else {
//                        cell2.DisplayLabel2.text = "All"
//                        return cell2
//                    }
                    
//                    if let display = SecondDataSet[cell][3][row] as? String {
//                        cell2.DisplayLabel2.text = display
//                        return cell2
//                    } else {
//                        cell2.DisplayLabel2.text = "error"
//                        return cell2
//                    }
                }
            }
            else {
                cell2.DisplayLabel2.text = "error"
                return cell2
            }
            
            /*
            if let cell = selectedMainCell {
                if let Display = SecondDataSet[cell][row] as? String {
                    cell2.DisplayLabel2.text = Display
                    return cell2
                } else {
                    cell2.DisplayLabel2.text = TableNumber[row]
                    return cell2
                }
            } else {
                cell2.DisplayLabel2.text = PendingData[row]
                return cell2
            }
            //        CellLabel.text = MainData[row]
            */
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == MainCollectionView {
            return CGSize(width: (self.MainCollectionView.bounds.width/4 - 10), height: 40)
        } else {
            //---------------------------------------------------------------------
            //remember to change data point for the width referenece of the second collection view
            //---------------------------------------------------------------------
            var cellcount = tables.count
            if tables.count == 0 {
                cellcount = 4
            } else {
            
            if cellcount <= 10 {
                cellcount = tables.count
            } else {
                cellcount = 10
            }
            }
            var cellWidth = (self.ChooseCollectionView.bounds.width)/CGFloat(cellcount)
            var cellHeight = CGFloat(40)
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
    }
    
    
}







extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
        
//        if selectedMainCell == 0 || selectedMainCell == 1 || selectedMainCell == 2 {
//            if selectedChooseCell == 0 {
//                println(dataPrimeLot[selectedMainCell][selectedChooseCell])
//                if let tempVar = dataPrimeLot[selectedMainCell][selectedChooseCell] as? [NSArray] {
//                    let count = tempVar.count
//                    return count
//                } else {
//                    return 1
//                }
//            } else {
//                return 1
//            }
//        } else {
//            //need to re config for tables objects
//            return 1
//        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int!
//        if tableView == ListingTableView {
//            if let cell = selectedMainCell {
//                if let cell2 = selectedChooseCell {
//                    if cell == 0 || cell == 1 || cell == 2 {
//                        if let check = dataPrimeLot[cell][cell2] as? NSArray {
//                            if cell2 == 0 {
//                                count = check.count
//                            } else {
//                                
////                                if let tempcount = dataPrimeLot[cell][0][selectedChooseCell] as NSArray {
////                                    
////                                }
////                                count = dataPrimeLot[cell][0][selectedChooseCell - 1]
//                            }
//                            
//                        } else {
//                            
//                        }
//                    }
//                }
//            }
//        }
        
        if reference.count == 0 {
            return 1
        }else {
        
        if tableView == ListingTableView {
            if let cell = selectedMainCell {
                if let cell2 = selectedChooseCell {
                    println(cell)
                    if selectedMainCell == 0 || selectedMainCell == 1 || selectedMainCell == 2 {
//                        println(dataPrimeLot)
                        println(selectedMainCell)
                        println(dataPrimeLot[cell][cell2])
                        if let check = dataPrimeLot[cell][cell2] as? [Reference] {
                            count = check.count
                            println("This is the count for " + String(cell) + " " + String(count))
//                            return check.count
                        } else {
                            secondDataSetRef = []
                            if let check = dataPrimeLot[cell][0] as? NSArray {
//                                println(check)
//                                var checkCount:Int!
//                                if check.count == 1 {
//                                    checkCount == check.count
//                                } else {
//                                    checkCount == check.count - 1
//                                }
                                for n in 0...(check.count - 1) {
                                    if let test = check[n] as? Reference {
                                        if test.date == (dataPrimeLot[cell][cell2] as! NSDate) {
                                            self.secondDataSetRef.append(check[n] as! Reference)
                                        }
                                    }
                                }
                                count = secondDataSetRef.count
                            }
                        }
                        return count
                    } else {
                        if tables.count == 0 {
                            return 2
                        } else {
                            
                        if noData == true {
                            count = 1
                        } else {
                            if let check = dataPrimeLot[cell][cell2] as? [Reference] {
                                count = check.count
                            } else {
                                secondDataSetRef = []
                                if let check = dataPrimeLot[cell][0] as? NSArray {
                                    for n in 0...(check.count - 1) {
                                        if let test = check[n] as? Reference {
                                            if test.table == (dataPrimeLot[cell][cell2] as! Int) {
                                                self.secondDataSetRef.append(check[n] as! Reference)
                                            }
                                        }
                                    }
                                    count = secondDataSetRef.count
                                } else {
                                    count = 1
                                }
                            }
                        }
                        }
                        return count
//                        return SecondDataSet[cell][cell2].count
                    }
//                    switch cell {
//                    case 0:
//                        return TestTableData.count
//                    case 1:
//                        return TestTableData2.count
//                    case 2:
//                        return TestTableData3.count
//                    default:
//                        return TestTableData.count
//                    }
                }
                
            }
        } else {
            return TestTableData.count
        }
        return TestTableData.count
    }
    }
    
    
    //building cell for collection view and table view.
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let timeStringFormatter = NSDateFormatter()
        timeStringFormatter.dateFormat = "HH-mm-ss"
        if reference.count == 0 {
            let cell = ListingTableView.dequeueReusableCellWithIdentifier("ListingTableCell", forIndexPath: indexPath) as! UITableViewCell
            let row = indexPath.row
            cell.textLabel?.text = "No Data"
            return cell
        } else {
        if tableView == ListingTableView {
            let cell = ListingTableView.dequeueReusableCellWithIdentifier("ListingTableCell", forIndexPath: indexPath) as! TableViewCell
            //            println(cell)
            let row = indexPath.row
            if let check1 = selectedMainCell {
                if let check2 = selectedChooseCell {
//                    println(check2)
                    if check1 == 0 || check1 == 1 || check1 == 2 {
                        if let display = dataPrimeLot[check1][check2] as? NSArray {
                            if let celldisplay = display[row] as? Reference {
                                cell.textLabel?.text = celldisplay.id
                                cell.textLabel?.hidden = true
                                cell.DateLabel.text = dateStringFormatter.stringFromDate(celldisplay.date)
                                cell.TimeLabel.text = timeStringFormatter.stringFromDate(celldisplay.time)
                                if celldisplay.table != nil {
                                    cell.TableNumberLabel.text = String(celldisplay.table)
                                } else {
                                    cell.TableNumberLabel.text = "Not yet Assign"
                                }
                                for temp in 0...(booking.count - 1 ){
                                    if booking[temp].bookingID == celldisplay.id {
                                        cell.UserLabel.text = booking[temp].userID
                                        cell.NumOfPLabel.text = String(booking[temp].numberOfPeople)
                                    }
                                    
                                }
                                
//                                cell.textLabel?.text = celldisplay.id
                            }
                        } else if let display = dataPrimeLot[check1][check2] as? NSDate {
                            cell.textLabel?.text = secondDataSetRef[row].id
                        }
                    } else {
                        if noData == true {
                            cell.textLabel?.text = "No Data"
                        } else {
                            println(check1)
                            println(dataPrimeLot[3][0])
                            if let display = dataPrimeLot[check1][check2] as? NSArray {
                                println(display.count)
//                                println(dataPrimeLot[check1][check2][1].id)
                                println(check1)
                                println(check2)
                                println(row)
                                if let celldisplay = display[row] as? Reference {
                                    println(celldisplay.id)
                                    cell.textLabel?.text = celldisplay.id
                                }
                            } else if let display = dataPrimeLot[check1][check2] as? Int {
                                cell.textLabel?.text = secondDataSetRef[row].id
                            } else {
                                if check2 == 1 {
                                    cell.textLabel?.text = secondDataSetRef[row].id
                                }
                            }
                        }
                    }
                }
            }
//            if dragged != nil && dragged == true {
//                selectedMainCellPrior = selectedMainCell
//                selectedMainCell = tempdrag
//            } else {
//            }
            
            return cell
            
           /*
            
            if let test1 = selectedMainCell {
//                println(selectedChooseCell)
                if let test2 = selectedChooseCell {
                    if let label = self.SecondDataSet[test1][row] as? String {
                        cell.textLabel?.text = label
//                        println(label)
                        return cell
                    } else
                    if let label = self.SecondDataSet[test1][test2][row] as? String {
                        cell.textLabel?.text = label
//                        println(label)
                        return cell
                    } else {
                        println("error")
                        return cell
                    }
                }
            } else {
                return cell
            }
            */
        }
        let cell = ListingTableView.dequeueReusableCellWithIdentifier("ListingTableCell", forIndexPath: indexPath) as! UITableViewCell
        return cell
        
    }
    }
    
}



/*
if let cell1 = selectedChooseCell {
switch cell1 {
case 0:
if let label = self.SecondDataSet[cell1][row] as? String {
cell.textLabel?.text = label as! String
//                    cell.textLabel?.text = TestTableData[row]
return cell
} else {
cell.textLabel?.text = "error"
return cell
}
case 1:
cell.textLabel?.text = TestTableData2[row]
return cell
case 2:
cell.textLabel?.text = TestTableData3[row]
return cell
default:
cell.textLabel?.text = TestTableData[row]
return cell
}
} else {
cell.textLabel?.text = TestTableData[row]
return cell
}
*/





/*
cell2.DisplayLabel2.text = SecondDataSet[cell][row] as! String
switch selectedMainCell {
case 0:
cell2.DisplayLabel2.text = PendingData[row]
return cell2
case 1:
cell2.DisplayLabel2.text = AcceptData[row]
return cell2
case 2:
cell2.DisplayLabel2.text = RejectedData[row]
return cell2
case 3:
cell2.DisplayLabel2.text = TableNumber[row]
return cell2
default:
cell2.DisplayLabel2.text = PendingData[row]
return cell2
}







if tableSet.containsObject(reference[n].date) {
} else {
tableSet.addObject(reference[n].date)
println(reference[n].date)
}
} else if x == 3 {
if tableSet.containsObject(reference[n].table) {
} else {
tableSet.addObject(reference[n].table)
}






*/


