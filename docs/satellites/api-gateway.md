# API Gateway

## Overview

The API Gateway is the single entry point for all client traffic into the cluster. It sits between the frontend and backend services (Kernel, Chat Satellite), handling routing, SSL termination, rate limiting, and request validation.

## Stack

- **Software:** Nginx

## Responsibilities

- Route HTTP requests to Kernel
- Proxy WebSocket connections to Chat Satellite
- SSL/TLS termination
- Rate limiting and request throttling
- Request logging and basic metrics

## Routing

| Path prefix      | Upstream        | Notes                 |
|------------------|-----------------|-----------------------|
| `/api/*`         | Kernel          | REST API              |
| `/ws`            | Chat Satellite  | WebSocket upgrade     |

## Why Nginx

- Battle-tested reverse proxy, same stack as Video Gateway
- Excellent WebSocket proxying support
- Built-in rate limiting, SSL termination, access logging
- Low resource usage, high concurrency
- Simple configuration, easy to replace with Envoy or cloud LB later
