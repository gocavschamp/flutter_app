package com.yuwenming.flutter.flutterapp


import android.os.Bundle
import io.flutter.app.FlutterPluginRegistry
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.plugin.asr.AsrPlugin

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
    registerSelfPlugin()
  }
    private fun registerSelfPlugin() {
        AsrPlugin.registerWith(FlutterPluginRegistry(flutterEngine,this).registrarFor("org.devio.flutter.plugin.asr.AsrPlugin"))
    }
}
