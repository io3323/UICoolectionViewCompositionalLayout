//
//  ViewController.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Игорь Островский on 04.10.2022.
//

import UIKit

class FlowViewController: UIViewController {
    var collectionView:UICollectionView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupCollectionView()
    }

    func setupCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //collectionView.backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.7625491023, green: 1, blue: 0.799480319, alpha: 1))
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}
extension FlowViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
extension FlowViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
}
// MARK: - SwiftUI
import SwiftUI
struct FlowProvider:PreviewProvider{
    static var previews: some View{
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    struct ContainterView:UIViewControllerRepresentable{
        let tabBar = MainTabBarController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> MainTabBarController{
            return tabBar
        }
        func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>){
        }
    }
}
