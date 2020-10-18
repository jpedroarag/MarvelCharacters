//
//  CharacterCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 18/10/20.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = .init(frame: .zero)
    lazy var label: UILabel = .init(frame: .zero)
    lazy var labelBackground: UIView = .init(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupColors()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(labelBackground)
        addSubview(label)
    }
    
    func setupColors() {
        backgroundColor = .clear
        imageView.backgroundColor = .systemGray
        labelBackground.backgroundColor = .white
    }
    
    func setupConstraints() {
        imageView
            .enableAutolayout()
            .filled(in: self)
        label
            .enableAutolayout()
            .left(in: labelBackground, offset: 8)
            .right(in: labelBackground, offset: -8)
            .centerY(in: labelBackground)
        labelBackground
            .enableAutolayout()
            .left(in: imageView)
            .right(in: imageView)
            .bottom(in: imageView)
            .height(imageView.heightAnchor, multiplier: 1/6)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
