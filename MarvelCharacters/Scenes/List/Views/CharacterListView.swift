//
//  CharacterListView.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 17/10/20.
//

import UIKit

class CharacterListView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .black
        return collection
    }()
    
    var delegate: UICollectionViewDelegate? {
        get {
            return collectionView.delegate
        }
        set {
            collectionView.delegate = newValue
        }
    }
    
    var dataSource: UICollectionViewDataSource? {
        get {
            return collectionView.dataSource
        }
        set {
            collectionView.dataSource = newValue
        }
    }
    
    var prefetchDataSource: UICollectionViewDataSourcePrefetching? {
        get {
            return collectionView.prefetchDataSource
        }
        set {
            collectionView.prefetchDataSource = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        setupConstraints()
        registerCell(type: CharacterCollectionViewCell.self, forId: "CharacterCell")
        registerFooterView(type: LoadingFooterCollectionReusableView.self, forId: "LoadingFooter")
    }
    
    func setupConstraints() {
        collectionView
            .enableAutolayout()
            .centerX(in: self)
            .centerY(in: self)
            .width(widthAnchor)
            .height(heightAnchor)
    }
    
    func registerFooterView<View>(type: View.Type, forId id: String) where View: UICollectionReusableView {
        collectionView.register(type,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: id)
    }
    
    func registerCell<Cell>(type: Cell.Type, forId id: String) where Cell: UICollectionViewCell {
        collectionView.register(type, forCellWithReuseIdentifier: id)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
