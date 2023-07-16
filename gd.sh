#!/bin/bash

REGIONS="us-gov-west-1"

## Disable GuardDuty Destination
# for REGION in ${REGIONS}; do 
#   DETECTOR=$(aws guardduty list-detectors --region ${REGION} --output text | awk '{print $2}')
#   DESTINATION=$(aws guardduty list-publishing-destinations --detector-id ${DETECTOR} --region ${REGION} --output text | awk '{print $2}')
#   aws guardduty delete-publishing-destination --detector-id ${DETECTOR} --destination-id ${DESTINATION} --region ${REGION}
# done

## Disable Config Delivery Channel and Recorder
for REGION in ${REGIONS}; do 
  echo "${REGION}"
  CHANNEL=$(aws configservice describe-delivery-channels --region ${REGION} --output text | grep DELIVERYCHANNELS | awk '{print $2}')
  RECORDER=$(aws configservice describe-configuration-recorders --region ${REGION} --output text | grep CONFIGURATIONRECORDERS | awk '{print $2}')
  aws configservice stop-configuration-recorder --configuration-recorder-name ${RECORDER} --region ${REGION}
  aws configservice delete-configuration-recorder --configuration-recorder-name ${RECORDER} --region ${REGION}
  aws configservice delete-delivery-channel --delivery-channel-name ${CHANNEL} --region ${REGION}
done
