//
//  Extenstion+UIButtons.swift
//  ReminderApp
//
//  Created by 강한결 on 7/2/24.
//

import UIKit

extension UIButton.Configuration {
    static func addButtonImpl(_ title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        
        config.title = title
        config.image = UIImage(systemName: "plus.circle")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .systemGreen
        
        return config
    }
}
