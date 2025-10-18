#!/bin/bash

eval $(ssh-agent -s)
ssh-add ./sshkeys/github/androidkey2
ssh -T git@github.com
