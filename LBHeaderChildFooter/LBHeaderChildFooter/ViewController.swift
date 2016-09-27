//
//  ViewController.swift
//  LBHeaderChildFooter
//
//  Created by Wira on 9/27/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var headerItems = [String]()
    var childItems = [String]()
    var footerItems = [String]()
    
    var selectedIndexPathSection:Int = -1
    var expandedItemList = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        headerItems = ["Asset","Debt","Networth","Cashflow","Primer"]
        childItems = ["Rp. 25.000.000","Rp. 50.000.000","Rp. 135.000.000"]
        footerItems = ["Total","Total","28th April 2017","29th April 2017","30th April 2017"]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Logbook"
        self.automaticallyAdjustsScrollViewInsets =  false
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 44;
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return headerItems.count
    }
    
    func numberOfFooterInTabelView(tableView: UITableView) -> Int{
        return footerItems.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return 35
    }
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return 35
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! HeaderCell
        headerCell.headerTitle.text = headerItems[section] as String
        
        //a buttton is added on the top of all UI elements on the cell and its tag is being set as header's section.
        
        headerCell.headerButton.tag =  section+100
        headerCell.headerButton.addTarget(self, action: "headerCellButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //minimize and maximize image with animation.
//        if(expandedItemList.contains(section))
//        {
//            UIView.animateWithDuration(0.3, delay: 1.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
//                headerCell.expandCollapseImageView.image =  UIImage(named: "maximize")
//                }, completion: nil)
//        }
//        else{
//            
//            UIView.animateWithDuration(0.3, delay: 1.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: {
//                headerCell.expandCollapseImageView.image =  UIImage(named: "minimize")
//                }, completion: nil)
//        }
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("footerCell") as! FooterCell
        
        
        return headerCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        for (var i = 0; i < expandedItemList.count ; i++) {
            
            if(expandedItemList[i] == section)
            {
                i == expandedItemList.count
                return 0
            }
        }
        return self.childItems.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let childCell = tableView.dequeueReusableCellWithIdentifier("childCell", forIndexPath: indexPath) as! ChildCell
        childCell.childValue.text = childItems[indexPath.row] as? String
        
        return childCell
    }
    
    
    //button tapped on header cell
    func headerCellButtonTapped(sender:UIButton)
    {
        for (var i = 0; i < expandedItemList.count ; i++) {
            
            if(expandedItemList[i] == (sender.tag-100))
            {
                expandedItemList.removeAtIndex(i)
                self.tableView.reloadData()
                
                return
            }
        }
        selectedIndexPathSection = sender.tag - 100
        expandedItemList.append(selectedIndexPathSection)
        
        
        UIView.animateWithDuration(0.3, delay: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve , animations: {
            self.tableView.reloadData()
            }, completion: nil)
        
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        
        let valueSelected: String = self.childItems[indexPath.row]
        
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("detail") as! DetailViewController
        viewController.value = valueSelected
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }


}

