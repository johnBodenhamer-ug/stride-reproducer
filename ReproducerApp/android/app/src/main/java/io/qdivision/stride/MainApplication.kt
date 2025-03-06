package io.qdivision.stride;

import android.app.Application
import com.facebook.react.PackageList
import com.facebook.react.ReactApplication
import com.facebook.react.ReactNativeHost
import com.facebook.react.ReactPackage
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint
import com.facebook.soloader.SoLoader
import java.util.List
import com.facebook.react.ReactHost
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.load
import com.facebook.react.defaults.DefaultReactHost.getDefaultReactHost
import com.facebook.react.flipper.ReactNativeFlipper
import com.facebook.react.defaults.DefaultReactNativeHost

import com.oblador.vectoricons.VectorIconsPackage;
import com.reactnativecommunity.netinfo.NetInfoPackage;
import com.ReactNativeBlobUtil.ReactNativeBlobUtilPackage;
import com.swmansion.gesturehandler.RNGestureHandlerPackage;
import com.rnfs.RNFSPackage;
import com.rssignaturecapture.RSSignatureCapturePackage;
import com.keyee.pdfview.PDFView;
import com.facebook.react.soloader.OpenSourceMergedSoMapping

class MainApplication : Application(), ReactApplication {

    override val reactNativeHost: ReactNativeHost =
        object : DefaultReactNativeHost(this) {
            override fun getPackages(): MutableList<ReactPackage> {
                // Packages that cannot be autolinked yet can be added manually here, for example:
                // packages.add(new MyReactNativePackage());
                val packages = mutableListOf<ReactPackage>()
                packages.add(VectorIconsPackage())
                packages.add(NetInfoPackage())
                packages.add(ReactNativeBlobUtilPackage())
                packages.add(RNGestureHandlerPackage())
                packages.add(RNFSPackage())
                packages.add(RSSignatureCapturePackage())
                packages.add(PDFView())
                packages.addAll(PackageList(this).packages)

                return packages
            }

            override fun getJSMainModuleName(): String = "index"

            override fun getUseDeveloperSupport(): Boolean = BuildConfig.DEBUG

            override val isNewArchEnabled: Boolean = BuildConfig.IS_NEW_ARCHITECTURE_ENABLED
            override val isHermesEnabled: Boolean = BuildConfig.IS_HERMES_ENABLED
        }

    override val reactHost: ReactHost
        get() = getDefaultReactHost(applicationContext, reactNativeHost)

    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, OpenSourceMergedSoMapping)
        if (BuildConfig.IS_NEW_ARCHITECTURE_ENABLED) {
            // If you opted-in for the New Architecture, we load the native entry point for this app.
            load()
        }
        ReactNativeFlipper.initializeFlipper(this, reactNativeHost.reactInstanceManager)
    }
}
