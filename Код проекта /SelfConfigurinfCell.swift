//
//  SelfConfigurinfCell.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Игорь Островский on 05.10.2022.
//

import Foundation
import UIKit
protocol SelfConfiguringCell{
    static var reuseId:String {get}
    func configure(with intValue:Int)
}
