//
//  DocumentoCloud.m
//  iCloud
//
//  Created by Daniel Arndt Alves on 3/30/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import "DocumentoCloud.h"

@implementation DocumentoCloud

// Upload
-(id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    return [NSKeyedArchiver archivedDataWithRootObject:self.anotacoes];
}

// Download
-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    id conteudo = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
    
    if (conteudo) {
        if ([conteudo isKindOfClass:[NSMutableArray class]]) {
            self.anotacoes = conteudo;
        }
    }
    else {
        self.anotacoes = [NSMutableArray new];
    }
    
    return YES;
}

@end
