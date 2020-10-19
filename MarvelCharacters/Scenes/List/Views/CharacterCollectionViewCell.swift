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
        label.round(radius: 5)
        imageView.contentMode = .scaleAspectFill
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
        label.textColor = UIColor.appText
        label.backgroundColor = UIColor.appLoadingBackground
        imageView.backgroundColor = UIColor.appLoadingBackground
        labelBackground.backgroundColor = UIColor.appTextBackground
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
            .height(labelBackground.heightAnchor, multiplier: 1/2)
        labelBackground
            .enableAutolayout()
            .left(in: imageView)
            .right(in: imageView)
            .bottom(in: imageView)
            .height(imageView.heightAnchor, multiplier: 1/6)
    }
    
    func configure(index: Int, withInfoFrom viewModel: CharacterListDataSourceType) {
        let text = viewModel.itemFor(index: index)
        let image = viewModel.getImage(for: index)
        round(radius: 5)
        label.backgroundColor = (text == "") ? .systemGray : .clear
        label.text = text
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
