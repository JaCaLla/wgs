//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.font` struct is generated, and contains static references to 8 fonts.
  struct font: Rswift.Validatable {
    /// Font `GothamRounded-BoldItalic`.
    static let gothamRoundedBoldItalic = Rswift.FontResource(fontName: "GothamRounded-BoldItalic")
    /// Font `GothamRounded-Bold`.
    static let gothamRoundedBold = Rswift.FontResource(fontName: "GothamRounded-Bold")
    /// Font `GothamRounded-BookItalic`.
    static let gothamRoundedBookItalic = Rswift.FontResource(fontName: "GothamRounded-BookItalic")
    /// Font `GothamRounded-Book`.
    static let gothamRoundedBook = Rswift.FontResource(fontName: "GothamRounded-Book")
    /// Font `GothamRounded-LightItalic`.
    static let gothamRoundedLightItalic = Rswift.FontResource(fontName: "GothamRounded-LightItalic")
    /// Font `GothamRounded-Light`.
    static let gothamRoundedLight = Rswift.FontResource(fontName: "GothamRounded-Light")
    /// Font `GothamRounded-MediumItalic`.
    static let gothamRoundedMediumItalic = Rswift.FontResource(fontName: "GothamRounded-MediumItalic")
    /// Font `GothamRounded-Medium`.
    static let gothamRoundedMedium = Rswift.FontResource(fontName: "GothamRounded-Medium")
    
    /// `UIFont(name: "GothamRounded-Bold", size: ...)`
    static func gothamRoundedBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedBold, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-BoldItalic", size: ...)`
    static func gothamRoundedBoldItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedBoldItalic, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-Book", size: ...)`
    static func gothamRoundedBook(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedBook, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-BookItalic", size: ...)`
    static func gothamRoundedBookItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedBookItalic, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-Light", size: ...)`
    static func gothamRoundedLight(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedLight, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-LightItalic", size: ...)`
    static func gothamRoundedLightItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedLightItalic, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-Medium", size: ...)`
    static func gothamRoundedMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedMedium, size: size)
    }
    
    /// `UIFont(name: "GothamRounded-MediumItalic", size: ...)`
    static func gothamRoundedMediumItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: gothamRoundedMediumItalic, size: size)
    }
    
    static func validate() throws {
      if R.font.gothamRoundedBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-Bold' could not be loaded, is 'GothamRounded-Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedBoldItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-BoldItalic' could not be loaded, is 'GothamRounded-BoldItalic.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedBook(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-Book' could not be loaded, is 'GothamRounded-Book.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedBookItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-BookItalic' could not be loaded, is 'GothamRounded-BookItalic.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedLight(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-Light' could not be loaded, is 'GothamRounded-Light.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedLightItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-LightItalic' could not be loaded, is 'GothamRounded-LightItalic.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-Medium' could not be loaded, is 'GothamRounded-Medium.otf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.gothamRoundedMediumItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'GothamRounded-MediumItalic' could not be loaded, is 'GothamRounded-MediumItalic.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `default_profile`.
    static let default_profile = Rswift.ImageResource(bundle: R.hostingBundle, name: "default_profile")
    
    /// `UIImage(named: "default_profile", bundle: ..., traitCollection: ...)`
    static func default_profile(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.default_profile, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 5 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `ActionPersonTVC`.
    static let actionPersonTVC: Rswift.ReuseIdentifier<ActionPersonTVC> = Rswift.ReuseIdentifier(identifier: "ActionPersonTVC")
    /// Reuse identifier `AttributePersonTVC`.
    static let attributePersonTVC: Rswift.ReuseIdentifier<AttributePersonTVC> = Rswift.ReuseIdentifier(identifier: "AttributePersonTVC")
    /// Reuse identifier `ImagePersonTVC`.
    static let imagePersonTVC: Rswift.ReuseIdentifier<ImagePersonTVC> = Rswift.ReuseIdentifier(identifier: "ImagePersonTVC")
    /// Reuse identifier `MapPersonTVC`.
    static let mapPersonTVC: Rswift.ReuseIdentifier<MapPersonTVC> = Rswift.ReuseIdentifier(identifier: "MapPersonTVC")
    /// Reuse identifier `PeopleListTVC`.
    static let peopleListTVC: Rswift.ReuseIdentifier<PeopleListTVC> = Rswift.ReuseIdentifier(identifier: "PeopleListTVC")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 15 localization keys.
    struct localizable {
      /// Value: < Back
      static let person_detail_back = Rswift.StringResource(key: "person_detail_back", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Camera
      static let person_detail_picker_camera = Rswift.StringResource(key: "person_detail_picker_camera", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Cancel
      static let person_detail_cancel = Rswift.StringResource(key: "person_detail_cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Cancel
      static let person_detail_picker_cancel = Rswift.StringResource(key: "person_detail_picker_cancel", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Choose Image
      static let person_detail_picker_choose_image = Rswift.StringResource(key: "person_detail_picker_choose_image", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: DELETE
      static let person_detail_delete = Rswift.StringResource(key: "person_detail_delete", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Done
      static let person_detail_save = Rswift.StringResource(key: "person_detail_save", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Edit
      static let person_detail_edit = Rswift.StringResource(key: "person_detail_edit", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Gallery
      static let person_detail_picker_gallery = Rswift.StringResource(key: "person_detail_picker_gallery", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Ok
      static let person_detail_picker_ok_image = Rswift.StringResource(key: "person_detail_picker_ok_image", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: People List
      static let person_list_title = Rswift.StringResource(key: "person_list_title", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Warning
      static let person_detail_picker_warning_image = Rswift.StringResource(key: "person_detail_picker_warning_image", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: You don't have camera
      static let person_detail_picker_no_camera_image = Rswift.StringResource(key: "person_detail_picker_no_camera_image", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: email
      static let person_detail_email = Rswift.StringResource(key: "person_detail_email", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: first
      static let person_detail_first = Rswift.StringResource(key: "person_detail_first", tableName: "Localizable", bundle: R.hostingBundle, locales: [], comment: nil)
      
      /// Value: < Back
      static func person_detail_back(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_back", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Camera
      static func person_detail_picker_camera(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_camera", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Cancel
      static func person_detail_cancel(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_cancel", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Cancel
      static func person_detail_picker_cancel(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_cancel", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Choose Image
      static func person_detail_picker_choose_image(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_choose_image", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: DELETE
      static func person_detail_delete(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_delete", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Done
      static func person_detail_save(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_save", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Edit
      static func person_detail_edit(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_edit", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Gallery
      static func person_detail_picker_gallery(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_gallery", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Ok
      static func person_detail_picker_ok_image(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_ok_image", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: People List
      static func person_list_title(_: Void = ()) -> String {
        return NSLocalizedString("person_list_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: Warning
      static func person_detail_picker_warning_image(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_warning_image", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: You don't have camera
      static func person_detail_picker_no_camera_image(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_picker_no_camera_image", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: email
      static func person_detail_email(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_email", bundle: R.hostingBundle, comment: "")
      }
      
      /// Value: first
      static func person_detail_first(_: Void = ()) -> String {
        return NSLocalizedString("person_detail_first", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
