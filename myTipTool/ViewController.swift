//
//  ViewController.swift
//  myTipTool
//
//  Created by Macintosh on 6/23/16.
//  Copyright © 2016 Ken Production. All rights reserved.
//

import UIKit
var checkdate = 1
class ViewController: UIViewController {
    
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    
    //var curDate =
    
    var defaultTipPercentage = 18
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willResignActive:", name: UIApplicationWillResignActiveNotification, object: nil)
    
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
        
        
    }
    
    func save(){
        
        
        defaults.setObject(billField.text, forKey: "billAmount")
        
        
        let saveDate = NSDate()
        
        defaults.setObject(saveDate, forKey: "saveDate")
        print("\(saveDate)")
        switch tipControl.selectedSegmentIndex{
        case 0:
            defaults.setObject(18, forKey: "tipPercentage")
        case 1:
            defaults.setObject(20, forKey: "tipPercentage")
        default:
            defaults.setObject(22, forKey: "tipPercentage")
        }
        signalUpdate = 1
        
        defaults.synchronize()
    }
    
   /* func load(){
        var assumedString: String!
        assumedString = defaults.objectForKey("defaultTip18") as? String ?? assumedString
        
        
        if let tmp18: String! = assumedString {
            defaultTip18data = assumedString
        }else
        {
            defaultTip18data = "checked";
        }
        
        assumedString = defaults.objectForKey("defaultTip20") as? String ?? assumedString
        
        if let tmp20: String! = assumedString {
            defaultTip20data = assumedString
        }else
        {
            defaultTip20data = "unchecked";
        }
        assumedString = defaults.objectForKey("defaultTip22") as? String ?? assumedString
        
        if let tmp22: String! = assumedString {
            defaultTip22data = assumedString
        }else
        {
            defaultTip22data = "unchecked";
        }
        
    }*/

    
    func willResignActive(notification: NSNotification) {
        // code to execute
        save()
    }
    
    func tipCalculate()
    {
        let tipPercentages = [0.18, 0.2, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale() // This is the default
        
        
        
        
        tipLabel.text = formatter.stringFromNumber(tip)
        totalLabel.text = formatter.stringFromNumber(total)
        
        //tipLabel.text = String(format:"$%.2f", tip)
        //totalLabel.text = String(format:"$%.2f", total)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        //defaultTipPercentage = defaultTipToPass
    if signalUpdate == 1
    {
        var assumedInt: Int!
        assumedInt = defaults.objectForKey("defaultTipToPass") as? Int ?? assumedInt
        
        
        if let tmp18: Int! = assumedInt {
            defaultTipPercentage = assumedInt
        }else
        {
            defaultTipPercentage = 18;
        }
        
        switch defaultTipPercentage{
        case 18:
            tipControl.selectedSegmentIndex = 0
        case 20:
            tipControl.selectedSegmentIndex = 1
        default:
            tipControl.selectedSegmentIndex = 2
            
        }
        signalUpdate = 0
        //self.onEditingChanged( nil )
        self.onEditingChanged()
        
    }
        
    if checkdate == 1{
        var curDate = NSDate()
        var preDate: NSDate!
        var preDatetmp: NSDate!
        preDatetmp = defaults.objectForKey("saveDate") as? NSDate ?? preDatetmp
        
        if let tmpDate: NSDate! = preDatetmp {
            preDate = preDatetmp
        }else
        {
            preDate = curDate;
        }
        
        let timeInterval: Double = curDate.timeIntervalSinceDate(preDate);
        if timeInterval < 600{
            var assumedString: String!
            assumedString = defaults.objectForKey("billAmount") as? String ?? assumedString
            if let tmpBill: String! = assumedString {
                billField.text = assumedString
            }
            
            var assumedInt: Int!
            assumedInt = defaults.objectForKey("tipPercentage") as? Int ?? assumedInt
            
            
            if let tmpTip: Int! = assumedInt {
                defaultTipPercentage = assumedInt
            }else
            {
                defaultTipPercentage = 18;
            }
            
            switch defaultTipPercentage{
            case 18:
                tipControl.selectedSegmentIndex = 0
            case 20:
                tipControl.selectedSegmentIndex = 1
            default:
                tipControl.selectedSegmentIndex = 2
                
            }
            
            self.onEditingChanged()
            
        }
            
    }
    checkdate = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject? = nil) {
        tipCalculate()
    }

    @IBAction func onTap(sender: AnyObject) {
        //view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
}

