//
//  LoadingView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    static let height: CGFloat = 100
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        self.addSubview(view)
        view.frame.origin = .zero
        view.frame.size = self.frame.size
    }
}
