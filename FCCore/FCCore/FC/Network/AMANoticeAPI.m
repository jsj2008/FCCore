//
//  AMANoticeAPI.m
//  Anymed
//
//  Created by 周鑫 on 3/27/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import "AMANoticeAPI.h"
#import "AMDBHelper.h"
#import "NotificationKeyHeader.h"

@implementation AMANoticeAPI

+(void)getNotices:(NSString *)userId success:(void(^)(NSArray *array))successBlock {
    
    NSArray *retArray = [AMDBHelper getNotices:userId];
    successBlock(retArray);
    
}

+(void)getNotices:(NSString *)userId category:(NSString *)category success:(void(^)(NSArray *array))successBlock {
    NSArray *retArray = [AMDBHelper getNotices:userId category:category];
    successBlock(retArray);
    
}

+(void)addNotice:(AMMNotice *)notice {
    [AMDBHelper replaceNotices:notice];
}

+(void)replaceNoticesWithArray:(NSArray * )array {
    [AMDBHelper replaceNoticesWithArray:array];
}

+(void)modifyUnreadByCategory:(NSString *)userId category:(NSString *)category {
    [AMDBHelper modifyUnreadByCategory:userId category:category];
}

+(void)modifyUnread:(NSString *)index {
    [AMDBHelper modifyUnread:index];
}


+ (void)deleteNotices:(NSString *)userid category:(NSString *)category {
    [AMDBHelper deleteNotices:userid category:category];
}

+ (void)deleteNotice:(NSString *)index {
    [AMDBHelper deleteNotice:index];
}

+ (void)deleteNotices:(NSArray *)array {
    [AMDBHelper deleteNotices:array];
}

+(void)addNoticeFromApns:(NSDictionary *)noticeDic {
    
    [self saveNeedShowUnreadMessage];
    [self showUnreadMessageBadgeIfNeed];
    
    if (noticeDic) {
        NSString *category      = [noticeDic objectForKey:@"category"];
        NSString *subCategory   = [noticeDic objectForKey:@"subCategory"];
        //咨询消息-->咨询回复
        if ([category isEqualToString:@"2"] && [subCategory isEqualToString:@"1"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshChatView" object:self userInfo:noticeDic];
        }
        AMMNotice * notice      =  [[AMMNotice alloc] init];
        
        // 消息Id
        if (noticeDic[@"msgId"]) {
            notice.msgId        = noticeDic[@"msgId"];
        }
        
        if (noticeDic[@"type"]) {
            notice.type         = noticeDic[@"type"];
        }
        
        // 离线咨询消息的userId以accountId字段返回来 zhuenkai v3.8
        if (noticeDic[@"accountId"]) {
            notice.userId       = noticeDic[@"accountId"];
        }
        if (noticeDic[@"userId"]) {
            notice.userId       = noticeDic[@"userId"];
        }
        if (noticeDic[@"orderId"]) {
            notice.orderId      = noticeDic[@"orderId"];
        }
        if (noticeDic[@"patientId"]) {
            notice.patientId    = noticeDic[@"patientId"];
        }
        if (noticeDic[@"hospId"]) {
            notice.hospId       = noticeDic[@"hospId"];
        }
        if (noticeDic[@"hospName"]) {
            notice.hospName     = noticeDic[@"hospName"];
        }
        if (noticeDic[@"regId"]) {
            notice.regId        = noticeDic[@"regId"];
        }
        if (noticeDic[@"bizId"]) {
            notice.regId        = noticeDic[@"bizId"];
        }
        if (noticeDic[@"reportId"]) {
            notice.reportId     = noticeDic[@"reportId"];
        }
        if (noticeDic[@"reportType"]) {
            notice.reportType   = noticeDic[@"reportType"];
        }
        if (noticeDic[@"status"]) {
            notice.status       = noticeDic[@"status"];
        }
        if (noticeDic[@"aps"][@"alert"]) {
            notice.alert        = noticeDic[@"aps"][@"alert"];
        }
        if (noticeDic[@"orderType"]) {
           notice.orderType     = noticeDic[@"orderType"];
        }
    
        //以下为 version 2.11.0新增字段 add by xuyue
        if (noticeDic[@"category"]) {
            notice.category     = noticeDic[@"category"];
        }
        if (noticeDic[@"subCategory"]) {
            notice.subCategory  = noticeDic[@"subCategory"];
        }
        if (noticeDic[@"dept"]) {
            notice.dept         = noticeDic[@"dept"];
        }
        if (noticeDic[@"docName"]) {
            notice.docName      = noticeDic[@"docName"];
        }
        if (noticeDic[@"fee"]) {
            notice.fee          = noticeDic[@"fee"];
        }
        if (noticeDic[@"medicalTime"]) {
            notice.medicalTime  = noticeDic[@"medicalTime"];
        }
        if (noticeDic[@"itemNos"]) {
            notice.itemNos      = noticeDic[@"itemNos"];
        }
        if (noticeDic[@"tradeTime"]) {
            notice.tradeTime    = noticeDic[@"tradeTime"];
        }
        if (noticeDic[@"bedNo"]) {
            notice.bedNo        = noticeDic[@"bedNo"];
        }
        if (noticeDic[@"balance"]) {
            notice.balance      = noticeDic[@"balance"];
        }
        if (noticeDic[@"anyMedDate"]) {
            notice.anyMedDate   = noticeDic[@"anyMedDate"];
        }
        if (noticeDic[@"anyMedPic"]) {
            notice.anyMedPic    = noticeDic[@"anyMedPic"];
        }
        if (noticeDic[@"anyMedSummary"]) {
            notice.anyMedSummary= noticeDic[@"anyMedSummary"];
        }
        if (noticeDic[@"anyMedTitle"]) {
            notice.anyMedTitle  = noticeDic[@"anyMedTitle"];
        }
        if (noticeDic[@"anyMedUrl"]) {
            notice.anyMedUrl    = noticeDic[@"anyMedUrl"];
        }
        if (noticeDic[@"docHead"]) {
            notice.docHead      = noticeDic[@"docHead"];
        }
        if (noticeDic[@"inpatientRecordId"]) {
            notice.inpatientRecordId = noticeDic[@"inpatientRecordId"];
        }
        if (noticeDic[@"msgBody"]) {
            notice.msgBody      = noticeDic[@"msgBody"];
        }
        if (noticeDic[@"docId"]) {
            notice.docId        = noticeDic[@"docId"];
        }
        if (noticeDic[@"reportName"]) {
            notice.reportName   = noticeDic[@"reportName"];
        }
        if (noticeDic[@"checkTime"]) {
            notice.checkTime    = noticeDic[@"checkTime"];
        }
        if (noticeDic[@"regDate"]) {
            notice.regDate      = noticeDic[@"regDate"];
        }
        if (noticeDic[@"iconUrl"]) {
            notice.iconUrl      = noticeDic[@"iconUrl"];
        }
        if (noticeDic[@"imId"]) {
            notice.imId         = noticeDic[@"imId"];
        }
        if (noticeDic[@"gender"]) {
            notice.gender       = noticeDic[@"gender"];
        }
        // 号点名称 add by v3.11 zhuenkai
        if (noticeDic[@"pointName"]) {
            notice.pointName    = noticeDic[@"pointName"];
        }
        
        // 互联网医院审核失败原因 add by zhuenkai v3.14
        if (noticeDic[@"reason"]) {
            notice.reason       = noticeDic[@"reason"];
        }
        
        // 互联网医院提示 add by zhuenkai v3.14
        if (noticeDic[@"notice"]) {
            notice.notice       = noticeDic[@"notice"];
        }
        
        // 互联网医院物流配送提醒:物流单号 add by zhuenkai v3.14
        if (noticeDic[@"logisNo"]) {
            notice.logisNo      = noticeDic[@"logisNo"];
        }
        
        // 互联网医院物流配送提醒:物流公司 add by zhuenkai v3.14
        if (noticeDic[@"logisCompany"]) {
            notice.logisCompany = noticeDic[@"logisCompany"];
        }
        
        // 互联网医院物流配送提醒:物流发货时间 add by zhuenkai v3.14
        if (noticeDic[@"logisSendTime"]) {
            notice.logisSendTime = noticeDic[@"logisSendTime"];
        }
        
        // 直播提醒 直播ID add by houmh v4.1
        if (noticeDic[@"actId"]) {
            notice.actId = noticeDic[@"actId"];
        }
        
        // 直播提醒 直播时间 add by houmh v4.1
        if (noticeDic[@"title"]) {
            notice.title = noticeDic[@"title"];
        }
        
        // 直播提醒 直播标题 add by houmh v4.1
        if (noticeDic[@"timeShow"]) {
            notice.timeShow = noticeDic[@"timeShow"];
        }
        
        // 挂号失败，停诊险退费描述 add by zhuenkai v4.1
        if (noticeDic[@"stopInsDesc"]) {
            notice.stopInsDesc = noticeDic[@"stopInsDesc"];
        }
        
        if (noticeDic[@"msgDate"]) {
            NSString *msgDateStr= noticeDic[@"msgDate"];
            NSDate *time        = [NSDate dateWithTimeIntervalSince1970:msgDateStr.doubleValue/1000];
            NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
            formatter.dateFormat        = @"YYYYMMddHHmmss";
            if (time) {
                notice.msgDate  = [formatter stringFromDate:time];
            }
        }
        
        if ([noticeDic[@"category"]isEqualToString:@"2"] && [noticeDic[@"subCategory"]isEqualToString:@"1"]) {
            notice.msgDate = noticeDic[@"msgDate"];
        }
        notice.unread           = @"1";
        
        ///*** 腾讯在线咨询扩展字段添加
        NSString *roomId = [noticeDic objectForKey:@"roomId"];
        if (roomId) {
            notice.roomId = roomId;
        }
        NSString *tImId = [noticeDic objectForKey:@"tImId"];
        if (roomId) {
            notice.tImId = tImId;
        }
        NSString *userName = [noticeDic objectForKey:@"userName"];
        if (userName) {
            notice.userName = userName;
        }
        
        // 就诊卡充值消息 add by xu v4.6
        NSString *cardNo = [noticeDic objectForKey:@"cardNo"];
        if (cardNo) {
            notice.cardNo = cardNo;
        }
        NSString *markNo = [noticeDic objectForKey:@"markNo"];
        if (markNo) {
            notice.markNo = markNo;
        }
        
        ///*** 就诊引导 v5.0  by 周鑫
        NSString *medGuide = [noticeDic objectForKey:@"medGuide"];
        if (medGuide) {
            notice.medGuide = medGuide;
        }
        
        ///*** 商城相关  by 周鑫
        //商品名称
        NSString *productName = [noticeDic objectForKey:@"productName"];
        if (productName) {
            notice.productName = productName;
        }
        //订单号
        NSString *orderNo = [noticeDic objectForKey:@"orderNo"];
        if (orderNo) {
            notice.orderNo = orderNo;
        }
        //成交时间
        NSString *finishTime = [noticeDic objectForKey:@"finishTime"];
        if (finishTime) {
            notice.finishTime = finishTime;
        }

        [self addNotice:notice];
        
        [self performSelector:@selector(postNotice) withObject:nil afterDelay:1.0f];
        
    }
}

+ (void) postNotice {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_RefreshNoticeView object:self userInfo:nil];
}

/** 保存需要显示消息小红点的flag */
+ (void)saveNeedShowUnreadMessage {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"1" forKey:@"unreadMessage"];
}

/** 显示消息的小红点 */
+ (void)showUnreadMessageBadgeIfNeed {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *isNeedShow = [userDefaults objectForKey:@"unreadMessage"];
    
    if ([isNeedShow isEqualToString:@"1"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MESSAGE_ShowUnreadMessageBadgeNotification object:nil];
    }
}

// 描述: 拉取消息列表
+ (void)pullMsgs:(int64_t)msgStartTime success:(void (^)(NXTFPullMsgsResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFPullMsgsReq *req = [[NXTFPullMsgsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (msgStartTime > 0) {
        [req setMsgStartTime:msgStartTime];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"pullMsgs:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFPullMsgsResp class]]) {
            NXTFPullMsgsResp *resp = (NXTFPullMsgsResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
