//
//  CustomLabel.swift
//  mm
//
//  Created by Rice Balls on 3/12/20.
//  Copyright © 2020 Rice Balls. All rights reserved.
//

import UIKit



class CustomLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel();
    }
    
    func setupLabel() {
        styleLabel();
    }
    
    private func styleLabel() {
        setShadow();
        
        layer.cornerRadius  = 5;
        layer.borderWidth = 1.0;
        layer.borderColor = UIColor.black.cgColor;
        clipsToBounds = true;
    }
    func setShadow(){
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0);
        layer.shadowRadius = 8;
        layer.shadowOpacity = 0.5;
        clipsToBounds = true;
        layer.masksToBounds = false;
    }
}
