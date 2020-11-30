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
    let circleRadius = (Macro_ScreenWidth-30)/2
    var duration : Double = 0.0
    let daySecion : Double = 86400;
    
    lazy var centerPoint : CGPoint = {
        return CGPoint(x: self.frame.size.width/2 , y: self.frame.size.height/2)
    }()
    
    lazy var startAngle : CGFloat = {
        let scale : CGFloat = CGFloat(86400 - self.duration) / 86400 * 360 - 90
        let result : CGFloat = CGFloat(scale) * .pi / 180
        return result
    }()
    
    lazy var strokeIt : CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = self.duration
        return animation
    }()
    
    lazy var circleBgLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(white: 0.6, alpha: 0.1).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineCap = .round
        return shapeLayer
    }()
    
    lazy var timeCountBgLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineCap = .round
        return shapeLayer
    }()
    
    lazy var timeCountLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineCap = .round
        shapeLayer.add(self.strokeIt, forKey: nil)
        return shapeLayer
    }()
    
    init(frame: CGRect, duration: Double)
    {
        // calls designated initializer
        super.init(frame: frame)
        self.duration = duration
        self.backgroundColor = .clear
        
        layer.addSublayer(circleBgLayer)
        layer.addSublayer(timeCountBgLayer)
        layer.addSublayer(timeCountLayer)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        updateCircleBgLayer()
        updateTimeCountBgLayer()
        updateTimeCountLayer()
    }
    
    private func updateCircleBgLayer()
    {
        circleBgLayer.path = UIBezierPath(arcCenter: centerPoint,
                                          radius: circleRadius,
                                          startAngle: -90.degreesToRadians,
                                          endAngle: 270.degreesToRadians,
                                          clockwise: true).cgPath
    }
    
    private func updateTimeCountBgLayer()
    {
        timeCountBgLayer.path = UIBezierPath(arcCenter: centerPoint,
                                          radius: circleRadius,
                                          startAngle: -90.degreesToRadians,
                                          endAngle: self.startAngle,
                                          clockwise: true).cgPath
    }
    
    private func updateTimeCountLayer()
    {
        timeCountLayer.path = UIBezierPath(arcCenter: centerPoint,
                                           radius: circleRadius,
                                           startAngle: self.startAngle,
                                           endAngle: 270.degreesToRadians,
                                           clockwise: true).cgPath
    }
    
    private func durationConvertToRadians(_duration : Double) -> Double
    {
        return (_duration/86400 * 360 - 90) * .pi / 180
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
