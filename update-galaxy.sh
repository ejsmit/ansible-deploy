#!/usr/bin/env bash

rm -r ansible_collections/*
rm -r ansible_roles/*

ansible-galaxy role install -r requirements.yml
ansible-galaxy collection install -r requirements.yml
