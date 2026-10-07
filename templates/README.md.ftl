<#-- Validar los datos que necesita el título -->
<#if !specificConfig??>
  <#stop "Falta el objeto obligatorio: specificConfig">
</#if>

<#assign requiredFields = [
  "BBDD_ENGINE",
  "BBDD_NAME",
  "ENV"
]>

<#list requiredFields as field>
  <#if !specificConfig[field]?? || !specificConfig[field]?has_content>
    <#stop "Falta el parámetro obligatorio: specificConfig." + field>
  </#if>
</#list>

<#-- Construir título automáticamente -->
<#assign dbEngine = specificConfig.BBDD_ENGINE?upper_case>
<#assign databaseName = specificConfig.BBDD_NAME?upper_case>
<#assign environment = specificConfig.ENV?upper_case>

# ${dbEngine} - ${databaseName} - ${environment}

## 🖥️ Descripción

Este proyecto fue generado usando ArqRef (Reference Architecture MAPFRE), puedes encontrar documentación y ayuda en [Marketplace MAPFRE](https://www.marketplace.mapfre.com).

Este repositorio gestiona la generación dinámica de los ficheros de configuración del componente mediante plantillas **FreeMarker** (`.ftl`). Permite parametrizar las conexiones de entrada, origen de datos y destino (como clusters de Kafka) según las variables inyectadas por la plataforma MAPFRE.

## 📁 Estructura del proyecto
  

```
├── .github
│   └── workflows
│       ├── merge-commit.yml
│       └── pull-request.yml
├── configuracion
│   ├── application
│   │   └── cdc_input_json_content.json.ftl
│   ├── db-connections
│   │   └── db-connections-${dbEngine}.yml.ftl
│   └── target-connections
│       └── kafka.yml.ftl
├── CHANGELOG.md
├── CONTRIBUTING.md
├── project-manifest.json.ftl
├── security-metadata.toml.ftl
└── README.md.ftl
```
- `.github/workflows/merge-commit.yml`: Workflow de GitHub para el proceso de integración continua (CI), genera y publica el artefacto de la base de datos relacional.
- `.github/workflows/pull-request.yml`: Workflow de GitHub para el proceso de integración continua (Build, Test, Sonar) cuando se crea o actualiza un Pull Request.
- `README.md`: Este archivo.
```

```
.github/workflows/merge-commit.yml
Este workflow se ejecuta en cada push a la rama principal. Valida una estructura mínima, genera un ZIP del contenido relevante de la base de datos y lo publica como artefacto descargable.

.github/workflows/pull-request.yml
Este workflow se dispara al abrir, actualizar, reabrir o sincronizar un Pull Request. Está diseñado con pasos de Build, Test y Sonar, pero deja vacías las integraciones específicas del proyecto hasta que se definan comandos reales, credenciales y el servidor de SonarQube.
```
Flujo de CI 
