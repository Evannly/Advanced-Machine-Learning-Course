#!/usr/bin/python
import sys
import numpy as np

def name_count_1(name):
  arr = np.zeros(26)
  name = name.lower()
  for ind, x in enumerate(name):
    arr[ord(x)-ord('a')] += 1
    # arr[ord(x)-ord('a')+26] += ind+1
  
  return arr

def name_count_2(name):
  arr = np.zeros(26*26)
  name = name.lower()
  # Iterate every 2 characters  
  for x in xrange(len(name)-1):
    ind = (ord(name[x])-ord('a'))*26 + (ord(name[x+1])-ord('a'))
    arr[ind] += 1
  return arr


def name_count(name):
  arr = np.zeros(52+26*26+4)
  name = name.lower()
  # Iterate each character
  for ind, x in enumerate(name):
    arr[ord(x)-ord('a')] += 1
    arr[ord(x)-ord('a')+26] += ind+1

  # Iterate every 2 characters  
  for x in xrange(len(name)-1):
    ind = (ord(name[x])-ord('a'))*26 + (ord(name[x+1])-ord('a')) + 52
    arr[ind] += 1
  
  # Last character
  arr[-4] = ord(name[-1])-ord('a')
  # Second Last character
  arr[-3] = ord(name[-2])-ord('a')
  # Length of name
  arr[-2] = len(name)
  # judge if last is vowel
  arr[-1] = name[-1] in 'aeiou'
  '''
  'last_letter': name[-1],
            'last_two' : name[-2:],
            'last_three': name[-3:],
            'last_is_vowel' : (name[-1] in 'AEIOUY')
            '''
  return arr

def hashfeatures(name):
  B=128; # number of dimensions in our feature space
  v=[0]*B; # initialize the vector to be all-zeros
  name=name.lower() # make all letters lower case
  # hash prefixes & suffixes
  for m in range(3):
    featurestring='prefix'+name[0:min(m+1,len(name))]
    v[hash(featurestring) % B]=1
    featurestring='suffix'+name[-1:-min(m+2,len(name)+1):-1]
    v[hash(featurestring) % B]=1
  return v

for name in sys.stdin:
  #print ','.join(map(str,hashfeatures(name.strip())))
  print ','.join(map(str,name_count_1(name.strip())))