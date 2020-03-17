//
//  LLCollectionSectionDecorationLayout.m
//  CollectionViewSectionStyle
//
//  Created by 刘江 on 2020/3/14.
//  Copyright © 2020 Liujiang. All rights reserved.
//

#import "LLCollectionSectionDecorationLayout.h"
#import "LLCollectionSectionDecorationUtils.h"
#import "LLCollectionSectionDecorationLayout+Alignment.h"
#import "LLCollectionSectionDecorateView.h"

@interface LLCollectionSectionDecorationLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;
//@property (nonatomic, assign) BOOL needsSectionDecorated;
@property (nonatomic, strong)LLCollectionSectionDecorationModel *insideModel;
@end

@implementation LLCollectionSectionDecorationLayout

- (void)prepareLayout {
    [super prepareLayout];
  
    NSInteger sections = [self.collectionView numberOfSections];
    id <UICollectionViewSectionDecorationFlowLayout> delegate  = (id <UICollectionViewSectionDecorationFlowLayout>)self.collectionView.delegate;

    [self registerClass:[LLCollectionSectionDecorateView class] forDecorationViewOfKind:LLCollectionSectionDecorateViewKind];
    [self.decorationViewAttrs removeAllObjects];
    
    for (NSInteger i = 0; i < sections; i++) {
        LLCollectionSectionDecorationModel *model = self.insideModel;
        if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSection:)]) {
            model = [delegate collectionView:self.collectionView layout:self configModelForSection:i];
        }
        if (model.decorateAreaKind == LLCollectionViewSectionDecorateAreaNone || model == nil) continue;
        NSArray *points = [self initialPointsForSection:i configModel:model];
        CGPoint mostLeftTopPoint = [points.firstObject CGPointValue];
        CGPoint mostRightBottomPoint = [points.lastObject CGPointValue];
        
        int items = (int)[self.collectionView numberOfItemsInSection:i];
        //遍历第一行确定上左边界
        CGFloat firstRow_bottom = 0.f;
        int j = 0;
        for (; j < items; j++) {
            UICollectionViewLayoutAttributes *cellAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            if (firstRow_bottom < CGRectGetMinY(cellAttr.frame)) {
                break;
            }
            mostLeftTopPoint.x = MIN(CGRectGetMinX(cellAttr.frame), mostLeftTopPoint.x);
            mostLeftTopPoint.y = MIN(CGRectGetMinY(cellAttr.frame), mostLeftTopPoint.y);
            
            firstRow_bottom = MAX(CGRectGetMaxY(cellAttr.frame), firstRow_bottom);
        }
        //遍历最后一行确定下右边界
        CGFloat lastRow_top = 0.f;
        int k = items-1;
        for (; k > -1; k--) {
            UICollectionViewLayoutAttributes *cellAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:k inSection:i]];
            if (lastRow_top > CGRectGetMaxY(cellAttr.frame)) {
                break;
            }
            mostRightBottomPoint.x = MAX(CGRectGetMaxX(cellAttr.frame), mostRightBottomPoint.x);
            mostRightBottomPoint.y = MAX(CGRectGetMaxY(cellAttr.frame), mostRightBottomPoint.y);
            
            lastRow_top = MIN(CGRectGetMinY(cellAttr.frame), lastRow_top);
        }
        // 上述循环提早结束, 取前5个和后5个验算
        if (j < 5) {
            for (int m = 0; m < 5 && m < items; m++) {
                UICollectionViewLayoutAttributes *cellAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:m inSection:i]];
                mostLeftTopPoint.x = MIN(CGRectGetMinX(cellAttr.frame), mostLeftTopPoint.x);
                mostLeftTopPoint.y = MIN(CGRectGetMinY(cellAttr.frame), mostLeftTopPoint.y);
                
            }
        }
        if (k < 5) {
            for (int n = items-1; n > items - 6 && n > -1; n--) {
                UICollectionViewLayoutAttributes *cellAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:n inSection:i]];
                mostRightBottomPoint.x = MAX(CGRectGetMaxX(cellAttr.frame), mostRightBottomPoint.x);
                mostRightBottomPoint.y = MAX(CGRectGetMaxY(cellAttr.frame), mostRightBottomPoint.y);
                
            }
        }
        //加入padding
        mostLeftTopPoint.x -= model.decorateAreaPadding.left;
        mostLeftTopPoint.y -= model.decorateAreaPadding.top;
        mostRightBottomPoint.x += model.decorateAreaPadding.right;
        mostRightBottomPoint.y += model.decorateAreaPadding.bottom;

        
        LLCollectionViewSectionLayoutAttributes *attr = [LLCollectionViewSectionLayoutAttributes layoutAttributesForDecorationViewOfKind:LLCollectionSectionDecorateViewKind withIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        attr.frame = CGRectMake(mostLeftTopPoint.x, mostLeftTopPoint.y, mostRightBottomPoint.x-mostLeftTopPoint.x, mostRightBottomPoint.y-mostLeftTopPoint.y);
        attr.zIndex = -1;
        attr.configModel = model;
        [self.decorationViewAttrs addObject:attr];
        
        
    }
}
- (NSArray *)initialPointsForSection:(NSUInteger)section configModel:(LLCollectionSectionDecorationModel *)model {
   
    UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    if (CGRectGetWidth(headerAttr.frame) <= 0 || CGRectGetHeight(headerAttr.frame) <= 0) {
        headerAttr = nil;
    }
    if (CGRectGetWidth(footerAttr.frame) <= 0 || CGRectGetHeight(footerAttr.frame) <= 0) {
        footerAttr = nil;
    }
    CGPoint mostLeftTopPoint = CGPointMake(1000, 1000), mostRightBottomPoint = CGPointMake(-1000, -1000);
    if (headerAttr && !footerAttr && (model.decorateAreaKind == LLCollectionViewSectionDecorateAreaAll || model.decorateAreaKind == LLCollectionViewSectionDecorateAreaHeaderAndCell)) {
        
        mostLeftTopPoint = CGPointMake(CGRectGetMinX(headerAttr.frame), CGRectGetMinY(headerAttr.frame));
        mostRightBottomPoint = CGPointMake(CGRectGetMaxX(headerAttr.frame), CGRectGetMaxY(headerAttr.frame));
    }else if (headerAttr && footerAttr) {
        if (model.decorateAreaKind == LLCollectionViewSectionDecorateAreaHeaderAndCell) {
            mostLeftTopPoint = CGPointMake(CGRectGetMinX(headerAttr.frame), CGRectGetMinY(headerAttr.frame));
            mostRightBottomPoint = CGPointMake(CGRectGetMaxX(headerAttr.frame), CGRectGetMaxY(headerAttr.frame));
        }else if (model.decorateAreaKind == LLCollectionViewSectionDecorateAreaAll) {
            mostLeftTopPoint = CGPointMake(MIN(CGRectGetMinX(headerAttr.frame), CGRectGetMinX(footerAttr.frame)), MIN(CGRectGetMinY(headerAttr.frame), CGRectGetMinY(footerAttr.frame)));
            mostRightBottomPoint = CGPointMake(MAX(CGRectGetMaxX(headerAttr.frame), CGRectGetMaxX(footerAttr.frame)), MAX(CGRectGetMaxY(headerAttr.frame), CGRectGetMaxY(footerAttr.frame)));
        }else if (model.decorateAreaKind == LLCollectionViewSectionDecorateAreaFooterAndCell) {
            mostLeftTopPoint = CGPointMake(CGRectGetMinX(footerAttr.frame), CGRectGetMinY(footerAttr.frame));
            mostRightBottomPoint = CGPointMake(CGRectGetMaxX(footerAttr.frame), CGRectGetMaxY(footerAttr.frame));
        }
    }else if (!headerAttr && footerAttr && (model.decorateAreaKind == LLCollectionViewSectionDecorateAreaAll || model.decorateAreaKind == LLCollectionViewSectionDecorateAreaFooterAndCell)) {
        mostLeftTopPoint = CGPointMake(CGRectGetMinX(footerAttr.frame), CGRectGetMinY(footerAttr.frame));
        mostRightBottomPoint = CGPointMake(CGRectGetMaxX(footerAttr.frame), CGRectGetMaxY(footerAttr.frame));
    }
    
    
    return @[[NSValue valueWithCGPoint:mostLeftTopPoint], [NSValue valueWithCGPoint:mostRightBottomPoint]];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray * attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    //用户设置了对称方式，进行对称设置 (若没设置，不执行，继续其他计算)
    if (self.collectionCellAlignmentType != LLCollectionViewLayoutAlignmentTypeBySystem
        && self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //竖向,Cell对齐方式暂不支持横向
        NSArray *formatGroudAttr = [self groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:attrs];
        
        [self evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:formatGroudAttr
                                        toChangeAttributesAttrsList:&attrs
                                                  cellAlignmentType:self.collectionCellAlignmentType];
    }

    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrs addObject:attr];
    }
    
    return attrs;
}

#pragma mark - other

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttrs{
    if (!_decorationViewAttrs) {
        _decorationViewAttrs = [NSMutableArray array];
    }
    return _decorationViewAttrs;
}

#pragma mark - setter & getter
- (void)setDecorateAreaKind:(LLCollectionViewSectionDecorateArea)decorateAreaKind {
    self.insideModel.decorateAreaKind = decorateAreaKind;
}
- (LLCollectionViewSectionDecorateArea)decorateAreaKind {
    return self.insideModel.decorateAreaKind;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.insideModel.borderWidth = borderWidth;
}
- (CGFloat)borderWidth {
    return self.insideModel.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.insideModel.borderColor = borderColor;
}
- (UIColor *)borderColor {
    return self.insideModel.borderColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.insideModel.backgroundColor = backgroundColor;
}
- (UIColor *)backgroundColor {
    return self.insideModel.backgroundColor;
}

- (void)setBackgroundView:(UIView *)backgroundView {
    self.insideModel.backgroundView = backgroundView;
}
- (UIView *)backgroundView {
    return self.insideModel.backgroundView;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.insideModel.shadowColor = shadowColor;
}
- (UIColor *)shadowColor {
    return self.insideModel.shadowColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.insideModel.shadowOffset = shadowOffset;
}
- (CGSize)shadowOffset {
    return self.insideModel.shadowOffset;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.insideModel.shadowOpacity = shadowOpacity;
}
- (CGFloat)shadowOpacity {
    return self.insideModel.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.insideModel.shadowRadius = shadowRadius;
}
- (CGFloat)shadowRadius {
    return self.insideModel.shadowRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.insideModel.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius {
    return self.insideModel.cornerRadius;
}

- (void)setDecorateAreaPadding:(UIEdgeInsets)decorateAreaPadding {
    self.insideModel.decorateAreaPadding = decorateAreaPadding;

}
- (UIEdgeInsets)decorateAreaPadding {
    return self.insideModel.decorateAreaPadding;
}

- (LLCollectionSectionDecorationModel *)insideModel {
    
    if (!_insideModel) {
        _insideModel = [LLCollectionSectionDecorationModel new];
    }
    return _insideModel;
}
@end


