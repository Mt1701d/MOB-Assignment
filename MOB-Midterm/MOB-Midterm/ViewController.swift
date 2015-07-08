//
//  ViewController.swift
//  MOB-Midterm
//
//  Created by MT1701 on 6/7/15.
//  Copyright (c) 2015 MT1701. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Numbers: UITextView!
    @IBOutlet weak var ACBut: UIButton!
    
    var number: Double!
    
    var storeVal: Double = 0
    var calVal: Double = 0
    
    var counter: Int = 0
    
    var operationOP: String = ""
    var currentVal: String!
    
    var ClearActionCount: Int = 0
    
    var decimal: Bool = false
    var decimalCounter: Int = 0
    var decimalnum: Int = 0
    var checkCounter: Int = 0
    
    var checkVal: Int = 0
    
    
    @IBAction func AC(sender: AnyObject) {
        ClearAction()
        decimal = false
        decimalCounter = 0
//        var ClearCount = 0
//        if calVal == 0 {
//            storeVal = 0
//            Numbers.text = String(storeVal)
//            ClearCount++
//        } else if ClearCount > 0 {
//            storeVal = 0
//            calVal = 0
//            Numbers.text = String(storeVal)
//            ClearCount = 0
//        }
    }
    @IBAction func Crossover(sender: AnyObject) {
        ChangeBut()
        storeVal = storeVal * -1
        displayVal()
    }
    @IBAction func Precent(sender: AnyObject) {
        ChangeBut()
        storeVal = storeVal/100
        displayVal()
    }
    @IBAction func divide(sender: AnyObject) {
        ChangeBut()
        clearDecimal()
        ClearActionCount = 0
        currentVal = "/"
//        store()
        Cal()
        counter++
    }
    @IBAction func Num1(sender: AnyObject) {
        ChangeBut()
        ClearActionCount = 0
        number = 1
        decimalCount()
        NumberShown()
    }
    @IBAction func Num2(sender: AnyObject) {
        ChangeBut()
        ClearActionCount = 0
        number = 2
        decimalCount()
        NumberShown()
    }
    @IBAction func Num3(sender: AnyObject) {
        ChangeBut()
        ClearActionCount = 0
        number = 3
        decimalCount()
        NumberShown()
    }
    @IBAction func Multi(sender: AnyObject) {
        ChangeBut()
        clearDecimal()
        ClearActionCount = 0
        currentVal = "*"
//        store()
        Cal()
        counter++
    }
    @IBAction func Num4(sender: AnyObject) {
        ChangeBut()
        number = 4
        decimalCount()
        NumberShown()
        ClearActionCount = 0
    }
    @IBAction func Num5(sender: AnyObject) {
        ChangeBut()
        number = 5
        decimalCount()
        NumberShown()
        ClearActionCount = 0
    }
    @IBAction func Num6(sender: AnyObject) {
        ChangeBut()
        ClearActionCount = 0
        number = 6
        decimalCount()
        NumberShown()
    }
    @IBAction func Sub(sender: AnyObject) {
        ChangeBut()
        clearDecimal()
        currentVal = "-"
//        store()
        Cal()
        counter++
        ClearActionCount = 0
    }
    @IBAction func Num7(sender: AnyObject) {
        ChangeBut()
        number = 7
        decimalCount()
        NumberShown()
        ClearActionCount = 0
    }
    @IBAction func Num8(sender: AnyObject) {
        ChangeBut()
        number = 8
        decimalCount()
        NumberShown()
        ClearActionCount = 0
    }
    @IBAction func Num9(sender: AnyObject) {
        ChangeBut()
        number = 9
        decimalCount()
        NumberShown()
        ClearActionCount = 0
    }
    @IBAction func Add(sender: AnyObject) {
        ChangeBut()
        clearDecimal()
        currentVal = "+"
//        store()
        Cal()
        counter++
        ClearActionCount = 0
    }
    @IBAction func Num0(sender: AnyObject) {
        ChangeBut()
        number = 0
        decimalCount()
        NumberShown()
        ClearActionCount = 0
    }
    @IBAction func Decmal(sender: AnyObject) {
        ChangeBut()
        let tempnum = Int(storeVal)
        if decimalnum == 0 {
            decimal = true
            Numbers.text = tempnum.description + "."
            decimalnum++
        } else {
            decimal = false
            decimalnum = 0
            Numbers.text = tempnum.description
        }
    }
    
    @IBAction func Equal(sender: AnyObject) {
        ChangeBut()
        clearDecimal()
        currentVal = ""
        Cal()
        ClearActionCount = 0
    }
    
    
    
    
    
    func displayVal(){
        var valString: String!
        var valInt: Int!
        if storeVal%1 != 0 {
            let valString = storeVal.description
            Numbers.text = valString
        } else {
            let valInt = Int(storeVal)
            let valString = valInt.description
            Numbers.text = valString
        }
        
    }
    
    func decimalCount() {
        if decimal == true {
            decimalCounter++
        }
    }
    
    func checknum() {
        
    }
    
    func clearDecimal() {
        decimal = false
        decimalCounter = 0
    }
    
    func NumberShown() {
        if decimal == false {
            if storeVal == 0 {
                storeVal = number
                displayVal()
            } else {
                storeVal = storeVal*10 + number
                displayVal()
            }
        } else {
            var n = 0
            var nString: String = ""
            println(decimalCounter)
            println(checkCounter)
            if number == 0 {
                checkVal++
                if storeVal%1 == 0 {
                    while n < checkVal {
                        nString = nString + "0"
                        n++
                    }
                    let x = Int(storeVal)
                    let xString = x.description
                    Numbers.text = xString + "." + nString
                } else {
                    while n < checkVal {
                        nString = nString + "0"
                        n++
                    }
                    let xString = storeVal.description
                    Numbers.text = xString + nString
                }
                
                
//                if storeVal%1 != 0 {
//                    decimalCounter = decimalCounter - checkCounter
//                    while n < decimalCounter {
//                        nString = nString + "0"
//                        n++
//                    }
//                    let xString = storeVal.description
//                    Numbers.text = xString + nString
//                } else {
//                    while n < decimalCounter {
//                        nString = nString + "0"
//                        n++
//                    }
//                    let x = Int(storeVal)
//                    let xString = x.description
//                    Numbers.text = xString + "." + nString
//                }
            } else {
                var y: Double = number
                while n < decimalCounter {
                    y = y/10
                    n++
                }
                storeVal = storeVal + y
                displayVal()
                checkVal = 0
            }
        }
    }
    
    func ClearAction() {
        println(storeVal)
        println(calVal)
        if ClearActionCount == 0 {
            storeVal = 0
            displayVal()
            ACBut.setTitle("A/C", forState: .Normal)
            ClearActionCount++
        } else {
            calVal = 0
            counter = 0
            ClearActionCount = 0
            displayVal()
            println("full reset")
        }
        
    }
    
    func Cal() {
        if counter == 0 {
            calVal = storeVal
            operationOP = currentVal
            println(calVal)
            println(operationOP)
            storeVal = 0
        } else {
            if operationOP != "" {
                if operationOP == "+" {
                    storeVal = calVal + storeVal
                    calVal = storeVal
                    displayVal()
                    println(calVal)
                    println(storeVal)
                    storeVal = 0
                    operationOP = currentVal
                }
                else if operationOP == "-" {
                    storeVal = calVal - storeVal
                    calVal = storeVal
                    displayVal()
                    println(calVal)
                    println(storeVal)
                    storeVal = 0
                    operationOP = currentVal
                }
                    
                else if operationOP == "/" {
                    storeVal = calVal / storeVal
                    calVal = storeVal
                    displayVal()
                    println(calVal)
                    println(storeVal)
                    storeVal = 0
                    operationOP = currentVal
                }
                    
                else if operationOP == "*" {
                    storeVal = calVal * storeVal
                    calVal = storeVal
                    displayVal()
                    println(calVal)
                    println(storeVal)
                    storeVal = 0
                    operationOP = currentVal
                }
            } else {
                operationOP = currentVal
            }

        }
    }
    
    func ChangeBut() {
//        ACBut.titleLabel?.text = "C"
        ACBut.setTitle("C", forState: .Normal)
    }
    
    
//    func store(){
//        calVal = storeVal
//    }
//    
//    func reset() {
//        storeVal = 0
//    }
//    
//    func ContinueCal() {
//        if counter != 0{
//            Cal()
//        } else {
//            store()
//        }
//    }
//    
//    func Cal() {
//        if operationVal == "+" {
//            storeVal = calVal + storeVal
//            store()
//        }
//        Numbers.text = String(storeVal)
//    
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

