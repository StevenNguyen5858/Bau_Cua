//
//  CustomButton.swift
//  mm
//
//  Created by Rice Balls on 3/11/20.
//  Copyright © 2020 Rice Balls. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton();
        addActionToButton()
    }
    
    func setupButton() {
        styleButton();
    }
    
    private func styleButton() {
        setShadow();
        setTitleColor(.white, for: .normal);
        
        //titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 15);
        layer.cornerRadius = 10;
        layer.borderWidth = 3.0;
        layer.borderColor = UIColor.init(red: 0.05, green: 0.05, blue: 0.05, alpha: 1).cgColor;
        
    }
    private func setShadow(){
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0);
        layer.shadowRadius = 8;
        layer.shadowOpacity = 0.5;
        clipsToBounds = true;
        layer.masksToBounds = false;
    }
    
    func shakeButton() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1;
        shake.repeatCount = 2;
        shake.autoreverses = true;
        
        let fromPoint = CGPoint(x: center.x - 0, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func addActionToButton() {
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside);
    }
    @objc func buttonTapped() {
        shakeButton();
    }
}
