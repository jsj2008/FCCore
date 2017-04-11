//
//  AMADoctorAPI.h
//  FCNetworkApi
//
//  Created by zhuenkai on 11/23/15.
//  Copyright © 2015 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMADoctorAPI : NSObject

/** add by 2.9.0 thrift xuyue
 *  mod by 4.2.0 chenda
 *  描述:创建咨询信息
 *  认证方式:	默认签名
 *  header      请求头信息
 *  @param  docId       医生ID      string
 *  @param  desc        描述        string
 *  @param  patientId   患者ID      i64
 *  @param  serviceType 咨询类型     i32
 *  @param  fee         咨询费用     string
 *  @param  patientName 患者姓名     string
 *  @param  gender      患者性别     i32
 *  @param  timId       患者的timId  string
 */
+ (void)addConsult:(NSString *)docId desc:(NSString *)desc patientId:(int64_t)patientId serviceType:(int32_t)serviceType fee:(NSString *)fee patientName:(NSString *)patientName gender:(int32_t)gender timId:(NSString *)timId success:(void(^)(NXTFAddConsultResp *consultId))successBlock failure:(void(^)(NSError *error))failureBlock;
//结束咨询
/**  add by thrift chenda
 *  描述：结束咨询
 *  认证方式:	默认签名
 *  header          请求头信息
 *  @param  consultID  咨询ID
*/
+ (void)terminateConsultation:(NSString *)consultID success:(void(^)(NSString *status))successBlock failure:(void(^)(NSError *error))failureBlock;

//+ (void)addConsult:(int64_t)patientId docId:(NSString *)docId disease:(NSString *)disease symptom:(NSString *)symptom timId:(NSString *)timID success:(void(^)(NSString *consultId))successBlock failure:(void(^)(NSError *error))failureBlock;
//add by 2.9.0 thirft

//添加评分信息
/** add by 2.9.0 thrift houmh
 *  描述:添加评分信息
 *  认证方式:	默认签名
 *  header          请求头信息
 *  @param  enalType        评价类型(0:就诊评价 1:咨询评价)                 i32
 *  @param  bizId           evalType=0时：就诊ID/ evalType=1 时：咨询ID    string
 *  @param  patientName     患者名                   string
 *  @param  docId           医生ID                   i64
 *  @param  docName         医生名                   string
 *  @param  disease         病症名                   string
 *  @param  message         评价内容                 string
 *  @param  attitude        就诊，咨询评分(医生态度)   i32
 *  @param  effect          就诊评分(治疗效果)        i32
 *  @param  hospSrv         就诊评分(医院服务)        i32
 *  @param  waiting         就诊评分(候诊时间)        i32
 *  @param  consult         咨询评分(咨询效果)        i32
 */
+ (void)addEvaluate:(int32_t)enalType bizId:(NSString *)bizId patientName:(NSString *)patientName docId:(int64_t)docId docName:(NSString *)docName disease:(NSString *)disease message:(NSString *)message attitude:(int32_t)attitude effect:(int32_t)effect hospSrv:(int32_t)hospSrv waiting:(int32_t)waiting consult:(int32_t)consult success:(void(^)(NXTFAddEvaluateResp *msgDto))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 2.9.0 thrift xuyue
 *  描述:获取医生评价信息
 *  认证方式:Token
 *  header  Base.ReqHeader
 *  @param  page	Base.Page	分页信息
 *          pageNo	i32         当前页码,从1开始
 *          pageSize i32        每页数量量
 *          total	i64         数据总量
 *  @param  docId	i64         医生ID
 */
+ (void)getEvaluates:(NXTFPage *)page docId:(int64_t)docId success:(void(^)(NXTFGetEvaluatesResp *evaluateModel))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 2.9.0 thrift 周鑫
 *  mod by 4.3 ChenDa
 *  描述:获取咨询列表的请求信息
 *  认证方式:Token
 *  header  Base.ReqHeader
 *  @param  patientId 患者ID
 *  咨询列表数组
 */
+ (void)getConsults:(int64_t)patientId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

/**
 *  add by 4.3 ChenDa
 *  描述:获取咨询信息
 *  认证方式:Token
 *  header  Base.ReqHeader
 *  @param  roomId 房间ID
 */
+ (void)getConsultationWithRoomId:(NSString *)roomId success:(void(^)(NXTFConsultationDto *consultation))successBlock failure:(void(^)(NSError *error))failureBlock;



/** add by 3.7.0 thrift zhuenkai
 *  描述:获取医生IMID
 *  认证方式:Token
 */
+ (void)getDrImId:(int64_t)docId Success:(void(^)(NXTFGetDrImIdResp *drImIdResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 3.7.0 thrift zhuenkai
 *  描述:注册咨询
 *  认证方式:Token
 */
+ (void)registConsult:(int64_t)docId Success:(void(^)(NXTFRegistConsultResp *registConsultResp))successBlock failure:(void(^)(NSError *error))failureBlock;


//文件上传
+(void)fileUpload:(NSString *)groupName fileContent:(NSData *)fileContent fileExtName:(NSString *)fileExtName masterFilename:(NSString *)masterFilename slavePrefixName:(NSString *)slavePrefixName msgId:(NSString *)msgId ttl:(int32_t)ttl success:(void(^)(NXTFFileUploadResp *patientsResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//下载文件
+(void)fileDownload:(NSString *)groupName remoteFilename:(NSString *)remoteFilename msgId:(NSString *)msgId success:(void(^)(NXTFFileDownloadResp *patientsResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 4.1.0 thrift houmh
 *  描述:获取直播活动列表
 *  认证方式:默认签名
 *  sort  i32	排序规则 0:当前时间往后的直播列表(DEF) 1:当前时间往前的直播列表
 */
+(void)getActs:(int32_t)sort page:(NXTFPage *)page Success:(void(^)(NXTFGetActsResp *getActsResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 4.1.0 thrift houmh
 *  描述:获取最近直播
 *  认证方式:默认签名
 */
+(void)getLastestActSuccess:(void(^)(NXTFGetLastestActResp *getLastestActResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 4.1.0 thrift houmh
 *  描述:获取直播详情
 *  认证方式:默认签名
 *  actId  string  直播ID
 */
+(void)getActDetail:(NSString *)actId Success:(void(^)(NXTFGetActDetailResp *getActDetailResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 4.1.0 thrift houmh
 *  描述:预约直播
 *  认证方式:默认签名
 *  actId  string  直播ID
 */
+(void)registerLive:(NSString *)actId Success:(void(^)(NXTFRegLiveResp *regLiveResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** add by 4.1.0 thrift houmh
 *  描述:获取banners
 *  认证方式:默认签名
 *  area  i32  地域限制 0:无限制(全国DEF) 1:有限制(area为1时，需要传入cityCode)
 *  cityCode  string  城市code
 */
+(void)getBanners:(int32_t)area cityCode:(NSString *)cityCode Success:(void(^)(NXTFGetBannersResp *regLiveResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/**
 *  上传问诊图片 V4.5 by 周鑫
 *
 *  @param regId       挂号ID
 *  @param fileContent 文件内容
 *  @param hospId      医院ID
 *  @param picName     图片名称
 *
 */
+(void)upLoadTreatPic:(NSString *)regId hospId:(int32_t)hospId fileContent:(NSData *)fileContent picName:(NSString *)picName Success:(void(^)(NXTFUpLoadTreatPicResp *upLoadTreatPicResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/**
 *  查询互联网医院候诊队列信息 V4.6 by chenda
 *
 *  @param hospId       医院ID
 *
 */
+(void)getQueInfoWithHospId:(int32_t)hospId Success:(void(^)(NXTFGetQueInfoResp *getQueInfoResp))successBlock failure:(void(^)(NSError *error))failureBlock;


/**
 家庭医生签约 v5.1 by zhuenkai

 @param teamId 团队ID
 @param dwellerInfos list<DwellerInfo> 居民信息
 @param packageIds list<string> 签约套餐
 @param contractDuration 签约时长（以月份为单位
 @param hospId 医院ID
 @param docId 医生ID
 @param teamName 团队名称
 */
+(void)signContract:(NSString *)teamId dwellerInfos:(NSMutableArray *)dwellerInfos packageIds:(NSMutableArray *)packageIds contractDuration:(int32_t)contractDuration hospId:(int32_t)hospId docId:(int64_t)docId teamName:(NSString *)teamName success:(void(^)(NXTFSignContractResp *signContractResp))successBlock failure:(void(^)(NSError *error))failureBlock;


/**
 获取医生团队服务包 v5.1 by zhuenkai

 @param teamId 团队ID
 @param hospId 医院ID
 */
+(void)getPackageInfos:(NSString *)teamId hospId:(int32_t)hospId success:(void(^)(NXTFGetPackageInfosResp *getPackageInfosResp))successBlock failure:(void(^)(NSError *error))failureBlock;


/**
 签约团队详细 v5.1 by zhuenkai

 @param patientId 患者id
 */
+(void)getMyDoctor:(int64_t)patientId success:(void(^)(NXTFGetMyDoctorResp *getMyDoctorResp))successBlock failure:(void(^)(NSError *error))failureBlock;
@end
