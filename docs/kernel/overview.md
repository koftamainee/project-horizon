# Kernel

## Overview

The Kernel is the core of Project Horizon — a Go API built as a modular monolith. It handles all CRUD operations, business logic, and serves as the central coordination point for the system.
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

## Database

### PostgreSQL

Primary data store for all business data.
Each kernel module has its own schema. Check module docs for more info

### Tigerbeetle

Financial database for ledger operations. Not part of MVP.

## Configuration

TODO: 
