//
//  MyFlowLayout.m
//  BCMClientManager
//
//  Created by kmallick on 9/10/14.
//
//

#import "MyFlowLayout.h"

//This class uses a Custom Flow logic for our Device TILE display used in MainView

@implementation MyFlowLayout

const NSInteger kMaxCellSpacing = 50;

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    
    //UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset];
    
    if (indexPath.item == 0) { // first item of section
        CGRect frame = currentItemAttributes.frame;
        frame.size.height = currentItemAttributes.frame.size.height - 40;
        //frame.origin.x = sectionInset.left; // first item of the section should always be left aligned
        currentItemAttributes.frame = frame;
        
        return currentItemAttributes;
    }
    
    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width + kMaxCellSpacing;
    
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(0,
                                              currentFrame.origin.y,
                                              self.collectionView.frame.size.width,
                                              currentFrame.size.height - 40);
    
    if (!CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)) { // if current item is the first item on the line
        // the approach here is to take the current frame, left align it to the edge of the view
        // then stretch it the width of the collection view, if it intersects with the previous frame then that means it
        // is on the same line, otherwise it is on it's own new line
        CGRect frame = currentItemAttributes.frame;
        frame.size.height = currentItemAttributes.frame.size.height - 40;
        //frame.origin.x = sectionInset.left; // first item on the line should always be left aligned
        currentItemAttributes.frame = frame;
        return currentItemAttributes;
    }
    
    CGRect frame = currentItemAttributes.frame;
    frame.origin.x = previousFrameRightPoint;
    frame.size.height = currentItemAttributes.frame.size.height - 40;
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}


@end
