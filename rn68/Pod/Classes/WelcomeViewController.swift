import UIKit
import React

public class WelcomeViewController: UIViewController, RCTBridgeDelegate {
    public override func viewDidLoad() {
        let bridge: RCTBridge = RCTBridge.init(delegate: self)
        self.view = RCTRootView.init(bridge: bridge, moduleName: "rn68", initialProperties: [:])
    }
    
    public func sourceURL(for bridge: RCTBridge!) -> URL! {
        let rn68Bundle: Bundle = Bundle.init(for: WelcomeViewController.self)
        return rn68Bundle.url(forResource: "rn68", withExtension: "js")
    }
}
