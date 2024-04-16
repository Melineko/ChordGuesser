//
//  ShapeArcView.swift
//  chordsGuesser
//
//  Created by Melissa Briere on 14/02/2024.
//

import UIKit

class ArcView : UIView {

override func draw(_ rect: CGRect) {
    super.draw(rect)
    let path = createArc(rect: rect)
    let fillColor = UIColor(red: 186/255, green: 164/255, blue: 171/255, alpha: 1)
    fillColor.setFill()
    path.fill()
}
private func createArc(rect : CGRect) -> UIBezierPath {
    let path: UIBezierPath = UIBezierPath()
    
    let start = CGPoint(x:0, y:rect.height)
    let end = CGPoint(x:rect.width, y:rect.height)
    let controlPointA = CGPoint(x:rect.width/6.6, y:0)
    let controlPointB = CGPoint(x:rect.width-(rect.width/6.6), y:0)
    
    
    // drawing curve form
    path.move(to: start)
    path.addCurve(to: end, controlPoint1: controlPointA, controlPoint2: controlPointB)
    path.close()
    
    return path
}
}
