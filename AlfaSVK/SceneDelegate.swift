//
//  SceneDelegate.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            
            let navigationController = UINavigationController()
            let assemblyBuilder = AssemblyModuleBuilder()
            let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
            router.initialStartVC()
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}
