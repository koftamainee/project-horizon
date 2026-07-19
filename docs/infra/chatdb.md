# ScyllaDB

## Overview

ScyllaDB is the database for the Chat satellite. It stores chat message history independently from the primary PostgreSQL database.

## Used By

- **Chat satellite** — read/write for chat messages

## Why ScyllaDB

- High write throughput for chat messages
- Low latency reads for message history
- Horizontally scalable
- Cassandra-compatible, but doesn't require voodoo magic with JVM

## What It Stores

TODO: describe exact structure