//
//  ActivityViewController.swift
//  LBResearchKit
//
//  Created by Wira on 9/30/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit
import Foundation
import ResearchKit

enum Activity: Int {
    case Survey, Microphone, Tapping
    
    static var allValues: [Activity] {
        var index = 0
        return Array (
            AnyGenerator {
                let returnedElement = self.init(rawValue: index)
                index = index + 1
                return returnedElement
            }
        )
    }
    
    var title: String {
        switch self {
        case .Survey:
            return "Survey"
        case .Microphone:
            return "Microphone"
        case .Tapping:
            return "Tapping"
        }
    }
    
    var subtitle: String {
        switch self {
        case .Survey:
            return "Answer 6 short questions"
        case .Microphone:
            return "Voice evaluation"
        case .Tapping:
            return "Test tapping speed"
        }
    }
}

class ActivityViewController: UITableViewController {
    // MARK: UITableViewDataSource
    
    let QuestionStepIdentifier = "TextChoiceQuestionStep"
    let BooleanStepIdentifier = "BooleanQuestionStep"
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 0 else { return 0 }
        
        return Activity.allValues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath)
        
        if let activity = Activity(rawValue: indexPath.row) {
            cell.textLabel?.text = activity.title
            cell.detailTextLabel?.text = activity.subtitle
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let activity = Activity(rawValue: indexPath.row) else { return }
        
        let taskViewController: ORKTaskViewController
        switch activity {
        case .Survey:
            taskViewController = ORKTaskViewController(task: StudyTasks.surveyTask, taskRunUUID: NSUUID())
            
            
        case .Microphone:
            taskViewController = ORKTaskViewController(task: StudyTasks.microphoneTask, taskRunUUID: NSUUID())
            
            do {
                let defaultFileManager = NSFileManager.defaultManager()
                
                // Identify the documents directory.
                let documentsDirectory = try defaultFileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
                
                // Create a directory based on the `taskRunUUID` to store output from the task.
                let outputDirectory = documentsDirectory.URLByAppendingPathComponent(taskViewController.taskRunUUID.UUIDString)
                try defaultFileManager.createDirectoryAtURL(outputDirectory, withIntermediateDirectories: true, attributes: nil)
                
                taskViewController.outputDirectory = outputDirectory
            }
            catch let error as NSError {
                fatalError("The output directory for the task with UUID: \(taskViewController.taskRunUUID.UUIDString) could not be created. Error: \(error.localizedDescription)")
            }
            
        case .Tapping:
            taskViewController = ORKTaskViewController(task: StudyTasks.tappingTask, taskRunUUID: NSUUID())
        }
        
        
        
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    
}

extension ActivityViewController : ORKTaskViewControllerDelegate {
    
    
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        
        // Handle results using taskViewController.result
        
        let taskResult = taskViewController.result.results
        print(taskResult)
        //
        ////        let stepResult = taskViewController.result.stepResultForStepIdentifier(QuestionStepIdentifier)
        ////        let stepResults = stepResult!.results
        //        let stepFirstResult = taskResult!.first
        //        let booleanResult = stepFirstResult as? ORKChoiceQuestionResult
        //        let booleanAnswer = booleanResult!.choiceAnswers
        //        print("Result for question: \(booleanAnswer)")
        
        
        if reason == .Completed {
            if let stepResult = taskViewController.result.stepResultForStepIdentifier(QuestionStepIdentifier),
                let stepResults = stepResult.results,
                let stepFirstResult = stepResults.first,
                let booleanResult = stepFirstResult as? ORKChoiceQuestionResult,
                let booleanAnswer = booleanResult.choiceAnswers {
                print("Result for question: \(booleanAnswer)")
            }
            
            if let stepResult = taskViewController.result.stepResultForStepIdentifier(BooleanStepIdentifier),
                let stepResults = stepResult.results,
                let stepFirstResult = stepResults.first,
                let booleanResult = stepFirstResult as? ORKBooleanQuestionResult,
                let booleanAnswer = booleanResult.booleanAnswer {
                print("Result for question: \(booleanAnswer.boolValue)")
            }
        }
        //
        
        
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
