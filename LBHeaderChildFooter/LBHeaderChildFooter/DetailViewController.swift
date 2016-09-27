//
//  DetailViewController.swift
//  LBHeaderChildFooter
//
//  Created by Wira on 9/27/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailValue: UILabel!
    
    
    var value: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailValue.text = value
    }
}