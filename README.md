# LogUtil

This project is forked from [KLog](https://github.com/ZhaoKaiQiang/KLog).
I make it implements `HttpLoggingInterceptorM.Logger` so that it can log information with OkHttp.
 
So it must be used with okHttp which version now is `3.4.1`. 
So you can create your Logger in this way.


# Problems
There is a problems when Multithreading conflicts.
