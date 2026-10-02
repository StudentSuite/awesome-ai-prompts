# Reusable prompt: Docker containerization

Copy-paste the block below into any AI coding agent to containerize an
application - a small, secure, working image, not a copy-pasted Dockerfile.

Keywords: docker, container, dockerfile, image, compose, build, reproducible builds

---

Create a Docker image for this application. The goal: a reproducible, small,
secure image that runs the app the way it's meant to run.

## Steps

1. **Understand the app first** - Language, runtime, build steps, entrypoint,
   required env vars, ports, and config. Read the README, manifests, and the
   actual code - don't guess the stack.
2. **Write a real Dockerfile** - Multi-stage where the stack benefits: a build
   stage for compiling and installing dependencies, a slim runtime stage with
   no build tools or source. Prefer official base images, pinned by version.
   Order dependency layers before source for caching.
3. **Harden the image** - Run as a non-root user unless the app genuinely
   needs root. Add a `.dockerignore` (node_modules, .git, tests, build
   caches, secrets, `.env`); never copy secrets or `.env` into the image.
   Document any file you deliberately must include.
4. **Make it reproducible and runnable** - Set `EXPOSE`, `ENV`, `WORKDIR`,
   `CMD`/`ENTRYPOINT`. Support a healthcheck or readiness probe where the app
   allows. Required env vars come in from outside, not baked in.
5. **Verify and document** - `docker build` with no meaningful warnings, run
   it locally with the documented env, and confirm the app starts and
   responds. Scan the image (`docker scout`, `trivy`) and fix what it flags.
   Add `docker build`, `docker run`, and the required env vars to the README.

## Verification

- [ ] The build uses multi-stage construction where the stack allows, and the
      runtime stage carries no compiler or package manager.
- [ ] The container runs as a non-root user, and no base image uses the
      `latest` tag.
- [ ] A `.dockerignore` keeps dependencies, VCS data, tests, and local env
      files out of the image.
- [ ] `docker build` completes without meaningful warnings, and the image was
      run locally and exercised.
- [ ] The README's build and run instructions were followed literally and
      worked.
- [ ] No secret, private key, or `.env` file is present in the image or the
      repo.

## Rules

- Never use `latest` tags for base images in a Dockerfile meant for
  production/reproducible builds.
- Never install package managers or compilers in the runtime stage just for
  convenience.
- Never commit secrets, private keys, or `.env` files to the image or the repo.
- If the app is hard to containerize cleanly (stateful, needs host services),
  stop and flag it rather than hacking around it.
