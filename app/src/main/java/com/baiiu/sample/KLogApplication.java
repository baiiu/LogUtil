package com.baiiu.sample;

import android.app.Application;

import com.baiiu.library.LogUtil;


/**
 * Created by zhaokaiqiang on 15/11/14.
 */
public class KLogApplication extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        LogUtil.init(BuildConfig.DEBUG);
    }
}
