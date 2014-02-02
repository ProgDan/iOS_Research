//
//  Professor.h
//  Classes
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "Pessoa.h"
#import "Churrasqueiro.h"

@interface Professor : Pessoa <Churrasqueiro>

-(void)ministrarAula;

@end
