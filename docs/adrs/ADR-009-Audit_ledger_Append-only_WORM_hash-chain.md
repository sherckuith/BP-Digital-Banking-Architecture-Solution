# ADR-009: Audit ledger append-only + WORM + hash-chain

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
Audit ledger append-only + WORM + hash-chain

## Consequences
1. Detecta cualquier alteración mediante verificación de cadena de hashes.
2. WORM en S3 Glacier cumple con requisitos de retención de 7 años (PCI-DSS, CNBV).
