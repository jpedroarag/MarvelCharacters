//
//  LoadingFooterCollectionReusableView.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 18/10/20.
//

import UIKit

class LoadingFooterCollectionReusableView: UICollectionReusableView {
        
    lazy var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        setupConstraints()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func setupConstraints() {
        activityIndicator
            .enableAutolayout()
            .filled(in: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
