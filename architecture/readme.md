# Architecture Overview

This folder contains architectural diagrams that describe the end-to-end
Azure data engineering pipeline implemented in this project.

## Diagrams Included

### 1. End-to-End Architecture
- Shows data flow from source systems to analytics consumption
- Highlights Azure services used at each stage
- Demonstrates the medallion architecture (Bronze, Silver, Gold)

File:
- `architecture.png`

### 2. Star Schema Design
- Visual representation of the curated analytics data model
- Fact tables at the center with surrounding dimension tables
- Optimized for BI and analytical queries

File:
- `star_schema.png`
