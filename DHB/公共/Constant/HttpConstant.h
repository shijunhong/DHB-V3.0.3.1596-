//
//  HttpConstant.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/14.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#import "DHBConstant.h"

/*******************************************网络环境******************************/
//内外网判断 1:外网 0:内网
#define IF_NET Environment
//判断开发环境 1:发布 0:测试
#define IF_Ste Status
//https://api.dhb168.com res.dhb168.com 发布
//ypc.dhb168.com  yres.dhb168.com 预发布
//tmapi.dhb.net.cn tmobile.dhb.net.cn Tnew

#if IF_NET
#if IF_Ste
#define DEVHTTPURL_DOMAINNAME @"api.dhb168.com"
#define DEVHTTPURL_DOMIAN  ([NSString stringWithFormat: @"%@%@%@",DEVHTTPURL_DOMAINNAME,@"",@"/api.php"])

#define WEBHTTPURL_DOMAINNAME @"mobile.dhb168.com"
#define WEBHTTPURL_DOMIAN  ([NSString stringWithFormat: @"%@%@%@",WEBHTTPURL_DOMAINNAME,@"",@"/html/common"])
#define HTTP @"https://"
#else
#define DEVHTTPURL_DOMAINNAME @"tmapi.dhb.net.cn"
#define DEVHTTPURL_DOMIAN  ([NSString stringWithFormat: @"%@%@%@",DEVHTTPURL_DOMAINNAME,@"",@""])

#define WEBHTTPURL_DOMAINNAME @"tmobile.dhb.net.cn"
#define WEBHTTPURL_DOMIAN  ([NSString stringWithFormat: @"%@%@%@",WEBHTTPURL_DOMAINNAME,@"",@"/html/common"])
#define HTTP @"http://"
#endif
#else
#define DEVHTTPURL_DOMAINNAME @"10.1.66.106"
#define DEVHTTPURL_DOMIAN  ([NSString stringWithFormat: @"%@%@%@",DEVHTTPURL_DOMAINNAME,@"",@"/ndhb/www/api.php"])

#define WEBHTTPURL_DOMAINNAME @"10.1.66.106"
#define WEBHTTPURL_DOMIAN  ([NSString stringWithFormat: @"%@%@%@",WEBHTTPURL_DOMAINNAME,@":8888",@"/dhb2.0mobile/html/common"])
#define HTTP @"http://"
#endif

#define DEVHTTPURL  ([NSString stringWithFormat: @"%@%@",HTTP,DEVHTTPURL_DOMIAN])
#define WEBHTTPURL  ([NSString stringWithFormat: @"%@%@/",HTTP,WEBHTTPURL_DOMIAN])
/*******************************************网络环境******************************/


