//
//  Entity.swift
//  Finch
//
//  Created by Captain Kidd on 06.07.2021.
//

import Foundation
import UIKit

struct Element {
    var image: UIImage
    var title: String
    var description: String
}

class ElementEntity {
    static let sharedEntity = ElementEntity()
    
    var elements: [Element] = []
}
