//
//  CompositionalViewController.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Игорь Островский on 04.10.2022.
//

import Foundation
import UIKit
class CompositionalViewController:UIViewController{
    enum SectionKind:Int, CaseIterable{
        case list, grid3
        var columnCount:Int{
            switch self{
            case .list:
                return 2
            case .grid3:
                return 3
            
            }
        }
    }
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>! = nil
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
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.reuseId)
        setupDataSource()
        reloudeData()
        
        
    
    }
    func configure<T: SelfConfiguringCell>(cellType:T.Type, with intValue:Int, for indexPath: IndexPath) -> T{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else{
            fatalError("Error \(cellType)")
        }
        return cell
    }
    //MARK: - Manage data in UICollectionView
    private func setupDataSource(){
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, intValue) ->
            UICollectionViewCell? in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section{
            case .list:
                return self.configure(cellType: UserCell.self, with: intValue, for: indexPath)
            case .grid3:
                return self.configure(cellType: FoodCell.self, with: intValue, for: indexPath)
            
            }
        })
    }
    func reloudeData(){
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        let itemPerSection = 10
        SectionKind.allCases.forEach { (sectionKind) in
            let itemOffSet = sectionKind.columnCount * itemPerSection
            let itemUpperBound = itemOffSet + itemPerSection
            snapshot.appendSections([sectionKind])
            snapshot.appendItems(Array(itemOffSet..<itemUpperBound), toSection: sectionKind)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    //MARK: - Setup Layout
    private func createLayout() -> UICollectionViewLayout{
        //section -> group -> items -> size
        let layout = UICollectionViewCompositionalLayout { (sectionIndex,layoutEnvirment) -> NSCollectionLayoutSection? in
            let section = SectionKind(rawValue: sectionIndex)!
            switch section{
            case .list:
                return self.createListSection()
            case .grid3:
                return self.createGridSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 50
        layout.configuration = config
        return layout
    }
    private func createListSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
        return section
    }
    private func createGridSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(104), heightDimension: .estimated(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 0, trailing: 12)
        return section
    }
}
// MARK: - SwiftUI
import SwiftUI
struct CompositionalProvider:PreviewProvider{
    static var previews: some View{
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    struct ContainterView:UIViewControllerRepresentable{
        let tabBar = MainTabBarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<CompositionalProvider.ContainterView>) -> MainTabBarController{
            return tabBar
        }
        func updateUIViewController(_ uiViewController: CompositionalProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<CompositionalProvider.ContainterView>){
        }
    }
}

