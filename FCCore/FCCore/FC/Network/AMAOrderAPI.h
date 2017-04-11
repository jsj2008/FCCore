//
//  AMAOrderAPI.h
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCoreHeader.h"

@interface AMAOrderAPI : NSObject

+(NSString *)getOrderStatus:(int)payStatus;

+(NSString *)getPayWay:(int)payWayTypeId;

//modify by 2.8.0 thirft
//获取挂号信息
+(void)getReg:(int64_t)regId success:(void(^)(NXTFGetRegResp *getRegResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//客户端已经支付完成
+(void)clientPaid:(int64_t)orderId success:(void(^)(BOOL bSuccess))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//取消预约
+(void)cancelReg:(int64_t)orderId success:(void(^)(BOOL ret))successBlock failure:(void(^)(NSError *error))failureBlock ;

//modify by 2.8.0 thirft
//获得订单信息
+(void)getPayInfo:(NSString *)orderId payWayTypeId:(NSString *)payWayTypeId success:(void(^)(NSString *orderData))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取该医院支持的支付方式
+(void)getPayWays:(NSString *)hospId clientType:(int32_t)clientType srvType:(int32_t)srvType merchantNo:(NSMutableArray *)merchantNo success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取处方信息列表
+(void)getRecipes:(int64_t)regId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取处方信息列表
+(void)getRecipes:(int64_t)patientId hospId:(int32_t)hospId payStatus:(int32_t)payStatus fromDate:(NSString *)fromDate toDate:(NSString *)toDate success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock;

//modify by 2.8.0 thirft
//获取合并支付的支付ID和费用
+(void)orderRecipe:(NSString *)patientId regNo:(NSString *)regNo recipeIds:(NSArray *)recipeIds hospId:(NSString *)hospId scheduleType:(int32_t)scheduleType success:(void(^)(NSString *orderId,NSString *fee))successBlock failure:(void(^)(NSError *error))failureBlock;

// 自助分诊排队
+ (void)checkIn:(int64_t)regId success:(void(^)(NXTFCheckInResp *checkInResp))successBlock failure:(void(^)(NSError *error))failureBlock;

//到院支付接口
+ (void)regHospPay:(NSString *)orderId regId:(NSString *)regId success:(void(^)(NXTFRegHospPayResp *regHospPayResp))successBlock failure:(void(^)(NSError *error))failureBlock;

@end
