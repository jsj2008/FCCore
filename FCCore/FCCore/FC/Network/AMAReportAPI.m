//
//  AMAReportAPI.m
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "AMAReportAPI.h"

@implementation AMAReportAPI

+(void)getReports:(NSString *)regId hospId:(NSString *)hospId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetReportsReq *req = [[NXTFGetReportsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (regId.intValue > 0) {
        [req setRegId:regId.intValue];
    }
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getReports:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetReportsResp class]]) {
            NXTFGetReportsResp *resp = (NXTFGetReportsResp *)content;
            successBlock(resp.reports);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getReports:(NSString *)patientId hospId:(NSString *)hospId reportType:(NSString *)reportType fromDate:(NSString *)fromDate toDate:(NSString *)toDate status:(NSString *)status success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetReportsReq *req = [[NXTFGetReportsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (reportType.length > 0) {
        [req setReportType:reportType];
    }
    if (fromDate.length > 0) {
        [req setFromDate:fromDate];
    }
    if (toDate.length > 0) {
        [req setToDate:toDate];
    }
    if (status.length > 0 && status.intValue >= 0) {
        [req setStatus:status.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getReports:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetReportsResp class]]) {
            NXTFGetReportsResp *resp = (NXTFGetReportsResp *)content;
            successBlock(resp.reports);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getReport:(NSString *)patientId reportId:(NSString *)reportId reportType:(NSString *)reportType hospId:(NSString *)hospId  success:(void(^)(NXTFGetReportResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetReportReq *req = [[NXTFGetReportReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    if (reportId.length > 0) {
        [req setReportId:reportId];
    }
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (reportType.length > 0) {
        [req setReportType:reportType];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:req selName:@"getReport:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetReportResp class]]) {
            NXTFGetReportResp *resp = (NXTFGetReportResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getPacsImg:(NSString *)patientId reportId:(NSString *)reportId hospId:(NSString *)hospId  success:(void(^)(NXTFGetPacsImgResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetPacsImgReq *req = [[NXTFGetPacsImgReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    if (reportId.length > 0) {
        [req setReportId:reportId];
    }
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:req selName:@"getPacsImg:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetPacsImgResp class]]) {
            NXTFGetPacsImgResp *resp = (NXTFGetPacsImgResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getAdvertis:(NSString *)hospId  success:(void(^)(NXTFGetAdvertisResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetAdvertisReq *req = [[NXTFGetAdvertisReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
 
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getAdvertis:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetAdvertisResp class]]) {
            NXTFGetAdvertisResp *resp = (NXTFGetAdvertisResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)pointNum:(NSString *)adId hospId:(NSString *)hospId success:(void(^)(NXTFPointNumResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFPointNumReq *req = [[NXTFPointNumReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (adId.length > 0) {
        [req setAdId:adId];
    }
    if(hospId.length > 0) {
        [req setHospId:hospId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"pointNum:" success:^(id content) {
        if ([content isKindOfClass:[NXTFPointNumResp class]]) {
            NXTFPointNumResp *resp = (NXTFPointNumResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getPhysicalExaminationReports:(NSString *)hospId patientId:(int64_t)patientId success:(void(^)(NXTFPhysicalRptInfoResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFPhysicalRptInfoReq *req = [[NXTFPhysicalRptInfoReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if(hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (patientId > 0) {
        [req setPatientId:patientId];
    }

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"GetPhysicalRptInfos:" success:^(id content) {
        if ([content isKindOfClass:[NXTFPhysicalRptInfoResp class]]) {
            NXTFPhysicalRptInfoResp *resp = (NXTFPhysicalRptInfoResp *)content;
            successBlock(resp);
        }
    } failure:^(NSError *error) {
        failureBlock (error);
    }];
}

+ (void)getgetPhysicalExaminationDetailReport:(NSString *)hospId physicalID:(NSString *)physicalID success:(void(^)(NXTFPhysicalReportResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFPhysicalReportReq *req = [[NXTFPhysicalReportReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if(hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (physicalID.length > 0) {
        [req setPhysicalID:physicalID];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"GetPhysicalReport:" success:^(id content) {
        if ([content isKindOfClass:[NXTFPhysicalReportResp class]]) {
            NXTFPhysicalReportResp *resp = (NXTFPhysicalReportResp *)content;
            successBlock(resp);
        }
    } failure:^(NSError *error) {
        failureBlock (error);
    }];

}

@end
