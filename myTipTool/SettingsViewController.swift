//
//  SettingsViewController.swift
//  myTipTool
//
//  Created by Macintosh on 6/23/16.
//  Copyright © 2016 Ken Production. All rights reserved.
//

import UIKit

var defaultTipToPass = 18
var signalUpdate = 1
let defaults = NSUserDefaults.standardUserDefaults()

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTip18: UIImageView!
    
    @IBOutlet weak var defaultTip20: UIImageView!
    
    @IBOutlet weak var defaultTip22: UIImageView!
    

    
    var defaultTip18data = "checked"
    var defaultTip20data = "unchecked"
    var defaultTip22data = "unchecked"

    
    func save(){

        defaults.setObject(defaultTip18data, forKey: "defaultTip18")

        defaults.setObject(defaultTip20data, forKey: "defaultTip20")
        
        defaults.setObject(defaultTip22data, forKey: "defaultTip22")
        
        defaults.setObject(defaultTipToPass, forKey: "defaultTipToPass")
        signalUpdate = 1

        defaults.synchronize()
    }
    
    func load(){
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

    }

    func reDraw()
    {
        if defaultTip18data == "checked" {
            defaultTip18.image = UIImage(named: "checked.png")
        }else {
            defaultTip18.image = UIImage(named: "uncheck.png")
        }
        if defaultTip20data == "checked" {
            defaultTip20.image = UIImage(named: "checked.png")
        }else {
            defaultTip20.image = UIImage(named: "uncheck.png")
        }
        if defaultTip22data == "checked" {
            defaultTip22.image = UIImage(named: "checked.png")
        }else {
            defaultTip22.image = UIImage(named: "uncheck.png")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
//        self.navigationItem.
        load()
        reDraw()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onTap18(sender: AnyObject) {
        if defaultTip18data == "unchecked"
        {
            defaultTip18data = "checked"
            defaultTipToPass = 18
            defaultTip20data = "unchecked"
            defaultTip22data = "unchecked"

            save()
            reDraw()
            
        }
    }
    @IBAction func onTap20(sender: AnyObject) {
        if defaultTip20data == "unchecked"
        {
            defaultTip18data = "unchecked"
            defaultTipToPass = 20
            defaultTip20data = "checked"
            defaultTip22data = "unchecked"

            save()
            reDraw()
            
        }
    }
    
    @IBAction func onTap22(sender: AnyObject) {
        if defaultTip22data == "unchecked"
        {
            defaultTip18data = "unchecked"
            defaultTip20data = "unchecked"
            defaultTip22data = "checked"
            defaultTipToPass = 22

            save()
            reDraw()
            
        }
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
