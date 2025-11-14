//
//  BaseViewController.swift
//  sopt-37th-assignment
//
//  Created by 이나연 on 10/23/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 호출 - \(type(of: self))")

        setView()
        setAddTarget()
        setDelegate()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear 호출 - \(type(of: self))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear 호출 - \(type(of: self))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear 호출 - \(type(of: self))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear 호출 - \(type(of: self))")
    }

    func setView() {}

    func setAddTarget() {}

    func setDelegate() {}
}
