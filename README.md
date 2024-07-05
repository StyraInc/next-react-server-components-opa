# Next.js App Router + React Server Components

## Introduction

This is a demo app of the Hacker News website clone, which shows Next.js App Router with support for [React Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components) **combined with server-side OPA evaluation** via [@styra/opa](https://www.npmjs.com/package/@styra/opa).

### Running Locally

First start OPA with the included policies:

```sh
opa run -ldebug -w -s policies
```

When using [Enterprise OPA](https://docs.styra.com/enterprise-opa), the `@styra/opa` SDK as used here will benefit from its [Batch API](https://docs.styra.com/enterprise-opa/reference/api-reference/batch-api).

Then spin up the Next.js dev setup:

1. `pnpm install`
2. `pnpm dev`

Go to `localhost:3000`.

Click on any story's comments. You'll find them all abbreviated to <= 100 characters.
This happend on the server: it used @styra/opa to process the comments before returning them to the client.

### Deploy

You can quickly deploy the demo to Vercel by clicking this link:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/templates/next.js/react-server-components)

## License

This demo is MIT licensed.
