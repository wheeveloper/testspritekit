//
//  MyScene2.m
//  testspritekit
//
//  Created by dongwheepark on 2014. 6. 12..
//
//

#import "MyScene2.h"

//
//  MyScene.m
//  testspritekit
//
//  Created by dongwheepark on 2014. 6. 12..
//  Copyright (c) 2014년 __MyCompanyName__. All rights reserved.
//

#import "MyScene2.h"

@implementation MyScene2

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        SKSpriteNode *backNode = [SKSpriteNode spriteNodeWithImageNamed:@"날씨bg"];
        backNode.position = CGPointMake(self.size.width / 2 , self.size.height / 2);
        [self addChild:backNode];
        NSLog(@"%@", NSStringFromCGSize(self.frame.size));
        
        
        
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(raindrop:) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    
    
    
    
    
}
- (void)raindrop:(id)sender
{
    for (int a = 0; a < 20; a ++) {
        int isLeft = arc4random() % 3 ;
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"빛방울"];
        int x = arc4random() % 640;
        int gotoX = arc4random() % 100;
        int y = arc4random()  % 1000;
        
        int speed = arc4random() % 5+ 7;
        [sprite setScale:0.4f];
        sprite.position = CGPointMake(x, y + 1136);
        
        SKAction *action = [SKAction moveTo:CGPointMake(gotoX + x, -39) duration:speed ];
        [sprite runAction:[SKAction repeatAction:action count:1]];
        
        [self addChild:sprite];
        
    }
    
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

