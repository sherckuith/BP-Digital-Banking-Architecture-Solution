# Índice de Diagramas Mermaid (C4 Model)

A continuación se listan los archivos fuente en formato Mermaid (`.mmd`) que definen la arquitectura C4 del proyecto.
Las rutas son relativas al directorio principal del repositorio.

## Nivel 1: Contexto
*   [diagrams/context/c4-context.mmd](diagrams/context/c4-context.mmd) - Diagrama de Contexto del Sistema

## Nivel 2: Contenedores
*   [diagrams/containers/c4-containers-v2.drawio.mmd](diagrams/containers/c4-containers-v2.drawio.mmd) - Diagrama de Contenedores (V2 - Arquitectura Actual)
*   [diagrams/containers/c4-containers.mmd](diagrams/containers/c4-containers.mmd) - Diagrama de Contenedores (Versión Anterior)

## Nivel 3: Componentes
*   [diagrams/components/c4-components-customer_service.mmd](diagrams/components/c4-components-customer_service.mmd) - Customer Service (Dual Source)
*   [diagrams/components/c4-components-transaction.mmd](diagrams/components/c4-components-transaction.mmd) - Transaction Service (Saga + Outbox)
*   [diagrams/components/c4-components-onboarding.mmd](diagrams/components/c4-components-onboarding.mmd) - Onboarding Service (IAL2 Biometry)
*   [diagrams/components/c4-components-audit-notify.mmd](diagrams/components/c4-components-audit-notify.mmd) - Audit & Notification Services

## Nivel 4: Despliegue
*   [diagrams/deployment/c4-deployment-aws.mmd](diagrams/deployment/c4-deployment-aws.mmd) - Infraestructura AWS Multi-Región

## Diagramas de Secuencia
*   [diagrams/components/sequence-transfer.mmd](diagrams/components/sequence-transfer.mmd) - Flujo de Transferencia (Outbox)
*   [diagrams/components/sequence-onboarding.mmd](diagrams/components/sequence-onboarding.mmd) - Flujo de Onboarding (Biometría)
