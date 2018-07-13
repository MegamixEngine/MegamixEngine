#!/bin/bash

echo "assign..."
python ./strexec_varsearch_alt.py ../ -assign > ../scripts/setInstanceVariable.gml
echo "read..."
python ./strexec_varsearch_alt.py ../ -read > ../scripts/getInstanceVariable.gml
echo "assign array..."
python ./strexec_varsearch_alt.py ../ -assigna > ../scripts/setInstanceVariableArray.gml
echo "read array..."
python ./strexec_varsearch_alt.py ../ -reada > ../scripts/getInstanceVariableArray.gml
echo "done"
