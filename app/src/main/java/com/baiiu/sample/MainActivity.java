package com.baiiu.sample;

import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;

import com.baiiu.library.LogUtil;


public class MainActivity extends AppCompatActivity {

    private static final String LOG_MSG = "LogUtil is a so cool Log Tool!";
    private static final String TAG = "CustomTag";
    private static String XML =
            "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!--  Copyright w3school.com.cn --><note><to>George</to><from>John</from><heading>Reminder</heading><body>Don't forget the meeting!</body></note>";
    private static String JSON;
    private static String JSON_LONG;
    private static String STRING_LONG;

    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        getSupportFragmentManager().beginTransaction()
                .replace(android.R.id.content, new RetrofitRxFragment(), RetrofitRxFragment.class.getName())
                .commitAllowingStateLoss();

        initView();
        initData();
    }

    private void initView() {
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolBar);
        if (toolbar != null) {
            toolbar.setTitleTextColor(Color.WHITE);
            setSupportActionBar(toolbar);
        }
    }

    private void initData() {
        JSON_LONG = getResources().getString(R.string.json_long);
        JSON = getResources().getString(R.string.json);
        STRING_LONG = getString(R.string.string_long);
    }

    public void log(View view) {
        LogUtil.v();
        LogUtil.d();
        LogUtil.i();
        LogUtil.w();
        LogUtil.e();
        LogUtil.a();
    }

    public void logWithNull(View view) {
        LogUtil.v(null);
        LogUtil.d(null);
        LogUtil.i(null);
        LogUtil.w(null);
        LogUtil.e(null);
        LogUtil.a(null);
    }

    public void logWithMsg(View view) {
        LogUtil.v(LOG_MSG);
        LogUtil.d(LOG_MSG);
        LogUtil.i(LOG_MSG);
        LogUtil.w(LOG_MSG);
        LogUtil.e(LOG_MSG);
        LogUtil.a(LOG_MSG);
    }

    public void logWithTag(View view) {
        LogUtil.v(TAG, LOG_MSG);
        LogUtil.d(TAG, LOG_MSG);
        LogUtil.i(TAG, LOG_MSG);
        LogUtil.w(TAG, LOG_MSG);
        LogUtil.e(TAG, LOG_MSG);
        LogUtil.a(TAG, LOG_MSG);
    }

    public void logWithLong(View view) {
        LogUtil.d(TAG, STRING_LONG);
    }

    public void logWithParams(View view) {
        LogUtil.v(TAG, LOG_MSG, "params1", "params2", this);
        LogUtil.d(TAG, LOG_MSG, "params1", "params2", this);
        LogUtil.i(TAG, LOG_MSG, "params1", "params2", this);
        LogUtil.w(TAG, LOG_MSG, "params1", "params2", this);
        LogUtil.e(TAG, LOG_MSG, "params1", "params2", this);
        LogUtil.a(TAG, LOG_MSG, "params1", "params2", this);
    }


    public void logWithJson(View view) {
        LogUtil.json("12345");
        LogUtil.json(null);
        LogUtil.json(JSON);
    }

    public void logWithLongJson(View view) {
        LogUtil.json(JSON_LONG);
    }

    public void logWithJsonTag(View view) {
        LogUtil.json(TAG, JSON);
    }

    public void logWithFile(View view) {
        LogUtil.file(Environment.getExternalStorageDirectory(), JSON_LONG);
        LogUtil.file(TAG, Environment.getExternalStorageDirectory(), JSON_LONG);
        LogUtil.file(TAG, Environment.getExternalStorageDirectory(), "test.txt", JSON_LONG);
    }

    public void logWithXml(View view) {
        LogUtil.xml("12345");
        LogUtil.xml(null);
        LogUtil.xml(XML);
    }

    ///////////////////////////////////////////////////////////////////////////
    // MENU
    ///////////////////////////////////////////////////////////////////////////

    @Override public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_about, menu);
        return true;
    }

    @Override public boolean onOptionsItemSelected(MenuItem item) {

        switch (item.getItemId()) {
            case R.id.action_github:
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://github.com/ZhaoKaiQiang/LogUtil")));
                break;
            case R.id.action_blog:
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("http://blog.csdn.net/zhaokaiqiang1992")));
                break;
        }

        return super.onOptionsItemSelected(item);
    }

}
