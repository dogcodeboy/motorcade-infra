# Known Issues / Why it felt impossible

1) **Vault autoload rules**
- Ansible autoloads `group_vars/` relative to inventory (and certain other places).
- A vault file placed elsewhere may not load, causing the LEADGEN_API_KEY assertion to fail.

2) **containers.podman module drift**
- The `containers.podman.podman_image` module has version-dependent parameters.
- Different hosts/collections produced “Unsupported parameters” failures.

3) **Non-standard Podman install**
- Podman is installed via a repo-specific static mechanism.
- `dnf install podman` fails on your target and should not be attempted.

4) **stdout callback yaml**
- The error `Invalid callback ... yaml` is almost always an environment variable forcing it.
- This checkpoint defaults to `stdout_callback=default` but cannot override your shell env var.

5) **Build context mismatch**
- Even once everything is correct, podman cannot build without a Dockerfile/Containerfile in the build directory.
