//
//  ChipmunkShapeTypeLayer.h
//  BasicCocos2D
//
//  Created by Ian Fan on 26/08/12.
//
//

#import "cocos2d.h"
#import "ObjectiveChipmunk.h"
#import "CPDebugLayer.h"

@interface ChipmunkShapeTypeLayer : CCLayer
{
  ChipmunkSpace *_space;
  CPDebugLayer *_debugLayer;
}

+(CCScene *) scene;

@end
