# Kernel

## Overview

The Kernel is the core of Project Horizon — a Go API built as a modular monolith. It handles all CRUD operations, business logic, and serves as the central coordination point for the system.

## Language - **Go**
Go is already in stack for satellites and domain logic is simple enough to not bring heavy backend frameworks like Spring Boot or ASP.NET. Also, I don't want to introduce new runtime platform (JVM/.NET), it will be new building step, new CI/CD pipeline, etc.

## Modules

### Auth

Handles user authentication and authorization.

- Registration and login
- Token generation and validation
- Password hashing and verification
- Session management

### Profile

Manages user profiles and account data.

- Profile CRUD
- Account settings and preferences
- User search and discovery

### Stream

Manages stream metadata and lifecycle state.

- Stream metadata CRUD
- Stream status tracking

### Follow

Manages follower/subscriber relationships and access control.

- Follow/unfollow users

### VOD

Manages Video-On-Demand records and post-stream assembly.

- Decide whether to create VOD based on user preferences
- Track VOD lifecycle
- Store VOD metadata

## Database

### PostgreSQL

Primary data store for all business data.
Each kernel module has its own schema. Check module docs for more info

### Tigerbeetle

Financial database for ledger operations. Not part of MVP.

