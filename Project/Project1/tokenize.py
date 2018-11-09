#!/usr/bin/python
#
# Usage: 
# python tokenize.py log_2(HASHBUCKETSIZE)
#
# 
# https://github.com/abhijeet3922/Mail-Spam-Filtering/blob/master/lingspam_filter.py

import email as em
import numpy as np
import os, sys
from collections import Counter

feature_dim = 5
bag_of_word_dim = 1500

def pre_process(string):
    punctuation = [',', '.', '_', '(', ')', '-', '<', '>',\
                   ':', '+', '#', '=', '\'', ';', '\"', '|',\
                   '[',']','{','}','&']
	string = string.lower()
    for item in punctuation:
        string = string.replace(item, '')
    for item in [int(s) for s in string.split() if s.isdigit()]:
        string = string.replace(str(item), 'number')
    return string

def make_Dictionary(path,ind):
    all_words = []
    for mailidx in range(len(ind)):
        with open(os.path.join(path,ind[mailidx][1])) as m:            
            msg = em.message_from_file(m)
            body = msg.get_payload()            
            # Turn list into string
            if type(body) is list:
                body = ' '.join(str(section) for section in body)
            body_words = pre_process(body).split()
            #body_words = body.split()  # XEDIT

            subject = msg.get("subject")
            subject_words=[]
            if (subject is not None) and (len(subject.split())>0):
                subject_words = pre_process(subject).split()
                #subject = pre_process(subject)
                #subject_words = subject.split()
            all_words+=body_words+subject_words
    dictionary = Counter(all_words)
    total_words_count = sum(dictionary.values())
    
    stopWordsStr=open('stopwords.txt').read().replace('\n',' ')
    stopWordsList=stopWordsStr.split()
    # Remove stop words from dictionary
    for item in dictionary.keys():
        if item in stopWordsList:
            del dictionary[item]
        elif item.isalpha() == False: 
            del dictionary[item]
        elif len(item) == 1:
            del dictionary[item]
        elif len(item) >= 20:
            del dictionary[item]
    
    dictionary = dictionary.most_common(bag_of_word_dim)
    return dictionary



# build feature vector of single email
def extract_features_single(directory):	
    features_arr = np.zeros((1,feature_dim+bag_of_word_dim))
    m = open(directory, "r")

	# Code for processing single email
	# Used Feature Vars:
	# subj_richness, body_richness
	# body_noCharacters ,body_HTML
	# url_noLinks

	# divide into different parts
    msg = em.message_from_file(m)
    subject = msg.get("subject")        
    subject_words=[]
    if (subject is not None) and (len(subject.split())>0):
        subject_words=pre_process(subject).split()
        subj_richness=len(subject.replace(' ',''))/len(subject.split());	features_arr[0,feature_dim+0] = subj_richness*100;

    body = msg.get_payload()
    # Turn list into string
    if type(body) is list:
        body = ' '.join(str(para) for para in body)
    body_words=pre_process(body).split()
    #body_words = body.split()	# \n is also cleared out
    body_noCharacters=len(body.replace(' ',''));                        features_arr[0,feature_dim+1] = body_noCharacters*100;
    body_richness=body_noCharacters/len(body.split());               features_arr[0,feature_dim+2] = body_richness*100;
    body_HTML=body.count('/>');                                     features_arr[0,feature_dim+3] = body_HTML*100;

    url_noLinks=body.count('http');                                 features_arr[0,feature_dim+4] = url_noLinks*100;
    
    meaningful_words=body_words+subject_words
    
	# traverse every word in dictionary, find how many times it appears in this mail
    for idx,word in enumerate(dictionary):        
        wordID=idx; word=word[0]; 
        #wordIDF=total_words_count/(dictionary[wordID][1])   # dictionary[i]: ('word', count)
        features_arr[0,wordID] = meaningful_words.count(word)
        #features_arr[0,wordID] = meaningful_words.count(word)*wordIDF

    # features_arr = features_arr / np.linalg.norm(features_arr)
    return features_arr

path=sys.argv[1]
# path=os.path.join(os.getcwd(),'data\data_train')

ind=[x.split() for x in open(path+'/index').read().split('\n') if len(x)>0] # read in index file
total_words_count=0
dictionary = make_Dictionary(path,ind)

feature_mat=np.matrix(np.zeros([feature_dim+bag_of_word_dim,len(ind)]))

# build codebook
for (num,(labelStr,fn)) in enumerate(ind):
	features_vec = np.transpose(extract_features_single(path+'/'+fn))
	feature_mat[:,num] = features_vec

np.savetxt('spamdata.csv',feature_mat,fmt='%d',delimiter=',')




	
