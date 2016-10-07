//
//  ViewController.swift
//  LBDynamicLabel
//
//  Created by Wira on 10/7/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.label.text = heightForView("asdas", font: self.font!, width: 100.0) 
    }
    
  
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    
    func rectForText(text: String, font: UIFont, maxSize: CGSize) -> CGSize {
        let attrString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:font])
        let rect = attrString.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        let size = CGSizeMake(rect.size.width, rect.size.height)
        return size
    }
    
    let labelSize = rectForText("your text here", font: font, maxSize: CGSizeMake(100,999))
    let labelHeight = labelSize.height //here it is!
    
    let font = UIFont(name: "Helvetica", size: 20.0)

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

