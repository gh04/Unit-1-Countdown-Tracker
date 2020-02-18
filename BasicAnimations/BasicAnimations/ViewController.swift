//
//  ViewController.swift
//  BasicAnimations
//
//  Created by Gerardo Hernandez on 1/30/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var label: UILabel!
    private var stackView: UIStackView!

    //in viewDidLoad will not draw
    override func viewDidLoad() {
        super.viewDidLoad()
       configureLabel()
        configureStackView()
        configureButton()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.center = view.center
        // make a perfect circle that is outlined
        //could be useful later. not for this project
//        label.layer.cornerRadius = label.bounds.size.width / 2
    }

    private func configureLabel() {
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        view.addSubview(label)
        
        label.text = "🖕"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
        
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureButton() {
        //Rotate
        let rotateButton = UIButton(type: .system)
        rotateButton.setTitle("Rotate", for: .normal)
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(rotateButton)
        
        //Key Frames
        let keyButton = UIButton(type: .system)
        keyButton.setTitle("Key Frames", for: .normal)
        keyButton.addTarget(self, action: #selector(keyButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview( keyButton)
        //Spring
        let springButton = UIButton(type: .system)
        springButton.setTitle("Spring", for: .normal)
        springButton.addTarget(self, action: #selector(springButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview( springButton)
        //Squash
        let squashButton = UIButton(type: .system)
        squashButton.setTitle("Squash", for: .normal)
        squashButton.addTarget(self, action: #selector(squashButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview( squashButton)
        
        //Antic
        let anticButton = UIButton(type: .system)
        anticButton.setTitle("Antic", for: .normal)
        anticButton.addTarget(self, action: #selector(anticButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview( anticButton)
    }
    
    @objc private func rotateButtonTapped() {
        label.center = view.center
        //hit return when highlighted to create a closure
        UIView.animate(withDuration: 0.2, animations: {
        self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi - 0.1)
     }) { (_) in
        UIView.animate(withDuration: 0.4, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/4)
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations:  {
          self.label.transform = .identity
    }       //CG = Core Graphics
            //rotating 45 degrees half of the distance of a circle = pi
//            self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
    
            )}
        }
    }
    //pi + 0.1 would move it the oppsite direction. there is no negetive pi. `
        
        @objc private func keyButtonTapped() {
            label.center = view.center
            
            //setting the time yourelf and work with it easier than up top but lose some like corner radios
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                    self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                    self.label.transform = .identity
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                    self.label.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                    self.label.center = self.view.center
                }
            }, completion: nil)
        }
        
    @objc private func springButtonTapped() {
        label.center = view.center
        
        self.label.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        //there is no good way, it is what looks best
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.label.transform = .identity
        }, completion: nil)
    }
    
    @objc private func squashButtonTapped() {
        label.center = CGPoint(x: view.center.x, y: -label.bounds.size.height)
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.label.center = self.view.center
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                //need to use the right formula
                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.label.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            
                       UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                        self.label.transform = .identity
            }
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animBlock, completion: nil)
    }
    
    @objc private func anticButtonTapped() {
        label.center = view.center
        
        let animBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                self.label.transform = CGAffineTransform(rotationAngle:  CGFloat.pi / 16.0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                self.label.center = CGPoint(
                        x: self.view.bounds.size.width + self.label.bounds.size.width,
                        y: self.view.center.y)
            }
        }
        
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: animBlock) { didFinish in
            guard didFinish else { return }
           
            self.label.center = CGPoint(x: -self.label.bounds.size.width, y: self.view.center.y)
           
            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseOut], animations: {
                self.label.center = self.view.center
                 self.label.transform = .identity
            }, completion: nil)
        }
    }
    
}
