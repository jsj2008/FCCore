//
//  AMAVisitInAPI.m
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "AMAVisitInAPI.h"
#import "AMMNotice.h"
#import "AMANoticeAPI.h"

@implementation AMAVisitInAPI

+(void)getQue:(int64_t)patientId hospId:(int32_t)hospId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetQueReq *getQueReq = [[NXTFGetQueReq alloc] init];
    [getQueReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (hospId>0) {
        [getQueReq setHospId:hospId];
    }
    if (patientId>0) {
        [getQueReq setPatientId:patientId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getQueReq selName:@"getQue:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetQueResp class]]) {
            NXTFGetQueResp *resp = (NXTFGetQueResp *)content;
            successBlock(resp.queues);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)bindMedCard:(NSString *)hospId patientId:(NSString *)patientId markType:(NSString *)markType markNo:(NSString *)markNo success:(void(^)(NSString *cardNo))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFBindMedCardReq *req = [[NXTFBindMedCardReq alloc]init];
    req.header = [FCTFApi1ClientManager getHeader:YES];
    
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    if (markType.length > 0) {
        [req setMarkType:markType];
    }
    if (markNo.length > 0) {
        [req setMarkNo:markNo];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"bindMedCard:" success:^(id content) {
        if ([content isKindOfClass:[NXTFBindMedCardResp class]]) {
            NXTFBindMedCardResp *resp = (NXTFBindMedCardResp *)content;
            successBlock(resp.cardNo);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getMedCards:(NSString *)patientId hospitalId:(NSString *)hospitalId mode:(int32_t)mode cardTarget:(NSString *)cardTarget markSubType:(int32_t)markSubType success:(void (^)(NXTFGetMedCardsResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetMedCardsReq *req = [[NXTFGetMedCardsReq alloc]init];
    req.header = [FCTFApi1ClientManager getHeader:YES];
    
    if (patientId.longLongValue > 0) {
        [req setPatientId:patientId.longLongValue];
    }
    
    if (hospitalId.intValue > 0) {
        [req setHospId:hospitalId.intValue];
    }
    if (mode > 0) {
        [req setMode:mode];
    }
    if (cardTarget && cardTarget.length > 0) {
        [req setCardTarget:cardTarget.intValue];
    }
    if (markSubType == 1) {
        [req setMarkSubType:markSubType];
    }
        
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getMedCards:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetMedCardsResp class]]) {
            NXTFGetMedCardsResp *resp = (NXTFGetMedCardsResp *)content;
            successBlock(resp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)regCardNo:(NSString *)hospId patientId:(NSString *)patientId success:(void(^)(NSString *cardNo))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFRegCardNoReq *req = [[NXTFRegCardNoReq alloc]init];
    req.header = [FCTFApi1ClientManager getHeader:YES];
    
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"regCardNo:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegCardNoResp class]]) {
            NXTFRegCardNoResp *resp = (NXTFRegCardNoResp *)content;
            successBlock(resp.data);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getMedInfos:(int64_t)patientId page:(NXTFPage *)page success:(void(^)(NXTFGetMedInfosResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetMedInfosReq *getMedInfosReq = [[NXTFGetMedInfosReq alloc] init];
    [getMedInfosReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (patientId >= 0) {
        [getMedInfosReq setPatientId:patientId];
    }
    [getMedInfosReq setPage:page];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getMedInfosReq selName:@"getMedInfos:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetMedInfosResp class]]) {
            NXTFGetMedInfosResp *getMedInfosResp = (NXTFGetMedInfosResp *)content;
            successBlock(getMedInfosResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

}

+(void)descSymptom:(int64_t)regId symptom:(NSString *)symptom disease:(NSString *)disease symptomPics:(NSMutableArray *)symptomPics success:(void(^)(BOOL ret))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFDescSymptomReq *req = [[NXTFDescSymptomReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (regId > 0) {
        [req setRegId:regId];
    }
    
    if (symptom.length > 0) {
        [req setSymptom:symptom];
    }
    
    if (disease.length > 0) {
        [req setDisease:disease];
    }
    
    if (symptomPics.count > 0) {
        [req setSymptomPics:symptomPics];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"descSymptom:" success:^(id content) {
        if ([content isKindOfClass:[NXTFDescSymptomResp class]]) {
            successBlock(YES);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getDescSymptom:(int64_t)regId success:(void(^)(NXTFGetDescSymptomResp *getDescSymptomResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetDescSymptomReq *req = [[NXTFGetDescSymptomReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (regId > 0) {
        [req setRegId:regId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getDescSymptom:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetDescSymptomResp class]]) {
            successBlock(content);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
//绑定住院号
+(void)bindInpatientNo:(NSString *)patientId hospId:(NSString *)hospId inpatientNo:(NSString *)inpatientNo success:(void(^)())successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFBindInpatientNoReq *req = [[NXTFBindInpatientNoReq alloc]init];
    req.header = [FCTFApi1ClientManager getHeader:YES];
    
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    if (inpatientNo.length > 0) {
        [req setInpatientNo:inpatientNo];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"bindInpatientNo:" success:^(id content) {
        if ([content isKindOfClass:[NXTFBindInpatientNoResp class]]) {
            successBlock();
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)inpatientPrePayment:(NSString *)patientId totalFee:(NSString *)totalFee recordId:(NSString *)recordId  success:(void(^)(NXTFInpatientPrePayment *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    if (patientId.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"patientId参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
        return;
    }
    if (totalFee.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"totalFee参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
        return;
    }
    if (recordId.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"recordId参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
        return;
    }
    
    NXTFInpatientPrePaymentReq *getReq = [[NXTFInpatientPrePaymentReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:YES] patientId:patientId.intValue totalFee:totalFee.doubleValue recordId:recordId.integerValue ];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"inpatientPrePayment:" success:^(id content) {
        if ([content isKindOfClass:[NXTFInpatientPrePaymentResp class]]) {
            NXTFInpatientPrePaymentResp *resp = (NXTFInpatientPrePaymentResp *)content;
            successBlock(resp.inpatientPrePayment);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

//查询住院预交金缴纳记录
+(void)getInpatientInfos:(NSString *)patientId hospId:(NSString *)hospId inpatientNo:(NSString *)inpatientNo success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFGetInpatientInfosReq *getReq = [[NXTFGetInpatientInfosReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:YES] patientId:patientId.intValue hospId:hospId.intValue inpatientNo:inpatientNo ];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getInpatientInfos:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetInpatientInfosResp class]]) {
            NXTFGetInpatientInfosResp *resp = (NXTFGetInpatientInfosResp *)content;
            successBlock(resp.inpatientInfos);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
      
}

+(void)getPrePaymentDetail:(NSString *)patientId  hospId:(NSString *)hospId recordId:(NSString *)recordId success:(void(^)(NXTFGetPrePaymentDetailResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    if (patientId.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"patientId参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
        return;
    }
    if (hospId.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"hospId参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
        return;
    }
    if (recordId.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"recordId参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
        return;
    }

    
    NXTFGetPrePaymentDetailReq *getReq = [[NXTFGetPrePaymentDetailReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:YES] page:nil hospId:hospId.intValue  patientId:patientId.intValue recordId:recordId.intValue];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getPrePaymentDetail:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetPrePaymentDetailResp class]]) {
            NXTFGetPrePaymentDetailResp *resp = (NXTFGetPrePaymentDetailResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getInpatientFeeDetail:(int64_t)patientId hospId:(int64_t)hospId recordId:(int64_t)recordId   feeDate:(NSString *)feeDate success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetInpatientFeeDetailReq *getReq = [[NXTFGetInpatientFeeDetailReq alloc] init];
    [getReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [getReq setPatientId:patientId];
    }
    
    if (hospId > 0) {
        [getReq setHospId:(int32_t)hospId];
    }
    
    if (recordId > 0) {
        [getReq setRecordId:recordId];
    }
    
    if (feeDate.length > 0) {
        [getReq setFeeDate:feeDate];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getInpatientFeeDetail:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetInpatientFeeDetailResp class]]) {
            NXTFGetInpatientFeeDetailResp *resp = (NXTFGetInpatientFeeDetailResp *)content;
            successBlock(resp.detailFees);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}


+(void)getInpatientInfo:(int64_t)patientId hospId:(int32_t)hospId recordId:(int64_t)recordId success:(void(^)(NXTFInpatientInfo *model)) successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetInpatientInfoReq *getReq =[[NXTFGetInpatientInfoReq alloc] init];
    
    [getReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [getReq setPatientId:patientId];
    }
    
    if (hospId > 0) {
        [getReq setHospId:hospId];
    }
    
    if (recordId > 0) {
        [getReq setRecordId:recordId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getInpatientInfo:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetInpatientInfoResp class]]) {
            NXTFGetInpatientInfoResp *resp = (NXTFGetInpatientInfoResp *)content;
            successBlock(resp.inpatientInfo);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getInpatientFeeList:(int64_t)patientId hospId:(int32_t)hospId recordId:(int64_t)recordId success:(void(^)(NXTFGetInpatientFeeListResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{

    NXTFGetInpatientFeeListReq *getReq = [[NXTFGetInpatientFeeListReq alloc] init];
    
    [getReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [getReq setPatientId:patientId];
    }
    
    if (hospId > 0) {
        [getReq setHospId:hospId];
    }
    
    if (recordId > 0) {
        [getReq setRecordId:recordId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getInpatientFeeList:" success:^(id content) {
         if ([content isKindOfClass:[NXTFGetInpatientFeeListResp class]]) {
             NXTFGetInpatientFeeListResp *resp = (NXTFGetInpatientFeeListResp *)content;
             successBlock(resp);
         } else {
             NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
             failureBlock(error);
         }
     }
     failure:^(NSError *error) {
         failureBlock(error);
     }];
}

//删除就诊卡
+(void)removeMedCard:(int64_t)patientId hospId:(int32_t)hospId cardId:(int64_t)cardId success:(void(^)(NXTFRemoveMedCardResp *model))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFRemoveMedCardReq *getReq = [[NXTFRemoveMedCardReq alloc] init];
    
    [getReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [getReq setPatientId:patientId];
    }
    
    if (hospId > 0) {
        [getReq setHospId:hospId];
    }
    
    if (cardId > 0) {
        [getReq setCardId:cardId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"removeMedCard:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRemoveMedCardResp class]]) {
            NXTFRemoveMedCardResp *resp = (NXTFRemoveMedCardResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
            failureBlock(error);
        }
    }
                              failure:^(NSError *error) {
                                  failureBlock(error);
                              }];
}

//设定/取消默认就诊卡
+(void)setDefaultCard:(int64_t)patientId hospId:(int32_t)hospId cardId:(int64_t)cardId isDefault:(int32_t)isDefault success:(void(^)(NXTFSetDefaultCardResp *model))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFSetDefaultCardReq *getReq = [[NXTFSetDefaultCardReq alloc] init];
    
    [getReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [getReq setPatientId:patientId];
    }
    
    if (hospId > 0) {
        [getReq setHospId:hospId];
    }
    
    if (cardId > 0) {
        [getReq setCardId:cardId];
    }
    
    [getReq setIsDefault:isDefault];
    
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"setDefaultCard:" success:^(id content) {
        if ([content isKindOfClass:[NXTFSetDefaultCardResp class]]) {
            NXTFSetDefaultCardResp *resp = (NXTFSetDefaultCardResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
            failureBlock(error);
        }
    }
    failure:^(NSError *error) {
            failureBlock(error);
    }];
}
//获取病历信息
+(void)getEmrInfo:(int64_t)regId hospId:(int32_t)hospId patientId:(int64_t)patientId success:(void(^)(NXTFGetEmrInfoResp *model))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFGetEmrInfoReq *getReq = [[NXTFGetEmrInfoReq alloc] init];
    
    [getReq setHeader:[FCTFApi1ClientManager getHeader:YES]];

    if (regId > 0) {
        [getReq setRegId:regId];
    }
    if (hospId > 0) {
        [getReq setHospId:hospId];
    }
    if (patientId > 0) {
        [getReq setPatientId:patientId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getEmrInfo:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetEmrInfoResp class]]) {
            NXTFGetEmrInfoResp *resp = (NXTFGetEmrInfoResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据为空" code:-11 userInfo:nil];
            failureBlock(error);
        }
    }
   failure:^(NSError *error) {
       failureBlock(error);
   }];
}

//获取科室/医生排班表信息
+(void)getVisits:(int32_t)hospId hisDeptId:(NSString *)hisDeptId deptId:(int64_t)deptId startDate:(NSString *)startDate endDate:(NSString *)endDate scheduleType:(int32_t)scheduleType success:(void(^)(NXTFGetVisitsResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFGetVisitsReq *getReq = [[NXTFGetVisitsReq alloc] init];
    [getReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (hospId > 0) {
        [getReq setHospId:hospId];
    }
    
    if (hisDeptId.length > 0) {
        [getReq setHisDeptId:hisDeptId];
    }
    if (deptId > 0) {
        [getReq setDeptId:deptId];
    }
    if (startDate.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"startDate参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
    }else {
        [getReq setStartDate:startDate];
    }
    if (endDate.length == 0) {
        NSError *error = [[NSError alloc] initWithDomain:@"endDate参数不能为空" code:-11 userInfo:nil];
        failureBlock(error);
    }else {
        [getReq setEndDate:endDate];
    }
    if (scheduleType >= 0) {
        [getReq setScheduleType:scheduleType];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getReq selName:@"getVisits:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetVisitsResp class]]) {
            NXTFGetVisitsResp *resp = (NXTFGetVisitsResp *)content;
            successBlock(resp);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

}

+(void)authPmr:(NSMutableArray *)authPmrs success:(void(^)(NXTFAuthPmrResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFAuthPmrReq *req = [[NXTFAuthPmrReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [req setAuthPmrs:authPmrs];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"authPmr:" success:^(id content) {
        if ([content isKindOfClass:[NXTFAuthPmrResp class]]) {
            NXTFAuthPmrResp *resp = (NXTFAuthPmrResp *)content;
            successBlock(resp);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getChargeBalance:(int32_t)hospId patientId:(int64_t)patientId markType:(NSString *)markType markNo:(NSString *)markNo pwd:(NSString *)pwd success:(void (^)(NXTFGetChargeBalanceResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetChargeBalanceReq *req = [[NXTFGetChargeBalanceReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (hospId > 0) {
        [req setHospId:hospId];
    }
    if (patientId > 0) {
        [req setPatientId:patientId];
    }
    if (markType.length > 0) {
        [req setMarkType:markType];
    }
    if (markNo.length > 0) {
        [req setMarkNo:markNo];
    }
    if (pwd.length > 0) {
        [req setPwd:pwd];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client]  addToSSlQuene:req selName:@"getChargeBalance:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetChargeBalanceResp class]]) {
            NXTFGetChargeBalanceResp *resp = (NXTFGetChargeBalanceResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)orderCharge:(int64_t)cardId paymentFee:(double)paymentFee success:(void (^)(NXTFOrderChargeResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFOrderChargeReq *req = [[NXTFOrderChargeReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (cardId > 0) {
        [req setCardId:cardId];
    }
    if (paymentFee > 0) {
        [req setPaymentFee:paymentFee];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"orderCharge:" success:^(id content) {
        if ([content isKindOfClass:[NXTFOrderChargeResp class]]) {
            NXTFOrderChargeResp *resp = (NXTFOrderChargeResp *)content;
            successBlock(resp);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
