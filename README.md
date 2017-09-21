# README

## 需求原文:

新建一个 Rails 5.1 的项目，使其有登录注册接口。
要求：
1. 注册时必须通过手机号 & 验证码的方式注册，注册完成后可以设定登录密码
2. 用户可以使用手机号 & 验证码或手机号 & 密码的方式登录
3. 发送短信验证码写假代码，不必真的调用第三方短信接口
4. 有自动化接口测试代码（测试框架不限）

## 实现说明:

项目依赖 Redis.

新用户注册的必选项目只有手机号, 密码可选.

登录方式: 手机号+验证码 或 手机号+密码.

默认 "记住我".

短信接口加入防刷功能.