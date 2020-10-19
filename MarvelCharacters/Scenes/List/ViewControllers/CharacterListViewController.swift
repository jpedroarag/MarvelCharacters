//
//  CharacterListViewController.swift
//  MarvelCharacters
//
//  Created by João Pedro Aragão on 15/10/20.
//

import UIKit

protocol CharacterListViewDelegate {
    
    func reloadScene()
    func updateScene(with indexes: [Int])
    func reloadScene(with indexes: [Int])
    
}

class CharacterListViewController: UIViewController {
    
    let viewModel: CharacterListViewModelType
    let listView: CharacterListView
    
    init(view: CharacterListView = .init(), viewModel: CharacterListViewModelType) {
        self.listView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.viewDelegate = self
    }

    override func loadView() {
        listView.dataSource = self
        listView.delegate = self
        listView.prefetchDataSource = self
        view = listView
    }
    
    required init?(coder: NSCoder) {
        self.listView = CharacterListView()
        self.viewModel = CharacterListViewModel(with: .init())
        super.init(coder: coder)
    }

}

extension CharacterListViewController: UICollectionViewDataSource,
                                       UICollectionViewDataSourcePrefetching,
                                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalOfItems
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCollectionViewCell else {
            return .init()
        }
        cell.configure(index: indexPath.item, withInfoFrom: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let contains = indexPaths.contains {
            $0.item >= viewModel.numberOfItems
        }
        if contains {
            viewModel.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter else { fatalError("Unspected element kind") }
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "LoadingFooter",
                                                                     for: indexPath)
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insetsValue: CGFloat = 24
        let width: CGFloat = UIScreen.main.bounds.width/2 - insetsValue
        let height: CGFloat = 256
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 64
        return CGSize(width: width, height: height)
    }
    
}

extension CharacterListViewController: CharacterListViewDelegate {
    
    private func mappedIndexes(_ array: [Int]) -> [IndexPath] {
        return array.map {
            IndexPath(item: $0, section: 0)
        }
    }
    
    func reloadScene() {
        listView.collectionView.reloadData()
    }
    
    func updateScene(with indexes: [Int]) {
        listView.collectionView.insertItems(at: mappedIndexes(indexes))
    }
    
    func reloadScene(with indexes: [Int]) {
        listView.collectionView.reloadItems(at: mappedIndexes(indexes))
    }
    
}
