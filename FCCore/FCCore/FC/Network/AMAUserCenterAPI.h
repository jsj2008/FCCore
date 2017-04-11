//
//  AMAUserCenterAPI.h
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAUserCenterAPI : NSObject

//modify by 2.5.0 thirft
//登录
+(void)signIn:(NSString *)phoneNo pwd:(NSString *)pwd signInMode:(int32_t)signInMode authCode:(NSString *)authCode success:(void(^)(NXTFSignInResp *userInfo))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//注销，退出登录
+(void)signOut:(NSString *)userId success:(void(^)(BOOL success))successBlock;

//modify by 2.8.0 thirft
//添加就诊人
+(void)addPatient:(NXTFPatientDto*)patientInfo success:(void(^)(NXTFPatientDto *patientInfo))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//修改就诊人
// modeType	i32	操作类型。默认：0（更新所有传入字段）；1：只更新身份证照片和认证状态
+(void)modifyPatient:(NXTFPatientDto*)patientInfo modeType:(int32_t)modeType success:(void(^)(NXTFPatientDto *patientInfo))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//删除就诊人
+(void)removePatient:(NSString *)patientId success:(void(^)(NXTFRemovePatientResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取就诊人列表
+(void)queryPatients:(NSString *)patientId name:(NSString *)name phoneNo:(NSString *)phoneNo hospId:(NSString *)hospId success:(void(^)(NSMutableArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 收藏/取消收藏医生
 *  userId   是 用户ID
 *  drId     是 医生ID
 *  operType 是 操作类型。0：取消收藏；1：收藏医生
 */
+(void)favorDr:(int64_t)drId operType:(NSString *)operType success:(void(^)(int32_t favorCount))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 收藏医生列表
 *  userId   是 用户ID
 */
+(void)getFavorDrsSuccess:(void(^)(NSMutableArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 描述:获取用户收藏医院列表
 *  认证方式     Token
 *  add by 2.12.0
 */
+ (void)getFavorHospsSuccess:(void(^)(NXTFGetFavorHospsResp *resp)) successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 提交反馈
 *  userId   是 用户ID
 */
+(void)feedback:(NSString *)feedback success:(void(^)(BOOL isSuccess))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.8.0 thirft
/** 获取医院的字典数据，可以用来获取就诊卡类型等字典数据
 *  hospId   是 医院ID
 */
+(void)getDictData:(NSString *)hospId dictType:pwddictType success:(void(^)(NXTFGetDictDataResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
/** 更改密码
 *  phoneNO   是 用户手机号
 */
+(void)changePwd:(NSString *)phoneNo pwd:(NSString *)pwd newPwd:(NSString *)newPwd authCode:(NSString *)authCode success:(void(^)(NXTFChangePwdResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取最新版本信息
+(void)getLatestVer:(void(^)(NXTFGetLatestVerResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.5.0 thirft
//用户基本信息
+(void)getPref:(void(^)(NXTFGetPrefResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//发送验证码
+(void)reqAuthCode:(NSString *)phoneNo reqMode:(int32_t)reqMode sendType:(int32_t)sendType success:(void(^)(NXTFReqAuthCodeResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//注册
+(void)signUp:(NSString *)phoneNo pwd:(NSString *)pwd authCode:(NSString *)authCode name:(NSString *)name papersNo:(NSString *)papersNo papersTypeId:(int32_t)papersTypeId success:(void(^)(NXTFSignUpResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.8.0 thirft
//修改姓名、手机号、修改手机号发送验证码
+(void)updateUser:(int32_t)updMode accountName:(NSString *)accountName newPhoneNo:(NSString *)newPhoneNo pwd:(NSString *)pwd authCode:(NSString *)authCode success:(void(^)(NXTFUpdateUserResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//上传头像
+ (void)uploadPatientHead:(NSData *)patientHead patientId:(NSString *)patientId success:(void(^)(NXTFPatientHeadResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.7.0 thirft zhuenkai
//关联聊天帐号
+(void)registerImWithSuccess:(void(^)(NXTFRegisterImResp *imAccountResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 3.7.0 thirft zhuenkai
//获取聊天服务器地址
+(void)getImHostsWithSuccess:(void(^)(NXTFGetImHostsResp *imHostResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取大象商城推荐列表 */
+ (void)getRecomOptsSuccess:(void(^)(NXTFGetRecomOptsResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取保险信息列表
 *  page NXTFPage   分页信息
 *   1	pageNo	i32	当前页码,从1开始	default	1
 *   2	pageSize	i32	每页数量量	default	10
 *   3	total	i64	数据总量	optional
 *  companyId	i32	保险公司id 查询某个保险公司的保险产品列表时用。对应页面上的店铺按钮
 */
+ (void)getInsInfos:(NXTFPage *)page companyId:(int32_t)companyId Success:(void(^)(NXTFGetInsInfosResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取保险产品详细
 *  companyId	i32	保险公司id	optional
 *	packageId	i32	保险产品id	optional
 */
+ (void)getInsPkg:(int32_t)packageId Success:(void(^)(NXTFGetInsPkgResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 4.4 thirft houmh
/** 获取健康档案详情
 *  patientId   i64 患者ID
 */
+ (void)getHealthProfile:(int64_t)patientId Success:(void(^)(NXTFGetHealthProfileResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取随访记录列表
 *  patientId   i64 患者ID
 */
+ (void)getVisitList:(int64_t)patientId code:(NSString *)code card:(NSString *)card page:(NXTFPage *)page hospId:(int32_t)hospId Success:(void(^)(NXTFGetVisitListResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 获取随访详细信息
 *  chid        string  主键
 *  visitType   i64     随访类型（1、高血压 2、糖尿病）
 */
+ (void)getVisitDetail:(NSString *)chid visitType:(int32_t)visitType patientId:(int64_t)patientId hospId:(int32_t)hospId Success:(void(^)(NXTFGetVisitDetailResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 4.5.0 by chenda

/**
 修改用户信息

 @param newNickName 用户昵称
 @param successBlock 成功Block
 @param failureBlock 失败Block
 */
+(void)updateNickName:(NSString *)newNickName success:(void(^)(NXTFUpdateUserResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;
@end
