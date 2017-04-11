//
//  NotificationKeyHeader.h
//  FC
//
//  Created by 侯明和 on 16/7/12.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#ifndef NotificationKeyHeader_h
#define NotificationKeyHeader_h

#pragma mark -------- 登录退出 --------
/** 弹出登录页面 */
#define LOGIN_ShowLoginViewController @"showLoginViewController"
/** 关闭登录页面 */
#define LOGIN_CloseLoginViewController @"closeLoginViewController"
/** 退出登录通知 */
#define LOGOUT_NXLogoutNotification @"NXLogoutNotification"

#pragma mark -------- 导诊 --------
/** 导诊页面取得推荐医院完成后，如果医院主页没有数据的话,通知它刷新一下 */
#define GUIDE_RefreshHospitalTopIfNeed @"refreshHospitalTopIfNeed"

#pragma mark -------- 就诊 --------

#pragma mark -------- 消息 --------
/** 收到推送时程序在后台运行，点击通知栏中的推送消息，跳转到消息页面 */
#define MESSAGE_ShowMessageViewController @"showMessageViewController"
/** APP 第一次启动并且在 NXNoticeTableViewController 中已经注册通知 */
#define MESSAGE_AppWillEnterForeground @"appWillEnterForeground"
/** 隐藏消息页小红点 */
#define MESSAGE_HideUnreadMessageBadgeNotification @"hideUnreadMessageBadgeNotification"
/** 显示小红点 */
#define MESSAGE_ShowUnreadMessageBadgeNotification @"showUnreadMessageBadgeNotification"
/** 刷新消息页面 */
#define MESSAGE_RefreshNoticeView @"refreshNoticeView"

#pragma mark -------- 病历 --------
#define TREATMENT_RefreshView @"TREATMENT_RefreshView"
#pragma mark -------- 个人 --------
/** 刷新就诊卡列表 */
#define PERSONAL_CardListNeedFresh @"cardListNeedFresh"


#pragma mark -------- Appdelegate --------
/** 从后台挂起是启动的通知（1、用于手势解锁，手势解锁目前没有用到 2、二维码扫描页面）*/
#define APPDELEGATE_NXEnterBackgroundNotification @"NXEnterBackgroundNotification"
/** 将要进入后台挂起推送 */
#define APPDELEGATE_NXPViewDidAppearNotification @"NXPViewDidAppearNotification"

/** 病情主诉图片浏览器刷新通知 */
#define ONlINEPICBEOWSER_Notification @"OnlinePicBrowserNotification"

#pragma mark -------- NXTabBarView --------
/** NXTabBarView 选中通知 */
#define NXTABARVIEW_DidSelecetdTabBarAtIndex @"didSelecetdTabBarAtIndex"

#pragma mark -------- 咨询详情跳转健康档案用 --------
#define NXJUMPTORECORDPAGE @"JUMPTORECORDPAGE"

#pragma mark -------- 病历详情跳转用 --------
#define NXJUMPTOMEDICALRECORD @"JumpToMedicalRecord"

#pragma mark -------- 病历详情跳转用 --------
#define NXJUMPTODOCHOMEPAGE @"jumpToDocHomePage"

#pragma mark -------- 判断是否是直播 --------
#define NXCHATNOWISBROADCAST @"CHATNOWISBROADCAST"

#pragma mark -------- 咨询评论后返回页面改变状态用 --------
#define NXEVALUATESCUSSACTION @"EVALUATESCUSSACTION"
#define NXEVALUATECANCEL @"EVALUATECANCEL"

#pragma mark -------- 腾讯登录 --------
#define NXTENCENT_LOGIN @"Tencent_Login"//腾讯登录

#endif /* NotificationKeyHeader_h */
