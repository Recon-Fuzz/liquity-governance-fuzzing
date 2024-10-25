# Liquity Governance Fuzzing

A Recon template to write and test Initiatives to be added to Liquity's governance

This template can also be used for ongoing monitoring, helping Governance flag malicious or incorrectly written initiatives

Giving more information to voters

## Developing

To write your `Initiative` just edit `src/Initiative.sol`

To test it run `Medusa` and `Foundry`

To test it after deployment, run `Echidna` in fork Mode

## Testing

Local Testing

### Run Foundry Tests

```
forge test
```

### Run Medusa Invariant Tests

```
medusa fuzz
```

### Run Echidna Invariant Tests

```
echidna . --contract CryticTester --config echidna.yaml
```

### ADVANCED: Run Echidna Fork Invariant Tests

TODO: Prob missing smth about the RPC

```
echidna . --contract ForkTester --config echidna.yaml
```


## Setup

To write your `Initiative` just edit `src/Initiative.sol`

To test it run `Medusa` and `Foundry`

To test it after deployment, run `Echidna` in fork Mode

## Using Recon Pro

## Governance Fuzzing and Ongoing Monitorign


## Implemented Tests

Testing is unable to magically determine if an initiative is safe or unsafe

We can only verify certain properties

Setup:
- Governance and Bold are correctly set to the intended values

Specifically, we verify that:
- ACCESS CONTROL - Each initiative hook will revert when called by any address that is not the governance
- CALLBACK LOGIC - Each initiative hook will not revert when called

## Recommendations

We recommend running this against each deployed initiative

Recon will set this up as a demo and is open to maintaining the code and offering live alerts to the Liquity Governance Ecosystem

## Help

Read more about our work and DM us on Twitter or Discord

https://getrecon.xyz/
