//
//  AppFonts.swift
//  wgs
//
//  Created by 08APO0516 on 06/02/2017.
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import UIKit

struct AppFonts {

    struct PersonsList {
        static let firstFont      = TextStyle.h20Bold.font
        static let emailFont      = TextStyle.h15Light.font
    }

    struct PersonDetail {
        static let valueFont      = TextStyle.h18Bold.font
        static let labelFont      = TextStyle.h15LightItalic.font
        static let buttonFont     = TextStyle.h20Bold.font
    }
}

enum TextStyle {
    case dynamic(style: UIFont.TextStyle)
    case customBold (size: CGFloat)
    case customBoldItalic (size: CGFloat)
    case customBook (size: CGFloat)
    case customBookItalic (size: CGFloat)
    case customLight (size: CGFloat)
    case customLightItalic (size: CGFloat)
    case customMedium (size: CGFloat)
    case customMediumItalic (size: CGFloat)

}

enum TextStyleSize: Int {
    case h75 = 75
    case h40 = 40
    case h36 = 36
    case h28 = 28
    case h24 = 24
    case h22 = 22
    case h20 = 20
    case h18 = 18
    case h17 = 17
    case h16 = 16
    case h15 = 15
    case h14 = 14
    case h13 = 13
    case h12 = 12
    case h10 = 10
    case h6  = 6
}

extension TextStyle {

    static let body = TextStyle.dynamic(style: .body)
    //static let headline = TextStyle.customBold(size: 20, weight: UIFontWeightBold, height: 24, dropShadow: true)

    static let h75Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h36Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h24Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h24.rawValue))
    static let h20Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10Bold = TextStyle.customBold(size: CGFloat(TextStyleSize.h10.rawValue))

    static let h75Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h36Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h20Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h16Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h16.rawValue))
    static let h15Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h12Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h12.rawValue))
    static let h10Book = TextStyle.customBook(size: CGFloat(TextStyleSize.h10.rawValue))
    static let h6Book  = TextStyle.customBook(size: CGFloat(TextStyleSize.h6.rawValue))

    static let h75Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h28Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h28.rawValue))
    static let h36Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h20Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10Light = TextStyle.customLight(size: CGFloat(TextStyleSize.h10.rawValue))

    static let h75LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h28LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h28.rawValue))
    static let h36LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h20LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h17LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h10LightItalic = TextStyle.customLightItalic(size: CGFloat(TextStyleSize.h10.rawValue))

    static let h75Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h75.rawValue))
    static let h40Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h40.rawValue))
    static let h36Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h36.rawValue))
    static let h28Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h28.rawValue))
    static let h24Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h24.rawValue))
    static let h22Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h22.rawValue))
    static let h20Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h20.rawValue))
    static let h18Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h18.rawValue))
    static let h16Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h16.rawValue))
    static let h17Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h17.rawValue))
    static let h15Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h15.rawValue))
    static let h14Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h14.rawValue))
    static let h13Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h13.rawValue))
    static let h12Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h12.rawValue))
    static let h10Medium = TextStyle.customMedium(size: CGFloat(TextStyleSize.h10.rawValue))

    var font: UIFont {
        let selectedFont: UIFont?
        switch self {
        case let .dynamic(style):
            selectedFont = UIFont.preferredFont(forTextStyle: style)
        case let .customBold(size):
            selectedFont = UIFont(name: "GothamRounded-Bold", size: size) ?? nil
        case let .customBoldItalic(size):
            selectedFont = UIFont(name: "GothamRounded-BoldItalic", size: size) ?? nil
        case let .customBook(size):
            selectedFont = UIFont(name: "GothamRounded-Book", size: size) ??  nil
        case let .customBookItalic(size):
            selectedFont = UIFont(name: "GothamRounded-BookItalic", size: size) ?? nil
        case let .customLight(size):
            selectedFont = UIFont(name: "GothamRounded-Light", size: size) ?? nil
        case let .customLightItalic(size):
            selectedFont = UIFont(name: "GothamRounded-LightItalic", size: size) ?? nil
        case let .customMedium(size):
            selectedFont = UIFont(name: "GothamRounded-Medium", size: size) ?? nil
        case let .customMediumItalic(size):
            selectedFont = UIFont(name: "GothamRounded-MediumItalic", size: size) ?? nil
        }

        return selectedFont ?? UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
    }

}
