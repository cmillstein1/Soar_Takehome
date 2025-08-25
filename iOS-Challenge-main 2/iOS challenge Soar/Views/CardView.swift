import UIKit

class CardView: UIView {
    
    // MARK: - UI Elements
    private let cardContainer = UIView()
    private let cardBackground = UIView()
    private var backgroundLayer: CAGradientLayer?
    
    // Compact content
    private let compactContent = UIView()
    private let logoView = UIView()
    private let cardNumberLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let cashbackLabel = UILabel()
    
    // Expanded content
    private let expandedContent = UIView()
    private let expandedLogoView = UIView()
    private let expandedCardNumberLabel = UILabel()
    private let expandedTitleLabel = UILabel()
    private let expandedSubtitleLabel = UILabel()
    private let detailsStackView = UIStackView()
    private let balanceLabel = UILabel()
    private let creditLabel = UILabel()
    private let paymentLabel = UILabel()
    private let aprLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    // MARK: - Animation Properties
    private var isExpanded = false
    private var expandConstraint: NSLayoutConstraint?
    private var compactConstraint: NSLayoutConstraint?
    
    // MARK: - Gesture Properties
    private var tapGesture: UITapGestureRecognizer!
    private var panGesture: UIPanGestureRecognizer!
    private var initialPanPoint: CGPoint = .zero
    private var currentPanPoint: CGPoint = .zero

    
    // MARK: - Card Data
    private let cardData: CardData
    
    // MARK: - Initialization
    init(cardData: CardData) {
        self.cardData = cardData
        super.init(frame: .zero)
        backgroundColor = .clear
        setupCard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupCard() {
        setupCardContainer()
        setupCardBackground()
        setupCompactContent()
        setupExpandedContent()
        setupGestures()
        setupHaptics()
        setupInitialAnimation()
    }
    
    private func setupCardContainer() {
        addSubview(cardContainer)
        cardContainer.translatesAutoresizingMaskIntoConstraints = false
        
        cardContainer.backgroundColor = .clear
        cardContainer.layer.cornerRadius = 20
        cardContainer.layer.borderWidth = 1.0
        cardContainer.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        cardContainer.clipsToBounds = true
        cardContainer.isOpaque = false
        
        cardContainer.pinToSuperview()
    }
    
    private func setupCardBackground() {
        cardContainer.addSubview(cardBackground)
        cardBackground.translatesAutoresizingMaskIntoConstraints = false
        
        cardContainer.sendSubviewToBack(cardBackground)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0).cgColor,
            UIColor(red: 0.6, green: 0.3, blue: 1.0, alpha: 1.0).cgColor,
            UIColor(red: 0.4, green: 0.2, blue: 0.8, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0.0, 0.6, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.opacity = 1.0
        
        cardBackground.layer.addSublayer(gradientLayer)
        cardBackground.layer.cornerRadius = 20
        cardBackground.clipsToBounds = true
        cardBackground.layer.isOpaque = false
        
        gradientLayer.cornerRadius = 20
        gradientLayer.masksToBounds = true
        
        cardBackground.alpha = 1.0
        cardBackground.isHidden = false
        cardBackground.backgroundColor = .clear
        
        backgroundLayer = gradientLayer
        
        cardBackground.pinToSuperview()
        
        DispatchQueue.main.async {
            gradientLayer.frame = self.cardBackground.bounds
        }
    }
    
    private func setupCompactContent() {
        cardContainer.addSubview(compactContent)
        compactContent.translatesAutoresizingMaskIntoConstraints = false
        
        setupLogoView()
        setupCompactLabels()
        setupCashbackLabel()
        
        compactContent.pinToSuperview(insets: UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    private func setupLogoView() {
        compactContent.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        let chaseLogoImageView = UIImageView()
        chaseLogoImageView.image = UIImage(named: "chaselogo")
        chaseLogoImageView.contentMode = .scaleAspectFit
        
        logoView.addSubview(chaseLogoImageView)
        chaseLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 80),
            logoView.heightAnchor.constraint(equalToConstant: 32),
            logoView.topAnchor.constraint(equalTo: compactContent.topAnchor),
            logoView.leadingAnchor.constraint(equalTo: compactContent.leadingAnchor),
            
            chaseLogoImageView.centerXAnchor.constraint(equalTo: logoView.centerXAnchor),
            chaseLogoImageView.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),
            chaseLogoImageView.widthAnchor.constraint(equalTo: logoView.widthAnchor, multiplier: 0.9),
            chaseLogoImageView.heightAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: 0.9)
        ])
    }
    
    private func setupCompactLabels() {
        compactContent.addSubview(cardNumberLabel)
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        cardNumberLabel.text = cardData.subtitle
        cardNumberLabel.font = .monospacedSystemFont(ofSize: 18, weight: .medium)
        cardNumberLabel.textColor = .white
        cardNumberLabel.textAlignment = .left
        
        compactContent.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = cardData.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        compactContent.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Credit Card"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        subtitleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: compactContent.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: compactContent.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: compactContent.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: compactContent.trailingAnchor),
            
            cardNumberLabel.bottomAnchor.constraint(equalTo: compactContent.bottomAnchor, constant: -8),
            cardNumberLabel.leadingAnchor.constraint(equalTo: compactContent.leadingAnchor),
            cardNumberLabel.trailingAnchor.constraint(equalTo: compactContent.trailingAnchor)
        ])
    }
    
    private func setupCashbackLabel() {
        compactContent.addSubview(cashbackLabel)
        cashbackLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cashbackLabel.text = "Cashback Rewards: $120.00"
        cashbackLabel.font = .systemFont(ofSize: 14, weight: .medium)
        cashbackLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        cashbackLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            cashbackLabel.bottomAnchor.constraint(equalTo: cardNumberLabel.topAnchor, constant: -16),
            cashbackLabel.leadingAnchor.constraint(equalTo: compactContent.leadingAnchor),
            cashbackLabel.trailingAnchor.constraint(equalTo: compactContent.trailingAnchor)
        ])
    }
    
    private func setupExpandedContent() {
        cardContainer.addSubview(expandedContent)
        expandedContent.translatesAutoresizingMaskIntoConstraints = false
        expandedContent.alpha = 0
        
        expandedContent.addSubview(expandedLogoView)
        expandedLogoView.translatesAutoresizingMaskIntoConstraints = false
        
        let expandedChaseLogoImageView = UIImageView()
        expandedChaseLogoImageView.image = UIImage(named: "chaselogo")
        expandedChaseLogoImageView.contentMode = .scaleAspectFit
        
        expandedLogoView.addSubview(expandedChaseLogoImageView)
        expandedChaseLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        expandedContent.addSubview(expandedCardNumberLabel)
        expandedCardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        expandedCardNumberLabel.text = cardData.subtitle
        expandedCardNumberLabel.font = .monospacedSystemFont(ofSize: 18, weight: .medium)
        expandedCardNumberLabel.textColor = .white
        expandedCardNumberLabel.textAlignment = .left
        
        expandedContent.addSubview(expandedTitleLabel)
        expandedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        expandedTitleLabel.text = cardData.title
        expandedTitleLabel.font = .boldSystemFont(ofSize: 20)
        expandedTitleLabel.textColor = .white
        expandedTitleLabel.textAlignment = .left
        
        expandedContent.addSubview(expandedSubtitleLabel)
        expandedSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        expandedSubtitleLabel.text = "Credit Card"
        expandedSubtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        expandedSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        expandedSubtitleLabel.textAlignment = .left
        
        setupDetailsStackView()
        setupActionButton()
        
        expandedContent.isHidden = true
        
        NSLayoutConstraint.activate([
            expandedContent.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 24),
            expandedContent.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor, constant: 24),
            expandedContent.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -24),
            expandedContent.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: -24),
            
            expandedLogoView.widthAnchor.constraint(equalToConstant: 80),
            expandedLogoView.heightAnchor.constraint(equalToConstant: 32),
            expandedLogoView.topAnchor.constraint(equalTo: expandedContent.topAnchor),
            expandedLogoView.leadingAnchor.constraint(equalTo: expandedContent.leadingAnchor),
            
            expandedChaseLogoImageView.centerXAnchor.constraint(equalTo: expandedLogoView.centerXAnchor),
            expandedChaseLogoImageView.centerYAnchor.constraint(equalTo: expandedLogoView.centerYAnchor),
            expandedChaseLogoImageView.widthAnchor.constraint(equalTo: expandedLogoView.widthAnchor, multiplier: 0.9),
            expandedChaseLogoImageView.heightAnchor.constraint(equalTo: expandedLogoView.widthAnchor, multiplier: 0.9),
            
            expandedTitleLabel.topAnchor.constraint(equalTo: expandedLogoView.bottomAnchor, constant: 24),
            expandedTitleLabel.leadingAnchor.constraint(equalTo: expandedContent.leadingAnchor),
            expandedTitleLabel.trailingAnchor.constraint(equalTo: expandedContent.trailingAnchor),
            
            expandedSubtitleLabel.topAnchor.constraint(equalTo: expandedTitleLabel.bottomAnchor, constant: 4),
            expandedSubtitleLabel.leadingAnchor.constraint(equalTo: expandedContent.leadingAnchor),
            expandedSubtitleLabel.trailingAnchor.constraint(equalTo: expandedContent.trailingAnchor),
            
            expandedCardNumberLabel.bottomAnchor.constraint(equalTo: expandedContent.bottomAnchor, constant: -8),
            expandedCardNumberLabel.leadingAnchor.constraint(equalTo: expandedContent.leadingAnchor),
            expandedCardNumberLabel.trailingAnchor.constraint(equalTo: expandedContent.trailingAnchor)
        ])
        
        cardContainer.bringSubviewToFront(expandedContent)
    }
    
    private func setupDetailsStackView() {
        expandedContent.addSubview(detailsStackView)
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 12
        detailsStackView.distribution = .fillEqually
        
        balanceLabel.text = "Balance: $2,847.32"
        balanceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        balanceLabel.textColor = .white
        
        creditLabel.text = "Available Credit: $7,152.68"
        creditLabel.font = .systemFont(ofSize: 16, weight: .medium)
        creditLabel.textColor = .white
        
        paymentLabel.text = "Next Payment: Dec 15"
        paymentLabel.font = .systemFont(ofSize: 16, weight: .medium)
        paymentLabel.textColor = .white
        
        aprLabel.text = "APR: 16.99%"
        aprLabel.font = .systemFont(ofSize: 16, weight: .medium)
        aprLabel.textColor = .white
        
        detailsStackView.addArrangedSubview(balanceLabel)
        detailsStackView.addArrangedSubview(creditLabel)
        detailsStackView.addArrangedSubview(paymentLabel)
        detailsStackView.addArrangedSubview(aprLabel)
        
        NSLayoutConstraint.activate([
            detailsStackView.topAnchor.constraint(equalTo: expandedSubtitleLabel.bottomAnchor, constant: 24),
            detailsStackView.leadingAnchor.constraint(equalTo: expandedContent.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: expandedContent.trailingAnchor),
            detailsStackView.bottomAnchor.constraint(lessThanOrEqualTo: expandedCardNumberLabel.topAnchor, constant: -16)
        ])
    }
    
    private func setupActionButton() {
        expandedContent.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        actionButton.setTitle("View Transactions", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        actionButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        actionButton.layer.cornerRadius = 12
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 24),
            actionButton.leadingAnchor.constraint(equalTo: expandedContent.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: expandedContent.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.bottomAnchor.constraint(lessThanOrEqualTo: expandedCardNumberLabel.topAnchor, constant: -16)
        ])
    }
    
    private func setupGestures() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    private func setupHaptics() {
        // Haptics are now handled by UIView extensions
    }
    
    private func setupInitialAnimation() {
        cardBackground.alpha = 1.0
        cardBackground.isHidden = false
        
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        animateWithSpring(duration: 0.8, damping: 0.8, velocity: 0.5, delay: 0.1) {
            self.transform = .identity
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateCompactElementsEntrance()
        }
    }
    
    private func animateCompactElementsEntrance() {
        let elements = [logoView, titleLabel, subtitleLabel, cashbackLabel, cardNumberLabel]
        UIView.animateElementsEntrance(elements)
    }
    
    @objc private func handleTap() {
        toggleExpansion()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            initialPanPoint = gesture.location(in: self)
            currentPanPoint = initialPanPoint
            
        case .changed:
            currentPanPoint = gesture.location(in: self)
            let deltaY = currentPanPoint.y - initialPanPoint.y
            
            if deltaY < 0 && !isExpanded {
                let progress = min(abs(deltaY) / 100, 1.0)
                updateExpansionProgress(progress)
            } else if deltaY > 0 && isExpanded {
                let progress = max(1.0 - (deltaY / 100), 0.0)
                updateCollapseProgress(progress)
            }
            
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: self)
            let deltaY = currentPanPoint.y - initialPanPoint.y
            
            resetVisualState()
            
            if isExpanded {
                expandConstraint?.isActive = true
                compactConstraint?.isActive = false
            } else {
                expandConstraint?.isActive = false
                compactConstraint?.isActive = true
            }
            
            if abs(velocity.y) > 500 {
                if velocity.y < 0 && !isExpanded {
                    expandCard()
                } else if velocity.y > 0 && isExpanded {
                    collapseCard()
                }
            } else if abs(deltaY) > 50 {
                if deltaY < 0 && !isExpanded {
                    expandCard()
                } else if deltaY > 0 && isExpanded {
                    collapseCard()
                }
            } else {
                if isExpanded {
                    expandCard()
                } else {
                    collapseCard()
                }
            }
            
        default:
            break
        }
    }
    
    private func toggleExpansion() {
        if isExpanded {
            collapseCard()
        } else {
            expandCard()
        }
    }
    
    private func expandCard() {
        guard !isExpanded else { return }
        
        isExpanded = true
        triggerMediumHaptic()
        
        expandedContent.isHidden = false
        expandedContent.alpha = 0
        expandedContent.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        let heightAnimation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9) {
            self.expandConstraint?.isActive = true
            self.compactConstraint?.isActive = false
            self.layoutIfNeeded()
        }
        
        let contentAnimation = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.9) {
            self.compactContent.alpha = 0
            self.compactContent.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            
            self.expandedContent.alpha = 1
            self.expandedContent.transform = .identity
        }
        
        let elementsAnimation = UIViewPropertyAnimator(duration: 0.6, dampingRatio: 0.9) {
            self.animateExpandedElementsEntrance()
        }
        
        heightAnimation.startAnimation()
        contentAnimation.startAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            elementsAnimation.startAnimation()
        }
    }
    
    private func collapseCard() {
        guard isExpanded else { return }
        
        isExpanded = false
        triggerLightHaptic()
        
        let heightAnimation = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9) {
            self.expandConstraint?.isActive = false
            self.compactConstraint?.isActive = true
            self.layoutIfNeeded()
        }
        
        let contentAnimation = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.9) {
            self.compactContent.alpha = 1
            self.compactContent.transform = .identity
            
            self.expandedContent.alpha = 0
            self.expandedContent.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
        contentAnimation.addCompletion { _ in
            self.expandedContent.isHidden = true
        }
        
        heightAnimation.startAnimation()
        contentAnimation.startAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateCompactElementsCollapse()
        }
    }
    
    private func updateExpansionProgress(_ progress: CGFloat) {
        let scale = 0.9 + (0.1 * progress)
        let alpha = progress
        
        expandedContent.transform = CGAffineTransform(scaleX: scale, y: scale)
        expandedContent.alpha = alpha
        
        compactContent.alpha = 1.0 - (alpha * 0.3)
        
        let compactScale = 1.0 - (0.05 * progress)
        compactContent.transform = CGAffineTransform(scaleX: compactScale, y: compactScale)
    }
    
    private func updateCollapseProgress(_ progress: CGFloat) {
        let scale = 1.0 - (0.1 * progress)
        let alpha = 1.0 - progress
        
        compactContent.transform = CGAffineTransform(scaleX: scale, y: scale)
        compactContent.alpha = alpha
        
        
        expandedContent.alpha = 1.0 - (progress * 0.3)
        
        let expandedScale = 0.9 + (0.05 * progress)
        expandedContent.transform = CGAffineTransform(scaleX: expandedScale, y: expandedScale)
        
        if progress > 0.1 {
            cardContainer.bringSubviewToFront(compactContent)
        } else {
            cardContainer.bringSubviewToFront(expandedContent)
        }
    }
    
    private func resetVisualState() {
        if isExpanded {
            expandedContent.alpha = 1
            expandedContent.transform = .identity
            compactContent.alpha = 0
            compactContent.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            
            cardContainer.bringSubviewToFront(expandedContent)
        } else {
            expandedContent.alpha = 0
            expandedContent.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            compactContent.alpha = 1
            compactContent.transform = .identity
            
            cardContainer.bringSubviewToFront(compactContent)
        }
        
        cardBackground.alpha = 1.0
        cardBackground.isHidden = false
    }
    
    private func animateExpandedElementsEntrance() {
        let elements = [expandedLogoView, expandedCardNumberLabel, expandedTitleLabel, expandedSubtitleLabel, detailsStackView, actionButton]
        UIView.animateElementsEntrance(elements, duration: 0.5, delay: 0.06)
    }
    
    private func animateCompactElementsCollapse() {
        let elements = [logoView, titleLabel, subtitleLabel, cashbackLabel, cardNumberLabel]
        UIView.animateElementsCollapse(elements)
    }
    
    @objc private func actionButtonTapped() {
        triggerMediumHaptic()
        
        UIView.animate(withDuration: 0.1, animations: {
            self.actionButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.actionButton.transform = .identity
            })
        }
        
        print("Action button tapped!")
    }
    
    // MARK: - Layout Updates
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer = backgroundLayer {
            gradientLayer.frame = cardBackground.bounds
        }
    }
    
    // MARK: - Public Interface
    func setHeightConstraints(compact: NSLayoutConstraint, expanded: NSLayoutConstraint) {
        self.compactConstraint = compact
        self.expandConstraint = expanded
    }
    
    // MARK: - Cleanup
    deinit {
        // Cleanup if needed
    }
}


