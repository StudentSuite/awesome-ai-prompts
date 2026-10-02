# Reusable prompt: Kubernetes deployment

Copy-paste the block below into any AI coding agent to deploy to Kubernetes
securely: real health probes, zero-downtime rollouts, non-root pods, and
bounded resources.

Keywords: kubernetes, k8s, pod, helm, manifest, rollout, ingress

---

Deploy this application to Kubernetes properly. The bar: pods pass real
health checks, rollouts don't drop requests, nothing runs as root, and
resource usage is bounded and visible.

## Steps

1. **Confirm the image is deployable** - Small, non-root, no floating
   `latest` tag, configuration via env/files rather than rebuilds. If the
   Dockerfile needs fixing, fix it first.
2. **Write manifests the declarative way** - Deployments (not bare pods),
   ConfigMaps/Secrets for config, Services, Ingress or HTTPRoute. Prefer
   Kustomize overlays per environment over copy-pasted YAML. Resource
   requests should match observed usage; limits prevent noisy neighbors.
3. **Health probes that mean something** - Liveness = process healthy (cheap,
   never depends on other services); readiness = able to serve (checks what
   actually matters); startupProbe for slow boots. A probe hitting `/` of a
   SPA is not a health check.
4. **Zero-downtime rollout** - Tune maxUnavailable/maxSurge; handle SIGTERM
   (or a preStop delay) so connections drain; set
   terminationGracePeriodSeconds long enough for in-flight work; gate on
   readiness during startup. Verify by watching error rates during a rollout.
5. **Lock down and observe** - securityContext (non-root, read-only rootfs,
   dropped capabilities), NetworkPolicies where the cluster enforces them,
   secrets from a secret manager rather than committed YAML, autoscaling
   based on real metrics, PodDisruptionBudget for availability tiers.
6. **Verify end-to-end** - Apply to a staging namespace, run smoke tests
   against the service, kill a pod under traffic and show zero failed
   requests, then tear down cleanly.

## Rules

- No `latest` tags and no root containers.
- Every manifest change must be applied and verified - YAML that was never
  applied is fiction.
- If the cluster lacks a feature (e.g., NetworkPolicy enforcement), say so
  rather than pretending the YAML protects anything.
