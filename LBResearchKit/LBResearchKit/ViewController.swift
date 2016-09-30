//
//  ViewController.swift
//  LBResearchKit
//
//  Created by Wira on 9/30/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit
import ResearchKit


class ViewController: UIViewController {
    
    let QuestionStepIdentifier = "TextChoiceQuestionStep"
    let BooleanStepIdentifier = "BooleanQuestionStep"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myStep = ORKInstructionStep(identifier: "intro")
        myStep.title = "Welcome to ResearchKit"
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        
//        let myStep = ORKInstructionStep(identifier: "intro")
//        myStep.title = "Welcome to ResearchKit"
//        
//        let task = ORKOrderedTask(identifier: "task", steps: [myStep])
//        
//        let taskViewController: ORKTaskViewController
//        taskViewController = ORKTaskViewController(task: task, taskRunUUID: nil)
//        taskViewController.delegate = self
//        presentViewController(taskViewController, animated: true, completion: nil)
        
        let taskViewController: ORKTaskViewController
        taskViewController = ORKTaskViewController(task: StudyTasks.surveyTask, taskRunUUID: NSUUID())
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension ViewController : ORKTaskViewControllerDelegate {
//    
//    
//    
//    func taskViewController(taskViewController: ORKTaskViewController,
//                            didFinishWithReason reason: ORKTaskViewControllerFinishReason,
//                                                error: NSError?) {
//        let taskResult = taskViewController.result
//        // You could do something with the result here.
//        
//        // Then, dismiss the task view controller.
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//}


extension ViewController : ORKTaskViewControllerDelegate {
    
    
    
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

