//
//  StudyTask.swift
//  LBResearchKit
//
//  Created by Wira on 9/30/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import Foundation
import ResearchKit

struct StudyTasks {
    
    static let microphoneTask: ORKOrderedTask = {
        let intendedUseDescription = "Everyone's voice has unique characteristics."
        let speechInstruction = "After the countdown, say Aaaaaaaaaaah for as long as you can. You'll have 10 seconds."
        let shortSpeechInstruction = "Say Aaaaaaaaaaah for as long as you can."
        
        return ORKOrderedTask.audioTaskWithIdentifier("AudioTask", intendedUseDescription: intendedUseDescription, speechInstruction: speechInstruction, shortSpeechInstruction: shortSpeechInstruction, duration: 10, recordingSettings: nil, options: ORKPredefinedTaskOption.ExcludeAccelerometer)
    }()
    
    static let tappingTask: ORKOrderedTask = {
        let intendedUseDescription = "Finger tapping is a universal way to communicate."
        
        return ORKOrderedTask.twoFingerTappingIntervalTaskWithIdentifier("TappingTask", intendedUseDescription: intendedUseDescription, duration: 10, options: ORKPredefinedTaskOption.None)
    }()
    
    static let surveyTask: ORKOrderedTask = {
        var steps = [ORKStep]()
        
        // Instruction step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "Knoweledge of the Universe Survey"
        instructionStep.text = "Please answer these 6 questions to the best of your ability. It's okay to skip a question if you don't know the answer."
        
        steps += [instructionStep]
        
        // Quest question using text choice
        let questQuestionStepTitle = "Which of the following is not a planet?"
        let textChoices = [
            ORKTextChoice(text: "Saturn", value: 0),
            ORKTextChoice(text: "Uranus", value: 1),
            ORKTextChoice(text: "Pluto", value: 2),
            ORKTextChoice(text: "Mars", value: 3)
        ]
        let questAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.MultipleChoice, textChoices: textChoices)
        let questQuestionStep = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: questQuestionStepTitle, answer: questAnswerFormat)
        
        
        steps += [questQuestionStep]
        
        // Name question using text input
        let nameAnswerFormat = ORKTextAnswerFormat(maximumLength: 25)
        nameAnswerFormat.multipleLines = false
        let nameQuestionStepTitle = "What do you think the next comet that's discovered should be named?"
        let nameQuestionStep = ORKQuestionStep(identifier: "NameQuestionStep", title: nameQuestionStepTitle, answer: nameAnswerFormat)
        
        steps += [nameQuestionStep]
        
        let shapeQuestionStepTitle = "Which shape is the closest to the shape of Messier object 101?"
        let shapeTuples = [
            (UIImage(named: "user")!, "Square"),
            (UIImage(named: "user")!, "Pinwheel"),
            (UIImage(named: "user")!, "Pentagon"),
            (UIImage(named: "user")!, "Circle")
        ]
        let imageChoices : [ORKImageChoice] = shapeTuples.map {
            return ORKImageChoice(normalImage: $0.0, selectedImage: nil, text: $0.1, value: $0.1)
        }
        let shapeAnswerFormat: ORKImageChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithImageChoices(imageChoices)
        let shapeQuestionStep = ORKQuestionStep(identifier: "ImageChoiceQuestionStep", title: shapeQuestionStepTitle, answer: shapeAnswerFormat)
        
        steps += [shapeQuestionStep]
        
        // Date question
        let today = NSDate()
        let dateAnswerFormat =  ORKAnswerFormat.dateAnswerFormatWithDefaultDate(nil, minimumDate: today, maximumDate: nil, calendar: nil)
        let dateQuestionStepTitle = "When is the next solar eclipse?"
        let dateQuestionStep = ORKQuestionStep(identifier: "DateQuestionStep", title: dateQuestionStepTitle, answer: dateAnswerFormat)
        
        steps += [dateQuestionStep]
        
        // Boolean question
        let booleanAnswerFormat = ORKBooleanAnswerFormat()
        let booleanQuestionStepTitle = "Is Venus larger than Saturn?"
        let booleanQuestionStep = ORKQuestionStep(identifier: "BooleanQuestionStep", title: booleanQuestionStepTitle, answer: booleanAnswerFormat)
        
        steps += [booleanQuestionStep]
        
        // Continuous question
        let continuousAnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(150, minimumValue: 30, defaultValue: 20, step: 10, vertical: false, maximumValueDescription: "Objects", minimumValueDescription: " ")
        let continuousQuestionStepTitle = "How many objects are in Messier's catalog?"
        let continuousQuestionStep = ORKQuestionStep(identifier: "ContinuousQuestionStep", title: continuousQuestionStepTitle, answer: continuousAnswerFormat)
        
        
        
        steps += [continuousQuestionStep]
        
        // Summary step
        
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "Thank you."
        summaryStep.text = "We appreciate your time."
        
        steps += [summaryStep]
        
        print(steps)
        return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
    }()
}
