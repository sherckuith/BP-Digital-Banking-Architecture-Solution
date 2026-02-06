# BP Digital Banking Architecture Solution

**Arquitectura de Banca Digital para Banco BP**

Este repositorio contiene el diseño de arquitectura de soluciones para el ecosistema de Banca por Internet de Banco BP. El diseño sigue el modelo **C4 (Context, Containers, Components, Code)** y se adhiere a las mejores prácticas de gobernanza, seguridad (Zero-Trust) y cumplimiento normativo (LOPDP, CNBV, PCI-DSS).

> **Estado del Proyecto:** 🚧 **En Progreso (80% Completado)**
>
> Actualmente, la estructura del repositorio, los diagramas arquitectónicos y la definición de decisiones clave (ADRs) están completos. Se está trabajando en el detalle fino de la implementación de referencia y las configuraciones finales de infraestructura.

## 📋 Resumen Ejecutivo/Executive Summary

La solución propone una arquitectura basada en **Microservicios (DDD)** y **Event-Driven Architecture (EDA)**, diseñada para soportar:

*   **Escalabilidad:** Hasta 200,000 TPS en pico.
*   **Alta Disponibilidad:** 99.99% (Multi-AZ + Multi-Region Warm Standby).
*   **Seguridad:** Flujos FAPI 2.0, DPoP, y validación biométrica IAL2.
*   **Cumplimiento:** Auditoría inmutable (WORM) y trazabilidad completa.

## 🗂 Estructura del Repositorio

La organización del código y la documentación sigue un estándar riguroso:

```text
online-banking-architecture/
├── diagrams/                  # Modelos Visuales (C4 Model)
│   ├── context/               # Nivel 1: Diagramas de Contexto
│   ├── containers/            # Nivel 2: Diagramas de Contenedores
│   ├── components/            # Nivel 3: Diagramas de Componentes
│   └── deployment/            # Nivel 4: Infraestructura AWS
│
├── docs/                      # Documentación Técnica y de Procesos
│   ├── adrs/                  # Architecture Decision Records (18 Decisiones Clave)
│   ├── compliance/            # Normativas (LOPDP, PCI-DSS)
│   └── observability/         # Estrategia de OpenTelemetry
│
├── services/                  # Definición de Microservicios (Bounded Contexts)
│   ├── transaction/           # Core transaccional (Saga + Outbox)
│   ├── onboarding/            # Alta digital biométrica
│   ├── audit/                 # Ledger inmutable
│   └── ...
│
├── bff/                       # Backend For Frontend (BFF)
│   ├── web/                   # BFF para SPA (React)
│   └── mobile/                # BFF para App Móvil (Flutter)
│
└── infra/                     # Infraestructura como Código (IaC)
    └── terraform/             # Scripts de despliegue AWS
```

## 🛠 Stack Tecnológico de Referencia

*   **Frontend:** React (Web), Flutter (Mobile).
*   **Backend:** Java (Spring Boot), Go (Audit/Onboarding), Node.js (BFF).
*   **Data & Events:** Aurora PostgreSQL (Global), DynamoDB, Kafka (MSK), Redis.
*   **Infraestructura:** AWS (EKS, Lambda, Outposts) + Terraform.

## 📖 Cómo navegar este repositorio

1.  Comience por **[Summary.md](./Summary.md)** para una visión general de las métricas y objetivos.
2.  Revise **[Arquitectura_de_Banca_por_Internet_BP.md](./Arquitectura_de_Banca_por_Internet_BP.md)** para el documento maestro de diseño.
3.  Consulte los **[ADRs](./docs/adrs/README.md)** para entender las justificaciones detrás de cada decisión técnica.
4.  Explore los diagramas visuales en **[diagrams/](./diagrams/README.md)**.

---
**Autor:** Angel David Yaguana Hernandez
**Rol:** Lead Solutions Architect
