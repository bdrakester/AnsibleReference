#!/bin/bash

ansible-playbook master.yml -i inventory.ini -u centos --private-key ../id_centos

#ansible-playbook master.yml -i inventory.ini -u centos --private-key ../id_centos --tags=simple

#ansible-playbook master.yml -i inventory.ini -u centos --private-key ../id_centos --skip-tags=simple