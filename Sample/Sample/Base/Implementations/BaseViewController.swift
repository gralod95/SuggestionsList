//
//  BaseViewController.swift
//  Sample
//
//  Created by Odinokov G. A. on 23.02.2024.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    private(set) lazy var rootView: View = .init()

    override func loadView() {
        view = rootView
    }
}
