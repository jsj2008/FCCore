//
//  AMAGuideAPI.h
//  FCNetworkApi
//
//  Created by 周鑫 on 15/7/6.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAGuideAPI : NSObject


//modify by 2.8.0 thirft
//症状详情
+(void)getDisease:(int64_t)diseaseId success:(void(^)(NXTFGetDiseaseResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//查症状
+(void)getDiseases:(int32_t)bodyPart crowd:(int32_t)crowd comDeptId:(int32_t)comDeptId name:(NSString*)name page:(NXTFPage*)page success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 基于筛选条件获取医院列表 Modify by 2.14.0
 *  @param cityCode     城市编码(城市检索的优先条件)
 *  @param cityName     城市名称(城市编码为空时，该条件有效)
 *  @param specialtyId  擅长领域ID(DEF:全部)
 *  @param hospType     医院类型(0:综合 1:妇产 2:儿童 3:妇幼 4:中医 5:肿瘤 6:皮肤 7:口腔 8:眼科)(DEF:全部)
 *  @param hospLevel    医院等级(1:三级甲等 2:三级 3:二级甲等 4:二级 5:一级甲等 6:一级)(DEF:全部)
 *  @param hospName     医院名称(医院名的模糊查询条件)
 *  @param comDeptId    通用科室ID(DEF:全部)
 *  @param isRecommend  是否推荐医院(0:否(DEF) 1:是)
 *  @param orderBy      排序规则(0:患者数(DEF) 1:医院等级 2:距离) 注意：2:距离排序时，currentLng、currentLat 必须设定
 *  @param isOpened     是否开通(0:未开通 1:已开通 DEF:全部)
 *  @param isOpenNet    是否开通互联网医院(0:全部(DEF) 1:只已开通)
 *  @param currentLng   定位位置(经度)
 *  @param currentLat   定位位置(纬度)
 *  @param page         分页信息
 *
 *  return hospitals   根据筛选条件获取对应的医院列表返回信息
 */
+(void)findHosps:(NSString *)cityCode cityName:(NSString *)cityName specialtyId:(NSString *)specialtyId hospType:(NSString *)hospType hospLevel:(NSString *)hospLevel hospName:(NSString *)hospName comDeptId:(NSString *)comDeptId isRecommend:(NSString *)isRecommend orderBy:(NSString *)orderBy isOpened:(NSString *)isOpened isOpenReg:(NSString *)isOpenReg isOpenNet:(NSString *)isOpenNet currentLng:(NSString *)currentLng currentLat:(NSString *)currentLat page:(NXTFPage *)page success:(void(^)(NXTFFindHospsResp *hospitals))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
// 医院,医生擅长
+(void)getSpecialties:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock ;

// modify by 3.8
/** 基于筛选条件获取医生列表
 *  @param cityCode	string	城市编码(城市检索的优先条件)
 *  @param cityName	string	城市名称(城市编码为空时，该条件有效)
 *  @param specialtyId	i32	擅长领域ID(DEF:全部)
 *  @param comDeptId	i32	通用科室ID(DEF:全部)
 *  @param hospitalId	i32	医院ID(hospId设定的场合，hospType、hospLevel条件无效)
 *  @param hospType	i32	医院类型(0:综合 1:妇产 2:儿童 3:妇幼 4:中医 5:肿瘤 6:皮肤 7:口腔 8:眼科)(DEF:全部)
 *  @param hospLevel	i32	医院等级(1:三级甲等 2:三级 3:二级甲等 4:二级 5:一级甲等 6:一级)(DEF:全部)
 *  @param isExpert	i32	是否专家(0:全部 1:只专家 2:专家以外)(DEF:全部)
 *  @param isRegisted	i32	是否可挂号(0:全部 1:只可挂号)(DEF:全部)
 *  @param docName	string	医生名(医生名的模糊查询条件)
 *  @param isRecommend	i32	是否推荐医院(0:否(DEF) 1:是)
 *  @param orderBy	i32	排序规则(0:预约数(DEF) 1:医院等级 2:大象评级 3:评价 4:问诊量 5:咨询价格)
 *  @param isConsulted	i32	是否可咨询(0:全部 1:可咨询[2、3、4任意可] 2:只图文咨询 3:只在线阅片 4:只视频咨询)(DEF:全部)
 *  @param docLevel i32 医生级别ID(0:全部, 1:主任医师, 2:副主任医师, 3:主治医师, 4:医师, 5:助理医师)
 */
+(void)findDoctors:(NSString *)cityCode cityName:(NSString *)cityName specialtyId:(NSString *)specialtyId comDeptId:(NSString *)comDeptId hospitalId:(NSString *)hospitalId hospType:(NSString *)hospType hospLevel:(NSString *)hospLevel isExpert:(NSString *)isExpert isRegisted:(NSString *)isRegisted docName:(NSString *)docName isRecommend:(NSString *)isRecommend orderBy:(NSString *)orderBy isConsulted:(NSString *)isConsulted docLevel:(int32_t)docLevel page:(NXTFPage *)page success:(void(^)(NXTFFindDoctorsResp *doctors))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by 2.7.0 thirft
// 全局搜索，搜索医院医生病症
+(void)gdSearchWithCityName:(NSString *)cityName cityCode:(NSString *)cityCode searchText:(NSString *)searchText searchType:(NSString *)searchType page:(NXTFPage *)page success:(void(^)(NXTFGDSearchResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 描述: 获取自诊病症列表  认证方式:	默认签名
 *  @param clientDictVer 病症字典版本号(版本号与Server端版本号一致时，不返回数据。)
 */
+ (void)getAutognosisSyms:(NSString *)clientDictVer success:(void(^)(NXTFGetAutognosisSymsResp *getAutognosisSymsResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 描述：获取自诊详细 认证方式：默认签名
 *  @param crownId  i32                 人群ID(0：女性，1：男性，2：老人，3：儿童)
 *  @param symptoms	list<string>        症状信息列表
 *  @param dispMode i32                 自诊结果显示模式(0:科室单位(DEF)， 1:疾病单位)
 *  @param bodyPartId	i32             人体部位ID
 *  @param bodyPartName	string          人体部位名称
 *  return NXTFGetAutognosisDetailResp 获取自诊详细的返回信息
 *  add by xuyue 3.6
 */
+ (void)getAutognosisDetail:(int32_t)crownId symptoms:(NSMutableArray *)symptoms dispMode:(int32_t)dispMode bodyPartId:(int32_t)bodyPartId bodyPartName:(NSString *)bodyPartName success:(void(^)(NXTFGetAutognosisDetailResp *getAutognosisDetailResp))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 描述: 获取自诊疾病结果  认证方式:	默认签名
 *  @param diseaseId  i64        	疾病ID
 */
+ (void)getAutognosisDis:(int64_t)diseaseId success:(void(^)(NXTFGetAutognosisDisResp *getAutognosisDisResp))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
