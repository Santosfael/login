//
//  UIView+extensions.swift
//  LoginDesafio
//
//  Created by Idwall Go Dev 008 on 24/03/22.
//

import UIKit

extension UIView {
    //Os 3 pontos que estão na declaração dessa função tem como objetivo receber um array de UIView
    public func addSubViews(_ subview: UIView...) {
        subview.forEach(addSubview)
    }
}
