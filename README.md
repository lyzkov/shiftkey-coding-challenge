# Shiftkey Coding Challenge

## Introduction

This repository contains prototype framework that demonstrates usage of [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) along with layered data-driven design and modular feature-driven structure, empowered by Combine and SwiftUI native extensions to Apple Core Foundation.

## Motivation

The project utilizes solution to recruitment task from Shiftkey as a setup example for combining programming principles emerging from open source Swift community.

## Requirements

To build and run the project you need iOS SDK 14.3 or newer installed on your machine.

## Architecture

I have introduced custom layout for unidirectional data flow here. Each entity passes three phases from its source to the final destination.

At the beginning, raw data from web service is transformed to networking model in system space. The system space layer reflects untoched response from the backend.

At the middle, effective core model is reshaped according to the mobile domain that rules application space. The application space layer reflects unprecedented inset to the midend.

At the end, view item is completed and ready to present in user space. The user space layer reflects unrendered input demanded by the frontend.

### For further investigation:
- Domain Specific Language descriptor transcribing OpenAPI manifest to dev readable networking client
- Code generator for Raw Data model with endpoints
- Modular design following hierarchy of state reducers
- Command driven routable entry points triggering effects in reactors
- Generic stores for Load and Feed eventual contexts of receiving items
- Error pipelines
