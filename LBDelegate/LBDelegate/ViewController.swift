//
//  ViewController.swift
//  LBDelegate
//
//  Created by Wira on 10/12/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DurationSelectDelegate {

    
    var secondController: SecondViewController = SecondViewController()
    
//    @IBAction func Next(sender : AnyObject)
//    {
//        let nextViewController = SecondViewController(nibName: "secondViewController", bundle: nil)
//        nextViewController.delegate = self
//        
//        self.navigationController!.pushViewController(nextViewController, animated: true)
//    }
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondController.delegate=self
    }
    
    func DurationSelected() {
        print("SUCCESS")
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSecondScreen(sender: AnyObject) {
        
       
//        viewController.delegate = self
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let objSomeViewController = storyBoard.instantiateViewControllerWithIdentifier("secondViewController") as! SecondViewController
        objSomeViewController.delegate = self
        self.presentViewController(objSomeViewController, animated:true, completion:nil)
        
//        let nextViewController = self.storyboard!.instantiateViewControllerWithIdentifier("secondViewController") as! SecondViewController
//        nextViewController.delegate = self
//        
//        self.navigationController!.pushViewController(nextViewController, animated: true)
        

//        
//        print(nextViewController)
//        
//        self.navigationController!.pushViewController(nextViewController, animated: true)
    }

}

