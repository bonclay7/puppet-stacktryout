#!/bin/bash

IMG_DIR='/tmp/images'
OPENSTACK_USER='admin'

#### checking keystone creds
if [ "$OS_TENANT_NAME" != "$OPENSTACK_USER" ]; then
  echo "ERROR : we cannot continue, you need to log to keystone as admin "
  echo "example : source ./keystone-admin.sh"
  exit -1
fi

#### add Ubuntu cloud images to glance
echo "** Downloading trusty cloud image..."
wget -P $IMG_DIR http://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg-amd64-disk1.img

#### Create a router for instances and allow floating network or something like that
echo "** Adding trusty to glance"
glance image-create --name "trusty-server-cloudimg-amd64" --file "$IMG_DIR/trusty-server-cloudimg-amd64-disk1.img" --disk-format qcow2 --container-format bare --is-public True --progress

### escape if there is an error
if [ "$?" != "0" ]; then
  echo "ERROR: An error occurred"
  exit -1
fi