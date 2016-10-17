//
//  SecondViewController.swift
//  LBDelegate
//
//  Created by Wira on 10/12/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import Foundation
import UIKit

protocol DurationSelectDelegate {
    func DurationSelected()
}



class SecondViewController: UIViewController {
    
    
     var delegate: DurationSelectDelegate?
    
    
    @IBAction func testDelegate(sender: AnyObject) {
        
        delegate?.DurationSelected()
        self.dismissViewControllerAnimated(true, completion: nil)
//        self.navigationController!.popViewControllerAnimated(true)
        
    }
}