package com.baiiu.sample;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.baiiu.library.LogUtil;
import com.baiiu.library.okHttpLog.HttpLoggingInterceptorM;
import com.baiiu.library.okHttpLog.LogInterceptor;
import com.baiiu.sample.retrofit.GankIODay;
import com.baiiu.sample.retrofit.GitHubAPI;
import com.baiiu.sample.retrofit.Repo;
import com.baiiu.sample.retrofit.User;

import java.util.List;

import okhttp3.OkHttpClient;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava.RxJavaCallAdapterFactory;
import retrofit2.converter.gson.GsonConverterFactory;
import rx.Subscriber;
import rx.android.schedulers.AndroidSchedulers;
import rx.schedulers.Schedulers;

/**
 * author: baiiu
 * date: on 16/5/28 10:59
 * description: 与Retrofit结合
 */
public class RetrofitRxFragment extends Fragment {

    private static final String GITHUB_BASEURL = "https://api.github.com/";
    private GitHubAPI gitHubAPI;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_log, container, false);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //添加HttpLoggingInterceptor
        HttpLoggingInterceptorM interceptor = new HttpLoggingInterceptorM(new LogInterceptor());
        interceptor.setLevel(HttpLoggingInterceptorM.Level.BODY);
        OkHttpClient okHttpClient = new OkHttpClient.Builder().addInterceptor(interceptor)
                .build();

        //创建
        Retrofit retrofit = new Retrofit.Builder().client(okHttpClient)
                .baseUrl(GITHUB_BASEURL)
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJavaCallAdapterFactory.create())
                .build();

        gitHubAPI = retrofit.create(GitHubAPI.class);

        gitHubAPI.userInfo("baiiu")
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Subscriber<User>() {
                    @Override
                    public void onCompleted() {
                        LogUtil.d("onComplete");
                    }

                    @Override
                    public void onError(Throwable e) {
                        LogUtil.e(e.toString());
                    }

                    @Override
                    public void onNext(User user) {
                        LogUtil.d(user.toString());
                    }
                });

        gitHubAPI.listRepos("baiiu")
                .enqueue(new Callback<List<Repo>>() {
                    @Override
                    public void onResponse(Call<List<Repo>> call, Response<List<Repo>> response) {
                        List<Repo> body = response.body();
                        if (body != null) {
                            LogUtil.d(body.toString());
                        }
                    }

                    @Override
                    public void onFailure(Call<List<Repo>> call, Throwable t) {
                        LogUtil.d(t.toString());
                    }
                });

        getOneDay();
    }

    private void getOneDay() {
        String s = "http://gank.io/api/day/2015/08/07";
        gitHubAPI.getOneDay(s)
                .enqueue(new Callback<GankIODay>() {
                    @Override
                    public void onResponse(Call<GankIODay> call, Response<GankIODay> response) {
                    }

                    @Override
                    public void onFailure(Call<GankIODay> call, Throwable t) {
                    }
                });
    }
}
