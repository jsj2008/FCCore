//
//  AMAReportAPI.h
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAReportAPI : NSObject

//modify by 2.8.0 thirft
//获得报告列表
+(void)getReports:(NSString *)regId hospId:(NSString *)hospId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获得报告列表
+(void)getReports:(NSString *)patientId hospId:(NSString *)hospId reportType:(NSString *)reportType fromDate:(NSString *)fromDate toDate:(NSString *)toDate status:(NSString *)status success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获得报告详情
+(void)getReport:(NSString *)patientId reportId:(NSString *)reportId reportType:(NSString *)reportType hospId:(NSString *)hospId success:(void(^)(NXTFGetReportResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 3.10.0 thirft
//获得pacs报告图片
+(void)getPacsImg:(NSString *)patientId reportId:(NSString *)reportId hospId:(NSString *)hospId  success:(void(^)(NXTFGetPacsImgResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by tenghaiyang, 增加广告接口
+(void)getAdvertis:(NSString *)hospId  success:(void(^)(NXTFGetAdvertisResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//add by houminghe 广告点击统计
+(void)pointNum:(NSString *)adId hospId:(NSString *)hospId success:(void(^)(NXTFPointNumResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 3.11.0 thirft
//获得体检报告列表
+ (void)getPhysicalExaminationReports:(NSString *)hospId patientId:(int64_t)patientId success:(void(^)(NXTFPhysicalRptInfoResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 3.11.0 thirft
//获得体检报告详情 
+ (void)getgetPhysicalExaminationDetailReport:(NSString *)hospId physicalID:(NSString *)physicalID success:(void(^)(NXTFPhysicalReportResp *model))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
