//
//  GMPhoneInfo.h
//  LifeAssistant
//
//  Created by GuoYongming on 1/28/16.
//  Copyright © 2016 GuoYongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMPhoneInfo : NSObject
@property (nonatomic, copy) NSString *province;         // 省
@property (nonatomic, copy) NSString *company;          // 公司
@property (nonatomic, copy) NSString *city;             // 市
@property (nonatomic, copy) NSString *areaCode;         // 区号
@property (nonatomic, copy) NSString *cardType;         // 卡类型
@property (nonatomic, copy) NSString *zipCode;          // 邮编
@end
