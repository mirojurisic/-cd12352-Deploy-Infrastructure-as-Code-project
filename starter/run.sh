#!/bin/bash
# Automation script for CloudFormation templates. 
#
# Parameters
#   $1: Execution mode. Valid values: deploy, delete, preview.
#   $2: STACK_NAME
#   $3: TEMPLATE_FILE_NAME
#   $4: PARAMETERS_FILE_NAME
#
# REGION is fixed to "eu-central-1"
# Usage examples:
#   ./run.sh deploy  udacity-scripts-exercise exercise.yml exercise-params.json
#   ./run.sh create  udacity-scripts-exercise exercise.yml exercise-params.json
#   ./run.sh update  udacity-scripts-exercise exercise.yml exercise-params.json
#   ./run.sh preview  udacity-scripts-exercise exercise.yml exercise-params.json
#   ./run.sh delete  udacity-scripts-exercise
#

# Validate parameters
if [[ $1 != "deploy" && $1 != "create" && $1 != "update" && $1 != "delete" && $1 != "preview" ]]; then
    echo "ERROR: Incorrect execution mode. Valid values: create, deploy, update, delete, preview." >&2
    exit 1
fi

EXECUTION_MODE=$1
STACK_NAME=$2
TEMPLATE_FILE_NAME=$3
PARAMETERS_FILE_NAME=$4

# Execute CloudFormation CLI
if [ $EXECUTION_MODE == "deploy" ]
then
    aws cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file $TEMPLATE_FILE_NAME \
        --parameter-overrides file://$PARAMETERS_FILE_NAME \
        --region="eu-central-1"
fi
if [ $EXECUTION_MODE == "create" ]
then
aws cloudformation create-stack --stack-name $2 \
    --template-body file://$3   \
    --parameters file://$4  \
    --capabilities "CAPABILITY_NAMED_IAM"  \
    --region=eu-central-1
fi
if [ $EXECUTION_MODE == "update" ]
then
    aws cloudformation update-stack --stack-name $2  \
        --template-body file://$3   \
        --parameters file://$4 \
        --capabilities "CAPABILITY_NAMED_IAM"  \
        --region=eu-central-1

fi
if [ $EXECUTION_MODE == "delete" ]
then
    aws cloudformation delete-stack \
        --stack-name $STACK_NAME \
        --region="eu-central-1"
fi
if [ $EXECUTION_MODE == "preview" ]
then
    aws cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file $TEMPLATE_FILE_NAME \
        --parameter-overrides file://$PARAMETERS_FILE_NAME \
        --no-execute-changeset \
        --region="eu-central-1" 
fi
