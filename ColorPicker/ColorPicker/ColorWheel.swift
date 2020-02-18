//
//  ColorWheel.swift
//  ColorPicker
//
//  Created by Gerardo Hernandez on 2/5/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class ColorWheel: UIView {

    // MARK: Properties
    var brightness: CGFloat = 0.8 {
        didSet {
            //the view is redrawn
            setNeedsDisplay()
        }
    }
    
    // MARK: - View Lifecycles
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        isUserInteractionEnabled = false
        
        clipsToBounds = true
        let radius = frame.width / 2.0
        //to get a circle
        layer.cornerRadius = radius
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    //implementing our own draw method. Not calling it self (super.init)
    override func draw(_ rect: CGRect) {
        //dont set it to .1 because it will take too long to draw. Will take up too much CPU and not build. 1 is fine. But 1 takes too long in the app to load the brightness. Tinker with the number
        let size: CGFloat = 4
        //for every pixel in the y direction
        for y in stride(from: 0, through: bounds.maxY, by: size) {
            for x in stride(from: 0, through: bounds.maxX, by: size) {
                let color = self.color(for: CGPoint(x: x, y: y))
                let pixel = CGRect(x: x, y: y, width: size, height: size)
                //painting.
                color.set()
                
                UIRectFill(pixel)
            }
        }
    }
    func color(for location: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let dy = location.y - center.y
        let dx = location.x - center.x
        let offset = CGPoint(x: dx / center.x, y: dy / center.y)
        let (hue, saturation) = Color.getHueSaturation(at: offset)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}
// Important to keep in mind because the view is redrawing each pixel as the slider moves
//core graphics CPU
//core animations GPU
