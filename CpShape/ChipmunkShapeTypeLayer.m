//
//  ChipmunkShapeTypeLayer.m
//  BasicCocos2D
//
//  Created by Ian Fan on 26/08/12.
//
//

#import "ChipmunkShapeTypeLayer.h"

@implementation ChipmunkShapeTypeLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	ChipmunkShapeTypeLayer *layer = [ChipmunkShapeTypeLayer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark -
#pragma mark Update

-(void)update:(ccTime)dt {
  [_space step:dt];
}

#pragma mark -
#pragma mark Chipmunk objects

-(void)setChipmunkObjectsWithDifferetShapeType {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  // set Circle Shape
  {
  cpFloat mass = 1;
  cpFloat innerRadius = 0;
  cpFloat outerRadius = 50;
  cpVect offset = cpvzero;
  cpVect position = cpv(winSize.width/5, winSize.height/2);
  cpFloat elasticity = 0.8;
  cpFloat friction = 0.2;
  
  cpFloat moment = cpMomentForCircle(mass, innerRadius, outerRadius, offset);
  ChipmunkBody *body = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  body.pos = position;
  [_space addBody:body];
  
  ChipmunkShape *shape = [ChipmunkCircleShape circleWithBody:body radius:outerRadius offset:offset];
  shape.elasticity = elasticity;
  shape.friction = friction;
  [_space addShape:shape];
  }
  
  //set BoxPoly Shape
  {
  cpFloat mass = 1;
  cpFloat width = 100;
  cpFloat height = 100;
  cpVect position = cpv(winSize.width*2/5, winSize.height/2);
  cpFloat elasticity = 0.8;
  cpFloat friction = 0.2;
  
  cpFloat moment = cpMomentForBox(mass, width, height);
  ChipmunkBody *body = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  body.pos = position;
  [_space addBody:body];
  
  ChipmunkShape *shape = [ChipmunkPolyShape boxWithBody:body width:width height:height];
  shape.elasticity = elasticity;
  shape.friction = friction;
  [_space addShape:shape];
  }
  
  // set Polygon Shape
  {
  cpFloat mass = 1;
  cpVect verts[5] = { cpv(-50, -50),cpv(-80, 30), cpv(0, 100), cpv(80, 30), cpv(50, -50) };
  cpVect offset = cpvzero;
  cpVect position = cpv(winSize.width*3/5, winSize.height/2);
  cpFloat elasticity = 0.8;
  cpFloat friction = 0.2;
  
  cpFloat moment = cpMomentForPoly(mass, 5, verts, offset);
  ChipmunkBody *body = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  body.pos = position;
  [_space addBody:body];
  
  ChipmunkShape *shape = [ChipmunkPolyShape polyWithBody:body count:5 verts:verts offset:offset];
  shape.elasticity = elasticity;
  shape.friction = friction;
  [_space addShape:shape];
  }
  
  //set Segment Shape
  {
  cpFloat mass = 1;
  cpVect a = cpv(-50, -50);
  cpVect b = cpv(-50,  50);
  cpFloat radius = 5;
  cpVect position = cpv(winSize.width*4/5, winSize.height/2);
  cpFloat elasticity = 0.8;
  cpFloat friction = 0.2;
  
  cpFloat moment = cpMomentForSegment(mass, a, b);
  ChipmunkBody *body = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  body.pos = position;
  body.angle = 0.4;
  [_space addBody:body];
  
  ChipmunkShape *shape = [ChipmunkSegmentShape segmentWithBody:body from:a to:b radius:radius];
  shape.elasticity = elasticity;
  shape.friction = friction;
  [_space addShape:shape];
  }
}

#pragma mark -
#pragma mark Chipmunk DebugLayer

-(void)setChipmunkDebugLayer {
  _debugLayer = [[CPDebugLayer alloc]initWithSpace:_space.space options:nil];
  [self addChild:_debugLayer z:999];
}

#pragma mark -
#pragma mark Chipmunk Space

-(void)setChipmunkSpace {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  _space = [[ChipmunkSpace alloc]init];
  [_space addBounds:CGRectMake(0, 0, winSize.width, winSize.height) thickness:60 elasticity:1.0 friction:0.2 layers:CP_ALL_LAYERS group:CP_NO_GROUP collisionType:@"borderType"];
  _space.gravity = cpv(0, -300);
}

/*
 Target: Set many types of Chipmunk Shape, including circle, boxPoly, polygon and segment shape.
 
 1. Set Chipmunk Space, DebugLayer and updateStep as usual.
 2. Set Chipmunk objects with different shapes, including circle, boxPoly, polygon and segment shape.
 */

#pragma mark -
#pragma mark Init

-(id) init {
	if((self = [super init])) {
    [self setChipmunkSpace];
    
    [self setChipmunkDebugLayer];
    
    [self setChipmunkObjectsWithDifferetShapeType];
    
    [self schedule:@selector(update:)];
	}
  
	return self;
}

- (void) dealloc {
  [_space release];
  [_debugLayer release];
  
	[super dealloc];
}

@end
