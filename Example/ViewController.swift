//
//  ViewController.swift
//  Example
//
//  Created by Xi Chen on 16.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import UIKit
import ModernNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    private func loadData() {
        let dataProvider = GithubDataProvider()
        dataProvider.hottestRepos.bind { value in
            print(value)
        }
        dataProvider.error.bind { error in
            print(error?.localizedDescription ?? "")
        }
        dataProvider.fetchData()
    }
}

