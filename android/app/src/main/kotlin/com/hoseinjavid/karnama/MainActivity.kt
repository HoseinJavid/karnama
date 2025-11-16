package com.hoseinjavid.karnama

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context       
import android.os.PowerManager    

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.hoseinjavid.karnama/battery_settings"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->

                when (call.method) {
                "openBatterySettings" -> {
                    openBatteryOptimizationSettings()
                    result.success(null) 
                }
                "isOptimizationIgnored" -> {
                    result.success(checkBatteryOptimizationStatus())
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun openBatteryOptimizationSettings() {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS).apply {
                data = Uri.parse("package:" + packageName)
            }
            startActivity(intent)
        } else {
        }
    }

    private fun checkBatteryOptimizationStatus(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true 
        }
        
        val powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager
        return powerManager.isIgnoringBatteryOptimizations(packageName)
    }
}