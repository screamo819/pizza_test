//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Pizza
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle

  let reuseIdentifier = reuseIdentifier()

  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var info: info { .init(bundle: bundle) }
  var nib: nib { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func info(bundle: Foundation.Bundle) -> info {
    .init(bundle: bundle)
  }
  func nib(bundle: Foundation.Bundle) -> nib {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.nib.validate()
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 4 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `Contacts`.
    var contacts: RswiftResources.ImageResource { .init(name: "Contacts", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Menu`.
    var menu: RswiftResources.ImageResource { .init(name: "Menu", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Profile`.
    var profile: RswiftResources.ImageResource { .init(name: "Profile", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `Trash`.
    var trash: RswiftResources.ImageResource { .init(name: "Trash", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    let bundle: Foundation.Bundle
    var uiApplicationSceneManifest: uiApplicationSceneManifest { .init(bundle: bundle) }

    func uiApplicationSceneManifest(bundle: Foundation.Bundle) -> uiApplicationSceneManifest {
      .init(bundle: bundle)
    }

    struct uiApplicationSceneManifest {
      let bundle: Foundation.Bundle

      let uiApplicationSupportsMultipleScenes: Bool = false

      var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest"], key: "_key") ?? "UIApplicationSceneManifest" }
      var uiSceneConfigurations: uiSceneConfigurations { .init(bundle: bundle) }

      func uiSceneConfigurations(bundle: Foundation.Bundle) -> uiSceneConfigurations {
        .init(bundle: bundle)
      }

      struct uiSceneConfigurations {
        let bundle: Foundation.Bundle
        var _key: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations"], key: "_key") ?? "UISceneConfigurations" }
        var uiWindowSceneSessionRoleApplication: uiWindowSceneSessionRoleApplication { .init(bundle: bundle) }

        func uiWindowSceneSessionRoleApplication(bundle: Foundation.Bundle) -> uiWindowSceneSessionRoleApplication {
          .init(bundle: bundle)
        }

        struct uiWindowSceneSessionRoleApplication {
          let bundle: Foundation.Bundle
          var defaultConfiguration: defaultConfiguration { .init(bundle: bundle) }

          func defaultConfiguration(bundle: Foundation.Bundle) -> defaultConfiguration {
            .init(bundle: bundle)
          }

          struct defaultConfiguration {
            let bundle: Foundation.Bundle
            var uiSceneConfigurationName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneConfigurationName") ?? "Default Configuration" }
            var uiSceneDelegateClassName: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate" }
            var uiSceneStoryboardFile: String { bundle.infoDictionaryString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication"], key: "UISceneStoryboardFile") ?? "Main" }
          }
        }
      }
    }
  }

  /// This `_R.nib` struct is generated, and contains static references to 4 nibs.
  struct nib {
    let bundle: Foundation.Bundle

    /// Nib `FilterTextCVCell`.
    var filterTextCVCell: RswiftResources.NibReferenceReuseIdentifier<FilterTextCVCell, FilterTextCVCell> { .init(name: "FilterTextCVCell", bundle: bundle, identifier: "NotificationsFilterTextCVCell") }

    /// Nib `ItemTVCell`.
    var itemTVCell: RswiftResources.NibReference<ItemTVCell> { .init(name: "ItemTVCell", bundle: bundle) }

    /// Nib `TabBar`.
    var tabBar: RswiftResources.NibReference<TabBar> { .init(name: "TabBar", bundle: bundle) }

    /// Nib `TabBarItem`.
    var tabBarItem: RswiftResources.NibReference<Pizza.TabBarItem> { .init(name: "TabBarItem", bundle: bundle) }

    func validate() throws {
      if UIKit.UIImage(named: "placeholder", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'placeholder' is used in nib 'ItemTVCell', but couldn't be loaded.") }
      if UIKit.UIImage(named: "img-shadow-bottom", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'img-shadow-bottom' is used in nib 'TabBar', but couldn't be loaded.") }
    }
  }

  /// This `_R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {

    /// Reuse identifier `NotificationsFilterTextCVCell`.
    let notificationsFilterTextCVCell: RswiftResources.ReuseIdentifier<FilterTextCVCell> = .init(identifier: "NotificationsFilterTextCVCell")
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }
    var menuViewController: menuViewController { .init(bundle: bundle) }
    var tabViewController: tabViewController { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func menuViewController(bundle: Foundation.Bundle) -> menuViewController {
      .init(bundle: bundle)
    }
    func tabViewController(bundle: Foundation.Bundle) -> tabViewController {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
      try self.menuViewController.validate()
      try self.tabViewController.validate()
    }


    /// Storyboard `LaunchScreen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "LaunchScreen"
      func validate() throws {

      }
    }

    /// Storyboard `MenuViewController`.
    struct menuViewController: RswiftResources.StoryboardReference {
      let bundle: Foundation.Bundle

      let name = "MenuViewController"

      var notificationsViewController: RswiftResources.StoryboardViewControllerIdentifier<MainViewController> { .init(identifier: "NotificationsViewController", storyboard: name, bundle: bundle) }

      func validate() throws {
        if UIKit.UIImage(named: "ic-navigation-bar-back-arrow", in: bundle, compatibleWith: nil) == nil { throw RswiftResources.ValidationError("[R.swift] Image named 'ic-navigation-bar-back-arrow' is used in storyboard 'MenuViewController', but couldn't be loaded.") }
        if notificationsViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'notificationsViewController' could not be loaded from storyboard 'MenuViewController' as 'MainViewController'.") }
      }
    }

    /// Storyboard `TabViewController`.
    struct tabViewController: RswiftResources.StoryboardReference {
      let bundle: Foundation.Bundle

      let name = "TabViewController"

      var tabBarViewController: RswiftResources.StoryboardViewControllerIdentifier<TabBarViewController> { .init(identifier: "TabBarViewController", storyboard: name, bundle: bundle) }

      func validate() throws {
        if tabBarViewController() == nil { throw RswiftResources.ValidationError("[R.swift] ViewController with identifier 'tabBarViewController' could not be loaded from storyboard 'TabViewController' as 'TabBarViewController'.") }
      }
    }
  }
}