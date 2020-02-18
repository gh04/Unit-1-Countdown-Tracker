//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Gerardo Hernandez on 2/5/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit
@IBDesignable
class ColorPicker: UIControl {

 // MARK: - Properties
    
    var color: UIColor = .white
    var colorWheel = ColorWheel()
    var brightnessSlider = UISlider()
    
    //iniilized in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    //gets instaistated from the storyboderd. Must do it to work with the storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        backgroundColor = .clear
        
        // Color Wheel
        colorWheel.translatesAutoresizingMaskIntoConstraints = false
        //must add this before constraints or app will crash
        addSubview(colorWheel)
        //setting the constraints to the color wheel inside the view. settings its contraints to that view
        NSLayoutConstraint.activate([
            colorWheel.topAnchor.constraint(equalTo: topAnchor),
            colorWheel.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorWheel.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorWheel.heightAnchor.constraint(equalTo: colorWheel.widthAnchor)
        ])
        //Brightness Slider
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(brightnessSlider)
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 1
        //default value
        brightnessSlider.value = 0.8
        
        brightnessSlider.addTarget(self, action: #selector(changeBrightness), for: .valueChanged)
        //we dont have to worry about height because slider has instriscit height
        NSLayoutConstraint.activate([
            brightnessSlider.topAnchor.constraint(equalTo: colorWheel.bottomAnchor, constant: 8),
            brightnessSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            brightnessSlider.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        ])
        
    }
    
    @objc func changeBrightness() {
        colorWheel.brightness = CGFloat(brightnessSlider.value)
        
    }
    
    // MARK: - Touch Tracking
    
    //when user touches the screen within the view. Even if they swipe into the view. It has to begin in the view.
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        color = colorWheel.color(for: touchPoint)
        //inform any objects that are connected to our view that an action occured
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    //
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        //test to see if that point is in our view
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
            
        }
        return true
    }
    
    //
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        //taking care of depencies before moving on to logic
        defer { super.endTracking(touch, with: event) }
        
        guard let touch = touch else { return }
        
        // Logic
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    //
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
    
    

}
