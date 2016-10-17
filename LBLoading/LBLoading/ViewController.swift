//
//  ViewController.swift
//  LBLoading
//
//  Created by Wira on 10/17/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LoadingOverlay.shared.showOverlay(self.view)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        LoadingOverlay.shared.showOverlay(self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class LoadingOverlay{
        
        var overlayView = UIView()
        var activityIndicator = UIActivityIndicatorView()
        
        class var shared: LoadingOverlay {
            struct Static {
                static let instance: LoadingOverlay = LoadingOverlay()
            }
            return Static.instance
        }
        
        func showOverlay(view: UIView) {
            
            overlayView.frame = CGRectMake(0, 0, 80, 80)
            overlayView.center = view.center
            overlayView.backgroundColor = UIColor(white: 0x444444, alpha: 0.7)
            overlayView.clipsToBounds = true
            overlayView.layer.cornerRadius = 10
            
            activityIndicator.frame = CGRectMake(0, 0, 40, 40)
            activityIndicator.activityIndicatorViewStyle = .WhiteLarge
            activityIndicator.center = CGPointMake(overlayView.bounds.width / 2, overlayView.bounds.height / 2)
            
            overlayView.addSubview(activityIndicator)
            view.addSubview(overlayView)
            
            activityIndicator.startAnimating()
        }
        
        func hideOverlayView() {
            activityIndicator.stopAnimating()
            overlayView.removeFromSuperview()
        }
    }


}

