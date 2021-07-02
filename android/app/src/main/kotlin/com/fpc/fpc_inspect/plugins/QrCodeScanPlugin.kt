package com.fpc.fpc_inspect.plugins
import android.app.Activity
import android.content.Intent
import android.util.Log
import com.fpc.core.zxing.activity.CaptureInfo
import com.fpc.core.zxing.activity.DecoderActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/**
 * Author: openXu
 * Time: 2021/6/29 11:34
 * class: FlutterNfcReaderPlugin
 * Description:  二维码插件android端实现
 */

class QrCodeScanPlugin :
        FlutterPlugin ,       //Flutter插件
        ActivityAware,        //插件与Activity生命周期绑定
        MethodCallHandler,    //插件方法调用帮助类，实现onMethodCall方法
        PluginRegistry.ActivityResultListener, PluginRegistry.RequestPermissionsResultListener {

    private val TAG = "QrCodeScanPlugin"
    private var activity: Activity? = null

    //★ 使用异步方法调用与平台插件通信的命名通道
    private var methodChannel: MethodChannel? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.e(TAG, "挂载qrcode插件，注册插件方法频道")
         methodChannel = MethodChannel(binding.binaryMessenger, "fpc.flutter.io/qrcode")
         methodChannel?.setMethodCallHandler(this)
     }

     override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
         methodChannel?.setMethodCallHandler(null)
         methodChannel = null
     }

    /**ActivityAware    FlutterPlugin绑定Activity生命周期*/
   override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.e(TAG, "nfc插件已经绑定到activity ${binding.activity}")
       this.activity = binding.activity
        binding.addActivityResultListener(this)
        binding.addRequestPermissionsResultListener(this)
   }
   override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding): Unit = onAttachedToActivity(binding)
   override fun onDetachedFromActivityForConfigChanges(): Unit = onDetachedFromActivity()
   override fun onDetachedFromActivity() {
       activity = null
   }

    //MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
    override fun onMethodCall(call: MethodCall, result: Result) {
        require(activity != null) { "Plugin not ready yet" }
        Log.e(TAG, "调用平台通道${call.method}")
        when(call.method){
            "scan" -> scan(result)
            else-> result.notImplemented()
        }
    }

    private fun scan(result: Result){
        val info = CaptureInfo()
        info.let {
            it.isDecodeLoacal = false
            it.title = "扫一扫"
            it.info1 = ""
            it.info2 = ""
        }
        scanResult = ScanResultHandler(result)
        val intent = Intent(activity, DecoderActivity::class.java)
        intent.putExtra("info", info)
        activity!!.startActivityForResult(intent, 100)
    }

    private var scanResult:ScanResultHandler? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Log.w(TAG, "Activity返回结果：$data")
        scanResult?.onActivityResult(requestCode, resultCode, data)
        return true
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?, grantResults: IntArray?): Boolean {
        return true
    }

    class ScanResultHandler(private val result: Result) : PluginRegistry.ActivityResultListener {
        override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
            if(resultCode != Activity.RESULT_OK || data==null) {
                result.error("-1", "取消",null)
                return true
            }
            val resultType = data.getIntExtra(DecoderActivity.EXTRA_TYPE_KEY, DecoderActivity.TYPE_OTHERCODE)
            val code = data.getStringExtra(DecoderActivity.EXTRA_KEY)
            val resultStr = "{\"resultType\":$resultType, \"code\":$code}"
            Log.w("dd", "返回结果：$resultStr")
            result.success(resultStr)
            return true
        }
    }


}

