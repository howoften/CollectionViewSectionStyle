//
//  LLCollectionSectionDecorationModel.m
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLCollectionSectionDecorationModel.h"

@implementation LLCollectionSectionDecorationModel

@synthesize backgroundColor = _backgroundColor;

@synthesize backgroundView;

@synthesize borderColor;

@synthesize decorateAreaPadding;

@synthesize borderWidth;

@synthesize cornerRadius;

@synthesize shadowColor;

@synthesize shadowOffset;

@synthesize shadowRadius;

@synthesize decorateAreaKind;

@synthesize shadowOpacity;


- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithWhite:242/255.f alpha:1];
    }
    return _backgroundColor;
}
@end
