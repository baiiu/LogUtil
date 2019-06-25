package com.baiiu.sample;

import android.annotation.SuppressLint;

import com.baiiu.library.okHttpLog.HttpLoggingInterceptorM;
import com.baiiu.library.okHttpLog.LogInterceptor;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;

import okhttp3.Dns;
import okhttp3.OkHttpClient;

/**
 * author: zhuzhe
 * time: 2019/2/20
 * description: OkHttp有请求排队，区分Api请求和下载请求，使用时注意
 */
public enum OkHttpFactory {
    INSTANCE;


    private static final int TIMEOUT_CONNECTION = 5 * 1000; // 连接超时时间
    private static final int TIMEOUT_READ = 15 * 1000; // 读取超时时间
    private static final int TIMEOUT_WRITE = 15 * 1000; // 写入超时时间


    private final OkHttpClient okHttpClient;

    OkHttpFactory() {
        OkHttpClient.Builder builder = new OkHttpClient.Builder()

                // 失败重连
                .retryOnConnectionFailure(true)

                // timeout
                .connectTimeout(TIMEOUT_CONNECTION, TimeUnit.MILLISECONDS)
                .readTimeout(TIMEOUT_READ, TimeUnit.MILLISECONDS)
                .writeTimeout(TIMEOUT_WRITE, TimeUnit.MILLISECONDS)

                .dns(new DnsImpl())

                .hostnameVerifier(new HostnameVerifier() {
                    @SuppressLint("BadHostnameVerifier")
                    @Override
                    public boolean verify(String hostname, SSLSession session) {
                        // todo 拷贝平台代码
                        return true;
                    }
                });


        if (BuildConfig.DEBUG) {
            builder.addInterceptor(new HttpLoggingInterceptorM(new LogInterceptor()));
        }

        okHttpClient = builder.build();
    }

    private static class DnsImpl implements Dns {
        @Override
        public List<InetAddress> lookup(String hostname) throws UnknownHostException {
            if (hostname == null) throw new UnknownHostException("hostname == null");

            try {
                return Arrays.asList(InetAddress.getAllByName(hostname));
            } catch (Throwable ignored) {
                return new ArrayList<>();
            }
        }
    }


    public OkHttpClient getOkHttpClient() {
        return okHttpClient;
    }

}
