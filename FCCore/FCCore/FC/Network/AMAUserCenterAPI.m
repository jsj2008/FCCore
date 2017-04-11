//
//  AMAUserCenterAPI.m
//  AnyMed
//
//  Created by 周鑫 on 15/3/17.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "AMAUserCenterAPI.h"
#import "AMMGesUserInfo.h"
#import "AMDBHelper.h"
#import "FCLogin.h"

@implementation AMAUserCenterAPI

//登录
+(void)signIn:(NSString *)phoneNo pwd:(NSString *)pwd signInMode:(int32_t)signInMode authCode:(NSString *)authCode success:(void(^)(NXTFSignInResp *userInfo))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFSignInReq *signInReq = [[NXTFSignInReq alloc] init];
    [signInReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [signInReq setPhoneNo:phoneNo];
    [signInReq setPwd:pwd];
    [signInReq setSignInMode:signInMode];
    if(authCode.length > 0) {
       [signInReq setAuthCode:authCode];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:signInReq selName:@"signIn:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFSignInResp class]]) {
            NXTFSignInResp *signInResp = (NXTFSignInResp *)content;
            if (signInResp) {
                [FCLogin sharedFCLogin].didSignIn    = YES;
                [FCLogin sharedFCLogin].token        = signInResp.token;
                [FCLogin sharedFCLogin].signingKey   = signInResp.signingKey;
                
                successBlock(signInResp);
            }
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"需要登录" code:-1015 userInfo:nil];
            
            [FCLogin sharedFCLogin].didSignIn    = NO;
            [FCLogin sharedFCLogin].token        = @"";
            [FCLogin sharedFCLogin].signingKey   = @"";
            failureBlock(error);
        }
                
    } failure:^(NSError *error) {
        
        [FCLogin sharedFCLogin].didSignIn    = NO;
        [FCLogin sharedFCLogin].token        = @"";
        [FCLogin sharedFCLogin].signingKey   = @"";
        failureBlock(error);
    }];

}

+(void)signOut:(NSString *)userId success:(void(^)(BOOL success))successBlock {
    
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithCapacity:1];
    if (userId) {
        [dictionary setObject:userId forKey:@"userId"];
    }
    NXTFSignOutReq *signOutReq = [[NXTFSignOutReq alloc] init];
    [signOutReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:signOutReq selName:@"signOut:" success:^(id content) {
        [FCLogin sharedFCLogin].didSignIn    = NO;
        [FCLogin sharedFCLogin].token        = @"";
        [FCLogin sharedFCLogin].signingKey   = @"";
    } failure:^(NSError *error) {
        [FCLogin sharedFCLogin].didSignIn    = NO;
        [FCLogin sharedFCLogin].token        = @"";
        [FCLogin sharedFCLogin].signingKey   = @"";
        
    }];
    successBlock(NO);
    
}

+(void)addPatient:(NXTFPatientDto*)patientInfo success:(void(^)(NXTFPatientDto *patientInfo))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFAddPatientReq *req = [[NXTFAddPatientReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientInfo.relationId.intValue > 0) {
        [req setRelationId:patientInfo.relationId.intValue];
    }
    if (patientInfo.name.length > 0) {
        [req setName:patientInfo.name];
    }
    // 性别, 0代表女,1代表男
    if (patientInfo.gender.length > 0 && patientInfo.gender.intValue > -1) {
        [req setGender:patientInfo.gender.intValue];
    }
    if (patientInfo.phoneNo.length > 0) {
        [req setPhoneNo:patientInfo.phoneNo];
    }
    if (patientInfo.papersNo.length > 0) {
        [req setPapersNo:patientInfo.papersNo];
    }
    if (patientInfo.papersTypeId.intValue > 0) {
        [req setPapersTypeId:patientInfo.papersTypeId.intValue];
    }
    if (patientInfo.medInsureance.length > 0) {
        [req setMedInsureance:patientInfo.medInsureance];
    }
    if (patientInfo.stature.doubleValue > 0) {
        [req setStature:patientInfo.stature.doubleValue];
    }
    if (patientInfo.weight.doubleValue > 0) {
        [req setWeight:patientInfo.weight.doubleValue];
    }
    if (patientInfo.bornDate.length > 0) {
        [req setBornDate:patientInfo.bornDate];
    }
    if (patientInfo.address.length > 0) {
        [req setAddress:patientInfo.address];
    }
    if (patientInfo.criticalIllness.length > 0) {
        [req setCriticalIllness:patientInfo.criticalIllness];
    }
    if (patientInfo.allergicHistory.length > 0) {
        [req setAllergicHistory:patientInfo.allergicHistory];
    }
    if (patientInfo.familyHistory.length > 0) {
        [req setFamilyHistory:patientInfo.familyHistory];
    }
    // 血型。 未知型血：0；A型血：1；B型血：2；O型血：3；AB型血：4；其他血型：5
    if (patientInfo.bloodType.intValue > -1) {
        [req setBloodType:patientInfo.bloodType.intValue];
    }
    ///*** 添加是否是婴幼儿绑卡 1:是; 0:否  by DC
    if (patientInfo.isChild.intValue >= 0) {
        [req setIsChild:patientInfo.isChild.intValue];
    }
    if (patientInfo.isChild.intValue > 0) {
        ///*** 婴幼儿时，添加生日  by DC
        if (patientInfo.bornDate.length > 0) {
            [req setBornDate:patientInfo.bornDate];
        }
        ///*** 婴幼儿时，添加性别  by DC
        if (patientInfo.gender.intValue >= 0) {
            [req setGender:patientInfo.gender.intValue];
        }
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"addPatient:" success:^(id content) {
        if ([content isKindOfClass:[NXTFAddPatientResp class]]) {
            NXTFAddPatientResp *resp = (NXTFAddPatientResp *)content;
            successBlock(resp.patient);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)modifyPatient:(NXTFPatientDto*)patientInfo modeType:(int32_t)modeType success:(void(^)(NXTFPatientDto *patientInfo))successBlock failure:(void(^)(NSError *error))failureBlock {

    NXTFModifyPatientReq *req = [[NXTFModifyPatientReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientInfo.relationId.intValue > 0) {
        [req setRelationId:patientInfo.relationId.intValue];
    }
    if (patientInfo.patientId.intValue > 0) {
        [req setPatientId:patientInfo.patientId.intValue];
    }
    if (patientInfo.name.length > 0) {
        [req setName:patientInfo.name];
    }
    // 性别, 0代表女,1代表男
    if (patientInfo.gender.length > 0 && patientInfo.gender.intValue > -1) {
        [req setGender:patientInfo.gender.intValue];
    }
    if (patientInfo.phoneNo.length > 0) {
        [req setPhoneNo:patientInfo.phoneNo];
    }
    if (patientInfo.papersNo.length > 0) {
        [req setPapersNo:patientInfo.papersNo];
    }
    if (patientInfo.papersTypeId.intValue > 0) {
        [req setPapersTypeId:patientInfo.papersTypeId.intValue];
    }
    if (patientInfo.medInsureance.length > 0) {
        [req setMedInsureance:patientInfo.medInsureance];
    }
    if (patientInfo.stature.doubleValue >= 0) {
        [req setStature:patientInfo.stature.doubleValue];
    }
    if (patientInfo.weight.doubleValue >= 0) {
        [req setWeight:patientInfo.weight.doubleValue];
    }
    if (patientInfo.bornDate.length > 0) {
        [req setBornDate:patientInfo.bornDate];
    }
    if (patientInfo.address.length > 0) {
        [req setAddress:patientInfo.address];
    }
    if (patientInfo.criticalIllness.length > 0) {
        [req setCriticalIllness:patientInfo.criticalIllness];
    }
    if (patientInfo.allergicHistory.length > 0) {
        [req setAllergicHistory:patientInfo.allergicHistory];
    }
    if (patientInfo.familyHistory.length > 0) {
        [req setFamilyHistory:patientInfo.familyHistory];
    }
    // 血型。 未知型血：0；A型血：1；B型血：2；O型血：3；AB型血：4；其他血型：5
    if (patientInfo.bloodType.intValue > -1) {
        [req setBloodType:patientInfo.bloodType.intValue];
    }
    // 身份证照片，默认正面在前，背面在后，文件名用逗号隔开(已在外面处理)
    if (patientInfo.papersPics.count > 0) {
        NSString *picsStr = patientInfo.papersPics.firstObject;
        [req setPapersPics:picsStr];
    }
    if (modeType == 1) {
        [req setModeType:modeType];
    }
    if (patientInfo.isChild.length > 0) {
        [req setIsChild:patientInfo.isChild.intValue];
    }
    
    ///*** 添加是否是婴幼儿绑卡 1:是; 0:否  by DC
    if (patientInfo.isChild.intValue >= 0) {
        [req setIsChild:patientInfo.isChild.intValue];
    }
    if (patientInfo.isChild.intValue > 0) {
        ///*** 婴幼儿时，添加生日  by DC
        if (patientInfo.bornDate.length > 0) {
            [req setBornDate:patientInfo.bornDate];
        }
        ///*** 婴幼儿时，添加性别  by DC
        if (patientInfo.gender.intValue >= 0) {
            [req setGender:patientInfo.gender.intValue];
        }
    }

    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"modifyPatient:" success:^(id content) {
        if ([content isKindOfClass:[NXTFModifyPatientResp class]]) {
            NXTFModifyPatientResp *resp = (NXTFModifyPatientResp *)content;

            if (resp.patient.userId == nil) {
                resp.patient.userId = @"";
            }
            if (resp.patient.patientId == nil) {
                resp.patient.patientId = @"";
            }
            if (resp.patient.headImg == nil) {
                resp.patient.headImg = @"";
            }
            if (resp.patient.name == nil) {
                resp.patient.name = @"";
            }
            if (resp.patient.gender == nil) {
                resp.patient.gender = @"";
            }
            if (resp.patient.phoneNo == nil) {
                resp.patient.phoneNo = @"";
            }
            if (resp.patient.papersNo == nil) {
                resp.patient.papersNo = @"";
            }
            if (resp.patient.papersTypeId == nil) {
                resp.patient.papersTypeId = @"";
            }
            if (resp.patient.medInsureance == nil) {
                resp.patient.medInsureance = @"";
            }
            if (resp.patient.stature == nil) {
                resp.patient.stature = @"";
            }
            if (resp.patient.weight == nil) {
                resp.patient.weight = @"";
            }
            if (resp.patient.bornDate == nil) {
                resp.patient.bornDate = @"";
            }
            if (resp.patient.address == nil) {
                resp.patient.address = @"";
            }
            if (resp.patient.relationId == nil) {
                resp.patient.relationId = @"";
            }
            if (resp.patient.criticalIllness == nil) {
                resp.patient.criticalIllness = @"";
            }
            if (resp.patient.allergicHistory == nil) {
                resp.patient.allergicHistory = @"";
            }
            if (resp.patient.familyHistory == nil) {
                resp.patient.familyHistory = @"";
            }
            if (resp.patient.bloodType == nil) {
                resp.patient.bloodType = @"";
            }
            if (resp.patient.cardNo == nil) {
                resp.patient.cardNo = @"";
            }
            if (resp.patient.inpatientNo == nil) {
                resp.patient.inpatientNo = @"";
            }
            if (resp.patient.cardCount == nil) {
                resp.patient.cardCount = @"";
            }
            if (resp.patient.inpatientCount == nil) {
                resp.patient.inpatientCount = @"";
            }
            if (resp.patient.patientHead == nil) {
                resp.patient.patientHead = @"";
            }
            
            successBlock(resp.patient);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)removePatient:(NSString *)patientId success:(void(^)(NXTFRemovePatientResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFRemovePatientReq *req = [[NXTFRemovePatientReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId && patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"removePatient:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFRemovePatientResp class]]) {
            NXTFRemovePatientResp *resp = (NXTFRemovePatientResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


+(void)queryPatients:(NSString *)patientId name:(NSString *)name phoneNo:(NSString *)phoneNo hospId:(NSString *)hospId success:(void(^)(NSMutableArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFQueryPatientsReq *req = [[NXTFQueryPatientsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    if (patientId && patientId.intValue > 0) {
        [req setPatientId:patientId.intValue];
    }
    
    if (name.length > 0) {
        [req setName:name];
    }
    
    if (phoneNo.length > 0) {
        [req setPhoneNo:phoneNo];
    }
    
    if (hospId && hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"queryPatients:" success:^(id content) {
        if ([content isKindOfClass:[NXTFQueryPatientsResp class]]) {
            NXTFQueryPatientsResp *resp = (NXTFQueryPatientsResp *)content;
            successBlock(resp.patients);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}


+(void)favorDr:(int64_t)drId operType:(NSString *)operType success:(void(^)(int32_t favorCount))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFFavorDrReq *favorDrReq = [[NXTFFavorDrReq alloc] init];
    [favorDrReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    if (drId>=0) {
        [favorDrReq setDrId:drId];
    }
    if (operType.length>0) {
        [favorDrReq setOperType:operType];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:favorDrReq selName:@"favorDr:" success:^(id content) {
        if ([content isKindOfClass:[NXTFFavorDrResp class]]) {
            NXTFFavorDrResp *resp = (NXTFFavorDrResp *)content;
            successBlock(resp.favorCount);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getFavorDrsSuccess:(void(^)(NSMutableArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetFavorDrsReq *req = [[NXTFGetFavorDrsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getFavorDrs:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetFavorDrsResp class]]) {
            NXTFGetFavorDrsResp *resp = (NXTFGetFavorDrsResp *)content;
            successBlock(resp.favorDrs);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getFavorHospsSuccess:(void(^)(NXTFGetFavorHospsResp *resp)) successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetFavorHospsReq *req = [[NXTFGetFavorHospsReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getFavorHosps:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetFavorHospsResp class]]) {
            NXTFGetFavorHospsResp *resp = (NXTFGetFavorHospsResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)feedback:(NSString *)feedback success:(void(^)(BOOL isSuccess))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFFeedbackReq *req = [[NXTFFeedbackReq alloc]init];
    req.header = [FCTFApi1ClientManager getHeader:YES];
    
    if (feedback.length > 0) {
        [req setFeedback:feedback];
    }

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"feedback:" success:^(id content) {
        if ([content isKindOfClass:[NXTFFeedbackResp class]]) {
            successBlock(YES);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getDictData:(NSString *)hospId dictType:(NSString *)dictType success:(void(^)( NXTFGetDictDataResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetDictDataReq *req = [[NXTFGetDictDataReq alloc]init];
    req.header = [FCTFApi1ClientManager getHeader:NO];
    
    if (hospId.intValue > 0) {
        [req setHospId:hospId.intValue];
    }
    if (dictType && dictType.length>0) {
        [req setDictType:dictType];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getDictData:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetDictDataResp class]]) {
            NXTFGetDictDataResp *resp = (NXTFGetDictDataResp *)content;
            successBlock(resp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
+(void)changePwd:(NSString *)phoneNo pwd:(NSString *)pwd newPwd:(NSString *)newPwd authCode:(NSString *)authCode success:(void (^)(NXTFChangePwdResp *))successBlock failure:(void (^)(NSError *))failureBlock
{
    NXTFChangePwdReq *changePwdReq = [[NXTFChangePwdReq alloc]init];
    changePwdReq.header = [FCTFApi1ClientManager getHeader:NO];
    if (phoneNo&&phoneNo.length > 0) {
       changePwdReq.phoneNo = phoneNo;
    }
    if (pwd && pwd.length>0) {
        changePwdReq.pwd = pwd;
    }
    if (newPwd) {
        changePwdReq.newPwd = newPwd;
    }
    if (authCode && authCode.length>0) {
        changePwdReq.authCode = authCode;
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:changePwdReq selName:@"changePwd:" success:^(id content) {
        if ([content isKindOfClass:[NXTFChangePwdResp class]]) {
            NXTFChangePwdResp *changePwdResp = (NXTFChangePwdResp *)content;
            successBlock(changePwdResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)getLatestVer:(void(^)(NXTFGetLatestVerResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetLatestVerReq *getLatestVerReq = [[NXTFGetLatestVerReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getLatestVerReq selName:@"getLatestVer:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetLatestVerResp class]]) {
            NXTFGetLatestVerResp *getLatestVerResp = (NXTFGetLatestVerResp *)content;
            successBlock(getLatestVerResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getPref:(void(^)(NXTFGetPrefResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetPrefReq *getPrefReq = [[NXTFGetPrefReq alloc] initWithHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getPrefReq selName:@"getPref:" success:^(id content) {
        successBlock(content);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)reqAuthCode:(NSString *)phoneNo reqMode:(int32_t)reqMode sendType:(int32_t)sendType success:(void(^)(NXTFReqAuthCodeResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFReqAuthCodeReq  *authCodeReq = [[NXTFReqAuthCodeReq alloc]init];
    authCodeReq.phoneNo = phoneNo;
    authCodeReq.reqMode = reqMode;
    authCodeReq.header = [FCTFApi1ClientManager getHeader:NO];
    authCodeReq.sendType = sendType;
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:authCodeReq selName:@"reqAuthCode:" success:^(id content) {
        if ([content isKindOfClass:[NXTFReqAuthCodeResp class]]) {
            NXTFReqAuthCodeResp *authCodeResp = (NXTFReqAuthCodeResp *)content;
            successBlock(authCodeResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }

    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
//thrift 注册
+(void)signUp:(NSString *)phoneNo pwd:(NSString *)pwd authCode:(NSString *)authCode name:(NSString *)name papersNo:(NSString *)papersNo papersTypeId:(int32_t)papersTypeId success:(void(^)(NXTFSignUpResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFSignUpReq *signUpRep = [[NXTFSignUpReq alloc]init];
    signUpRep.header = [FCTFApi1ClientManager getHeader:NO];
    signUpRep.phoneNo = phoneNo;
    signUpRep.pwd = pwd;
    signUpRep.authCode = authCode;
    if (name&&name.length>0) {
        signUpRep.name = name;
    }
    if (papersNo&&papersNo.length>0) {
        signUpRep.papersNo = papersNo;
    }
    signUpRep.papersTypeId = papersTypeId;
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:signUpRep selName:@"signUp:" success:^(id content) {
        if ([content isKindOfClass:[NXTFSignUpResp class]]) {
            NXTFSignUpResp *signUpResp = (NXTFSignUpResp *)content;
            successBlock(signUpResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
//修改姓名、手机号、修改手机号发送验证码
+(void)updateUser:(int32_t)updMode accountName:(NSString *)accountName newPhoneNo:(NSString *)newPhoneNo pwd:(NSString *)pwd authCode:(NSString *)authCode success:(void(^)(NXTFUpdateUserResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFUpdateUserReq *updateUserReq = [[NXTFUpdateUserReq alloc]init];
    updateUserReq.header = [FCTFApi1ClientManager getHeader:YES];
    updateUserReq.updMode = updMode;
    if (accountName && accountName.length > 0) {
        updateUserReq.accountName = accountName;
    } 
    if (newPhoneNo&&newPhoneNo.length > 0) {
        updateUserReq.newPhoneNo = newPhoneNo;
    }
    if (pwd&&pwd.length > 0) {
        updateUserReq.pwd = pwd;
    }
    if (authCode&&authCode.length > 0) {
        updateUserReq.authCode = authCode;
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:updateUserReq selName:@"updateUser:" success:^(id content) {
        if ([content isKindOfClass:[NXTFUpdateUserResp class]]) {
            NXTFUpdateUserResp *updateUserResp = (NXTFUpdateUserResp *)content;
            successBlock(updateUserResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
         failureBlock(error);
    }];
    }

+ (void)uploadPatientHead:(NSData *)patientHead patientId:(NSString *)patientId success:(void(^)(NXTFPatientHeadResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFPatientHeadReq *patientHeadRep = [[NXTFPatientHeadReq alloc]init];
    patientHeadRep.header = [FCTFApi1ClientManager getHeader:YES];
    if (patientHead.length > 0) {
        patientHeadRep.patientHead = patientHead;
    }
    if (patientId.length > 0) {
        patientHeadRep.patientId = patientId;
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:patientHeadRep selName:@"uploadPatientHead:" success:^(id content) {
        if ([content isKindOfClass:[NXTFPatientHeadResp class]]) {
            NXTFPatientHeadResp *patientHeadResp = (NXTFPatientHeadResp *)content;
            successBlock(patientHeadResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//关联聊天帐号
+(void)registerImWithSuccess:(void(^)(NXTFRegisterImResp *imAccountResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFRegisterImReq *imAccountReq = [[NXTFRegisterImReq alloc]init];
    [imAccountReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:imAccountReq selName:@"registerIm:" success:^(id content) {
        if ([content isKindOfClass:[NXTFRegisterImResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//获取聊天服务器地址
+(void)getImHostsWithSuccess:(void(^)(NXTFGetImHostsResp *imHostResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetImHostsReq *imHostReq = [[NXTFGetImHostsReq alloc]init];
    [imHostReq setHeader:[FCTFApi1ClientManager getHeader:YES]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:imHostReq selName:@"getImHosts:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetImHostsResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getRecomOptsSuccess:(void (^)(NXTFGetRecomOptsResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetRecomOptsReq *req = [[NXTFGetRecomOptsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getRecomOpts:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetRecomOptsResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getInsInfos:(NXTFPage *)page companyId:(int32_t)companyId Success:(void (^)(NXTFGetInsInfosResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetInsInfosReq *req = [[NXTFGetInsInfosReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (page) {
        [req setPage:page];
    }
    if (companyId > 0) {
        [req setCompanyId:companyId];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getInsInfos:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetInsInfosResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getInsPkg:(int32_t)packageId Success:(void (^)(NXTFGetInsPkgResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    NXTFGetInsPkgReq *req = [[NXTFGetInsPkgReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (packageId > 0) {
        [req setPackageId:packageId];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getInsPkg:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetInsPkgResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getHealthProfile:(int64_t)patientId Success:(void(^)(NXTFGetHealthProfileResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetHealthProfileReq *req = [[NXTFGetHealthProfileReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [req setPatientId:patientId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:req selName:@"getHealthProfile:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetHealthProfileResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getVisitList:(int64_t)patientId code:(NSString *)code card:(NSString *)card page:(NXTFPage *)page hospId:(int32_t)hospId Success:(void(^)(NXTFGetVisitListResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetVisitListReq *req = [[NXTFGetVisitListReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [req setPatientId:patientId];
    [req setCode:code];
    [req setCard:card];
    [req setPage:page];
    [req setHospId:hospId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:req selName:@"getVisitList:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetVisitListResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getVisitDetail:(NSString *)chid visitType:(int32_t)visitType patientId:(int64_t)patientId hospId:(int32_t)hospId Success:(void(^)(NXTFGetVisitDetailResp *respModel))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetVisitDetailReq *req = [[NXTFGetVisitDetailReq alloc]init];
    [req setHeader:[FCTFApi1ClientManager getHeader:YES]];
    [req setChid:chid];
    [req setVisitType:visitType];
    [req setPatientId:patientId];
    [req setHospId:hospId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:req selName:@"getVisitDetail:" success:^(id content) {
        if ([content isKindOfClass:[NXTFGetVisitDetailResp class]]) {
            successBlock(content);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)updateNickName:(NSString *)newNickName success:(void(^)(NXTFUpdateUserResp *model))successBlock failure:(void(^)(NSError *error))failureBlock
{
    NXTFUpdateUserReq *updateUserReq = [[NXTFUpdateUserReq alloc]init];
    updateUserReq.header = [FCTFApi1ClientManager getHeader:YES];
    updateUserReq.updMode = 4;
    if (newNickName.length > 0) {
        updateUserReq.nickName = newNickName;
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToSSlQuene:updateUserReq selName:@"updateUser:" success:^(id content) {
        if ([content isKindOfClass:[NXTFUpdateUserResp class]]) {
            NXTFUpdateUserResp *updateUserResp = (NXTFUpdateUserResp *)content;
            successBlock(updateUserResp);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}
@end
