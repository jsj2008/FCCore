//
//  AMADoctorAPI.m
//  FCNetworkApi
//
//  Created by zhuenkai on 11/23/15.
//  Copyright © 2015 HZTeam. All rights reserved.
//

#import "AMADoctorAPI.h"

@implementation AMADoctorAPI

+ (void)addConsult:(NSString *)docId desc:(NSString *)desc patientId:(int64_t)patientId serviceType:(int32_t)serviceType fee:(NSString *)fee patientName:(NSString *)patientName gender:(int32_t)gender timId:(NSString *)timId success:(void(^)(NXTFAddConsultResp *consultId))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFAddConsultReq *req = [[NXTFAddConsultReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (docId.length > 0) {
        [req setDrId:docId];
    }
    if (desc.length > 0) {
        [req setDesc:desc];
    }
    if (patientId >= 0) {
        [req setPatientId:patientId];
    }
    if (serviceType >= 0) {
        [req setServiceType:serviceType];
    }
    if (fee.length > 0) {
        [req setFee:fee];
    }
    if (patientName.length > 0) {
        [req setPatientName:patientName];
    }
    if (gender >= 0) {
        [req setGender:gender];
    }
    if (timId.length > 0) {
        [req setTimId:timId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"addConsult:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFAddConsultResp class]]) {
            NXTFAddConsultResp *resp = (NXTFAddConsultResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}
//+ (void)addConsult:(int64_t)patientId docId:(NSString *)docId disease:(NSString *)disease symptom:(NSString *)symptom timId:(NSString *)timID success:(void (^)(NSString *))successBlock failure:(void (^)(NSError *))failureBlock {
//    NXTFAddConsultReq *req = [[NXTFAddConsultReq alloc]init];
//    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
//    if (patientId >= 0) {
//        [req setPatientId:patientId];
//    }
//    if (docId >= 0) {
//        [req setDrId:docId];
//    }
//    if (disease.length > 0) {
//        [req setDesc:disease];
//    }
////    if (symptom.length > 0) {
////        [req setSymptom:symptom];
////    }
//    
//    
//    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"addConsult:" success:^(id content) {
//        
//        if ([content isKindOfClass:[NXTFAddConsultResp class]]) {
//            NXTFAddConsultResp *resp = (NXTFAddConsultResp *)content;
////            successBlock(resp.consultId);
//        } else {
//            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
//            failureBlock(error);
//        }
//        
//    } failure:^(NSError *error) {
//        failureBlock(error);
//    }];
//}

//添加评分信息
+ (void)addEvaluate:(int32_t)enalType bizId:(NSString *)bizId patientName:(NSString *)patientName docId:(int64_t)docId docName:(NSString *)docName disease:(NSString *)disease message:(NSString *)message attitude:(int32_t)attitude effect:(int32_t)effect hospSrv:(int32_t)hospSrv waiting:(int32_t)waiting consult:(int32_t)consult success:(void(^)(NXTFAddEvaluateResp *msgDto))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFAddEvaluateReq *req = [[NXTFAddEvaluateReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (enalType >=0) {
        [req setEvalType:enalType];
    }
    if (bizId.length > 0) {
        [req setBizId:bizId];
    }
    if (patientName.length > 0) {
        [req setPatientName:patientName];
    }
    if (docId >= 0) {
        [req setDocId:docId];
    }
    if (docName.length > 0) {
        [req setDocName:docName];
    }
    if (disease.length > 0) {
        [req setDisease:disease];
    }
    if (message.length > 0) {
        [req setMessage:message];
    }
    if (attitude >= 0) {
        [req setAttitude:attitude];
    }
     if (enalType == 1) {
        if (consult >= 0) {
            [req setConsult:consult];
        }
    }else{
        if (effect >= 0) {
            [req setEffect:effect];
        }
        if (hospSrv >= 0) {
            [req setHospSrv:hospSrv];
        }
        if (waiting >= 0) {
            [req setWaiting:waiting];
        }
    }
   
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"addEvaluate:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFAddEvaluateResp class]]) {
            NXTFAddEvaluateResp *resp = (NXTFAddEvaluateResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getEvaluates:(NXTFPage *)page docId:(int64_t)docId success:(void (^)(NXTFGetEvaluatesResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetEvaluatesReq *req = [[NXTFGetEvaluatesReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (page) {
        [req setPage:page];
    }
    if (docId >= 0) {
        [req setDocId:docId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getEvaluates:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetEvaluatesResp class]]) {
            NXTFGetEvaluatesResp *resp = (NXTFGetEvaluatesResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


+ (void)getConsults:(int64_t)patientId success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock; {
    
    NXTFGetConsultsReq *req = [[NXTFGetConsultsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];

    if(patientId && patientId > 0) {
        [req setPatientId:patientId];
    }

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getConsults:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetConsultsResp class]]) {
            NXTFGetConsultsResp *resp = (NXTFGetConsultsResp *)content;
            successBlock(resp.consultations);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+ (void)getConsultationWithRoomId:(NSString *)roomId success:(void(^)(NXTFConsultationDto *consultation))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFGetConsultationReq *req = [[NXTFGetConsultationReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if(roomId.length > 0) {
        [req setRoomId:roomId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getConsultation:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetConsultationResp class]]) {
            NXTFGetConsultationResp *resp = (NXTFGetConsultationResp *)content;
            successBlock(resp.consultations);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)terminateConsultation:(NSString *)consultID success:(void(^)(NSString *status))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFTerminateConsultationReq *req = [[NXTFTerminateConsultationReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if(consultID.length > 0) {
        [req setConsultationId:consultID];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"terminateConsultation:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFTerminateConsultationResp class]]) {
            NXTFTerminateConsultationResp *resp = (NXTFTerminateConsultationResp *)content;
            successBlock(resp.consultStatus);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getDrImId:(int64_t)docId Success:(void(^)(NXTFGetDrImIdResp *drImIdResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetDrImIdReq *req = [[NXTFGetDrImIdReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (docId > 0) {
        [req setDrId:docId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getDrImId:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetDrImIdResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)registConsult:(int64_t)docId Success:(void(^)(NXTFRegistConsultResp *registConsultResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFRegistConsultReq *req = [[NXTFRegistConsultReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (docId > 0) {
        [req setDrId:docId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"registConsult:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegistConsultResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


+(void)fileUpload:(NSString *)groupName fileContent:(NSData *)fileContent fileExtName:(NSString *)fileExtName masterFilename:(NSString *)masterFilename slavePrefixName:(NSString *)slavePrefixName msgId:(NSString *)msgId ttl:(int32_t)ttl success:(void(^)(NXTFFileUploadResp *patientsResp))successBlock failure:(void(^)(NSError *error))failureBlock{
    
    NXTFFileUploadReq *fileUplooadReq = [[NXTFFileUploadReq alloc]init];
    [fileUplooadReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (groupName.length > 0) {
        [fileUplooadReq setGroupName:groupName];
    }
    
    if (fileContent) {
        [fileUplooadReq setFileContent:fileContent];
    }
    
    if (fileExtName.length > 0) {
        [fileUplooadReq setFileExtName:fileExtName];
    }
    
    if (masterFilename.length > 0) {
        [fileUplooadReq setMasterFilename:masterFilename];
    }
    
    if (slavePrefixName.length > 0) {
        [fileUplooadReq setSlavePrefixName:slavePrefixName];
    }
    
    if (msgId.length > 0) {
        [fileUplooadReq setMsgId:msgId];
    }
    if (ttl == -1) {
        [fileUplooadReq setTtl:ttl];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addMsgToQuene:fileUplooadReq selName:@"fileUpload:" messageID:msgId success:^(id content) {
        if([content isKindOfClass:[NXTFFileUploadResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)fileDownload:(NSString *)groupName remoteFilename:(NSString *)remoteFilename msgId:(NSString *)msgId success:(void(^)(NXTFFileDownloadResp *patientsResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFFileDownloadReq *fileDownloadReq = [[NXTFFileDownloadReq alloc]init];
    [fileDownloadReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (groupName.length > 0) {
        [fileDownloadReq setGroupName:groupName];
    }
    
    if (remoteFilename.length > 0) {
        [fileDownloadReq setRemoteFilename:remoteFilename];
    }
    
    if (msgId.length > 0) {
        [fileDownloadReq setMsgId:msgId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addMsgToQuene:fileDownloadReq selName:@"fileDownload:" messageID:msgId success:^(id content) {
        if([content isKindOfClass:[NXTFFileDownloadResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getActs:(int32_t)sort page:(NXTFPage *)page Success:(void(^)(NXTFGetActsResp *getActsResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetActsReq *getActsReq = [[NXTFGetActsReq alloc]init];
    [getActsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [getActsReq setSort:sort];
    [getActsReq setPage:page];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getActsReq selName:@"getActs:" success:^(id content) {
        if([content isKindOfClass:[NXTFGetActsResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getLastestActSuccess:(void(^)(NXTFGetLastestActResp *getLastestActResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetLastestActReq *getLastestActReq = [[NXTFGetLastestActReq alloc]init];
    [getLastestActReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getLastestActReq selName:@"getLastestAct:" success:^(id content) {
        if([content isKindOfClass:[NXTFGetLastestActResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getActDetail:(NSString *)actId Success:(void(^)(NXTFGetActDetailResp *getActDetailResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetActDetailReq *getActDetailReq = [[NXTFGetActDetailReq alloc]init];
    [getActDetailReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [getActDetailReq setActId:actId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getActDetailReq selName:@"getActDetail:" success:^(id content) {
        if([content isKindOfClass:[NXTFGetActDetailResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)registerLive:(NSString *)actId Success:(void(^)(NXTFRegLiveResp *regLiveResp))successBlock failure:(void(^)(NSError *error))failureBlock {

    NXTFRegLiveReq *regLiveReq = [[NXTFRegLiveReq alloc]init];
    [regLiveReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [regLiveReq setActId:actId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:regLiveReq selName:@"registerLive:" success:^(id content) {
        if([content isKindOfClass:[NXTFRegLiveResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getBanners:(int32_t)area cityCode:(NSString *)cityCode Success:(void(^)(NXTFGetBannersResp *regLiveResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetBannersReq *getBannersReq = [[NXTFGetBannersReq alloc]init];
    [getBannersReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [getBannersReq setCityCode:cityCode];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getBannersReq selName:@"getBanners:" success:^(id content) {
        if([content isKindOfClass:[NXTFGetBannersResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)upLoadTreatPic:(NSString *)regId hospId:(int32_t)hospId fileContent:(NSData *)fileContent picName:(NSString *)picName Success:(void(^)(NXTFUpLoadTreatPicResp *upLoadTreatPicResp))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFUpLoadTreatPicReq *upLoadTreatPicReq = [[NXTFUpLoadTreatPicReq alloc] init];
    [upLoadTreatPicReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (regId.length > 0) {
        [upLoadTreatPicReq setHisRegId:regId];
    }
    
    if (hospId > 0) {
        [upLoadTreatPicReq setHospId:hospId];
    }
    
    if (fileContent) {
        [upLoadTreatPicReq setFileContent:fileContent];
    }
    
    if (picName.length > 0) {
        [upLoadTreatPicReq setPicName:picName];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:upLoadTreatPicReq selName:@"upLoadTreatPic:" success:^(id content) {
        if([content isKindOfClass:[NXTFUpLoadTreatPicResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];


}

+(void)getQueInfoWithHospId:(int32_t)hospId Success:(void(^)(NXTFGetQueInfoResp *getQueInfoResp))successBlock failure:(void(^)(NSError *error))failureBlock{
    NXTFGetQueInfoReq *req = [[NXTFGetQueInfoReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (hospId > 0) {
        [req setHospId:hospId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getQueInfo:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetQueInfoResp class]]) {
            NXTFGetQueInfoResp *getDiseaseResp = (NXTFGetQueInfoResp *)content;
            successBlock(getDiseaseResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)signContract:(NSString *)teamId dwellerInfos:(NSMutableArray *)dwellerInfos packageIds:(NSMutableArray *)packageIds contractDuration:(int32_t)contractDuration hospId:(int32_t)hospId docId:(int64_t)docId teamName:(NSString *)teamName success:(void(^)(NXTFSignContractResp *signContractResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFSignContractReq *req = [[NXTFSignContractReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (teamId.length > 0) {
        [req setTeamId:teamId];
    }
    
    if (dwellerInfos && dwellerInfos.count > 0) {
        [req setDwellerInfos:dwellerInfos];
    }
    
    if (packageIds && packageIds.count > 0) {
        [req setPackageIds:packageIds];
    }
    
    if (contractDuration >= 0) {
        [req setContractDuration:contractDuration];
    }
    
    if (hospId >= 0) {
        [req setHospId:hospId];
    }
    
    if (docId >= 0) {
        [req setDocId:docId];
    }
    
    if (teamName.length > 0) {
        [req setTeamName:teamName];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:req selName:@"signContract:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFSignContractResp class]]) {
            NXTFSignContractResp *resp = (NXTFSignContractResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getPackageInfos:(NSString *)teamId hospId:(int32_t)hospId success:(void(^)(NXTFGetPackageInfosResp *getPackageInfosResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetPackageInfosReq *req = [[NXTFGetPackageInfosReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (teamId.length > 0) {
        [req setTeamID:teamId];
    }
    
    if (hospId >= 0) {
        [req setHospId:hospId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getPackageInfos:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetPackageInfosResp class]]) {
            NXTFGetPackageInfosResp *resp = (NXTFGetPackageInfosResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getMyDoctor:(int64_t)patientId success:(void(^)(NXTFGetMyDoctorResp *getMyDoctorResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetMyDoctorReq *req = [[NXTFGetMyDoctorReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId >= 0) {
        [req setPatientId:patientId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getMyDoctor:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetMyDoctorResp class]]) {
            NXTFGetMyDoctorResp *resp = (NXTFGetMyDoctorResp *)content;
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
