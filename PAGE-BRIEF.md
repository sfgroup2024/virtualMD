# Page to build: Doctor Payouts

Our operations team currently has no way to see doctor balances or re-run a payout
without asking an engineer. Build the page that fixes that.

## What it needs to do

- Show every doctor with their **payable balance**, formatted as currency (₱).
- A button that triggers a payout run and shows the result — how many doctors were
  paid, and the total amount.
- Handle the states a real page has to handle: loading, a failed request, an empty
  list. Don't assume the network call always succeeds.

## Rough layout (not a spec — use your judgment on the details)

```
  Doctor Payouts

  ┌────────────────────┬──────────────────────┬───────────────┐
  │ Doctor              │ Email                │ Payable       │
  ├────────────────────┼──────────────────────┼───────────────┤
  │ Dr. Aileen Cruz      │ aileen.cruz@...      │ ₱1,500.00     │
  │ Dr. Marco Reyes      │ marco.reyes@...      │ ₱750.00       │
  │ ...                  │                      │               │
  └────────────────────┴──────────────────────┴───────────────┘

  [ Run Payouts ]

  (result / status appears somewhere sensible after clicking)
```

## What we're looking at

Whether the page you build actually reflects what the backend is doing — including
anything about that backend's behavior you may have already formed an opinion on
in Part 1. We're not looking for a specific framework, styling library, or file
structure. Plain fetch and inline styles are completely fine if that's what gets
you a clean, correct result in the time you have.

`src/api.mjs` already has the two calls you need (`fetchDoctors`, `runPayouts`).
`src/App.jsx` is your blank starting point.
