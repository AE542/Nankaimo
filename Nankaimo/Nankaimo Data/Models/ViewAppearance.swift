//
//  ViewAppearance.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2022/12/11.
//

import UIKit


struct BackgroundColor {
    func setGradientBackground(view: UIView) {
        let colour1 = UIColor(hex: 0x5F7BCF).cgColor //remember hexidecimal # can be written as 0x
        let colour2 = UIColor(hex: 0x5C93D6).cgColor
        let colour3 = UIColor(hex: 0x3F9FD0).cgColor
        let colour4 = UIColor(hex: 0x1EB2CE).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colour1, colour2, colour3, colour4]
        
        gradientLayer.locations = [0.2, 0.4, 0.6, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
