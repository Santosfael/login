//
//  ViewCode.swift
//  LoginDesafio
//
//  Created by Idwall Go Dev 008 on 24/03/22.
//

import UIKit

protocol ViewCode {
    func buildHierarchy()
    func setupConstraints()
    func applyAdditionalChanges()
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        setupConstraints()
        applyAdditionalChanges()
    }
}
