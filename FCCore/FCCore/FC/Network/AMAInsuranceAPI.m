//
//  AMAInsuranceAPI.m
//  FCNetworkApi
//
//  Created by xuyue on 16/7/28.
//  Copyright © 2016年 HZTeam. All rights reserved.
//

#import "AMAInsuranceAPI.h"

@implementation AMAInsuranceAPI

// 获取停诊险保单详细信息
+ (void)getStInsDetail:(int64_t)regId success:(void (^)(NXTFGetStInsDetailResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetStInsDetailReq *req = [[NXTFGetStInsDetailReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (regId > 0) {
        [req setRegId:regId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getStInsDetail:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetStInsDetailResp class]]) {
            NXTFGetStInsDetailResp *resp = (NXTFGetStInsDetailResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

// 获取我的常用支付信息
+ (void)getMyPayInfos:(int64_t)patientId success:(void (^)(NXTFGetMyPayInfosResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetMyPayInfosReq *req = [[NXTFGetMyPayInfosReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (patientId > 0) {
        [req setPatientId:patientId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getMyPayInfos:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetMyPayInfosResp class]]) {
            NXTFGetMyPayInfosResp *resp = (NXTFGetMyPayInfosResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

// 获取停诊险理赔支持的银行列表
+ (void)getBanks:(int32_t)type success:(void (^)(NXTFGetStInsBanksResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetStInsBanksReq *req = [[NXTFGetStInsBanksReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (type > 0) {
        [req setType:type];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getBanks:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetStInsBanksResp class]]) {
            NXTFGetStInsBanksResp *resp = (NXTFGetStInsBanksResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

// 停诊险申请理赔
+ (void)reqStInsClaim:(int64_t)regId payee:(NSString *)payee payMethod:(NSString *)payMethod bankCode:(NSString *)bankCode bankName:(NSString *)bankName accountNum:(NSString *)accountNum success:(void (^)(NXTFReqStInsClaimResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFReqStInsClaimReq *req = [[NXTFReqStInsClaimReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (regId > 0) {
        [req setRegId:regId];
    }
    if (payee.length > 0) {
        [req setPayee:payee];
    }
    if (payMethod.length > 0) {
        [req setPayMethod:payMethod];
    }
    if (bankCode.length > 0) {
        [req setBankCode:bankCode];
    }
    if (bankName.length > 0) {
        [req setBankName:bankName];
    }
    if (accountNum.length > 0) {
        [req setAccountNum:accountNum];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"reqStInsClaim:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFReqStInsClaimResp class]]) {
            NXTFReqStInsClaimResp *resp = (NXTFReqStInsClaimResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//获取停诊险试算结果
+ (void)getStInsCalRs:(int64_t)regId success:(void(^)(NXTFGetStInsCalResultResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFGetStInsCalResultReq *req = [[NXTFGetStInsCalResultReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [req setRegId:regId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getStInsCalRs:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetStInsCalResultResp class]]) {
            NXTFGetStInsCalResultResp *resp = (NXTFGetStInsCalResultResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

// 停诊险下单(核保)
+ (void)orderStIns:(int64_t)regId messageId:(NSString *)messageId success:(void(^)(NXTFOrderStInsResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock {

    NXTFOrderStInsReq *orderStInsReq = [[NXTFOrderStInsReq alloc]init];
    [orderStInsReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [orderStInsReq setRegId:regId];
    [orderStInsReq setMessageId:messageId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:orderStInsReq selName:@"orderStIns:" success:^(id content) {
        if ([content isKindOfClass:[NXTFOrderStInsResp class]]) {
            NXTFOrderStInsResp *resp = (NXTFOrderStInsResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//获取停诊险支付信息
+ (void)getStInsPayInfo:(int32_t)payWayTypeId regId:(int64_t)regId success:(void(^)(NXTFGetStInsPayInfoResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetStInsPayInfoReq *getStInsPayInfoReq = [[NXTFGetStInsPayInfoReq alloc]init];
    [getStInsPayInfoReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [getStInsPayInfoReq setPayWayTypeId:payWayTypeId];
    [getStInsPayInfoReq setRegId:regId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene: getStInsPayInfoReq selName:@"getStInsPayInfo:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetStInsPayInfoResp class]]) {
            NXTFGetStInsPayInfoResp *resp = (NXTFGetStInsPayInfoResp *)content;
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
