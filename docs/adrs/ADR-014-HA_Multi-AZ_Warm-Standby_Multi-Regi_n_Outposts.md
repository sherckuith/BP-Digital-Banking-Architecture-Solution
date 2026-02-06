# ADR-014: HA multi-AZ + DR warm-standby multi-región

## Status
Accepted

## Context
[Contexto del problema arquitectónico que se resuelve con esta decisión]

## Decision
HA multi-AZ + DR warm-standby multi-región

## Consequences
1. RTO < 5 min y RPO ~ 0 s gracias a Aurora Global, DynamoDB Global Tables y Global Accelerator.
2. Cost-balance: warm-standby reduce coste frente a un full active-active.
