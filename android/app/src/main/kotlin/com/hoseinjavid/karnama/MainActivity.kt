package com.hoseinjavid.karnama

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.InputStream

class MainActivity : FlutterActivity() {
    private val channelBatterySettings = "com.hoseinjavid.karnama/battery_settings"
    private val  channelRowReader = "com.hoseinjavid.karnama/raw_reader";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelBatterySettings
        ).setMethodCallHandler { call, result ->

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

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelRowReader
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "readRawFile" -> {
                    val fileName = call.argument<String>("fileName")

                    if (fileName != null) {
                        try {
                            val resourceId = resources.getIdentifier(
                                fileName, "raw", packageName
                            )

                            if (resourceId != 0) {
                                val inputStream: InputStream = resources.openRawResource(resourceId)
                                val bytes = inputStream.readBytes()
                                result.success(bytes)
                            } else {
                                result.error(
                                    "NOT_FOUND",
                                    "Resource ID for $fileName not found.",
                                    null
                                )
                            }
                        } catch (e: Exception) {
                            result.error("FILE_ERROR", "Could not read raw file.", e.message)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "File name is required.", null)
                    }
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
                data = Uri.parse("package:$packageName")
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


