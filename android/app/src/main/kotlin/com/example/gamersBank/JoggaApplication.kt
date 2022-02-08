package com.example.gamersBank

import com.freshchat.consumer.sdk.flutter.FreshchatSdkPlugin
import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService

class JoggaApplication : FlutterApplication(), PluginRegistrantCallback {
    @Override
    override fun onCreate() {
        super.onCreate()
       // FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
    }
    @Override
    override fun registerWith(registry: PluginRegistry) {
        //FlutterFirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
        FreshchatSdkPlugin.register(registry)
    }
}