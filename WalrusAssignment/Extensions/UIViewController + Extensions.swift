//
//  UIViewController + Extensions.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func  instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}

