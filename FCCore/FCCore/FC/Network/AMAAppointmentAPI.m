//
//  AMAAppointmentAPI.m
//  AnyMed
//
//  Created by 周鑫 on 15/3/11.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "AMAAppointmentAPI.h"
#import "AMDBHelper.h"

@implementation AMAAppointmentAPI


+(void)getComDepts:(BOOL)showDesc type:(int32_t)type  success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFGetComDeptsReq *getComDeptsReq = [[NXTFGetComDeptsReq alloc] init];
    [getComDeptsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [getComDeptsReq setShowDesc:showDesc];
    if (type > -1) {
        [getComDeptsReq setType:type];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getComDeptsReq selName:@"getComDepts:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetComDeptsResp class]]) {
            NXTFGetComDeptsResp *getComDeptsResp = (NXTFGetComDeptsResp *)content;
            successBlock(getComDeptsResp.comDepts);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

//获取可以通过APP挂号的城市列表
+(void)getCities:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetCitiesReq *getCitiesReq = [[NXTFGetCitiesReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:NO]];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getCitiesReq selName:@"getCities:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetCitiesResp class]]) {
            NXTFGetCitiesResp *getCitiesResp = (NXTFGetCitiesResp *)content;
            successBlock(getCitiesResp.citys);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getHosp:(int32_t)hospId success:(void(^)(NXTFGetHospResp *getHospResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFGetHospReq *getHospReq = [[NXTFGetHospReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:NO] hospId:hospId];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getHospReq selName:@"getHosp:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetHospResp class]]) {
            NXTFGetHospResp *getHospResp = (NXTFGetHospResp *)content;
            [AMDBHelper replaceHospsCode:[NSString stringWithFormat:@"%d",hospId] serviceCode:getHospResp.serviceCode];
            successBlock(getHospResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

}

+(void)getDepts:(int32_t)hospId isMutiDept:(int32_t)isMutiDept scheduleType:(int32_t)scheduleType success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetDeptsReq *getDeptsReq = [[NXTFGetDeptsReq alloc] init];
    
    [getDeptsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [getDeptsReq setHospId:hospId];
    [getDeptsReq setIsMutiDept:isMutiDept];
    [getDeptsReq setScheduleType:scheduleType];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getDeptsReq selName:@"getDepts:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetDeptsResp class]]) {
            NXTFGetDeptsResp *getDeptsResp = (NXTFGetDeptsResp *)content;
            successBlock(getDeptsResp.depts);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getDr:(int64_t)drId dcId:(NSString *)dcId mode:(int32_t)mode success:(void(^)(NXTFGetDrResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetDrReq *getDrReq = [[NXTFGetDrReq alloc]init];
    [getDrReq setHeader:[FCTFApi1ClientManager getHeader:NO]];//[FCLogin sharedFCLogin].didSignIn]
    if (drId > 0) {
        [getDrReq setDrId:drId];
    }
    if (dcId.length > 0) {
        [getDrReq setDcId:dcId];
    }
    if (mode >= 0) {
        [getDrReq setMode:mode];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getDrReq selName:@"getDr:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetDrResp class]]) {
            NXTFGetDrResp *getDrResp = (NXTFGetDrResp *)content;
            [AMDBHelper replaceHospsCode:[NSString stringWithFormat:@"%d",getDrResp.hospId] serviceCode:getDrResp.serviceCode];
            successBlock(getDrResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];


}

+(void)getNotice:(int32_t)hospId deptId:(NSString *)deptId noticeType:(int32_t)noticeType success:(void(^)(NSString *string))successBlock failure:(void(^)(NSError *error))failureBlock  {
    
    NXTFGetNoticeReq *getNoticeReq = [[NXTFGetNoticeReq alloc] init];
    [getNoticeReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (hospId>=0) {
        [getNoticeReq setHospId:hospId];
    }
    if (deptId.length>0) {
        [getNoticeReq setDeptId:deptId];
    }
    [getNoticeReq setNoticeType:noticeType];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getNoticeReq selName:@"getNotice:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetNoticeResp class]]) {
            NXTFGetNoticeResp *getNoticeResp = (NXTFGetNoticeResp *)content;
            successBlock(getNoticeResp.notice);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getHospMaps:(int32_t)hospId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFGetHospMapsReq *getHospMapsReq = [[NXTFGetHospMapsReq alloc] init];
    [getHospMapsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (hospId > 0) {
        [getHospMapsReq setHospId:hospId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getHospMapsReq selName:@"getHospMaps:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetHospMapsResp class]]) {
            NXTFGetHospMapsResp *getHospMapsResp = (NXTFGetHospMapsResp *)content;
            successBlock(getHospMapsResp.hospitalMaps);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

//获取可挂号目标列表(旧版挂号排班页接口)
+(void)regTargets:(int32_t)comDeptId cityName:(NSString *)cityName deptId:(int64_t)deptId success:(void(^)(NXTFRegTargetsResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFRegTargetsReq *regTargetsReq = [[NXTFRegTargetsReq alloc] init];
    [regTargetsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if(comDeptId>=0) {
        [regTargetsReq setComDeptId:comDeptId];
    }
    if(cityName.length>0) {
        [regTargetsReq setCityName:cityName];
    }
    if (deptId>=0) {
        [regTargetsReq setDeptId:deptId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:regTargetsReq selName:@"regTargets:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegTargetsResp class]]) {
            NXTFRegTargetsResp *regTargetsResp = (NXTFRegTargetsResp *)content;
            [AMDBHelper replaceHospsCode:regTargetsResp.hospId serviceCode:regTargetsResp.serviceCode];
            successBlock(regTargetsResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//获取可挂号目标列表(新版挂号排班页接口)
+ (void)regTargets:(int32_t)comDeptId cityName:(NSString *)cityName deptId:(int64_t)deptId hospitalId:(int32_t)hospitalId hisDeptId:(NSString *)hisDeptId scheduleDate:(NSString *)scheduleDate scheduleType:(int32_t)scheduleType success:(void (^)(NXTFRegTargetsResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    
    NXTFRegTargetsReq *regTargetsReq = [[NXTFRegTargetsReq alloc] init];
    [regTargetsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if(comDeptId>=0) {
        [regTargetsReq setComDeptId:comDeptId];
    }
    if(cityName.length>0) {
        [regTargetsReq setCityName:cityName];
    }
    if (deptId>=0) {
        [regTargetsReq setDeptId:deptId];
    }
    if (hospitalId >= 0) {
        [regTargetsReq setHospitalId:hospitalId];
    }
    if (hisDeptId.length > 0) {
        [regTargetsReq setHisDeptId:hisDeptId];
    }
    if (scheduleDate.length > 0) {
        [regTargetsReq setScheduleDate:scheduleDate];
    }
    [regTargetsReq setScheduleType:scheduleType];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:regTargetsReq selName:@"regTargets:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegTargetsResp class]]) {
            NXTFRegTargetsResp *regTargetsResp = (NXTFRegTargetsResp *)content;
            [AMDBHelper replaceHospsCode:regTargetsResp.hospId serviceCode:regTargetsResp.serviceCode];
            successBlock(regTargetsResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
/**
 获取号点
 */
+(void)regPoints:(int64_t)targetId targetType:(int32_t)targetType regLevelId:(NSString *)regLevelId deptId:(int64_t)deptId scheduleType:(int32_t)scheduleType page:(NXTFPage*)page success:(void(^)(NXTFRegPointsResp *regPointsResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFRegPointsReq *regPointsReq = [[NXTFRegPointsReq alloc]init];
    [regPointsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [regPointsReq setRegLevelId:regLevelId];
    if (targetId >= 0) {
        [regPointsReq setTargetId:targetId];
    }
    if (targetType >= 0) {
        [regPointsReq setTargetType:targetType];
    }
    if (deptId >= 0) {
        [regPointsReq setDeptId:deptId];
    }
    if(page) {
        [regPointsReq setPage:page];
    }
    [regPointsReq setScheduleType:scheduleType];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:regPointsReq selName:@"regPoints:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegPointsResp class]]) {
            NXTFRegPointsResp *regPointsResp = (NXTFRegPointsResp *)content;
            successBlock(regPointsResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

}


+(void)regPoint:(int64_t)patientId pointId:(NSString *)pointId pointName:(NSString *)pointName pointDate:(NSString *)pointDate regLevelId:(NSString *)regLevelId regLevelName:(NSString *)regLevelName deptId:(int64_t)deptId drId:(int64_t)drId visitTime:(NSString *)visitTime scheduleType:(int32_t)scheduleType success:(void(^)(NXTFRegPointResp *regPointResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFRegPointReq *regPointReq = [[NXTFRegPointReq alloc]init];
    [regPointReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId > 0) {
        [regPointReq setPatientId:patientId];
    }
    
    if (pointId.length > 0) {
        [regPointReq setPointId:pointId];
    }
    
    if (pointName.length > 0) {
        [regPointReq setPointName:pointName];
    }
    
    if (pointDate.length > 0) {
        [regPointReq setPointDate:pointDate];
    }
    
    if (regLevelId.length > 0) {
        [regPointReq setRegLevelId:regLevelId];
    }
    
    if (regLevelName.length > 0) {
        [regPointReq setRegLevelName:regLevelName];
    }
    
    if (deptId > 0) {
        [regPointReq setDeptId:deptId];
    }
    
    if(drId >= 0) {
        [regPointReq setDrId:drId];
    }
    
    if (visitTime.length > 0) {
       [regPointReq setVisitTime:visitTime];
    }
    [regPointReq setScheduleType:scheduleType];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:regPointReq selName:@"regPoint:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegPointResp class]]) {
            NXTFRegPointResp *regPointResp = (NXTFRegPointResp *)content;
            successBlock(regPointResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];


}

+(void)getGuide:(NSString *)hospId success:(void(^)(NSString *string))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetGuideReq *req = [[NXTFGetGuideReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (hospId.length > 0 && hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getGuide:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetGuideResp class]]) {
            NXTFGetGuideResp *resp = (NXTFGetGuideResp *)content;
            
            if (resp.guideIsSet) {
                successBlock(resp.guide);
            } else {
                successBlock(@"");
            }
            
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

}

+ (void)favorHosp:(int64_t)HospId operType:(NSString *)operType success:(void(^)(NXTFFavorHospResp *regPointResp))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFFavorHospReq *req = [[NXTFFavorHospReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (HospId>=0) {
        [req setHospId:HospId];
    }
    if (operType.length>0) {
        [req setOperType:operType];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"favorHosp:" success:^(id content) {
        if ([content isKindOfClass:[NXTFFavorHospResp class]]) {
            NXTFFavorHospResp *resp = (NXTFFavorHospResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

}

+ (void)getHospAnn:(NXTFPage *)page hospId:(int32_t)hospId success:(void(^)(NXTFGetHospAnnResp *getHospAnnResp))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFGetHospAnnReq *req = [[NXTFGetHospAnnReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if(page) {
        [req setPage:page];
    }
    if (hospId>=0) {
        [req setHospId:hospId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getHospAnn:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetHospAnnResp class]]) {
            NXTFGetHospAnnResp *resp = (NXTFGetHospAnnResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getRegDates:(int32_t)hospId targetType:(int32_t)targetType docId:(int64_t)docId deptId:(int64_t)deptId hisDeptId:(NSString *)hisDeptId startDate:(NSString *)startDate endDate:(NSString *)endDate success:(void(^)(NXTFGetRegDatesResp *getRegDatesResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetRegDatesReq *req = [[NXTFGetRegDatesReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];

    if (hospId >= 0 ) {
        [req setHospId:hospId];
    }
    
    // 挂号目标类型(0:科室, 1:医生 ,未设定:全部)
    if (targetType == 0 || targetType == 1) {
        [req setTargetType:targetType];
    }
    // 医生ID(targetType=1时：必须)
    if (docId >= 0) {
        [req setDocId:docId];
    }
    // 科室ID(targetType=0时：必须)
    if (deptId >= 0) {
        [req setDeptId:deptId];
    }
    
    if (hisDeptId && hisDeptId.length > 0) {
        [req setHisDeptId:hisDeptId];
    }
    // 开始日期(yyyyMMdd)
    if (startDate && startDate.length > 0) {
        [req setStartDate:startDate];
    }
    // 结束日期(yyyyMMdd)
    if (endDate && endDate.length > 0) {
        [req setEndDate:endDate];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getRegDates:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetRegDatesResp class]]) {
            NXTFGetRegDatesResp *resp = (NXTFGetRegDatesResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

//通过His数据获取医生信息
+ (void)getDrWithHis:(NSString *)hisDrid hospid:(int32_t)hospid success:(void(^)(NXTFGetDrResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFGetDrReq *getDrReq = [[NXTFGetDrReq alloc]init];
    [getDrReq setHeader:[FCTFApi1ClientManager getHeader:NO]];//[FCLogin sharedFCLogin].didSignIn]
    if (hisDrid.length > 0) {
        [getDrReq setHisDrId:hisDrid];
    }
    if (hospid > 0) {
        [getDrReq setHospId:hospid];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getDrReq selName:@"getDr:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetDrResp class]]) {
            NXTFGetDrResp *getDrResp = (NXTFGetDrResp *)content;
            [AMDBHelper replaceHospsCode:[NSString stringWithFormat:@"%d",getDrResp.hospId] serviceCode:getDrResp.serviceCode];
            successBlock(getDrResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

// 获取可挂号科室
+(void)getRegistedDept:(int32_t)hospId Success:(void(^)(NXTFGetRegistedDeptResp *regResp))successBlock failure:(void(^)(NSError *error))failureBlock{
    
    NXTFGetRegistedDeptReq *getRegReq = [[NXTFGetRegistedDeptReq alloc]init];
    [getRegReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (hospId > 0) {
        [getRegReq setHospId:hospId];
    }else{
        [getRegReq setHospId:0];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getRegReq selName:@"getRegistedDept:" success:^(id content) {
        if([content isKindOfClass:[NXTFGetRegistedDeptResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

//获取科室医生列表
+(void)getDeptDocs:(int64_t)deptId Success:(void(^)(NXTFDeptDocsResp *deptDocsResp))successBlock failure:(void(^)(NSError *error))failureBlock{
    
    NXTFDeptDocsReq *deptDocsReq = [[NXTFDeptDocsReq alloc]init];
    [deptDocsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (deptId > 0) {
        [deptDocsReq setDeptId:deptId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:deptDocsReq selName:@"getDeptDocs:" success:^(id content) {
        if([content isKindOfClass:[NXTFDeptDocsResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


@end
