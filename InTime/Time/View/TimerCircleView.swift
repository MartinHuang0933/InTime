//
//  TimerCircleView.swift
//  InTime
//
//  Created by Mac on 2020/11/19.
//  Copyright © 2020 Martin. All rights reserved.
//

import UIKit

class TimerCircleView: UIView
{
    let circleBgLayer = CAShapeLayer()
    let timeCountLayer = CAShapeLayer()
    let circleRadius = (Macro_ScreenWidth-30)/2
    
    
    override init(frame: CGRect)
    {
        // calls designated initializer
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupCircleBgLayer()
        setupTimeCountLayer()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        updateCircleBgLayer()
        updateTimeCountLayer()
    }
    
    lazy var strokeIt : CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 60
        return animation
    }()
    
    private func setupCircleBgLayer()
    {
        circleBgLayer.strokeColor = UIColor.orange.cgColor
        circleBgLayer.fillColor = UIColor.clear.cgColor
        circleBgLayer.lineWidth = 12
        layer.addSublayer(circleBgLayer)
    }
    
    private func setupTimeCountLayer()
    {
        timeCountLayer.strokeColor = UIColor.red.cgColor
        timeCountLayer.fillColor = UIColor.clear.cgColor
        timeCountLayer.lineWidth = 12
        timeCountLayer.add(strokeIt, forKey: nil)
        layer.addSublayer(timeCountLayer)
    }
    
    private func updateCircleBgLayer()
    {
        let centerPoint = CGPoint(x: self.frame.size.width/2 , y: self.frame.size.height/2)
        circleBgLayer.path = UIBezierPath(arcCenter: centerPoint,
                                          radius: circleRadius,
                                          startAngle: -90.degreesToRadians,
                                          endAngle: 270.degreesToRadians,
                                          clockwise: true).cgPath
    }
    
    private func updateTimeCountLayer()
    {
        let centerPoint = CGPoint(x: self.frame.size.width/2 , y: self.frame.size.height/2)
        timeCountLayer.path = UIBezierPath(arcCenter: centerPoint,
                                           radius: circleRadius,
                                           startAngle: -90.degreesToRadians,
                                           endAngle: 270.degreesToRadians,
                                           clockwise: true).cgPath
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
