//
//  ViewController.swift
//  LBWebPdfViewer
//
//  Created by Wira on 10/10/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var path = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        path = NSBundle.mainBundle().pathForResource("Dropbox", ofType: "pdf")!
        
        let url = NSURL.fileURLWithPath(path)
        
        self.webView.loadRequest(NSURLRequest.init(URL: url))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

