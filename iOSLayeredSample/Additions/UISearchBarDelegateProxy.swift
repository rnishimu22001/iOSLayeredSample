//
//  UISearchBarDelegateProxy.swift
//  iOSLayeredSample
//
//  Created by rnishimu on 2019/08/24.
//  Copyright © 2019 rnishimu22001. All rights reserved.
//

import UIKit
import Combine
import Foundation

protocol UISearchBarDelegateProxyInterface: UISearchBarDelegate {
    var textDidEndEditing: CurrentValueSubject<String?, Never> { get }
}

final class UISearchBarDelegateProxy: NSObject, UISearchBarDelegateProxyInterface {
    let textDidEndEditing: CurrentValueSubject<String?, Never> = .init(nil)
}
extension UISearchBarDelegateProxy: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        textDidEndEditing.value = searchBar.text
    }
}
