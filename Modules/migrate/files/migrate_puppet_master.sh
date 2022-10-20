#!/bin/bash

# Export the path to include /opt/puppetlabs/bin as an ubuntu machne may have puppet
# in here or /usr/sbin depending on the version of puppet.

export PATH=$PATH:/opt/puppetlabs/bin

os=`lsb_release -c |awk '{print $2}'`
#Ubuntu: precise, trusty, xenial, bionic
#Debian: wheezy, jessie

DATE=`date "+%Y%m%d-%H%M%S"`

# Get the puppet version
puppetversion=`puppet --version |awk -F. '{print $1'}`

# Puppet 4 needs to land on the legacy system to see if it can be upgraded
if [ $puppetversion == "4" ]; then
  echo "Puppet v4"
  puppetserver="puppet-legacy.support.toolstation.com"
fi

# Puppet 5 can move directly to new
if [ $puppetversion == "5" ]; then
  echo "Puppet v5"
  puppetserver="puppet.support.toolstation.com"
  puppetproxy="puppet-proxy.support.toolstation.com"
fi

# Test if servers can be reached, if not, no point in going on.
nc -w1 $puppetserver 8140
if [ $? == '1' ]; then
  echo "Can not connect to new puppet server"
  exit 1
fi

# Get the location of the config file
config=`puppet config print config`

grep -q ${puppetserver} ${config}
if [ $? == '0' ]; then
  echo "Done, so skipping migration"
  exit 2
else
  if [ $puppetversion == '4' ]; then
    echo "Migrating to Legacy System.."
    puppet config set server $puppetserver --section agent
    mv /etc/puppetlabs/puppet/ssl /etc/puppetlabs/puppet/ssl.$DATE
    puppet agent -t
  else
    if [ $puppetversion == '5' ]; then
      echo "Migrating to Skynet.."
      puppet config set server $puppetproxy --section agent
      puppet config set ca_server $puppetserver --section agent
      puppet config set --section main certificate_revocation leaf
      mv /etc/puppetlabs/puppet/ssl /etc/puppetlabs/puppet/ssl.$DATE
      mkdir -m 0775 /etc/puppetlabs/puppet/ssl
      mkdir -m 0755 /etc/puppetlabs/puppet/ssl/certs
      cat <<EOF >/etc/puppetlabs/puppet/ssl/certs/ca.pem
-----BEGIN CERTIFICATE-----
MIIFeDCCA2CgAwIBAgIBAjANBgkqhkiG9w0BAQsFADApMScwJQYDVQQDDB5QdXBw
ZXQgUm9vdCBDQTogNTFjMjQzNWM1ZWJjYzEwHhcNMjExMjA4MTAyNTU3WhcNMzYx
MjA1MTAyNTU4WjA8MTowOAYDVQQDDDFQdXBwZXQgQ0E6IHB1cHBldC1wcmltYXJ5
LnN1cHBvcnQudG9vbHN0YXRpb24uY29tMIICIjANBgkqhkiG9w0BAQEFAAOCAg8A
MIICCgKCAgEAscvn2N4m4SJBH/zoCU1oNNvKxu4yhwy2IpNgsCok187TMKpGPjma
7z2LveB1VdKbKNjjM7i5qB6KAEtsbYw8mvbIEQYN3jjRfVAMrPfg60Jor7XiiqIY
toNBT7K9wmipjqYlXJflvK0eKNKg/rh2eLBOk6Yqppee9rH14uObNucPQ0hxbVjN
crS9b03HJly5/H81E4mmfgffkOEJ+/lektWZuIR66hxvo8qiZuSPEFVkuGf+X/ct
t6HW8Hmj6XyP8VrY/aYs9LQHgDzu889wjo297QPVz84XjViq7heSkw3YgaoPa6ZF
BIRhJH0jqrq03GfJC7tslBQOvU2I99JuvEnZQtLIE9S5ErOcGInFDuVl/Tl2NHAk
d+NoL+dxhxS898q8edHgPbG0SyDiR2xgtKBZjvsMEQLucm7YWngFkjt7I0dySbP0
PZDVFboIdz4IUcy3yQVAjKZVQMRdNBIe8FhGMfce4B0gdCzBA3kSqIm6RHNCKcE6
0yKlM4FTna5JSNUzoPmDp4JQgyLdv+EZIs3NHLCQE07wFQCSUVw4247kxJzEYbMh
lERzhIA9sRWWhqBMCdi1D4oKUX+KnJVENKS5ZTVeNNax6h9K9u1wOKdYqwoBjiuh
d2+eL9gWmdvd+1t+3Otajt6tTdJrppmvaVkH0bB7Gu70L/ds6sS+gdcCAwEAAaOB
lzCBlDAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQU
gPD1y59uroXqpXPiq3wNOjMK+egwMQYJYIZIAYb4QgENBCQWIlB1cHBldCBTZXJ2
ZXIgSW50ZXJuYWwgQ2VydGlmaWNhdGUwHwYDVR0jBBgwFoAUwJVZMCs6IwCyKeaZ
Sg5xy6G1LRYwDQYJKoZIhvcNAQELBQADggIBAE4KogyCR0xTWeZUeCiSSfceZGrM
fhABQ5acx+HfSCe8qACAxXplYBLay3mkiT4eEo9vqVqR46j3Imb9DDOWpbWQkMGT
7koAQKiO81+p5U7y9xO5poecfghyYmWU2RM1K8+CcnTJ53hh+MPc9YSNa52ipxzc
q+mY2VgtgARTaejfiY4N1jhshFp6i8AfoD3GDunwCY6PU/nLjOs4+ogquWX2dKQv
s99TRW93sIwq/PAM+v3GmAelJ/1VR5N+AITrakz+qUh8ZqPfYn/shgx1jlELGsdp
hyEx8cqP/ZNJr6R37OX0/NpDRsG2vdmhW4Ff4Vv+DWPA6LHEQVvdOkHpXzZEFC5R
lkv4b6dvnuUHMkNzIqSWmd5DQMbVtaw3A8VYcl3FiBcKu6mC3KZWwlPMncC0lRV+
ojfURhygNy8Z1V5A6DwbEPMq372HZuaDf4w/xB0hUKGqj2k+Rmfenwc9T3Z85ckJ
Vnbi+PDGa3np8+TGkjeP7Hy8RBetFc5z6LexNWuqeUa/yWU64+A/G6zFsKeqK1lE
stXq7Ax7FwpFdrJMwmAAzUSn6l2Xj8JSGUCIOscv5oXWJF5v2/PQUzvWQ1YXiP1f
sejOXkDnrz0ega5sd5xCp1EmqBmUZ/jdVWfCIiuuPF5uUBAbk/sspoIwxYxGDFxO
T2HfU9hHVW/mmNPn
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIFZTCCA02gAwIBAgIBATANBgkqhkiG9w0BAQsFADApMScwJQYDVQQDDB5QdXBw
ZXQgUm9vdCBDQTogNTFjMjQzNWM1ZWJjYzEwHhcNMjExMjA4MTAyNTU3WhcNMzYx
MjA1MTAyNTU3WjApMScwJQYDVQQDDB5QdXBwZXQgUm9vdCBDQTogNTFjMjQzNWM1
ZWJjYzEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC6kPAVU/3oCXXL
CiCMpUZBbERJsOCkXsy+2griVuql5Z2wRBBRmx4FdCpUk97P88sO3CwQhX3N6TPS
z42gNEPpS460OoPrAvoR4bchdjNeCizMcDFNtngV7tfXsZU34TYX3ACa93vCRKLN
i7GlLDLp1SfZH2sGRrh1U/fD0uWkNZ/AiuyA8W3heErvvO6+jYLReIv9QksI/FQU
f9qsY1mwSLdz2F4w5mCB0ftyPpDI/U5OpfQKmsF2QEGsM/u8mFXmiwqefEGJRq75
p9ONIiuGoIs8xczJ6wtovu0b0ohTLJ8UUogEX+Xxl1cz7HNbeZMJJXg6nsMEVzb4
3LIqW89J2nTkrAoFGdPgZjQ0KJWILlRfQdyqYi5dRi7GLFkO86oZhpGU4k5EVkXD
z/XWEb7/9qqtTokNQA33O9exWgClowtoAopvcTlQy+Ys9GtbA9GxoG4V8+JZPlog
SvxS2ZGpO7BZoQg+YsioaPKuHD3H5WLwoItUX5abnV+n9G+DZoL4MqvBh8syZJk+
7ZbsupcROHG1mROC57eoyh9u/I2fFXLFyNQx+MwhlR+r14bq+qlp1xHHpKygEHra
kcyjtCRmQva9bBT1wbxuiRv/d222TPQZG1TLNhDN0wJVV0n/7wYkn7b1KyzwzeJU
Pcq6IN5FxzAEjrzFOVbwaRDm2PmO3QIDAQABo4GXMIGUMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBTAlVkwKzojALIp5plKDnHLobUt
FjAxBglghkgBhvhCAQ0EJBYiUHVwcGV0IFNlcnZlciBJbnRlcm5hbCBDZXJ0aWZp
Y2F0ZTAfBgNVHSMEGDAWgBTAlVkwKzojALIp5plKDnHLobUtFjANBgkqhkiG9w0B
AQsFAAOCAgEAabc19IkRNaAvMb2JGeViKGimvEkxByOYclRKGwAnKks0JgLXS9tK
4N3AKMXvYWBCTrTnLpVbQeZ3UAOEt/wfv+IMsxKummnG4TXOIuilj+cX0odSMFyE
+hBdsnai/bssx39U2twqMbK4Z017iw+FyYQOauOS9KLG1M/KO12W8fASoiABksGw
Jk4PC+e8LllRv16M/zMPYmlWS9K4Yetukawlpe3FAq9i8dbpZzyk73trI46KjDPV
X6bP90kMg09tqj6zab7aBeckAKNGozR4gfjEnP+zw1PoaNHSzsFhzl3FQNqAxQYu
ru515VIE/AsUHaXA+ksmC1SLWlxDL6YG8uLwKb5f4pA5B7rMzOoMIszlJ+6+W0sV
VakaV1DQZ502dRBJu722J6NOsg0Jt6kuOiWMSySmsSzVp32frAGrqNIVzgizmSsQ
9bJmHVzXLPd1JC/kcXYwyDKy9StmrhLZ1zSRBhe+U8vgWWTrCDZG6XYLIz5jgGb3
+93a/NNQGSVYi9QxfFMX0PtQnu2+GIghGhKCUiEjW7Wunthk5sgE4L8U/Zy9ygLi
Xs7a2KVfKYRkkZ9bnqHY9SguBS/LL6NqYV4RXHmWl8Xc98qHwFqyj8DhorC7ekrY
oPVD3kqnJzOVpXREaEC5B3gio97ZQmi7oC1+euneiMy0BbWf+1skN44=
-----END CERTIFICATE-----
EOF

      puppet agent -t
    fi
  fi
fi
