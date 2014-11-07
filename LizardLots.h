//
//  LizardLots.h
//  Lizard
//
//  Created by Ty Parker on 11/5/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

#import <Realm/Realm.h>

@interface LizardLots : RLMObject
<# Add properties here to define the model #>
@end

// This protocol enables typed collections. i.e.:
// RLMArray<LizardLots>
RLM_ARRAY_TYPE(LizardLots)
