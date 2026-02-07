# Changelog

## [Unreleased]

### Added
- **Structurizr DSL Model**: Se ha creado el archivo `diagrams/structurizr/workspace.dsl` para modelar formalmente la arquitectura.
    - **Nivel 1 (Contexto)**: Definición de actores (Clientes, Reguladores) y sistemas externos (Core, IdP, Fraude).
    - **Nivel 2 (Contenedores)**: Mapeo completo de microservicios, BFFs, Gateway y capas de datos (Aurora, MSK, Redis).
    - **Nivel 3 (Componentes)**: Detalle granular para *Transaction Service* (Saga, Outbox), *Onboarding* (Biometría), *Audit* (Ledger Inmutable) y *Notification*.
    - **Nivel 4 (Despliegue)**: Representación de infraestructura AWS Multi-Región y conexión On-Premise.
- **Cumplimiento de Test**: El modelo refleja estrictamente los requisitos de `test_instructions.md` (e.g., FAPI 2.0, Zero-Trust, HA, WORM).
