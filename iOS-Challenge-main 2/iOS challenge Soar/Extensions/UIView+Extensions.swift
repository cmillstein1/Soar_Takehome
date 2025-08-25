//
//  UIView+Extensions.swift
//  Soar iOS challenge
//
//  Created by Stanley Virgint on 8/22/25.
//

import UIKit

// MARK: - Spring Animation Extensions
extension UIView {
    
    func animateWithSpring(
        duration: TimeInterval = 0.5,
        damping: CGFloat = 0.8,
        velocity: CGFloat = 0.5,
        delay: TimeInterval = 0,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: damping,
            initialSpringVelocity: velocity,
            options: [.curveEaseOut],
            animations: animations,
            completion: completion
        )
    }
    
    func animateWithSpring(
        duration: TimeInterval = 0.5,
        damping: CGFloat = 0.8,
        velocity: CGFloat = 0.5,
        delay: TimeInterval = 0,
        animations: @escaping () -> Void
    ) {
        animateWithSpring(
            duration: duration,
            damping: damping,
            velocity: velocity,
            delay: delay,
            animations: animations,
            completion: nil
        )
    }
}

// MARK: - Constraint Setup Extensions
extension UIView {
    
    func pinToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
        ])
    }
    
    func pinToSuperview(padding: CGFloat) {
        pinToSuperview(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }
    
    func centerInSuperview() {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}

// MARK: - Animation Sequence Extensions
extension UIView {
    
    static func animateElementsStaggered(
        _ elements: [UIView],
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.05,
        damping: CGFloat = 0.9,
        velocity: CGFloat = 0.3,
        transform: CGAffineTransform = CGAffineTransform(translationX: 0, y: 10),
        animations: @escaping (UIView) -> Void = { _ in }
    ) {
        for (index, element) in elements.enumerated() {
            element.animateWithSpring(
                duration: duration,
                damping: damping,
                velocity: velocity,
                delay: delay * Double(index)
            ) {
                element.transform = .identity
                animations(element)
            }
        }
    }
    
    static func animateElementsEntrance(
        _ elements: [UIView],
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.08,
        damping: CGFloat = 0.9,
        velocity: CGFloat = 0.3
    ) {
        for (index, element) in elements.enumerated() {
            element.alpha = 0
            element.transform = CGAffineTransform(translationX: 0, y: 10)
            
            element.animateWithSpring(
                duration: duration,
                damping: damping,
                velocity: velocity,
                delay: delay * Double(index)
            ) {
                element.alpha = 1
                element.transform = .identity
            }
        }
    }
    
    static func animateElementsCollapse(
        _ elements: [UIView],
        duration: TimeInterval = 0.4,
        delay: TimeInterval = 0.05,
        damping: CGFloat = 0.8,
        velocity: CGFloat = 0.5
    ) {
        for (index, element) in elements.enumerated() {
            element.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            
            element.animateWithSpring(
                duration: duration,
                damping: damping,
                velocity: velocity,
                delay: delay * Double(index)
            ) {
                element.transform = .identity
            }
        }
    }
}

// MARK: - View Styling Extensions
extension UIView {
    
    func styleAsCard(
        cornerRadius: CGFloat = 20,
        borderWidth: CGFloat = 1.0,
        borderColor: UIColor = UIColor.white.withAlphaComponent(0.3),
        shadowColor: UIColor = .black,
        shadowOffset: CGSize = CGSize(width: 0, height: 8),
        shadowRadius: CGFloat = 20,
        shadowOpacity: Float = 0.3
    ) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        clipsToBounds = false
    }
    
    func applyGradientBackground(
        colors: [UIColor],
        locations: [NSNumber] = [0.0, 1.0],
        startPoint: CGPoint = CGPoint(x: 0, y: 0),
        endPoint: CGPoint = CGPoint(x: 1, y: 1)
    ) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        DispatchQueue.main.async {
            gradientLayer.frame = self.bounds
        }
    }
}

// MARK: - Haptic Feedback Extensions
extension UIView {
    
    func triggerLightHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
    }
    
    func triggerMediumHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        haptic.impactOccurred()
    }
    
    func triggerHeavyHaptic() {
        let haptic = UIImpactFeedbackGenerator(style: .heavy)
        haptic.impactOccurred()
    }
}
