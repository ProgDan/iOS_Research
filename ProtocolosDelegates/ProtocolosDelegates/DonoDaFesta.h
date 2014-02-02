//
//  DonoDaFesta.h
//  ProtocolosDelegates
//
//  Created by Daniel Arndt Alves on 2/2/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "Pessoa.h"
#import "Churrasqueiro.h"

@interface DonoDaFesta : Pessoa

@property (nonatomic, strong) id <Churrasqueiro> delegate;

-(void)cadeOChurrasco;

@end
