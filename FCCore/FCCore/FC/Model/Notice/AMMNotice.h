//
//  AMMNotice.h
//  Anymed
//
//  Created by 周鑫 on 3/26/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMNotice : NSObject

//消息Id
@property (nonatomic,strong) NSString *msgId;//version 3.12
//订单Id
@property (nonatomic,strong) NSString *orderId;//version 2.11.0
/**0 未支付,1 支付处理中,2 已支付,3 退费处理中,4 已退费,5 已取消,6 未知状态,7 支付失败,8 退费失败,9 支付异常，需要人工干预,10 退费异常，需要人工干预,11 交易关闭,12 有退款*/
@property (nonatomic,strong) NSString *status;//version 2.11.0
//用户Id
@property (nonatomic,strong) NSString *userId;//version 2.11.0
//消息内容
@property (nonatomic,strong) NSString *msgBody;//version 2.11.0
//消息类型  0 文本通知 1 支付通知 2 候诊排队通知 3 处方通知 4 报告通知 5 住院预交金通知 6 一键120通知 7 医生对咨询的答复
@property (nonatomic,strong) NSString *type;//version 2.11.0 这个保留
//消息类型 如:10.挂号,20.处方,30 住院预交金订单
@property (nonatomic,strong) NSString *orderType;//version 2.11.0
//就诊人Id
@property (nonatomic,strong) NSString *patientId;//version 2.11.0
//是否已读 1未读,0已读
@property (nonatomic,strong) NSString *unread;//version 2.11.0
//时间
@property (nonatomic,strong) NSString *msgDate;//version 2.11.0
//流水号
@property (nonatomic,strong) NSString *regId;//version 2.11.0
//医院ID
@property (nonatomic,strong) NSString *hospId;//version 2.11.0
//医院名称
@property (nonatomic,strong) NSString *hospName;//version 2.11.0
//报告ID
@property (nonatomic,strong) NSString *reportId;//version 2.11.0
//报告名称
@property (nonatomic,strong) NSString *reportName;//version 2.11.0
//报告类型
@property (nonatomic,strong) NSString *reportType;//version 2.11.0
//index
@property (nonatomic,strong) NSString *index;

/*以下 version 2.11.0新增字段 add by xuyue*/
/**消息大类:0 大象资讯,1 就诊提醒,2 在线咨询提醒,3 订阅资讯,4 住院提醒,5 一键120提醒*/
@property (nonatomic, copy) NSString *category;

/**0-0大象资讯
 *1-0挂号成功,1-1 挂号失败,1-2 挂号超时,1-3 就医提醒,1-4 候诊通知,1-5 支付成功,1-6 支付失败,1-7 退费成功,1-8 报告已出,1-9 医院提醒
 *2-0 咨询答复
 *3-0 默认小类
 *4-0 住院预交金通知,4-1 支付失败,4-2 支付成功,4-3 支付退费,4-4 文本通知
 */
/**消息小类*/
@property (nonatomic, copy) NSString *subCategory;

/**科室*/
@property (nonatomic, copy) NSString *dept;

/**医生名称*/
@property (nonatomic, copy) NSString *docName;

/**费用*/
@property (nonatomic, copy) NSString *fee;

/**就诊日期*/
@property (nonatomic, copy) NSString *medicalTime;

/**项目编号[逗号分割]*/
@property (nonatomic, copy) NSString *itemNos;

/**支付时间*/
@property (nonatomic, copy) NSString *tradeTime;

/**床号*/
@property (nonatomic, copy) NSString *bedNo;

/**余额*/
@property (nonatomic, copy) NSString *balance;

/**资讯标题*/
@property (nonatomic, copy) NSString *anyMedTitle;

/**资讯简介*/
@property (nonatomic, copy) NSString *anyMedSummary;

/**资讯时间*/
@property (nonatomic, copy) NSString *anyMedDate;

/**资讯封面访问路径*/
@property (nonatomic, copy) NSString *anyMedPic;

/**资讯页面访问路径*/
@property (nonatomic, copy) NSString *anyMedUrl;

/**医生头像*/
@property (nonatomic, copy) NSString *docHead;

/**	住院记录id*/
@property (nonatomic, copy) NSString *inpatientRecordId;

/**咨询内容*/
@property (nonatomic, copy) NSString *alert;

/**医生ID*/
@property (nonatomic, copy) NSString *docId;

/**检查时间*/
@property (nonatomic, copy) NSString *checkTime;

/**就诊时间*/
@property (nonatomic, copy) NSString *regDate;

/**头像地址*/
@property (nonatomic, copy) NSString *iconUrl;

/**聊天Id*/
@property (nonatomic, copy) NSString *imId;

/**性别，医生聊天用 add by zhuenkai v3.9*/
@property (nonatomic, copy) NSString *gender;

/**号点名称 add by zhuenkai v3.11*/
@property (nonatomic, copy) NSString *pointName;

/**消息是否选择，多选删除时使用 add by tenghaiyang 2016/1/27*/
@property (nonatomic) BOOL selected;

/**互联网医院审核失败原因 add by zhuenkai v3.14*/
@property (nonatomic, copy) NSString *reason;

/**互联网医院提示 add by zhuenkai v3.14*/
@property (nonatomic, copy) NSString *notice;

/**互联网医院物流配送提醒:物流单号 add by zhuenkai v3.14*/
@property (nonatomic, copy) NSString *logisNo;

/**互联网医院物流配送提醒:物流公司 add by zhuenkai v3.14*/
@property (nonatomic, copy) NSString *logisCompany;

/**互联网医院物流配送提醒:物流发货时间 add by zhuenkai v3.14*/
@property (nonatomic, copy) NSString *logisSendTime;

/**直播提醒 actId add by houmh v4.1*/
@property (nonatomic, copy) NSString *actId;

/**直播提醒 timeShow add by houmh v4.1*/
@property (nonatomic, copy) NSString *timeShow;

/**直播提醒 title add by houmh v4.1*/
@property (nonatomic, copy) NSString *title;

/**停诊险描述 stopInsDesc add by zhuenkai v4.1*/
@property (nonatomic, copy) NSString *stopInsDesc;

//*** 腾讯在线咨询扩展字段
@property (nonatomic, copy) NSString *tImId;        // 咨询患者腾讯ID
@property (nonatomic, copy) NSString *roomId;       // 咨询房间号
@property (nonatomic, copy) NSString *userName;     // 咨询患者名称

/** 就诊卡支付 门诊号 add by xu v4.6 */
@property (nonatomic, copy) NSString *cardNo;

/** 就诊卡支付 病历号 add by xu v4.6 */
@property (nonatomic, copy) NSString *markNo;

///*** 就诊引导  by 周鑫
@property (nonatomic, copy) NSString *medGuide;

///*** 商城相关  by 周鑫
@property (nonatomic, copy) NSString *productName; //商品名称
@property (nonatomic, copy) NSString *orderNo; //订单号
@property (nonatomic, copy) NSString *finishTime; //成交时间

- (NSString*)dateToNSString:(NSDate*)date;

@end
