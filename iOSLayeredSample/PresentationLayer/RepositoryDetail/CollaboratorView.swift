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
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var admin: UILabel!
    
    func setup(_ colloaborator: CollaboratorDisplayable) {
        Nuke.loadImage(with: colloaborator.icon, into: icon)
        name.text = colloaborator.name
        admin.isHidden = !colloaborator.hasAdminBadge
    }
}
