//
//  HttpApi.h
//  VLCTest
//
//  Created by mrwang90hou on 2018/6/15.
//  Copyright © 2018年 csl. All rights reserved.
//

#ifndef HttpApi_h
#define HttpApi_h


//#define GKMAIN_URL @"https://www.zgzzwl.com.cn"
#define GKMAIN_URL @"https://home.zgzzwl.com.cn"
#define GKMAIN_URL_TEST @"http://allenryosuke.nat300.top"

//正式发布时需要改成1
#define RELEASEtoAPPSTORE 0

#if RELEASEtoAPPSTORE
// 1 = YES
#define GK_URL GKMAIN_URL
#else
// 0 = NO
#define GK_URL GKMAIN_URL_TEST
#endif


//private static String phone; //手机号码
//private static String code; //验证码
//private static String type = "3"; //类型码 暂时固定值
//#define key = "";
//private static String cookid;
//public static String cabid;

#define PhoneTypeID @"4"  //类型码 暂时固定值
//map.put("phone", et_sjh.getText().toString().trim());
//map.put("token", "PK1ET0sXJatywLfN");
#define TOKEN @"PK1ET0sXJatywLfN"  //类型码 暂时固定值
//短信发送
//#define SENDMessageURL @"/charge/smallrount/sendcode"
#define SENDMessageURL GK_URL @"/charge/smallrount/sendcode"

//账号登录
#define LOGINAccountURL GK_URL @"/charge/app/register"
//#define qrCodeURL GKMAIN_URL @"/charge/app/register";

//扫码进入充电页
#define SCANQRCodeChargeURL GK_URL @"/charge/smallrount/scan"
//#define saomachongdianURL GKMAIN_URL @"/charge/smallrount/scan";
//#define userId = "";
//#define socketId = "";
//用于做扫码判定,没有这个请求头认为不是充电宝
#define SMPDURL GKMAIN_URL @"/"

//客户端数据推送
#if RELEASEtoAPPSTORE
// 1 = YES
//#define WebSocketURL @"wss://www.zgzzwl.com.cn/charge/wsk"
#define WebSocketURL @"wss://home.zgzzwl.com.cn/charge/wsk"
#else
// 0 = NO
#define WebSocketURL @"ws://allenryosuke.nat300.top/charge/wsk"
#endif

#define KIP webSocketURL @"?type=selectcharge&userId=ca9899ae7c5b4d1e94d1e48957fac063&socketId=4e3937313233341315323137"
#define KIP2 @"ws://allenryosuke.nat300.top/charge/wsk?type=selectcharge&userId=56fb8c0de6494d44ac2614eea4edb1ff&socketId=4e3937313233341315363137"

//返回客户端数据推送地址
//public static String getWebSocketUrl() {
//    MLog.v(webSocketUrl + "?type=selectcharge&userId=" + userId + "&socketId=" + socketId);
//    //MLog.v(webSocketUrl + "?type=selectcharge&userId=" + userId + "&socketId=9999887712345612");
//    return webSocketUrl + "?type=selectcharge&userId=" + userId + "&socketId=" + socketId;
//    //return webSocketUrl + "?type=selectcharge&userId=03f194e58a16437fa8fc857a5dcabc45&socketId=9999887712345605";
//    //return webSocketUrl + "?type=selectcharge&userId=" + userId + "&socketId=9999887712345612";
//}

//租借充电线
#define RENTChargingLineURL GK_URL @"/charge/smallrount/lend"
//#define zjcdxURL GKMAIN_URL @"/charge/smallrount/lend";

//归还充电线
#define RETURNChargingLineURL GK_URL @"/charge/smallrount/back2"
//#define ghcdxURL GKMAIN_URL @"/charge/smallrount/back2";

//续租充电线
#define RENTChargingLineAgainURL GK_URL @"/charge/smallrount/rent"
//#define xzcdxURL GKMAIN_URL @"/charge/smallrount/rent";

//查询充电状态
#define CXChargingLineStatusURL GK_URL @"/charge/smallrount/havenlend"
//#define cxcdURL GKMAIN_URL @"/charge/smallrount/havenlend";

//查询用户账单列表
#define CXUserBillListURL GK_URL @"/charge/smallrount/not_order_list"
//#define yhzdListURL GKMAIN_URL @"/charge/smallrount/not_order_list";

//查询用户账单详细
#define CXUserBillDetailURL GK_URL @"/charge/smallrount/getdetail"
//#define yhzdqxURL GKMAIN_URL @"/charge/smallrount/getdetail";

//获取个人信息
#define GETUserInfoURL GK_URL @"/charge/smallrount/info"
//#define grxxURL GKMAIN_URL @"/charge/smallrount/info";

//上传故障信息
#define UPLOADFaultInfoURL GK_URL @"/charge/smallrount/newspaper"
//#define schzURL GKMAIN_URL @"/charge/smallrount/newspaper";

//获取故障列表
#define GETFaultListURL GK_URL @"/charge/smallrount/getworrylist"
//#define gzListURL GKMAIN_URL @"/charge/smallrount/getworrylist";

//获取故障详细信息
#define GETFaultDetailInfo GK_URL @"/charge/smallrount/getworryinfo"
//#define gzqxURL GKMAIN_URL @"/charge/smallrount/getworryinfo";

//获取公交车列表
#define GetBusListURL GK_URL @"/charge/smallrount/bus/bus_list"
//#define busListURL GKMAIN_URL @"/charge/bus/bus_list";

//获取评价订单
#define GETEvaluateOrderURL GK_URL @"/charge/smallrount/bus/detail"
//#define pjddUrl1 GKMAIN_URL @"/charge/bus/bus_detail";

//获取评价订单2
#define GETEvaluateOrderURL2 GK_URL @"/charge/smallrount/bus/detail2"
//#define pjddUrl2 GKMAIN_URL @"/charge/bus/bus_detail2";

//订单评价
#define OrderEvaluateURL GK_URL @"/charge/smallrount/bus/comments"
//#define ddpjURL GKMAIN_URL @"/charge/bus/comments";

//获取城市列表
//#define cityListURL GKMAIN_URL @"/charge/bus/location_list";
#define GETCityListURL GK_URL @"/charge/smallrount/bus/location_list"

//获取支付下单信息
//#define wxpayURL GKMAIN_URL @"/charge/pay_order";
#define GETPayInfoURL GK_URL @"/charge/smallrount/pay_order"

//上传个人头像名字
#define UPLOADPersonalHeaderImageURL GK_URL @"/charge/app/updateinfo"

#endif
