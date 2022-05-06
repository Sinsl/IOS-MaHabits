//
//  SceneDelegate.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let ws = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: ws.coordinateSpace.bounds)
        window?.windowScene = ws
        window?.tintColor = .purple
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }

    func createHabitsViewController() -> UINavigationController {

        let habitsViewController = HabitsViewController()
        habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)

    return UINavigationController(rootViewController: habitsViewController)

    }
    
    func createInfoViewController() -> UINavigationController {

        let infoViewController = InfoViewController()
        infoViewController.title = "Информация"
        infoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)

    return UINavigationController(rootViewController: infoViewController)
        
    }
    func createTabBarController() -> UITabBarController {

        let tabBarController = UITabBarController()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .systemGray6
        tabBarController.viewControllers = [createHabitsViewController(), createInfoViewController()]
    return tabBarController

    }
    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

