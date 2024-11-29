//
//  ColorTypeConverter.swift
//  Sample_AR-GunMan_Replace
//
//  Created by ウルトラ深瀬 on 10/11/24.
//

import UIKit

final class ColorTypeConverter {
    static func fromColorType(_ colorType: ColorType) -> UIColor {
        switch colorType {
        case .red:
            return .systemRed
        case .green:
            return .systemGreen
        }
    }
}
