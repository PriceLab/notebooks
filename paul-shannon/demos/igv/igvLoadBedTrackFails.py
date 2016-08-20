
# coding: utf-8

# In[1]:

from igv import IGV, Reference, Track


# In[2]:

import pandas as pd


# In[3]:

igv = IGV(locus="chr1:1-200", reference=Reference(id="hg19"), 
          tracks=[Track(
                   name="Genes", 
                    url="//s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/gencode.v18.collapsed.bed",
                    index_url="//s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/gencode.v18.collapsed.bed.idx", 
                    display_mode="EXPANDED")])


# In[4]:

tbl = pd.DataFrame([["chr1", "10", "100", "fp1", 9.9], ["chr1", 90, 130, "fp2", 0.5]])


# In[12]:

tbl.to_csv("testTrack.bed", sep="\t", header=False, index=False)


# In[13]:

newTrack = Track(name="testTrack", 
                 format="bed", 
                 indexed=False, 
                 url="http://localhost:8890/notebooks/testTrack.bed", display_mode='EXPANDED')


# In[9]:

igv


# In[14]:

igv.load_track("testTrack.bed")


# In[ ]:



