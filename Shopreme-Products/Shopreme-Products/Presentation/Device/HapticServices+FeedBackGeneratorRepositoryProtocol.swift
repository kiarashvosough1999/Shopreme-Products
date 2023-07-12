//
//  HapticServices+FeedBackGeneratorProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/12/23.
//

import UIKit

protocol FeedBackGeneratorProtocol {
    func generateSuccessFeedBack()
    func generateWarningFeedBack()
    func generateErrorFeedBack()
    func generateImapctFeedBack()
}

extension HapticServices: FeedBackGeneratorProtocol {

    private var notificationGenerator: UINotificationFeedbackGenerator {
        UINotificationFeedbackGenerator()
    }

    func generateSuccessFeedBack() {
        notificationGenerator.notificationOccurred(.success)
    }
    
    func generateWarningFeedBack() {
        notificationGenerator.notificationOccurred(.warning)
    }
    
    func generateErrorFeedBack() {
        notificationGenerator.notificationOccurred(.error)
    }
    
    func generateImapctFeedBack() {
        let notificationGenerator = UIImpactFeedbackGenerator(style: .light)
        notificationGenerator.impactOccurred()
    }
}
