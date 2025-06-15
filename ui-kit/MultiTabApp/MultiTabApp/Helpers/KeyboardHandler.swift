//
//  KeyboardHandler.swift
//  MultiTabApp
//
//  Created by Lukasz Fabia on 15/06/2025.
//

import Foundation
import UIKit

/// Responsible for hiding and showing keyboard
class KeyboardHandler {
    private struct Config {
        let duration: Double
        let keyboardHeight: CGFloat
    }
    
    var animationBody: (_ height: CGFloat) -> Void
    
    init(fn: @escaping (_ height: CGFloat) -> Void) {
        self.animationBody = fn
        setupNotifications()
    }
   
//    init(contentViewBottom: NSLayoutConstraint, view: UIView) {
//        self.contentViewBottom = contentViewBottom
//        self.currentView = view
//    }
    
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func willHide(notification: Notification){
        // get info and then setup animation
        guard let config = retrieve(from: notification) else {return}
        
        
        UIView.animate(withDuration: config.duration) {
            self.animationBody(config.keyboardHeight)
        }
    }
    
    @objc func willShow(notification: Notification){
        guard let config = retrieve(from: notification) else {return}
        
        
        UIView.animate(withDuration: config.duration) {
            self.animationBody(0)
        }
    }
    
    private func retrieve(from notification: Notification) -> Config? {
        // get user info
        guard let userInfo = notification.userInfo else {return nil}
        
        // get keyboard props
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return nil}
        
        // get animation duration
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else {return nil}
        
        return Config(duration: duration, keyboardHeight: keyboardFrame.height)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
