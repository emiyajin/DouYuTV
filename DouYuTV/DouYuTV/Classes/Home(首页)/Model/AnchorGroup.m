//
//  AnchorGroup.m
//  DouYuTV
//
//  Created by emiyajin on 17/2/9.
//  Copyright © 2017年 emiyajin. All rights reserved.
//

#import "AnchorGroup.h"
#import <MJExtension.h>
#import "Anchor.h"

@implementation AnchorGroup
#pragma mark -- 懒加载
-(NSMutableArray<Anchor *> *)anchors
{
    if (!_anchors) {
        _anchors = [[NSMutableArray alloc]init];
    }
    return _anchors;
}

-(void)setIcon_name:(NSString *)icon_name
{
    if (icon_name.length == 0) {
        icon_name = @"home_header_normal";
    }
    _icon_name = icon_name;
}

-(void)setRoom_list:(NSArray *)room_list
{
    _room_list = room_list;

    for (NSDictionary *dict in room_list) {
       //遍历封装模型
        Anchor *anchor = [Anchor mj_objectWithKeyValues:dict];
        [self.anchors addObject:anchor];
    }
}
@end
