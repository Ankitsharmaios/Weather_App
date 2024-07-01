//
//  EditImageVC+Draw.swift
//  WhatsappPhoto
//
//  Created by PC on 26/09/22.
//

import Foundation
import UIKit

extension EditImageVC {
    
    override public func touchesBegan(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            swiped = false
            if let touch = touches.first {
                lastPoint = touch.location(in: self.canvasImageView)
                print("touchesBegan",lastPoint)
//                lines.append([CGPoint]())
                arrLinesModel.append(.init(point: [CGPoint](), color: [drawColor]))
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            // 6
            swiped = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: canvasImageView)
                //                guard let point = touches.first?.location(in: canvasImageView) else { return }
                
//                guard var lastLine = lines.popLast() else { return }
//
//                lastLine.append(currentPoint)
//                lines.append(lastLine)
                
                let lastLine1 = arrLinesModel.removeLast()
                guard var points = lastLine1.point, var colors = lastLine1.color else { return }
                points.append(currentPoint)
                colors.append(self.drawColor)
                arrLinesModel.append(PointModel(point: points, color: colors))
                
                DispatchQueue.main.async {
                    self.drawLineFrom()
                }
                // 7
                lastPoint = currentPoint
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            if !swiped {
                // draw a single point
                DispatchQueue.main.async {
                    self.drawLineFrom(self.lastPoint, toPoint: self.lastPoint)
                }
            }
        }
    }
    
    func drawLineFrom(_ fromPoint: CGPoint = CGPoint.zero, toPoint: CGPoint = CGPoint.zero) {
        // 1
        let canvasSize = canvasImageView.frame.integral.size
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        canvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))
        
        context.setLineCap( CGLineCap.round)
        context.setLineWidth(4.0)
        context.setBlendMode( CGBlendMode.normal)
        
        for i in arrLinesModel {
            guard let point = i.point, let color = i.color else { return }
            for (indx,j) in point.enumerated() {
                if indx == 0 {
                    context.move(to: j)
                    context.setStrokeColor(color[indx].cgColor)
                } else {
                    context.addLine(to: j)
                    context.setStrokeColor(color[indx].cgColor)
                }
            }
            context.strokePath()
        }
        
        canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        canvasImageView.setNeedsDisplay()
    }
    
//    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
//        // 1
//        let canvasSize = canvasImageView.frame.integral.size
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
//        if let context = UIGraphicsGetCurrentContext() {
//            canvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))
//            // 2
////            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
////            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
////            context.setStrokeColor(UIColor.red.cgColor)
////            context.setLineWidth(10)
////            context.setLineCap(.butt)
//
//            lines.forEach { (line) in
//                for (i, p) in line.enumerated() {
//                    if i == 0 {
//                        context.move(to: p)
//                    } else {
//                        context.addLine(to: p)
//                    }
//                }
//            }
//
//            // 3
//            context.setLineCap( CGLineCap.round)
//            context.setLineWidth(4.0)
//            context.setStrokeColor(drawColor.cgColor)
//            context.setBlendMode( CGBlendMode.normal)
//            // 4
//            context.strokePath()
//            // 5
//            canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
//        }
//        UIGraphicsEndImageContext()
//        canvasImageView.setNeedsDisplay()
//    }
    
}
