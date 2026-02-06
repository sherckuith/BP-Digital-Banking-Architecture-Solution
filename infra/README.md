# Infraestructura como Código (IaC)

Este directorio contiene las definiciones de infraestructura para desplegar la solución en AWS.

## Estrategia de Despliegue

La infraestructura sigue un modelo **Multi-Región Activo/Pasivo (Warm Standby)** con capacidad de failover a un entorno On-Premise (Outposts).

### Componentes Principales

*   **terraform/**: Scripts de Terraform para el aprovisionamiento de recursos.
*   **VPC**: Red privada virtual segmentada en subredes públicas (ALB), privadas de aplicación (EKS) y privadas de datos (Aurora, MSK).
*   **EKS**: Amazon Elastic Kubernetes Service para la orquestación de contenedores.
*   **Aurora Global DB**: Base de datos relacional distribuida globalmente para RPO cercano a cero.
*   **MSK**: Amazon Managed Streaming for Apache Kafka.

## Directorios

*   `terraform/`: Código fuente HCL.
