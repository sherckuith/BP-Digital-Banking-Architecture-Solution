# ADR-015: Secret management con KMS/KeyVault

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Secret management con KMS/KeyVault

## Consequences
1. Almacena secretos bajo AES-256-GCM y rota automáticamente.
2. Auditable: CloudTrail registra cada acceso, cumpliendo con PCI-DSS 3.2 y LOPDP.
