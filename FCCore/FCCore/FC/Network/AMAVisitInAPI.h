//
//  AMAVisitInAPI.h
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAVisitInAPI : NSObject

//modify by 2.8.0 thirft
//获得当前用户排队候诊信息
+(void)getQue:(int64_t)patientId hospId:(int32_t)hospId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//绑定就诊卡。如果用户第一次绑定，那么给患者新增就诊卡；如果用户更新已有的就诊卡，那么判断数据是否变更，数据变更则设置原就诊卡数据为失效状态，同时插入新的就诊卡，如果数据未变更，那么不进行数据操作。
+(void)bindMedCard:(NSString *)hospId patientId:(NSString *)patientId markType:(NSString *)markType markNo:(NSString *)markNo success:(void(^)(NSString *cardNo))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/**
 *  @desc 获取患者绑定的就诊卡和住院号信息
 *  @param patientId    i64	就诊人ID	optional
 *  @param hospitalId       i32	医院ID 从医院主页点击就诊卡充值按钮获取获取就诊卡列表时，hospId必须有值；从个人信息获取就诊卡列表时，该值为空	optional
 *  @param mode         i32	模式(就诊卡=1,住院卡=2)	optional	1
 *  @param cardTarget	i32	卡类型(0:只获取主卡、1:获取全部卡)	optional
 *  @param markSubType	i32	是否可充值 0：否 1：是
 
 */
+(void)getMedCards:(NSString *)patientId hospitalId:(NSString *)hospitalId mode:(int32_t)mode cardTarget:(NSString *)cardTarget markSubType:(int32_t)markSubType success:(void(^)(NXTFGetMedCardsResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//患者自动医院注册门诊号
+(void)regCardNo:(NSString *)hospId patientId:(NSString *)patientId success:(void(^)(NSString *cardNo))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//诊疗接口
+(void)getMedInfos:(int64_t)patientId page:(NXTFPage *)page success:(void(^)(NXTFGetMedInfosResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//症状描述
//add symptomPics 图片数组 at 4.2.0 by houmh
+(void)descSymptom:(int64_t)regId symptom:(NSString *)symptom disease:(NSString *)disease symptomPics:(NSMutableArray *)symptomPics success:(void(^)(BOOL ret))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取病人主诉信息
 *  @param regId    i64 挂号ID
 */
+ (void)getDescSymptom:(int64_t)regId success:(void(^)(NXTFGetDescSymptomResp *getDescSymptomResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//绑定住院号
+(void)bindInpatientNo:(NSString *)patientId hospId:(NSString *)hospId inpatientNo:(NSString *)inpatientNo success:(void(^)())successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.6.0 thirft
// 查询住院历史纪录
+(void)getInpatientInfos:(NSString *)patientId hospId:(NSString *)hospId inpatientNo:(NSString *)inpatientNo success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.6.0 thirft
//查询住院预交金缴纳记录
+(void)getPrePaymentDetail:(NSString *)patientId  hospId:(NSString *)hospId recordId:(NSString *)recordId success:(void(^)(NXTFGetPrePaymentDetailResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.6.0 thirft
//缴纳住院预交金(生成订单)
+(void)inpatientPrePayment:(NSString *)patientId totalFee:(NSString *)totalFee recordId:(NSString *)recordId  success:(void(^)(NXTFInpatientPrePayment *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.7.0 thirft
//获取住院的费用清单
+(void)getInpatientFeeDetail:(int64_t)patientId hospId:(int64_t)hospId recordId:(int64_t)recordId   feeDate:(NSString *)feeDate success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.7.0 thirft
//取得住院信息
+(void)getInpatientInfo:(int64_t)patientId hospId:(int32_t)hospId recordId:(int64_t)recordId success:(void(^)(NXTFInpatientInfo *model)) successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.7.0 thirft
//获取住院费用一览(每日的费用总额)
+(void)getInpatientFeeList:(int64_t)patientId hospId:(int32_t)hospId recordId:(int64_t)recordId success:(void(^)(NXTFGetInpatientFeeListResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.4.0 thirft
//删除就诊卡
+(void)removeMedCard:(int64_t)patientId hospId:(int32_t)hospId cardId:(int64_t)cardId success:(void(^)(NXTFRemoveMedCardResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.4.0 thirft
//设定/取消默认就诊卡
+(void)setDefaultCard:(int64_t)patientId hospId:(int32_t)hospId cardId:(int64_t)cardId isDefault:(int32_t)isDefault success:(void(^)(NXTFSetDefaultCardResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.10.0 thirft
//获取病历信息
+(void)getEmrInfo:(int64_t)regId hospId:(int32_t)hospId patientId:(int64_t)patientId success:(void(^)(NXTFGetEmrInfoResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.11.0 thirft
//获取科室/医生排班表信息
+(void)getVisits:(int32_t)hospId hisDeptId:(NSString *)hisDeptId deptId:(int64_t)deptId startDate:(NSString *)startDate endDate:(NSString *)endDate scheduleType:(int32_t)scheduleType success:(void(^)(NXTFGetVisitsResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 4.5.0 thirft houmh
+(void)authPmr:(NSMutableArray *)authPmrs success:(void(^)(NXTFAuthPmrResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

/**
 *  @desc   查询就诊卡余额 add by 4.5 xu
 *  @param  hospId      i32     医院ID    optional
 *  @param  patientId	i64     患者ID    optional
 *  @param  markType	string	就诊卡类型   default
 *  @param  markNo      string	就诊卡号    default
 *  @param  pwd         string	就诊卡密码(需要密码时使用)  default
 */
+ (void)getChargeBalance:(int32_t)hospId patientId:(int64_t)patientId markType:(NSString *)markType markNo:(NSString *)markNo pwd:(NSString *)pwd success:(void(^)(NXTFGetChargeBalanceResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/**
 *  @desc   创建就诊卡充值订单
 *  @param  cardId      i64     门诊卡ID optional
 *  @param  paymentFee	double	充值金额 optional
 */
+ (void)orderCharge:(int64_t)cardId paymentFee:(double)paymentFee success:(void(^)(NXTFOrderChargeResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
