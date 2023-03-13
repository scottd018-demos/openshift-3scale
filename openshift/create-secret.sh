#!/usr/bin/env sh

: ${S3_ACCESS_KEY_ID?missing required environment variable AWS_ACCESS_KEY_ID}
: ${S3_SECRET_ACCESS_KEY?missing required environment variable AWS_SECRET_ACCESS_KEY}
: ${S3_BUCKET_REGION?missing required environment variable S3_BUCKET_REGION}
: ${S3_BUCKET_NAME?missing required environment variable S3_BUCKET_NAME}

cat << EOF | oc apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: aws-auth
  namespace: 3scale-demo
stringData:
  AWS_ACCESS_KEY_ID: "$S3_ACCESS_KEY_ID"
  AWS_SECRET_ACCESS_KEY: "$S3_SECRET_ACCESS_KEY"
  AWS_BUCKET: "$S3_BUCKET_NAME"
  AWS_REGION: "$S3_BUCKET_REGION"
type: Opaque
EOF
