//
//  AMAGuideAPI.m
//  FCNetworkApi
//
//  Created by 周鑫 on 15/7/6.
//  Copyright (c) 2015年 HZTeam. All rights reserved.
//

#import "AMAGuideAPI.h"
#import "AMDBHelper.h"

@implementation AMAGuideAPI

+(void)getDisease:(int64_t)diseaseId success:(void(^)(NXTFGetDiseaseResp *model))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetDiseaseReq *getDiseaseReq = [[NXTFGetDiseaseReq alloc] init];
    [getDiseaseReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (diseaseId>=0) {
        [getDiseaseReq setDiseaseId:diseaseId];
    }

    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getDiseaseReq selName:@"getDisease:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetDiseaseResp class]]) {
            NXTFGetDiseaseResp *getDiseaseResp = (NXTFGetDiseaseResp *)content;
            successBlock(getDiseaseResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
    
}

+(void)getDiseases:(int32_t)bodyPart crowd:(int32_t)crowd comDeptId:(int32_t)comDeptId name:(NSString*)name page:(NXTFPage*)page success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    
    NXTFGetDiseasesReq *getDiseasesReq = [[NXTFGetDiseasesReq alloc] init];
    [getDiseasesReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (bodyPart>=0) {
        [getDiseasesReq setBodyPart:bodyPart];
    }
    if (crowd>=0) {
        [getDiseasesReq setCrowd:crowd];
    }
    if (comDeptId>=0) {
        [getDiseasesReq setComDeptId:comDeptId];
    }
    if (name && name.length) {
        [getDiseasesReq setName:name];
    }
    if (page) {
        [getDiseasesReq setPage:page];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getDiseasesReq selName:@"getDiseases:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetDiseasesResp class]]) {
            NXTFGetDiseasesResp *getDiseasesResp = (NXTFGetDiseasesResp *)content;
            successBlock(getDiseasesResp.diseases);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];

    
}

+(void)findHosps:(NSString *)cityCode cityName:(NSString *)cityName specialtyId:(NSString *)specialtyId hospType:(NSString *)hospType hospLevel:(NSString *)hospLevel hospName:(NSString *)hospName comDeptId:(NSString *)comDeptId isRecommend:(NSString *)isRecommend orderBy:(NSString *)orderBy isOpened:(NSString *)isOpened isOpenReg:(NSString *)isOpenReg isOpenNet:(NSString *)isOpenNet currentLng:(NSString *)currentLng currentLat:(NSString *)currentLat page:(NXTFPage *)page success:(void(^)(NXTFFindHospsResp *hospitals))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFFindHospsReq *hospsReq = [[NXTFFindHospsReq alloc] init];
    [hospsReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [hospsReq setPage:page];
    
    if (cityCode && cityCode.length > 0) {
        [hospsReq setCityCode:cityCode];
    }
    if (cityName && cityName.length > 0) {
        [hospsReq setCityName:cityName];
    }
    if (specialtyId.length > 0 && specialtyId.intValue > 0) {
        [hospsReq setSpecialtyId:specialtyId.intValue];
    }
    if (hospType.length > 0 && hospType.intValue >= 0) {
        [hospsReq setHospType:hospType.intValue];
    }
    if (hospLevel.length > 0 && hospLevel.intValue > 0) {
        [hospsReq setHospLevel:hospLevel.intValue];
    }
    if (hospName && hospName.length>0) {
        [hospsReq setHospName:hospName];
    }
    if (comDeptId.length > 0 && comDeptId.intValue >= 0) {
        [hospsReq setComDeptId:comDeptId.intValue];
    }
    if (isRecommend.length > 0 && isRecommend.intValue >= 0) {
        [hospsReq setIsRecommend:isRecommend.intValue];
    }
    if (orderBy.length > 0 && orderBy.intValue >= 0) {
        [hospsReq setOrderBy:orderBy.intValue];
    }
    
    if (isOpened.length > 0 && isOpened.intValue >= 0) {
        [hospsReq setIsOpened:isOpened.intValue];
    }
    
    if (isOpenReg.length > 0 && isOpenReg.intValue >= 0) {
        [hospsReq setIsOpenReg:isOpenReg.intValue];
    }
    
    if (isOpenNet.length > 0 && isOpenNet.intValue >= 0) {
        [hospsReq setIsOpenNet:isOpenNet.intValue];
    }
    
    if (currentLng.length > 0 && currentLng.doubleValue >= 0) {
        [hospsReq setCurrentLng:currentLng.doubleValue];
    }
    
    if (currentLat.length > 0 && currentLat.doubleValue >= 0) {
        [hospsReq setCurrentLat:currentLat.doubleValue];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:hospsReq selName:@"findHosps:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFFindHospsResp class]]) {
            NXTFFindHospsResp *findHospsResp = (NXTFFindHospsResp *)content;
            [AMDBHelper replaceHospsCode:findHospsResp.findHospOutputs];
            successBlock(findHospsResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

//modify by 2.8.0 thirft
// 医院,医生擅长
+(void)getSpecialties:(void(^)(NSArray *array))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGetSpecialtiesReq *req = [[NXTFGetSpecialtiesReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getSpecialties:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetSpecialtiesResp class]]) {
            NXTFGetSpecialtiesResp *resp = (NXTFGetSpecialtiesResp *)content;
            successBlock(resp.specialties);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)findDoctors:(NSString *)cityCode cityName:(NSString *)cityName specialtyId:(NSString *)specialtyId comDeptId:(NSString *)comDeptId hospitalId:(NSString *)hospitalId hospType:(NSString *)hospType hospLevel:(NSString *)hospLevel isExpert:(NSString *)isExpert isRegisted:(NSString *)isRegisted docName:(NSString *)docName isRecommend:(NSString *)isRecommend orderBy:(NSString *)orderBy isConsulted:(NSString *)isConsulted docLevel:(int32_t)docLevel page:(NXTFPage *)page success:(void(^)(NXTFFindDoctorsResp *doctors))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFFindDoctorsReq *req = [[NXTFFindDoctorsReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [req setPage:page];
    if ([cityName isEqualToString:@"全国"]) {
        cityName = @"";
    }
    //城市编码(城市检索的优先条件)
    if (cityCode && cityCode.length > 0) {
        [req setCityCode:cityCode];
    }
    //医生名称
    if (docName && docName.length > 0) {
        [req setDocName:docName];
    }
    //城市名称(城市编码为空时，该条件有效)
    if (cityName && cityName.length > 0) {
        [req setCityName:cityName];
    }
    //擅长领域ID(DEF:全部)
    if (specialtyId.length > 0 && specialtyId.intValue >= 0) {
        [req setSpecialtyId:specialtyId.intValue];
    }
    //通用科室ID(DEF:全部)
    if (comDeptId.length > 0 && comDeptId.intValue >= 0) {
        [req setComDeptId:comDeptId.intValue];
    }
    // 医院Id
    if (hospitalId.length > 0 && hospitalId.intValue > 0) {
        [req setHospId:hospitalId.intValue];
    }
    //医院类型(0:综合 1:妇产 2:儿童 3:妇幼 4:中医 5:肿瘤 6:皮肤 7:口腔 8:眼科)(DEF:全部)
    if (hospType.length > 0 && hospType.intValue > -1) {
        [req setHospType:hospType.intValue];
    }
    //医院等级(1:三级甲等 2:三级 3:二级甲等 4:二级 5:一级甲等 6:一级)(DEF:全部)
    if (hospLevel.length > 0 && hospLevel.intValue > 0) {
        [req setHospLevel:hospLevel.intValue];
    }
    // 是否专家(0:全部 1:只专家)(DEF:全部)
    if (isExpert.length > 0 && isExpert.intValue > -1) {
        [req setIsExpert:isExpert.intValue];
    }
    // 是否可挂号(0:全部 1:只可挂号)(DEF:全部)
    if (isRegisted.length > 0 && isRegisted.intValue > -1) {
        [req setIsRegisted:isRegisted.intValue];
    }
    //是否推荐医院(0:否(DEF) 1:是)
    if (isRecommend.length > 0 && isRecommend.intValue > -1) {
        [req setIsRecommend:isRecommend.intValue];
    }
    //排序规则(0:患者数(DEF) 1:医院等级 2:大象评级 3:好评度)
    if (orderBy.intValue >= 0) {
        [req setOrderBy:orderBy.intValue];
    }
    // 是否可咨询(0:全部 1:只可咨询)(DEF:全部)
    if (isConsulted.intValue >= 0) {
        [req setIsConsulted:isConsulted.intValue];
    }
    if (docLevel >= 0) {
        [req setDocLevel:docLevel];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"findDoctors:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFFindDoctorsResp class]]) {
            NXTFFindDoctorsResp *findHospsResp = (NXTFFindDoctorsResp *)content;
            successBlock(findHospsResp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+(void)gdSearchWithCityName:(NSString *)cityName cityCode:(NSString *)cityCode searchText:(NSString *)searchText searchType:(NSString *)searchType page:(NXTFPage *)page success:(void(^)(NXTFGDSearchResp *resp))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    NXTFGDSearchReq *gdSearchReq = [[NXTFGDSearchReq alloc] init];
    [gdSearchReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (cityName.length > 0) {
        [gdSearchReq setCityName:cityName];
    }
    if (cityCode.length > 0) {
        [gdSearchReq setCityCode:cityCode];
    }
    [gdSearchReq setPage:page];
    [gdSearchReq setSearchText:searchText];
    [gdSearchReq setSearchType:[searchType integerValue]];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:gdSearchReq selName:@"gdSearch:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGDSearchResp class]]) {
            NXTFGDSearchResp *resp = (NXTFGDSearchResp *)content;
            successBlock(resp);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getAutognosisSyms:(NSString *)clientDictVer success:(void (^)(NXTFGetAutognosisSymsResp *))successBlock failure:(void (^)(NSError *))failureBlock {
    
    NXTFGetAutognosisSymsReq *req = [[NXTFGetAutognosisSymsReq alloc] init];
    
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    
    if (clientDictVer.length > 0) {
        
        [req setClientDictVer:clientDictVer];
    }
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getAutognosisSyms:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetAutognosisSymsResp class]]) {
            NXTFGetAutognosisSymsResp *resp = (NXTFGetAutognosisSymsResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getAutognosisDetail:(int32_t)crownId symptoms:(NSMutableArray *)symptoms dispMode:(int32_t)dispMode bodyPartId:(int32_t)bodyPartId bodyPartName:(NSString *)bodyPartName success:(void(^)(NXTFGetAutognosisDetailResp *getAutognosisDetailResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetAutognosisDetailReq *req = [[NXTFGetAutognosisDetailReq alloc] init];
    [req setHeader:[FCTFApi1ClientManager getHeader:NO]];
    if (crownId >= 0) {
        [req setCrownId:crownId];
    }
    if (symptoms.count > 0) {
        [req setSymptoms:symptoms];
    }
    [req setDispMode:dispMode];
    if (bodyPartId > 0) {
        [req setBodyPartId:bodyPartId];
    }
    if (bodyPartName.length > 0) {
        [req setBodyPartName:bodyPartName];
    }
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:req selName:@"getAutognosisDetail:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetAutognosisDetailResp class]]) {
            NXTFGetAutognosisDetailResp *resp = (NXTFGetAutognosisDetailResp *)content;
            successBlock(resp);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"返回数据格式错误" code:-11 userInfo:nil];
            failureBlock(error);
        }
        
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (void)getAutognosisDis:(int64_t)diseaseId success:(void(^)(NXTFGetAutognosisDisResp *getAutognosisDisResp))successBlock failure:(void(^)(NSError *error))failureBlock {
    NXTFGetAutognosisDisReq *getAutognosisDisReq = [[NXTFGetAutognosisDisReq alloc]init];
    [getAutognosisDisReq setHeader:[FCTFApi1ClientManager getHeader:NO]];
    [getAutognosisDisReq setDiseaseId:diseaseId];
    [[FCTFApi1ClientManager sharedTFApi1Client] addToQuene:getAutognosisDisReq selName:@"getAutognosisDis:" success:^(id content) {
        
        if ([content isKindOfClass:[NXTFGetAutognosisDisResp class]]) {
            NXTFGetAutognosisDisResp *resp = (NXTFGetAutognosisDisResp *)content;
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
