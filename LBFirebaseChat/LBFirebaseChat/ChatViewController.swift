//
//  ChatViewController.swift
//  LBFirebaseChat
//
//  Created by Wira on 10/2/16.
//  Copyright © 2016 Wira. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    // MARK: Properties
    let rootRef = Firebase(url: "https://wirasetiawan29.firebaseio.com/")
    var messageRef: Firebase!
    var messages = [JSQMessage]()
    
    var userIsTypingRef: Firebase!
    var usersTypingQuery: FQuery!
    private var localTyping = false
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBubbles()
        messageRef = rootRef.childByAppendingPath("chat")
        
        // No avatars
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        observeMessages()
        
        
//        // messages from someone else
//        addMessage("foo", text: "Hey person!")
//        // messages sent from local sender
//        addMessage(senderId, text: "Yo!")
//        addMessage(senderId, text: "I like turtles!")
//        // animates the receiving of a new message on the view
//        finishReceivingMessage()
        
        observeTyping()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId { // 1
            cell.textView!.textColor = UIColor.whiteColor() // 2
        } else {
            cell.textView!.textColor = UIColor.blackColor() // 3
        }
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    private func observeMessages() {
        // 1
        print(messageRef)
        let messagesQuery = messageRef.queryLimitedToLast(25)
        
//        messageRef.observeEventType(.ChildAdded, withBlock: { snapshot in
//            print(snapshot.value.objectForKey("senderId"))
//            let id = snapshot.value["senderId"] as! String
//            print(id)
//            
//            print(snapshot.value.objectForKey("text"))
//        })
        
        // 2
        messagesQuery.observeEventType(.ChildAdded) { (snapshot: FDataSnapshot!) in
            // 3
//            let time = snapshot.value["formattedTime"] as! String
//            let timeStamp = snapshot.value["timestamp"] as! NSNumber
//            let userId = snapshot.value["userId"] as! NSNumber
            let id = snapshot.value["name"] as! String
            let text = snapshot.value["message"] as! String
            
            
//            let id = snapshot.value["senderId"] as! String
//            let text = snapshot.value["text"] as! String
            
            // 4
            self.addMessage(id, text: text)
            
            // 5
            self.finishReceivingMessage()
        }
    }
    
    private func observeTyping() {
        let typingIndicatorRef = rootRef.childByAppendingPath("typingIndicator")
        userIsTypingRef = typingIndicatorRef.childByAppendingPath(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqualToValue(true)
        
        usersTypingQuery.observeEventType(.Value) { (data: FDataSnapshot!) in
            
            // You're the only typing, don't show the indicator
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            
            // Are there others typing?
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottomAnimated(true)
        }
        
    }
    
    func addMessage(id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message)
    }
    
    override func textViewDidChange(textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        isTyping = textView.text != ""
    }
    
    
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        let itemRef = messageRef.childByAutoId() // 1
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        formatter.AMSymbol = "AM"
        formatter.PMSymbol = "PM"
        let hour = formatter.stringFromDate(NSDate())
        
        var timestamps: NSNumber {
            return NSDate().timeIntervalSince1970 * 1000
        }
        
        let timeStamp: Int = Int(timestamps)
        
        print(hour)
        print(timeStamp)
        
        let messageItem = [ // 2
            "formattedTime" : hour,
            "timestamp": timeStamp,
            "message": text,
            "name": senderId,
            "userId" : 29
            
        ]
        itemRef.setValue(messageItem) // 3
        
        // 4
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 5
        finishSendingMessage()
        isTyping = false
    }
    
    private func setupBubbles() {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = bubbleImageFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = bubbleImageFactory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    }
    
}