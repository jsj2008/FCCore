//
//  AMMServiceCode.h
//  Anymed
//
//  Created by 周鑫 on 15/5/25.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMMServiceCode : NSObject

//挂号
@property (nonatomic,assign) BOOL supportAppointment;
//支付
@property (nonatomic,assign) BOOL supportPay;
//候诊
@property (nonatomic,assign) BOOL supportWaitting;
//报告
@property (nonatomic,assign) BOOL supportReport;
//处方支付
@property (nonatomic,assign) BOOL supportPrescriptionsPay;
//住院查看
@property (nonatomic,assign) BOOL supportInhospital;
//诊前症状
@property (nonatomic,assign) BOOL supportState;
//院内地图
@property (nonatomic,assign) BOOL supportMap;
//病例图片
@property (nonatomic,assign) BOOL supportIllness;
//给医生发送消息
@property (nonatomic,assign) BOOL supportMessage;
//医院消息推送
@property (nonatomic,assign) BOOL supportPush;
//门诊在线退费
@property (nonatomic,assign) BOOL supportRefund;
//当天在线退费
@property (nonatomic,assign) BOOL supportTodayRefund;
//处方查看
@property (nonatomic,assign) BOOL supportPrescriptionsList;
//住院支付
@property (nonatomic,assign) BOOL supportInhospitalPay;
//线下不使用门诊号
@property (nonatomic,assign) BOOL supportHiddenCardNo;
//一键120 add at 2.7.0
@property (nonatomic,assign) BOOL support120;
//未支付前显示处方项目 add at 2.7.0
@property (nonatomic,assign) BOOL supportNoPayRecipeDetail;
//不能自动绑定服务码 add at 2.8.0
@property (nonatomic,assign) BOOL supportDisableAutoRegCardNo;
// 支持候诊签到 add at 3.10.0
@property (nonatomic,assign) BOOL supportCheckIn;
// 支持Pacs报告图片 add at 3.10.0
@property (nonatomic,assign) BOOL supportPacsReportImage;
// 体检 add at 3.11.0
@property (nonatomic,assign) BOOL supportPhysicalExamination;
// 不支持分开支付处方 add 3.12  by 周鑫
@property (nonatomic,assign) BOOL supportPayPrescription;
///*** 婴幼儿无身份证绑卡 4.5  by 周鑫
@property (nonatomic, assign) BOOL supportIdentityCard;
// 就诊卡充值 add at 4.5 by xuyue
@property (nonatomic, assign) BOOL supportTopUpTreamentCard;


@end
