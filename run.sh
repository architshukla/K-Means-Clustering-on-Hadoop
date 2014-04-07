#! /usr/bin/env bash

BASEFOLDER=/tmp/maxT/
DATASET=$BASEFOLDER/input/1.txt
KCENTROIDSFILE=$BASEFOLDER/input/centroids.txt
JARFILENAME=kMeans.jar

# Delete previous outputs
hadoop dfs -rmr $BASEFOLDER/output*

# Iterative K-Means Cluster Centroid calculation
time hadoop jar dist/$JARFILENAME kmeans.KMeansDriver $DATASET $KCENTROIDSFILE $BASEFOLDER/output_1

# Cluster Assignment
hadoop jar dist/$JARFILENAME clusterassign.ClusterAssignDriver $DATASET $KCENTROIDSFILE $BASEFOLDER/output_2
