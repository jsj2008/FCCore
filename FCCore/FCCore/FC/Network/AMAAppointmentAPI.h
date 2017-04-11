//
//  AMAAppointmentAPI.h
//  AnyMed
//
//  Created by 周鑫 on 15/3/11.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAAppointmentAPI : NSObject

//modify by 2.8.0 thirft
/**
 @abst  获取通用科室列表
 @param showDesc    BOOL    是否返回通用科室简介, true返回,false不返回
 @param type        i32     类别 0:普通(DEF) 1:可咨询(add by xuyue 4.2)
 */
+(void)getComDepts:(BOOL)showDesc type:(int32_t)type success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取可以通过APP挂号的城市列表
+(void)getCities:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取医院详细信息
+(void)getHosp:(int32_t)hospId success:(void(^)(NXTFGetHospResp *getHospResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 获取医院的科室列表
 * @param hospId	i32	医院id
 * @param isMutiDept	i32	是否支持多级科室(0:否(DEF)，1:是)
 * @param scheduleType i32 排班类型(0:普通排班(DEF)，1:互联网排班)
 */
+(void)getDepts:(int32_t)hospId isMutiDept:(int32_t)isMutiDept scheduleType:(int32_t)scheduleType success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 5.1.0 thirft
//获取医生信息
+(void)getDr:(int64_t)drId dcId:(NSString *)dcId mode:(int32_t)mode success:(void(^)(NXTFGetDrResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 
 如果不传deptId，那么根据hospId获取医院通知。
 如果传了deptId，那么根据根据医院ID和科室ID获取科室的通知。
 *  hospId   是 医院ID
 *  deptId   是 科室ID
 */
+(void)getNotice:(int32_t)hospId deptId:(NSString *)deptId noticeType:(int32_t)noticeType success:(void(^)(NSString *string))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 根据医院ID获取院内地图
 *  hospId   是 医院ID
 */
+(void)getHospMaps:(int32_t)hospId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/**
 如果给定具体的deptId将根据科室去获取,
 否则根据comDeptId和cityName获取
 */
+(void)regTargets:(int32_t)comDeptId cityName:(NSString *)cityName deptId:(int64_t)deptId success:(void(^)(NXTFRegTargetsResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 描述:获取可挂号目标列表(新版挂号排班页接口)
 *  认证方式:	默认签名     add by 2.10.0 xuyue
 *  @param comDeptId    通用科室id             int32_t
 *  @param cityName     城市名称               string
 *  @param deptId       科室id                int64_t
 *  @param hospitalId   医院id                int32_t
 *  @param hisDeptId    院端HIS系统中科室的ID   string
 *  @param scheduleDate 排班日期yyyyMMdd       string
 *  @param scheduleType 排班类型(0:普通排班(DEF)，1:互联网排班) int32_t
 */
+(void)regTargets:(int32_t)comDeptId cityName:(NSString *)cityName deptId:(int64_t)deptId hospitalId:(int32_t)hospitalId hisDeptId:(NSString *)hisDeptId scheduleDate:(NSString *)scheduleDate scheduleType:(int32_t)scheduleType success:(void(^)(NXTFRegTargetsResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;


//modify by 2.8.0 thirft
/**
 获取号点(可分页的)
 */
+(void)regPoints:(int64_t)targetId targetType:(int32_t)targetType regLevelId:(NSString *)regLevelId deptId:(int64_t)deptId scheduleType:(int32_t)scheduleType page:(NXTFPage*)page success:(void(^)(NXTFRegPointsResp *regPointsResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/**
 抢占号点
 */
+(void)regPoint:(int64_t)patientId pointId:(NSString *)pointId pointName:(NSString *)pointName pointDate:(NSString *)pointDate regLevelId:(NSString *)regLevelId regLevelName:(NSString *)regLevelName deptId:(int64_t)deptId drId:(int64_t)drId visitTime:(NSString *)visitTime scheduleType:(int32_t)scheduleType success:(void(^)(NXTFRegPointResp *regPointResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/**
 根据医院ID获取该医院的就医指南
 */
+(void)getGuide:(NSString *)hospId success:(void(^)(NSString *string))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.11.0 thirft
/**
 收藏、取消收藏医院
 *  HospId   是 医院ID
 *  operType 是 操作类型。0：取消收藏；1：收藏医院
 */
+ (void)favorHosp:(int64_t)HospId operType:(NSString *)operType success:(void(^)(NXTFFavorHospResp *regPointResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.11 thirft
/**
 获取医院公告
 */
+ (void)getHospAnn:(NXTFPage *)page hospId:(int32_t)hospId success:(void(^)(NXTFGetHospAnnResp *getHospAnnResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.11 thirft
/**
 获取有排班的日期
 */
+ (void)getRegDates:(int32_t)hospId targetType:(int32_t)targetType docId:(int64_t)docId deptId:(int64_t)deptId hisDeptId:(NSString *)hisDeptId startDate:(NSString *)startDate endDate:(NSString *)endDate success:(void(^)(NXTFGetRegDatesResp *getRegDatesResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/**
 *  通过His数据获取医生信息
 *
 *  @param hisDrid      his医生ID
 *  @param hospid       医院ID
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
+ (void)getDrWithHis:(NSString *)hisDrid hospid:(int32_t)hospid success:(void(^)(NXTFGetDrResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 5.1.0 thrift ChenDa
 *  描述:获取可挂号科室
 *  认证方式:默认签名
 *  hospId  i32  医院ID
 */
+(void)getRegistedDept:(int32_t)hospId Success:(void(^)(NXTFGetRegistedDeptResp *regResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 5.1.0 thrift ChenDa
 *  描述:获取科室医生列表
 *  认证方式:默认签名
 *  deptId  i64  科室ID  optional
 */
+(void)getDeptDocs:(int64_t)deptId Success:(void(^)(NXTFDeptDocsResp *deptDocsResp))successBlock failure:(void(^)(NSError *error))failureBlock;


@end
