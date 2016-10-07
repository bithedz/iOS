//
//  ViewController.swift
//  LBFirebaseChat
//
//  Created by Wira on 10/2/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: Firebase!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Firebase(url: "https://wirasetiawan29.firebaseio.com/ios")
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startChat(sender: AnyObject) {
        self.performSegueWithIdentifier("Login", sender: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let navVc = segue.destinationViewController as! UINavigationController
        let chatVc = navVc.viewControllers.first as! ChatViewController
        chatVc.senderId = "wira"
        chatVc.senderDisplayName = ""
        
    }

}

