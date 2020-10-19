//
//  ImageTableViewCell.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 19/10/20.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    lazy var customImageView = UIImageView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupColors()
        setupImage()
        addSubview(customImageView)
        setupConstraints()
    }
    
    func setupColors() {
        backgroundColor = .clear
    }
    
    func setupImage() {
        customImageView.contentMode = .scaleAspectFill
        customImageView.clipsToBounds = true
    }
    
    func setupConstraints() {
        customImageView
            .enableAutolayout()
            .top(in: self, offset: 0)
            .left(in: self)
            .right(in: self)
            .bottom(in: self)
            .height(UIScreen.main.bounds.height/2.5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
