#!  /usr/bin/env python3

import os
import numpy as np

os.chdir('../tmp')

for filt in 'griz': 
	with open("RES." + filt) as f: 
		na = [] 
		for l in f:
			lb = l.split() 
			na.append(float(lb[3]))
		na = np.array(na)
		m = na.mean()
		s = na.std()
		print("%s %.4f %.4f %.2f%%" % (filt, m, s, 100*s/m))

