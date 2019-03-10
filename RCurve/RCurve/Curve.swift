//
//  Curve.swift
//  RCurve
//
//  Created by Sandeep Joshi on 9/15/18.
//  Copyright © 2018 Sandeep Joshi. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class Curve: UIView {

    override func awakeFromNib() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawShape()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawShape()
    }
    
    var meetingDuration : Int = 90
    var dragAngle : CGFloat = 0.0
    
    let clayer = CAShapeLayer()
    
    var angle = 0.0
    var radius = 140
    
    var lpath = UIBezierPath()
    
    let masterTLayer = CAShapeLayer()
    let backLayer = CAShapeLayer()
    
    var rangle = 0.0
    
    var layerToRotate = CAShapeLayer()
    
    func drawShape() {
        
//        for i in 0..<14 {
//            let pangle = ((Double(i) * 15.0) * .pi ) / 180.0
//            radius = radius - 10
//            let path = UIBezierPath(arcCenter: CGPoint(x: clayer.bounds.midX, y: clayer.bounds.midY), radius: CGFloat(radius), startAngle: CGFloat(3 * .pi / 4 + pangle), endAngle:  CGFloat(pangle) - .pi / 4, clockwise: true)
//
//            lpath.append(path)
//
//        }
        
        lpath = UIBezierPath(arcCenter: CGPoint(x: clayer.bounds.midX, y: clayer.bounds.midY), radius: layer.bounds.width / 2 - 5, startAngle: CGFloat(0.0), endAngle: CGFloat(.pi * 2.0), clockwise: true)
        
        let mpath = UIBezierPath(arcCenter: CGPoint(x: clayer.bounds.midX, y: clayer.bounds.midY), radius: layer.bounds.width / 3 - 5, startAngle: CGFloat(0.0), endAngle: CGFloat(.pi * 2.0), clockwise: true)
        
        let mlayer = CAShapeLayer()
        mlayer.path = mpath.cgPath
        
//        mlayer.fillColor = UIColor(red: 211/255.0, green: 84/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        mlayer.fillColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1).cgColor
        mlayer.shadowOpacity = 1.0
        mlayer.shadowRadius = 4.0
        mlayer.shadowOffset = CGSize.zero
        mlayer.opacity = 0.5
        mlayer.shadowColor = UIColor.black.cgColor
//        mlayer.shadowColor = UIColor(red: 29/255.0, green: 131/255.0, blue: 72/255.0, alpha: 1).cgColor
        
        mlayer.shadowPath = UIBezierPath(arcCenter: CGPoint(x: clayer.bounds.midX, y: clayer.bounds.midY), radius: layer.bounds.width / 3 - 5, startAngle: CGFloat(0.0), endAngle: CGFloat(.pi * 2.0), clockwise: true).cgPath
        
        clayer.path = lpath.cgPath
        
        clayer.shadowColor = UIColor.black.cgColor
        clayer.shadowOffset = CGSize.zero
        clayer.shadowRadius = 4.0
        clayer.shadowPath = UIBezierPath(arcCenter: CGPoint(x: clayer.bounds.midX, y: clayer.bounds.midY), radius: layer.bounds.width / 2 - 5, startAngle: CGFloat(0.0), endAngle: CGFloat(.pi * 2.0), clockwise: true).cgPath
        clayer.shadowOpacity = 1.0
        clayer.masksToBounds = false
        
        clayer.name = "Clayer"
        mlayer.name = "Mlayer"
        
        layer.addSublayer(clayer)
        layer.addSublayer(mlayer)
        clayer.position = CGPoint(x: layer.bounds.size.width/2, y: layer.bounds.height/2)
        mlayer.position = CGPoint(x: layer.bounds.size.width/2, y: layer.bounds.height/2)
        self.masterTLayer.position = layer.position
        typealias Point = (Int, Int)
        let origin: Point = (0, 0)
        self.masterTLayer.frame = CGRect(x: 0, y: 0, width: layer.bounds.width, height: layer.bounds.height)
        
        
        
       
        self.backLayer.position = layer.position
        self.backLayer.frame = CGRect(x: 0, y: 0, width: layer.bounds.width, height: layer.bounds.height)
        
        
        // Adding texts in a circular fashion for the clock
        var startAngle: CGFloat = -90
        
        let angle_text : [String] = ["24","21","18","15","12","9","6","3"]
        
        
        
        for i in 0..<8 {

            let hourLayer = CATextLayer()
            hourLayer.string = angle_text[i]
            hourLayer.foregroundColor = UIColor(red: 255/255, green: 224/255.0, blue: 49/255.0, alpha: 1).cgColor
            let angle = (startAngle * .pi) / 180.0
            hourLayer.position = CGPoint(x: clayer.position.x + (80 * cos(angle)) - 9, y: clayer.position.y + (80 * sin(angle))-9)
            hourLayer.frame = CGRect(x: hourLayer.position.x, y: hourLayer.position.y, width: 18, height: 18)
            hourLayer.opacity = 1.0
            hourLayer.fontSize = 12.0
            hourLayer.font = UIFont.boldSystemFont(ofSize: 12.0)
            hourLayer.contentsScale = UIScreen.main.scale
            hourLayer.cornerRadius = 9.0
//            hourLayer.backgroundColor = UIColor.red.cgColor
            hourLayer.alignmentMode = CATextLayerAlignmentMode.center
            let rotationAngle = ((startAngle) * .pi)/180.0
            hourLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
            self.masterTLayer.addSublayer(hourLayer)
            startAngle = startAngle - 45
        }
        
        layer.addSublayer(self.masterTLayer)
        layer.addSublayer(self.backLayer)
        
        startAngle = -90
        
        for i in 0..<8 {
            
            let hourLayer = CATextLayer()
            hourLayer.string = angle_text[i]
            hourLayer.foregroundColor = UIColor(red: 0/255, green: 128/255.0, blue: 0/255.0, alpha: 1).cgColor
            let angle = (startAngle * .pi) / 180.0
            hourLayer.position = CGPoint(x: clayer.position.x + (130 * cos(angle)) - 9, y: clayer.position.y + (130 * sin(angle))-9)
            hourLayer.frame = CGRect(x: hourLayer.position.x, y: hourLayer.position.y, width: 18, height: 18)
            hourLayer.opacity = 1.0
            hourLayer.fontSize = 12.0
            hourLayer.font = UIFont.boldSystemFont(ofSize: 12.0)
            hourLayer.contentsScale = UIScreen.main.scale
            hourLayer.cornerRadius = 9.0
            let rotationAngle = ((startAngle) * .pi)/180.0
            hourLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 1)
//            hourLayer.backgroundColor = UIColor.red.cgColor
            hourLayer.alignmentMode = CATextLayerAlignmentMode.center
            self.backLayer.addSublayer(hourLayer)
            startAngle = startAngle - 45
        }
        
        let durationInMins = CGFloat(self.meetingDuration)
        let rotationAngle = durationInMins * 360.0 / 1440
        
        let angles = [-90 + rotationAngle, -90 - rotationAngle]
        
        for angle in angles {
            let lineLayer = CAShapeLayer()
            let semiPath = UIBezierPath()
//            let angle = CGFloat(-90)
            semiPath.move(to: CGPoint(x: clayer.position.x + (30 * cos(angle * .pi / 180.0)), y: clayer.position.y + (30 * sin(angle * .pi / 180.0)) ))
            semiPath.addLine(to: CGPoint(x: clayer.position.x + (140 * cos(angle * .pi / 180.0)), y: clayer.position.y + (140 * sin(angle * .pi / 180.0)) ))
            
            lineLayer.path = semiPath.cgPath
            lineLayer.strokeColor = UIColor.blue.cgColor
            lineLayer.lineWidth = 1.5
            lineLayer.lineDashPattern = [2.0, 6.0]
            lineLayer.lineCap = .round
            lineLayer.shadowColor = UIColor.black.cgColor
            lineLayer.shadowOffset = CGSize.zero
            lineLayer.shadowRadius = 16.0
            lineLayer.shadowOpacity = 1.0
            lineLayer.shadowPath = semiPath.cgPath
            self.layer.addSublayer(lineLayer)
        }
        
        
        
        
        
        
        
//        let txtlayer = CATextLayer()
//        txtlayer.string = "12"
//        txtlayer.foregroundColor = UIColor.black.cgColor
//
//        txtlayer.position = CGPoint(x: mlayer.position.x, y: mlayer.position.y)
//        txtlayer.frame = CGRect(x: txtlayer.position.x, y: txtlayer.position.y, width: 25, height: 25)
//        txtlayer.opacity = 1.0
//        txtlayer.fontSize = 22.0
//        txtlayer.contentsScale = UIScreen.main.scale
//        txtlayer.backgroundColor = UIColor.cyan.cgColor
//        layer.addSublayer(txtlayer)
//        txtlayer.transform = CATransform3DMakeRotation(.pi/4, 0, 0, 1)
        
        
        
        clayer.fillColor = UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1).cgColor
//        clayer.fillColor = UIColor.white.cgColor
        clayer.strokeColor = UIColor.clear.cgColor
        clayer.opacity = 0.6
        clayer.transform = CATransform3DMakeRotation(0.0, 0, 0, 1)
        
        
//        let sectorLayer = CAShapeLayer()
//        let sectorPath = UIBezierPath(arcCenter: CGPoint(x: layer.frame.width/2, y: layer.frame.height/2), radius: 100, startAngle: CGFloat(0.0), endAngle:.pi/2.0, clockwise: false)
//        sectorLayer.path = sectorPath.cgPath
//        sectorLayer.fillColor = UIColor.cyan.cgColor
//        sectorLayer.opacity = 0.4
//
////        self.layer.addSublayer(sectorLayer)
    }
    

    
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.isRemovedOnCompletion = false
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as! CAAnimationDelegate
        }
        
        clayer.add(rotateAnimation, forKey: nil)
    }
    
    
    
    func rotate() {
        
//        self.masterTLayer.transform = CATransform3DMakeRotation(CGFloat(rangle), 0.0, 0.0, 1.0)
        self.backLayer.transform = CATransform3DMakeRotation(0.0, 0.0, 0.0, 1.0)
    }

}


class RotationGestureRecognizer : UIPanGestureRecognizer {
    
    private(set) var touchAngle : CGFloat = 0
    var diff : CGFloat = 0
    var layerName : String = String()
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        
        maximumNumberOfTouches = 1
        minimumNumberOfTouches = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        let ang = updateAngle(with: touches)
        touchAngle = ang
        
        let touch = touches.first
        
        guard let point = touch?.location(in: self.view) else { return }
        guard let sublayers = self.view?.layer.sublayers as? [CAShapeLayer] else { return }
        
        
        
        for layer in sublayers{
            if layer.path == nil {
                continue
            }
            
            if (layer.path?.contains((self.view!.layer.convert(point, to: layer))))! {
                self.layerName = layer.name!
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let ang = updateAngle(with: touches)
        self.diff = touchAngle - ang
        touchAngle = ang
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        let ang = updateAngle(with: touches)
        self.diff = touchAngle - ang
        touchAngle = ang
    }
    
    private func updateAngle(with touches: Set<UITouch>) -> CGFloat {
        guard
            let touch = touches.first,
            let view = view
        else {
            return 0
        }
        
        let touchPoint = touch.location(in: view)
        return angle(for: touchPoint, in: view)
        
    }
    
    private func angle(for point: CGPoint, in view: UIView) -> CGFloat {
        let centerOffset = CGPoint(x: point.x - view.bounds.midX, y: point.y - view.bounds.midY)
        return atan2(centerOffset.y, centerOffset.x)
    }
}
