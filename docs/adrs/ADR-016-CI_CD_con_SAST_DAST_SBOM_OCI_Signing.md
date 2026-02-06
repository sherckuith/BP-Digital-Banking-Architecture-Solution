# ADR-016: CI/CD con SAST/DAST/SBOM + firmas OCI

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
CI/CD con SAST/DAST/SBOM + firmas OCI

## Consequences
1. Detecta vulnerabilidades en stage (pre-prod) reduciendo surface-of-attack.
2. SBOM + Cosign garantizan integridad del artefacto en producción (Supply-Chain Security).
