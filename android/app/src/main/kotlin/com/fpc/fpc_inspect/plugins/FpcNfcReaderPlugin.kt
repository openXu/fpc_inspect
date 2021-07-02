package com.fpc.fpc_inspect.plugins
import android.app.Activity
import android.app.PendingIntent
import android.content.Intent
import android.content.IntentFilter
import android.nfc.NfcAdapter
import android.nfc.Tag
import android.nfc.tech.*
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.CopyOnWriteArrayList

/**
 * Author: openXu
 * Time: 2021/6/29 11:34
 * class: FlutterNfcReaderPlugin
 * Description:  读NFC插件Android端实现
 */

class FpcNfcReaderPlugin :
        FlutterPlugin ,       //Flutter插件
        ActivityAware,        //插件与Activity生命周期绑定
        MethodCallHandler,    //插件方法调用帮助类，实现onMethodCall方法
        EventChannel.StreamHandler,
        NfcAdapter.ReaderCallback  //NFC读取回调
{

    private val TAG = "FlutterNfcReaderPlugin"
    private var activity: Activity? = null
    //★ 使用异步方法调用与平台插件通信的命名通道
    private var methodChannel: MethodChannel? = null
    //★ EventChannel 使用事件流与平台插件通信的命名通道
    private var eventChannel: EventChannel? = null
//    internal var eventSink: EventChannel.EventSink? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.e(TAG, "挂载nfc插件，注册插件方法频道")
         methodChannel = MethodChannel(binding.binaryMessenger, "fpc.flutter.io/nfc")
         methodChannel?.setMethodCallHandler(this)
         eventChannel = EventChannel(binding.binaryMessenger, "fpc.flutter.io/nfcstream")
         eventChannel?.setStreamHandler(this)
     }

     override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
         methodChannel?.setMethodCallHandler(null)
         methodChannel = null
         eventChannel?.setStreamHandler(null)
         eventChannel = null
     }

    /**ActivityAware    FlutterPlugin绑定Activity生命周期*/
   override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.e(TAG, "nfc插件已经绑定到activity ${binding.activity}")
       this.activity = binding.activity
   }
   override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding): Unit = onAttachedToActivity(binding)
   override fun onDetachedFromActivityForConfigChanges(): Unit = onDetachedFromActivity()
   override fun onDetachedFromActivity() {
       activity = null
   }

    //MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
    override fun onMethodCall(call: MethodCall, result: Result) {
        require(activity != null) { "Plugin not ready yet" }
        val nfcAdapter by lazy {
            (nfcAdapter ?: error("Plugin not ready yet")).apply {
                if (!isEnabled) {
                    result.error("404", "NFC Hardware not found", null)
                }
            }
        }
        Log.e(TAG, "调用平台通道${call.method}")
        when(call.method){
            "supportNFC" -> result.success(supportNFC())
            "isEnableNFC" -> result.success(isEnableNFC())
            "readNFCOnce" -> readNFC(result, null)
            "stopNfc" -> result.success(stopNfc())
            else-> result.notImplemented()
        }
    }

    /**插件方法流处理*/
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        Log.w(TAG, "开启插件事件流通道${events}")
        if(events!=null)
            readNFC(null, events)
    }
    override fun onCancel(arguments: Any?) {
    }

    /**NFC */
    private var nfcAdapter: NfcAdapter? = null
    companion object {
        internal val nfcOnceListeners = CopyOnWriteArrayList<NfcAdapter.ReaderCallback>()
    }

    private fun getNfcAdapter() : NfcAdapter?{
        if(nfcAdapter==null) {
            // 获取nfc适配器
            nfcAdapter = NfcAdapter.getDefaultAdapter(activity)
//            nfcManager = activity.getSystemService(Context.NFC_SERVICE) as? NfcManager
//            nfcAdapter = nfcManager?.defaultAdapter
        }
        return nfcAdapter
    }
    /**1. 设备是否支持nfc*/
    private fun supportNFC(): Boolean {
        //  FToast.warning("设备不支持NFC功能！")
        return getNfcAdapter()!=null
    }
    /**2. 是否开启了nfc*/
    private fun isEnableNFC(): Boolean {
        //FToast.warning("请在系统设置中先启用NFC功能！")
        val adapter = getNfcAdapter() ?: return false
        return adapter.isEnabled
    }

    /**3. 读取nfc*/
    private fun readNFC(result: Result?, events: EventChannel.EventSink?) {
        val techList = arrayOf(arrayOf(NfcV::class.java.name),
                arrayOf(NfcA::class.java.name),
                arrayOf(NfcF::class.java.name),
                arrayOf(NfcB::class.java.name),
                arrayOf(Ndef::class.java.name),
                arrayOf(NdefFormatable::class.java.name),
                arrayOf(IsoDep::class.java.name),
                arrayOf(MifareUltralight::class.java.name
                ))
        val intentFilters = arrayOf(IntentFilter(NfcAdapter.ACTION_TECH_DISCOVERED))
        // 创建一个 PendingIntent 对象, 这样Android系统就能在一个tag被检测到时定位到这个对象
        val pendingIntent = PendingIntent.getActivity(activity, 0, Intent(activity, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0)
        // 使用前台发布系统
        getNfcAdapter()?.enableForegroundDispatch(activity, pendingIntent, intentFilters, techList)
        if(result!=null){
            //一次性读取
            nfcOnceListeners.add(NfcReaderCallback(result, null))
        }else{
            //持续事件流读取nfc
            nfcOnceListeners.add(NfcReaderCallback(null, events))
        }

        /**
         * NFC (Near Field Communication)近距离无线通信，是一种采用13.56MHz频带的近距离无线通信技术，
         * 允许电子设备之间进行非接触式点对点式数据传输与交换(在10cm内)。这个技术由RFID技术演变而来，
         * 并向下兼容RFID，从这个概念来说：NFC属于RFID，NFC是RFID技术里的一个类别。
         *
         * RFID是射频识别技术，它主要是通过无线电讯号识别特定目标，并可读写数据，但仅仅是单向的读取。
         * RFID有低频（几mm的传输距离）、高频（13.56Mhz）、超高频、微波频段等，频段不同，导致功率不同，
         * 导致传输的距离不同。NFC是近距离无线通讯技术，芯片具有相互通信能力，并有计算能力。
         *
         * NFC可以看作是RFID的子集，用的是RFID的高频（13.56MHz）的标准，但却是双向过程。
         *
         * NFC工作有效距离约10cm，所以具有很高的安全性。如果使用一些特殊的信号采集设备，可以在相当远的距离外读取到RFID的信息。
         *
         * NFC 分类：
         * 1类标签：基于ISO14443A标准，可读写（可读、可重新写入）。存储能力96byte，可被扩充到2k，通信速度为106 kbit/s
         * 2类标签：基于ISO14443A标准，可读、重新写入。内存48字节，可被扩充到2k字节。通信速度也是106 kbit/s。
         * 3类标签：基于Sony FeliCa体系，内存2k，通讯速度为212 kbit/s（★高速）。适合较复杂的应用，成本较高
         * 4类标签：与ISO14443A、B标准兼容。制造时被预先设定为可读/可重写、或者只读。内存容量可达32k字节，通信速度介于106 kbit/s和424 kbit/s之间。
         *
         *  IsoDep              ISO-DEP (ISO 14443-4)
         *  MifareClassic       MIFARE Classic
         *  MifareUltralight    MIFARE Ultralight
         *  Ndef                NDEF content and operations
         *  NdefFormatable      NDEF format
         *  NfcA                NFC-A (ISO 14443-3A)   暂住证[android.nfc.tech.IsoDep, android.nfc.tech.NfcA] 352C2C62
         *  NfcB                NFC-B (ISO 14443-3B)   身份证[android.nfc.tech.NfcB]   4796EF043155789A
         *  NfcBarcode          containing barcode
         *  NfcF                NFC-F (JIS 6319-4)
         *  NfcV                NFC-V (ISO 15693)   RFID
         *
         *  掌上119安全检查点RFID: [android.nfc.tech.NfcA, android.nfc.tech.MifareClassic, android.nfc.tech.NdefFormatable]
         *                       A98FF25C
         */
        var nfcFlags = NfcAdapter.FLAG_READER_NFC_A or
                NfcAdapter.FLAG_READER_NFC_B or
                NfcAdapter.FLAG_READER_NFC_BARCODE or
                NfcAdapter.FLAG_READER_NFC_F or
                NfcAdapter.FLAG_READER_NFC_V
        //当此 Activity 在前台时，将 NFC 控制器限制为读取器模式。
        getNfcAdapter()?.enableReaderMode(activity, this, nfcFlags, null)
    }
    /**4. 关闭读取*/
    private fun stopNfc(): Boolean {
        nfcOnceListeners.clear()
//        getNfcAdapter()?.disableForegroundDispatch(activity)
        getNfcAdapter()?.disableReaderMode(activity)
        return true
    }

    /**读取nfc信号回调*/
    override fun onTagDiscovered(tag: Tag?) {
        Log.e(TAG, "${Thread.currentThread()}  nfc读取结果回调：${tag}")
        nfcOnceListeners.forEach { it.onTagDiscovered(tag) }
    }
    /**
     * NFC读取结果回调，如果result不为空则是一次性读取
     * 否则使用eventSink返回持续事件流
     */
    class NfcReaderCallback(private val result: Result?,
                            private val eventSink: EventChannel.EventSink?)
        : NfcAdapter.ReaderCallback {
        override fun onTagDiscovered(tag: Tag?) {
            //获取此标记中可用的技术，作为完全限定类名
            Log.e("NfcReaderCallback", "遍历回调：${tag}")
            tag?.result { data ->
                result?.success(data)      //只能返回一次结果 否则报错 java.lang.IllegalStateException: Reply already submitted
                eventSink?.success(data)  //返回事件流
            }
            if(result!=null)
                nfcOnceListeners.remove(this)
        }
    }



}

fun Tag.result(callback: (String?) -> Unit) {

    //id:获取标记标识符（如果有）。标签标识符是一个低级序列号，用于防碰撞以及身份证明
    //大多数标签都有一个稳定的唯一标识符（UID），但有些标记每次被发现时都会生成一个随机ID（RID），并且有些标签根本没有ID（字节数组的大小为零）。
    //ID的大小和格式取决于标签使用的射频技术。
    val id = id.bytesToHexString()
    Log.w("Tag", "解析读取nfc结果: $id")
    //java.lang.RuntimeException: Methods marked with @UiThread must be executed on the main thread. Current thread: Binder:28953_2
    //W/Binder  (28953): 	at io.flutter.embedding.engine.FlutterJNI.ensureRunningOnMainThread(FlutterJNI.java:1230)
    //需要切换到主线程后返回到dart层
    Handler(Looper.getMainLooper()).post {
        callback(id)
    }
}
private fun ByteArray.bytesToHexString(): String? {
    val stringBuilder = StringBuilder(/*"0x"*/)
    for (i in indices) {
        stringBuilder.append(Character.forDigit(get(i).toInt() ushr 4 and 0x0F, 16))
        stringBuilder.append(Character.forDigit(get(i).toInt() and 0x0F, 16))
    }

    return stringBuilder.toString().toUpperCase()
}