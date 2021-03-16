//
//  UIViewControllerExtensions.swift
//  HabitsRN
//
//  Created by Matthew Hall on 2/26/21.
//
//  Extends UIViewController class
//  Creates static method that creates an instance of itself
//      and loads the .xib files with it.

import UIKit

extension UIViewController {
    static func instaniate() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}


