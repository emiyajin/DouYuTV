//
//  CycleModel.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/10.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "CycleModel.h"
#import <MJExtension.h>

@implementation CycleModel
-(void)setRoom:(NSDictionary *)room
{
    _room = room;

    self.anchorModel = [Anchor mj_objectWithKeyValues:room];
}
@end
