
# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import numpy as np
class Rect(object):
        def _init_(self, height=10, width=5):
            self.height = 10
            self.width = 5
                
        def area(self):
            return(self.height * self.width)
                    
c1 = Rect(7, 7)
c2 = Rect(14, 3)
print(c1.area())
c1.height = 20
print(c1.area(), c2.area())

if _name_ == '_main_':
        print("I'm UTSA")
else:
        print("I'm not at UTSA")
        
try:
        y = 17 / 0
except:
    y = np.Nam
    print("not gonna work")
print(y)

sanity check function