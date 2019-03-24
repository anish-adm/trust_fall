package com.anish.trust_fall;

import android.app.Activity;
import android.content.Context;

import com.anish.trust_fall.Emulator.EmulatorCheck;
import com.anish.trust_fall.ExternalStorage.ExternalStorageCheck;
import com.anish.trust_fall.MockLocation.MockLocationCheck;
import com.anish.trust_fall.Rooted.RootedCheck;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TrustFallPlugin */
public class TrustFallPlugin implements MethodCallHandler {
  /** Plugin registration. */

  private final Context context;
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "trust_fall");
    channel.setMethodCallHandler(new TrustFallPlugin(registrar.context()));
  }

  private TrustFallPlugin(Context context){
    this.context = context;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("isJailBroken")) {
      result.success(RootedCheck.isJailBroken(context));
    } else if (call.method.equals("canMockLocation")) {
      result.success(MockLocationCheck.isMockLocationOn(context));
    }else if (call.method.equals("isRealDevice")) {
      result.success(!EmulatorCheck.isEmulator());
    }else if (call.method.equals("isOnExternalStorage")) {
      result.success(ExternalStorageCheck.isOnExternalStorage(context));
    }
    else {
      result.notImplemented();
    }
  }
}
