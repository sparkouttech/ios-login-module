//
//  UIViewController+Nib.swift
//  LoginModule
//
//  Created by Keerthi on 04/09/21.
//

import UIKit

public extension UIViewController {

    func viewFromNib(optionalName: String? = nil) -> UIView {
        let name = optionalName ?? String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        return view
    }
    
}
