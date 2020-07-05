//
//  DetailViewController.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/17.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
       
    var detailView: DetailViewProtocol!
    lazy var viewModel = {
        DetailViewModel(repositoryFullName: repositoryFullName)
    }()
    var repositoryFullName: String = ""
    private var cancellables: [AnyCancellable] = []
    
    override func loadView() {
        super.loadView()
        detailView = DetailPresenter(with: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = repositoryFullName
        navigationItem.backBarButtonItem?.title = ""
        sink()
        viewModel.reload()
    }
    
    private func sink() {
//        let statusCancellable = viewModel.status.sink { [weak self] status in
//            DispatchQueue.asyncAtMain {
//                self?.detailView.update(status: status)
//            }
//        }
//        let contentsCancellable = viewModel.contents.sink { [weak self] contents in
//            DispatchQueue.asyncAtMain {
//                self?.detailView.update(contents: contents)
//            }
//        }
//        cancellables.append(statusCancellable)
//        cancellables.append(contentsCancellable)
    }
}
