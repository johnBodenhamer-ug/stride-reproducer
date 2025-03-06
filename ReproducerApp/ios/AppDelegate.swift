import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider
import Firebase
import AppAuth

@main
class AppDelegate: RCTAppDelegate, RNAppAuthAuthorizationFlowManager {
  
    public weak var authorizationFlowManagerDelegate: RNAppAuthAuthorizationFlowManagerDelegate?

    var currentAuthorizationFlow: OIDExternalUserAgentSession?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        FirebaseApp.configure()
        
        self.moduleName = "ConvergeStrideApp"
        self.dependencyProvider = RCTAppDependencyProvider()
        
        self.initialProps = [:]

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // ✅ Required function to conform to RNAppAuthAuthorizationFlowManager
    func setCurrentAuthorizationFlow(_ authorizationFlow: OIDExternalUserAgentSession?) {
        self.currentAuthorizationFlow = authorizationFlow
    }

    // ✅ Handle OAuth redirects
    override func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        if let authorizationFlow = currentAuthorizationFlow, authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            currentAuthorizationFlow = nil
            return true
        }

        return super.application(app, open: url, options: options)
    }

    // ✅ Handle screen orientation changes
    override func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        return Orientation.getOrientation()
    }

    override func sourceURL(for bridge: RCTBridge) -> URL? {
        return self.bundleURL()
    }

    override func bundleURL() -> URL? {
#if DEBUG
        return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
#else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
#endif
    }
}
