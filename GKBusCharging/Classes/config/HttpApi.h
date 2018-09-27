//
//  HttpApi.h
//  VLCTest
//
//  Created by mrwang90hou on 2018/6/15.
//  Copyright © 2018年 csl. All rights reserved.
//

#ifndef HttpApi_h
#define HttpApi_h
/****************************  URL  ******************************/
#define GKDOMAIN @"http://192.72.1.1"

#define DEBUG_URL @"http://192.72.1.1/cgi-bin/Config.cgi"
#define APPSTORE_URL @"http://192.72.1.1/cgi-bin/Config.cgi"

#warning ----生成iPA时需要改成1
#define DEBUG_MODE 1

#if DEBUG_MODE
// 1 = YES
#define GK_URL DEBUG_URL
#else
// 0 = NO
#define GK_URL APPSTORE_URL
#endif

//模糊视频
#define NOTHIGHDEFINITION @"rtsp://192.72.1.1/liveRTSP/av1"

//高清视频
#define HIGHDEFINITION @"rtsp://192.72.1.1/liveRTSP/av2"

//向上翻转-
#define UPWARD GK_URL @"?action=set&property=UpsideDown&value=Normal"
//向下翻转-
#define DOWNWARD GK_URL @"?action=set&property=UpsideDown&value=Upsidedown"
//开始录像-
#define STARTTHEVIDEO GK_URL @"?action=set&property=Video&value=record_start"
//停止录像-
#define STOPTHEVIDEO GK_URL @"?action=set&property=Video&value=record_stop"
//列出照片-
#define LISTPHOTOS GK_URL @"?action=dir&property=Photo&format=all&count=88&from=0"
//列出录像文件-
#define LISTVIDEOFILES GK_URL @"?action=dir&property=Normal&format=all&count=16&from=0"
//获取录像分辨率-
#define GETVIDEORESOLUTION GK_URL @"?action=get&property=Camera.Menu.VideoRes"
//获取照相分辨率-
#define GETPHOTORESOLUTION GK_URL @"?action=get&property=Camera.Menu.ImageRes"
//获取当前录像时长-
#define GETSTHECURRENTVIDEODURATION GK_URL @"?action=get&property=Camera.Record.Total"
//获取WiFi ssid和密码-
#define GETWIFI GK_URL @"?action=get&property=Net.WIFI_AP.SSID&property=Net.WIFI_AP.CryptoKey"
//设置WiFi ssid和密码-
#define SETWIFI GK_URL @"?action=set&property=Net.WIFI_AP.SSID&value=Neekin8830&property=Net.WIFI_AP.CryptoKey&value=1234567890
//查看菜单-
#define SEETHEMENU GK_URL @"?action=get&property=Camera.Menu.*"
//设定拍照模式-
#define SETPHOTOMODE GK_URL @"?action=set&property=UIMode&value=CAMERA"
//拍照
#define TAKEPHOTO GK_URL @"?action=set&property=Video&value=capture"
//设定录像模式-
#define SETVIDEOMODE GK_URL @"?action=set&property=UIMode&value=VIDEO"
//格式化SD卡1
#define DELETESDONE GK_URL @"?action=set&property=SD0&value=preformat"
//格式化SD卡2
#define DELETESDTWO GK_URL @"?action=set&property=SD0&value=format"

//删除照片/视频

//#define DELETEPHOTOS GK_URL @"?action=del&property=SD/Photo/NK_P20180820_173212_0_8.JPG"
#define DELETEPHOTOS GK_URL @"?action=del&property="
#define DELETEVIDEO GK_URL @"?action=del&property=SD/Normal/NK_D20180820_173338_1440.MP4"

////////////////////////////////////////

#define CHANGEPHPTORES GK_URL @"?action=set&property=Imageres&value="


#endif


/*
 总菜单
 action=get&property=Camera.Menu.*
 【录像】
         录音与不录音
         action=set&property=SoundIndicator&value=OFF
         action=set&property=SoundIndicator&value=ON
 
         开机自动录像
         action=set&property=Q-SHOT&value=ON
         action=set&property=Q-SHOT&value=OFF
 
         碰撞触发灵敏度
         action=set&property=Camera.Menu.GsensorLockLevel&value=0
         action=set&property=Camera.Menu.GsensorLockLevel&value=1
         action=set&property=Camera.Menu.GsensorLockLevel&value=2
         action=set&property=Camera.Menu.GsensorLockLevel&value=3
 
         循环录像
         action=set&property=VideoClipTime&value=1MIN
         action=set&property=VideoClipTime&value=3MIN
         action=set&property=VideoClipTime&value=5MIN
 
 【拍照】
         拍照分辨率
         action=set&property=Imageres&value=8MP
         action=set&property=Imageres&value=5MP
         action=set&property=Imageres&value=3MP
 
         连拍
         action=set&property=PhotoBurst&value=3_1SEC
         action=set&property=PhotoBurst&value=5_1SEC
 
         时间水印
         action=set&property=Camera.Menu.LogoTimeStamp&value=1
         action=set&property=Camera.Menu.LogoTimeStamp&value=0
 
 【通用设置】
         关机延时录像
         action=set&property=PowerOffDelay&value=5SEC
         action=set&property=PowerOffDelay&value=30SEC
         action=set&property=PowerOffDelay&value=60SEC
 
         停车监控
         action=set&property=Camera.Menu.ParkGsensorLevel&value=0
         action=set&property=Camera.Menu.ParkGsensorLevel&value=1
         action=set&property=Camera.Menu.ParkGsensorLevel&value=2
         action=set&property=Camera.Menu.ParkGsensorLevel&value=3
 
         闪烁频率
         action=set&property=Flicker&value=50Hz
         action=set&property=Flicker&value=60Hz
 
         高动态
         action=set&property=HDR&value=ON
         action=set&property=HDR&value=OFF
 
 【设备】
         SD格式化
         action=set&property=SD0&value=preformat
         上条指令得到回复后等2秒，再发
         action=set&property=SD0&value=format
 
         同步记录仪时间
         action=set&property=TimeSettings&value=2018$08$20$10$21$30
 
         恢复出厂设置
         action=set&property=FactoryReset&value=Camera
 
 
 
 【主页面操作按钮】
         启停录像
         action=set&property=Video&value=record_stop
         action=set&property=Video&value=record_start
 
         拍照
         action=set&property=Video&value=capture
 
         拍照模式
         action=set&property=UIMode&value=CAMERA
 
         录像模式
         action=set&property=UIMode&value=VIDEO
 */
