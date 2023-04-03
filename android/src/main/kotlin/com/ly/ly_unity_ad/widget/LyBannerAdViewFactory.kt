package com.ly.ly_unity_ad.widget

import android.app.Activity
import android.content.Context
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import com.ly.ly_unity_ad.callback.LyUnityCallback
import com.unity3d.services.banners.BannerErrorInfo
import com.unity3d.services.banners.BannerView
import com.unity3d.services.banners.UnityBannerSize
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


class LyBannerAdViewFactory(
    private val messenger: BinaryMessenger?,
    private val height: Int,
    private val width: Int,
    private val adUnitId: String?,
    private val lyUnityCallback: LyUnityCallback
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private var activity: Activity? = null
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return LyBannerAdView(activity, height = height, width = width, adUnitId = adUnitId,lyUnityCallback=lyUnityCallback)
    }
}

class LyBannerAdView(
    activity: Activity?, height: Int,
    width: Int,
    adUnitId: String?,
    lyUnityCallback: LyUnityCallback
) : PlatformView {
    private var topBanner: BannerView? = null


    init {
        val size = UnityBannerSize(width, height)
        topBanner = BannerView(activity, adUnitId, size)
        topBanner?.listener = object : BannerView.IListener {
            override fun onBannerLoaded(bannerAdView: BannerView?) {
                Log.d("ly say:", "onBannerLoaded")
            }

            override fun onBannerClick(bannerAdView: BannerView?) {
                Log.d("ly say:", "onBannerClick")
                lyUnityCallback.onClicked(bannerAdView?.placementId)
            }

            override fun onBannerFailedToLoad(
                bannerAdView: BannerView?,
                errorInfo: BannerErrorInfo?
            ) {
                Log.d("ly say:", "onBannerFailedToLoad:${errorInfo?.errorMessage}")
            }

            override fun onBannerLeftApplication(bannerView: BannerView?) {
                Log.d("ly say:", "onBannerLeftApplication")
            }
        }
        topBanner?.load()
    }

    override fun getView(): View? {
        return topBanner
    }

    override fun dispose() {
    }

}