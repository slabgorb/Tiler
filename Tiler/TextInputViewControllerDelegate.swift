//
//  TextInputViewControllerDelegate.swift
//  Tiler
//
//  Created by Keith Avery on 4/20/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import Foundation

protocol TextInputViewControllerDelegate: class {
    func textInputViewControllerCancelButtonTapped(viewController: TextInputViewController)
    func textInputViewController(viewController: TextInputViewController, saveButtonTappedWithText text:String)
    var textInputViewController: TextInputViewController? { get set }
}

extension TextInputViewControllerDelegate {
    func removeTextInputViewController()  {
        textInputViewController?.removeFromParentViewController()
        textInputViewController?.view.removeFromSuperview()
        textInputViewController = nil
    }
}

