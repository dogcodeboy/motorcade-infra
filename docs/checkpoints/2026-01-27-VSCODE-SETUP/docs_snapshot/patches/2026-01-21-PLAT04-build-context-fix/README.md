# PLAT_04 Build Context Fix

## Symptom
Podman image build fails with:
  Error: context must be a directory

## Cause
`containers.podman.podman_image` requires an explicit build context.

## Fix
Adds:
  build.context: /opt/motorcade/motorcade-leadgen

No other behavior changed.
