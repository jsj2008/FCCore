//
//  AMAOrderAPI.m
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "AMAOrderAPI.h"
#import "AMDBHelper.h"

@implementation AMAOrderAPI

+(NSString *)getOrderStatus:(int)payStatus {
    
    NSString * string = @"未知状态";
    switch (payStatus) {
        case 0:
            string = @"未支付";
            break;
        case 1:
            string = @"支付处理中";
            break;
        case 2:
            string = @"已支付";
            break;
        case 3:
            string = @"退费处理中";
            break;
        case 4:
            string = @"已退费";
            break;
        case 5:
            string = @"已取消";
            break;
        case 6:
            string = @"未知状态";
            break;
        case 7:
            string = @"支付失败";
            break;
        case 8:
            string = @"退费失败";
            break;
        case 9:
            string = @"支付异常，需要人工干预";
            break;
        case 10:
            string = @"退费异常，需要人工干预";
            break;
        case 11:
            string = @"交易关闭";
            break;
        case 12:
            string = @"有退款";
            break;
        case 13:
            string = @"预约成功";
            break;
        case 101:
            string = @"已挂号";
            break;
        case 102:
            string = @"候诊中";
            break;
        case 103:
            string = @"诊疗中";
            break;
        case 104:
            string = @"等待报告";
            break;
        case 105:
            string = @"诊疗结束";
            break;
        default:
            break;
    }
    return string;
}


+(NSString *)getPayWay:(int)payWayTypeId {
    
    NSString * string = @"未知";
    switch (payWayTypeId) {
        case 1:
            string = @"银联在线支付";
            break;
        case 2:
        case 20:
            string = @"支付宝移动支付";
            break;
        case 3:
            string = @"微信移动支付";
            break;
        case 4:
            string = @"工商银行手机支付";
            break;
        case 5:
            string = @"招商银行手机支付";
            break;
        case 6:
            string = @"非大象就医平台支付";
            break;
        case 7:
            string = @"建设银行手机支付";
            break;
        case 9:
            string = @"一网通银行卡支付";
            break;
        case 10:
            string = @"大象支付";
            break;
        case 11:
            string = @"银联在线支付";
            break;
        case 21:
            string = @"支付宝手机网页支付";
            break;
        case 31:
            string = @"微信扫码支付";
            break;
        case 32:
            string = @"微信网页支付";
            break;
            
        default:
            break;
    }
    return string;
}

+(void)getReg:(int64_t)regId success:(void(^)(NXTFGetRegResp *getRegResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFGetRegReq *getRegReq = [[NXTFGetRegReq alloc] init];
    [getRegReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [getRegReq setRegId:regId];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getRegReq selName:@"getReg:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetRegResp class]]) {
            NXTFGetRegResp *getRegResp = (NXTFGetRegResp *)content;
            [AMDBHelper replaceHospsCode:getRegResp.hospId serviceCode:getRegResp.serviceCode];
            successBlock(getRegResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    

}


+(void)clientPaid:(int64_t)orderId success:(void(^)(BOOL bSuccess))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFClientPaidReq *getRegReq = [[NXTFClientPaidReq alloc] init];
    [getRegReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [getRegReq setOrderId:orderId];
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:getRegReq selName:@"clientPaid:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFClientPaidResp class]]) {
            successBlock(YES);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//取消预约
+(void)cancelReg:(int64_t)orderId success:(void(^)(BOOL ret))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFCancelRegReq *req = [[NXTFCancelRegReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (orderId > 0) {
       [req setOrderId:orderId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"cancelReg:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFCancelRegResp class]]) {
            successBlock(YES);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getPayInfo:(NSString *)orderId payWayTypeId:(NSString *)payWayTypeId success:(void(^)(NSString *orderData))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetPayInfoReq *req = [[NXTFGetPayInfoReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (orderId.length > 0 && orderId.intValue > 0) {
        [req setOrderId:orderId.intValue];
    }
    if (payWayTypeId.length > 0 && payWayTypeId.intValue > 0) {
        [req setPayWayTypeId:payWayTypeId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToSSlQuene:req selName:@"getPayInfo:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetPayInfoResp class]]) {
            NXTFGetPayInfoResp *resp = (NXTFGetPayInfoResp *)content;
            successBlock(resp.payInfo);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getPayWays:(NSString *)hospId clientType:(int32_t)clientType srvType:(int32_t)srvType merchantNo:(NSMutableArray *)merchantNo success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetPayWaysReq *req = [[NXTFGetPayWaysReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (hospId.length > 0 && hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (clientType > 0) {
        [req setClientType:clientType];
    }
    if (srvType > 0) {
        [req setSrvType:srvType];
    }
    if (merchantNo.count > 0) {
        [req setMerchantNo:merchantNo];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"getPayWays:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetPayWaysResp class]]) {
            NXTFGetPayWaysResp *resp = (NXTFGetPayWaysResp *)content;
            successBlock(resp.payWays);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getRecipes:(int64_t)regId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {

    NXTFGetRecipesReq *req = [[NXTFGetRecipesReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (regId > 0) {
        [req setRegId:regId];
    }
    
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"getRecipes:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetRecipesResp class]]) {
            NXTFGetRecipesResp *resp = (NXTFGetRecipesResp *)content;
            successBlock(resp.recipes);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    

}

+(void)getRecipes:(int64_t)patientId hospId:(int32_t)hospId payStatus:(int32_t)payStatus fromDate:(NSString *)fromDate toDate:(NSString *)toDate success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetRecipesReq *req = [[NXTFGetRecipesReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [req setPatientId:patientId];
    }
    
    if(payStatus >= 0) {
        [req setPayStatus:payStatus];
    }
    if(hospId >= 0) {
        [req setHospId:hospId];
    }
    if (toDate.length>0) {
        [req setToDate:toDate];
    }
    if (fromDate.length>0) {
        [req setFromDate:fromDate];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"getRecipes:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetRecipesResp class]]) {
            NXTFGetRecipesResp *resp = (NXTFGetRecipesResp *)content;
            successBlock(resp.recipes);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)orderRecipe:(NSString *)patientId regNo:(NSString *)regNo recipeIds:(NSArray *)recipeIds hospId:(NSString *)hospId scheduleType:(int32_t)scheduleType success:(void(^)(NSString *orderId,NSString *fee))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFOrderRecipeReq *req = [[NXTFOrderRecipeReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if(patientId.length > 0 && patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    if (regNo.length > 0) {
        [req setRegNo:regNo];
    }
    if(hospId.length > 0 && hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (recipeIds && recipeIds.count > 0) {
        NSMutableSet *set = [[NSMutableSet alloc] initWithArray:recipeIds];
        [req setRecipeIds:set];
    }
    if (scheduleType >= 0) {
        [req setScheduleType:scheduleType];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"orderRecipe:" success:^(id content) {
        if ([content isKindOfClass:[NXTFOrderRecipeResp class]]) {
            NXTFOrderRecipeResp *resp = (NXTFOrderRecipeResp *)content;
            
            successBlock(resp.orderId,resp.fee);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+ (void)checkIn:(int64_t)regId success:(void(^)(NXTFCheckInResp *checkInResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFCheckInReq *req = [[NXTFCheckInReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (regId > 0) {
        [req setRegId:regId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToQuene:req selName:@"checkIn:" success:^(id content) {
        if ([content isKindOfClass:[NXTFCheckInResp class]]) {
            NXTFCheckInResp *resp = (NXTFCheckInResp *)content;
            successBlock(resp);
            
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//到院支付接口
+ (void)regHospPay:(NSString *)orderId regId:(NSString *)regId success:(void(^)(NXTFRegHospPayResp *regHospPayResp))successBlock failure:(void(^)(NSError *error))failureBlock{

    NXTFRegHospPayReq *regHosPayReq = [[NXTFRegHospPayReq alloc]init];
    [regHosPayReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (orderId.length > 0) {
        [regHosPayReq setOrderId:orderId];
    }
    if (regId.length > 0) {
        [regHosPayReq setRegId:regId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:regHosPayReq selName:@"regHospPay:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegHospPayResp class]]) {
            NXTFRegHospPayResp *resp = (NXTFRegHospPayResp *)content;
            successBlock(resp);
            
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
