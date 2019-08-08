#!/bin/bash
#
#
# wrapper script to run EviDENce doc2vec docker services
#
# INPUTS:
# $1 :: config template (e.g. model_config_template.conf)
#


#source the config file
source $1

#setup environment variables and a perpetuated environment file
TAG_NAME=${CORPUS_NAME}_${MODEL_NAME}

ENVIRONMENTFILE=${TAG_NAME}.env

touch ${ENVIRONMENTFILE}
echo "TAG=${TAG_NAME}" >> ${ENVIRONMENTFILE}
echo "CORPUSNAME=${CORPUS_NAME}" >> ${ENVIRONMENTFILE}
echo "MODELNAME=${MODEL_NAME}" >> ${ENVIRONMENTFILE}
echo "INPUTPATH=${INPUT_PATH}" >> ${ENVIRONMENTFILE}
echo "CODEPATH=${CODE_PATH}" >> ${ENVIRONMENTFILE}
echo "DERIVEDPATH=${DERIVED_PATH}" >> ${ENVIRONMENTFILE}

#copy the environment file to the .env file used by docker-compose
cp ${ENVIRONMENTFILE} .env

#run docker compose using the .env file and TAG_NAMe as unique project name
docker-compose --project-name ${TAG_NAME} up -d

docker-compose --project-name ${TAG_NAME} logs | tail -100 > ${TAG_NAME}_logs.txt