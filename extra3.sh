#!/bin/bash

systemctl enable tor
sysctl kernel.unprivileged_userns_clone=1
echo kernel.unprivileged_userns_clone = 1 | tee /etc/sysctl.d/00-local-userns.conf
