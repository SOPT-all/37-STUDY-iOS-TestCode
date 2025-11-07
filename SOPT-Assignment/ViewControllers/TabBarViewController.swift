//
//  TabBarViewController.swift
//  SOPT-Assignment
//
//  Created by 이승준 on 11/7/25.
//

import UIKit
import Then

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let firstTabBar = BaeminFeedViewController()
        firstTabBar.tabBarItem = UITabBarItem(title: "홈", image: .homeSelected, tag: 0)
        
        let secondTabBar = UINavigationController(rootViewController: UIViewController().then { $0.view.backgroundColor = .red} )
        secondTabBar.tabBarItem = UITabBarItem(title: "장보기·쇼핑", image: .shop, tag: 1)
        
        let thirdTabBar = UINavigationController(rootViewController: UIViewController().then { $0.view.backgroundColor = .orange} )
        thirdTabBar.tabBarItem = UITabBarItem(title: "찜", image: .heart, tag: 2)
        
        let forthTabBar = UINavigationController(rootViewController: UIViewController().then { $0.view.backgroundColor = .yellow} )
        forthTabBar.tabBarItem = UITabBarItem(title: "주문내역", image: .list, tag: 3)
        
        let fifthTabBar = UINavigationController(rootViewController: UIViewController().then { $0.view.backgroundColor = .green} )
        fifthTabBar.tabBarItem = UITabBarItem(title: "마이배민", image: .myPage, tag: 4)
        
        //탭바컨트롤러에 뷰 컨트롤러를 array형식으로 넣어주면 탭바가 완성됩니다.
        self.viewControllers = [firstTabBar, secondTabBar, thirdTabBar, forthTabBar, fifthTabBar]
    }
}
