# Shiftkey Coding Challenge

[![Code Analysis](https://github.com/lyzkov/shiftkey-coding-challenge/actions/workflows/codeql.yml/badge.svg)](https://github.com/lyzkov/shiftkey-coding-challenge/actions/workflows/codeql.yml)

## Introduction

This repository contains prototype framework that demonstrates usage of [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) along with layered data-driven design and modular feature-driven structure, empowered by Combine and SwiftUI native extensions to Apple Core Foundation.

## Motivation

The project utilizes solution to recruitment task from Shiftkey as a setup example for combining programming principles emerging from open source Swift community.

## Requirements

To build and run the project you need iOS SDK 14.3 or newer installed on your machine.

## Architecture

I have introduced custom layout for unidirectional data flow here. Each entity passes three phases from its source to the final destination.

At the beginning, raw data from web service is transformed to networking model in system space. The system space layer reflects untoched response from the backend.

At the midway, effective core model is reshaped according to the mobile domain that rules application space. The application space layer reflects unprecedented inset to the midend.

At the final, the view item is completed and ready to present in the user space. The user space layer reflects yet-to-be-rendered input demanded by the frontend.

## Networking

Networking service fetches entities from Shiftkey Web API. Shiftkey API client inherits most of its internal structure from prototype inspired by [RxStorm](https://github.com/lyzkov/RxStorm) library. 

Networking client invokes `NSURLSession` reactive extensions to wrap HTTP response with decoded JSON item inside `Load` enum:

```Swift
public typealias Load<Item, Fault: Error> = Status<Result<Item, Fault>>

public enum Status<Completed> {
    case pending(Fraction? = nil)
    case completed(Completed)

    public typealias Fraction = Float
}
```

Load publishers enable client to publish progress status in background while resource is busy fetching data from requested endpoint.

### For further investigation:
- Domain Specific Language descriptor transcribing from OpenAPI manifest to dev readable networking client spec tree
- Code generator for Raw Data model with endpoints
- Modular design following hierarchy of state reducers
- Command-driven, routable entry points triggering effects in reactors
- Generic stores for Load and Feed eventual contexts of receiving items from remote data source
- Error dedicated pipelines
