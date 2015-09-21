# NPSP-Test-Data
Repository for NPSP test data generation and deployment ETL jobs

# Set up

The instructions below assume you have a copy of the Nonprofit Starter Pack 3 installed in your target org

## Install Kettle

    wget http://sourceforge.net/projects/pentaho/files/Data%20Integration/5.4/pdi-ce-5.4.0.1-130.zip/download
    unzip pdi-ce-5.4.0.1-130.zip

## Generate Test Data

    WORKING_DIR=`pwd`/npsp_1k
    cd data-integration
    ./kitchen.sh -rep="NPSP-Test-Data" -dir="Test Data Creation" -param:WORKING_DIR=$WORKING_DIR -job="Create Test Data"

## Deploy the Test Data

    cd ..
    WORKING_DIR=`pwd`/npsp_1k_deploy
    cd $WORKING_DIR
    cp config.properties.example config.properties
    vi config.properties   # Enter your org's username and password+token
    cp ../npsp_1k/npsp_test_data.db .
    
    cd ../data-integration
   
### For managed package installations 
    
    ./kitchen.sh -rep="NPSP-Test-Data" -dir="Test Data Deployment" -param:WORKING_DIR=$WORKING_DIR -job="Create Test Data"

### For unmanaged deployments

    ./kitchen.sh -rep="NPSP-Test-Data" -dir="Test Data Deployment Unmanaged" -param:WORKING_DIR=$WORKING_DIR -job="Create Test Data"

### Deleting the Test Data

WARNING: This wipes out all data found in the org that the scripts handle deletion of.  You've been warned!

    cd ..
    WORKING_DIR=`pwd`/npsp_1k_deploy
    cd $WORKING_DIR
   
### For managed package installations 
    
    ./kitchen.sh -rep="NPSP-Test-Data" -dir="Test Data Deployment/Delete" -param:WORKING_DIR=$WORKING_DIR -job="Delete Test Data"

### For unmanaged deployments

    ./kitchen.sh -rep="NPSP-Test-Data" -dir="Test Data Deployment Unmanaged/Delete" -param:WORKING_DIR=$WORKING_DIR -job="Delete Test Data"

## Building the 100k data set

Following the steps above replacing npsp_1k with npsp_100k 

## Deploying sample data to a Developer Edition Org

The 1k data set is too large to fit in the storage of a DE org.  If you want to populate a DE org with sample data, follow the steps above using the npsp_de and npsp_de_deploy folders instead of npsp_1k and npsp_1k_deploy.
