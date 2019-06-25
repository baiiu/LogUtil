# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/zhaokaiqiang/Develop/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# 指定代码的压缩级别
-optimizationpasses 5

-ignorewarnings # 抑制警告
-verbose    # 混淆时是否记录日志（混淆后生产映射文件 map 类名 -> 转化后类名的映射
-dontpreverify # 不预校验
-dontoptimize #不优化输入的类文件
-dontshrink #该选项 表示 不启用压缩  混淆时是否做预校验（可去掉加快混淆速度）

-dontusemixedcaseclassnames # 混淆时不会产生形形色色的类名  是否使用大小写混合
-dontskipnonpubliclibraryclasses #不跳过(混淆) jars中的 非public classes   默认选项

-keepattributes Exceptions # 解决AGPBI警告
-keepattributes Exceptions,InnerClasses,...
-keepattributes EnclosingMethod
-keepattributes SourceFile,LineNumberTable #运行抛出异常时保留代码行号
#过滤泛型
-keepattributes Signature
#过滤注解
-keepattributes *Annotation*
-keep class * extends java.lang.annotation.Annotation { *; }
-keep interface * extends java.lang.annotation.Annotation { *; }


#继承自activity,application,service,broadcastReceiver,contentprovider....不进行混淆
-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.support.v4.**
-keep public class com.android.vending.licensing.ILicensingService
-keep public class * extends android.support.multidex.MultiDexApplication
-keep public class * extends android.view.View
-keep class android.support.** {*;}

# keep setters in Views so that animations can still work.
# see http://proguard.sourceforge.net/manual/examples.html#beans
-keepclassmembers public class * extends android.view.View {
   void set*(***);
   *** get*();
}

# 所有View的子类及其子类的get、set方法都不进行混淆
-keep public class * extends android.view.View {  #保持自定义控件指定规则的方法不被混淆
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

#保持指定规则的方法不被混淆（Android layout 布局文件中为控件配置的onClick方法不能混淆）
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

# 对于带有回调函数onXXEvent的，不能被混淆
-keepclassmembers class * {
    void *(*Event);
}

 #保持R文件不被混淆，否则，你的反射是获取不到资源id的
-keep class **.R$* { *; }
# 不混淆R类里及其所有内部static类中的所有static变量字段，$是用来分割内嵌类与其母体的标志
-keep public class **.R$*{
   public static final int *;
}
-keepclassmembers class **.R$* {
	public static <fields>;
}

#过滤js
-keepattributes *JavascriptInterface*
#保护WebView对HTML页面的API不被混淆
-keep class **.Webview2JsInterface { *; }
-keepclassmembers class * extends android.webkit.WebViewClient {  #如果你的项目中用到了webview的复杂操作 ，最好加入
     public void *(android.webkit.WebView,java.lang.String,android.graphics.Bitmap);
     public boolean *(android.webkit.WebView,java.lang.String);
}
-keepclassmembers class * extends android.webkit.WebChromeClient {  #如果你的项目中用到了webview的复杂操作 ，最好加入
     public void *(android.webkit.WebView,java.lang.String);
}
#对WebView的简单说明下：经过实战检验,做腾讯QQ登录，如果引用他们提供的jar，若不加防止WebChromeClient混淆的代码，oauth认证无法回调，
#反编译基代码后可看到他们有用到WebChromeClient，加入此代码即可。

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);  #保持自定义控件类不被混淆，指定格式的构造方法不去混淆
}

-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet, int);
}


# 保持枚举 enum 类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保持 native 方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}

# 保持 Parcelable 不被混淆
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}

#-keep public class * {
#    public protected *;
#}

#需要序列化和反序列化的类不能被混淆（注：Java反射用到的类也不能被混淆）
-keep public class * implements java.io.Serializable {
        public *;
}

#不混淆Serializable接口的子类中指定的某些成员变量和方法
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}

-keep class org.** {*;}
-keep class com.android.**{*;}
#-assumenosideeffects class_specification

#v7 不混淆
-keep class android.support.v7.** { *; }
-keep interface android.support.v7.** { *; }
-dontwarn android.support.v7.**

# support-design
-dontwarn android.support.design.**
-keep class android.support.design.** { *; }
-keep interface android.support.design.** { *; }
-keep public class android.support.design.R$* { *; }

# support-v7-appcompat
-dontwarn android.support.v7.**
-keep class android.support.v7.** { *; }
-keep class android.support.v7.internal.** { *; }
-keep interface android.support.v7.internal.** { *; }
-keep public class android.support.v7.widget.** { *; }
-keep public class android.support.v7.internal.widget.** { *; }
-keep public class android.support.v7.internal.view.menu.** { *; }

# support-v4
-dontwarn android.support.v4.**
-keep class android.support.v4.app.** { *; }
-keep interface android.support.v4.app.** { *; }
-keep class android.support.v4.** { *; }
-keep public class * extends android.support.v4.view.ActionProvider {
    public <init>(android.content.Context);
}

# support-v7-cardview.pro
# http://stackoverflow.com/questions/29679177/cardview-shadow-not-appearing-in-lollipop-after-obfuscate-with-proguard/29698051
-keep class android.support.v7.widget.RoundRectDrawable { *; }

-dontwarn android.net.http.**
-keep class org.apache.http.** { *;}




# Retrofit does reflection on generic parameters. InnerClasses is required to use Signature and
# EnclosingMethod is required to use InnerClasses.
-keepattributes Signature, InnerClasses, EnclosingMethod

# Retrofit does reflection on method and parameter annotations.
-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations

# Retain service method parameters when optimizing.
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}

# Ignore annotation used for build tooling.
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement

# Ignore JSR 305 annotations for embedding nullability information.
-dontwarn javax.annotation.**

# Guarded by a NoClassDefFoundError try/catch and only used when on the classpath.
-dontwarn kotlin.Unit

# Top-level functions that can only be used by Kotlin.
-dontwarn retrofit2.KotlinExtensions

# With R8 full mode, it sees no subtypes of Retrofit interfaces since they are created with a Proxy
# and replaces all potential values with null. Explicitly keeping the interfaces prevents this.
#-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>


# JSR 305 annotations are for embedding nullability information.
-dontwarn javax.annotation.**

# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*

# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform


# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*
-dontwarn okio.**
-dontwarn retrofit2.**
-dontwarn rx.**


# >>>>>>>>>>>>>>>>>>>>>>>>  Facebook Fresco  Start >>>>>>>>>>>>>>>>>>>>>>>>
# Keep our interfaces so they can be used by other ProGuard rules.
# See http://sourceforge.net/p/proguard/bugs/466/
-keep,allowobfuscation @interface com.facebook.common.internal.DoNotStrip

# Do not strip any method/class that is annotated with @DoNotStrip
-keep @com.facebook.common.internal.DoNotStrip class *
-keepclassmembers class * {
    @com.facebook.common.internal.DoNotStrip *;
}

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn com.android.volley.toolbox.**

-dontwarn com.squareup.okhttp.**
-dontwarn okhttp3.**
# >>>>>>>>>>>>>>>>>>>>>>>>  Facebook Fresco  End >>>>>>>>>>>>>>>>>>>>>>>>



# >>>>>>>>>>>>>>>>>>>>>>>>  Glide  Start >>>>>>>>>>>>>>>>>>>>>>>>
# Glide specific rules #
# https://github.com/bumptech/glide
-dontwarn  com.bumptech.**
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}
# >>>>>>>>>>>>>>>>>>>>>>>>  Glide  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  Picasso  Start >>>>>>>>>>>>>>>>>>>>>>>>
## Square Picasso specific rules ##
## https://square.github.io/picasso/ ##
-dontwarn com.squareup.okhttp.**
# >>>>>>>>>>>>>>>>>>>>>>>>  Picasso  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  Jackson  Start >>>>>>>>>>>>>>>>>>>>>>>>
-dontwarn com.fasterxml.jackson.databind.**
-keep class com.fasterxml.jackson.core.** {*;}
-keep interface com.fasterxml.jackson.core { *; }
-keep public class * extends com.fasterxml.jackson.core.**
-keep class com.fasterxml.jackson.databind.introspect.VisibilityChecker$Std.<clinit>
-keep class com.fasterxml.jackson.databind.ObjectMapper.<clinit>
-keep class com.fasterxml.jackson.databind.** {*;}
-keep class com.fasterxml.jackson.databind.introspect.VisibilityChecker$*{*;}
-keep interface com.fasterxml.jackson.databind { *; }
-keep public class * extends com.fasterxml.jackson.databind.**
# >>>>>>>>>>>>>>>>>>>>>>>>  Jackson  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  GSON  Start >>>>>>>>>>>>>>>>>>>>>>>>
## GSON 2.2.4 specific rules ##
# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

-keepattributes EnclosingMethod

# Gson specific classes
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.**{*;}
-keep class com.google.gson.examples.android.model.** { *; }
# >>>>>>>>>>>>>>>>>>>>>>>>  GSON  End >>>>>>>>>>>>>>>>>>>>>>>>

# >>>>>>>>>>>>>>>>>>>>>>>>  zxing  Start >>>>>>>>>>>>>>>>>>>>>>>>
-dontwarn com.google.zxing.**
-dontwarn com.google.zxing.client.android.**
-keep  class com.google.zxing.**{*;}
# >>>>>>>>>>>>>>>>>>>>>>>>  zxing  End >>>>>>>>>>>>>>>>>>>>>>>>



# >>>>>>>>>>>>>>>>>>>>>>>>  EventBus 2  Start >>>>>>>>>>>>>>>>>>>>>>>>
## GreenRobot EventBus specific rules ##
# https://github.com/greenrobot/EventBus/blob/master/HOWTO.md#proguard-configuration

-keepclassmembers class ** {
    public void onEvent*(***);
}

# Only required if you use AsyncExecutor
-keepclassmembers class * extends de.greenrobot.event.util.ThrowableFailureEvent {
    public <init>(java.lang.Throwable);
}

# Don't warn for missing support classes
-dontwarn de.greenrobot.event.util.*$Support
-dontwarn de.greenrobot.event.util.*$SupportManagerFragment
# >>>>>>>>>>>>>>>>>>>>>>>>  EventBus 2  End >>>>>>>>>>>>>>>>>>>>>>>>



# >>>>>>>>>>>>>>>>>>>>>>>>  EventBus 3  Start >>>>>>>>>>>>>>>>>>>>>>>>
## New rules for EventBus 3.0.x ##
# http://greenrobot.org/eventbus/documentation/proguard/

-keepattributes *Annotation*
-keepclassmembers class ** {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }

# Only required if you use AsyncExecutor
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}
# >>>>>>>>>>>>>>>>>>>>>>>>  EventBus 3  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  Rxjava  Start >>>>>>>>>>>>>>>>>>>>>>>>
-dontwarn sun.misc.**
-dontwarn org.apache.http.**

-keep class rx.**.

-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
   long producerIndex;
   long consumerIndex;
}

-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode producerNode;
}

-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode consumerNode;
}
# >>>>>>>>>>>>>>>>>>>>>>>>  Rxjava  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  OkHttp  Start >>>>>>>>>>>>>>>>>>>>>>>>
# OkHttp
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.squareup.okhttp.** { *; }
-keep interface com.squareup.okhttp.** { *; }
-dontwarn com.squareup.okhttp.**

# OkHttp3
-dontwarn okhttp3.**
-keepattributes Signature
-keepattributes *Annotation*
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }

# Okio
-keep class sun.misc.Unsafe { *; }
-dontwarn java.nio.file.*
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn okio.**
-keep class okio.** {*;}
# >>>>>>>>>>>>>>>>>>>>>>>>  OkHttp  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  Retrofit2  Start >>>>>>>>>>>>>>>>>>>>>>>>
# Platform calls Class.forName on types which do not exist on Android to determine platform.
-dontnote retrofit2.Platform
# Platform used when running on RoboVM on iOS. Will not be used at runtime.
-dontnote retrofit2.Platform$IOS$MainThreadExecutor
# Platform used when running on Java 8 VMs. Will not be used at runtime.
-dontwarn retrofit2.Platform$Java8
# Retain generic type information for use by reflection by converters and adapters.
-keepattributes Signature
# Retain declared checked exceptions for use by a Proxy instance.
-keepattributes Exceptions

-dontwarn retrofit2.adapter.**

# Retrofit 2.X
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions

-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}

# >>>>>>>>>>>>>>>>>>>>>>>>  Retrofit2  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  Ormlite  Start >>>>>>>>>>>>>>>>>>>>>>>>
-keep class com.j256.ormlite.** {*;}
# >>>>>>>>>>>>>>>>>>>>>>>>  Ormlite  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  Butterknife  Start >>>>>>>>>>>>>>>>>>>>>>>>
# ButterKnife 7
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keep class **$$ViewInjector { *; }
-keepnames class * { @butterknife.InjectView *;}

-keepclasseswithmembernames class * {
    @butterknife.* <fields>;
}

-keepclasseswithmembernames class * {
    @butterknife.* <methods>;
}
# >>>>>>>>>>>>>>>>>>>>>>>>  Butterknife  End >>>>>>>>>>>>>>>>>>>>>>>>



# >>>>>>>>>>>>>>>>>>>>>>>>  热修复框架rocoofix  Start >>>>>>>>>>>>>>>>>>>>>>>>
-keep class com.dodola.rocoofix.** {*;}
-keep class com.lody.legend.** {*;}
# >>>>>>>>>>>>>>>>>>>>>>>>  热修复框架rocoofix  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>>  数据库加密不混淆  Start >>>>>>>>>>>>>>>>>>>>>>>>
-dontwarn com.google.common.**
-keep  class net.sqlcipher.** {*;}
-keep  class net.sqlcipher.database.** {*;}
# >>>>>>>>>>>>>>>>>>>>>>>>  数据库加密不混淆  End >>>>>>>>>>>>>>>>>>>>>>>>



# >>>>>>>>>>>>>>>>>>>>>>>> 七牛  Start >>>>>>>>>>>>>>>>>>>>>>>>
-keep class com.qiniu.** {*;}
-dontwarn com.qiniu.**
# >>>>>>>>>>>>>>>>>>>>>>>> 七牛  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>> UMeng大数据分析sdk混淆配置  Start >>>>>>>>>>>>>>>>>>>>>>>>
-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}

-dontwarn org.apache.http.**

-keep class org.apache.http.** { *;}

-keep class com.umeng.analytics.** {*;}
-dontwarn com.umeng.analytics.**

# >>>>>>>>>>>>>>>>>>>>>>>> UMeng大数据分析sdk混淆配置  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>> 高德相关混淆文件  Start >>>>>>>>>>>>>>>>>>>>>>>>
-keep class com.amap.api.** {*;}
-keep class com.autonavi.** {*;}
-keep class com.a.a.** {*;}
-keep class com.loc.** {*;}
-dontwarn com.amap.api.**
-dontwarn com.autonavi.**
-dontwarn com.a.a.**
-dontwarn com.loc.**
# >>>>>>>>>>>>>>>>>>>>>>>> 高德相关混淆文件  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>> 百度定位  End >>>>>>>>>>>>>>>>>>>>>>>>
-keep class com.baidu.** {*;}
-keep class vi.com.** {*;}
-dontwarn com.baidu.**
# >>>>>>>>>>>>>>>>>>>>>>>> 百度定位  End >>>>>>>>>>>>>>>>>>>>>>>>


# >>>>>>>>>>>>>>>>>>>>>>>> pinyin4j  Start >>>>>>>>>>>>>>>>>>>>>>>>
-dontwarn net.soureceforge.pinyin4j.**
-dontwarn demo.**
-keep class net.sourceforge.pinyin4j.** { *;}
-keep class demo.** { *;}
-keep class com.hp.** { *;}
# >>>>>>>>>>>>>>>>>>>>>>>> pinyin4j  End >>>>>>>>>>>>>>>>>>>>>>>>

# >>>>>>>>>>>>>>>>>>>>>>>> httpclient  Start >>>>>>>>>>>>>>>>>>>>>>>>
-dontwarn android.net.compatibility.**
-dontwarn android.net.http.**
-dontwarn com.android.internal.http.multipart.**
-dontwarn org.apache.commons.**
-dontwarn org.apache.http.**
-dontwarn org.apache.http.protocol.**
-keep class android.net.compatibility.**{*;}
-keep class android.net.http.**{*;}
-keep class com.android.internal.http.multipart.**{*;}
-keep class org.apache.commons.**{*;}
-keep class org.apache.org.**{*;}
-keep class org.apache.harmony.**{*;}
# >>>>>>>>>>>>>>>>>>>>>>>> pinyin4j  End >>>>>>>>>>>>>>>>>>>>>>>>


-dontwarn net.sf.json.**
-keep class net.sf.json.** {*;}

# 动画库
-keep class com.nineoldandroids.** {*;}
