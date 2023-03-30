package com.ly.ly_unity_ad

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.unity3d.ads.*

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** LyUnityAdPlugin */
class LyUnityAdPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ly_unity_ad")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }


    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> getPlatformVersion(call, result)
            "init" -> init(call, result)
            "showInterstitialAd" -> showAds(call, result, false)
            "showRewardedAd" -> showAds(call, result, true)
        }


    }

    /**
     * 展示插页式广告
     */
    private fun getPlatformVersion(@NonNull call: MethodCall, @NonNull result: Result) {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }


    /**
     * 展示基本视频
     * 包含基本广告和激励广告
     * @param isRewardAd 是否是奖励广告
     */
    private fun showAds(@NonNull call: MethodCall, @NonNull result: Result, isRewardAd: Boolean) {
        val adUnitId = (call.argument("adUnitId") as? String)
        val gamerSid = (call.argument("gamerSid") as? String)

        UnityAds.load(adUnitId, object : IUnityAdsLoadListener {
            override fun onUnityAdsAdLoaded(placementId: String?) {
                Log.d("ly say:", "onUnityAdsAdLoaded")
                result.success("onUnityAdsAdLoaded:$placementId")
                // 广告加载成功
                //进行广告显示
                val options: UnityAdsShowOptions = UnityAdsShowOptions()
                options.data.put("openAnimated", true)
                options.data.put("gamerSid", gamerSid)
                options.data.put("muteVideoSounds", false)
                options.data.put("videoMuted", false)
                UnityAds.show(
                    activity,
                    adUnitId,
                    options,
                    object : IUnityAdsShowListener {
                        override fun onUnityAdsShowFailure(
                            placementId: String?,
                            error: UnityAds.UnityAdsShowError?,
                            message: String?
                        ) {
                            ///进行广告显示 失败
                            Log.d("ly", "onUnityAdsShowFailure:$message");

                        }

                        override fun onUnityAdsShowStart(placementId: String?) {
                            ///进行广告显示 进行中
                            Log.d("ly", "onUnityAdsShowStart:$placementId");

                        }

                        override fun onUnityAdsShowClick(placementId: String?) {
                            ///进行广告显示 点击

                            channel.invokeMethod(
                                "onUnityAdsShowClick",
                                mapOf(
                                    "placementId" to placementId
                                )
                            )
                        }

                        override fun onUnityAdsShowComplete(
                            placementId: String?,
                            state: UnityAds.UnityAdsShowCompletionState?
                        ) {
                            ///进行广告显示 展示完成
                            Log.d("ly", "onUnityAdsShowComplete:${state?.name}")
                            if (isRewardAd) {
                                //如果是奖励广告 需要区分是否观看完毕了
                                val isWatchCompleted =
                                    state?.equals(UnityAds.UnityAdsShowCompletionState.COMPLETED)
                                channel.invokeMethod(
                                    "onUnityAdsShowComplete",
                                    mapOf(
                                        "placementId" to placementId,
                                        "isWatchCompleted" to isWatchCompleted,
                                    )
                                )
                            }
                        }
                    })
            }

            override fun onUnityAdsFailedToLoad(
                placementId: String?,
                error: UnityAds.UnityAdsLoadError?,
                message: String?
            ) {
                // 广告加载失败
                result.success("onUnityAdsFailedToLoad:$message")
                Log.d("ly say:", "onUnityAdsFailedToLoad:$message")

            }

        })
    }

    /**
     * 初始化sdk
     */
    private fun init(@NonNull call: MethodCall, @NonNull result: Result) {
//        'init', {"gameId": gameId,"ifTestModel":ifTestModel
        val gameId = (call.argument("gameId") as? String)
        val ifTestModel = (call.argument("ifTestModel") as? Boolean)
        UnityAds.initialize(
            context,
            gameId,
            ifTestModel == false,
            object : IUnityAdsInitializationListener {
                override fun onInitializationComplete() {
                    result.success("InitializationComplete")
                }

                override fun onInitializationFailed(
                    error: UnityAds.UnityAdsInitializationError?,
                    message: String?
                ) {
                    result.success(message)

                }
            });

    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }


}
