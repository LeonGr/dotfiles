#!/bin/bash

# from: https://gist.github.com/fatihkaan22/0cad6b53647c5d887c67b22c260568cb?permalink_comment_id=4408813#gistcomment-4408813
pw-dump \
  | jq '.[] | select(.type == "PipeWire:Interface:Client" and .info.props."application.name" == "spotify") | .id' \
  | head -n-1 \
  | xargs --no-run-if-empty -n1 pw-cli destroy
