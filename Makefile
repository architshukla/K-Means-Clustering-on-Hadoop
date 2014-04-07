# Hadoop Jar
HADOOPJAR=$(HADOOP_HOME)/hadoop-core-*.jar

# Folders
SRC=src
BIN=bin
DIST=dist
JARFILENAME=kMeans.jar

# Folders in SRC
KMEANS=kmeans
CLUSTERASSIGN=clusterassign
DATAPOINT=datapoint

# Build all
all:	build_kmeans build_clusterassign
	mkdir -p $(BIN)
	mkdir -p $(DIST)

	mkdir -p $(BIN)/$(KMEANS)/
	mkdir -p $(BIN)/$(CLUSTERASSIGN)/
	mkdir -p $(BIN)/$(DATAPOINT)/

	mv $(SRC)/$(KMEANS)/*.class $(BIN)/$(KMEANS)/
	mv $(SRC)/$(CLUSTERASSIGN)/*.class $(BIN)/$(CLUSTERASSIGN)/
	mv $(SRC)/$(DATAPOINT)/*.class $(BIN)/$(DATAPOINT)/

	jar -cvf $(JARFILENAME) -C $(BIN) .
	mv $(JARFILENAME) $(DIST)

build_kmeans:	$(SRC)/$(KMEANS)/KMeansDriver.java \
				$(SRC)/$(KMEANS)/KMeansMapper.java \
				$(SRC)/$(KMEANS)/KMeansReducer.java \
				$(SRC)/$(DATAPOINT)/DataPoint.java
	javac -cp $(HADOOPJAR) $(SRC)/$(KMEANS)/KMeansDriver.java \
		$(SRC)/$(KMEANS)/KMeansMapper.java \
		$(SRC)/$(KMEANS)/KMeansReducer.java \
		$(SRC)/$(DATAPOINT)/DataPoint.java

build_clusterassign:	$(SRC)/$(CLUSTERASSIGN)/ClusterAssignDriver.java \
						$(SRC)/$(CLUSTERASSIGN)/ClusterAssignMapper.java \
						$(SRC)/$(CLUSTERASSIGN)/ClusterAssignReducer.java \
						$(SRC)/$(DATAPOINT)/DataPoint.java
	javac -cp $(HADOOPJAR) $(SRC)/$(CLUSTERASSIGN)/ClusterAssignDriver.java \
		$(SRC)/$(CLUSTERASSIGN)/ClusterAssignMapper.java \
		$(SRC)/$(CLUSTERASSIGN)/ClusterAssignReducer.java \
		$(SRC)/$(DATAPOINT)/DataPoint.java


# Clean
clean:	clean_allclassfiles
	if test -d $(BIN); then rm -rf $(BIN); fi
	if test -d $(DIST); then rm -rf $(DIST); fi

clean_allclassfiles:	clean_kmeans clean_datapoint

clean_kmeans:
	if test -f $(SRC)/$(KMEANS)/*.class; then rm $(SRC)/$(KMEANS)/*.class; fi

clean_datapoint:
	if test -f $(SRC)/$(DATAPOINT)/*.class; then rm $(SRC)/$(DATAPOINT)/*.class; fi