//
//  Professor.m
//  Classes
//
//  Created by Daniel Arndt Alves on 2/1/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "Professor.h"

@implementation Professor

-(void)acenderChurrasqueira{
    NSLog(@"Pegar um tanque de guerra e atirar na churrasqueira.");
}

-(void)temperarCarne {
    NSLog(@"Lançar a carne no saco se sal grosso");
}

// Método novo
-(void)ministrarAula {
    [super falar];
    [self falar];
    NSLog(@"aula aula aula. ...");
}

// Método da classe pessoa, sobrescrevendo
-(void)falar {
    NSLog(@"O meu nome é %@ e sou professor de Objective C.", self.nome);
}

@end
