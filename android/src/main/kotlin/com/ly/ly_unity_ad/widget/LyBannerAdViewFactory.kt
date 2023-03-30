package com.ly.ly_unity_ad.widget

import android.app.Activity
import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


class LyBannerAdViewFactory(
        private val messenger: BinaryMessenger?
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private var activity: Activity? = null
    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        return LyBannerAdView(context)
    }
}

class LyBannerAdView(context: Context?) : PlatformView {
        var topBanner: BannerView? = null


    init {
        topBanner = TextView(context)
        textView?.text = "ly"
    }

    override fun getView(): View? {
        return textView
    }

    override fun dispose() {
    }

}