//
//  DonoDaFesta.m
//  ProtocolosDelegates
//
//  Created by Daniel Arndt Alves on 2/2/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "DonoDaFesta.h"

@implementation DonoDaFesta

-(void)cadeOChurrasco {
    if (self.delegate == nil) {
        NSLog(@"putz, ferrou!");
        return;
    }
    
    [self.delegate acenderChurrasqueira];
    [self.delegate temperarCarne];
}

@end
