# Reusable prompt: Docker containerization

Copy-paste the block below into any AI coding agent to containerize an
application - a small, secure, working image, not a copy-pasted Dockerfile.

Keywords: docker, container, dockerfile, image, compose, build, reproducible builds

---

Create a Docker image for this application. The goal: a reproducible, small,
secure image that runs the app the way it's meant to run.

## Requirements

1. **Understand the app first** - Read how the app is built and run: language,
   runtime, build steps, entrypoint, required env vars, ports, and config.
   Read the README, manifests, and the actual code - don't guess the stack.
2. **Write a real Dockerfile** - Use multi-stage builds where the stack
   benefits (build stage for compiling/dependency-install, slim runtime stage
   without build tools and source). Prefer the official base images and pin
   versions. Cache-friendly ordering: dependency layers before source.
3. **Run as a non-root user** - Create and switch to an unprivileged user in
   the image unless the app genuinely needs root.
4. **Don't ship junk** - Add a `.dockerignore` (node_modules, .git, tests,
   build caches, secrets, `.env`). Never copy secrets or `.env` files into the
   image. Keep the image as small as reasonable - document any files you
   deliberately must include.
5. **Make it reproducible & runnable** - Set sensible `EXPOSE`, `ENV`,
   `WORKDIR`, `CMD`/`ENTRYPOINT`. Ensure healthcheck/readiness is possible
   where the app supports it. Container runs with required env vars provided
   externally (config, not baked in).
6. **Verify** - `docker build` it without warnings that matter, run it locally
   with the documented env, and confirm the app starts and responds. Check the
   image with a security scanner if available (e.g. `docker scout`,
   `trivy`). Fix anything real it flags.
7. **Document** - Update/extend the README with build and run instructions
   (`docker build`, `docker run`, required env vars, ports) if not already
   present.

## Rules

- Never use `latest` tags for base images in a Dockerfile meant for
  production/reproducible builds.
- Never install package managers or compilers in the runtime stage just for
  convenience.
- Never commit secrets, private keys, or `.env` files to the image or the repo.
- If the app is hard to containerize cleanly (stateful, needs host services),
  stop and flag it rather than hacking around it.
