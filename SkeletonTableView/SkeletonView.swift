//
//  SkeletonView.swift
//  SkeletonTableView
//
//  Created by Aleksei Tsyss on 7/9/21.
//

import UIKit

class SkeletonView: UIView {
    var startLocations : [NSNumber] = [-1.0,-0.5, 0.0]
    var endLocations : [NSNumber] = [1.0,1.5, 2.0]
    
    var gradientBackgroundColor : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
    var gradientMovingColor : CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
    
    var movingAnimationDuration : CFTimeInterval = 0.8
    var delayBetweenAnimationLoops : CFTimeInterval = 1.0
    
    lazy var gradientLayer : CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [
            gradientBackgroundColor,
            gradientMovingColor,
            gradientBackgroundColor
        ]
        gradientLayer.locations = self.startLocations
        self.layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = self.startLocations
        animation.toValue = self.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }
    
    func stopAnimating() {
        self.gradientLayer.removeAllAnimations()
    }
}

class SkeletonLayer: CAGradientLayer {
    struct Configuration {
        let gradientBackgroundColor: UIColor
        let gradientMovingColor: UIColor
        let movingAnimationDuration: CFTimeInterval
        let delayBetweenAnimationLoops: CFTimeInterval
        
        static let `default` = Configuration(
            gradientBackgroundColor: UIColor(red: 237, green: 237, blue: 237),
            gradientMovingColor: UIColor(red: 246, green: 246, blue: 246),
            movingAnimationDuration: 0.8, delayBetweenAnimationLoops: 1.0
        )
    }
    
    private static let startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    private static let endLocations: [NSNumber] = [1.0, 1.5, 2.0]
    
    let gradientBackgroundColor: CGColor
    let gradientMovingColor: CGColor
    
    let movingAnimationDuration: CFTimeInterval
    let delayBetweenAnimationLoops: CFTimeInterval
    
    convenience init(frame: CGRect, cornerRadius: CGFloat = 0, configuration: Configuration = .default) {
        self.init(configuration: configuration)
        self.frame = frame
        self.cornerRadius = cornerRadius
    }
    
    init(configuration: Configuration) {
        gradientBackgroundColor = configuration.gradientBackgroundColor.cgColor
        gradientMovingColor = configuration.gradientMovingColor.cgColor
        
        movingAnimationDuration = configuration.movingAnimationDuration
        delayBetweenAnimationLoops = configuration.delayBetweenAnimationLoops
        
        super.init()
        
        startPoint = CGPoint(x: 0.0, y: 1.0)
        endPoint = CGPoint(x: 1.0, y: 1.0)
        
        colors = [
            gradientBackgroundColor,
            gradientMovingColor,
            gradientBackgroundColor
        ]
        
        locations = SkeletonLayer.startLocations
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = SkeletonLayer.startLocations
        animation.toValue = SkeletonLayer.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        add(animationGroup, forKey: animation.keyPath)
    }
    
    func stopAnimating() {
        removeAllAnimations()
    }
}
