#! /usr/bin/env bash

BASEFOLDER=/tmp/maxT/
DATASET=$BASEFOLDER/input/1.txt
KCENTROIDSFILE=$BASEFOLDER/input/centroids.txt
JARFILENAME=kMeans.jar

# Delete previous outputs
hadoop dfs -rmr $BASEFOLDER/output*

hadoop jar dist/$JARFILENAME KMeans.KMeansDriver $DATASET $KCENTROIDSFILE $BASEFOLDER/output_1