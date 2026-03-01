#!/bin/bash

set -euo pipefail

ln -sf $(pwd)/hooks/* ../.git/hooks/

