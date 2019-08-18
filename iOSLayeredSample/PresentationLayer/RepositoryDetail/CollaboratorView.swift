//
//  CollaboratorView.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/18.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Nuke

final class CollaboratorView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var admin: UILabel!
    
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
    
    func setup(_ colloaborator: CollaboratorDisplayable) {
        Nuke.loadImage(with: colloaborator.icon, into: icon)
        name.text = colloaborator.name
        admin.isHidden = !colloaborator.hasAdminBadge
    }
}
