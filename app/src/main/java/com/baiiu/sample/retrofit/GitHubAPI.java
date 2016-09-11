package com.baiiu.sample.retrofit;

import java.util.List;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;
import retrofit2.http.Url;
import rx.Observable;

/**
 * author: baiiu
 * date: on 16/5/16 14:40
 * description:
 *
 * github的API
 *
 * baiiu is an example user.
 */
public interface GitHubAPI {

  /**
   * ============================GET请求==============================
   */

  /*
    普通的
    https://api.github.com/users/baiiu
   */
  @GET("users/{user}") Observable<User> userInfo(@Path("user") String user);

  /*
    带路径参数
    使用 @Path 表示
    https://api.github.com/users/baiiu/repos
   */
  @GET("users/{user}/repos") Call<List<Repo>> listRepos(@Path("user") String user);

  @GET Call<GankIODay> getOneDay(@Url String url);
}
