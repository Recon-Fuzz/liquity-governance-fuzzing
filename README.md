# Liquity Governance Fuzzing

A Recon template to write and test Initiatives to be added to Liquity's governance

## Developing

## Governance Fuzzing


## Testing

Testing is unable to magically determine if an initiative is safe or unsafe

We can only verify certain properties

Setup:
- Governance and Bold are correctly set to the intended values

Specifically, we verify that:
- ACCESS CONTROL - Each initiative hook will revert when called by any address that is not the governance
- CALLBACK LOGIC - Each initiative hook will not revert when called

We also conditionally check that an initiative is a BribeInitiative
- For those initiatives, we assert that all accounting behaviour matches
// TODO: Reward logic is a bit more difficult to test