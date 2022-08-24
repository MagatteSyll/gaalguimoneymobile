package com.example.gaalguimoney
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.Manifest
import android.content.*
import android.app.Activity
import android.content.pm.PackageManager
import android.util.Log
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.PermissionChecker
import android.os.Build


class MainActivity: FlutterActivity() {
private val channel="flutter.native.com/auth";


  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    val authChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)

      authChannel.setMethodCallHandler{
        call,result ->
        if (call.method =="getoken") {
        val  sharedPref =getSharedPreferences("tokens", MODE_PRIVATE);
        val  access  =sharedPref.getString("access","pas de token");
          result.success(access)
        }
        if(call.method =="setoken") {
          val arg= call.arguments()  as Map<String, String>?
          val access= arg?.get("access");
          val refresh= arg?.get("refresh");
          val sharedPref = getSharedPreferences("tokens", MODE_PRIVATE);
          val editor:SharedPreferences.Editor=sharedPref.edit();
          editor.apply{
            putString("access",access)
            putString("refresh", refresh) }
          editor.commit()
          val  resultat =sharedPref.getString("access",null);
          result.success(resultat);


        }
        if(call.method =="deconnexion")
        {
          val  sharedPref =getSharedPreferences("tokens", MODE_PRIVATE);
          sharedPref.edit().remove("access").commit()
          sharedPref.edit().remove("refresh").commit()
          result.success("success remove key")
        }
        else {
          result.notImplemented()
        }

      }
    }
}

/* val arg= call.arguments()!! as Map<String?,String?>;

         */