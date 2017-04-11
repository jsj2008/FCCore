//
//  AMAInsuranceAPI.h
//  FCNetworkApi
//
//  Created by xuyue on 16/7/28.
//  Copyright © 2016年 HZTeam. All rights reserved.
//  保险相关Api

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAInsuranceAPI : NSObject

/** 获取停诊险保单详细信息
 *  @param  regId	i64	挂号ID
 */
+ (void)getStInsDetail:(int64_t)regId success:(void(^)(NXTFGetStInsDetailResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取我的常用支付信息
 *  @param  patientId	i64	患者ID
 */
+ (void)getMyPayInfos:(int64_t)patientId success:(void(^)(NXTFGetMyPayInfosResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取停诊险理赔支持的银行列表
 *  @param  type    i32 银行卡类型 1 停诊险, 不传值时返回全部类型
 */
+ (void)getBanks:(int32_t)type success:(void(^)(NXTFGetStInsBanksResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 停诊险申请理赔
 *  @param  regId           i64     挂号ID                                           optional
 *  @param  payee           string	收款人姓名                                        default
 *  @param  payMethod       string	收款方式支付方式：01:银行转账, 02:支付宝, 03:微信     default
 *  @param  bankCode        string	开户银行代码(payMethod=01银行转账时必须)            default
 *  @param  bankName        string	开户银行名(payMethod=01银行转账时必须)              default
 *  @param  accountNum      string	微信、支付宝或银行账号                              default
 */
+ (void)reqStInsClaim:(int64_t)regId payee:(NSString *)payee payMethod:(NSString *)payMethod bankCode:(NSString *)bankCode bankName:(NSString *)bankName accountNum:(NSString *)accountNum success:(void(^)(NXTFReqStInsClaimResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取停诊险试算结果
 *  @param  regId           i64     挂号ID                                           optional
 */
+ (void)getStInsCalRs:(int64_t)regId success:(void(^)(NXTFGetStInsCalResultResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 停诊险下单(核保)
 *  @param  regId           i64     挂号ID                                           optional
 *  @param  messageId       string  流水号(UUID)                                           optional
 */
+ (void)orderStIns:(int64_t)regId messageId:(NSString *)messageId success:(void(^)(NXTFOrderStInsResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取停诊险支付信息
 *  @param  payWayTypeId    i32   	支付方式ID                                           optional
 *  @param  regId           i64     挂号ID                                           optional
 */
+ (void)getStInsPayInfo:(int32_t)payWayTypeId regId:(int64_t)regId success:(void(^)(NXTFGetStInsPayInfoResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
