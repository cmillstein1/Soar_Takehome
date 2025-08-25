//
//  MainViewController.swift
//  Soar iOS challenge
//
//  Created by Stanley Virgint on 8/22/25.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    private var cardView: CardView!
    private let backgroundGradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupBackground()
        setupCardView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradientLayer.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setupViewController() {
        view.backgroundColor = .clear
        title = "Wallet"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    private func setupBackground() {
        backgroundGradientLayer.colors = [
            UIColor.systemIndigo.cgColor,
            UIColor.systemPurple.cgColor,
            UIColor.systemBlue.cgColor
        ]
        backgroundGradientLayer.locations = [0.0, 0.5, 1.0]
        backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
        
        addBackgroundElements()
    }
    
    private func addBackgroundElements() {
        for i in 0..<5 {
            let circle = createFloatingCircle()
            view.insertSubview(circle, at: 1)
            
            // Animate parallax motion
            UIView.animate(withDuration: Double.random(in: 3...6), delay: Double(i) * 0.5, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
                circle.transform = CGAffineTransform(translationX: CGFloat.random(in: -50...50), y: CGFloat.random(in: -30...30))
            })
        }
    }
    
    private func createFloatingCircle() -> UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        circle.layer.cornerRadius = CGFloat.random(in: 20...60)
        
        let size = CGFloat.random(in: 40...120)
        circle.frame = CGRect(
            x: CGFloat.random(in: 0...view.bounds.width),
            y: CGFloat.random(in: 100...view.bounds.height - 200),
            width: size,
            height: size
        )
        
        return circle
    }
    
    private func setupCardView() {
        cardView = CardView(cardData: CardData.sample)
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 8)
        cardView.layer.shadowRadius = 20
        cardView.layer.shadowOpacity = 0.3
        
        let compactHeight: CGFloat = 280
        let expandedHeight: CGFloat = 480
        
        let compactConstraint = cardView.heightAnchor.constraint(equalToConstant: compactHeight)
        compactConstraint.isActive = true
        
        let expandedConstraint = cardView.heightAnchor.constraint(equalToConstant: expandedHeight)
        expandedConstraint.isActive = false
        
        cardView.setHeightConstraints(compact: compactConstraint, expanded: expandedConstraint)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        addInstructionLabel()
    }
    
    private func addInstructionLabel() {
        let instructionLabel = UILabel()
        instructionLabel.text = "👆 Tap to expand • 👆 Swipe up/down • 👇 Long press for haptics"
        instructionLabel.font = .systemFont(ofSize: 16, weight: .medium)
        instructionLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        instructionLabel.textAlignment = .center
        instructionLabel.numberOfLines = 0
        
        view.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 32),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        instructionLabel.alpha = 0
        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
            instructionLabel.alpha = 1
        })
    }
}


