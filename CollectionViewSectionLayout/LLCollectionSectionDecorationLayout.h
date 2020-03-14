//
//  LLCollectionSectionDecorationLayout.h
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLCollectionSectionDecorationLayoutConfig.h"
#import "LLCollectionSectionDecorationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LLCollectionSectionDecorationLayout : UICollectionViewFlowLayout<UICollectionViewSectionDecorateAttributes>
@property (assign, nonatomic) LLCollectionViewLayoutAlignmentType collectionCellAlignmentType;

@end

NS_ASSUME_NONNULL_END
