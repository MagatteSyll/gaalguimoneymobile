package com.example.gaalguimoney
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.*


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
          val access= arg?.get("access")
          val refresh= arg?.get("refresh")
          val sharedPref = getSharedPreferences("tokens", MODE_PRIVATE);
          val editor:SharedPreferences.Editor=sharedPref.edit();
          editor.apply{
            putString("access",access)
            putString("refresh", refresh) }
          editor.commit()
          val  resultat =sharedPref.getString("access",null);
          result.success(resultat)


        }
        if(call.method =="deconnexion")
        {
          val  sharedPref =getSharedPreferences("tokens", MODE_PRIVATE);
          sharedPref.edit().remove("access").commit()
          sharedPref.edit().remove("refresh").commit()
          sharedPref.edit().remove("phone").commit()
          sharedPref.edit().remove("code").commit()
          result.success("success remove key")
        }
        if(call.method =="simpledeconnexion")
        {
          val  sharedPref =getSharedPreferences("tokens", MODE_PRIVATE);
          sharedPref.edit().remove("access").commit()
          sharedPref.edit().remove("refresh").commit()
          result.success("success remove key")
        }
        if(call.method =="setphone") {
          val arg= call.arguments()  as Map<String, String>?
          val phone= arg?.get("phone")
          val code= arg?.get("code")
          val sharedPref = getSharedPreferences("tokens", MODE_PRIVATE);
          val editor:SharedPreferences.Editor=sharedPref.edit();
          editor.apply {
            putString("phone", phone)
            putString("code", code) }
          editor.commit()
          val  resultat =sharedPref.getString("phone",null);
          result.success(resultat)
        }
        if (call.method =="getphone") {
          val  sharedPref =getSharedPreferences("tokens", MODE_PRIVATE);
          val  phone  =sharedPref.getString("phone","pas de phone");
          result.success(phone)
        }
        if (call.method =="getcode") {
          val  sharedPref =getSharedPreferences("tokens", MODE_PRIVATE);
          val  code  =sharedPref.getString("code","pas de code");
          result.success(code)
        }
        else {
          result.notImplemented()
        }

      }
    }
}

/* val arg= call.arguments()!! as Map<String?,String?>;

         */