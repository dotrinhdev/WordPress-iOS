#!/bin/bash
bundle install
bundle exec pod install
if [ $? -eq 31 ]; then
    bundle exec pod install --repo-update
fi
