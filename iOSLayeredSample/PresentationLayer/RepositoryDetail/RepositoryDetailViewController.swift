//
//  RepositoryDetailViewController.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {
       
    var presenter: RepositoryDetailPresenterProtocol!
    // var viewModel: RepositorySearchListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = RepositoryDetailPresenter(with: view)
    }
}
