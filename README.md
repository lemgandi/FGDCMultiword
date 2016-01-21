# FGDCMultiword
Convert FGDC-parsed address data into a format useful for training the usaddress python module 

This is an xslt script which will convert multi-word FGDC address
components into single words delimited by the same tags, so that you
can use them to train the datamade/usaddress python parser (
https://github.com/datamade/usaddress ).  

The usaddress parser uses a probabilistic parsing engine at its core,
so the more data you use to train it, the more accurate it can be when
fed new data to parse. See their README.md (
http://github.com/datamade/usaddress ) for details on how to use new
data to train the usaddress parser.

Use this script if you have
already-parsed address data which you would like to use to enhance the
accuracy of the datamade/usaddress parser for your local addresses. 

Contents:

FGDC_multi_to_singleword.xslt  -- Conversion script
test.xml -- Test input xml
test_xslt.sh --- Script to run xsltproc against test.xml


