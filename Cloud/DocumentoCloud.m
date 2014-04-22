//
//  DocumentoCloud.m
//  Cloud
//
//  Created by Eduardo Lima on 3/30/14.
//  Copyright (c) 2014 personal. All rights reserved.
//

#import "DocumentoCloud.h"

@implementation DocumentoCloud


//Upload
-(id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError{
    
    //Serializar as informações do vetor
    return [NSKeyedArchiver archivedDataWithRootObject:self.anotacoes];
}

//Download
-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError{
    
    id conteudo = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
    
    
    if (!conteudo) {
        self.anotacoes = [[NSMutableArray alloc] init];
    }
    else{
        
        if ([conteudo isKindOfClass:[NSMutableArray class]]) {
            self.anotacoes = (NSMutableArray*)conteudo;
        }
        
    }
    
    return YES;
    
}

@end
