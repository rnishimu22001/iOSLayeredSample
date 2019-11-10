//
//  BranchView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/10/05.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit

final class BranchView: UIView {
    
    static let height: CGFloat = 30
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var protected: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(type(of: self).className, owner: self, options: nil)
        addSubview(view)
        view.frame = self.frame
    }
    
    func setup(_ branch: BranchDisplayData) {
        name.text = branch.name
        protected.isHidden = branch.shouldHiddenProtected
    }
}
