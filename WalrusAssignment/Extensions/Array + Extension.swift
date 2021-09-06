//
//  Array + Extension.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
