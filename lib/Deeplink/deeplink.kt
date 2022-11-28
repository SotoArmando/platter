private val CHANNEL = "poc.deeplink.flutter.dev/channel"
private var startString: String? = nulloverride 

fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
        if (call.method == "initialLink") {
            if (startString != null) {
                result.success(startString)
            }
        }
    }
}

override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    val intent = getIntent()
    startString = intent.data?.toString()
}