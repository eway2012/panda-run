//
//  TTSpriteItem.m
//  panda-run
//
//  Created by Qi He on 12-7-30.
//  Copyright (c) 2012年 Heyook. All rights reserved.
//

#import "TTSpriteItem.h"
#import "Constants.h"

@implementation TTSpriteItem

@synthesize velocity = _velocity;

+ (TTSpriteItem *) createSpriteItemWithName:(NSString *)name{
  return [[[self alloc] initWithSpriteFrameName:name] autorelease];
}

-(id) initWithSpriteFrameName:(NSString *)imageName
{
  if ((self = [super initWithSpriteFrameName:imageName]))
	{
	}
	
	return self;
}

-(void) dealloc
{
	
	[super dealloc];
}

- (void)reset
{
  float screenWidth = [[CCDirector sharedDirector] winSize].width;
  float screenHeight= [[CCDirector sharedDirector] winSize].height;
	
  self.position = CGPointMake(screenWidth, (arc4random() % 5 * 0.1 + 0.25)*screenHeight );
  
  _timeCount = 0;
  _rotationRandomFactor = arc4random() % 10 * 0.1 + 0.5;
}

-(void) start
{	
	self.visible = YES;
	[self reset];
	[self scheduleUpdate];
}

-(void) update:(ccTime)delta
{
  if (_timeCount == 20) {
    
    _timeCount = 0;
    
    float y = arc4random() % 10;
    float x = arc4random() % 5;
    
    y = cosf(y) * 0.5f;
    x = cosf(x) * 0.5f - 2.0f;
    
    self.velocity = CGPointMake(x, y);
    
    _rotationChange = _rotationRandomFactor * ANGLE_TO_DEGREE * 0.05f;
    
  }
  
  _timeCount ++;
  
  self.rotation = self.rotation + _rotationChange;
	self.position = ccpAdd(self.position, self.velocity);
	
	if (   self.position.x > [[CCDirector sharedDirector] winSize].width 
      || self.position.x < 0
      || self.position.y < 0
      || self.position.y > [[CCDirector sharedDirector] winSize].height )
	{
    [self reset];
	}
}

@end
