//
//  LLCollectionSectionDecorationLayout+Alignment.m
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLCollectionSectionDecorationLayout+Alignment.h"
#import "LLCollectionSectionDecorationUtils.h"

@implementation LLCollectionSectionDecorationLayout (Alignment)

- (NSArray *)groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    NSMutableDictionary *allDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attr  in layoutAttributesAttrs) {
        
        NSMutableArray *dictArr = allDict[@(CGRectGetMidY(attr.frame))];
        if (dictArr) {
            [dictArr addObject:[attr copy]];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithObject:[attr copy]];
            allDict[@(CGRectGetMidY(attr.frame))] = arr;
        }
    }
    return allDict.allValues;
}

- (NSArray *)groupLayoutAttributesForElementsByXLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    NSMutableDictionary *allDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        NSMutableArray *dictArr = allDict[@(attr.frame.origin.x)];
        if (dictArr) {
            [dictArr addObject:[attr copy]];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithObject:[attr copy]];
            allDict[@(attr.frame.origin.x)] = arr;
        }
    }
    return allDict.allValues;
}

- (NSMutableArray *)evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs toChangeAttributesAttrsList:(NSMutableArray *_Nonnull *_Nonnull)toChangeAttributesAttrsList cellAlignmentType:(LLCollectionViewLayoutAlignmentType)alignmentType{
    NSMutableArray *toChangeList = *toChangeAttributesAttrsList;
    [toChangeList removeAllObjects];
    for (NSArray *calculateAttributesAttrsArr in layoutAttributesAttrs) {
        switch (alignmentType) {
            case LLCollectionViewLayoutAlignmentTypeLeft:{
                [self evaluatedCellSettingFrameByLeftWithWithJJCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case LLCollectionViewLayoutAlignmentTypeCenter:{
                [self evaluatedCellSettingFrameByCentertWithWithJJCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case LLCollectionViewLayoutAlignmentTypeRight:{
                NSArray* reversedArray = [[calculateAttributesAttrsArr reverseObjectEnumerator] allObjects];
                [self evaluatedCellSettingFrameByRightWithWithJJCollectionLayout:self layoutAttributesAttrs:reversedArray];
            }break;
            case LLCollectionViewLayoutAlignmentTypeRightAndStartR:{
                [self evaluatedCellSettingFrameByRightWithWithJJCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            default:
                break;
        }
        [toChangeList addObjectsFromArray:calculateAttributesAttrsArr];
    }
    return toChangeList;
}

#pragma mark - alignment

- (void)evaluatedCellSettingFrameByLeftWithWithJJCollectionLayout:(LLCollectionSectionDecorationLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    //left
    UICollectionViewLayoutAttributes *pAttr = nil;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [LLCollectionSectionDecorationUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.x = [LLCollectionSectionDecorationUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].left;
            }
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [LLCollectionSectionDecorationUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [LLCollectionSectionDecorationUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}

/// 计算AttributesAttrs居中对齐
/// @param layout JJCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByCentertWithWithJJCollectionLayout:(LLCollectionSectionDecorationLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    
    //center
    UICollectionViewLayoutAttributes *pAttr = nil;
    
    CGFloat useWidth = 0;
            NSInteger theSection = ((UICollectionViewLayoutAttributes *)layoutAttributesAttrs.firstObject).indexPath.section;
            for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
                useWidth += attr.bounds.size.width;
            }
    CGFloat firstLeft = (self.collectionView.bounds.size.width - useWidth - ([LLCollectionSectionDecorationUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:theSection]*layoutAttributesAttrs.count))/2.0;
    
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [LLCollectionSectionDecorationUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.x = firstLeft;
            }
            attr.frame = frame;
            pAttr = attr;
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [LLCollectionSectionDecorationUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [LLCollectionSectionDecorationUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}


/// 计算AttributesAttrs右对齐
/// @param layout JJCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByRightWithWithJJCollectionLayout:(LLCollectionSectionDecorationLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
//    right
    UICollectionViewLayoutAttributes *pAttr = nil;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x - [LLCollectionSectionDecorationUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section] - frame.size.width;
            }else{
                frame.origin.x = layout.collectionView.bounds.size.width - [LLCollectionSectionDecorationUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].right - frame.size.width;
            }
        }else{
            
        }
        attr.frame = frame;
        pAttr = attr;
    }
}


@end
