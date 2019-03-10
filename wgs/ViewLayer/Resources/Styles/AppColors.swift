//
//  AppColors.swift
//  wgs
//
//  Created by Alejandro Fornés Gandía on 02/02/2017.
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import UIKit.UIColor

// App Colors

struct AppColors {

    struct Interface {
        static let Grey = UIColor(rgbaValue: 0x888888FF)            //#colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        static let LightGrey = UIColor(rgbaValue: 0xf8f8f8FF)       //#colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        static let GreyDark = UIColor(rgbaValue: 0x2C2C2CFF)        //#colorLiteral(red: 0.2274459004, green: 0.2274520993, blue: 0.2274487615, alpha: 1)
        static let MediumGrey = UIColor(rgbaValue: 0x9b9b9bFF)      //#colorLiteral(red: 0.6712639928, green: 0.6712799668, blue: 0.6712713838, alpha: 1)
        static let MediumLightGrey = UIColor(rgbaValue: 0xDDDDDDFF) //#colorLiteral(red: 0.8926324248, green: 0.8926534057, blue: 0.8926420808, alpha: 1)
        static let White = UIColor(rgbaValue: 0xFFFFFFFF)           //#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let Black = UIColor(rgbaValue: 0x000000ff)           //#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let Brown = UIColor(rgbaValue: 0xC48764ff)           //#colorLiteral(red: 0.768627451, green: 0.5294117647, blue: 0.3921568627, alpha: 1)
        static let BrownDark = UIColor(rgbaValue: 0x986638ff)       //#colorLiteral(red: 0.5960784314, green: 0.4, blue: 0.2196078431, alpha: 1)
        static let Crimsom = UIColor(rgbaValue: 0xce2124ff)         //#colorLiteral(red: 0.8078431373, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        static let BrownNavigation = UIColor(rgbaValue: 0x986638ff) //#colorLiteral(red: 0.5960784314, green: 0.4, blue: 0.2196078431, alpha: 1)
        static let Water = UIColor(rgbaValue: 0x5085DEff)           //#colorLiteral(red: 0.3093082607, green: 0.6018980742, blue: 0.8968223333, alpha: 1)
        static let Foam = UIColor(rgbaValue: 0xf1debcff)           //#colorLiteral(red: 0.9575889707, green: 0.8937497735, blue: 0.7838762403, alpha: 1)
        static let Coffee = UIColor(rgbaValue: 0x814127ff)         //#colorLiteral(red: 0.5824688077, green: 0.3278023005, blue: 0.2013338208, alpha: 1)
        static let WhiteBroken = UIColor(rgbaValue: 0xf7f6f3ff)     //#colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9529411765, alpha: 1)
        static let LightBrown = UIColor(rgbaValue: 0xd9cbacff)
        static let WhiteStained = UIColor(rgbaValue: 0xefefefFF)
        static let Clear = UIColor.clear
        static let Cement = UIColor(rgbaValue: 0x949493FF)
        static let Blue = UIColor(rgbaValue: 0x007AFFFF)
        static let Red = UIColor(rgbaValue: 0xff0000ff)
    }

    // MARK: - PersonsList
    struct PersonsList {
        static let FirstFontColor   = AppColors.Interface.White
        static let EmailFontColor   = AppColors.Interface.White
        static let Background       = AppColors.Interface.Black
        static let TitleFontColor   = AppColors.Interface.White
    }

    // MARK: - PersonDetail
    struct PersonDetail {
        static let FontColor                = AppColors.Interface.White
        static let Background               = AppColors.Interface.Black
        static let ButtonBackgroundColor    = AppColors.Interface.Red
    }
}

typealias Color = UIColor

extension Color {
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

enum ColorName {
    case coffee
    case water

    var rgbaValue: UInt32 {
        switch self {
        case .coffee:
            return 0x321914
        case .water:
            return 0xc48764
        }
    }

    var color: Color {
        return Color(named: self)
    }
}
// swiftlint:enable type_body_length

extension Color {
    convenience init(named name: ColorName) {
        self.init(rgbaValue: name.rgbaValue)
    }
}
