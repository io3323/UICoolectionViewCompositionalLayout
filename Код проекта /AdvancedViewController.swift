//
//  AdvancedLayout.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Игорь Островский on 05.10.2022.
//

import Foundation
import UIKit
class AdvancedViewController:UIViewController{
    var collectionView:UICollectionView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupCollectionView()
    }
    func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //collectionView.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.7625491023, green: 1, blue: 0.799480319, alpha: 1))
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}
//MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension AdvancedViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .gray
        cell.layer.borderWidth = 1
        return cell
    }
    
    private func createLayout() -> UICollectionViewLayout{
        //section -> group -> items -> size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(10)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
// MARK: - SwiftUI
import SwiftUI
struct AdvancedLayoutProvider:PreviewProvider{
    static var previews: some View{
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    struct ContainterView:UIViewControllerRepresentable{
        let tabBar = MainTabBarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<AdvancedLayoutProvider.ContainterView>) -> MainTabBarController{
            return tabBar
        }
        func updateUIViewController(_ uiViewController: AdvancedLayoutProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<AdvancedLayoutProvider.ContainterView>){
        }
    }
}


    
