//
//  PageDelegateHandler.swift
//  ChainAnimationForm
//
//  Created by Samuel Hyeman on 21/07/2021.
//

import Foundation
import UIKit

protocol PageDelegate {
    func next(child: UIViewController)
    func previous(child: UIViewController)
}
