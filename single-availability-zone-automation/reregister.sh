##
## =============================================================================
## IBM Confidential
## © Copyright IBM Corp. 2020
##
## The source code for this program is not published or otherwise divested of
## its trade secrets, irrespective of what has been deposited with the
## U.S. Copyright Office.
## =============================================================================
##
#
# Description: Reregister an RHEL virtual server instance to its respective capsule server
#

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

argumentsFound=false
FILE_DIR=/var/lib/cloud/instance/scripts/vendor
file=$(grep -src -r -w 'REDHAT_CAPSULE_SERVER\|OS_INSTALL_CODE' $FILE_DIR | awk -F: '$2 == 6 {print $1}')
echo "Processing $file..."
if [ -f  "$file" ]; then
    capsule="$(grep "REDHAT_CAPSULE_SERVER=" $file | cut -d\" -f2)"
    organization="$(grep "OS_REDHAT_ORG_NAME=" $file | cut -d\" -f2)"
    activationKey="$(grep "ACTIVATION_KEYS=" $file | cut -d\" -f2)"
    profileName="$(grep "PROFILENAME=" $file | cut -d\" -f2)"
    if [ ! -z "$capsule" ] && [ ! -z "$organization" ] && [ ! -z "activationKey" ] && [ ! -z "profileName" ]; then
        argumentsFound=true
    fi
fi

if [ "$argumentsFound" = false ]; then
    if [ -z "$4" ]; then
        echo Please provide capsule hostname, organization, activation key and profile name
        exit
    fi

    capsule="$(echo $1 | cut -d. -f1).adn.networklayer.com"
    organization=$2
    activationKey=$3
    profileName=$4
fi
echo "Cleaning metadata..."
yum clean all

echo "Unregistering system..."
subscription-manager unregister
subscription-manager clean

echo "Removing any existing katello-ca RPMs..."
rpm -qa | grep katello-ca | xargs rpm -e

echo "Installing consumer RPM..."
rpm -Uvh http://${capsule}/pub/katello-ca-consumer-latest.noarch.rpm

subscription-manager config --server.hostname=${capsule}
subscription-manager config --rhsm.baseurl=https://${capsule}/pulp/repos

if [ -f /etc/rhsm/facts/katello.facts ]; then
    mv /etc/rhsm/facts/katello.facts /etc/rhsm/facts/katello.facts.bak.$(date +%s)
fi
echo '{"network.hostname-override":"'${profileName}'"}' > /etc/rhsm/facts/katello.facts

echo "Registering system..."
subscription-manager register --org="${organization}" --activationkey="${activationKey}" --force