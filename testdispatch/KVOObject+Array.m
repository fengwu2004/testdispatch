//
//  KVOObject+Array.m
//  testdispatch
//
//  Created by ky on 2018/8/23.
//  Copyright © 2018 yellfun. All rights reserved.
//

#import "KVOObject+Array.h"
#import <objc/runtime.h>
#import "TestObj.h"

@implementation KVOObject (Array)

- (void)setObj:(TestObj *)value {

  if (!class_getProperty(self.class, "backProperty")) {
    
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([value class])] UTF8String] };
    
    objc_property_attribute_t ownership = { "&", "N" };
    
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", @"obj"] UTF8String] };
    
    objc_property_attribute_t attr[] = {type, ownership, backingivar};
    
    class_addProperty(self.class, "backProperty", attr, 3);
    
    class_addMethod(self.class, @selector(setBackObj:), (IMP)setBackProperty, "V@:@");
    
    class_addMethod(self.class, @selector(backObj), (IMP)getBackProperty, "@@:");
  }
  
  [self performSelector:@selector(setBackObj:) withObject:value];
}

id getBackProperty(id self, SEL sel) {
  
  Ivar ivar = class_getInstanceVariable(KVOObject.class , "_obj");
  
  return object_getIvar(self, ivar);
}

void setBackProperty(id self, SEL _sel, TestObj *obj) {
  
  Ivar ivar = class_getInstanceVariable(KVOObject.class , "_obj");
  
  id old = object_getIvar(self, ivar);
  
  if (old != obj) {
    
    object_setIvar(self, ivar, obj);
  }
}

- (TestObj*)obj {
  
  if (!class_getProperty(self.class, "backProperty")) {
    
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([TestObj class])] UTF8String] };
    
    objc_property_attribute_t ownership = { "&", "N" };
    
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", @"obj"] UTF8String] };
    
    objc_property_attribute_t attr[] = {type, ownership, backingivar};
    
    class_addProperty(self.class, "backProperty", attr, 3);
    
    class_addMethod(self.class, @selector(setBackObj:), (IMP)setBackProperty, "V@:@");
    
    class_addMethod(self.class, @selector(backObj), (IMP)setBackProperty, "@@:");
  }
  
  return [self performSelector:@selector(backObj)];
}

@end
