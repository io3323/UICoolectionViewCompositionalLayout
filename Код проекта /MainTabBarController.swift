import Foundation
import UIKit
class MainTabBarController:UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let flowViewController = FlowViewController()
        let compositionalViewController = CompositionalViewController()
        let advansedLayoutViewController = AdvancedViewController()
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        let carImage = UIImage(systemName: "car", withConfiguration: boldConfig)!
        viewControllers = [
            generateNavigationController(rootViewController: compositionalViewController, title: "Compositional", image: convImage),
            generateNavigationController(rootViewController: flowViewController, title: "Flow", image: peopleImage),
            generateNavigationController(rootViewController: advansedLayoutViewController, title: "Advanced", image: carImage)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image:UIImage) -> UIViewController{
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.image = image
        return navigationVC
    }
}
