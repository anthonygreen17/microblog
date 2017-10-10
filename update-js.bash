#! /usr/bin/env bash

(cd assets && node node_modules/brunch/bin/brunch build)
mix phx.digest
