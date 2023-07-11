//
//  RetryButton.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit

struct RetryButtonModel {
    let subtitle: String
    
    init(subtitle: String = "") {
        self.subtitle = subtitle
    }
}

protocol RetryButtonProtocol {}

extension RetryButtonProtocol where Self: UIViewController {

    private var tag: Int { -902 }
    
    func removeRetryButton() {
        let button = view.viewWithTag(tag)
        button?.removeFromSuperview()
    }
    
    @MainActor
    func showRetryButton(subtitle: String, with action: UIAction) {
        let button = RetryButton(subtitle: subtitle)
        button.addAction(action, for: .primaryActionTriggered)
        button.tag = tag
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

final class RetryButton: UIButton {
    
    init(subtitle: String) {
        super.init(frame: .zero)
        var attributedString = AttributedString(stringLiteral: .localized(.wiederholen).capitalized)
        attributedString[AttributeScopes.UIKitAttributes.FontAttribute.self] = Assets.Fonts.Semibold.body2

        configuration = .filled()
        configuration?.baseBackgroundColor = .red
        configuration?.attributedTitle = attributedString
        configuration?.titlePadding = 8
        configuration?.imagePadding = 8
        configuration?.cornerStyle = .capsule
        configuration?.subtitle = subtitle
        configuration?.image = UIImage(systemName: "arrow.clockwise")
        
        isUserInteractionEnabled = true
        isEnabled = true

        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = .infinity
        animationGroup.animations = [pulse1]

        layer.add(animationGroup, forKey: "pulse")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
