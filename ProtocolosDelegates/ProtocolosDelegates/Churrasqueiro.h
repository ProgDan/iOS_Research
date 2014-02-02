//
//  Churrasqueiro.h
//  ProtocolosDelegates
//
//  Created by Daniel Arndt Alves on 2/2/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Churrasqueiro <NSObject>

@required
-(void)acenderChurrasqueira;
-(void)temperarCarne;

@optional
-(void)servirCarne;

@end
